Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6153CC433ED
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 01:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0E361625
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 01:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEKBRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 21:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhEKBQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 21:16:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24B0C061574
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 18:15:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa21-20020a17090af0d5b0290157eb6b590fso391500pjb.5
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 18:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jNWAMh6bQ8Il+gbGHjMT39Yzq6BWfaQ9h/Og+TEg0U8=;
        b=gDRJr2ike3Y0wBw2ini1J7S0JTftfmBMlPahaHrKNSeKlLVGQs7ub558hXrQ+WHvR6
         yPvoqucXq4/Ex4k/DGVXPr0cRXE7aqH2iSrEY8jcuYDdvwlZjInp7TetGfxvzVPPR5jJ
         0hvfNSJ7jUL3EaNjlEmtxOw7w73HVrlUWvVPlRZOElPbI921Nlc8ezv6wvHko4tW8QrB
         u17qsXa3xNQ3wyDNT0r8yeyEQPMBMhGkwRiNMJjV0ps5TG7XyHHSLJTPYv05auxb4uw2
         AvV+bl0J1lAo+ldkdeR+7xWgOBTFtYDS98ZlFD5Ip/4aCWGEBnbXmSpzTv9N0LJodXwp
         ZiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jNWAMh6bQ8Il+gbGHjMT39Yzq6BWfaQ9h/Og+TEg0U8=;
        b=Sm51JXKeVoh9y9TC85HhvN7UZaZJWlxwFc5Yp+nzbWW7EldkaSlbzrnvk+zrUfdqOp
         1KEcP2lTGci8ayvGELn7KmlMK9s+XvG050rT9uu3uuF9ICgoDbgNdE5/y0jk78CCxao9
         T4AhgTbsQA6cRmDvwOpUR1fNccZvcX+VAzpriJdanKKzZsiUOvtr7NQ+r0+vfo+kve1p
         hw/cLVPuUfh4PZEiAq17EcnSMRTYmNrQ9thnWEoeyxS/f3E0LGCnOmAG3nlWVH5Cq2CR
         rErpX4KjVRUCW7I7foIVbyoVxcJ3fcRYI6mKyOihURfrJf31v+kFo6yux5/N+omMlFRM
         jQ3g==
X-Gm-Message-State: AOAM532T1FLu0nI7U3jAvb4ifYJEWwt3w5/UX8MrApJ+KKHdlV8NQue2
        ECmxM1WgaFH6P193qjNgzZSbDuIBKI6yYw==
X-Google-Smtp-Source: ABdhPJwEq6Zx5ZKb1pJjbXsmrO2xuTkLnpdqiJAyjjkWluQdyb1COT8R7LJct6laaWgAZXHCD7PAQw==
X-Received: by 2002:a17:902:fe98:b029:ed:23f5:7d54 with SMTP id x24-20020a170902fe98b02900ed23f57d54mr27070207plm.57.1620695751270;
        Mon, 10 May 2021 18:15:51 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1e60])
        by smtp.gmail.com with ESMTPSA id ge4sm547981pjb.49.2021.05.10.18.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 18:15:50 -0700 (PDT)
Date:   Mon, 10 May 2021 18:15:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, kernel-team@fb.com,
        Jakub Kicinski <kuba@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] kyber: fix out of bounds access when preempted
Message-ID: <YJnaxDt+Ml35k9QW@relinquished.localdomain>
References: <c7598605401a48d5cfeadebb678abd10af22b83f.1620691329.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7598605401a48d5cfeadebb678abd10af22b83f.1620691329.git.osandov@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 10, 2021 at 05:05:35PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> __blk_mq_sched_bio_merge() gets the ctx and hctx for the current CPU and
> passes the hctx to ->bio_merge(). kyber_bio_merge() then gets the ctx
> for the current CPU again and uses that to get the corresponding Kyber
> context in the passed hctx. However, the thread may be preempted between
> the two calls to blk_mq_get_ctx(), and the ctx returned the second time
> may no longer correspond to the passed hctx. This "works" accidentally
> most of the time, but it can cause us to read garbage if the second ctx
> came from an hctx with more ctx's than the first one (i.e., if
> ctx->index_hw[hctx->type] > hctx->nr_ctx).
> 
> This manifested as this UBSAN array index out of bounds error reported
> by Jakub:
> 
> UBSAN: array-index-out-of-bounds in ../kernel/locking/qspinlock.c:130:9
> index 13106 is out of range for type 'long unsigned int [128]'
> Call Trace:
>  dump_stack+0xa4/0xe5
>  ubsan_epilogue+0x5/0x40
>  __ubsan_handle_out_of_bounds.cold.13+0x2a/0x34
>  queued_spin_lock_slowpath+0x476/0x480
>  do_raw_spin_lock+0x1c2/0x1d0
>  kyber_bio_merge+0x112/0x180
>  blk_mq_submit_bio+0x1f5/0x1100
>  submit_bio_noacct+0x7b0/0x870
>  submit_bio+0xc2/0x3a0
>  btrfs_map_bio+0x4f0/0x9d0
>  btrfs_submit_data_bio+0x24e/0x310
>  submit_one_bio+0x7f/0xb0
>  submit_extent_page+0xc4/0x440
>  __extent_writepage_io+0x2b8/0x5e0
>  __extent_writepage+0x28d/0x6e0
>  extent_write_cache_pages+0x4d7/0x7a0
>  extent_writepages+0xa2/0x110
>  do_writepages+0x8f/0x180
>  __writeback_single_inode+0x99/0x7f0
>  writeback_sb_inodes+0x34e/0x790
>  __writeback_inodes_wb+0x9e/0x120
>  wb_writeback+0x4d2/0x660
>  wb_workfn+0x64d/0xa10
>  process_one_work+0x53a/0xa80
>  worker_thread+0x69/0x5b0
>  kthread+0x20b/0x240
>  ret_from_fork+0x1f/0x30
> 
> Only Kyber uses the hctx, so fix it by passing the request_queue to
> ->bio_merge() instead. BFQ and mq-deadline just use that, and Kyber can
> map the queues itself to avoid the mismatch.

I should elaborate that once we get the Kyber context, it doesn't matter
if we get preempted after that, since we lock it for merging.
