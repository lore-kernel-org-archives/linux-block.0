Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205875;
	b=sBk6ksGgdZSvlgXNAPZvD83Iyo2Le0VlHsuwGT24h1KqYR3hCjuOlxJxprLm+sbzIG3+
	 GkjnwEkSzDbynSv/+pEmbAvYu89Djcy1vgqLY8cCjRDGEKvViJpvn9HeTmM2HN1uM5VU9
	 qkdT6VZLVwi93B7981dzk11aDBNUvPq/JURvpv+2mygC443/nekG/X2GYJchej4lsXh7M
	 XzYR0tuhXtuuqYRLUDpFFwJarJPFzDsAujvC9Wd6ukIQPuJGQlvSIsEHu6LnCdDj222aK
	 Uu8xl/ivtcC8j3p32cMqZw2NG6iXqT8EQCOigiJ2FXwA7LUYfSwJ8TSaL/wfaajb4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Eah4eZ2NNJey3C3ZIctCsaYE+Nsl/KWY1VDrBW5Q9l0=;
	b=pRDAaA455cEXpshFsw9jXNQZOn3QMPYor8FwtY1fLAxcdf0qCCC6DTIRSkvcfzrYW41d
	 8kvNmhAlwAH3q1OcwXyE8DRQ7s8FKTxGsp0k6H8uy5hyjTdXCtMB9NOpp7yfAt6/vbmyi
	 CZmycdEMmgqZTy2YAW3KRCrNGPkxIp/dK3CStlIfe9N0Kodmq5VM2QnWK8jMhHqIF1ybJ
	 ahLTKBhKR+9qoHrYajmy9uHsdAP/b1FJINhHRao3T+iBWbzaxsYhbYUNn7XAtAyuXpwME
	 wc6oPV/0tfIcR3lZ+jtK5msUm3SYtdNAajPGLPBoJuMYlnTneXZUQTgSdl95LV69/RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tdYY9SG4;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D7606A320
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2D7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tdYY9SG4
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-714d57774d8so271439eaf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205874; x=1793810674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eah4eZ2NNJey3C3ZIctCsaYE+Nsl/KWY1VDrBW5Q9l0=;
        b=tdYY9SG4kfUDOB+dHoA+NMqdIS/Skh6EBe9XKsmoP58oH865vXkzvwT/ntxkl66+wM
         eAKdtUbUhx5ICcEIGFQ7IB7tcBnVnUyvMIpHFfiusgP7WCAS/mEfv+bak2b78FHb/3Wh
         6DCYW85MJ1AsXZpEVSOUnfl+Xi1Oq2iiLBQ1nSI/ZFPtGzD4dhfN/CHy66b0onGOYDby
         J57klmMHmyMsomqeB7HPnKCcMr3qB2bjZdmI/9DWjiPyy6qEUs5Z+knhVdRxcyUDjqtO
         5XE6B15xLdNZlq1n9Gh6mVrEc7Kasuhip3QmvssIgm8VP9phkuG4M5J2uckSYDx/GCUc
         XWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205874; x=1793810674;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eah4eZ2NNJey3C3ZIctCsaYE+Nsl/KWY1VDrBW5Q9l0=;
        b=Xm1WrTZJUC2TI2UTmaIBZyMIHmmOc8tE7/BtVdlrN3/BaHLMykpNxBbWcCR8g3tolX
         3fAPglsLeV+9Hn5aErftx5H0XoVhTyKENbYjzqTa4SYrKmPo/kaJEG+gsI44sl30VI6S
         TNCSYWdDyz5vRCGJzsNhTSDptoMrxCmFF1X9At7pE1wv7oRfRcfqweKlzJjzz2R1qGF6
         NeOr6znjYjNaqHbNPgl4mg2vfihOnjgnY9vg0ucsAj0BOeympOzrm/5zObRbfPhajXUR
         dqgD5S0rV8H+Daff6MUtOeTNzUkw/KiiOM2fDH7ZQzKkdGcv+j0JO5XUkya4t1GbjY4F
         iaNw==
X-Gm-Message-State: AFq9FYJSxrBAve2PMHZ397r5Ua0KUKTzkmecTJfs0qWT4UfmNCVx4/Sm
	QQ6/3AHWEOwHktHj4O//ecNM+yErEax0lbcWcZnT+zWBR7MqZ5GSxEyXoov6Lg2ttU7GIyjPN/x
	P6hsDKPY=
X-Gm-Gg: AYBFou3syYw9hZWAk257jyxHKrg26eUH1KRkjjEFBffNyaOVHV9J8n1HbVWluEX1VpS
	/QtFirSxXcF0VUso9B7SusTPSzt7WOfyE6kNcF9rIH+jA9g2DrlwTxMQnEc+lyac7Gz9qDth4Ks
	t2/bkM1/pzRD+tf+Z4MfxhSKQwwOZ5P5WjGTZiRdGGnng6tYsXRjbI/4f+0ZkoVOqmD6d1irdi7
	w+FKDeZjS+kYdGzuM7rbaemg2zaBJALsSjcDnmxnHt/6fSfzAQ5JSg4DbNIh5Z0EviQfWfYDJ1z
	p0Rdwh/OuhffsCcRNr6QcLjx6qKkfZdwTynelPQ8FJKaPuxRXRr8I+FjewApsf8bUjAotqwilzk
	EwEuWlAZCjPDjitWXNWTIbqrlEKAOKYaPFqW9Lo3YmYnjQ+9bZbzldKlukGzqYbbbkeRNCfr3rI
	pGVqazSaBvIs3hw/y5CQY9ljuwnqcL2lq6fzfMGwppvP9dX0QAnaQzeZ//aGy1LikHlc6C/AUAB
	JAvwlljkFE+46Tz1ygkcaeafZJWMMJxK0tvb4bpr8zchVVoVW7vpBEZfahAJlDOoYG6ww974glU
	um9e7jOYrQXGDMls7ksdjO8Z+TiQtnr7RpJzppUOj39p6lWzO737dl+F7hyYfd/v4Bz8jBKSlg=
	=
X-Received: by 2002:a05:6820:2203:b0:6d7:a325:35f7 with SMTP id 006d021491bc7-713f05cff45mr1541509eaf.81.1793205873788;
        Wed, 28 Oct 2026 09:44:33 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/98] drbd: stop the start_resync timer of a dying device
Date: Wed, 28 Oct 2026 10:41:15 -0600
Message-ID: <20261028164415.1262013-13-axboe@kernel.dk>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

start_resync_timer gets armed for up to a second and nothing ever
deletes it, so drbd_destroy_device() can free the device with the timer
pending. Shut it down where request_timer is shut down.

Fixes: 370a43e7982d ("drbd: Work on the Ahead -> SyncSource transition")
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/drbd/drbd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a2a841c89201..099dff1ea256 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2163,6 +2163,7 @@ void drbd_destroy_device(struct kref *kref)
 	struct drbd_peer_device *peer_device, *tmp_peer_device;
 
 	timer_shutdown_sync(&device->request_timer);
+	timer_shutdown_sync(&device->start_resync_timer);
 
 	/* paranoia asserts */
 	D_ASSERT(device, device->open_cnt == 0);
-- 
2.56.0

