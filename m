Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E0823A8
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703899; cv=none; b=CtRRgZOQFxGffAqWhwaI6yf1NO3aKphw4zLVUrGWPwBIKQsMtN7Nac/x3MUKIM6v8wFmm66eLn4gA15TQn1AV+Fm2nsmV39Z8C71PN71n2kJ6Mp7MbNgos7tQe92oW5yajdK3g0IIwY25LhpTytHvveZBufeKXBcYTs+opCqQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703899; c=relaxed/simple;
	bh=ZH381XWq1zBTkACBF2//KeafUWHfw67mulBGzDmiY08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a3Q3fXTwidEzNJArofu0N5RSzFwfsvSVdYgrgtvFdY9oUxc3jGbS4+riX+AQeBtMzNr2vCnX/BD1uKHoZXLLEAdBDnIS4+KlYtQOvWq2jPt8jHW0g9kN94OUVJbX/7uSyo1M5sPlQrdv9zjGJwbnwFshWov9YK+s8n1agHYQYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KFKNFmPH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KFKNFmPH"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so83094966b.0
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708703895; x=1709308695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6OU9fCSyWEEzN1u8BEFct7dyiCVhZczrHs1XtVuYnk=;
        b=KFKNFmPHFQvnDtcs/LTdD3HuBYePSJheE7tvw/U+T3yLpjCPJNM1YC7hGoaOnohm/3
         jVe/bz5W3TJj/JlbiKG3vuIVXEkzxilb8KUVOpSUfWlGYNlJZepoI8CIBRgA9K0wGqio
         v0NznsX88neTPiQms+BZKv0WeISNc4E3xrl/UUWTRUbzp1UWAzwC+pKRljfgTJAXz7Se
         jQQ5gVRZlwJgGLGDl+riICyZT9kZIu23m8ikbY8c/i3rAm/+MU0pKGbtbG8pWkGhhCQm
         J34aQYBkGW5NUrPmM1XLf8OQTs3o3w11yFl46Z9sDjJQcpsxWzpWwk6VJbIEBR499BFG
         pjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703895; x=1709308695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6OU9fCSyWEEzN1u8BEFct7dyiCVhZczrHs1XtVuYnk=;
        b=cuSMUQUYvHdVwPIWVTYkgpZqXI4HJTfcK2f7GcXcLVnyEfLQII/HGcVcFUMdb/OLqO
         jUT0xyjWfzCpU8e7bGaj4hccr2V9RKxNO6Kzz2q8R9aUr49Xwk3b5hY4vXlGmrRyqGqm
         OkAQkpVpZ7E/7WZFdpeMd7PiNc66doq1gurDss4JAOkJt7kpFdIO3l6S3lrsGz6onKx+
         YaJ9xmdM/pA28d71PX630H1NSCwjLdzHuCBjxuzF6Xa9Ji72WXqdksZe+4RsDY7disII
         ZaEfIYOriUswfT5+27wj9EUxOSMsuEadJ/IbyBid9V33eY/cOotzn/dfF2VE73npm+87
         IpUg==
X-Forwarded-Encrypted: i=1; AJvYcCXoIk5E1zVc9PRADDC74IvFDsD+gyljiEgA7FfDrFAVNfQ8N1g0OwCtDCw6lvawxJ1kEBISPqiSFJ3jNgw0iRzyBTbU5mtUwKWRKUY=
X-Gm-Message-State: AOJu0YyByUUxNZPA9hiPyUMvgrKwb8lYpehGF/VEEWWcbWFfZAZGh+zn
	FyrsKPG0aNGNHgNFmBB/2u0ACAwriwc7UOlHoy9enOsDgjr0SA3hHK7eEMeUzgI=
X-Google-Smtp-Source: AGHT+IFOrob8ed9f5/s0soRamhpTRgugIXA1/sDn/fhSiVJwNaqHd65cLwVQZcDbvzNuhb8zX2rujA==
X-Received: by 2002:a17:906:ae54:b0:a3e:f7c1:5f21 with SMTP id lf20-20020a170906ae5400b00a3ef7c15f21mr147674ejb.52.1708703895503;
        Fri, 23 Feb 2024 07:58:15 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a3e28471fa4sm6461293ejc.59.2024.02.23.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:58:14 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 0/2] sched: blk: Handle HMP systems when completing IO
Date: Fri, 23 Feb 2024 15:57:47 +0000
Message-Id: <20240223155749.2958009-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to recent changes in how topology is represented on asymmetric multi
processing systems like big.LITTLE where all cpus share the last LLC, there is
a performance regression as cpus with different compute capacities appear under
the same LLC and we no longer send an IPI when the requester is running on
a different cluster with different compute capacity.

Restore the old behavior by adding a new cpus_equal_capacity() function to help
check for the new condition for these systems.

Changes since v1:

	* Split the patch per subsystem.
	* Convert cpus_gte_capacity() to cpus_equal_capacity()
	* Make cpus_equal_capacity() return immediately for SMP systems.

Qais Yousef (2):
  sched: Add a new function to compare if two cpus have the same
    capacity
  block/blk-mq: Don't complete locally if capacities are different

 block/blk-mq.c                 |  5 +++--
 include/linux/sched/topology.h |  6 ++++++
 kernel/sched/core.c            | 11 +++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.34.1

