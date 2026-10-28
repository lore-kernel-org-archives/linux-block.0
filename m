Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205877;
	b=2YpL+eDqgX6436ZnyAk+SRY7e1/tqYovSzvQ/2eyrV7oi5AJnJx40AWZsWye7Zkfcvl1
	 IS8vrP7PXHeyPGh3cHn7iiJSLTX7Se0e4JSt3j3ehq8yU7DvgB9iSauL4aoq3OV5fSZWC
	 x0jVPWJ0KD0/gC35AU3C52+Ymlkw8GfMA2VF66FjXmUFSzk1ybQDfv4IxTN0n6qDY2uYZ
	 /l4adBkceY8ItjWAY63s6BLKegzdGMqawzB/FZi6JQQXynoS8i/hXhYt+x3SywAz2tAOu
	 C3rbCzbnZkzWRhUPIdYARJJ9VGh55/oxQ5dHrmMY/P1hRvyYvP9vlV4bujV4FN04VMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MsjJONEl2ufMEQeFENm54QCqTNG6W3CtoJ/9MOxw5NE=;
	b=HQr13KfdcgIIHX1JPLIyDYWUIADRVD3LyGZgGSyXv9LqiDv6o8iZ1WKrxLrSz6DOSbRF
	 Z9WOd6vK5hcC180v/Y1vRCJ9TJjsKgGPsEiBB8nJb30YiKH57pXhc/C7Hiyswboz3Mjt5
	 xTUvC8RPXhl6iwJnBKSCQz6+PPd7FpWgTkZChacxMcLtpjoxG5eP7764AzDkxtfaaIwEj
	 3t7EVQNg+Uydyi9Di4Y8JYzP0Un0A4wLIUKiObR20DvwoNX5OYiZLu+b6gizkpPZMXI16
	 LzeJGeYj0ozHfxCTvoY9EeVsMDNUG/JMg6A4UySNwq/3GHxsLU2G5Q+k0ibisq5YwZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="f/QOfbXr";
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9C606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F9C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f/QOfbXr
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6dde81a6820so999426eaf.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205876; x=1793810676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MsjJONEl2ufMEQeFENm54QCqTNG6W3CtoJ/9MOxw5NE=;
        b=f/QOfbXrAO5cWKk6o5DSRNnrHY4WFsmRnp2sp3POHKk0CLS/x7Fhi1wuOPgjzjv0fw
         XGClOeAeqP9q1YwA8KGKTAQ/motmWykqcrb9WkHNgkWax5lBUEh8+bLZHOT7EUDCD419
         jHGSEeG6yxFumnFbOMzGZVQ/xGa0PmRS3QZ883yzoxV+ETCKHVRu/YU4d8YEcwBt87Wr
         WuwukYXO7MUttn1CwW6k/nBu5IP+EZGVc6Smi0ZBh309wIJyO/RudSqeIXVohAkg9xF+
         pKVupIGoEieOqfDwX+BAVSkEEBNvFUvmhw79w9PelUTYcVZZIAp1be7WTrJYVJfYrTEK
         ag1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205876; x=1793810676;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsjJONEl2ufMEQeFENm54QCqTNG6W3CtoJ/9MOxw5NE=;
        b=DlEsXj7gd9EaFjKviqbgaWMJg3tOvk/hPilSkY002mKQ+AdvcSD5t6H/4ryRVsLt6H
         kzdXohbsMT8cO+9L1M7eQ7+OEsz0nmkBCthphLY1Sy39jZ16k81Oyr3RCx7t3hDtBx42
         WvuXD46qVOoAq7TlgPdKj+b8SifPLqC/IzPWZYYC6uCMF6xZVPOZvBO+JM08QL3dn612
         kpHXS24St0zcjuJ/RvAbsWUxGqhZ8yfGVTLsB033EQB7grPihzmH0PiUIal19AED9iQk
         daG16jtb35bUkUlM9RsPoIwjcNgJ28Zfn/OA/IJY0uFvTVgP32Mct9V79zOml1DmX7OD
         a6dA==
X-Gm-Message-State: AFq9FYJKgmLj2J+VvEUbhVD3oWRmhdZswkcVVD+5Qq02IEtXCt70sC4K
	qn7Dc0qYpT2Th/6EiqJ18doz/nQqUPx758NVV+GOVU98ZDOWICMPSq1uM421IIY/eVrK+AMc9r3
	u9gROjWs=
X-Gm-Gg: AYBFou3pc/BgqampOtKOr3wmnYY+Fu45AEZsc4n96kRSH2cBVBy4kC5qS4Fbqs2HWBv
	f+hBRJwTPqsCDSs7yKPeFp0hbLx3ifZmh+4NEgP42c8klhMkQR7n8mqvk/lcatQHHsrPbKDqt+i
	yRqGeZhVwWPuvcRKZgS9muc+jpEd8ToUhSVekbrR7oUvZG7/1300x/7nDmHGo1U0cqdN5DRt9FB
	krdHG3fKfw70x/dDhL7ZpgMaHo+rDn+sz8QLc1JLB12y1Wcd3ouNqDwr9JyJrzvdUnPUEzcjJri
	ZfTGG88w5T5x5HcKsllx/deKUoVwcO74hkgKJ0J7q1rrgjZEAR+VH5H+3I6Uxg5MlCNDgPK9V1f
	9Vjx1UstpPq5QMecNUaMUs2OwTCQRl2vEVRMvqkIcBuR8xAkErxPKgyGH8IyHkpsh6wMr4ug6TL
	AfBzO5IIvOnvavTBHtODvXPdTTeI12W72l42HPKaaT7xlAnuerrOtjbbSQTeNiVolSg1tGaodm9
	BOIl+FI1NzbeROlZ3BjVx1a3dKhFm1spw1qhwsbzzmWgaJbs1y2l07XKVZmrcloYo35yqIPVgkr
	uZeUn0ZnSZN9QdrI93epd9mbCGKtuz1ba8ccqgU+XQlURYy1MyJ+Rd966T2Va4VLwGW/NZP66Q=
	=
X-Received: by 2002:a05:6820:a009:b0:6d2:a9c5:ec7a with SMTP id 006d021491bc7-713ef3396c6mr1246563eaf.34.1793205876320;
        Wed, 28 Oct 2026 09:44:36 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/98] drbd: take req_lock to skip the initial sync as peer
Date: Wed, 28 Oct 2026 10:41:17 -0600
Message-ID: <20261028164415.1262013-15-axboe@kernel.dk>
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

_drbd_set_state() must be called with req_lock held. drbd_adm_new_c_uuid()
does, receive_uuids() on the peer doesn't, so a concurrent state change
gets lost: the device is Secondary again, or its failed disk UpToDate,
while the work for the lost change is already queued.

Fixes: b411b3637fa7 ("The DRBD driver")
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/drbd/drbd_receiver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 2135c14354a8..a405ccdf919e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4096,8 +4096,10 @@ static int receive_uuids(struct drbd_connection *connection, struct packet_info
 					BM_LOCKED_TEST_ALLOWED, NULL);
 			_drbd_uuid_set(device, UI_CURRENT, p_uuid[UI_CURRENT]);
 			_drbd_uuid_set(device, UI_BITMAP, 0);
+			spin_lock_irq(&device->resource->req_lock);
 			_drbd_set_state(_NS2(device, disk, D_UP_TO_DATE, pdsk, D_UP_TO_DATE),
 					CS_VERBOSE, NULL);
+			spin_unlock_irq(&device->resource->req_lock);
 			drbd_md_sync(device);
 			updated_uuids = 1;
 		}
-- 
2.56.0

