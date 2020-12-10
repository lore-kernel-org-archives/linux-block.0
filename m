Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511D6C4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 15:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075BE23D57
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 15:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391989AbgLJPyc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:54:32 -0500
Received: from mx4.veeam.com ([104.41.138.86]:36282 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391972AbgLJPy3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 10:54:29 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id A6EE6B21AA;
        Thu, 10 Dec 2020 18:53:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1607615625; bh=3awHdxGKc6WUm7H6eoqHiaDYHJ/Q1xBn9eP28D3/mQQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=MMMjdzzWarHX14mrpOC28CzT7RnW55A+vlU8XVgQjIyzj3WLwnnvpXYBMKbuoHnea
         KvRkIBtCwGeR1q2m5tga/Pdu8XEuD6WqWXJooHQc8gwtY+qxASNicg+Q26OnIUikM5
         I/KTLtAfJMqg7UnDYhBs6W42qzBPG/f5QZwHurPE=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 10 Dec 2020
 16:53:43 +0100
Date:   Thu, 10 Dec 2020 18:54:05 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
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
Message-ID: <20201210155405.GB31521@veeam.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <1607518911-30692-3-git-send-email-sergei.shtepa@veeam.com>
 <20201209143606.GA494@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201209143606.GA494@redhat.com>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A627064
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 12/09/2020 17:36, Mike Snitzer wrote:
> On Wed, Dec 09 2020 at  8:01am -0500,
> Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
> 
> > This sample demonstrates how to use blk_interposer.
> > It show how to properly connect the interposer module to kernel,
> > and perform the simplest monitoring of the number of bio.
> > 
> > Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> > ---
> >  samples/blk_interposer/Makefile         |   2 +
> >  samples/blk_interposer/blk-interposer.c | 276 ++++++++++++++++++++++++
> >  2 files changed, 278 insertions(+)
> >  create mode 100644 samples/blk_interposer/Makefile
> >  create mode 100644 samples/blk_interposer/blk-interposer.c
> > 
> > diff --git a/samples/blk_interposer/Makefile b/samples/blk_interposer/Makefile
> > new file mode 100644
> > index 000000000000..b11aefde2b1c
> > --- /dev/null
> > +++ b/samples/blk_interposer/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_SAMPLE_BLK_INTERPOSER) += blk-interposer.o
> > diff --git a/samples/blk_interposer/blk-interposer.c b/samples/blk_interposer/blk-interposer.c
> > new file mode 100644
> > index 000000000000..92b4c1fcf8f7
> > --- /dev/null
> > +++ b/samples/blk_interposer/blk-interposer.c
> > @@ -0,0 +1,276 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Block layer interposer allow to interpose bio requests from kernel module.
> > + * This allows you to monitor requests, modify requests, add new request,
> > + * or even redirect requests to another devices.
> > + *
> > + * This sample demonstrates how to use blk_interposer.
> > + * It show how to properly connect the interposer module to kernel,
> > + * and perform the simplest monitoring of the number of bio.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/errno.h>
> > +#include <linux/blkdev.h>
> > +#include <linux/genhd.h>
> > +#include <linux/blk-mq.h>
> > +
> > +int device_major = 8;
> > +int device_minor;
> > +int fmode = FMODE_READ | FMODE_WRITE;
> > +
> > +/*
> > + * Each interposer must have a common part in the form of the blk_interposer structure,
> > + * as well as its own unique data.
> > + */
> > +struct my_interposer {
> > +	/*
> > +	 * Common part of block device interposer.
> > +	 */
> > +	struct blk_interposer interposer;
> > +	/*
> > +	 * Specific part for our interposer data.
> > +	 */
> > +	atomic_t counter;
> > +};
> > +
> > +struct my_interposer my_ip;
> > +
> > +/**
> > + * blk_interposer_attach - Attach interposer to disk
> > + * @disk: target disk
> > + * @interposer: block device interposer
> > + */
> > +static int blk_interposer_attach(struct gendisk *disk, struct blk_interposer *interposer)
> > +{
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * Stop disks queue processing.
> > +	 */
> > +	blk_mq_freeze_queue(disk->queue);
> > +	blk_mq_quiesce_queue(disk->queue);
> > +
> > +	/*
> > +	 * Check if the interposer is already busy.
> > +	 * The interposer will only connect if it is not busy.
> > +	 */
> > +	if (blk_has_interposer(disk)) {
> > +		pr_info("The interposer is already busy.\n");
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * Attach the interposer.
> > +	 */
> > +	disk->interposer = interposer;
> > +	/*
> > +	 * And while the queue is stopped, we can do something specific for our module.
> > +	 */
> > +	pr_info("Block device interposer attached successfully.\n");
> > +
> > +out:
> > +	/*
> > +	 * Resume disks queue processing
> > +	 */
> > +	blk_mq_unquiesce_queue(disk->queue);
> > +	blk_mq_unfreeze_queue(disk->queue);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * blk_interposer_detach - Detach interposer from disk
> > + * @disk: target disk
> > + * @interposer: block device interposer
> > + */
> > +static int blk_interposer_detach(struct gendisk *disk, struct blk_interposer *interposer)
> > +{
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(!disk))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Stop disks queue processing.
> > +	 */
> > +	blk_mq_freeze_queue(disk->queue);
> > +	blk_mq_quiesce_queue(disk->queue);
> > +
> > +	/*
> > +	 * Check if the interposer is still available.
> > +	 */
> > +	if (!disk->interposer) {
> > +		pr_info("The interposer is not available.\n");
> > +		return -ENOENT;
> > +		goto out;
> > +	}
> > +	/*
> > +	 * Check if it is really our interposer.
> > +	 */
> > +	if (disk->interposer->ip_submit_bio != interposer->ip_submit_bio) {
> > +		pr_info("The interposer found is not ours.\n");
> > +		return -EPERM;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * Detach interposer.
> > +	 */
> > +	disk->interposer = NULL;
> > +	/*
> > +	 * And while the queue is stopped, we can do something specific for our module.
> > +	 */
> > +	pr_info("Block device interposer detached successfully.\n");
> > +
> > +out:
> > +	/*
> > +	 * Resume disks queue processing.
> > +	 */
> > +	blk_mq_unquiesce_queue(disk->queue);
> > +	blk_mq_unfreeze_queue(disk->queue);
> > +
> > +	return ret;
> > +}
> 
> This attach and detach code needs to be elevated out of samples so that
> any future consumer of blk_interposer doesn't reinvent it.  It is far
> too fundamental.
> 
> The way you've proposed this be merged is very much unacceptable.
> 
> Nacked-by: Mike Snitzer <snitzer@redhat.com>
> 
Yes, but on the other hand, while the queue is suspended, the module can perform
some other actions specific to it.

And since the functions blk_mq_freeze_queue(), blk_mq_quiesce_queue(),
blk_mq_unquiesce_queue() and blk_mq_unfreeze_queue() are public,
the module creator can implement its module connection functionality regardless of
whether we make the functions blk_interposer_attach() and blk_interposer_detach()
in the kernel or not.

I'll think about it and try to come up with a better solution.
-- 
Sergei Shtepa
Veeam Software developer.
