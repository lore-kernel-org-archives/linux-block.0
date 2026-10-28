Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205882;
	b=443xJ8xAcUJPoRmRhv9Mqz4oOn1eXYpkv1w+40ALf6b32SA+B7YX1O+S2ZBuOBrYnGn0
	 SO+G8qvvmydtM5x2k57vCUV42T2WPnOoApx2+jbe4y5cQx7jgwIkHd+nDhx80XP3ujTJv
	 LmFgSt2b7eEZa7DQ+UeYIywioe4/uZoYe/VYk990W8nv0AnWBUm71I4lJZnrxb9bNYlRz
	 NDqrtTbn3v0TNrKH9QRb/QJ0vIIZN3VQF0SkV3N08Y72wJND9gXEeJIh8e47gYvXA6ilH
	 C9VdlQUdGlWILCjcmdcq1178N1+6q5mrAudkaa4jzOOzSJYOzyOgqCCKfNYVDs4k8qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HAwCQp7tsNdvV/+ypIhkoZppnDA09ERiRcAgkNdHw54=;
	b=41uwdNNZo3a2nv/yfBMTspdk9CnNB7IwbnDrGxDLpm99ICuL+oCyQLtdRF5ROoFFdA6j
	 /fSsACroYvlREaPK/iAcd5MaWqKc9coDv2NL+8SLwM5+iGPV+gVWsC2H+CKyIH8ytQzZb
	 WCBAMjVF++eeEBUeJwhYNOsjUULjeWatoX4mFhRBJEuZFChjIvS07osKGz8d1kQole+pG
	 dX6w/XSI5VsI4YvvMNejQABHDuQgdrrEMMwKF1g6dcxlHT8DhENptWlKPh3d2k5tKcLjt
	 iRdMrCDjKmr/npm9v8GCYiXmR+ZJ2c5kPS/mTrAzSYfE56GnlpfjyDjJrdRsG0+HJrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QqXdPZn1;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E0606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3E0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QqXdPZn1
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6df7f544919so790203eaf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205881; x=1793810681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAwCQp7tsNdvV/+ypIhkoZppnDA09ERiRcAgkNdHw54=;
        b=QqXdPZn1C7mCJDnttze+6veG9M8WuCBTKayTMQ/mhvQRUW+L20suVF0L/JzaCG+7qC
         WHWHBs9gtYX+QWscNyQaHgfKjoQc0QTtqQTqf1MSOQltqH3OKezdgkBLeH8nayUlt9nI
         tJGX1eudj6UCrFHVd4ZU1AtX3nCIJx35DHB7fsqODpXnbMv9AalyaAWO6bI2he1grxMg
         +5qx1u4oVxt2DZwOk4hlkax6/acagFcEoGSqcVfLiNiiQ+QybLUtWR8TXK/R9cZxha4Y
         blSi3a0fqMNrggrJwMphXsPCOh2shBRpgmeWBa/EFdkfSWOMUFGdOouwcwnrXjHIRVUa
         vUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205881; x=1793810681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HAwCQp7tsNdvV/+ypIhkoZppnDA09ERiRcAgkNdHw54=;
        b=Fy040i3RAbX7mretNlgIFkAmiuzlcIdfhZamfcYTALn1NKyhzrDdEpwKWevCL80i61
         xW8mui/IAZqVRutkAMt+g2ANG81+Sp3hyYdpmQdXfNXJDNokf5vTGOeJOy4TvyMImwoG
         TxBLa560YFJIWlzrEc3Q1dmwZyJOav3tRaHUrjOazunYQropqqAYA0cwmKw7gsynmAmr
         3Tc0Py2mrTzsfi4y5jY3jiDsI3OgV3ChrV7A37pGeclA8s8/4UR4ZtI2bA4QiN1BX9R+
         20EGlCFsZPuinL/E8ULZHlXt1u3D2WQ8mbRcjPttqE27jwdMCmAnZxNijihgkFSTPBOn
         UrTA==
X-Gm-Message-State: AFq9FYKjtd1Bj+NyA4r/gnC/q0szWFd0j+HIH5CpLuVg6vFVkH33OKzS
	cdkrYB7B6nUhT9EofQmw3wbN82bOTU13zM/Y5b4HniyYa5be5o4JNYQsw435b8fNlzmy27XDfhp
	AEhMUHVs=
X-Gm-Gg: AYBFou1RkgXi+5W7Q454Y85t9ZbjmGbJmaecpnJew9DPOsCjolwja8Jz2bDAxxPpIJA
	Z/IjxbnGOZOFru4h23UaYDN8f9BZ0LsOGGgIfo1iQuU+pp5DrjhYW21wMlItyANNO5suJb29VHl
	alG5NGBtG0F65hscdqI/fkUzmFyD03tQzwaECAeYj9jjVLH7D4kY0J/WqAGONWJDUSPh1iqOkFq
	zKhY05v6k03V+WCItKk3k8RIAZI+/bNkj5pe2DMSEiNyEZtJTNnPjCvgijYCCF0qZjkD90s+6WT
	2JHytS+JP72wnVkIGKAxjCXWWsI+GpoxFrl1o3coTS4Xos7yIFIt1ztqtJblvWCOE44X6+TlIKc
	dktclMoC8inVmYxkcfkJY2WdbkzNyTC+q79aJbRYgoXugtcz8GjypJrx/VXCgWplrXgtEm2olB0
	ojxThzpJvFNCGUFdqRUFWHg2Lax6n9A0LsHJc/TB6lOyiiO+MDtfuPhC5nRt95pC5EmNn76TgXP
	d1V3Etc8op64TdwfvoMDApAVbaXF6LnKLVS3Dr4KVydvYDtQU+8zadJEWrR9D05YKcAUda5T1AD
	KZ6mBLH712wVk0RBmf8cW8iruIxOHnJU96bTctKh7PA9L1wNCE1u5WEV2RYearGSGnD6zdQEnA=
	=
X-Received: by 2002:a05:6820:f00f:b0:713:286a:3d36 with SMTP id 006d021491bc7-713f1d50fccmr1488103eaf.62.1793205881460;
        Wed, 28 Oct 2026 09:44:41 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/98] aoe: don't free a device with its work queued
Date: Wed, 28 Oct 2026 10:41:21 -0600
Message-ID: <20261028164415.1262013-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

flush() picks the devices without pending work and frees them, but since
aoedev_downdev() may sleep, the check and the DEVFL_TKILL marking are no
longer one step under the lock. A reply to an ATA IDENTIFY in between
queues d->work, and the device is freed with it queued.

Set DEVFL_TKILL under d->lock, don't queue the work for a device that
has it, and cancel the work in freedev().

Fixes: 430380b4637a ("block: aoe: Fix kernel crash due to atomic sleep when exiting")
Cc: Justin Sanders <justin@coraid.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 drivers/block/aoe/aoedev.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index a4744a30a8af..c5b102947998 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -974,7 +974,7 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, unsigned char *id)
 			d->fw_ver, (long long)ssize);
 	d->ssize = ssize;
 	d->geo.start = 0;
-	if (d->flags & (DEVFL_GDALLOC|DEVFL_NEWSIZE))
+	if (d->flags & (DEVFL_GDALLOC | DEVFL_NEWSIZE | DEVFL_TKILL))
 		return;
 	if (d->gd != NULL)
 		d->flags |= DEVFL_NEWSIZE;
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 6e8b3807c1c8..5b443b3b224e 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -286,6 +286,8 @@ freedev(struct aoedev *d)
 		return;
 
 	timer_delete_sync(&d->timer);
+	/* With DEVFL_TKILL set only the work itself still queues it */
+	cancel_work_sync(&d->work);
 	if (d->gd) {
 		aoedisk_rm_debugfs(d);
 		del_gendisk(d->gd);
@@ -356,7 +358,9 @@ flush(const char __user *str, size_t cnt, int exiting)
 		spin_unlock(&d->lock);
 		spin_unlock_irqrestore(&devlist_lock, flags);
 		aoedev_downdev(d);
+		spin_lock_irqsave(&d->lock, flags);
 		d->flags |= DEVFL_TKILL;
+		spin_unlock_irqrestore(&d->lock, flags);
 		goto restart1;
 cont:
 		spin_unlock(&d->lock);
-- 
2.56.0

