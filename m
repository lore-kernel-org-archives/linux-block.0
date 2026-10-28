Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205868;
	b=USMLh9hpRr/Cr1s6ngayca3oMFBAGqZVUDnSHibdVvI+ND7wtS1vCbdDWelGBKJXtN0D
	 zv4cNcQp4zQkZxsetWCHZ1GXVFZh8m4vEOaV3hmycYZ4EvCp7RTpxQ6hFanyrBwYILCOr
	 Ggf2sEtkqTwdNGn6tZf01GkHUy1iyIvkXpL3YrWqL9xfE9Tsso45wRvM11xMOc4QTq0Ng
	 38GCuGAbDcN6cFjD6VeeerwTBX0keyHZffRSyQ2QxeRCvHjEca0p7yTKW1mIjXKL1f24V
	 yqQHM85UNDENM6nHjbiazfZFT1zrtKsaEb6tgo3+F2jfjPTQ9/xjaUQuRSd6dneZ3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lwgogBUaAi1Nto0wpwXWmfpj5EqFBIqg4o+dWouQbOg=;
	b=M6DOWQS2jmNBhWbwywdq3ZM9IootxQIKkDStgiKK5nEJtVAw5yUZcgXXWRwuSyZiSCoB
	 I+Fy/oorMe5RiOaoc9WZyjvpcYhAdMWEKR8Uqj1zB9OJ2F9P3wML7kn/HCN4xvLMqs6wI
	 LyMmIZnGlhc2UcppWBDN7N64KKvVnos1qfltGZ1QMO4ZFt3FPYFBbqUgMRxKg0Gq2S/Mk
	 XSOBMPYjA17U3on1kArJdQOgJ+UYn4nlvJ5VCGVP7PPHjKQNrFFBQ58crEUj6H9UCIhB8
	 A8ZiPos/sRIHlkC8Or2BsPtAMF5S7l2q8TOsdfaQsdok48nLxVAWynLFuJ7DrsCcmGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MmNLcYn7;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875D606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4875D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MmNLcYn7
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-844a8bf7e25so798111a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205867; x=1793810667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwgogBUaAi1Nto0wpwXWmfpj5EqFBIqg4o+dWouQbOg=;
        b=MmNLcYn7SKDbukuTD2N63WHh4WpsnoJSVutZZJ1aHipm9BjBFn3YU1i0dElkAM99vB
         Gm9hlHWAPoRTLdECfVbTRRBbLEWJUyc5G0uGbrOMdh8L7CEWscKQjXuNNkBucHtC6lYk
         AHVK572reAvdRnscKZo7PtamExVWpFzsaQ2m0Q1+CczFoIb5g+9V5K+2Omy4oi7Mi5ze
         A32IDLDUbVT3ZvZXPCj0z1izqMsW2PfoJc4UoFCO7L4G7+HKeOeaDZmqRUGFfvpF1Luo
         1jEKs8+QkOQMp9fwh9juZ8HcLceOQkOjf8SKjkC6OkQcv66n3AwozcC9QZOczRO3ZawW
         1ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205867; x=1793810667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lwgogBUaAi1Nto0wpwXWmfpj5EqFBIqg4o+dWouQbOg=;
        b=TNLdgvzycM9ttdX7oN4ZYGsd/mx8hORepQblo6S0vd5nz+ysPVSOMBe8nFi7Kqp5zp
         NVaqtqW81HpeNro88fzNxk6ozqqkGR+83lTa+5Q8zFTlyFu9FgDZMqdCjgDIAqYVCmD2
         bRaCMh386k/FwcBKakBwDKf8woY3xs3NW7z7vtHB0Y3EJzN0NApy9t6S62gOyWEu7X8E
         f//hbIvHqk4nI1LdHhNP6oGLs7HyjYews4XamAcEbIgoFKGjGlz0/CArSGyLcZjhc35I
         Gu89O/hPRcI54SKZMztAjWUItUywlEIUbYdDvwOYFFtmdbWwhV9PmB6D1FwlRIJlOmX4
         O4YA==
X-Gm-Message-State: AFq9FYKVFXchxvmesJswjC/VTD0uaVxJ44xcK7V4W4md5Z0X2qaqmd5a
	cAA6RVe6k8S9+z71YhoMe+eFX022jWNFFQO/u0y+q48B9lK5uG2eCFS19I3T/pzcDWRgJzE0ZZT
	sTJk5xcU=
X-Gm-Gg: AYBFou2mMcb/9XkmNS4+rcpmllXP0pBHzeEO/K1OyehRU8tCdJTI27z2YkJnO9CHSKN
	7s2NO14XNy8A5lADL93LuZ3Mm5r4w1wu5tP53Uf7WLoV2wpl++uJFqqYiFbFNnopzNhuQvupKfO
	IHQEs0VMPGZ+mcaZlgQEeSMRPcSAseJIk74TLRHgikYSmxcWVO/UVQ0aE8dUkzxYmRA2+iLzmXW
	FPuAdlSfSblCdGnbl7nhRChXKTBG7YzUT5chKDQz+b70sAIWpyaudEpaJ949fzYEIj/B5M56U6C
	GfRDk5tn92ujym1qZCYCyZxUBWHb5TrZU6r00bHEgmjTtN7s8sv4I+loZjvDaP0kaVu7bD4BtSc
	F9vtFHlNP98Uo2mhcPN7K7TZ9EMWum/Fq67HRZ1GyjrVH/SrdmwrM+Bz/LWetm+nQP38kp9lxGx
	sUnpj88WDpwpy0UNGSMSrgd5Xs/FEf0OJGTGPm+9e1mWQReR1yHiqwLwoTm8Ft+idaSAZEHhCJo
	bKyiBLjTFIyRON3CaYoUmu7Fi/f0DCXuhjPNnSaIuEIUiY8oEWt5QevIKKXrjHxKQKFxWdSq3Pt
	HTNW11qZuwpBGqG6950wqDaJpVIeGMalgYYK6jBHwNHToMoZbUJwr9CqEtXPDvdw0QkjCLGLXw=
	=
X-Received: by 2002:a05:6830:4391:b0:843:e0e8:8a0e with SMTP id 46e09a7af769-85abd8057bfmr2616170a34.24.1793205867329;
        Wed, 28 Oct 2026 09:44:27 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/98] block: keep zone write plugs with plugged BIOs alive
Date: Wed, 28 Oct 2026 10:41:10 -0600
Message-ID: <20261028164415.1262013-8-axboe@kernel.dk>
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

The issuer of a plugged zone write hears about the completion in
bio_endio(), before blk_zone_write_plug_finish_request() unplugs the
zone, and may reset the zone and write it again in between. Since commit
836efd35c472 that revives the plug the reset marked dead, with the new
BIO on the list and wp_offset still 0. The unplug of the first write
then sees an empty zone and marks the plug dead again, BIO and all. Once
that BIO is done the plug is freed and the write pointer offset is lost.

Only remove the plug of an empty zone when no BIO is left on it.

Fixes: 836efd35c472 ("block: fix handling of dead zone write plugs")
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-zoned.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4c5889296191..18c05e2a1746 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1812,7 +1812,14 @@ static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 	else if (!bio_list_empty(&zwplug->bio_list))
 		disk_zone_wplug_schedule_work(disk, zwplug);
 
-	if (!zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug))
+	/*
+	 * The issuer of the write was told about its completion before we got
+	 * here. It may already have reset the zone and started to write it
+	 * again, in which case the zone is empty but has BIOs plugged. The plug
+	 * must stay alive to track them.
+	 */
+	if ((!zwplug->wp_offset && bio_list_empty(&zwplug->bio_list)) ||
+	    disk_zone_wplug_is_full(disk, zwplug))
 		disk_mark_zone_wplug_dead(zwplug);
 
 	spin_unlock_irqrestore(&zwplug->lock, flags);
-- 
2.56.0

