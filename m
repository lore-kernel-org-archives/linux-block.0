Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C6DC07E96
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 06:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A46961042
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 06:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhGMGCw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jul 2021 02:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhGMGCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jul 2021 02:02:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79DC0613DD;
        Mon, 12 Jul 2021 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1D07VBYHVlfVW177ehSNjfkxJ96KWMGyfdK1Ulmhwzo=; b=M+fYzrlIfp6yhbAuJdNoK/NvWF
        fURYIdss5pnxUmi4WlMY0NBeq5C/CnLHT265KG/4C+pzkOkQcAYrxl2PWTiRM5c+yQdSdLN/ry8pP
        MXPQtAOj3Zp4fL7guTW7GJC0yN/ib4tyA9jZgvFimcRMWyNqMdTZKxWCy1tbtTqiQ6cT+vPKC/8wN
        pZMkc5BKdM6LdOT8E+JQpAxlP8pzOVXVhcX1sBPKpyhrzo2MBWv3ABGnXWt/EkOUnksLHlnB/oFum
        Zlg/JFKDztbD83RowHH/ucjHxKalCFvT8xHqRt7FFEfE+zv3POEngluWV0esGd/KuBfecS9iE8KMq
        v20KkQIw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3BSC-000myC-Ou; Tue, 13 Jul 2021 05:59:44 +0000
Date:   Tue, 13 Jul 2021 06:59:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     'Matteo Croce' <mcroce@linux.microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz?lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 3/5] block: add ioctl to read the disk sequence number
Message-ID: <YO0ryEHQngrGpvm2@infradead.org>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
 <20210711175415.80173-4-mcroce@linux.microsoft.com>
 <TU4PR8401MB10558BB52D2F37CFC96FB8B8AB159@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB10558BB52D2F37CFC96FB8B8AB159@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 12, 2021 at 07:22:43PM +0000, Elliott, Robert (Servers) wrote:
>     static int put_u64(u64 __user *argp, u64 val)
>     {
>         return put_user(val, argp);
>     }
> 
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index 24beec9ca9c9..0c3a4a53fa11 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -469,6 +469,8 @@ static int blkdev_common_ioctl(struct block_device
> > *bdev, fmode_t mode,
> >  				BLKDEV_DISCARD_SECURE);
> ...
> 
> > +	case BLKGETDISKSEQ:
> > +		return put_u64(argp, bdev->bd_disk->diskseq);
> 
> How does that work on a system in which int is 32 bits?

Why would it not work?  put_user is a magic macro that works on all
scalar value.
