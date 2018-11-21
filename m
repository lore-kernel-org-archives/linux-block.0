Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B984FC43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744BA21479
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="BF2shX7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744BA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeKVA0J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:26:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45141 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeKVA0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 19:26:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id v6so5758124wrr.12
        for <linux-block@vger.kernel.org>; Wed, 21 Nov 2018 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r+8PhuaifMwYOPCFAjIlDkKdgTPxlArn6WdDAR1ExYk=;
        b=BF2shX7EeGeIDF7mw8rF8rCjKOFRh4N7XArmKJtqOMO4yX6Us73Hi79fx+AJU9S8NE
         lsCyWxUesIav0mzToBldtpYc4maOzTlsZivEUbfBIfOIl/UwumLte6n6Q9W2YjcHZFgY
         ru9nHSCcFl20916zxc2FiyTAXnQ/X48RqLkXSyoWGri9YoHCpVZC83IykHfef8cju+8L
         5llwfHlLv9KLC/CtRHWcl7jLVCGMRS0FuL8QV969bYV+bFVQjspfAmyrj5P0QttRycco
         5VUQ9Fi12XArpOHIKaY8adbrhpVrD/FDmWeBEjPvsuAy5q9Taly6Su69ykH8aQBJiJLe
         T78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+8PhuaifMwYOPCFAjIlDkKdgTPxlArn6WdDAR1ExYk=;
        b=HFwbyutpTKIwVNS83xgSGSXF2byvBuwhNCk9+iFXisCxJzsAfxWwuvuGFKvV3U3b0j
         7oC4NtDnz8AEpr4p6b+SX9C8gKJDzpAY3EtMIFMKp/ZkYgzEZwpJNS8Ov8e0KxPkHp9j
         TKCSvqOQRpNvgih3QDHFjYAp3HuNqlu+OacLPmFumSbiaDCfPcv7l2aqSR4kRY4un5HA
         Fg9C7TjFr+HBubxzvLL0q+sCmKqEBAWcFOvnDY+Ie3Z9HzLGZzgbeBbfsIEgzxx8J+S0
         zWTHmG0IrN4+wD0KjSKiZ+/t3DkBPad3p96h5bUwnCZleyuCyf+RSKkAMK5c1UDM65WP
         AoDQ==
X-Gm-Message-State: AA+aEWbywf2kHhJMNYg2vW35ag4679cL50KY1iy5Deyjg7i/7K1nPun9
        h0bF6aZ8Qq0jLzVo/20lOjsvNJwpVRo=
X-Google-Smtp-Source: AFSGD/WfkVMhrlQVzBgFfZR+J/pxIAn40p0uZaiHEUxbwoLhdeL4kGKzAQ/Ko9DjPrT/IegzK8Al0Q==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr6045392wru.152.1542808297200;
        Wed, 21 Nov 2018 05:51:37 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id t82-v6sm1477629wme.30.2018.11.21.05.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 05:51:36 -0800 (PST)
Message-ID: <50ff9c208503fe9572a3c76a9d2f74de2da43020.camel@scylladb.com>
Subject: Re: [PATCH 8/8] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 21 Nov 2018 15:51:34 +0200
In-Reply-To: <eb9d0381-eeaa-a67b-ea30-43525ee1fc3e@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
         <20181120171953.1258-9-axboe@kernel.dk>
         <c3066246445a9f303d3d46f6a3274944093e78e8.camel@scylladb.com>
         <eb9d0381-eeaa-a67b-ea30-43525ee1fc3e@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-11-21 at 06:26 -0700, Jens Axboe wrote:
> On 11/21/18 4:12 AM, Benny Halevy wrote:
> > > +#define AIO_POLL_STACK	8
> > > +
> > > +/*
> > > + * Process completed iocb iopoll entries, copying the result to userspace.
> > > + */
> > > +static long aio_iopoll_reap(struct kioctx *ctx, struct io_event __user *evs,
> > > +			    unsigned int *nr_events, long max)
> > > +{
> > > +	void *iocbs[AIO_POLL_STACK];
> > > +	struct aio_kiocb *iocb, *n;
> > > +	int to_free = 0, ret = 0;
> > 
> > To be on the safe side, how about checking that if (evs)
> > *nr_events < max, otherwise, return -EINVAL?
> 
> Good point, I think we should re-arrange the loop a bit to move the
> check up at the top to guard for entries == max at entry. I've done
> that.
> 
> > > +	/*
> > > +	 * Take in a new working set from the submitted list if possible.
> > > +	 */
> > > +	if (!list_empty_careful(&ctx->poll_submitted)) {
> > > +		spin_lock(&ctx->poll_lock);
> > > +		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
> > > +		spin_unlock(&ctx->poll_lock);
> > > +	}
> > > +
> > > +	if (list_empty(&ctx->poll_completing))
> > > +		return 0;
> > 
> > Could be somewhat optimized like this:
> > 
> > 	if (list_empty_careful(&ctx->poll_submitted))
> > 		return 0;
> > 
> > 	spin_lock(&ctx->poll_lock);
> > 	list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
> > 	spin_unlock(&ctx->poll_lock);
> > 	if (list_empty(&ctx->poll_completing))
> > 		return 0;
> > 
> > Or, possibly...
> > 	if (list_empty_careful(&ctx->poll_submitted) ||
> > 	    ({
> > 		spin_lock(&ctx->poll_lock);
> > 		list_splice_init(&ctx->poll_submitted, &ctx->poll_completing);
> > 		spin_unlock(&ctx->poll_lock);
> > 		list_empty(&ctx->poll_completing);
> > 	    }))
> > 		return 0;
> 
> I think the readability of the existing version is better.
> 
> > > +	/*
> > > +	 * Check again now that we have a new batch.
> > > +	 */
> > > +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	if (*nr_events >= min)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * Find up to 'max_nr' worth of events to poll for, including the
> > 
> > What's max_nr? You mean 'max'?
> 
> It should, corrected.
> 
> > > +	 * events we already successfully polled
> > > +	 */
> > > +	polled = to_poll = 0;
> > > +	poll_completed = atomic_read(&ctx->poll_completed);
> > > +	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
> > > +		/*
> > > +		 * Poll for needed events with wait == true, anything after
> > > +		 * that we just check if we have more, up to max.
> > > +		 */
> > > +		bool wait = polled + *nr_events >= min;
> > > +		struct kiocb *kiocb = &iocb->rw;
> > > +
> > > +		if (test_bit(IOCB_POLL_COMPLETED, &iocb->ki_flags))
> > > +			break;
> > > +		if (++to_poll + *nr_events >= max)
> > > +			break;
> > > +
> > > +		polled += kiocb->ki_filp->f_op->iopoll(kiocb, wait);
> > 
> > Could iopoll return a negative value? (Currently not in this patchset,
> > but would it be possible in the future?)
> 
> That's a good point, I've added a separate check for this. Given that
> it's a regular fops handler, it should be perfectly valid to return
> -ERROR.
> 
> > > +		if (polled + *nr_events >= max)
> > > +			break;
> > > +		if (poll_completed != atomic_read(&ctx->poll_completed))
> > > +			break;
> > > +	}
> > > +
> > > +	ret = aio_iopoll_reap(ctx, event, nr_events, max);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	if (*nr_events >= min)
> > > +		return 0;
> > > +	return to_poll;
> > 
> > What does the returned value mean?
> > If the intention is only to return a value greater than zero,
> > how about just returning to_poll > 0?
> 
> It just means that you could call us again, if > 0, and < 0 is an error
> specifically.
> 
> > > +/*
> > > + * We can't just wait for polled events to come to us, we have to actively
> > > + * find and complete them.
> > > + */
> > > +static void aio_iopoll_reap_events(struct kioctx *ctx)
> > > +{
> > > +	if (!(ctx->flags & IOCTX_FLAG_IOPOLL))
> > > +		return;
> > > +
> > > +	while (!list_empty_careful(&ctx->poll_submitted) ||
> > > +	       !list_empty(&ctx->poll_completing)) {
> > > +		unsigned int nr_events = 0;
> > > +
> > > +		__aio_iopoll_check(ctx, NULL, &nr_events, 1, UINT_MAX);
> > 
> > BUG_ON(__aoi_iopoll_check() < 0) ?
> 
> Ho hum...
> 
> > > +	}
> > > +}
> > > +
> > > +static int aio_iopoll_check(struct kioctx *ctx, long min_nr, long nr,
> > > +			    struct io_event __user *event)
> > > +{
> > > +	unsigned int nr_events = 0;
> > > +	int ret = 0;
> > > +
> > > +	/* * Only allow one thread polling at a time */
> > 
> > nit: extra '* '
> 
> Removed.
> 
> Thanks for your review!

You're welcome. Always happy to help!
Thanks for introducing this interface!
We intend to make use of it in scylla, via seastar
(See http://seastar.io/ https://github.com/scylladb/seastar)

Benny


