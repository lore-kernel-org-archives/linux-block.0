Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF940A937;
	Thu, 16 Jul 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197221; cv=none; b=JfOH25+W27B5UfVQeew2mj827UCIJYhBWrWfNuTTTcN27IbZkycE8ELcwILmVhfxbJsFmV5MhyRlv88Xx+56COLqjg0+cYs9OeZ/sb/08R9Y4THSsD/LBeCpzbxyuD7uKjdjI9hZvSOpSZmx60wmO+FZYj1dqPuPXLG9vQ6zoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197221; c=relaxed/simple;
	bh=aRaYpVUmt76coUED7V2uJ8xLBN+/vDBKOQJ+VR2C8/0=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=J75jRkidhEYA8dYYcJNkooe/zg3Ylv2EAggi+0n8pkePsbZkuZ+T6g07o227mnE7FOfeBntgjBEfK7PRCPU1TnvsHKPZgTbjuuH5i5w51+9TjVCnC1Pkijv8hH9f2ZY4Vi3Z9O2WDRiLPAo0+HLCW6vMYwarLXn/9G2RrNBbYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VjMs+Xfg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VjMs+Xfg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A90941400111;
	Thu, 16 Jul 2026 06:20:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197219; x=
	1784283619; bh=RkBDpOT/b1Fpz0RDjfTSCn7zO86xaYAzh8lZx1UEbkc=; b=V
	jMs+XfgLQpAevZmhPuDiKDRRHuuBc3XDQm6TvQ31ikxpU3Zqr7k0CvHibrMAOCgW
	y2MZtpdB948ZR6dP5cjcgeSIi8OvTeEUvltdh3wpjvC9lYdVtNDxePc1MynsKy4e
	KvK76+A6IpDv0pBliuEPUBRUyNgOBbMOWrP4YlIrxGb0RHDweA+w0tpQ/Q7ecAme
	Os5nCjCCBtuw9JYBtv0mRKKZheIm/lJaweCOrDORGGApOZ4PsgOh1MCow8AOMVNW
	53EFUMmuNHyfjom4Z93LAeUHpRWAfv/9dS7JmrkBTAnnJvGnhcn3SAMY7O7kmaxx
	uuYQo0Jym2dtpGXX7EbNg==
X-ME-Sender: <xms:Y7BYasz5pUdLH_q1fNHH1zXdvCjeDRBTAeIyRa-SK3Ec14Pigj0Khg>
    <xme:Y7BYaqUDdiLa4oM5YBqrT3MkmQs_Cng3P9xoXrWnT2XDz212OD13EVAcYh7agmrz7
    QhPxH1osiBv7dgTrwSRlYHbT7OXPFV8e6aPTywHb8AcH3Han2Mz3iU>
X-ME-Received: <xmr:Y7BYauMmfJlsGDjPwpA9lPhdXP3p5Cp7yYfFQ3b80dfqxtHI9fCNO91mtxeiaAKaChh8CqSAn0JeCCKLdh63ZkOZX5SRROHEFXM>
X-ME-Proxy-Cause: dmFkZTGGGewHkjpARU5mNGplDlBlY7p1odKmymFrbaV8Q3+bQsnQg5xAUvXrrFQLL3CMBN
    9OSeY8TluGCuzgV+6h5sHMBhm4tUYGi/0KgjlrhR0aTheYnJ2w9fc0FJjykw30cCwVzUFL
    VGxlKRb4ZAcUJiaZQDcagjySXR0/ef0ba8eFQaLtttRWf9QsrK03r3YkHui/deCxQth/F+
    L64jeKVJRY1u0e8lxhds+DWKKAvmh18CB8YPb28fqoWrUOliAkLNFtF3+XFb6ws0WJx78w
    nPtgmyMFrfwQ7SNoPNjar/gw4XUxnklUoqg+oB4Zx6dZBtlIjsZ3+1UWIFq+f7P2FdyPHx
    9GVc6IHakHeXT1hXhqp5PBSLPNjiX8xNcicenNXEytBBW5WjpleFrUhNar4iikYQFHLhEt
    kewJjIJUCbg938JUG5bLO7r1E2PV4jXM7zHa/gvADIf3hrhbFvtrCmvqGIPCyU8fvazzVr
    rGosu2lBr48h7OcCDV772EZf/qFkeNy7rXtRZytrRgnKCvi5eTdnITBFDAFn3o11ktUec9
    zncTXIJ/ecIF1nIYJN8wWHZeNDU8GZQqRLzdZgOoao8D06My5xi7WOc3hf+Wb20cElYUX3
    lzGuNpvXd4w8FZlNpZA+98n09lh4ck3+vHcvUf3E/b1KzE8payz312UDyZ0w
X-ME-Proxy: <xmx:Y7BYasB7eSbxcXWxm34Unl1FfCf4dxcxqUsXPvOnL_5cZVJhptGLWQ>
    <xmx:Y7BYarfudK-7yv8xKw_rmgSAx61sTbDxIrK9u8ptkb8u16MgKgDMog>
    <xmx:Y7BYarMr3_oh3LYFmj9oaxHRjQlU0pGG4SSdBN957NsVZk0mbSssMA>
    <xmx:Y7BYarL7iv2Xahzy9RhQBX6p8LWE4iz4pSosH0nOd6KvUjrcKXORpg>
    <xmx:Y7BYal_pL7Yd6fai0dT_E7IFk_u45fqL7N6gWKI1BKfk_G2af5v2ScmT>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:20:18 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <46e56724a3d8a9268ff2d086e21e23b6a0b2d97e.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 18/31] swim: Remove redundant RELAX actions
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Wherever we have a swim_select() or swim_readbit() call there is an
implicit RELAX. That means the caller doesn't have to do it. Remove the
redundant code.

BTW, Inside Macintosh says, "Be sure [...] that CA0 and CA1 are set high
before changing SEL." Hence the RELAX found in swim_select(). The SwimIII
driver in mkLinux also has that. But the swim3.c driver in Linux is odd:
it scatters RELAX actions around as though SEL was not actually under its
control... In anycase, swim.c really does control SEL so there's no need
for that here.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 6f93ebaaffb7..b4bf96a788db 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -336,7 +336,6 @@ static inline void swim_motor(struct swim __iomem *base,
 		swim_action(base, MOTOR_ON);
 
 		for (i = 0; i < 2*HZ; i++) {
-			swim_select(base, RELAX);
 			if (swim_readbit(base, MOTOR_ON))
 				break;
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -344,7 +343,7 @@ static inline void swim_motor(struct swim __iomem *base,
 		}
 	} else if (action == OFF) {
 		swim_action(base, MOTOR_OFF);
-		swim_select(base, RELAX);
+		swim_write(base, phase, RELAX);
 	}
 }
 
@@ -355,13 +354,11 @@ static inline void swim_eject(struct swim __iomem *base)
 	swim_action(base, EJECT);
 
 	for (i = 0; i < 2*HZ; i++) {
-		swim_select(base, RELAX);
 		if (!swim_readbit(base, DISK_IN))
 			break;
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
-	swim_select(base, RELAX);
 }
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
@@ -385,7 +382,6 @@ static inline int swim_step(struct swim __iomem *base)
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 
-		swim_select(base, RELAX);
 		if (!swim_readbit(base, STEP))
 			return 0;
 	}
@@ -399,8 +395,6 @@ static inline int swim_track00(struct swim __iomem *base)
 	swim_action(base, SEEK_NEGATIVE);
 
 	for (try = 0; try < 100; try++) {
-
-		swim_select(base, RELAX);
 		msleep(3);
 
 		if (swim_readbit(base, TRACK_ZERO))
-- 
2.52.0

