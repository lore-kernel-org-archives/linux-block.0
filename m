Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F85288C96
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320004; cv=none; b=tW1lamkBPRW+74z4qs1IZg16+AOpvoV2Eeb/wLeNCZYMfnmws34jEpg82GYy9vLGwzU8LKMtckOkEfMQRbXvRBjar2/t/hKMc/aI49bGkPIEa6xRO+1Mt3l2lJ9h28o4ApnCTsIXFthlIsD+5dGaKv0b3aVCRKMx3YQ0Xaehjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320004; c=relaxed/simple;
	bh=mzAW38TuEcjt/saLnFTmbZY1YtbOK0h/MWaBnESZcQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pPoHy2IhL26yYP6AT7MKQ9YdxpzYJSuBEt5cNeAiOz3Zk4SFy9M8EH8Y7/KRsCEgCxEuGnoyCVwDlAaO9uwEUYCgdX6c1FdBLrLMIAo7C4oQoVWt8/vIblBd4Pw6sQ0kX9mIpAZzcj6N8XR130yePNXN1XIOmrikSmvGceesc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L35FkZeS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L35FkZeS"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1438337b3a.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764320002; x=1764924802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/HVrbBDCxQDG+yEvihnxixCZuGHu6XDCP5618aYnD8=;
        b=L35FkZeStvUotinQwfwYRE1j0yXAhLhsf74Ez6KxZIIbIWT3dW8XLT9ds7m5iiIchR
         XJtdsqk5gN+ng3KjxrIRvA3g8uhnHrusH3VmgRDZEyxoZZXOmrs6cYGlTFTTT1n38jNN
         TVt5bD4kGxHWxMG5nnoi/Mq3DtObE2A9ogc2xQw5nNHyMIcKRSxFMkZU/FKm7uaWSbWO
         AWqX2ptw8xfmTz+iX90ZcX3hNBfJwQv7c4WEnUM5Yif5/YoCTDoyCZt9ZCMcZdlmaFmH
         1GF1QsrwBA4m4MraMi+ozlJ9mZHDAdqxWB/0x+XIYOU3QkQ8f4Cjf4sAU13mkvcydHhg
         s21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320002; x=1764924802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/HVrbBDCxQDG+yEvihnxixCZuGHu6XDCP5618aYnD8=;
        b=vq4n1smx1K9mWsEFhm+g6jpb9jOISdRLPqOeayTuDkToCMu3ZtZ9tfH46FLa3ACNvh
         V0uOGdh2eAiVku3N6wNBjrNz8EDbzhgCUJ3UBVar3tl9+vRFbSzYAFrwwRK+GLNui9CZ
         ony3cbveLzdxKs5bw/tAlBGk1Bu1ynt++rRIhyWQawz7nZGjFAwIgkz+kPNeWrcPaAh1
         DuveO2Vqwf91ZQk+peuyvQiDHH+W0Yu1qA3xmTOEAnaAtIMeIZUb6m0g+yiFMVUxfD3U
         KAeESZqCwSaDlMBIB7E4xVdDo5tH9ZseTs7NijrrAhk4H67G5L9WqjjPaiqFkt0bruEt
         iOrw==
X-Forwarded-Encrypted: i=1; AJvYcCU0kEBSCa8u1lqcX2Kym+o7/tcWaekVnhEtYscaGlfUvZ5LHLmxZinU++5i9Mk+nsaq+SKQLsN9Ow4oPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKJbJ/tWG48nr4IEvBdJzt9YqnUM9o+bUHJalP6EaJY92URIh
	ilMUWWPYFUfVFqh6a2FJmD81g15rJzyqfeSqk8ZfoCFKBj4nvqL6fOGL7gIcqg==
X-Gm-Gg: ASbGnctSHeYxz1n4nhXhStv2+C3/+QClxEJh8hf7A3pfngHiP9kaRAHVCqkxdIOZ0Bp
	U1fYszd3/k+n/wdWjtYp0ERbAXl2UXPBgcvDXf3YueJhXLzmP5Hmq8y1HzAewpa5mjLiM6KR25k
	MSeAnAvL1/K8g60MVkuiIe1B7pg6AxuFodcOqaNSsNNBYp2CmCiygZDcWu6I7xkJi+hwCTlkH8N
	Iwa4Ps11qwXELNRiyYb/3pjhJvGM4OnF3lp4eSMpDSYHJ5G0zSHx0TaZo6jKKlznpGd8kns6Ooj
	jTX4J8rdFRtQsLlFHpj8j3sED0fxC4CNlElxuzKheG1WKUgW6B8NTz+zhOcZQCU7Yvx44IpHB1Z
	lSTu/Xm46BDG6HWDhIUWpmqUtzpKXYOI1T2Yx5QrPIjQgyiVpWrpabQ4OopTrp9NfmkE9RhXHiE
	9WIq8TP2Mwvm/h5dR76qnlCRkIAuk2VCH7fdQOL4b01P4=
X-Google-Smtp-Source: AGHT+IEWJGdXjB7Rz8U6SI6enX0sOUIzdkNjZICSsUR+oViL2pvdChAUYcoEvENaypGZahTG4Giw9A==
X-Received: by 2002:a05:6a20:9143:b0:35d:2984:e5f2 with SMTP id adf61e73a8af0-3637e0d536bmr16797763637.59.1764320002004;
        Fri, 28 Nov 2025 00:53:22 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-be5093b5b79sm3999943a12.25.2025.11.28.00.53.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Nov 2025 00:53:21 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
X-Google-Original-From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai@fnnas.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v3 0/2] blk-mq: use array manage hctx map instead of xarray
Date: Fri, 28 Nov 2025 16:53:12 +0800
Message-Id: <20251128085314.8991-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
an xarray instead of array to store hctx, but in poll mode, each time
in blk_mq_poll, we need use xa_load to find corresponding hctx, this
introduce some costs. In my test, xa_load may cost 3.8% cpu.

After revert previous change, eliminates the overhead of xa_load and can
result in a 3% performance improvement.

potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
avoid, same as Yu Kuai did in [1].

[1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

v3:
fix build error and part sparse warnings, not all sparse warnings, because
the queue is freezed in __blk_mq_update_nr_hw_queues, only need protect
'queue_hw_ctx' through rcu where it can be accessed without grabbing
'q_usage_counter'.

v2:
1. modify synchronize_rcu() to synchronize_rcu_expedited()
2. use rcu_dereference(q->queue_hw_ctx)[id] in queue_hctx to better read.

Fengnan Chang (2):
  blk-mq: use array manage hctx map instead of xarray
  blk-mq: fix potential uaf for 'queue_hw_ctx'

 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 63 ++++++++++++++++++++++++++++--------------
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h | 14 +++++++++-
 include/linux/blkdev.h |  2 +-
 5 files changed, 58 insertions(+), 25 deletions(-)


base-commit: 4941a17751c99e17422be743c02c923ad706f888
-- 
2.39.5 (Apple Git-154)

