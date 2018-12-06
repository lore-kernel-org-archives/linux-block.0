Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E7BC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 09:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F10D20989
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 09:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="UhKE/euD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F10D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeLFJE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:04:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeLFJE7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 04:04:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so22425901wrs.8
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 01:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZQk0pbtBP7wG/ITlIFUupSL/k6xVaiom3/h9orjCy/o=;
        b=UhKE/euD5dgBnsdblspucRYvgEo6Vb4rpoqrGjem4xE+TW2+znWz3DG1VlXhx2e9G2
         XV3nlF/Y9/BfoiUC8OWRKbKLnc9ahLQ8cb1h7ayWp9SnQPC+vOvRWG/hmT4hxAjpAmJV
         KltR0OOT/dEH0peRRJ7tu2fGuJrnguxwMNcoI4UuoCwqzah3V77I4o5tU3EEJzHodYal
         qa8UmqVmeVxpvObkad9wspCTFDv7ltdBKumw5daziC4e2e9a4UVb2NVkbpZXDRtkwr9y
         31Li1P9jw2SLy4bDPxRssROTh2xw4DI2P9NF6AUznoHViU4UVOl3HfEOZFAH6FSe2lzW
         NELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZQk0pbtBP7wG/ITlIFUupSL/k6xVaiom3/h9orjCy/o=;
        b=DiLmw539jaBCFrOMD2CC4L83o6boGVm49FL1KJHn3IKnEDg+qu+egehxNs63rxz9ZW
         iqI1sczxabcdg0bDCJal/f4noCb5rc3jWW6QJRF38zHBxlIm0aAmqdXlRi5bFVSbPTsr
         0l3f1cKM6MElDXYEYFchR/4X9opdzHoom+Amx2PUxU5mMJ4OV/K5RR5ECbNuENQFwN5x
         tDeWnA940cGIv1hv+RxwF2+owNvnHxpRELImwSKlU5tKWfKlv6zfA705tibMCFboJZ3k
         9cxguXltekWvSFU8/EqNU5FGpXXhsEQRgVV1YKo/QPd5Jt2AVIRip7fIPfF3PsJVd5hX
         xIVA==
X-Gm-Message-State: AA+aEWbPP+b736Ce14uIqvQ6/ugUuRpsCzZo+EajS4EdbCEXYlqPCWb+
        gxHv2/4ZWtapo7cCuCXvKM8Yjg==
X-Google-Smtp-Source: AFSGD/XRdMC8knrezKnfLvVRG2/PZl9Fqj3wluP988KgqaX4WUh76CGMgna6jKW5FpZwvjIOMwsiKw==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr25515665wrv.187.1544087098040;
        Thu, 06 Dec 2018 01:04:58 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id q3sm17471301wrn.84.2018.12.06.01.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 01:04:57 -0800 (PST)
Message-ID: <ef2ffc05f262ec222db7fb11a4bf827ef757c723.camel@scylladb.com>
Subject: Re: [PATCH 15/26] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com
Date:   Thu, 06 Dec 2018 11:04:55 +0200
In-Reply-To: <a8df7d41-3a3c-370f-33be-1e2954b45362@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
         <20181204233729.26776-16-axboe@kernel.dk>
         <51ae659719c64d869cae06cdc94748f64132ba3a.camel@scylladb.com>
         <a8df7d41-3a3c-370f-33be-1e2954b45362@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-12-05 at 06:10 -0700, Jens Axboe wrote:
> On 12/5/18 2:56 AM, Benny Halevy wrote:
> > > +static int aio_iopoll_getevents(struct kioctx *ctx,
> > > +				struct io_event __user *event,
> > > +				unsigned int *nr_events, long min, long max)
> > > +{
> > > +	struct aio_kiocb *iocb;
> > > +	int to_poll, polled, ret;
> > > +
> > > +	/*
> > > +	 * Check if we already have done events that satisfy what we need
> > > +	 */
> > > +	if (!list_empty(&ctx->poll_completing)) {
> > > +		ret = aio_iopoll_reap(ctx, event, nr_events, max);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		/* if min is zero, still go through a poll check */
> > 
> > A function-level comment about that would be more visible.
> 
> Yes, that might be a better idea.
> 
> > > +		if (min && *nr_events >= min)
> > > 
> > > +			return 0;
> > 
> > if ((min && *nr_events >= min) || *nr_events >= max) ?
> > 
> > Otherwise, if poll_completing or poll_submitted are not empty,
> > besides getting to the "Shouldn't happen" case in aio_iopoll_reap,
> > it looks like we're gonna waste some cycles and never call f_op->iopoll
> 
> Agree, that would be a better place to catch it. I'll make those two
> changes, thanks!
> 
> > > +
> > > +	/*
> > > +	 * Find up to 'max' worth of events to poll for, including the
> > > +	 * events we already successfully polled
> > > +	 */
> > > +	polled = to_poll = 0;
> > > +	list_for_each_entry(iocb, &ctx->poll_completing, ki_list) {
> > > +		/*
> > > +		 * Poll for needed events with spin == true, anything after
> > > +		 * that we just check if we have more, up to max.
> > > +		 */
> > > +		bool spin = polled + *nr_events >= min;
> > 
> > I'm confused. Shouldn't spin == true if polled + *nr_events < min?
> 
> Heh, that does look off, and it is. I think the correct condition is:
> 
> bool spin = !polled || *nr_events < min;
> 
> and I'm not sure why that got broken. I just tested it, slight
> performance win as expected correcting this. It ties in with the above
> nr_events check - it's perfectly valid to pass min_nr == 0 and just do a
> poll check. Conversely, if we already spun, just do non-spin checks on
> followup poll checks.
> 

Yep, that makes sense.

> > > +static int __aio_iopoll_check(struct kioctx *ctx, struct io_event __user *event,
> > > +			      unsigned int *nr_events, long min_nr, long max_nr)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	while (!*nr_events || !need_resched()) {
> > > +		int tmin = 0;
> > > +
> > > +		if (*nr_events < min_nr)
> > > +			tmin = min_nr - *nr_events;
> > 
> > Otherwise, shouldn't the function just return 0?
> > 
> > Or perhaps you explicitly want to go through the tmin==0 case
> > in aio_iopoll_getevents if *nr_events == min_nr (or min_nr==0)?
> 
> No, we need to go through poll, if min_nr == 0, but only if min_nr == 0
> and !nr_events. But we only get here for nr_events != 0, so should be
> fine as-is.
> 
> Thanks for your review, very useful! I'll make the above changes right
> now.
> 

Thanks!



