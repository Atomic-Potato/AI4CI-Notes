> [!info] Static Typing
> You can do static typing the same way you would in GDscript

---

# Libraries
```py
import sklearn
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# For getting data
from pathlib import Path
import tarfile
import urllib.request
```

# DataFrame
We store data from a CSV file in a `DataFrame` object:
```py
data:pd.DataFrame = pd.read_csv(Path("...."))
```

## Functions
- **`head()`:** Returns the first couple of records
- **`info()`:** Returns information about each column in the data set
- **`describe()` :** Returns the following fields
	- count, mean, min, max
	- std: Standard deviation; A **low** standard deviation means the data points tend to be very close to the mean (average), while a **high** standard deviation indicates the data points are spread out over a wider range.
	- 25%, 50%, 75%: The value x which y% of the data fall under
- **`frame['column_name'].value_counts():`** Returns the count of each value in the column

# pyplot
