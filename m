Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E0CC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C1208E7
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="b2J0hhr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0C1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeK1UeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:34:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36149 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeK1UeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 15:34:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so1162259wmj.1
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDfUH+jAbWymQlV+srSqrYDaxKXexQ2PPMThtQxZGog=;
        b=b2J0hhr7yz1K1DPFJ59olW4x9IekN1WJsKzNFKzRGgl27lC/QRIZDTuYCY6fipO6BO
         5tqVcRH4vjq8XtpkWwGUHKh0HUmXOmMEiWfpN+G62R3oE8HV8Ae7fPUUBgSMg91Clrmw
         FPL3ZSyaEMTLDXgghdwKxdFgT77fbqYEDp6vfTYwazZhg5KPn9Dvytcyn4NXwgh69UO+
         iOh6r+i5SCK03w54lAKUQNaDyNWKkC5fnGriz1Kw9onOHEEMWbEDC/jDjnJXZpKFBYws
         mh23bffyh4uSke9P5jyAccZaD7U7qdgmrqUugzcXcH6aBmnl2sjt3mrXNNHZJeqjvQz+
         yZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDfUH+jAbWymQlV+srSqrYDaxKXexQ2PPMThtQxZGog=;
        b=D0G0bROdftgdBGUsk+DLOk8WDWSquCpyZfCz3WURSJhG7ex3LbciRjvzi1yxSz2uns
         Otq8YEhRKGJ95z8d6SrWPUtEO3srCVO6h2oJbvSUWnSus/Qy3XvF0L0wLCZZn4hrdDEQ
         yv/8ypFFgNWyDdJdzr/FTql3mxnCyNTw4QfaGC2/H37+oeM18kULQxRfEzpTAujd01wp
         0T8aB07rAp30g8wzKQZTBj2UOGY/6RlEVqSlxEQiDEKPrpbYZsZRfbIvENhDvLDLmlv7
         uQ2/NVFeN9j+ZOtr8wYzrYGQcwwwPRCQ0Jm7s6lT1UtB/uXxCviSJBrgY99FNox3zjBz
         ja0g==
X-Gm-Message-State: AA+aEWZPnXmCa/spvE4IoPczMOh6G6SZFLSO6/5E1i6snduQv9bbN/eL
        2GSVZ5PcymJY8YCHGmMvc6n3Xw==
X-Google-Smtp-Source: AFSGD/XTHGrYSwzhkn7OO+8iOousuTvHD9qyN6wo+YCOZMm0TF5GApDR7DLM+hBDdtO2I7Ox/arHJA==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr1903029wma.123.1543397587766;
        Wed, 28 Nov 2018 01:33:07 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id y145sm1285195wmd.30.2018.11.28.01.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:33:06 -0800 (PST)
Message-ID: <1b282e42a1573bbcba31bd628860b31ce9b60e5c.camel@scylladb.com>
Subject: Re: [PATCH 17/20] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 28 Nov 2018 11:33:04 +0200
In-Reply-To: <a58a7fd3-7994-0e30-40f7-f990a162205f@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
         <20181126164544.5699-18-axboe@kernel.dk>
         <69acea804eaf71f2d05b6ab649ecbf9bfd026447.camel@scylladb.com>
         <a58a7fd3-7994-0e30-40f7-f990a162205f@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-11-27 at 08:24 -0700, Jens Axboe wrote:
> On 11/27/18 2:53 AM, Benny Halevy wrote:
> > > @@ -818,11 +853,15 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
> > >  {
> > >  	struct kioctx_table *table;
> > >  
> > > +	mutex_lock(&ctx->getevents_lock);
> > >  	spin_lock(&mm->ioctx_lock);
> > >  	if (atomic_xchg(&ctx->dead, 1)) {
> > >  		spin_unlock(&mm->ioctx_lock);
> > > +		mutex_unlock(&ctx->getevents_lock);
> > >  		return -EINVAL;
> > >  	}
> > > +	aio_iopoll_reap_events(ctx);
> > > +	mutex_unlock(&ctx->getevents_lock);
> > 
> > Is it worth handling the mutex lock and calling aio_iopoll_reap_events
> > only if (ctx->flags & IOCTX_FLAG_IOPOLL)?  If so, testing it can be
> > removed from aio_iopoll_reap_events() (and maybe it could even
> > be open coded
> > here since this is its only call site apparently)
> 
> I don't think it really matters, this only happens when you tear down an
> io_context. FWIW, I think it's cleaner to retain the test in the
> function, not outside it.
> 
> > > @@ -1072,6 +1112,15 @@ static inline void iocb_put(struct aio_kiocb *iocb)
> > >  	}
> > >  }
> > >  
> > > +static void iocb_put_many(struct kioctx *ctx, void **iocbs, int *nr)
> > > +{
> > > +	if (nr) {
> > 
> > How can nr by NULL?
> > And what's the point of supporting this case?
> > Did you mean: if (*nr)?
> > (In this case, if safe to call the functions below with *nr==0,
> > I'm not sure it's worth optimizing... especially since this is a static
> > function and its callers make sure to call it only when *nr > 0)
> 
> Indeed, that should be if (*nr), thanks! The slub implementation of the
> bulk free complains if you pass in nr == 0. Outside of that, a single
> check should be better than checking in multiple spots.
> 

Cool. The compiler might also optimize it away when inlining this function
if the caller tests *nr for being non-zero too.

> > > @@ -1261,6 +1310,166 @@ static bool aio_read_events(struct kioctx *ctx, long min_nr, long nr,
> > >  	return ret < 0 || *i >= min_nr;
> > >  }
> > >  
> > > +#define AIO_IOPOLL_BATCH	8
> > > +
> > > +/*
> > > + * Process completed iocb iopoll entries, copying the result to userspace.
> > > + */
> > > +static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
> > > +			    unsigned int *nr_events, long max)
> > > +{
> > > +	void *iocbs[AIO_IOPOLL_BATCH];
> > > +	struct aio_kiocb *iocb, *n;
> > > +	int to_free = 0, ret = 0;
> > > +
> > > +	list_for_each_entry_safe(iocb, n, &ctx->poll_completing, ki_list) {
> > > +		if (*nr_events == max)
> > 
> > *nr_events >= max would be safer.
> 
> I don't see how we can get there with it being larger than already, that
> would be a big bug if we fill more events than userspace asked for.
> 

Currently we indeed can't, but if the code changes in the future
and we do, this will reduce the damage - hence being safer (and it costs nothing
in terms of performance).

> > > @@ -1570,17 +1829,43 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
> > >  	default:
> > >  		req->ki_complete(req, ret, 0);
> > >  	}
> > > +
> > 
> > nit: this hunk is probably unintentional
> 
> Looks like it, I'll kill it.
> 
> 

