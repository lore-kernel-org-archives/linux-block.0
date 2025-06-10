Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A823504C;
	Tue, 10 Jun 2025 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575190; cv=none; b=j7mxvFYPlUrkMHkB5O5vTEUuJdbjdEFYx9C/pbaG3hf5SCuciy8FIJV1sfI2HBs/asNHWq0vJZq2iCUrYTh4mldCk5J/6P3ULTj+iOxIwlF0PILu818utbW+oGCuQDgu0SsxpgG3hwV1M6SjlkQHPjRR5ilUbuwb/F7SU+j9Jpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575190; c=relaxed/simple;
	bh=NUXvYJH6T2JZjcLR74wX+Dfjzjbv1lF4uF8g2mNX8QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FytiJUATRUaGiYmRN8gPjTTywz9GvKIwtpiyGPWxxv4ns9CJ0c0JHdRjmXeTiY3yc2A3cAVDKd6mF01khQcsY93UhfT8DbJr2ScVfFHNNLtgGNWd/GEhx26euIb6Wwy0z5X+FUNfwMVI+hUopnGNzuHKyDpozFtdDtG7IIkmjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLpAdZrf; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLpAdZrf"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5353228276.1;
        Tue, 10 Jun 2025 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575188; x=1750179988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ruyBowyUQRTCl2+Gb9/lAn2W0Qctw5ABD0tXVfMl6E=;
        b=eLpAdZrfGX7rdKSxPa6o7SRs8+DFNv5OJsaVZxRH8NdQJ9+oSh+uKw79v90yh3bEEi
         9LQFqxDvHJ68p0x+CKvFTJH5ruEi+zWG2HSQ7oj5ehSL+5XLiV5NjBsCa7gWL71EuGSW
         U9dyszUCoAr0IEVmUL0IxU8wyipXHq8hvH4q30Yw3Wc3bPqghwxrswTR1guwPo3SGehP
         KcbukGzsEPo5KfsNTQhkNGXjF+eNp8aYUWbvvT2UNb1k5T5bodz82sdZAVU7jLpgz+rE
         vphFj/W2yiO/vNjn+6B7CHlIbqe8sAIlXNgRAWJWIiawUtaLKgPWROsU68gHXg8tZ2yq
         l7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575188; x=1750179988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ruyBowyUQRTCl2+Gb9/lAn2W0Qctw5ABD0tXVfMl6E=;
        b=hcWUM8mjNwAt768eC2pn1jHITw2B/tRh+1P5Tvvo8QcrhCpIS/2Pk0Tbhd8VaBD6uz
         QejElz1Nk81ejPo4KSOgXRoBdkNry+Zn/7dCHC/Tz5HhUVaKfEvozD8u9gcuwRsXYGeH
         yxa1FhoRu26kWM/iZfSRChXX0lUNmVJOi9LDdglIhY2zyYB1amTJD2Zdfsc94Gi8kos1
         zTAyGgDUmkD13OOtcO2ypVfWLRgs9D0Gz6gRU10S4wCGE/xZyIu+oi1Zewkfg4EW1Fw1
         vojPw1dsdkZR/o0qUSJ/szdurnqVtV6+p0PSGaMuzbdbLzA7tYZm0ht+lNgX3ETM7WBQ
         R48Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ9pTMRyH9ktWZpm/6YyYSNWm831KPXyPZq63FEQ8pQihz/rSX2X7fzunV+Me9RBosJMtJZXr9v5YbwMi@vger.kernel.org, AJvYcCVczVlSW++m2pjShLCGOqP2hzgtvNTtfZnGlGNaQaZl2hfEp3h3QbiNzKBWsN3hU9aISKK9hIhLgebxgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HyJ18izSpHoswTNWxjU2jP+T48E0mLD6XjvsVKsybTRDrCGM
	hf8pi7tBrp6I8rb42g09D13ZUTexV3lDYtl4tf+83/v9Otn708jupVunbn2aqtsP
X-Gm-Gg: ASbGncujcO4iDkUm5BpTsXVL9kRmpEt8EIztWT4QuueP8jLcoAE1sItQnXa6z7xCvvP
	P8IFWU6wGWmFDZuzOtqwMP42XQFkmpTLet+jj2E6ieGdJasvkTpxyuAUlFVKS0WqamHBqA9dloT
	69G6CCUHBKsFJnidvT2VQitx5tgqn2EFEsYdNX9VWR0jDIow4MR05tfZMiJhFw4Xt7zAG98yW2a
	ubyFMGGfdhfMaugMtiX8mwwdQZcxN2NOiIFPdkyfgye5ndtAPmbde9R14BI+uJ8G0A0x2VID2EN
	YguoTJPMtcPqJHnZhGAu/GDZett4TUz6wmLT/JRW7JDFuvnpmuxOwvPbcWYwnKRsqu6Mz3tcvzS
	oJF9rj6xiAVA/v504JeGOlEBi9cJPWhZsoJJgmJtlRJ0=
X-Google-Smtp-Source: AGHT+IGyh7d7I6FKjdyngjMjp5eG9hHAkNl0HKfBiAN0fbcCB9zb9jTNfApnNJtPgW5gEmE9c0jqJQ==
X-Received: by 2002:a05:6902:a84:b0:e81:b4ae:99e4 with SMTP id 3f1490d57ef6-e81fe70bf82mr500228276.44.1749575188051;
        Tue, 10 Jun 2025 10:06:28 -0700 (PDT)
Received: from archlinux.. (71-146-63-133.lightspeed.tukrga.sbcglobal.net. [71.146.63.133])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e81a4179ca6sm3001390276.42.2025.06.10.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:06:27 -0700 (PDT)
From: Justin Sanders <jsanders.devel@gmail.com>
To: axboe@kernel.dk,
	ed.cashin@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Justin Sanders <jsanders.devel@gmail.com>
Subject: [PATCH 2/2] aoe: defer rexmit timer downdev work to workqueue
Date: Tue, 10 Jun 2025 17:06:00 +0000
Message-ID: <20250610170600.869-2-jsanders.devel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610170600.869-1-jsanders.devel@gmail.com>
References: <20250610170600.869-1-jsanders.devel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When aoe's rexmit_timer() notices that an aoe target fails to respond to
commands for more than aoe_deadsecs, it calls aoedev_downdev() which
cleans the outstanding aoe and block queues. This can involve sleeping,
such as in blk_mq_freeze_queue(), which should not occur in irq context.

This patch defers that aoedev_downdev() call to the aoe device's
workqueue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212665
Signed-off-by: Justin Sanders <jsanders.devel@gmail.com>
---
 drivers/block/aoe/aoe.h    | 1 +
 drivers/block/aoe/aoecmd.c | 8 ++++++--
 drivers/block/aoe/aoedev.c | 5 ++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 749ae1246f4c..d35caa3c69e1 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -80,6 +80,7 @@ enum {
 	DEVFL_NEWSIZE = (1<<6),	/* need to update dev size in block layer */
 	DEVFL_FREEING = (1<<7),	/* set when device is being cleaned up */
 	DEVFL_FREED = (1<<8),	/* device has been cleaned up */
+	DEVFL_DEAD = (1<<9),	/* device has timed out of aoe_deadsecs */
 };
 
 enum {
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 50cc90f6ab35..6298f8e271e3 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -754,7 +754,7 @@ rexmit_timer(struct timer_list *timer)
 
 	utgts = count_targets(d, NULL);
 
-	if (d->flags & DEVFL_TKILL) {
+	if (d->flags & (DEVFL_TKILL | DEVFL_DEAD)) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
@@ -786,7 +786,8 @@ rexmit_timer(struct timer_list *timer)
 			 * to clean up.
 			 */
 			list_splice(&flist, &d->factive[0]);
-			aoedev_downdev(d);
+			d->flags |= DEVFL_DEAD;
+			queue_work(aoe_wq, &d->work);
 			goto out;
 		}
 
@@ -898,6 +899,9 @@ aoecmd_sleepwork(struct work_struct *work)
 {
 	struct aoedev *d = container_of(work, struct aoedev, work);
 
+	if (d->flags & DEVFL_DEAD)
+		aoedev_downdev(d);
+
 	if (d->flags & DEVFL_GDALLOC)
 		aoeblk_gdalloc(d);
 
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index edd4bae3b5a9..3a240755045b 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -200,8 +200,11 @@ aoedev_downdev(struct aoedev *d)
 	struct list_head *head, *pos, *nx;
 	struct request *rq, *rqnext;
 	int i;
+	unsigned long flags;
 
-	d->flags &= ~DEVFL_UP;
+	spin_lock_irqsave(&d->lock, flags);
+	d->flags &= ~(DEVFL_UP | DEVFL_DEAD);
+	spin_unlock_irqrestore(&d->lock, flags);
 
 	/* clean out active and to-be-retransmitted buffers */
 	for (i = 0; i < NFACTIVE; i++) {
-- 
2.49.0

