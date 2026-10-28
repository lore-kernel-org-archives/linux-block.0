Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205866;
	b=ruoq1bMVJLjxYFrm75Q4Btnz9d3KaisjWIYQ5Lxqr07jjtmzTIjtJvylpAevBastkD0/
	 3Afyvsn699/KrK1Shg/pQ4nvbc4y1fhKHDnIUBF1isrWy2NdCCoFMSkZ0R5TccGd5H0iL
	 Yb48TuyU+m7A1xRp7p4axSmPsAIhJ4DaVQTJBdMYK7sMN+mI/1KG72qren8WtwTPGBJkZ
	 ZEJABmn8GJFA4vuzFWvWLasf2kakZtK8AYLrAXJizAIJtqXmRDXBNzZupzSC2h5A++3mj
	 ZH8M8onxhmHY2BHMjKsf0XzwOv1a3r5sMkppcCBrBuOPesyi1rHM5D1yhWNVAUhZfDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LUt9/Q/OIdTLbIzXYXFwQ1UNUA+CWlgRnrTnlFKejJs=;
	b=kiM7PU/IADZOi1dx8LCYMin+ap1ioh23F/zeBE7u4y6iJk0eKtBjPpvTEK40SeaUZ93q
	 IRFXVtGjxKWKWWB6GogYS/nMeRCX3Ut/kQ60Z9KVXc8jh8aOKi7iROO49JUl/0zNmv9z/
	 ruskP0H4kpZv4SZRfDo2Zo8eB5z4BRyBYYUhLC3MrgL16lqjMaheIad665oQdA2krMAIV
	 fxuhk13mA2U5ctZnO5qWdnjIvM8cAtx5x5uYVejDP0ETw3QQolenW0xackPP2uJ1lw590
	 3EswHR5Cv5tNIdW7SEXZ8onZ84UaqIA4gRB2+EOVe5xdktq/APUKfRSZC4LlPGewGOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iRGml2Y9;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE3606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4FE3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iRGml2Y9
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8256106635eso661280a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205865; x=1793810665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LUt9/Q/OIdTLbIzXYXFwQ1UNUA+CWlgRnrTnlFKejJs=;
        b=iRGml2Y9fpAeQn7QZpD33LVMphN/u2hTihg3FxVvAQWkjKH1gjy7FKcTc3SxuCAOvl
         xvt5bY57WRkmG4MamVqmG7McaS4Sbv3DvILVCMgRPku4UiY+569gWf5HynkS8AFDlobF
         M1zKhBjxamaNMUBJehPlZCRl8fNsI0udBCbXNBcG4LVx1PfisoUIzCT0XpW7FDzdPtY+
         kSJS9T0uJaEaPmgYx+7rUniPrd1VIkeU/FZ6Dnr+9k7eTMleX02UeqBkmQvTHx0ab/7U
         SGFF+X2cs8VMYhJflrpjhzIv6mrMzdX/tV1boKcIWp6OJkr6PUA9zcAmqcOsVvsEyXJ2
         hwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205865; x=1793810665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LUt9/Q/OIdTLbIzXYXFwQ1UNUA+CWlgRnrTnlFKejJs=;
        b=ZNVQXB6803OaKB/NeUT+9BaS/hh5WcihJ30bYY3kk0QCxPx3QFGBdLqGtwOL3Oqrwa
         avSlzuQbtXLEmVwm1FIJC23LDt4klRq0r2d1fSCoCtRVX56Jq7nsYJXW0FAfHxq3DQnh
         yuNNaE2+kz7AVkh7PjFHJPt7QMFeARSD0U4cw30+lSQHXxPqPUbS6i64RP2uvMv4PXWQ
         PTC7aiEz2gjO6gHkM4aKnQeDLl5WeJyQhiY3lJ2MKC5xL7KORMPWQUatfBdtlvaQzRww
         j6i86/I9H6C1XmSZgAbhYTRsKkeKNbomFUuqZHMv5HoiQZR2Pe8837yi9HIcQH+TTgEb
         R9QA==
X-Gm-Message-State: AFq9FYLneeTllxHo885OEi5b6wNInpAaeq/wocq4RD8tiAkSycRBlxIa
	vnLKrELf6k7Wzsfo72mgpi6SFdOV03M5jV7l1WzGk3A82mtSIuJLiwD+pSrp14MuvXwo/BztRVd
	rMHp3PPE=
X-Gm-Gg: AYBFou1XPj+GvlSZz/Z6LQOm8YB2JIWqG0+XiFiTjNy2lpvSA/nEvlXhECmnj58TOEx
	KyIkVdDVhoGeS/Wri7hm4SnAMSJqObI2SAjTHpEnRoAlLuByit6ytkmp9/rP6/4FKFRr11hpkUs
	8HkN2iWp43Zy5KT5ioR1TZtzFXSchCeLqRL+t/gwOKXTnSqlfLGbA5xRFfpNh2cOYmJgZ0+VA/Z
	3SHpMULc2gFwZbT41PEuQPOECqflaquHwzCxA3dsGQbsJlS3Z+pFwy0pLpd5rNn8YHbKMaCec3e
	jySZlpDS8bNsd+ZhvXhcSbAiNr52pDZ7LmOT6cqkKnJbi9k8iIYHl9hTh+xxolVZpk0P8572Yo8
	4UCK88pcdoKoZxqOtvc2ievbs2MU4aB4A/2eqj6cWyC2SCnYqXahTX4qXt+MVPWpakWVF0xqMoz
	M6Uimrb3YMhRygYZsYrOl3Xzwg520rScZ1dbaryY7hbmbFHl5fTgqBtbOcTG+p+Sd1pSfyFpVt0
	ygYWWV732gNCzxAud61lvcQSdluUUWXYU0MUKWRNj0/ok77C/UrD+levCMZwjdVhDJWufM1axB5
	j7lxKuSvrVL+jwi3APXFAPMNoONbBOxHWN54168tH62HU7nVwkzbx4yYg/nmJAtzbTsiHf//Zw=
	=
X-Received: by 2002:a05:6830:4393:b0:7fa:5c68:d04d with SMTP id 46e09a7af769-85ac0ce9632mr2444282a34.23.1793205864683;
        Wed, 28 Oct 2026 09:44:24 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/98] block: don't lose the status of a failed flush request
Date: Wed, 28 Oct 2026 10:41:08 -0600
Message-ID: <20261028164415.1262013-6-axboe@kernel.dk>
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

flush_end_io() stores the status in fq->rq_status for whoever drops the
last reference to finish the flush sequence. blk_mq_put_rq_ref() calls
it with BLK_STS_OK from tag iterators and the timeout handler and
overwrites an error the real completion stored. With two extra
references, reading /sys/block/<disk>/inflight is enough for that, a
failed flush completes everything waiting on it with success and fsync()
lies to the application.

Only store a status that is an error.

Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-flush.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 403a46c86411..38bd4ae5d9e7 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -212,7 +212,13 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
 	if (!req_ref_put_and_test(flush_rq)) {
-		fq->rq_status = error;
+		/*
+		 * Remember the status of the flush for whoever drops the last
+		 * reference. blk_mq_put_rq_ref() gets here with BLK_STS_OK and
+		 * must not wipe it out.
+		 */
+		if (error != BLK_STS_OK)
+			fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return RQ_END_IO_NONE;
 	}
-- 
2.56.0

