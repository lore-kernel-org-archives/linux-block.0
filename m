Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2B2C6FD1D
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 22:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjDGWht (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDGWhs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 18:37:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C15B77C
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 15:37:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so2474286pja.2
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680907067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG7rHhvzn+QO90+jExkI05GJilJzxR/FCmLHTtYfAQk=;
        b=UWUo1p3i11yE6marIskHMAZr/+2FtCO4m8LXKUgiu+PNAXck7nQ6u31FbGIGF+fOUk
         k25bhe6/vNFpAa2Wsn0uNNqUXFVIzGzW3CEXoudp+jEraSfq6giSWBU7nGtV0p36yqgH
         aAcphi2EjTDx4lSVxZAhn2V3npA6kRB2VVQcsRmZMlxD5xQTvdClHl8spuJr5BppRGHP
         m8DY2Ugr04eBiY+dOuHBfImqsvxM+hNDPzjFAHekg3WAYNmxqmAR2znCVFawtunX33Xz
         mRWnzeoYgc/VVXLkCBvRZs4UjPuKtQJh98V3NDq/bPz50rwSKMWtWxthCen8EG+gCkky
         t5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680907067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG7rHhvzn+QO90+jExkI05GJilJzxR/FCmLHTtYfAQk=;
        b=HrqV9p6FPs3/mNSUz1IwmAI2veb0z0eawUr5HFC5QR3G3GDHTWvbKQbzOpZyhIs/9n
         X6UzzhKOkrXpJw8JQEDxm3FoWI4Up2tPxZNCFUxLGl9ApVTfTnCFsbPazMgIlJJP/Jjw
         t91AhMffCSedpQWDPXO/H9K313ILCxhdIUEbVnNceePboXT69JZxRMmr5cltKFHWzvrW
         gt1ju+WciLTMXPEwRNobJF0Y0gPPf9fIiQ7Wt3Gbzm+wgE3NeK8Gi19Md1J2eDLS+zCS
         hE6y1zyxTb0EtwLgz4spwWiPf1x/v7qEjA/8psZMkLL0Nnp17sngROKkn+bk7wmj6ChW
         UktA==
X-Gm-Message-State: AAQBX9dEc/aW/+LjzsmCfyuBt5nQnNdTqh5S7UMG+Udur4mdsmAbT4we
        8HMJtdqBH45N2ioR2fR6l3Ih0VE1PfM=
X-Google-Smtp-Source: AKy350Ypa5IKY+5r2iGPDjZHbGM7kiGz7TMHJw22vo9EUMXMefd2sCFvWzGwvFXAs7B+UpB9sPDaQA==
X-Received: by 2002:a17:90b:3842:b0:237:9a13:5841 with SMTP id nl2-20020a17090b384200b002379a135841mr4156900pjb.3.1680907067306;
        Fri, 07 Apr 2023 15:37:47 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8c04:2c9c:8af7:8bc2])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709028ecb00b001a1cd6c5a88sm3399270plo.73.2023.04.07.15.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 15:37:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 7 Apr 2023 15:37:44 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-ID: <ZDCbOCza3bK5JSOB@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-16-hch@lst.de>
 <ZC9CIsMcwCjYvbXX@google.com>
 <20230406155810.abc9a2b5c72f43f03a5d5800@linux-foundation.org>
 <ZC9il6lWSKEZxDUr@google.com>
 <20230407043743.GB5674@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407043743.GB5674@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 07, 2023 at 06:37:43AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 06, 2023 at 05:23:51PM -0700, Minchan Kim wrote:
> > rw_page path so that bio comes next to serve the rw_page failure.
> > In the case, zram will always do chained bio so we are fine with
> > asynchronous IO.
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index b8549c61ff2c..23fa0e03cdc1 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1264,6 +1264,8 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
> >                 struct bio_vec bvec;
> > 
> >                 zram_slot_unlock(zram, index);
> > +               if (partial_io)
> > +                       return -EAGAIN;
> > 
> >                 bvec.bv_page = page;
> >                 bvec.bv_len = PAGE_SIZE;
> 
> What tree is this supposed to apply to?  6.2 already has the
> zram_bvec_read_from_bdev helper.

It was for prior to 6.1 where doesn't have (94541bc3fbde4, zram: always
expose rw_page). Since 6.1, with returning -EOPNOTSUPP on the rw_page,
it will defer the request to be handled via submit_bio so every IO to
read data from backing device will have parent bio and chained.

> 
> 
> But either way partial_io can be true when called from zram_bvec_write,
> where we can't just -EAGAIN as ->submit_bio is not allowed to return
> that except for REQ_NOWAIT bios, and even then it needs to be handle
> them when submitted without REQ_NOWAIT.

The case returning -EAGAIN is only rw_page path not the submit_bio path
so the request will be deferred to submit_bio path. However, yeah,
I see it's still broken since read_from_bdev_sync never wait the read
complettion again.

Then, as you suggested, just disable the feature for non-4K would be
the simple option.

I see only this way to achieve it and not sure it will cover all the
cases. If you have better idea, let me know.

Thank you!

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 0386b7da02aa..ae7662430789 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -58,6 +58,12 @@ config ZRAM_DEF_COMP
 config ZRAM_WRITEBACK
        bool "Write back incompressible or idle page to backing device"
        depends on ZRAM
+       depends on !PAGE_SIZE_8KB
+       depends on !PAGE_SIZE_16KB
+       depends on !PAGE_SIZE_32KB
+       depends on !PAGE_SIZE_64KB
+       depends on !PAGE_SIZE_256KB
+       depends on !PAGE_SIZE_1MB
        help
         With incompressible page, there is no memory saving to keep it
         in memory. Instead, write it out to backing device.

