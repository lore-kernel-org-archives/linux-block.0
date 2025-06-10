Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582BD230BF5;
	Tue, 10 Jun 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575189; cv=none; b=rX8kdWXKaFyn6BnqTYi2WGv/t8HxLcDm4nDtotSKngvZBAcY1RRCDRllXJsKQ43nM0pv/eWzPWx0xCRANgHGU5gP8Gj9MptcOCSGFABM5Xx8hQYi0/92eIbsC0W6PN5OHNNYlgE8AIxdzlAe4xLxnSK/ywtw0DhioHKK0dSLo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575189; c=relaxed/simple;
	bh=mP4gb3dWFWly+mPtgYAQn/d03wKupUZ4N6Pl0+DbPfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTJa41Iadyk/SnoUXIg3kYuR6tBV696B0BVbKizTkvva3Mpba4WuHuzNfUlnaSHE0K+6dQWlN79FuPpcvjdHPM1efCZt1peuHXyS3hxeJGTpsxRg/C5CpCeGuKovvU7jM1ugyY4XuEjGip91TbZFGA2cS9uykw5WKffSbX4va0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWCLAWIO; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWCLAWIO"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso4935036276.1;
        Tue, 10 Jun 2025 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575187; x=1750179987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRHFfN327juvheBTAFy/tSemDTmbHfrjHgV9Lv1ygdo=;
        b=GWCLAWIOvUPq8oxkpE5qxfr7gHx8645uhx69GrcCQv7kfk5AduIKbRGDUOYy/hoXtX
         vHRCESV5nGMeg1qIkzUlbeBj1MuCcZdZRx8lAdKm3qdQu5HN0ER4e9mnLeRyg5PiZo8b
         VjZbzDBv7mJnLtP6st9BbJ+quRktLwoCBlEzgIb0nXt/qwEqis8ZGsXAPATiwyXGNymN
         zQHZJxjZt3ni+uQV8hxKIjhkpmGljA6I6GFsw/2cmb0hYAKbh2L6pjT7xTdYMgQJiRbB
         jzWKXAVo0wbeDXpx3Dp3OLGHuWSRDgnakplIlwAU5t2w5J4T5QSQePGPRgU+gqBt/bdD
         XSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575187; x=1750179987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRHFfN327juvheBTAFy/tSemDTmbHfrjHgV9Lv1ygdo=;
        b=DDFMuAU0HbqwlsxXXupH3cUO9ZevPmxtB3OOidf8mKS0RTEU6+Bo2wELNarVmBN7le
         ZN9Y2CadxhJyfQxHfFNIuZT1f5uUgX8XLF5AzZ3B4CeX/Lbtg0uL5uRuIKuPmviYvuOZ
         Dc16q8qNNpVD2bITuQJcWO7Nbq2LsFSjqihjAOvy9OdJqEbaDfNvGbT8vCj77KJPx1sN
         Ux3NKyedvqiw62w/ZR2sv6UFsURWf1WChTy7TbetuAVBCVlJI4dmZn+KD54pC6TgIlhU
         TAJwb78h5d16br0l7e8YYbwi/qmM+RFUXRUiFzcohd/dXVHvvhLshFjfrPMWpSf6g6Sn
         XAJg==
X-Forwarded-Encrypted: i=1; AJvYcCViij6M0ofwFnxDe1o5DbQ5Pn6jXDgolwI286HUcPgimcbWp6AZ5747AS9fEl+XJq2iHWR1K3QciorSuNNo@vger.kernel.org, AJvYcCWztCDVlHozXqsthycdlCxwx3xXNKJbe+3gm+P0Vikb7VuLEa72OJymzgd8+C5l8/3MqyjTfv2SgyhpJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygNiFNEAFavWRS9OrPQfzMxMWa1yF4NSJVtLcWatwUrgPMDrhL
	F92IjxxVL6Xwchvczu5hiIE70HMz8nQlm0OueJTOPxYa69WLAPUozNMSfLBZZHYA
X-Gm-Gg: ASbGnctjUWwcEi++p/gSkEw/3S0xEY3Osalkyzj2BHRddKmF/J1hbm6lSEiA1zqqACG
	zywLqjOJfq6c7qyPzhtj6Cjk4JznZvJ5RQci0qgnJvrohdTFwFFURpG02MTqX6DMpCPraZWZIpw
	z/kRT3RkqHjHbfObO9nLEEMpVAjfCRaosfgTKhBM/UbDKxgAKVUN5OpoCBQ2P0T5V5IkNI9Mpm2
	2z6g/uxRTU6ajwt8nj1VejS8MWNNOKZjfmg3/sYY1mdHuYDPt4RlrwBRkveAvNn+R7eLrAWJUwq
	er5tvR6ceDFEebMqexg/340lV4NxaeHtTfTEJkuSIakJaxU/Q5XZjJMhqqQHga2Cm9zyPZIGpGR
	H4yxSH4Cjg5RC8yxcCFkD14lcHT4dke1fXNzcs0PezLn5vF1onT+/dA==
X-Google-Smtp-Source: AGHT+IFXmLRSWgTCMuTvF8E5lZNN3DKvVkRsTwGOv0u4BOG3Xoi8OXw1S716YEpLjRjhRyhvezHX/A==
X-Received: by 2002:a05:6902:cc5:b0:e81:f2c1:6292 with SMTP id 3f1490d57ef6-e81fd960379mr555096276.18.1749575187358;
        Tue, 10 Jun 2025 10:06:27 -0700 (PDT)
Received: from archlinux.. (71-146-63-133.lightspeed.tukrga.sbcglobal.net. [71.146.63.133])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e81a4179ca6sm3001390276.42.2025.06.10.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:06:26 -0700 (PDT)
From: Justin Sanders <jsanders.devel@gmail.com>
To: axboe@kernel.dk,
	ed.cashin@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Justin Sanders <jsanders.devel@gmail.com>
Subject: [PATCH 1/2] aoe: clean device rq_list in aoedev_downdev()
Date: Tue, 10 Jun 2025 17:05:59 +0000
Message-ID: <20250610170600.869-1-jsanders.devel@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An aoe device's rq_list contains accepted block requests that are
waiting to be transmitted to the aoe target. This queue was added as
part of the conversion to blk_mq. However, the queue was not cleaned out
when an aoe device is downed which caused blk_mq_freeze_queue() to sleep
indefinitely waiting for those requests to complete, causing a hang. This
fix cleans out the queue before calling blk_mq_freeze_queue().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212665
Fixes: 3582dd291788 ("aoe: convert aoeblk to blk-mq")
Signed-off-by: Justin Sanders <jsanders.devel@gmail.com>
---
 drivers/block/aoe/aoedev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index bba05f0c5bbd..edd4bae3b5a9 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -198,6 +198,7 @@ aoedev_downdev(struct aoedev *d)
 {
 	struct aoetgt *t, **tt, **te;
 	struct list_head *head, *pos, *nx;
+	struct request *rq, *rqnext;
 	int i;
 
 	d->flags &= ~DEVFL_UP;
@@ -223,6 +224,13 @@ aoedev_downdev(struct aoedev *d)
 	/* clean out the in-process request (if any) */
 	aoe_failip(d);
 
+	/* clean out any queued block requests */
+	list_for_each_entry_safe(rq, rqnext, &d->rq_list, queuelist) {
+		list_del_init(&rq->queuelist);
+		blk_mq_start_request(rq);
+		blk_mq_end_request(rq, BLK_STS_IOERR);
+	}
+
 	/* fast fail all pending I/O */
 	if (d->blkq) {
 		/* UP is cleared, freeze+quiesce to insure all are errored */
-- 
2.49.0

