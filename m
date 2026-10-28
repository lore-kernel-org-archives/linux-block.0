Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205871;
	b=rfLyddvOEm1jra4TRXf8WpC94i3bPGCRcsdS8SYn7RcmIe3kzZ0YE7zQZBjErQeiNvP1
	 ZEOygg5UruIdApG68VH9EKQEncmnFwv7uB+NrRQTQghiwL/Y42btHHRjQOAMDmofze9RD
	 8d2ppi3zvvhPUf7EHe6oK5Vn3p2sNx8mv4fGxMB0kAMcOo7Vh2OMw7+tC2+uFhzmXLr2k
	 XmlJMyNF3QBZAsivVRqpgYMjRquSXrsU4IFPMek0f9lvTP3OerlG9vT1KsvXTZQaxs/8V
	 oIGfI0FN7cm074FqanMpTPrOJCoDNegh0xhk1MloftI8dbtvacEJ286BCk1WKvq1OLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t4+NbeWkC9oel3/0qXrXhmz86DjUc+DPRgOkppqAmrQ=;
	b=kVCPXsz1vVjCrX1lsxJTHU9LdVFj2AId0RZF0Bgw3BOyDZfmmhDMi1AAwzDysDUGHar1
	 RtThou5tpbaQKlTxO67S3uas+3WUyOo9tQLxPTB2pd3nPnApyyl7A72THqNMlwHiG1gU3
	 Ct3cjd2hJElD/noFOhtOl8cGeKSSrSJVdyClBuPETRBNq2Y3jWhuFMFG/W3wsqWVW9DN8
	 9SJVVeLXET+oVQOdDRxD3TfvTQGNl2p47VOhd3ehZyCs3W30rwmkjmAJZWuw6EJx0KYNp
	 zycPVAsw0Oz7Dz5OxCXymRpCnqH6CwdkoJa9J56DxAn8rZE6jBkzEbriMCz8mBsHVQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HIiukBCq;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACD606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EACD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HIiukBCq
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-70b875f6f1fso945804eaf.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205870; x=1793810670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4+NbeWkC9oel3/0qXrXhmz86DjUc+DPRgOkppqAmrQ=;
        b=HIiukBCqtTXUS3418/J9wNqH3uCaAj4HZoem7P/pu6Uc6QbbEohTZly/kieqi/bF9z
         Gvwl28/8CLZbis8M2JbYdXefzyshW9SMzFxuPnDqvEqscb7IVdiiFbauyLWpbzlhQ9Bj
         7Bd8vhfavznMlcwsMUak4/XRe+V+64UVLK2asZ/IP18nShqiUq3OU0jafWcOJRek0D4Y
         LOknlIskbdmMNt8Syf2YV8MVS6nCv8yZPJAvFvGLRNFD2zaLFESEb7my4UBSmGNtJDMe
         Lxk9opN/adtckkaS8Shdx2d1eujW73UeRsEwXrdB9uGQsFgRTDcAJnmVQBQU2CSUfV1D
         ezIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205870; x=1793810670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4+NbeWkC9oel3/0qXrXhmz86DjUc+DPRgOkppqAmrQ=;
        b=GyTYnN8/afEqTwCC2gFXVN9Th9gg/AjtpDSjUrW6JIfx/nxyZe/MUyz1v9C2XBUsyR
         EhfUq6odgr1hBMQfopTEBrL1HEZIXWKPhdXKxa1Cx7qZ+aHKyfQ3Zaa4G/v2xH+KgIZ9
         ky7kTya3liznWLZhzGkr7CU0JSV/AZtDh0NWboovA6KcY1b4FMw2DdXEO6R/vavp7caL
         DUlR/3fM/tyY6CSY5jBJjeWB04H3oho1L7rjbHhWsBLJbXu0mkr25/83izR5ApLsKGl+
         U6u9SJkeI5iWjvpmt2hjd28KD4ltfK1hZw3whNhXFhDPTO6kbw6wxizh5aytfujpIfec
         EIyw==
X-Gm-Message-State: AFq9FYK09zn+cfVxjZs2gZJH5aTgub/0MlfXx49zc18QamHfVBNjuvnm
	vjEKRbjCIoW2nXARVxco7SgxzAQRyzczrJjvr1fwxDH3cna6p7/tqvTQS3iVvdGdgCo5aNbP+a0
	iPhE93e4=
X-Gm-Gg: AYBFou3yYpcyOe9nC+jJh25d/yiD748OIU4b0hPYU6tQZMRhrkps7Zrkg/UGTqKgPHx
	+foXvly9t5HNQ42rVenKZIrM+XAT1AGzKi4xiPwYwtFhofW15MN9GffaSYLtWYS2fOjmAy07gXO
	QGwi8BgDplA/PkeOnAw5beOZvXcifAHL4zMVcf9VmrRINvvceV24Iec4I/PTAyzdmw15C9WSaYE
	4TO0R65GHiYYgtAIEL+IWsNy6F8vduOhJq5vSkxxlALtVccXjru0b9zWBpL/oGRGClmkLSw0xUg
	ldz6vRl8z/wxhfgSWFVcScoHH/hx2d7VK9Yv7jvn+ZqR8zWsx//N3iGC4Bth8JqoGsPehQAXY9i
	UCMtT8wNq14qt6bYO11/xKv+qrWbmgh3oAh9rG448cHJzyLvSMsbL8f7ufufE8TWYjQbgXjFVyf
	mP/dCwrfejKGyyfR2RkgMC4WwD0tBaJYtum4RVSbiA+J6pyD2F8tM/tDRyEtgPS4OI+WLzyvHmM
	GeXhg+IXASiiTYP1j8Zixl6vacTrpnCao0CAhMbgySPgLAEUGwi4FEWtCHVbSX78HWyxj7HFuEu
	JDqQNmQd7t6GsoahTYqcvstTJ34gQdGHALZ8XQYYkdnkoxcuyoZDSj63mMxdwy97kiyG4GoUDg=
	=
X-Received: by 2002:a05:6820:162b:b0:70a:4053:52dd with SMTP id 006d021491bc7-713eaf5ae18mr1853763eaf.12.1793205870082;
        Wed, 28 Oct 2026 09:44:30 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/98] blk-mq: end the request if getting a keyslot fails
Date: Wed, 28 Oct 2026 10:41:12 -0600
Message-ID: <20261028164415.1262013-10-axboe@kernel.dk>
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

When blk_crypto_rq_get_keyslot() fails, blk_mq_submit_bio() ends the bio
by hand and frees the request. By then blk_mq_bio_to_request() has done
the IO accounting, which blk_mq_free_request() doesn't undo, so the
in_flight counter never drops and iostat shows a device that is 100%
busy. If the bio went through zone write plugging the zone stays plugged
as well, and every later write to it waits forever.

Use blk_mq_end_request() like the dispatch path does for a request the
driver rejected, after marking it for zone write plugging.

Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7400f678258e..c91306f8156f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3195,8 +3195,9 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
-		bio_endio_status(bio, ret);
-		blk_mq_free_request(rq);
+		if (bio_zone_write_plugging(bio))
+			blk_zone_write_plug_init_request(rq);
+		blk_mq_end_request(rq, ret);
 		return;
 	}
 
-- 
2.56.0

