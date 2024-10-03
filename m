Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253B12D1FA
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965036; cv=none; b=Z0k/lriWsezO004iAK8hV7Gp0hqOXDr2Q9I4/sZKG6lHKnEDCcrfEM47gIMCdaJ1b7ZBovIRrAFKjXVxDqwUyjCbMoT47MxeAD4VSLwjRgacC8DF3b04PBuWaR2y+7pnLgeLw4q/0APc+DsxwCh9lXNyhjecAwNzIurlTnDEyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965036; c=relaxed/simple;
	bh=gHAjhIpIOeUJHbAOojfrAXvUJGqyxiOvfwqFvRRxfgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTyE/iG/+XPaCQDUNvh4g67qfpGNHQhAcUm1OmICjnmkEMpSG/uEOgAbMFxFuozeUtN5knH+WABI6aADBfsW2kdrvExFY3R1K1Ef6JxouGMHOpKg63B2exFpulgmWJ7GzF7W+zRxRRGqgRS1yCbJa8iPMMVMKxXr77ehnJksQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z4lI+v5s; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z4lI+v5s"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db238d07b3so776484a12.2
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727965034; x=1728569834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nY8DUOxEIQESRM3K9M7xvE11dh819ZwIcVhYwQUWZKQ=;
        b=Z4lI+v5s9v/mBsMlL4RGa8BVsJdsxHb8Qf4m9m38LCriyn+imczyE2oGd7yH2Ctkez
         bSPqR7gyq+pXmpcFb73Cxl1ZKgzjq9jP+9ntxyskmwA0PtCEKLL3cmu5i1e8NMfFD12Q
         /C5C60ea47cdOhHyAoUoVgPkklACgKDbjL4ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965034; x=1728569834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY8DUOxEIQESRM3K9M7xvE11dh819ZwIcVhYwQUWZKQ=;
        b=fIODypkaP0wvcH0uhGiVInl7yUZPicR20WIwWvQ0O8xMsk8SAmPJVX4KjHhSllXNgD
         59Yk8hcYgTrK9qIdubqx3GfKplIBTJeUTSTiMeQxp/bFlu9nXhuzrj7aJb54nLm2fOUa
         t3SVUhcM4SbZrezGPsenxVv4wvLN6aOos7lCgoues3OYUdnbj0qJuVyub488r4QYztro
         V4kzOJfx5rpled4u3COAbEl6y5Xao63JLDIPOZY5RWFEBkkjN7vl1T4FeZ1/YBNq/hn7
         YFT8Gt7535FDqpp0YWH7qJfVwzQDsl65HxaZYqo1tU4lwWAIt87/2XcBGGYHkKisDxuP
         UosQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ev+iXL0On13uRIegruVRwc1E3g+8tv39Vlh/pyYHZb9TnN/j7uCnCTJerAgykGNrnsZKe6V3QUGl0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOnwWbJChvZ/ilSVOWTrxzryohrWLIHhjfWJv5eyP+lQ/Dq0HF
	MbIH58tk9TFV17l9CzcQos8gn3/4y7gDiM59ivTOF/ALaB5CQwrQLMvNN2uNTw==
X-Google-Smtp-Source: AGHT+IGUvOuLEO1DV/utG0RYTgEKqGUHXLTOcm7HmbY12ea9hGJydKB3qBvvZJ68s9VjAuZ4nZKjRA==
X-Received: by 2002:a05:6a21:e8a:b0:1cf:6ef0:c6b9 with SMTP id adf61e73a8af0-1d5e2d7c128mr10364205637.32.1727965033720;
        Thu, 03 Oct 2024 07:17:13 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6c:4e9b:4272:1036])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8c1c7sm1363003b3a.53.2024.10.03.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:17:12 -0700 (PDT)
Date: Thu, 3 Oct 2024 23:17:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241003141709.GN11458@google.com>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003140051.GM11458@google.com>

On (24/10/03 23:00), Sergey Senozhatsky wrote:
> On (24/10/03 06:43), Christoph Hellwig wrote:
[..]
> So that mutex_lock(&disk->open_mutex) right before it potentially can
> deadlock (I think it will).
> 
> My idea, thus far, was to
> 
> 	if (test_bit(GD_OWNS_QUEUE, &disk->state)) }
> 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> 		blk_kick_queue_enter(disk->queue);  // this one simply wake_up_all(&q->mq_freeze_wq);
> 											// if the queue has QUEUE_FLAG_DYING
> 	}
> 
> in del_gendisk() before the very first time del_gendisk() attempts to
> mutex_lock(&disk->open_mutex), because that mutex is already locked
> forever.

Well, just in case, the diff that I have (against 6.6)

---

diff --git a/block/blk-core.c b/block/blk-core.c
index 4f25d2c..470c910 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -304,6 +304,13 @@
 	wake_up_all(&q->mq_freeze_wq);
 }
 
+void blk_kick_queue_enter(struct request_queue *q)
+{
+	if (WARN_ON_ONCE(!blk_queue_dying(q)))
+		return;
+	wake_up_all(&q->mq_freeze_wq);
+}
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
diff --git a/block/genhd.c b/block/genhd.c
index 203c880..3ccc593 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -581,9 +581,6 @@
 	if (test_and_set_bit(GD_DEAD, &disk->state))
 		return;
 
-	if (test_bit(GD_OWNS_QUEUE, &disk->state))
-		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
-
 	/*
 	 * Stop buffered writers from dirtying pages that can't be written out.
 	 */
@@ -641,6 +638,20 @@
 
 	disk_del_events(disk);
 
+	if (test_bit(GD_OWNS_QUEUE, &disk->state)) {
+		/*
+		 * Set QUEUE_FLAG_DYING before we grab ->open_mutex so that
+		 * blkdev_put() -> release -> blk_queue_enter() can detect
+		 * dead device
+		 */
+		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
+		/*
+		 * Make sure that ->mq_freeze_wq see QUEUE_FLAG_DYING and
+		 * bail out, unlocking ->open_mutex
+		 */
+		blk_kick_queue_enter(disk->queue);
+	}
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6f67dbe..a49afe9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -854,6 +854,7 @@
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
+void blk_kick_queue_enter(struct request_queue *q);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(enum req_op op);
