Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143373;
	b=yI4vwMtVpHgHXNL6VL7mfGnVhjbfvfij10OPdMdRYLmfpDDEda7QyUgHTseNTLfsZZo3
	 DkYbyR41bY2PuXZkFeO3t0VD3sNiRM1OJXMlAMyfoKHEyfoShpwA12GCPfgMMyKaPuZ/W
	 VATXtq0LifcDQyNdUZwej0uKFf0Zzauc7HNKZzb+E78HuuE2F9s2rbLSd06OdoL5/23lv
	 mFyWjIJKRseGRx+aFh2l+jzS4yVjGtnyWX6KVilmVVsslM82f5l9NFx7GUfeSWHj2kWMf
	 MSsPOhDy0B/vOnLkcXFMXaIysV8VqXutUUePCayHJYv+Tq1cbRAFhWDcEf5DV4HqDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2UPt9p34nIxWIkNf9Ri70NscQqBECXpPB2+yVfs1gWE=;
	b=WXzzetWCy4L5vc6+Y7arurluRUsOefGG/jCepmTL6XZbBZo5o7gd6wa2sC7oT/nb6abU
	 o1dc2rh22ECbWKiVaHzDVMwec83bSrOyDz4lwd7IgUokwSDVsnG2SYceDQZh7TyDps5oM
	 vw0lq3BkC+W6FWhsudkvKA9nDDKpKLZG4fowaKom9LG4It5bMwhGmOVoUW9zoB2Bwhe6K
	 T6Oux5P+bIbcElOjsEoLqCWn4//ptLMwdZwsRxfYljUuZp8567XCzbwMTmEEbYHdYt/Sq
	 AjoIf0Db65egsWjkVMu03lET0v6/aljGpT2VjfZUousMVlwMgKwQyqqJcAeRl6novLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QJCXi2S8;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96916606A326
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96916606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QJCXi2S8
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b41e627cadso226400a91.1
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143371; x=1795748171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UPt9p34nIxWIkNf9Ri70NscQqBECXpPB2+yVfs1gWE=;
        b=QJCXi2S8pIOkLuyWzYBnJy3xA9Dbsn/ZiL1TRrB1V2x24lfN8a6gQZmfx82Vg4m4dz
         lfmlFnQomOFd0u/partG6wzlMwF5hKQEtYupveIOAF343i2WDqG+SYQEREGeVw3GeBJq
         0UZJslLBjJNCWEbHUiFrWI+Z7NnaKKJ8/XpSxuO/WS7gUisuB6f1o4zfFLy/33Wm1nyS
         i49PX0BL+n4sEOQucjgyTXUmIx2254ST23gBCgBo4LjyWnfLqgk4TbkraNa3aqCoXmy4
         FbtMZPy3yBJO7gaV9ds4N2z9chNn9F/cdh3VI89toDN06Ng+5nJIkiLkXC7gW241Lkbg
         1F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143371; x=1795748171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UPt9p34nIxWIkNf9Ri70NscQqBECXpPB2+yVfs1gWE=;
        b=ZlTv54p53JRjcc5AG4l5FBsk1fOCWgC6tZb1wAEVLZ6A13rglRV8FJSJ4kexYcETx7
         HnqqN5nIUi/Z6tdHN4nmQT9JuWVEirH3mqkenM6Y6QxIsnWaLiUVbP/vy85iisUhDfVG
         QaIPnd03AeADYhVRL4tw3G5gKM3rYgAdpz77g8kERMKZzeN9bCXaHqppmacfENxCUsQ7
         fl3uL98GF4IkDRfWv6n9OvWm7L5Xy2pSorZAiYTe65p014fdQdrVXoI1fHV6BfBOnVne
         g06qel9d+t8q7DuBZT6mZIGC23PIHyRiKfeQ8rVVT3S2EEikHfjUn8sg1+USqVmDR6z8
         mwEw==
X-Gm-Message-State: APuU4Z8wl2Q2zZrfodFavuX/wkPpruWs97D1EArYXj1U5UOQ+i3A4C3p
	gi6r7Vnnnx0xCwzXuEDHWIG73MZ/B46rn0oHyTLKAIe9CsjjFPIHOfzFMWmNppx/fOV0wRyIJLJ
	WWMWqP4i5Vf47XA4mN2a4V+5pINBTLjKyykQVzBgrazDH5NSXcDP1BRu85QRKQlaD8/yE9BY=
X-Gm-Gg: AZFdTZeu1n8w/iGGv8h963U5eJt07AIhYdWPuIpj8P981sOko6f+K+YR7b2n/xuVUSR
	pX4lTYLkuslwGXz/IXAqdvNEv2/cNEJAC0Z7Kd810LiL2hpBpXCUBrv+ZWj5my2Qv8ji2nySwVJ
	KqeOGWQfq5TStI/P4XxVj4SivkZWEo/8weI3qRX4qYUzz2B4SVA/gppl5H0MfqdcOCh7W3TTuRZ
	RpJArn+JsXEltRYUrlSCp0PVeqxbtBAcC33dFQ47dIs5kR1IWsDsCySjXLusE1vf03A+jkQ/ycq
	qJ9xw/9n0GRjEXgWGQBgTksvzDGsnbcKCY3FWfVU0YGFtYnZ3wRh+c4/kzqSObdgqvpsRetjJdD
	x4qYkmNPPnP4Ux/luB6jBkPckwjMyaMj5gKahaaWOHJ2bcT0VoqpWL+r+hgtN2RhuZIw5rP9amf
	w02DI5Z6Ec4a/kNgQAvF2nRcbupz94tR4mI2TgND1jpSq5RYSQjwsr/cB8bL05Sha/UP46aTX9d
	QByLv+sSdWjrPyrh5J9LqFz42KzOCEdD1I5g8w360XRiQiiEa1lhaw6AL3nescgh+UMrFA4yTFM
	p/s8wTPVMiCi/+g/yHkSvJzMPMMd7BvytUzC+qZTWudBN+V4sqZ5ybpi/xk=
X-Received: by 2002:a17:90b:2688:b0:3b3:cde6:d8c8 with SMTP id 98e67ed59e1d1-3b41c955b9dmr1262506a91.46.1795143370698;
        Thu, 19 Nov 2026 18:56:10 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm5546461a91.8.2026.11.19.18.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:56:10 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v2 0/5] Expose blk-mq tag sets through debugfs
Date: Fri, 20 Nov 2026 10:55:59 +0800
Message-ID: <cover.1795143228.git.lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009030111.57784-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block debugfs hierarchy currently exposes request queues and hardware
contexts, but not the tag sets they share. This series adds a tag-set view
for configuration, CPU mappings and driver tags, links request queues to
their tag set, and links SCSI tag sets to their controller debugfs data.

Compared with v1:
  - Reworked tag allocation and reclamation so the debugfs objects have a
    safe lifetime across queue initialization and hardware queue updates.
  - Added controller links for megaraid_sas and mpt3sas, including helpers
    that build relative debugfs targets and serialize link updates.
  - Folded the stale CPU mapping comment cleanup into the tag-set changes.

The series is based on Linux v7.3-rc2. The tag-set debugfs implementation
was exercised with concurrent queue resizing, shared tag sets, device
teardown and old file descriptors, allocation fault injection, and KASAN
and lockdep enabled. No KASAN or lockdep reports were observed.

Lei Chen (5):
  block: expose blk-mq tag sets through debugfs
  block: link request queue debugfs directories to tag sets
  block: add helpers to link tag set debugfs to controllers
  scsi: megaraid_sas: Link tag set debugfs to the controller
  scsi: mpt3sas: Link tag set debugfs to the controller

 block/blk-mq-debugfs.c                       | 378 +++++++++++++++++++
 block/blk-mq-debugfs.h                       |  22 ++
 block/blk-mq.c                               |   8 +
 drivers/scsi/megaraid/megaraid_sas_debugfs.c |   3 +
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c       |   4 +-
 include/linux/blk-mq.h                       |  24 ++
 6 files changed, 438 insertions(+), 1 deletion(-)

-- 
2.43.0

