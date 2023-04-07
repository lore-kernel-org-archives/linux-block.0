Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0317DC761A6
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDGAXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjDGAXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:23:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568608682
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:23:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so147265pjo.4
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680827034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUXSnzZl5YAsmN+IFD2pzA5Bp7kbqJ9DlT7DQ5NHXog=;
        b=WvUnjfKxerFVkA+WfZKbaEUShZgjfnhuTTsaZ+Zl/R1eiovVGtD7B1hRFxERxxT42P
         3pEoATSjVciLLa3ssnbkznWkJMTI2TYem8cSujUt2MF+1dUJS77bVW7Axqdn9cwL85Vq
         ElbkkymNmkfWisRLPlNeyVMxQYzdkaNQi3pL784WLGKxS2av337OYTPlE2qcUxEWHgd3
         8dYKVxCALQD1RTLxOm1QsXq85I0ZJhiqhyVjgmrOyKvOLgRj983F/WNQWKdmSQfzX67y
         gLOpYs2yqyecocFdEx19OXuJDZ7EuMD7F/9mtNygi+o22Qn3GpDfyxuolAKowIrr0KTg
         iavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680827034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUXSnzZl5YAsmN+IFD2pzA5Bp7kbqJ9DlT7DQ5NHXog=;
        b=53n55aIAzWeldQRkXihaP4JEStXjgMphZvadF+1qVKGC2hS5qXqnrbUFUyVJaxu9Lp
         ppQDghjPQW4pOTHxJ1I4wV5nV/5DjICcx5ZDKNEBMTc9ruPKd3tBkjGIDkisSUONZRcH
         KE5A4QDsFA3rOmJRQ5RSOlQL5pz7cvXYl8+4OZjgPy++r/Pt6MDPfhk/I+92PN6Lksip
         lGu1KbLxDYR5CUeEl4xCHsymdQcgcHolR4olVW+6F6s7u00NYpCNd4mGMFBzwOl3dL7E
         C3CDONgM9UxWVZqlTm+sQMPmJfkayk2DbZ8F1hOphyGGyvKpTusbNmN7zzQKXUeIlJi6
         CFYA==
X-Gm-Message-State: AAQBX9dE9wK3zV70C2nL0MFKVbb3qGoH9R1GlPVs+ncPS5PJL04omhNo
        DJkGmsqArLGs4skH8nTuirQ=
X-Google-Smtp-Source: AKy350a4+biEEr2HLsLtIoYbsacQvN3hirOQg/GG99XuceG87sT66ev3CeOb0n1XtynRASA9BBzS6g==
X-Received: by 2002:a17:90a:49:b0:23f:4dfd:4fc1 with SMTP id 9-20020a17090a004900b0023f4dfd4fc1mr313519pjb.43.1680827033782;
        Thu, 06 Apr 2023 17:23:53 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id y10-20020a170903010a00b0019f9fd5c24asm1886781plc.207.2023.04.06.17.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:23:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 17:23:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 15/16] zram: fix synchronous reads
Message-ID: <ZC9il6lWSKEZxDUr@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-16-hch@lst.de>
 <ZC9CIsMcwCjYvbXX@google.com>
 <20230406155810.abc9a2b5c72f43f03a5d5800@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406155810.abc9a2b5c72f43f03a5d5800@linux-foundation.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 03:58:10PM -0700, Andrew Morton wrote:
> On Thu, 6 Apr 2023 15:05:22 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
> > On Thu, Apr 06, 2023 at 04:41:01PM +0200, Christoph Hellwig wrote:
> > > Currently nothing waits for the synchronous reads before accessing
> > > the data.  Switch them to an on-stack bio and submit_bio_wait to
> > > make sure the I/O has actually completed when the work item has been
> > > flushed.  This also removes the call to page_endio that would unlock
> > > a page that has never been locked.
> > > 
> > > Drop the partial_io/sync flag, as chaining only makes sense for the
> > > asynchronous reads of the entire page.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > 
> > So this fixes zram_rw_page + CONFIG_ZRAM_WRITEBACK feature on
> > ppc some arch where PAGE_SIZE is not 4K.
> > 
> > IIRC, we didn't have any report since the writeback feature was
> > introduced. Then, we may skip having the fix into stable?
> 
> Someone may develop such a use case in the future.  And backporting
> this fix will be difficult, unless people backport all the other
> patches, which is also difficult.

I think the simple fix is just bail out for partial IO case from
rw_page path so that bio comes next to serve the rw_page failure.
In the case, zram will always do chained bio so we are fine with
asynchronous IO.

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c61ff2c..23fa0e03cdc1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1264,6 +1264,8 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
                struct bio_vec bvec;

                zram_slot_unlock(zram, index);
+               if (partial_io)
+                       return -EAGAIN;

                bvec.bv_page = page;
                bvec.bv_len = PAGE_SIZE;

> 
> What are the user-visible effects of this bug?  It sounds like it will
> give userspace access to unintialized kernel memory, which isn't good.

It's true.

Without better suggestion or objections, I could cook the stable patch.
