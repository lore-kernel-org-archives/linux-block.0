Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E8C43461
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DF861412
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbhELRc6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 13:32:58 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33748 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346863AbhELRVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 13:21:50 -0400
Received: by mail-pg1-f182.google.com with SMTP id i5so13919160pgm.0;
        Wed, 12 May 2021 10:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7LGcYCNZMcfCP3NWFcJJOSDPCUnlEq03kEzY5RMmLcM=;
        b=VTckpdLgLA5oquEjefQpHUhNroCbphuA3PLt1n06GLPgkmRJ9nueRDlj9o2nMxxigz
         PanOzLSm+JOvYpEMDEgqnvIASdv+guZUqG7jxWhXVBLw9OlhtWU+/leNki8Gsf4cwrRw
         MMBq/jZ2HUnrZAK/wk61eMsvC7prUntW0Az3jYKddbpfOSja8mN1SE7ZpX5y1m6WAa22
         jeEKdRXF52b3wOeQ9fKZaVpXsLVfJk0YDDVbxqjwvHhJGFKTz6HiR5DXYhLNZVIlBRKs
         WGSmKxmgphU/YmXS8TI+ahFla4UTvSudqU8CzpwrXhywJdy09jove0eAVUsATYSZavut
         2+dg==
X-Gm-Message-State: AOAM5309DMh/SPlWl3EK0l+NLc+Fj4JW5+zUcprtNGhu46KjDGIuw/cp
        j4OlyVRbcXqNFkTvg1/GRKw=
X-Google-Smtp-Source: ABdhPJzFXwRRMW5n7pGiz+V294eU3gB1BFVm04NenPL4KbwcBLPSsec4Ecele52LHZfmHrzXIwhV+g==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr37948115pgg.397.1620840041768;
        Wed, 12 May 2021 10:20:41 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j79sm333131pfd.184.2021.05.12.10.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:20:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EBA8B41321; Wed, 12 May 2021 17:20:39 +0000 (UTC)
Date:   Wed, 12 May 2021 17:20:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] null_blk: add error handling support for
 add_disk()
Message-ID: <20210512172039.GQ4332@42.do-not-panic.com>
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-8-mcgrof@kernel.org>
 <842b6a8d-8880-a0da-a38b-39378dc6ebb9@suse.de>
 <20210512164709.GA4332@42.do-not-panic.com>
 <d519b9ce-ad28-a266-786f-4128e0b91b9f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d519b9ce-ad28-a266-786f-4128e0b91b9f@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 12, 2021 at 07:12:03PM +0200, Hannes Reinecke wrote:
> On 5/12/21 6:47 PM, Luis Chamberlain wrote:
> > On Wed, May 12, 2021 at 05:16:39PM +0200, Hannes Reinecke wrote:
> > > On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> > > > We never checked for errors on add_disk() as this function
> > > > returned void. Now that this is fixed, use the shiny new
> > > > error handling.
> > > > 
> > > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > ---
> > > >    drivers/block/null_blk/main.c | 9 +++++++--
> > > >    1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> > > > index 5f006d9e1472..2346d1292b26 100644
> > > > --- a/drivers/block/null_blk/main.c
> > > > +++ b/drivers/block/null_blk/main.c
> > > > @@ -1699,6 +1699,7 @@ static int init_driver_queues(struct nullb *nullb)
> > > >    static int null_gendisk_register(struct nullb *nullb)
> > > >    {
> > > > +	int ret;
> > > >    	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
> > > >    	struct gendisk *disk;
> > > > @@ -1719,13 +1720,17 @@ static int null_gendisk_register(struct nullb *nullb)
> > > >    	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
> > > >    	if (nullb->dev->zoned) {
> > > > -		int ret = null_register_zoned_dev(nullb);
> > > > +		ret = null_register_zoned_dev(nullb);
> > > >    		if (ret)
> > > >    			return ret;
> > > >    	}
> > > > -	add_disk(disk);
> > > > +	ret = add_disk(disk);
> > > > +	if (ret) {
> > > 
> > > unregister_zoned_device() ?
> > 
> > That function does not exist, do you mean null_free_zoned_dev()? If so
> > that is done by the caller.
> > 
> What I intended to say is that you are calling 'null_register_zoned_dev()'
> at one point, but don't call a cleanup function if there is an error later
> in the path, leaving the caller to guess whether null_register_zoned_dev()
> has been called or not.
> So we should call the cleanup function here, too.

The cleanup for zone stuff is done on the caller.

  Luis
