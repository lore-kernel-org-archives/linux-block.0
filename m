Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0A3C060C
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146843; cv=none; b=eox4cxTpSbzXkfoQ44rjDOuSBm5cYG03Oo4ywnUEs+k2TvgCTRPMzFRskUTYM3ONYSfvVf6NLR/6A6C8gSmGK6NBKjpQ8KF7YTuMoTxYWVjkmdgYkGP7xXxnWHhAm+RDGNLkq19PO/RLwYQ1Z76U0AHjPRZorG9WJLIa7Ssqy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146843; c=relaxed/simple;
	bh=64GYkBNAtE+BDFwDFkPtNvIvvoMh/YbkLtBo5cM1LEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxfo2jGSrOfDhUOfHO55L84/jnAFC8iU7b9oBcrhlzE1tRlETiHizuJLBt7JtVTwgYoTGcjgxv46uvNeoA5YxJhU9YfynelwSl4jV1vOENC9CvfbNse8pEbnOU6HIAg4o9kryTzAkAvFUBcplGqHaMAiUEba9g9Lr9THhIxH324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nLL0DtLX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLL0DtLX"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9ec9443c2so10412615ad.1
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778146841; x=1778751641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GHLHxbWZMeODD7NZR/2u5e4BofCNB2jQY/FhKfcUTY=;
        b=nLL0DtLXXmO8zJyC1JE+QIM3Fv9sIfvg9Hh/3vc6A/bJAqpJ2gvpGt09V0N58esQCx
         H0LPqKOPX5sBhCUqrWz86QtMh2+T5OaI4wZWF+63yxA/7yS6kS/cOUZlECQBPAJatzpH
         Q+hu8wmDID+jsXkq/GjWToiArpdYLKN6kBa0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146841; x=1778751641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GHLHxbWZMeODD7NZR/2u5e4BofCNB2jQY/FhKfcUTY=;
        b=dJWmRGKIav0gvYJoPXYLfopbhviqgPMbPgTMxOJwU0oLxk+8Gybs03LToolmEBG4R4
         yOczgdR85mXAYzMWbelmwsMhq4T8nZl+k/D1A51vTj8yLE5hkOLd/ABmtZph1YavhdYU
         ZLa6uhFLZ2XaeXsBMZM8tnPlbSfP+nJW6hcj/Y9OUsJQ8Ip7fvK6SjPRI7k1lH6+eOi+
         ytNqnBg5k6EeizswSx3bczqIF0795EK9Lld9XiNsYHiCsoELHMBwvHbntSbPASCR/v3t
         oWcjh5YQu4SdED4NbJd0E00f/qcKKrJmMxXs61nwM0QGHqxKwvoVpW72TgEdu1IFl+xl
         lNzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SuoRoicQYXAZLdvDiDVAJhH+Exc9w5U26jh+ybGua5Q5S3ULlQuaJRgGWgsIjG9geDC6OUP6MMpfrIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0or2geOnXbz4+iE+N1tuIKPO3Ei9gvb0RMyqkvImnQN5urSQt
	OvTKuS8njPJUreRTuiLU2YHPb8F1a+iSqD9lXhNkuf/Tca6ZEHgxSV1XzKprx7sCeA==
X-Gm-Gg: AeBDies9Pu6o/vUbwEMCP+dZECCl70a3yb90F/reReeWAICMCWaLGKoXcx5MRmvxq0S
	2fKh3MC0prQtV4iB+hOaW1d008X4vyNY2RgBp0URkd2KBEtFzT5ANcrtCQKGfySADB50AbPM0us
	jOSnmOxO/EdvSMh8dwRe28m0idYYpDrfqasT8jln1R/fUag7OWP09VB2svIDw2wLuNZMm21H3Iq
	vsso0xwuM6YIwzmuDXTEOvW7Y0hfUKQd5Y/lpj/Q4IuzffJPbn8vdQnUXCrVG7874dwnMrf7H+D
	8WEoLzuKBUrz3m8cPbRYbhjQvOmz5WHesJHHtFgjANClYZY384UNNfJJkn6bfTARz0Lmc3euNlr
	O7syK8vSK3Er7mLchvZbGNL/OZZ9rgj4Lc/eUMJkGQDLjwkcK+k9loTAyT3mHeT44Nz7SuMMk3O
	vpiM1KBvTLQ8IVGxZPjaBNNb8m2LHrTxVB0p3ka/AoBvrO+bdifW6maarjB8H5wnxMDlme0fPK3
	w==
X-Received: by 2002:a17:903:28c:b0:2b4:64cf:e8f8 with SMTP id d9443c01a7336-2babc859054mr19200625ad.2.1778146841053;
        Thu, 07 May 2026 02:40:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7ba2:1dc2:ed3e:1484])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaac3576sm20701395ad.4.2026.05.07.02.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:40:40 -0700 (PDT)
Date: Thu, 7 May 2026 18:40:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Richard Chang <richardycc@google.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, liumartin@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_writeback_endio
Message-ID: <afw2919RiZje9xzq@google.com>
References: <20260504123230.3833765-1-richardycc@google.com>
 <afoc5qLvK2PDQKb-@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoc5qLvK2PDQKb-@google.com>

On (26/05/05 09:37), Minchan Kim wrote:
> > @@ -966,9 +966,8 @@ static void zram_writeback_endio(struct bio *bio)
> >
> >  	spin_lock_irqsave(&wb_ctl->done_lock, flags);
> >  	list_add(&req->entry, &wb_ctl->done_reqs);
> > -	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
> > -
> >  	wake_up(&wb_ctl->done_wait);
> > +	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
> >  }
> >
>
> I agree this will fix the issue, but using a lock to extend the lifetime of
> an object to avoid a UAF is not a good pattern. Object lifetime shared between
> process and interrupt contexts should be managed explicitly using refcount.

->num_inflight is a ref-counter, basically.  The problem is that
completion is a two-step process, only one part of each is synchronized
with the writeback context.  I honestly don't want to have two ref-counts:
one for requests pending zram completion and one for active endio contexts.
Maybe we can repurpose num_inflight instead.

> Furthermore, keeping wake_up() outside the critical section minimizes
> interrupt-disabled latency

So I considered that, but isn't endio already called from IRQ context?
Just asking.  We wakeup only one waiter (writeback task), so it's not
that bad CPU-cycles wise.  Do you think it's really a concern?

wake_up() under spin-lock solves the problem of a unsynchronized
two-stages endio process.

> and avoids nesting spinlocks (done_lock -> done_wait.lock), reducing
> the risk of future lockdep issues, just in case.

I considered lockdep as well but ruled it out as impossible scenario,
nesting here is strictly uni-directional, we never call into zram from
the scheduler.  Just saying.

> It definitely will add more overhead for the submission/completion paths to deal
> with the refcount, but I think we should go that way at the cost of runtime.

Dunno, something like below maybe?

---
 drivers/block/zram/zram_drv.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ce2e1c79fc75..27fe50d666d7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -967,7 +967,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 static void zram_writeback_endio(struct bio *bio)
 {
 	struct zram_wb_req *req = container_of(bio, struct zram_wb_req, bio);
-	struct zram_wb_ctl *wb_ctl = bio->bi_private;
+	struct zram_wb_ctl *wb_ctl = READ_ONCE(bio->bi_private);
 	unsigned long flags;
 
 	spin_lock_irqsave(&wb_ctl->done_lock, flags);
@@ -975,6 +975,7 @@ static void zram_writeback_endio(struct bio *bio)
 	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
 	wake_up(&wb_ctl->done_wait);
+	atomic_dec(&wb_ctl->num_inflight);
 }
 
 static void zram_submit_wb_request(struct zram *zram,
@@ -998,7 +999,7 @@ static int zram_complete_done_reqs(struct zram *zram,
 	unsigned long flags;
 	int ret = 0, err;
 
-	while (atomic_read(&wb_ctl->num_inflight) > 0) {
+	for (;;) {
 		spin_lock_irqsave(&wb_ctl->done_lock, flags);
 		req = list_first_entry_or_null(&wb_ctl->done_reqs,
 					       struct zram_wb_req, entry);
@@ -1006,7 +1007,6 @@ static int zram_complete_done_reqs(struct zram *zram,
 			list_del(&req->entry);
 		spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
-		/* ->num_inflight > 0 doesn't mean we have done requests */
 		if (!req)
 			break;
 
@@ -1014,7 +1014,6 @@ static int zram_complete_done_reqs(struct zram *zram,
 		if (err)
 			ret = err;
 
-		atomic_dec(&wb_ctl->num_inflight);
 		release_pp_slot(zram, req->pps);
 		req->pps = NULL;
 
@@ -1129,8 +1128,11 @@ static int zram_writeback_slots(struct zram *zram,
 	if (req)
 		release_wb_req(req);
 
-	while (atomic_read(&wb_ctl->num_inflight) > 0) {
-		wait_event(wb_ctl->done_wait, !list_empty(&wb_ctl->done_reqs));
+	while (atomic_read(&wb_ctl->num_inflight) ||
+	       !list_empty(&wb_ctl->done_reqs)) {
+		wait_event_timeout(wb_ctl->done_wait,
+				   !list_empty(&wb_ctl->done_reqs),
+				   HZ);
 		err = zram_complete_done_reqs(zram, wb_ctl);
 		if (err)
 			ret = err;
-- 
2.54.0.563.g4f69b47b94-goog
