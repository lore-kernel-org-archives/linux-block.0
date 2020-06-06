Return-Path: <SRS0=HdX3=7T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B765C433E0
	for <linux-block@archiver.kernel.org>; Sat,  6 Jun 2020 03:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7FD207D5
	for <linux-block@archiver.kernel.org>; Sat,  6 Jun 2020 03:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgGfnuyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgFFD0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 23:26:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728527AbgFFD0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 23:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591413958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLLXFV/8GzWAF1DdNnZjW5Jf0xu/KRRiEpnUKnulajE=;
        b=HgGfnuycFCxGtu7yGFZc8iOF9R78rp4zNUfsSK0pBoSW5aSdSRU5jskbea6DakrB6AEKv2
        +dimN274c3vubiUac2woXnfYX5M384H74QSjpR6i5te00Sf3jUftmZxkc01H9XlHOd2jOm
        +Yi2SYAfdc0FIAr7FCQTHxjm4MfqrGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-icUVYSDiPmK_Pgi7emjdSA-1; Fri, 05 Jun 2020 23:25:56 -0400
X-MC-Unique: icUVYSDiPmK_Pgi7emjdSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C22AC800685;
        Sat,  6 Jun 2020 03:25:53 +0000 (UTC)
Received: from T590 (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9ED27CCEE;
        Sat,  6 Jun 2020 03:25:46 +0000 (UTC)
Date:   Sat, 6 Jun 2020 11:25:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] blk-mq: provide more tags for woken-up process when
 tag allocation is busy
Message-ID: <20200606032541.GA2455424@T590>
References: <20200603073931.94435-1-houtao1@huawei.com>
 <20200604100121.GA2234582@T590>
 <7430b61f-f4a5-4582-e91c-1d46e43a3a64@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7430b61f-f4a5-4582-e91c-1d46e43a3a64@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 05, 2020 at 10:21:31PM +0800, Hou Tao wrote:
> Hi Ming,
> 
> On 2020/6/4 18:01, Ming Lei wrote:
> > Hi Hou Tao,
> > 
> > On Wed, Jun 03, 2020 at 03:39:31PM +0800, Hou Tao wrote:
> >> When there are many free-bit waiters, current batch wakeup method will
> >> wake up at most wake_batch processes when wake_batch bits are freed.
> >> The perfect result is each process will get a free bit, however the
> >> real result is that a waken-up process may being unable to get
> >> a free bit and will call io_schedule() multiple times. That's because
> >> other processes (e.g. wake-up before) in the same wake-up batch
> >> may have already allocated multiple free bits.
> >>
> >> And the race leads to two problems. The first one is the unnecessary
> >> context switch, because multiple processes are waken up and then
> >> go to sleep afterwards. And the second one is the performance
> >> degradation when there is spatial locality between requests from
> >> one process (e.g. split IO for HDD), because one process can not
> >> allocated requests continuously for the split IOs, and
> >> the sequential IOs will be dispatched separatedly.
> > 
> > I guess this way is a bit worse for HDD since sequential IO may be
> > interrupted by other context.
> Yes.
> 
> >>
> >> To fix the problem, we mimic the way how SQ handles this situation:
> > 
> > Do you mean the SQ way is the congestion control code in __get_request()?
> > If not, could you provide more background of SQ's way for this issue?
> > Cause it isn't easy for me to associate your approach with SQ's code.
> > 
> The congestion control is accomplished by both __get_request() and __freed_request().
> In __get_request(), the max available requests is  nr_requests * 1.5 when

Actually, SQ code classified requests into sync an async, and for each
type: the max allowed requests is nr_requests * 1.5, and batching
allocation is triggered if rl->count[is_sync]+1 >= q->nr_requests or
waking up from blocking allocation.

> there are multiple threads try to allocate requests, and in __free_requests()
> it only start to wake up waiter when the busy requests is less than nr_requests,
> so half of nr_request is free when the waiter is woken-up.

The SQ's batching allocation usually allows one active process to
complete one batch of requests and others are blocked. This way is
really nice for sequential IO on HDD.

I did observe some HDD's writeback performance drops a lot after SQ's
batching allocation is killed:

[1] https://lore.kernel.org/linux-scsi/Pine.LNX.4.44L0.1909181213141.1507-100000@iolanthe.rowland.org/
[2] https://lore.kernel.org/linux-scsi/20191226083706.GA17974@ming.t460p/

> 
> The approach in the patch is buggy, because it doesn't check whether
> the number of busy bits is greater than the number of to-be-stashed
> bits. So we just add an atomic (bit_busy) in struct sbitmap to track
> the number of busy bits and use the number to decide whether

Tracking busy bits is really expensive for SSD/NVMe, but it should be
fine for HDD. Maybe we can one dedicated approach for HDD's request
allocation.

> we should wake one process or not:
> 
> +#define SBQ_WS_ACTIVE_MIN 4
> +
> +/* return true when fallback to batched wake-up is needed */
> +static bool sbitmap_do_stash_and_wakeup(struct sbitmap_queue *sbq)
> +{
> +       bool fall_back = false;
> +       int ws_active;
> +       struct sbq_wait_state *ws;
> +       int max_busy;
> +       int bit_busy;
> +       int wake_seq;
> +       int old;
> +
> +       ws_active = atomic_read(&sbq->ws_active);
> +       if (!ws_active)
> +               goto done;
> +
> +       if (ws_active < SBQ_WS_ACTIVE_MIN) {
> +               fall_back = true;
> +               goto done;
> +       }
> +
> +       /* stash and make sure free bits >= depth / 4 */
> +       max_busy = max_t(int, sbq->sb.depth * 3 / 4, 1);
> +       bit_busy = atomic_read(&sbq->bit_busy);
> +       if (bit_busy > max_busy)
> +               goto done;
> +
> +retry:
> +       ws = sbq_wake_ptr(sbq);
> +       if (!ws)
> +               goto done;
> +
> +       wake_seq = atomic_read(&ws->wake_seq);
> +       old = atomic_cmpxchg(&ws->wake_seq, wake_seq, wake_seq + 1);
> +       if (old == wake_seq) {
> +               sbq_index_atomic_inc(&sbq->wake_index);
> +               wake_up(&ws->wait);
> +               goto done;
> +       }
> +
> +done:
> +       return fall_back;
> +}
> +
>  static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  {
>         struct sbq_wait_state *ws;
>         unsigned int wake_batch;
>         int wait_cnt;
> 
> +       if (sbq->flags & SBQ_FLAG_BATCH_BIT_ALLOC) {
> +               if (!sbitmap_do_stash_and_wakeup(sbq))
> +                       return false;
> +       }
> +

I feel that it is a good direction to add one such flag only for HDD's
request tag allocation.

>         ws = sbq_wake_ptr(sbq);
>         if (!ws)
>                 return false;
> 
> >> 1) stash a bulk of free bits
> >> 2) wake up a process when a new bit is freed
> >> 3) woken-up process consumes the stashed free bits
> >> 4) when stashed free bits are exhausted, goto step 1)
> >>>> Because the tag allocation path or io submit path is much faster than
> >> the tag free path, so when the race for free tags is intensive,
> > 
> > Indeed, I guess you mean bio_endio is slow.
> > 
> Yes, thanks for the correction.
> 
> >> we can ensure:
> >> 1) only few processes will be waken up and will exhaust the stashed
> >>    free bits quickly.
> >> 2) these processes will be able to allocate multiple requests
> >>    continuously.
> >>
> >> An alternative fix is to dynamically adjust the number of woken-up
> >> process according to the number of waiters and busy bits, instead of
> >> using wake_batch each time in __sbq_wake_up(). However it will need
> >> to record the number of busy bits all the time, so use the
> >> stash-wake-use method instead.
> >>
> >> The following is the result of a simple fio test:
> >>
> >> 1. fio (random read, 1MB, libaio, iodepth=1024)
> >>
> >> (1) 4TB HDD (max_sectors_kb=256)
> >>
> >> IOPS (bs=1MB)
> >> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> >> 1    | 120      | 120    | 119
> >> 24   | 120      | 105    | 121
> >> 48   | 122      | 102    | 121
> >> 72   | 120      | 100    | 119
> >>
> >> context switch per second
> >> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> >> 1    | 1058     | 1162   | 1188
> >> 24   | 1047     | 1715   | 1105
> >> 48   | 1109     | 1967   | 1105
> >> 72   | 1084     | 1908   | 1106
> >>
> >> (2) 1.8TB SSD (set max_sectors_kb=256)
> >>
> >> IOPS (bs=1MB)
> >> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> >> 1    | 1077     | 1075   | 1076
> >> 24   | 1079     | 1075   | 1076
> >> 48   | 1077     | 1076   | 1076
> >> 72   | 1077     | 1076   | 1077
> >>
> >> context switch per second
> >> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> >> 1    | 1833     | 5123   | 5264
> >> 24   | 2143     | 15238  | 3859
> >> 48   | 2182     | 19015  | 3617
> >> 72   | 2268     | 19050  | 3662
> >>
> >> (3) 1.5TB nvme (set max_sectors_kb=256)
> >>
> >> 4 read queue, 72 CPU
> >>
> >> IOPS (bs=1MB)
> >> jobs | 5.6.15 | 5.6.15-patched |
> >> 1    | 3018   | 3018
> >> 18   | 3015   | 3016
> >> 36   | 3001   | 3005
> >> 54   | 2993   | 2997
> >> 72   | 2984   | 2990
> >>
> >> context switch per second
> >> jobs | 5.6.15 | 5.6.15-patched |
> >> 1    | 6292   | 6469
> >> 18   | 19428  | 4253
> >> 36   | 21290  | 3928
> >> 54   | 23060  | 3957
> >> 72   | 24221  | 4054
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >> Hi,
> >>
> >> We found the problems (excessive context switch and few performance
> >> degradation) during the performance comparison between blk-sq (4.18)
> >> and blk-mq (5.16) on HDD, but we can not find a better way to fix it.
> >>
> >> It seems that in order to implement batched request allocation for
> >> single process, we need to use an atomic variable to track
> >> the number of busy bits. It's suitable for HDD or SDD, because the
> >> IO latency is greater than 1ms, but no sure whether or not it's OK
> >> for NVMe device.
> >
> > Do you have benchmark on NVMe/SSD with 4k BS?
> > 
> The following is the randread test on SSD and NVMe.
> 
> 1. fio randread 4KB
> 
> (1) SSD 1.8TB (nr_tags=1024, nr_requests=256)
> 
> It seems that when there is no race for tag allocation, the performance is the same,
> but when there are intensive race for tag allocation, the performance gain is huge.
> 
> total iodepth=256, so when jobs=2, iodepth=256/2=128
> 
> jobs | 5.6   | 5.6 patched
> 1    | 193k  | 192k
> 2    | 197k  | 196k
> 4    | 198k  | 198k
> 8    | 197k  | 197k
> 16   | 197k  | 198k
> 32   | 198k  | 198k
> 64   | 195k  | 195k
> 128  | 193k  | 192k
> 256  | 198k  | 198k
> 
> total iodepth=512
> 
> jobs | 5.6   | 5.6 patched
> 1    | 193k  | 194k
> 2    | 197k  | 196k
> 4    | 198k  | 197k
> 8    | 197k  | 219k
> 16   | 197k  | 394k
> 32   | 198k  | 395k
> 64   | 196k  | 592k
> 128  | 199k  | 591k
> 256  | 196k  | 591k
> 512  | 198k  | 591k
> 
> total iodepth=1024
> 
> jobs | 5.6   | 5.6 patched
> 1    | 195k  | 192k
> 2    | 196k  | 197k
> 4    | 197k  | 197k
> 8    | 198k  | 197k
> 16   | 197k  | 198k
> 32   | 197k  | 243k
> 64   | 197k  | 393k
> 128  | 197k  | 986k
> 256  | 200k  | 976k
> 512  | 203k  | 984k
> 1024 | 202k  | 354k
> 
> (2) NVMe 1.5TB (nr_tags=1023)
> 
> It seems there is no performance impact on NVMe device, but the
> the number of context switch will be reduced.
> 
> total iodepth=256, so when jobs=2, iodepth=256/2=128
> 
> jobs | 5.6   | 5.6 patched
> 1    | 398k  | 394k
> 4    | 774k  | 775k
> 16   | 774k  | 774k
> 64   | 774k  | 775k
> 256  | 778k  | 784k
> 
> total iodepth=1024
> 
> jobs | 5.6   | 5.6 patched
> 1    | 406k  | 405k
> 4    | 774k  | 773k
> 16   | 774k  | 774k
> 64   | 777k  | 773k
> 256  | 783k  | 783k
> 1024 | 764k  | 755k
> 
> total iodepth=2048
> 
> jobs | 5.6   | 5.6 patched
> 1    | 369k  | 377k
> 4    | 774k  | 774k
> 16   | 774k  | 774k
> 64   | 767k  | 773k
> 256  | 784k  | 781k
> 1024 | 741k  | 1416k
> 2048 | 754k  | 753k

Frankly speaking, I am more interested in context switch & cpu
utilization change on SSD/NVMe after applying your patch.

We may improve HDD, meantime SSD/NVMe's perf can't be hurt, either
latency, or cpu utilization.


Thanks, 
Ming

