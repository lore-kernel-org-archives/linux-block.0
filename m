Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE11A9F8D
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434565; cv=none; b=dpmMCiHtDEj7aBhVb9T3hWKudbEpetdKfnZbsQVFtCihgSmvF6h1xJKts4KWpWZrcRIVhtUddA1YtWXilXgq/yemVlzgOrvk9EnWV3r3WtbLr05gkUAojaSmcLBEmzsqybsGDDC5RMnVCNkBjzRRa/YbFgzDu6QLoa6qJ+LZ7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434565; c=relaxed/simple;
	bh=Sr3KKY5gdg4covXdAxmynr9WNo37NEEPQufX1R1+kpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTubwgJFzwzzVB4MLhijfAI+oGSzlOU9xL3IHt3bxLEI2W4x1ADXY9wb0C39trw8B0+trpvAGm3k7xXqZUDzHRULTlw9ShyRETGky8uUC311VKmki+Y5ae7a/ntqAX2xH+GhxinftY50u7vN2bcrd83iTPash9OQ+wp+sVzsiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYUnIsdq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYUnIsdq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso52363555ad.3
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766434564; x=1767039364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAVD7pQJt8pMzyS2qTPwLIicoj5lRR1SZQUgrj3JBGw=;
        b=UYUnIsdqca6W5EK9IRZsyTjinmGI7yU057N2001gmCM//pxLU1QXBPX9Lh5RhfsjWc
         50lw7c4po/zDsVfLhncxCuoRZpVcTDb02XzW/Zwba0uNay6CqSqB/CMqRQwdPW5GfRx7
         0V3UQ23zEGCGT0axOhNwxxM52lfQBDh05l1ODYYUv6K8xOTWh5sCKAe8bY9gwp2CVS4O
         nleSAyH1BZiP5FDX2qoE9XoVQ5w2noKlpytWodVaGLnZbKHC25gpU5vMgQ7xg+hxrMOZ
         dSAV63XxrUcqVgeazjoZ2rSt4PZ4gn47Ko0QrZQK4XEEunaRwqshf+rhRol6v4QHsYhd
         aYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766434564; x=1767039364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAVD7pQJt8pMzyS2qTPwLIicoj5lRR1SZQUgrj3JBGw=;
        b=HnbnfL0d+J1G0PB504v0QsCd3mGfy2pK8Ujkstr4YSyw31J+aYLjZQucNhmFiVu5RI
         waq8Z/KQRyvTWUoNayPTZ/SOH0ST5eCKlqhGEf5V4XGBl7jheNpeftcN7Veu/LVLhuAP
         INACrjxbWY/Ub5k0rfG0D5Z85xfE/+fov+8+GL8n6EdxVTgjuyFlg2OjsIvfkeAQsPOC
         4NkH3hyCWEuKa/rC5ldKtNNBKbnWbUc/QGb4DkkoMbZkFJC7WBZellLKCjjrxcOY3CHO
         jBeXXuSo+bjmNTpl0c4Pmn/aphy8o4nuhdLbb6lfVRZN07zqFCVnIZAoUG9jAiK6uPAS
         xoLg==
X-Forwarded-Encrypted: i=1; AJvYcCXRCjO7iMZDqxKg1PUiTfIE6naKqRm1O0ZgOFVYugzTUUpcFixgH51MbJBhcgt4i2Ct0zkGU300K6J8zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqy22ZFIkU+8tOiw8oi95QkzlWmxhtaQUbxtEaZGZ0REr9oBC4
	/UBTq9Lbz35k5GPtCKiaIYoZLaX+yjMAkMLwqd9l+LwtGpqF8L7/mfAY
X-Gm-Gg: AY/fxX4qZi6cMpleY16Q7GXlACgxw92amItL9KlbkP7+UWpDRVWSXndxuKnPaU8A9VL
	QF5jTftYDEO5+UPUibFSHvPPq3s4hTUDs2YK9TzUaW0IpDrJZZHpaPTPvdk+Hnhob7FdiuOew/U
	t0Bh6/lUrhp18KufOxk/aI+eHP/YRyGBHg8EEjtTVJr3lNgx8D2A3cKw2XE2hZB4o6ygEK80xmr
	Lb3LzXdnaIEqdTW6FeXPIpq07k/RboKsawz39P2ERFnlmfAHkO13Dam9XcXaxvOR/W8FOOXot8M
	9f2HcuHnhibSxurZ6wIdYib/f3+9+aMEi1kZCjHGpL4uYB8ko8awYnCaeuF0KgKG0pHqs5WswsW
	pISftyNk/ANHYtx5oi0WvVTX8Uo+mIH6SMgB1gJBGxZQ6X+E60JUNV9yjCu+gTP0duj2AmzpFL6
	gJf5t0Z1/JO48KWRbDD868IYINagIwa3IEJmeFf22+tqij
X-Google-Smtp-Source: AGHT+IGoKDbgLO06d1N/xUAWix3bqvDx5d2bd7CemzO0C9eAGrNH3gikQJk/ZoCDYWgpNXOngJAKkA==
X-Received: by 2002:a17:903:ac4:b0:298:2afa:796d with SMTP id d9443c01a7336-2a2f2a56707mr111799725ad.61.1766434563728;
        Mon, 22 Dec 2025 12:16:03 -0800 (PST)
Received: from ionutnechita-arz2022.local ([2a02:2f07:6016:fa00:48f6:1551:3b44:fd83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f330d25esm104358905ad.0.2025.12.22.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 12:16:03 -0800 (PST)
From: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
X-Google-Original-From: "Ionut Nechita (WindRiver)" <ionut.nechita@windriver.com>
To: ming.lei@redhat.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	ionut.nechita@windriver.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] block/blk-mq: fix RT kernel issues and interrupt context warnings
Date: Mon, 22 Dec 2025 22:15:39 +0200
Message-ID: <20251222201541.11961-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut.nechita@windriver.com>

This series addresses two critical issues in the block layer multiqueue
(blk-mq) subsystem when running on PREEMPT_RT kernels.

The first patch fixes a severe performance regression where queue_lock
contention in the I/O hot path causes IRQ threads to sleep on RT kernels.
Testing on MegaRAID 12GSAS controller showed a 76% performance drop
(640 MB/s -> 153 MB/s). The fix replaces spinlock with memory barriers
to maintain ordering without sleeping.

The second patch fixes a WARN_ON that triggers during SCSI device scanning
when blk_freeze_queue_start() calls blk_mq_run_hw_queues() synchronously
from interrupt context. The warning "WARN_ON_ONCE(!async && in_interrupt())"
is resolved by switching to asynchronous execution.

Changes in v2:
- Removed the blk_mq_cpuhp_lock patch (needs more investigation)
- Added fix for WARN_ON in interrupt context during queue freezing
- Updated commit messages for clarity

Ionut Nechita (2):
  block/blk-mq: fix RT kernel regression with queue_lock in hot path
  block: Fix WARN_ON in blk_mq_run_hw_queue when called from interrupt
    context

 block/blk-mq.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.52.0

