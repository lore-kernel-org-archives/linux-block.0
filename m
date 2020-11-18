Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D2C5519F
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 07:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA03A2223D
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 07:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hk7+7ouc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKRHHV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Nov 2020 02:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRHHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 02:07:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35109C0613D4
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2020 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rh/8z/nDtnRM/4rCYFlL+5imtJKMw1grNrpSTn0hWBo=; b=Hk7+7oucN3OhBJX4ALwd+48c2d
        EUs3diEwKEccKfwMi8YhnYJYuLU9t2C/ebAMPydCWEftfDE7opJx+eaqFt4ceU8WlF2p7+Dqnf1bn
        D/YmCcF6gRHQTeivdgFRThIpFaEo83LR3CDoL7YCeVHUpT323cYf7hN6HeEOViISHWkKPCOdNV9qd
        0hv05hBJ3rX6VcbhAcuQ01KWHwaBIfZ3CdQE46Xk4jwBpNWV0OHgJ0VdH4FbcXIu0Ivkuqjx9mxEL
        fCVFPJfsMW2l51W+PIKa0gH8vJGPh3oZHl4HSzXQvwTmzok/kYKhl8I6jTzmCLfOYoIxA7/1IPPsc
        qA4koTaQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfHYg-00013P-PW; Wed, 18 Nov 2020 07:07:14 +0000
Date:   Wed, 18 Nov 2020 07:07:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongjoo Seo <commisori28@gmail.com>
Cc:     axboe@kernel.dk, hch@infradead.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Message-ID: <20201118070714.GA3786@infradead.org>
References: <20201118004746.GA29180@dongjoo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118004746.GA29180@dongjoo-desktop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adding Damien who wrote this code.

On Wed, Nov 18, 2020 at 09:47:46AM +0900, Dongjoo Seo wrote:
> Current sleep time for hybrid polling is half of mean time.
> The 'half' sleep time is good for minimizing the cpu utilization.
> But, the problem is that its cpu utilization is still high.
> this patch can help to minimize the cpu utilization side.
> 
> Below 1,2 is my test hardware sets.
> 
> 1. Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz + Samsung 970 pro 1Tb
> 2. Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz + INTEL SSDPED1D480GA 480G
> 
>         |  Classic Polling | Hybrid Polling  | this Patch
> -----------------------------------------------------------------
>         cpu util | IOPS(k) | cpu util | IOPS | cpu util | IOPS  |
> -----------------------------------------------------------------
> 1.       99.96   |   491   |  56.98   | 467  | 35.98    | 442   |
> -----------------------------------------------------------------
> 2.       99.94   |   582   |  56.3    | 582  | 35.28    | 582   |
> 
> cpu util means that sum of sys and user util.
> 
> I used 4k rand read for this test.
> because that case is worst case of I/O performance side.
> below one is my fio setup.
> 
> name=pollTest
> ioengine=pvsync2
> hipri
> direct=1
> size=100%
> randrepeat=0
> time_based
> ramp_time=0
> norandommap
> refill_buffers
> log_avg_msec=1000
> log_max_value=1
> group_reporting
> filename=/dev/nvme0n1
> [rd_rnd_qd_1_4k_1w]
> bs=4k
> iodepth=32
> numjobs=[num of cpus]
> rw=randread
> runtime=60
> write_bw_log=bw_rd_rnd_qd_1_4k_1w
> write_iops_log=iops_rd_rnd_qd_1_4k_1w
> write_lat_log=lat_rd_rnd_qd_1_4k_1w
> 
> Thanks
> 
> Signed-off-by: Dongjoo Seo <commisori28@gmail.com>
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1b25ec2fe9be..c3d578416899 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3749,8 +3749,7 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
>  		return ret;
>  
>  	if (q->poll_stat[bucket].nr_samples)
> -		ret = (q->poll_stat[bucket].mean + 1) / 2;
> -
> +		ret = (q->poll_stat[bucket].mean + 1) * 3 / 4;
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 
---end quoted text---
