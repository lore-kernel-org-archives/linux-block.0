Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B91A8408
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664426; cv=none; b=qjfQ3OoSFvr5hw6v2Av9Q3TXKm0TdWF+7SzPXsC0puCcSw8W7qFsvvg6JqQ8WfZwYUWKu1FBqyHz1g6bQBz6k1+0FumHUQdho+wdaQEaC4CmWDCODkEuO1iLhnvCdy1/ihpwTPcnzTaLXaHoa5nhXHBWqz/C2+l7Zrh9WSJIk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664426; c=relaxed/simple;
	bh=FWKEcRh71BAg0M2WtgM0lmWRruTWaXBmuyXlhb/Yq0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Epl1/w6gk3ebZTFvRvI75fKDLXfUdJhrPr3YtP7cZgM4E8wEwoGdkm6GGkyrnN9J8UVQGvulqXKw8NLZ539Amr4nnHHoxbCXSEKwZYo/PMdc++bBCWSwhNrs/YiOSkRTGEeh92ykvD8LVGg8Hme6qmVcxN2L9MRfm/HlSO4KQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=g6XdWemd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="g6XdWemd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso2027856a91.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 12:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1737664424; x=1738269224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWKEcRh71BAg0M2WtgM0lmWRruTWaXBmuyXlhb/Yq0c=;
        b=g6XdWemdVVhvmB2oj3+cg+GEe68ypf3bwGAEc7ZQuDstOJvQjlKcJ6Wn/WNXWYlsfl
         4inTcnxezrk/2GvCL6ApCtIyWYHYIzpJ7Ghdp9qjpsRCr0RS9XFzqrU6vwpA5wKd6PcI
         eWiCsZRIMeHky4/kXAMP/bwx3jJTmgCRZo0WCEegnxaoS+YE1zYNIRBDj3sFX5FMjIef
         I3BdepdaeVCjG7pcC4jBZ66sjkr6IfiTWxAe/bCqStmBMY5X3SwCpMSfcNntCCWW3xow
         +wpd7EYd7/jyZgmKeJtB2Qgk/Spo1zMuENjIALIEmDcTi4bhjeuQ9uqiDlECIFtd6fCt
         Nv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737664424; x=1738269224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWKEcRh71BAg0M2WtgM0lmWRruTWaXBmuyXlhb/Yq0c=;
        b=n5iDtfC+LDu5DgIZx50eaGLd+LAamWGuIEl6jCeYJm4ZRddcKMwUnICDAjQlFdFHJH
         /NlJef0Kq0ogoC/bNXzhme78PAu2tchRJfbIYBTrxFYjhDXwHX+V0RSyo1x9RbS+XFPM
         2vSuaY454dpSSaQEObx97V5f5rJTOrb/E1RWL1hOL/X3y24nnOkrutxk3fpU3OYsSPTe
         7eS6qGtMzoZu3ThaO8JsNRJOgHKjf+1lsKQ6DPgFSBsYiZ/wdSnSrkAlQs29ZtdoSRit
         q4MvbdJX+7j+9pYEathYMiyeS5XlEIyMvYKlrdLjfSwLRgQnz96khCCdm6Uw9ovqqTQu
         WZAA==
X-Forwarded-Encrypted: i=1; AJvYcCXEJaFNBUMqHN+zw39tq4TH4ntk2S3JobBJ3y0njV374GZdkcLlmWDkxyYQ9reWxkCXYYmqsUEpFeTixg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGLCfBtgVuHk+gy7NOsXFPg7Ulvsw+ot3gj06NXKEE5pXq+Fz
	8BJDpCVk3gOjK3ukzypUckTd0ZYfXyUw9anwk0xMNBzJh5NlxPIw0rHAThFpo4Q=
X-Gm-Gg: ASbGncvr8PL+6PjJ7+s1CMjGFDY/XW8tPDASB0fPn9rmLwlr2n+t8uG2KdpR96bjBx7
	FmaxMiwkZxztiPhX7DzH3Iatr0/L6KVeG39SexgBBvJkEhyj3NNgTPM9dqg6+bQO5Ep6xONVWqp
	XJ1e8LKtgIy3IgPzhKAEN/Vbxw3Xamvxq4kSGGmwQVn3XPM0/16TIzWNZEJi6oagiyqvnZ7ppHM
	WqYIKjgo0u4Ne5Ox6YYsJ035B64Sfsf4teSslQ3TnS7YftIuc84XDxnvaiBVYfJWctgqcxIRt+a
	NQjho6dTVaeM+W4uIKI=
X-Google-Smtp-Source: AGHT+IHruNaV/fe3ZJuXQt7dVzgbe6RJhqsGmZcMMO0ypaCWrIi0BmI2NW+jNcrCG6nHd+Ztk82R7A==
X-Received: by 2002:a17:90a:c2c5:b0:2ee:8008:b583 with SMTP id 98e67ed59e1d1-2f782c9c88fmr43158452a91.16.1737664424284;
        Thu, 23 Jan 2025 12:33:44 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:3505:6c:7825:7b9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa56fbbsm143335a91.16.2025.01.23.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:33:43 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	javier.gonz@samsung.com,
	Slava.Dubeyko@ibm.com,
	gfarnum@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [LSF/MM/BPF TOPIC] Generalized data temperature estimation framework
Date: Thu, 23 Jan 2025 12:33:19 -0800
Message-ID: <20250123203319.11420-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I would like to discuss a generalized data "temperature"
estimation framework.

[PROBLEM DECLARATION]
Efficient data placement policy is a Holy Grail for data
storage and file system engineers. Achieving this goal is
equally important and really hard. Multiple data storage
and file system technologies have been invented to manage
the data placement policy (for example, COW, ZNS, FDP, etc).
But these technologies still require the hints related to
nature of data from application side.

[DATA "TEMPERATURE" CONCEPT]
One of the widely used and intuitively clear idea of data
nature definition is data "temperature" (cold, warm,
hot data). However, data "temperature" is as intuitively
sound as illusive definition of data nature. Generally
speaking, thermodynamics defines temperature as a way
to estimate the average kinetic energy of vibrating
atoms in a substance. But we cannot see a direct analogy
between data "temperature" and temperature in physics
because data is not something that has kinetic energy.

[WHAT IS GENERALIZED DATA "TEMPERATURE" ESTIMATION]
We usually imply that if some data is updated more
frequently, then such data is more hot than other one.
But, it is possible to see several problems here:
(1) How can we estimate the data "hotness" in
quantitative way? (2) We can state that data is "hot"
after some number of updates. It means that this
definition implies state of the data in the past.
Will this data continue to be "hot" in the future?
Generally speaking, the crucial problem is how to define
the data nature or data "temperature" in the future.
Because, this knowledge is the fundamental basis for
elaboration an efficient data placement policy.
Generalized data "temperature" estimation framework
suggests the way to define a future state of the data
and the basis for quantitative measurement of data
"temperature".

[ARCHITECTURE OF FRAMEWORK]
Usually, file system has a page cache for every inode. And
initially memory pages become dirty in page cache. Finally,
dirty pages will be sent to storage device. Technically
speaking, the number of dirty pages in a particular page
cache is the quantitative measurement of current "hotness"
of a file. But number of dirty pages is still not stable
basis for quantitative measurement of data "temperature".
It is possible to suggest of using the total number of
logical blocks in a file as a unit of one degree of data
"temperature". As a result, if the whole file was updated
several times, then "temperature" of the file has been
increased for several degrees. And if the file is under
continous updates, then the file "temperature" is growing.

We need to keep not only current number of dirty pages,
but also the number of updated pages in the near past
for accumulating the total "temperature" of a file.
Generally speaking, total number of updated pages in the
nearest past defines the aggregated "temperature" of file.
And number of dirty pages defines the delta of
"temperature" growth for current update operation.
This approach defines the mechanism of "temperature" growth.

But if we have no more updates for the file, then
"temperature" needs to decrease. Starting and ending
timestamps of update operation can work as a basis for
decreasing "temperature" of a file. If we know the number
of updated logical blocks of the file, then we can divide
the duration of update operation on number of updated
logical blocks. As a result, this is the way to define
a time duration per one logical block. By means of
multiplying this value (time duration per one logical
block) on total number of logical blocks in file, we
can calculate the time duration of "temperature"
decreasing for one degree. Finally, the operation of
division the time range (between end of last update
operation and begin of new update operation) on
the time duration of "temperature" decreasing for
one degree provides the way to define how many
degrees should be subtracted from current "temperature"
of the file.

[HOW TO USE THE APPROACH]
The lifetime of data "temperature" value for a file
can be explained by steps: (1) iget() method sets
the data "temperature" object; (2) folio_account_dirtied()
method accounts the number of dirty memory pages and
tries to estimate the current temperature of the file;
(3) folio_clear_dirty_for_io() decrease number of dirty
memory pages and increases number of updated pages;
(4) folio_account_dirtied() also decreases file's
"temperature" if updates hasn't happened some time;
(5) file system can get file's temperature and
to share the hint with block layer; (6) inode
eviction method removes and free the data "temperature"
object.

Thanks,
Slava.
