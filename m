Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E1C388F9
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 09:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9BC20759
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 09:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtYITrwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgJZJVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 05:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbgJZJVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 05:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603704094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6pknwutpWsK6wn74TRUSYpeVku6IU+jCbWaovp5wZz0=;
        b=XtYITrwuURICXHBU1BGjuvFtWXHEK3uU/IslFLjwUwc3PjDWPoPu/vhjE3KJRDXUNg00di
        ycnqBAuvczApwFFsGW9YpFcoJFqTDdqv2Nde18WJ4zA5t7bwduIXuO+HQOzGgeiFr3jhoJ
        O9gJjJa7aoVH5rIMP4CBzslx30oa3yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-NYS_qdRWOSKavYIgnBBR5A-1; Mon, 26 Oct 2020 05:21:32 -0400
X-MC-Unique: NYS_qdRWOSKavYIgnBBR5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B02A8049DE;
        Mon, 26 Oct 2020 09:21:31 +0000 (UTC)
Received: from T590 (ovpn-12-190.pek2.redhat.com [10.72.12.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E336E5C1C2;
        Mon, 26 Oct 2020 09:21:22 +0000 (UTC)
Date:   Mon, 26 Oct 2020 17:21:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     axboe@kernel.dk, snitzer@redhat.com, mpatocka@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/2] block: fix inaccurate io_ticks
Message-ID: <20201026092118.GA1779085@T590>
References: <20201026061533.GA23974@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026061533.GA23974@192.168.3.9>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 26, 2020 at 02:15:34PM +0800, Weiping Zhang wrote:
> Do not add io_ticks if there is no infligh io when start a new IO,
> otherwise an extra 1 jiffy will be add to this IO.
> 
> I run the following command on a host, with different kernel version.
> 
> fio -name=test -ioengine=sync -bs=4K -rw=write
> -filename=/home/test.fio.log -size=100M -time_based=1 -direct=1
> -runtime=300 -rate=2m,2m
> 
> If we run fio in a sync direct io mode, IO will be proccessed one by one,
> you can see that there are 512 IOs completed in one second.
> 
> kernel: 4.19.0
> 
> Device: rrqm/s wrqm/s  r/s    w/s rMB/s wMB/s avgrq-sz avgqu-sz await r_await w_await svctm %util
> vda       0.00   0.00 0.00 512.00  0.00  2.00     8.00     0.21  0.40    0.00    0.40  0.40 20.60
> 
> The averate io.latency is 0.4ms, so the disk time cost in one second
> should be 0.4 * 512 = 204.8 ms, that means, %util should be 20%.
> 
> Becase update_io_ticks will add a extra 1 jiffy(1ms) for every IO, the
> io.latency will be 1 + 0.4 = 1.4ms, 1.4 * 512 = 716.8ms,
> so the %util show it about 72%.
> 
> Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  1.41  72.10
> 
> After this patch:
> Device  r/s    w/s rMB/s wMB/s rrqm/s wrqm/s %rrqm %wrqm r_await w_await aqu-sz rareq-sz wareq-sz svctm  %util
> vda    0.00 512.00  0.00  2.00   0.00   0.00  0.00  0.00    0.00    0.40   0.20     0.00     4.00  0.39  20.00
> 
> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> Fixes: 2b8bd423614c ("block/diskstats: more accurate approximation of io_ticks for slow disks")
> Reported-by: Yabin Li <liyabinliyabin@didiglobal.com>
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  block/blk-core.c | 19 ++++++++++++++-----
>  block/blk-mq.c   | 26 ++++++++++++++++++++++++++
>  block/blk-mq.h   |  1 +
>  block/blk.h      |  1 +
>  block/genhd.c    | 13 +++++++++++++
>  5 files changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ac00d2fa4eb4..9dad92355125 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1256,14 +1256,14 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
>  }
>  EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
>  
> -static void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> +static void update_io_ticks(struct hd_struct *part, unsigned long now, bool inflight)
>  {
>  	unsigned long stamp;
>  again:
>  	stamp = READ_ONCE(part->stamp);
>  	if (unlikely(stamp != now)) {
> -		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp))
> -			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
> +		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp) && inflight)
> +			__part_stat_add(part, io_ticks, now - stamp);
>  	}
>  	if (part->partno) {
>  		part = &part_to_disk(part)->part0;
> @@ -1310,13 +1310,20 @@ void blk_account_io_done(struct request *req, u64 now)
>  
>  void blk_account_io_start(struct request *rq)
>  {
> +	struct hd_struct *part;
> +	struct request_queue *q;
> +	bool inflight;
> +
>  	if (!blk_do_io_stat(rq))
>  		return;
>  
>  	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
>  
>  	part_stat_lock();
> -	update_io_ticks(rq->part, jiffies, false);
> +	part = rq->part;
> +	q = part_to_disk(part)->queue;
> +	inflight = blk_mq_part_is_in_flight(q, part);
> +	update_io_ticks(part, jiffies, inflight);

This way is much worse than before commit 5b18b5a73760("block: delete part_round_stats
and switch to less precise counting") which only reads inflight once in every jiffy.

But you switch to read inflight for _every_ IO, and this way is too bad, IMO.

Thanks,
Ming

