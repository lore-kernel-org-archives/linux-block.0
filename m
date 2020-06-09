Return-Path: <SRS0=iQ6z=7W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD55C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B29420812
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 08:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsOPnG7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgFIIIj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:08:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58530 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728137AbgFIIIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jun 2020 04:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591690116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ahInagcs9feFsW/SRSfMWTw6AkLwWZT798daR2SDEg=;
        b=OsOPnG7NVFrz5Uh9w49uTmX7y8/xtIsjelyzrbrI/ejL7/2e96NnHBx7WiecoEAhRY4xk9
        EzXe/ZHu/c1O74+bT54ZKyZLGAcAlvTO+/ewvzwGZhgbm9uywW2+kq4zm/FfRe5uFwc+fm
        rWzSr8dn3JYGR/1BVZo+24WBeVHb6WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-s5cgG3OxMeW2xbgVBgR6Cw-1; Tue, 09 Jun 2020 04:08:35 -0400
X-MC-Unique: s5cgG3OxMeW2xbgVBgR6Cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B69B6108BD0A;
        Tue,  9 Jun 2020 08:08:33 +0000 (UTC)
Received: from T590 (ovpn-13-202.pek2.redhat.com [10.72.13.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EF6090320;
        Tue,  9 Jun 2020 08:08:13 +0000 (UTC)
Date:   Tue, 9 Jun 2020 16:08:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Josh Snyder <joshs@netflix.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Snyder <josh@code406.com>
Subject: Re: [RFC 1/2] Eliminate over- and under-counting of io_ticks
Message-ID: <20200609080808.GA270404@T590>
References: <20200609040724.448519-1-joshs@netflix.com>
 <20200609040724.448519-2-joshs@netflix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609040724.448519-2-joshs@netflix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 09:07:23PM -0700, Josh Snyder wrote:
> Previously, io_ticks could be under-counted. Consider these I/Os along
> the time axis (in jiffies):
> 
>   t          012345678
>   io1        |----|
>   io2            |---|

In current way, when io2 is done, io tickes should be 5, since 1 tick
is added for two io start.

> 
> Under the old approach, io_ticks would count up to 6, like so:
> 
>   t          012345678
>   io1        |----|
>   io2            |---|
>   stamp      0   45  8
>   io_ticks   1   23  6

Before commit 5b18b5a73760("block: delete part_round_stats and switch to less precise counting"),
io tick is calculated accurately, which is basically:

	(4 - 0) + (5 - 4) + (8 - 5) = 8

> 
> With this change, io_ticks instead counts to 8, eliminating the
> under-counting:
> 
>   t          012345678
>   io1        |----|
>   io2            |---|
>   stamp      0    5  8
>   io_ticks   0    5  8
> 
> It was also possible for io_ticks to be over-counted. Consider a
> workload that issues I/Os deterministically at intervals of 8ms (125Hz).
> If each I/O takes 1ms, then the true utilization is 12.5%. The previous
> implementation will increment io_ticks once for each jiffy in which an
> I/O ends. Since the workload issues an I/O reliably for each jiffy, the
> reported utilization will be 100%. This commit changes the approach such
> that only I/Os which cross a boundary between jiffies are counted. With
> this change, the given workload would count an I/O tick on every eighth
> jiffy, resulting in a (correct) calculated utilization of 12.5%.
> 
> Signed-off-by: Josh Snyder <joshs@netflix.com>
> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> ---
>  block/blk-core.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d1b79dfe9540..a0bbd9e099b9 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1396,14 +1396,22 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
>  }
>  EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
>  
> -static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> +static void update_io_ticks(struct hd_struct *part, unsigned long now, unsigned long start)
>  {
>  	unsigned long stamp;
> +	unsigned long elapsed;
>  again:
>  	stamp = READ_ONCE(part->stamp);
>  	if (unlikely(stamp != now)) {
> -		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> -			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
> +		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
> +			// stamp denotes the last IO to finish
> +			// If this IO started before stamp, then there was overlap between this IO
> +			// and that one. We increment only by the non-overlap time.
> +			// If not, there was no overlap and we increment by our own time,
> +			// disregarding stamp.

Linux kernel's comment style is '/**/'

> +			elapsed = now - (start < stamp ? stamp : start);
> +			__part_stat_add(part, io_ticks, elapsed);

Looks this way of only sampling IO done is smart, io ticks becomes much
more accurate than before.

> +		}
>  	}
>  	if (part->partno) {
>  		part = &part_to_disk(part)->part0;
> @@ -1439,7 +1447,7 @@ void blk_account_io_done(struct request *req, u64 now)
>  		part_stat_lock();
>  		part = req->part;
>  
> -		update_io_ticks(part, jiffies, true);
> +		update_io_ticks(part, jiffies, nsecs_to_jiffies(req->start_time_ns));

jiffies and req->start_time_ns may be from different clock sources, so
I'd suggest to merge the two patches into one.


Thanks, 
Ming

