Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B4CC2BB48
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654D123E25
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbgLJQAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 11:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403855AbgLJQAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 11:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607615917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKjSMYSu+Z18egYl0Qu1TrUiaOZoWdBxJJgAeszoW0s=;
        b=Q4/KIDHt4HEZsEV6aPQX1FZdUgcig8GLdSBuhhyN1FS07+ZVZKZgtq4ynBMqZVXFqS0mNU
        68xZGINwlBknKpr+vJXHS2mS9JEPqv4H4hbH4NmipN30fieRxQ7MHTx0pVARDko6N5gN0o
        IcU6aYKyHR228eMgU8gTtRYhJL7MYWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-XJ-9TNLrOFOCL9NKwKRRTA-1; Thu, 10 Dec 2020 10:58:32 -0500
X-MC-Unique: XJ-9TNLrOFOCL9NKwKRRTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 083758049C9;
        Thu, 10 Dec 2020 15:58:31 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D19419C78;
        Thu, 10 Dec 2020 15:58:27 +0000 (UTC)
Date:   Thu, 10 Dec 2020 10:58:26 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH 2/3] block: blk_interposer - sample
Message-ID: <20201210155826.GA10154@redhat.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <1607518911-30692-3-git-send-email-sergei.shtepa@veeam.com>
 <20201209143606.GA494@redhat.com>
 <20201210155405.GB31521@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210155405.GB31521@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 10 2020 at 10:54am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> The 12/09/2020 17:36, Mike Snitzer wrote:
> > On Wed, Dec 09 2020 at  8:01am -0500,
> > Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> > 
> > > This sample demonstrates how to use blk_interposer.
> > > It show how to properly connect the interposer module to kernel,
> > > and perform the simplest monitoring of the number of bio.
> > > 
> > > Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> > > ---
> > >  samples/blk_interposer/Makefile         |   2 +
> > >  samples/blk_interposer/blk-interposer.c | 276 ++++++++++++++++++++++++
> > >  2 files changed, 278 insertions(+)
> > >  create mode 100644 samples/blk_interposer/Makefile
> > >  create mode 100644 samples/blk_interposer/blk-interposer.c
> > > 
> > > diff --git a/samples/blk_interposer/Makefile b/samples/blk_interposer/Makefile
> > > new file mode 100644
> > > index 000000000000..b11aefde2b1c
> > > --- /dev/null
> > > +++ b/samples/blk_interposer/Makefile
> > > @@ -0,0 +1,2 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +obj-$(CONFIG_SAMPLE_BLK_INTERPOSER) += blk-interposer.o
> > > diff --git a/samples/blk_interposer/blk-interposer.c b/samples/blk_interposer/blk-interposer.c
> > > new file mode 100644
> > > index 000000000000..92b4c1fcf8f7
> > > --- /dev/null
> > > +++ b/samples/blk_interposer/blk-interposer.c
> > > @@ -0,0 +1,276 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * Block layer interposer allow to interpose bio requests from kernel module.
> > > + * This allows you to monitor requests, modify requests, add new request,
> > > + * or even redirect requests to another devices.
> > > + *
> > > + * This sample demonstrates how to use blk_interposer.
> > > + * It show how to properly connect the interposer module to kernel,
> > > + * and perform the simplest monitoring of the number of bio.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/types.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/blkdev.h>
> > > +#include <linux/genhd.h>
> > > +#include <linux/blk-mq.h>
> > > +
> > > +int device_major = 8;
> > > +int device_minor;
> > > +int fmode = FMODE_READ | FMODE_WRITE;
> > > +
> > > +/*
> > > + * Each interposer must have a common part in the form of the blk_interposer structure,
> > > + * as well as its own unique data.
> > > + */
> > > +struct my_interposer {
> > > +	/*
> > > +	 * Common part of block device interposer.
> > > +	 */
> > > +	struct blk_interposer interposer;
> > > +	/*
> > > +	 * Specific part for our interposer data.
> > > +	 */
> > > +	atomic_t counter;
> > > +};
> > > +
> > > +struct my_interposer my_ip;
> > > +
> > > +/**
> > > + * blk_interposer_attach - Attach interposer to disk
> > > + * @disk: target disk
> > > + * @interposer: block device interposer
> > > + */
> > > +static int blk_interposer_attach(struct gendisk *disk, struct blk_interposer *interposer)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	/*
> > > +	 * Stop disks queue processing.
> > > +	 */
> > > +	blk_mq_freeze_queue(disk->queue);
> > > +	blk_mq_quiesce_queue(disk->queue);
> > > +
> > > +	/*
> > > +	 * Check if the interposer is already busy.
> > > +	 * The interposer will only connect if it is not busy.
> > > +	 */
> > > +	if (blk_has_interposer(disk)) {
> > > +		pr_info("The interposer is already busy.\n");
> > > +		ret = -EBUSY;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Attach the interposer.
> > > +	 */
> > > +	disk->interposer = interposer;
> > > +	/*
> > > +	 * And while the queue is stopped, we can do something specific for our module.
> > > +	 */
> > > +	pr_info("Block device interposer attached successfully.\n");
> > > +
> > > +out:
> > > +	/*
> > > +	 * Resume disks queue processing
> > > +	 */
> > > +	blk_mq_unquiesce_queue(disk->queue);
> > > +	blk_mq_unfreeze_queue(disk->queue);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * blk_interposer_detach - Detach interposer from disk
> > > + * @disk: target disk
> > > + * @interposer: block device interposer
> > > + */
> > > +static int blk_interposer_detach(struct gendisk *disk, struct blk_interposer *interposer)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (WARN_ON(!disk))
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * Stop disks queue processing.
> > > +	 */
> > > +	blk_mq_freeze_queue(disk->queue);
> > > +	blk_mq_quiesce_queue(disk->queue);
> > > +
> > > +	/*
> > > +	 * Check if the interposer is still available.
> > > +	 */
> > > +	if (!disk->interposer) {
> > > +		pr_info("The interposer is not available.\n");
> > > +		return -ENOENT;
> > > +		goto out;
> > > +	}
> > > +	/*
> > > +	 * Check if it is really our interposer.
> > > +	 */
> > > +	if (disk->interposer->ip_submit_bio != interposer->ip_submit_bio) {
> > > +		pr_info("The interposer found is not ours.\n");
> > > +		return -EPERM;
> > > +		goto out;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Detach interposer.
> > > +	 */
> > > +	disk->interposer = NULL;
> > > +	/*
> > > +	 * And while the queue is stopped, we can do something specific for our module.
> > > +	 */
> > > +	pr_info("Block device interposer detached successfully.\n");
> > > +
> > > +out:
> > > +	/*
> > > +	 * Resume disks queue processing.
> > > +	 */
> > > +	blk_mq_unquiesce_queue(disk->queue);
> > > +	blk_mq_unfreeze_queue(disk->queue);
> > > +
> > > +	return ret;
> > > +}
> > 
> > This attach and detach code needs to be elevated out of samples so that
> > any future consumer of blk_interposer doesn't reinvent it.  It is far
> > too fundamental.
> > 
> > The way you've proposed this be merged is very much unacceptable.
> > 
> > Nacked-by: Mike Snitzer <snitzer@redhat.com>
> > 
> Yes, but on the other hand, while the queue is suspended, the module can perform
> some other actions specific to it.
> 
> And since the functions blk_mq_freeze_queue(), blk_mq_quiesce_queue(),
> blk_mq_unquiesce_queue() and blk_mq_unfreeze_queue() are public,
> the module creator can implement its module connection functionality regardless of
> whether we make the functions blk_interposer_attach() and blk_interposer_detach()
> in the kernel or not.
> 
> I'll think about it and try to come up with a better solution.

This practice of sprinkling code in samples/ subdir and getting a
minimalist hook into the kernel (with no actual in-kernel consumer) is
_not_ how we do things.

I'm not well-versed on the samples/ subdir nor when it came into
existence; but it should die in a fire!

Mike

