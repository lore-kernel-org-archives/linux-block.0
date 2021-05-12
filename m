Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CBC433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F130C61429
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhELRcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 13:32:19 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45646 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhELQse (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 12:48:34 -0400
Received: by mail-pg1-f176.google.com with SMTP id q15so14363564pgg.12;
        Wed, 12 May 2021 09:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQdeOjhRYFgbH8ojPKrKgcUJIq+EW4Iy/CRZ9cBVqUc=;
        b=tK4jdr+v3pztDzvrItSTTmJXAP0QXO7s7CducS3FxRWF+3WQ9NO7iWw8wY5DRUTvBB
         wQojA+pEVDpI85sm87S1zfPOQs9MgMCSthk5Ei1FK/G1aqIXLLMzOV84SEvwMo/ku8Ik
         DWPVYrW3GuI1rTj2JP7gmfEiSW8rv4g/ae3+1iwV1FPjZZ32/4dT4fWTvNIzgULEX2tr
         DSYcxQ0/HSFH2IfE7WM0+SIVb5jlbnpx4uGMI19dabU2WeyfNoLhyJnUoqb7d298CNG4
         OTvY+f8lpYSigLnjdnEfLaRfeyREZClk5tUkoSCk/JIgDJkvOhZWm+rMeQa0I9H4JL6v
         ETfQ==
X-Gm-Message-State: AOAM532183XEHOMYdHQzy86yWUjpbXCXrb5XGvFoRV2IQyYcg+yPZWtb
        WwKDDAfwpwwhjThAWl1smLc=
X-Google-Smtp-Source: ABdhPJwkxyguLllYMar1p3+1vMzDxJPmoaRb/ecSIbYWZaxHLDbQqfiUcliSEs34RG5mp/IaPK9EiQ==
X-Received: by 2002:a63:ee53:: with SMTP id n19mr37538477pgk.268.1620838032353;
        Wed, 12 May 2021 09:47:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x35sm285934pfu.209.2021.05.12.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 09:47:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C286841321; Wed, 12 May 2021 16:47:09 +0000 (UTC)
Date:   Wed, 12 May 2021 16:47:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] null_blk: add error handling support for
 add_disk()
Message-ID: <20210512164709.GA4332@42.do-not-panic.com>
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-8-mcgrof@kernel.org>
 <842b6a8d-8880-a0da-a38b-39378dc6ebb9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842b6a8d-8880-a0da-a38b-39378dc6ebb9@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 12, 2021 at 05:16:39PM +0200, Hannes Reinecke wrote:
> On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> > We never checked for errors on add_disk() as this function
> > returned void. Now that this is fixed, use the shiny new
> > error handling.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   drivers/block/null_blk/main.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> > index 5f006d9e1472..2346d1292b26 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -1699,6 +1699,7 @@ static int init_driver_queues(struct nullb *nullb)
> >   static int null_gendisk_register(struct nullb *nullb)
> >   {
> > +	int ret;
> >   	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
> >   	struct gendisk *disk;
> > @@ -1719,13 +1720,17 @@ static int null_gendisk_register(struct nullb *nullb)
> >   	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
> >   	if (nullb->dev->zoned) {
> > -		int ret = null_register_zoned_dev(nullb);
> > +		ret = null_register_zoned_dev(nullb);
> >   		if (ret)
> >   			return ret;
> >   	}
> > -	add_disk(disk);
> > +	ret = add_disk(disk);
> > +	if (ret) {
> 
> unregister_zoned_device() ?

That function does not exist, do you mean null_free_zoned_dev()? If so
that is done by the caller.

  Luis
