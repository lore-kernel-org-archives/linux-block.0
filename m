Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044308;
	b=W+DOfeVeYJZeOzEw9Rw/jpZ0UtqfS+HW9d0rDBmdTVLpecQFQBe0fsnD2Qeg5WXtcWvq
	 0Z5OtuThzACFJUr7DorzMpadWed3z7sAHbCbNxIh9YDrWfZMdQuBfntLsjB7ZpOjDSHrh
	 cWJ/QR32hlTlpqYtSmhlky/a/+8wcVXwyy6GTXmzDonpIRqu5UxVnhcxDo1xL7IGIHjFS
	 YxecnJsQhwF/HuIvPEDuDIeZIzpOICMCUj5lEwd968kN+U1urpaPVa0znjHBLqz2No3AR
	 SCYuxOZe/aiSgHXBaHPtNVYleGGyvQ2Sdft1fGXcSD3lHhwbFb71MsOkDWBhmtIb0bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lt5+IIOEQntNwj4k8ixyv60ZFra3k7uwj0Sn4JHHT+4=;
	b=zCl9MhnLr3eMi3WewYadpU9JFSkN+41ZYPBsOVUVEKzN523kpB+MSpJSvBoyx4WrVloa
	 be1aSz980403vqYsXd1AQ8Jn8b/tj9iCeslPHP9KohP499fiOQ1BXj5cbTuVAwu5vGQG/
	 Ae7L8hfZp7d21nnXTRJVp2NlZ3QwYpgL7vD4ixXKDZwhACTb9IrFEuduY5dAM4rjxF6hr
	 omH7j60J1RmQTw2FauH41wA842CndrTpKTIrKqgTNYGwkOLzKU7shAi0u1q/s5RAw/ZS8
	 Cpz65grPjptM1Vn56HtNPay6r44akJrFtBFB9K3jh4HGilpzHlbQOuiWwEaNqRW4hAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D2YtkdlV;
	arc=none smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E842606A31A
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 19:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E842606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D2YtkdlV
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-35af9712d88so279669eec.1
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044307; x=1793649107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lt5+IIOEQntNwj4k8ixyv60ZFra3k7uwj0Sn4JHHT+4=;
        b=D2YtkdlVCDGqT/iZgKm4itlNOYiW4o6uFWvyGLGYTXjPAelbMQS2Pv18QOHavGVg+2
         ioK8NOehpDooXHPIbX8jkrkGbJckCdeOh60CmsswXjMvrcNBdMXOB/AZ8LG6ezgMfK/N
         7lUc8oS7m8KmfPNBxPTy6xjMOKDvHfDKSeRGVj19Uv+8grTzMLgweXy5xJFTNKGognr7
         zDOfA7MWebe+XHAlNEyCLcM1RNqx6EijjI/FNx+4qDAkWlWoST0H6Kk6FUtBSgvwVXFy
         /9ehPtbmsP3d61x9DZzzg50mAPfv9GtSsgNFGd6jOa+p5d+J3fc1HraVLcJEHSfT/5Ji
         b9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044307; x=1793649107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lt5+IIOEQntNwj4k8ixyv60ZFra3k7uwj0Sn4JHHT+4=;
        b=tslCAi9ag0GfY+RyeodW1qgXjZ47tNj+hWQS7UBZOefdvQOotyhbMY+Kr5lSfB6gzb
         mB4bg2S4Ptqw23W6m2d+JcOxHqKtJNqzSz99BPJiuVLIOvrEmv1duoPGXiYsAZ2wXZbY
         0NK5c3/aEahIHWVXyU0sCC3do4CnuYJAKnp+/yC8E2o0khyxT0WpmFPjD6YxRCQPXE3H
         Jnp816H49LAzqZveWt9kXCgQxnPk/fK5lBfbuGf6cUXziIsKr1/yTmwoqZA9Qm9gxqDz
         P6Kf5hAp2OiT9dvAg8AKC1JQdSYxzz6vPVpQddw+Vk5FddAzQlb19Bjfu8Fp2Ir88GSC
         pc7g==
X-Gm-Message-State: AFq9FYLUJI30dAIesWvSDWCMyptu7liSuRx2WjizHfcHpUUMZyb8S3S8
	a58kVIBxyZttoAQwye8levGRl9jNYDaklSUD14f/X5991EzR9+9wxmxH
X-Gm-Gg: AYBFou1ri82/GymEKaQ2JPxJYdzePEaUMVhqMG6LWwtXlVfRbAjnwLJ8rA9welYe8vY
	CTMRV318hS0AIt6X5nROMZ1fAEzkMPb6Fhs3dFmndgpzOWLdU6LyccN39IeqObzgW8Go92tlFur
	vwxw2vO+y9DZjCzvGGwvSQbh+MInB7pUIPgPAijQZiRDU5MK35e1q1d5LxYMfQgHRUmN//fCz0t
	PL//9Bl7cALPnxEbZEX7K8qh1z8HVVeJ+kBI/EpGCD6Fro3WKYUXp7TZGQLFao8Tzy7NV2da87T
	IgBPwJh0K7LuHsSGP22t5ktVB5LN2mpThFPDjYrJDiH5vMg5PEszLKv5RVUW2XyN4EcBZo09lpi
	eUVpjuTQFyqPrwH1EbVB9sEazsaT6hm/gY7Ubh1dBL4LAVPVhwlTTMo8ULYGE3jxQeXr8fm6PqQ
	eKhj9cZA/MUtK8ljwI9Pf/9Zk/4Hes17Hbg/u2p5s1UrkYJGwkVQ7iyuV84a7ccoc5U0jHk4CGy
	gsaKRWp/3ISBdPlX1VSBB8dbD20AVtby8mmeRETUZn40tyYyDuFIOylmBJdE6tu5yDq2VC2E+Y0
	irH7QHU=
X-Received: by 2002:a05:7022:102:b0:196:7590:8bed with SMTP id a92af1059eb24-1a3c3240338mr1258384c88.2.1793044307251;
        Mon, 26 Oct 2026 12:51:47 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm36573707c88.4.2026.10.26.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:51:46 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	mtsai@redhat.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] block: fix discard alignment for non-power-of-two granularities
Date: Mon, 26 Oct 2026 19:51:31 +0000
Message-ID: <20261026195131.46699-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

bio_discard_limit() uses round_up() and round_down(), which require a
power-of-two alignment. However, discard_granularity need not be a power
of two. For example, dm-thin supports data block sizes that are arbitrary
multiples of 64 KiB and advertises the block size as its granularity.

With a 192 KiB granularity, discarding one complete block at offset
384 KiB is split into 128 KiB and 64 KiB bios. Neither covers a complete
thin block, so dm-thin ignores both and the mapping remains allocated.

Use sector_div() to find the distance to the next granularity boundary,
and rounddown() to align the maximum bio size. This handles non-power-of-
two granularities while preserving the alignment for power-of-two ones.

When discard is unsupported or disabled, discard_granularity can be zero.
Return BIO_MAX_SECTORS in that case so the existing bio submission checks
can handle unsupported discard requests without dividing by zero.

Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
Reported-by: Ming-Hung Tsai <mtsai@redhat.com>
Link: https://lore.kernel.org/r/CALjSBEvjbiGDVewuapWKhGDtaxZwcn4=22raUiBEOyj22rY7-g@mail.gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Handle zero discard_granularity before dividing, as pointed out by
  Sashiko. Leave unsupported discard handling to the bio submission path.
 block/blk-lib.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 688bc67cbf73..5649e4d3b5bf 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -13,26 +13,28 @@
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
-	sector_t granularity_aligned_sector;
+	unsigned int remainder;
+
+	if (!discard_granularity)
+		return BIO_MAX_SECTORS;
 
 	if (bdev_is_partition(bdev))
 		sector += bdev->bd_start_sect;
 
-	granularity_aligned_sector =
-		round_up(sector, discard_granularity >> SECTOR_SHIFT);
+	remainder = sector_div(sector, discard_granularity >> SECTOR_SHIFT);
 
 	/*
 	 * Make sure subsequent bios start aligned to the discard granularity if
 	 * it needs to be split.
 	 */
-	if (granularity_aligned_sector != sector)
-		return granularity_aligned_sector - sector;
+	if (remainder)
+		return (discard_granularity >> SECTOR_SHIFT) - remainder;
 
 	/*
 	 * Align the bio size to the discard granularity to make splitting the bio
 	 * at discard granularity boundaries easier in the driver if needed.
 	 */
-	return round_down(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
+	return rounddown(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
 }
 
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,
-- 
2.43.0

