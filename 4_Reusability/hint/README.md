# 🤔 **Need Some Guidance?**

If you're getting stuck or feeling like you’re lost in the **Refactor Swamp**, here are some hints to help you:

- **Hint #1**: Use `ref()` instead of directly referencing tables like `<your_schema_name>.raw_citizens`. This ensures **correct execution order** and prevents any dependency issues.

- **Hint #2**: The **date logic** (like `TO_CHAR(TO_DATE(date_of_birth, 'DD/MM/YYYY'), 'YYYY-MM-DD')`) is used in multiple places. To **reduce repetition**, create a **macro** and call it wherever you need it.

- **Hint #3**: Add a **freshness test** to the sources section in the `schema.yml`. This ensures that the data is **up-to-date** and **reliable**. If it's not, you’ll be alerted! 📅

- **Hint #4**: Use the `warn_after` and `error_after` fields to set how **old** the data can be before triggering a **warning** or **error**. This helps you ensure the **timeliness** of the data.
