Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D86C636CB
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 20:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8786261400
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 20:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGPUDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jul 2021 16:03:49 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34799 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPUDr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jul 2021 16:03:47 -0400
Received: by mail-pf1-f171.google.com with SMTP id o201so9822717pfd.1;
        Fri, 16 Jul 2021 13:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VqxYosNJSSm5h/ehaBu4ffc0gNTJlbOIyJp8FcVr0hQ=;
        b=S56c5WITDN7POXCCgWTAEwUNZVX7X6tNg87NNZnmXkqGH9u9vtALYLw3s3SSr/mOtL
         0bHEQLdiVO+OQiuNQgCLpik0GJNQxLYmfzevrTZCrpordva7xBiufXcT+yy17QaOXDKM
         fjueVpHDUwMBO78C7qr9NvYssgKSy7Xe/M/gXCwwY8lxovB47XlrGfSN9a36DsM5U9Eu
         gXDLYemY+6HzsxmPnv351LCnL9aTJ7c8SPYjOzrjaR5BNc9FtAtRXXt+dpByF446+3jN
         yYpCj9aVc8zqOp1QjXS0FKFfw2mBejk6U/P9+gmNeCmw9nKS2lz2R2oevn9PcSic5vEp
         XkHg==
X-Gm-Message-State: AOAM533FAYbUyo22guYLY88qmzZQObxNeQDU0td9uf5woak84A7Mr6BP
        g/RjZ8SGLzuZt4cHzzFa4cQ=
X-Google-Smtp-Source: ABdhPJwrBQhhNGhDbAji2TU24bcw8voKaGEJlJ+9r3RnucdZtvfSmbZAT5deXSQnj9UwtwSRPJS5Tw==
X-Received: by 2002:a63:500b:: with SMTP id e11mr11747110pgb.423.1626465649351;
        Fri, 16 Jul 2021 13:00:49 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id w186sm11421485pfw.106.2021.07.16.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:00:48 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:00:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/6] block: add flag for add_disk() completion notation
Message-ID: <20210716200045.rqtrfjzegrf726fr@garbanzo>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-3-mcgrof@kernel.org>
 <cbaa9f73-92f8-d5a2-4fd7-c05bda112c56@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbaa9f73-92f8-d5a2-4fd7-c05bda112c56@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 16, 2021 at 07:49:49AM +0200, Hannes Reinecke wrote:
> On 7/15/21 10:23 PM, Luis Chamberlain wrote:
> > Often drivers may have complex setups where it is not
> > clear if their disk completed their respective *add_disk*()
> > call. They either have to invent a setting or, they
> > incorrectly use GENHD_FL_UP. Using GENHD_FL_UP however is
> > used internally so we know when we can add / remove
> > partitions safely. We can easily fail along the way
> > prior to add_disk() completing and still have
> > GENHD_FL_UP set, so it would not be correct in that case
> > to call del_gendisk() on the disk.
> > 
> > Provide a new flag then which allows us to check if
> > *add_disk*() completed, and conversely just make
> > del_gendisk() check for this for drivers so that
> > they can safely call del_gendisk() and we'll figure
> > it out if it is safe for you to call this.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   block/genhd.c         |  8 ++++++++
> >   include/linux/genhd.h | 11 ++++++++++-
> >   2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index c6c9c196ff27..72703d243b44 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -630,6 +630,8 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
> >   	if (ret)
> >   		goto exit_del_events;
> > +	disk->flags |= GENHD_FL_DISK_ADDED;
> > +
> >   	return 0;
> >   exit_del_events:
> >   	disk_del_events(disk);
> > @@ -677,6 +679,9 @@ EXPORT_SYMBOL(device_add_disk_no_queue_reg);
> >    * with put_disk(), which should be called after del_gendisk(), if
> >    * __device_add_disk() was used.
> >    *
> > + * Drivers can safely call this even if they are not sure if the respective
> > + * __device_add_disk() call succeeded.
> > + *
> >    * Drivers exist which depend on the release of the gendisk to be synchronous,
> >    * it should not be deferred.
> >    *
> > @@ -686,6 +691,9 @@ void del_gendisk(struct gendisk *disk)
> >   {
> >   	might_sleep();
> > +	if (!blk_disk_registered(disk))
> > +		return;
> > +
> >   	if (WARN_ON_ONCE(!disk->queue))
> >   		return;
> > diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> > index dc07a957c9e1..73024416d2d5 100644
> > --- a/include/linux/genhd.h
> > +++ b/include/linux/genhd.h
> > @@ -56,6 +56,10 @@ struct partition_meta_info {
> >    * Must not be set for devices which are removed entirely when the
> >    * media is removed.
> >    *
> > + * ``GENHD_FL_DISK_ADDED`` (0x0002): used to clarify that the
> > + * respective add_disk*() call completed successfully, so that
> > + * we know we can safely process del_gendisk() on the disk.
> > + *
> >    * ``GENHD_FL_CD`` (0x0008): the block device is a CD-ROM-style
> >    * device.
> >    * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
> > @@ -94,7 +98,7 @@ struct partition_meta_info {
> >    * Used for multipath devices.
> >    */
> >   #define GENHD_FL_REMOVABLE			0x0001
> > -/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
> > +#define GENHD_FL_DISK_ADDED			0x0002
> >   /* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
> >   #define GENHD_FL_CD				0x0008
> >   #define GENHD_FL_UP				0x0010
> > @@ -189,6 +193,11 @@ struct gendisk {
> >   #define disk_to_cdi(disk)	NULL
> >   #endif
> > +static inline bool blk_disk_registered(struct gendisk *disk)
> > +{
> > +	return disk && (disk->flags & GENHD_FL_DISK_ADDED);
> > +}
> > +
> >   static inline int disk_max_parts(struct gendisk *disk)
> >   {
> >   	if (disk->flags & GENHD_FL_EXT_DEVT)
> > 
> Bah. The flag is named 'DISK_ADDED', and the wrapper 'disk_registered'.
> Please use the same wording (either 'added' or 'registered') for both to
> avoid confusion.

Indeed, will stick with blk_disk_added() then.

  Luis
