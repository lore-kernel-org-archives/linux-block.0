Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A6C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E50F61289
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 15:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhFVPOc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:14:32 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:45921 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVPOa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 11:14:30 -0400
Received: by mail-pl1-f180.google.com with SMTP id i4so6889276plt.12;
        Tue, 22 Jun 2021 08:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1W5C3srCUkjJy1nJL26HVe5YZv8gm/IcknUzZl2jap4=;
        b=oRM9Qmm2yp0l3ah4qOrpRY4Lzsu6HoLgYlJVizPI1t7wWrbBf19OuEBNyZoB95GOZ1
         2BzQWKsf+YGqO8WrhwQXnTmdyYbRTg8SVqBBm5T2HEtuYSw7mQoiwnhLOU284WN6FTOX
         b/P4r7IUz92ftGnedvhhxLVmsV/na2dJJ+L21AMGRHtMdqkH29T6zbNd1OFxHi6sPx9A
         po2Ubc/EjkEofV69aXP3IMqesBH2tiCfXdtqxuJxo4pDr5nxmpilkf0NVw4/gt1Etu64
         fh1Dn/tZhCpcY4eeoZcXlIaBD4wyyO8jjhE8rHlHCD/YjvOccPpx3LLAFi3MdUiQukL/
         WPWw==
X-Gm-Message-State: AOAM530zVoKXiNyBuo0PCGlgDq+nZGb5EkSesPaix+XvWCzLY5K0OaN9
        yYHmtBOctUfoy/rOEvpq52Y=
X-Google-Smtp-Source: ABdhPJyIdq9ICzPWCTbv0gJeQOUGN7a+w4xqg2KO7iP3aLZrWEQT/oMMdfSGD28i1kyypaJSZwTbIQ==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr4495520pjb.134.1624374734411;
        Tue, 22 Jun 2021 08:12:14 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id y21sm9152127pfp.57.2021.06.22.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:12:13 -0700 (PDT)
Date:   Tue, 22 Jun 2021 08:12:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210622151210.lpbgnarxsbaakzdy@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233013.562641-2-mcgrof@kernel.org>
 <YNGTvN2cVOPr+duH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNGTvN2cVOPr+duH@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 09:39:40AM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 04:30:11PM -0700, Luis Chamberlain wrote:
> > CPU 1                            CPU 2
> > 
> > class_unregister(...);
> 
> Now the sysfs files are removed and invalidated for all devices
> associated with that class.

You're right the disksize_store() would have to happen before.

> > idr_for_each(...);
> > zram_debugfs_destroy();
> >                                 disksize_store(...);
> 
> How will this call into the kobject's store function if
> class_unregister() has already happened?

The disksize_store() would indeed have to happen before.

> > idr_destroy(...);
> > unregister_blkdev(...);
> 
> Ah, it's a block device's store function you are worried about, not the
> class one?

In this case its about any files which can change the cpu compression
streams.

> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index cf8deecc39ef..431b60cd85c1 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -44,6 +44,8 @@ static DEFINE_MUTEX(zram_index_mutex);
> >  static int zram_major;
> >  static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
> >  
> > +bool zram_up;
> 
> static?

Will fix.

> > +
> >  /* Module params (documentation at end) */
> >  static unsigned int num_devices = 1;
> >  /*
> > @@ -1704,6 +1706,7 @@ static void zram_reset_device(struct zram *zram)
> >  	comp = zram->comp;
> >  	disksize = zram->disksize;
> >  	zram->disksize = 0;
> > +	zram->comp = NULL;
> 
> Is this a new change?

It is a sanity change, but indeed, it is separate. I'll let Minchan
decide if he would prefer this to go out as a separate change.

  Luis
