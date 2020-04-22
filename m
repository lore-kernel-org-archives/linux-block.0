Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F36C55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 08:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592102071E
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 08:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgDVIH4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:07:56 -0400
Received: from verein.lst.de ([213.95.11.211]:50856 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVIH4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 04:07:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F9E268C4E; Wed, 22 Apr 2020 10:07:53 +0200 (CEST)
Date:   Wed, 22 Apr 2020 10:07:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 4/4] loop: Add LOOP_SET_FD_AND_STATUS ioctl.
Message-ID: <20200422080752.GA24916@lst.de>
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-5-maco@android.com> <20200422061919.GA22819@lst.de> <CAB0TPYHCHytLouWSpwKvi3qpZCzAYhuEot9y+ssnE8vDGgtQpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYHCHytLouWSpwKvi3qpZCzAYhuEot9y+ssnE8vDGgtQpg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 22, 2020 at 10:06:17AM +0200, Martijn Coenen wrote:
> > line at the top of lo_compat_ioctl, and switches the LOOP_SET_STATUS
> > and LOOP_GET_STATUS case to it?
> 
> Did you mean in regular lo_ioctl()?

Yes, sorry.

> eg something like this:
> 
> @@ -1671,6 +1671,7 @@ static int lo_ioctl(struct block_device *bdev,
> fmode_t mode,
>         unsigned int cmd, unsigned long arg)
>  {
>         struct loop_device *lo = bdev->bd_disk->private_data;
> +       void __user *argp = (void __user *) arg;
>         int err;
> 
>         switch (cmd) {
> @@ -1694,21 +1695,19 @@ static int lo_ioctl(struct block_device *bdev,
> fmode_t mode,
>         case LOOP_SET_STATUS:
>                 err = -EPERM;
>                 if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
> -                       err = loop_set_status_old(lo,
> -                                       (struct loop_info __user *)arg);
> +                       err = loop_set_status_old(lo, argp);
>                 }
>                 break;
>         case LOOP_GET_STATUS:
> -               return loop_get_status_old(lo, (struct loop_info __user *) arg);
> +               return loop_get_status_old(lo, argp);
>         case LOOP_SET_STATUS64:
>                 err = -EPERM;
>                 if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
> -                       err = loop_set_status64(lo,
> -                                       (struct loop_info64 __user *) arg);
> +                       err = loop_set_status64(lo, argp);
>                 }
>                 break;
>         case LOOP_GET_STATUS64:
> -               return loop_get_status64(lo, (struct loop_info64 __user *) arg);
> +               return loop_get_status64(lo, argp);

Exactly!
