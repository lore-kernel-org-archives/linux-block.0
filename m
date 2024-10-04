Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF791311B5
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028105; cv=none; b=ZDWnMg5KqvVPGfUWUMXlfJIdGN4EuKACt0GexSZpk8sONr0p30tG9HnA+TgbmP1owR1roBR9pGU+6l+yVIMNq+H6tSCqVzjCBDBKZ1RqGs+0rZYyP2LA5BwNapuVXKH8+qwU0StBq6zqXitXav/3303Q37sd2qZ2dYOW27tUHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028105; c=relaxed/simple;
	bh=g3l3qv3QRhYdFXARgqv6qP63pB8d1c4XSAm7xJF6fIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNxIJGGoONr5kgx9RN2cY8ynvdKxACfcDnMuYBMHhPfpFkhHt8XvOU5ZUP/nOGP8BgHbE88TANg3vjGWicc09W6BiUKqnv/DKOIipUlpp1YuPws6ZTqj7W9rFxK7GKQ3dADh5Zbkf6+u9bvenbUrkEYIEntoxIgr7vnLko7ewF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=buSfCye2; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="buSfCye2"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e1ba0adcb0so880237eaf.0
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728028103; x=1728632903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKRO7hm49rDFUKciww2pkRwEGH7ur0IfGc/J4xaBoqE=;
        b=buSfCye2e94PMr0VHLNKjWGHgqEnbtAcZF7ZoCnmxn9zoDSFh4hlC0qthgrdTeYnJa
         8fVvfa93J95P3iD2iCMmBWtnfrRSbSuuAzD9H+MUpRw+dbgpc5L2TBaS2B13UuBPKwWH
         8MH+gGy7SNSB98+2rLwqiNRE68lAb1+QXw7Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028103; x=1728632903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKRO7hm49rDFUKciww2pkRwEGH7ur0IfGc/J4xaBoqE=;
        b=eUA7XyJz1m9r7888EetQ1flK0FMgdFA301RzzeSbYnnQjJGArttTVmhj1fmkaX8wsx
         JYWaDrY3cwZ/fDntXJmCmJdEuNo/OBgGKFNav1jRFra4lNZnzkIf6nliBYczPQ2oVboY
         p7ek8K25Cr3LXm+7MrP4MEshao9kgK0xTHg5HOvW9pTb6tJIrgC6QuEgs43nuFrinjYS
         mNbUyzZvffBbS1Dqf9ht7AV7Go+PrjQ9s57Awqy9OgzNB4FTdzQXZUz0/s3/Ac76JLPh
         m4PgOTd/lvObHZ856AGLUDWI4KA0i8sKS51fW5Uf4Fop14Ovr0tjTLBBxx3qrg/4ox++
         DAdg==
X-Forwarded-Encrypted: i=1; AJvYcCVE0k3h8iZbLEahqfO0LgVbSyKODvB338hlzvOL9yk5Xo3Lh+vx+U54pxNTrIraszMA+7eJlh0raUeKOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh31V3+SIN1TA/Hh6d1EuBWSH/gAefCFfhVqmpdEu/WNmn+f8a
	NdBlv+z2WscgPMisIuNQbeQcVWUm4MFskAR/1cNSfJSlYg2Uyp+FrY/W0eP9UA==
X-Google-Smtp-Source: AGHT+IH6X7oUE5VJtsQMIz3kpIuaC/awBd4oxqob3SuOp9f9DAbVGsaxF4owWEXZps+KilelzqgHKw==
X-Received: by 2002:a05:6871:520c:b0:277:bc16:12c3 with SMTP id 586e51a60fabf-287c1dadd3amr1711996fac.17.1728028102895;
        Fri, 04 Oct 2024 00:48:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:17b3:dfd3:7130:df15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb13aa5sm1926352a12.38.2024.10.04.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:48:22 -0700 (PDT)
Date: Fri, 4 Oct 2024 16:48:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <20241004074818.GP11458@google.com>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
 <Zv-O9tldIzPfD8ju@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv-O9tldIzPfD8ju@infradead.org>

On (24/10/03 23:45), Christoph Hellwig wrote:
> Date: Thu, 3 Oct 2024 23:45:10 -0700
> From: Christoph Hellwig <hch@infradead.org>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
>  linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
> Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
> Message-ID: <Zv-O9tldIzPfD8ju@infradead.org>
> 
> On Fri, Oct 04, 2024 at 01:21:27PM +0900, Sergey Senozhatsky wrote:
> > Dunno. Is something like this completely silly?
> 
> __blk_mark_disk_dead got moved into the lock by: 7e04da2dc701 
> ("block: fix deadlock between sd_remove & sd_release"), which has a trace
> that looks very similar to the one your reported.

Hmm, okay, a deadlock one way or another.

> And that commit also points out something I missed - we do not set
> QUEUE_FLAG_DYING here because the gendisk does not own the queue for
> SCSI.  Because of that allocating the request in sd/sr will not fail, and
> it will deadlock.

I see.  Thanks for the pointers.

> So I think the short term fix is to also fail passthrough request here -
> either by clearing and resurrecting QUEUE_FLAG_DYING or by also checking
> q->disk for GD_DEAD if it exists.  Both of these are a bit ugly because
> they will fail passthrough through /dev/sg during the removal which is
> unexpected (although probably not happening for usual workloads).

You are way ahead of me.  Does the below diff look like "checking for
GD_DEAD"?

---

diff --git a/block/blk-core.c b/block/blk-core.c
index bc5e8c5eaac9..ccd36cb5ada7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -292,6 +292,16 @@ void blk_queue_start_drain(struct request_queue *q)
 	wake_up_all(&q->mq_freeze_wq);
 }
 
+void blk_queue_disk_dead(struct request_queue *q)
+{
+	struct gendisk *disk = q->disk;
+
+	if (WARN_ON_ONCE(!test_bit(GD_DEAD, &disk->state)))
+		return;
+	/* Make blk_queue_enter() reexamine the GD_DEAD flag. */
+	wake_up_all(&q->mq_freeze_wq);
+}
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -302,6 +312,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	const bool pm = flags & BLK_MQ_REQ_PM;
 
 	while (!blk_try_enter_queue(q, pm)) {
+		struct gendisk *disk = q->disk;
+
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EAGAIN;
 
@@ -316,8 +328,9 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		wait_event(q->mq_freeze_wq,
 			   (!q->mq_freeze_depth &&
 			    blk_pm_resume_queue(pm, q)) ||
-			   blk_queue_dying(q));
-		if (blk_queue_dying(q))
+			   blk_queue_dying(q) ||
+			   test_bit(GD_DEAD, &disk->state));
+		if (blk_queue_dying(q) || test_bit(GD_DEAD, &disk->state))
 			return -ENODEV;
 	}
 
diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..c213a0cf8268 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -583,12 +583,6 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 
 static void __blk_mark_disk_dead(struct gendisk *disk)
 {
-	/*
-	 * Fail any new I/O.
-	 */
-	if (test_and_set_bit(GD_DEAD, &disk->state))
-		return;
-
 	if (test_bit(GD_OWNS_QUEUE, &disk->state))
 		blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 
@@ -649,6 +643,12 @@ void del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	/*
+	 * Fail any new I/O.
+	 */
+	test_bit(GD_DEAD, &disk->state);
+	blk_queue_disk_dead(disk->queue);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..aaaa6fa12328 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -862,6 +862,7 @@ extern int blk_lld_busy(struct request_queue *q);
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
+void blk_queue_disk_dead(struct request_queue *q);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(enum req_op op);

---

> The proper fix would be to split the freezing mechanism for file system
> vs passthrough I/O, but that's going to be a huge change.

My preference would be a simpler short-term fix (cherry-pick to older
kernels are much easier this way).
