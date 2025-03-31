use sqlx::types::chrono::{DateTime, Utc};
use thiserror::Error;
/// The priority of each entry
pub enum Priority {
    Low,
    Medium,
    High,
    Asap,
    Far,
}

#[derive(Error, Debug)]
pub enum PriorityConvertError {
    #[error("Failed to Parse Priority")]
    FailedToParse,
}

impl TryFrom<String> for Priority {
    type Error = PriorityConvertError;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        match value.as_str() {
            "Low" => Ok(Priority::Low),
            "low" => Ok(Priority::Low),
            "L" => Ok(Priority::Low),
            "l" => Ok(Priority::Low),

            "Medium" => Ok(Priority::Medium),
            "medium" => Ok(Priority::Medium),
            "M" => Ok(Priority::Medium),
            "m" => Ok(Priority::Medium),

            "High" => Ok(Priority::High),
            "high" => Ok(Priority::High),
            "H" => Ok(Priority::High),
            "h" => Ok(Priority::High),

            "Asap" => Ok(Priority::Asap),
            "asap" => Ok(Priority::Asap),
            "A" => Ok(Priority::Asap),
            "a" => Ok(Priority::Asap),
            "Far" => Ok(Priority::Far),
            "far" => Ok(Priority::Far),
            "F" => Ok(Priority::Far),
            "f" => Ok(Priority::Far),

            _ => Err(PriorityConvertError::FailedToParse),
        }
    }
}

pub struct Entry {
    group: String,
    priority: Priority,
    descripiton: String,
    due: DateTime<Utc>,
}
