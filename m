Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205892;
	b=Y4itxe/BhAuEmO0kU6E3ZmTpyCbx83TQ/nS9snDhFDdraJEDIy1hRIqXWwlcKNYSCFre
	 xSRPUE2hkxja74Q0bBz3e0YCBseU0mKO+d0w731WtUzZDGoMGqS/0Z7F1/rH445DGKhBi
	 E5HLuJEryDJuKOKAkkKPEHZIrYP7E+DQNPItA85zkVUstSIMq6V6nJ6T+vWI56SEx3ntC
	 wskuEk1L6Ezn+ER1X6jyYi/pNMi0ac2OI/NuTKNB+w+5k/JYi6guowZlvFObp7mJzx38u
	 /lTkbGFQQxSlA5x0MENkklw6gzS0e8b2+dfz0aTJZrNpxJc6YxntREZ9GK2mdhEH2Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FQPoQ1KPxajFoXmsJZsv0bKSDr7AhMOKCf05nkt91wo=;
	b=D3FG9cFNA4m6StjMRVjdraHiIOimyBBFAr0+YGR2CpOIcBaWticbZuPgw1o5sZufXMGT
	 Djuq6eGNhvJhDz8s+dMl5gs8S+6c/WDfFdrPisyFblK0hmPGBLDjHd6LDM1ihLhVGyb5j
	 I4PeJWaqkGvONFMwDBNudC7khdjmMLFLbkk/iBSWd1BhNqK17nM9qc4kLcbeg6bglNAFj
	 JZeHERqEizGFt0QwPOpUYGJ5qloJ8Q8t38byNwwSSqHYtFt3thREgMzHm42T2gidflmQb
	 5ohR8zJDZMtz5BsvmNwNB6JusvHLIZuWcmu9zC1kJOJ40CN7OFoA/6dlbHpe2yL2jxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hp2vGnkW;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3695606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3695606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hp2vGnkW
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8470d7d430fso575736a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205891; x=1793810691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQPoQ1KPxajFoXmsJZsv0bKSDr7AhMOKCf05nkt91wo=;
        b=hp2vGnkWmUmZp91hNcjW0ATEe2yZVqivF+xhfbied7ev12P9JlDeit773Nw8JRu3/+
         xMidy3G7DjtOSwyrc5Bq/GgA+BOerMsjDhhyy+YMEaz2r85Lr0KPoy0rB17euCHhsq99
         OWwdXqb6pABALBwmDeHB0i+iF3sbYj2Y4S87ieg4vSOLOUfMQT2d5WRNxXMU+zneUXY4
         4zOUdN2DrHtQs9s/yDtgilic0Cx7Li7yIrVjDocIKZsDip8HEPSVztV4NegPjz8wtawP
         Bai06PuYbcgnrVNkpdKCq77imJ5/A5FEd79IGuC8lZN43JT3QHDn5HS7E1Fvth2FpHyv
         uKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205891; x=1793810691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FQPoQ1KPxajFoXmsJZsv0bKSDr7AhMOKCf05nkt91wo=;
        b=fy+Z8JgeV/ZcWZk0fqLhoMyx/F3r1f4YO2BomwgRYcDgvBFWhDfS0rlO33RIh/jwip
         5CAvc+RtChMmsoGwUQpEmMXB7fyt/HyRGrSKiWD/+b2mZf/wWqSySJbspzDBKfYmqTvT
         7HbgoMvUG6fmqdHi5HVRKC9O2KXZc8WJlKApcGb2V6/Pe6Kc61vFTFZY+5+V/ufcRjWM
         45t18HYBkqMWEKcUyK1JVRIxEneS1AWpSI6g5D/DVZANkyGv/UjGAVH7qD3JMdTZSVz4
         AqCxeZg3KTxUapKcOJoNfo4IV/3mnG2rJChIPwHK2Vra82BcjeRYsXElURklrQSGRacc
         BrrA==
X-Gm-Message-State: AFq9FYLU0MqZyr9+cNwYrbKuY7mKY+88x8Qgoch2uyzZtOmDcu3IH/rh
	zSEEJKszp3lo1q50AJYxGjDPDR0LozIv4V8TNMbkDRIlvlTxmnTXMD6AAggJPelEbEfod6HhCs2
	Lh8W+WXQ=
X-Gm-Gg: AYBFou3U+Wxat5BIf7r14SDCJ5pHfi6IXs+ItJbJgs+T6/ndxExawoKcZ6KmOu+jRnA
	t02NxcOd9eA5PXW8R9u6BWGzoFt4uJ/YHomEtI5vs1yzxPcXyBcCw1Y6nIBpcV4cAO5UtfNOXIN
	9NlfbrdjisF+swVmlNtc02XmkCG7dkj4KOXvIjkDce/zLn0CWAfw3mVq0oN2LGrGTC8YCPYa2v2
	1g3P8YcUoe67hLfqt1fJwTbl8ViL81J7EfhHpV3cIHPThqgjlYBTPedMslY9Isg+MHfO1Ar23eE
	iUYwPjEoIZ7ORLc8U71+L+uchU10gVmD28ep4WOdq1VguOCcOug2Y+T4/9O1yFVYfc87SbH5BCC
	ioE7YwvsABec0qi+DzegH7oYhJCi5bFkI3scAPN5tc6FttihSCBfJ/Mz2cMRfs5bvtYj7ODVZ3w
	YEkdMKz8wLgWNh5q8E7oUaVvnVstD5LYp2ncV9d7rO2ykl9KtKVRD2dFSrUCkqAO9Wei3USbfBb
	pyX0RMymWKVWOVMOd/Lu/EzCkuY3MaqWFe/5qMra2EzCiCYLesTNrXDpLls7KcSKRYXozAj0J9H
	bY0XUS7KpKVg0FyeNGpsNuVMjwW13DJRov4Mw5MDwgL2TF5VIyCqITWU3SaVBqOxBiBH2geBKw=
	=
X-Received: by 2002:a05:6830:3491:b0:83f:492a:91e0 with SMTP id 46e09a7af769-85ab9e47d81mr2810279a34.15.1793205890831;
        Wed, 28 Oct 2026 09:44:50 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 26/98] blk-throttle: make blkio.reset_stats reset I/O counts
Date: Wed, 28 Oct 2026 10:41:29 -0600
Message-ID: <20261028164415.1262013-27-axboe@kernel.dk>
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

blkio.throttle.io_service_bytes and io_serviced were reset by
blkcg_reset_stats() while the counters were part of the blkg. Now that
they live in the throtl_grp, add a pd_reset_stats_fn for them.

Fixes: 7ca464383aec ("blk-throtl: stop using blkg->stat_bytes and ->stat_ios")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-throttle.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 80a5e4b2872f..c46807a0faab 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1684,6 +1684,14 @@ static void throtl_pd_offline(struct blkg_policy_data *pd)
 	}
 }
 
+static void throtl_pd_reset_stats(struct blkg_policy_data *pd)
+{
+	struct throtl_grp *tg = pd_to_tg(pd);
+
+	blkg_rwstat_reset(&tg->stat_bytes);
+	blkg_rwstat_reset(&tg->stat_ios);
+}
+
 struct blkcg_policy blkcg_policy_throtl = {
 	.dfl_cftypes		= throtl_files,
 	.legacy_cftypes		= throtl_legacy_files,
@@ -1693,6 +1701,7 @@ struct blkcg_policy blkcg_policy_throtl = {
 	.pd_online_fn		= throtl_pd_online,
 	.pd_offline_fn		= throtl_pd_offline,
 	.pd_free_fn		= throtl_pd_free,
+	.pd_reset_stats_fn	= throtl_pd_reset_stats,
 };
 
 static void tg_cancel_writeback_bios(struct throtl_grp *tg,
-- 
2.56.0

