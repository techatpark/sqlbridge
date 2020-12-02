<#if table.tableType == 'TABLE' >
	public int delete(${getPrimaryKeysAsParameterString()}) throws SQLException  {
		final String query = """
                DELETE FROM ${table.tableName}
					WHERE
					<#assign index=0>
					<#list properties as property>
						<#if property.column.primaryKeyIndex != 0>
						<#if index == 0><#assign index=1><#else>,</#if>${property.column.columnName} = ?
						</#if>
					</#list>
                """;
        try (Connection connection = dataSource.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(query)) {
			${getPrimaryKeysAsPreparedStatements()}
            return preparedStatement.executeUpdate();
        }
	}<#assign a=addImportStatement("java.sql.PreparedStatement")>
</#if>