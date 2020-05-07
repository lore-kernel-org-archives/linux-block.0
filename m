Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3804C38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 14:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9802084D
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CBTvy5Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEGOUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgEGOUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 10:20:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866BC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j2EWCBqUxnFrEG/hbqubA0jV+4nAanz0Wg48hGEICK8=; b=CBTvy5XusS8WJcMXZO6wC1S5Mh
        2t/CeQaEyVo3E9cTaI3GTt+KGNrSSNXaUry2wYy33KwuLNZc0sriAmYOWRb3oL8l9f3P+ounh1cg8
        PXv8pXeaVr01htlqnqNf9Td77ipASsTYkTkeuGGMAJQRD2X5dxQzbRb7cZZ4OxqtygBIBi6rKMDjb
        PXTzyAAQZi0mqdEHggPimu2B1D72EIlcfQtFMV9QrylYVuYny06h5X9wHch+PlSRwyyBDH3wbTGp3
        qqrUe8Wnl1WZGJ2m8jtism1HxiWccrnvJvkYZd1S5Kd/ydCPKNSDht6saIkv+AyHpKuOld+X8K7/L
        bN25QaSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWhOM-0005vC-Hc; Thu, 07 May 2020 14:20:50 +0000
Date:   Thu, 7 May 2020 07:20:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 4/4] block: don't hold part0's refcount in IO path
Message-ID: <20200507142050.GD11551@infradead.org>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
 <20200507085239.1354854-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507085239.1354854-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 04:52:39PM +0800, Ming Lei wrote:
> gendisk can't be gone when there is IO activity, so not hold
> part0's refcount in IO path.
> 
> Cc: Yufen Yu <yuyufen@huawei.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c | 3 ++-
>  block/genhd.c    | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 826a8980997d..56cc61354671 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1343,7 +1343,8 @@ void blk_account_io_done(struct request *req, u64 now)
>  		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>  		part_dec_in_flight(req->q, part, rq_data_dir(req));
>  
> -		hd_struct_put(part);
> +		if (part->partno)
> +			hd_struct_put(part);
>  		part_stat_unlock();

Doesn't blk_account_io_merge needs the check as well?

Maybe it should go into hd_struct_put and the other helpers to be
centralized?

Otherwise this looks fine to me.
