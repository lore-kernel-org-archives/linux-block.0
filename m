Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DE2CA9;
	Sun, 18 May 2025 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747537062; cv=none; b=XdQeVALD9nMlpJrvrWIa9c9mm1WQ51YbZiApDcumQ+cJziT5KvTdR5eUo4FdKv4QYLPMStU/FxGcXP+gyhdvRGmeFyfzyTQFRuvimksBzFMY2bqX1Ymy41iqrMa3LzmLzd0Tqr7xH9TqcztI6T98gAQPZGC7OBVtcP2PPGu6QLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747537062; c=relaxed/simple;
	bh=tCcWdKyz2amA6KBdrze8Ih6BN32dNcib5cgyLnGjycE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0c7w5/nNMP+3nd+al5bBKJXbQjSd7aowVDraiDnb9D0ZIH13UwW/KSLr70esK4PqHBuJJ8fQnFyR6x7fwwlUE2mOIjjrBkzO8DJBD8FYnyJqKY06oMrhRT6MqdULotzmJF31FYMpSB9fSXVkTzyXIOZoq1VqcfNuTzfehOtunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1/PWajJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1/PWajJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c277331eso3918978b3a.1;
        Sat, 17 May 2025 19:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747537060; x=1748141860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl8n3bRfS57HIJIAg1FzvptonBgJ4tvPHNOJ1GvJKus=;
        b=b1/PWajJneey1h6GSdLpIFIVkwnFlpZiUfjQ8XEl/22iV+XaGvHzSpYWoIGikwrJiD
         bVuYqHqZWjGDvQ8xj8FPv9UurUUbvF4lT9X5pxnHiLbicoRr9xdB9TSloJKMHKsmh4Lm
         Hme1zvs3B43QiUXEbdAbjdo5iWQCedcZjL2nCLwsdxnzz6lhgwof/KNRohyYc0SnjGK/
         /G87BdXgSwYx+pxUBt9yjYw7Z/0ddoEE8swxX4XXvHx8AfpZeiPt0xtUB+hyQ4CQCH8w
         MMEOyfZPtDLq6hQ0ucnqMc9/aWuYX29oWujbEFfehpZgLcVu6C1J+KcidsPWVrPCztkW
         M0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747537060; x=1748141860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kl8n3bRfS57HIJIAg1FzvptonBgJ4tvPHNOJ1GvJKus=;
        b=NfRAhy1BEKiazWCwaSZDKXI+kAMs9oGwJiMyuyZWYRtXXd0e+QjoGr6n2vLJDN0aos
         iGcFcZTBrFvsP8SOd0dvmvU8x9NwAdAjintL6Q5Zymda0+vh6ZpHXdVwD5knHg+w3ckH
         fpP8BpS7IpkBFuc6Yp0cRArjxpIoVYfOwcLS3/CMjWImX+rftsSkdFWCpseUIs/on/v9
         /xVVkT2kMd4Ge+j9xuM8iEahUbRVhOHMEdA2Yz/GNFnIYuVEPJ/Aglv5xj5agMp8fIAA
         j8lgM8HmWwV+lyNv464mAWtFiTPyrhxx4lpWltbTns0fbs+kn8hNp07eAoC9VT0nkVMb
         ukLw==
X-Forwarded-Encrypted: i=1; AJvYcCWacdc0zqh9tBQrud+p2oLZf0zGtpyQAUb+fhvJdNJ7iecn9WIKOc7M2xlBq9Dh+pKMRrB+IMHDFtjl+Q==@vger.kernel.org, AJvYcCXT7wGSBRejDW3pY8RKGfR9Lrpe3rp0/PcvcdgKs7voMMIZdrORVj4MfzOiag3A4jOVO8bATx71qPUiGCEajmNbrTz4@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPxHXC+M17R7JEA9hX9zkKD9Ri8+9BE/fN8usJyaIUonxeHkf
	pKxwMrrZ5zxhw5xfZCDk0xVsFD/lxtE0F5BYqN9H9u6nPhtebjZ27XX5kjcJnvb8BB8=
X-Gm-Gg: ASbGnctME2DGitdBaZ+/sKKvY2NfASwbzRsYzJXWhAJ86KJLMZjM+m7QDwm3fqy8NtF
	L00iCcA6TsoxtH6WvQxR9oyVJmONaQyGy751beIrd6poYt3UdLYaDANy/dVrFira6Ga/Ml0q/b6
	Vc/gr3YoWdd9aTgULBE/ldRagvtDvb7WB4rf26QpikCImqZ3T0meY4mK79/ee492tyFfaM0p31h
	hyLDTrjA0N465sbPFqg8PL6osB7CMKrtP6UrmZsy7vi88xBTJzt15MXuwkPaKd9Q+qP2o2xaPDL
	Qqq57grPiuBw7eVjDjixH/7ZKLpgAahbi8pMX3pwipA3DmUYDxVREuXAn9BW655qgmBR2VPvw/A
	E1AGE2at9JixaUNdPdr1DesuX
X-Google-Smtp-Source: AGHT+IE958td6S/yEXXHa30zVQNxcehcD9tKByd0MP4rVfbUDmQc90fWxqI5nArtr2ftfJFjXnnY7g==
X-Received: by 2002:a05:6a21:170f:b0:1fd:f4df:ab67 with SMTP id adf61e73a8af0-2165f8ada70mr11670950637.21.1747537060126;
        Sat, 17 May 2025 19:57:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739a12sm3839125b3a.77.2025.05.17.19.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 19:57:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v3 0/4] relayfs: misc changes
Date: Sun, 18 May 2025 10:57:30 +0800
Message-Id: <20250518025734.61479-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series mostly focuses on the error counters which helps every user
debug their own kernel module.

---
Note: this series is made on top of this cleanup[1] and unmerged commit[2]
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable
[2]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/

Jason Xing (4):
  relayfs: support a counter tracking if per-cpu buffers is full
  relayfs: introduce getting relayfs statistics function
  blktrace: use rbuf->stats.full as a drop indicator in relayfs
  relayfs: support a counter tracking if data is too big to write

 include/linux/relay.h   | 19 ++++++++++++++-
 kernel/relay.c          | 52 +++++++++++++++++++++++++++++++++++------
 kernel/trace/blktrace.c | 22 ++---------------
 3 files changed, 65 insertions(+), 28 deletions(-)

-- 
2.43.5

