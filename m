Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5E2F617D
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313200; cv=none; b=SE6Hf/WVdwSe9PofJQJRxcq2n+/AiSep+nASRy9BkAas9BLjQbMpN18Tnb+8MLq5dkrUewv3AthHYacpEoMi7Sgpk5xgWLffbYjWBaSSe5dB+aVCisedjsyIuH6i1+bN19DusVTwn2HRy73vvHKrhRrVXWiYUDAFJot/Khk9Dck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313200; c=relaxed/simple;
	bh=XNMHHJguSN5BclgVIkPWZkUfWieiYIzVEUynIB2F+og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJb8cJf8uBG+8sn9ia6PDvfw2RZElmB5+0iMV4ENVsIaPcXETThkzJw3k223tWwjExOBH7yuZ5s4Pqmd5O3zksiqxFJf0XQTD4OhhI9qCTQqwixgfJWQmkNXfab6Ql/c3TMPR2ToakGWFZmQwKaH+cIdK/d+4dzzSthKWU7boh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=KAsRUpRK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="KAsRUpRK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432da746749so814161f8f.0
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 09:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1770313198; x=1770917998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdr0IwDMGGG3tNroL/3nN4LO0wiu5miJzO4pgtEfhC0=;
        b=KAsRUpRKUoGgDFmeCmV9/c71Vo+ptHGmCuDpcEbsIIENNHAVsf7UfLAKljpwPDQ+cF
         lJ5ty6xOlPdwA4Pmy8jeDyDVDsm57KVaDYAPrT3oaJ151aYy8EC6SIufZ4OLJHuuneEO
         baHJLPgp9PEZMJz3xgbOPrMRqQRlsO93aIE5oQUgLOLwPOftP668iqc2ky65Zlc94BCB
         sDF1RHboLSI2Ib4ezYu1ep27ef5uCLEeM8d7eM7B2SR4+QeuHF3X6LI179jV4r3K94C4
         FQOo+PEr6WE/SgMiNena5LpEBGYHoo5UgLn0/e8QuS7Bq4KnJz1Ejl04uY0KIYuVfXbG
         Q/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313198; x=1770917998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdr0IwDMGGG3tNroL/3nN4LO0wiu5miJzO4pgtEfhC0=;
        b=uTNP+ksi+CTV4IxZciZe+4JBkisBFfQma3tjRU+714doL91tHGKwzs5xmsI5Wxzihs
         VXXdvwtfAOc9NrFOkBJ6q20fDB330mnutGqW5s9B7ENz6iZ649kWISNp/XKtNCEERgO6
         Mf14BGQ8mW+ESnrAwgnS5LLO0W0eHX+D4yAZwiLuTIykSdwceUzPO0G0yK76ZE9duPNl
         iSC277kXOBW7XIbt8B/+fdJHD15eP8mrFQ4IkECslQSnqtSC2K84Gybbk4dx92Fj/akG
         UVzWqDZHHuUMDMTsk+oH3YrhReWf5AhTZt8R7kkzHM3yZ0oWuxVLEG5ciNiDzmRYo7MV
         4rdw==
X-Forwarded-Encrypted: i=1; AJvYcCUTZf0y8XnLzaeIFbXFa0MMmbuWD/KhtNIjgqyFKP430J5pZY+gFX950x/jLI3ywBh1QUvUIQ5vBDXsRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxorujzyrtF3szb2+PcXzvMlkt/Y7wnpwkC7Y0sr6zlZh6TsFZ
	w+9h1tKY1TuDqj3KldsfsL7OKZpDINnBN06CM+jVmFUBqB9xuXG/cB2Z97Y/izkTMH0=
X-Gm-Gg: AZuq6aLQPKOBUkKgbX92NkAh2BrgKbo8l3DUm3+XrSK/YH5exWxjAsVMqY36751g375
	PxSkz6q7IZDWK7ybsIwDAJaBU40xGwrDTJ7TBroSib4dEzrIgbqW8X0IiaxodBEvW9/MzdXKFx+
	4MkZbNz1MAekBpyvYwEzV4SnId+A/V7VbAaRxvRm+A3Eksrz29iVTMirwMp6XhnLfHsitnTIwiD
	/cCOou7wwBBHWHvVc4KW8A1rRwiE5MpQrexj3xR9gylkoGlZOhI9SoyXx+gInfWdY7bhwdBgeqI
	jaHYu8BwItOV26IbAisERdjeB81PP7EbpMEHowTlC0UDOOO/Rq5OlB64GGn8LmoJe3KbIixKSik
	ha923jMoGd4XfbmkT4Uyt0PGbXI9JOCgL1MlIztABBJQRk9njn/SITAx/jQZYBpkf/w3SQBnBzn
	WPNZRUOTp8Knj5lg48wurCexcBW8iUPNuaV4iAKHqILCuqHc0yYPhjirnoVOR9ixvsLxHskSV9e
	tcv/vUbuA==
X-Received: by 2002:a5d:630c:0:b0:436:1896:e1e3 with SMTP id ffacd0b85a97d-4362924101dmr57832f8f.9.1770313197976;
        Thu, 05 Feb 2026 09:39:57 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25cefsm16559622f8f.9.2026.02.05.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:39:57 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH] drbd: always set BLK_FEAT_STABLE_WRITES
Date: Thu,  5 Feb 2026 18:39:29 +0100
Message-ID: <20260205173928.3166880-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DRBD requires stable pages because it may read the same bio data
multiple times for local disk I/O and network transmission, and in
some cases for calculating checksums.

The BLK_FEAT_STABLE_WRITES flag is set when the device is first
created, but blk_set_stacking_limits() clears it whenever a
backing device is attached. In some cases the flag may be
inherited from the backing device, but we want it to be enabled
at all times.

Unconditionally re-enable BLK_FEAT_STABLE_WRITES in
drbd_reconsider_queue_parameters() after the queue parameter
negotiations.

Also, document why we want this flag enabled in the first place.

Fixes: 1a02f3a73f8c ("block: move the stable_writes flag to queue_limits")
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
Note: this commit is based on the for-6.19/block tree in case it is
still possible to take it into the 6.19 release as this *could* lead
to silent data corruption. However, due to other protection
mechanisms in DRBD, this is relatively unlikely to happen in the
real world and we have not seen any corresponding reports from users.
So if this only lands in 6.20/7.0, it is also fine.

 drivers/block/drbd/drbd_main.c |  3 ---
 drivers/block/drbd/drbd_nl.c   | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index c73376886e7a..1f6ac9202b66 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2659,9 +2659,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		 * connect.
 		 */
 		.max_hw_sectors		= DRBD_MAX_BIO_SIZE_SAFE >> 8,
-		.features		= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
-					  BLK_FEAT_ROTATIONAL |
-					  BLK_FEAT_STABLE_WRITES,
 	};
 
 	device = minor_to_device(minor);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 91f3b8afb63c..b502038be0a9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1296,6 +1296,8 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		lim.max_segments = drbd_backing_dev_max_segments(device);
 	} else {
 		lim.max_segments = BLK_MAX_SEGMENTS;
+		lim.features = BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA |
+			       BLK_FEAT_ROTATIONAL | BLK_FEAT_STABLE_WRITES;
 	}
 
 	lim.max_hw_sectors = new >> SECTOR_SHIFT;
@@ -1318,8 +1320,24 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		lim.max_hw_discard_sectors = 0;
 	}
 
-	if (bdev)
+	if (bdev) {
 		blk_stack_limits(&lim, &b->limits, 0);
+		/*
+		 * blk_set_stacking_limits() cleared the features, and
+		 * blk_stack_limits() may or may not have inherited
+		 * BLK_FEAT_STABLE_WRITES from the backing device.
+		 *
+		 * DRBD always requires stable writes because:
+		 * 1. The same bio data is read for both local disk I/O and
+		 *    network transmission. If the page changes mid-flight,
+		 *    the local and remote copies could diverge.
+		 * 2. When data integrity is enabled, DRBD calculates a
+		 *    checksum before sending the data. If the page changes
+		 *    between checksum calculation and transmission, the
+		 *    receiver will detect a checksum mismatch.
+		 */
+		lim.features |= BLK_FEAT_STABLE_WRITES;
+	}
 
 	/*
 	 * If we can handle "zeroes" efficiently on the protocol, we want to do

base-commit: b1e5c96ab4a011763afac033f6660cf1eb499458
-- 
2.52.0

