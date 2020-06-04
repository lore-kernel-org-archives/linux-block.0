Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDDC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714D8204EA
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 10:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUYDmo24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgFDKBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:01:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726115AbgFDKBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 06:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591264897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyOP0d8Rbryllr+78UCZbRbmOJgI0LPizgdXJXtUYzQ=;
        b=IUYDmo24SNECMy5g+bcGP3O7mFjrK5nIA0+Nl5eWHaht9RpSJ7I8j3ieW3NwypH3+T62GQ
        bpMD/7M4xymQvFHZWHncRex1XFdOrz8iTKtgnlGHs36StuNQ6jGRXfhiVwCV2UneRoHgTA
        Vy0H2iuNAf7GoOqlolgz4m4v/Kcedf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-I9fh53FiNkSQ7Gf4_IUhVg-1; Thu, 04 Jun 2020 06:01:35 -0400
X-MC-Unique: I9fh53FiNkSQ7Gf4_IUhVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D83E107ACCA;
        Thu,  4 Jun 2020 10:01:34 +0000 (UTC)
Received: from T590 (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25FA15D9D3;
        Thu,  4 Jun 2020 10:01:25 +0000 (UTC)
Date:   Thu, 4 Jun 2020 18:01:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] blk-mq: provide more tags for woken-up process when
 tag allocation is busy
Message-ID: <20200604100121.GA2234582@T590>
References: <20200603073931.94435-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603073931.94435-1-houtao1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hou Tao,

On Wed, Jun 03, 2020 at 03:39:31PM +0800, Hou Tao wrote:
> When there are many free-bit waiters, current batch wakeup method will
> wake up at most wake_batch processes when wake_batch bits are freed.
> The perfect result is each process will get a free bit, however the
> real result is that a waken-up process may being unable to get
> a free bit and will call io_schedule() multiple times. That's because
> other processes (e.g. wake-up before) in the same wake-up batch
> may have already allocated multiple free bits.
> 
> And the race leads to two problems. The first one is the unnecessary
> context switch, because multiple processes are waken up and then
> go to sleep afterwards. And the second one is the performance
> degradation when there is spatial locality between requests from
> one process (e.g. split IO for HDD), because one process can not
> allocated requests continuously for the split IOs, and
> the sequential IOs will be dispatched separatedly.

I guess this way is a bit worse for HDD since sequential IO may be
interrupted by other context.

> 
> To fix the problem, we mimic the way how SQ handles this situation:

Do you mean the SQ way is the congestion control code in __get_request()?
If not, could you provide more background of SQ's way for this issue?
Cause it isn't easy for me to associate your approach with SQ's code.

> 1) stash a bulk of free bits
> 2) wake up a process when a new bit is freed
> 3) woken-up process consumes the stashed free bits
> 4) when stashed free bits are exhausted, goto step 1)
> 
> Because the tag allocation path or io submit path is much faster than
> the tag free path, so when the race for free tags is intensive,

Indeed, I guess you mean bio_endio is slow.

> we can ensure:
> 1) only few processes will be waken up and will exhaust the stashed
>    free bits quickly.
> 2) these processes will be able to allocate multiple requests
>    continuously.
> 
> An alternative fix is to dynamically adjust the number of woken-up
> process according to the number of waiters and busy bits, instead of
> using wake_batch each time in __sbq_wake_up(). However it will need
> to record the number of busy bits all the time, so use the
> stash-wake-use method instead.
> 
> The following is the result of a simple fio test:
> 
> 1. fio (random read, 1MB, libaio, iodepth=1024)
> 
> (1) 4TB HDD (max_sectors_kb=256)
> 
> IOPS (bs=1MB)
> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> 1    | 120      | 120    | 119
> 24   | 120      | 105    | 121
> 48   | 122      | 102    | 121
> 72   | 120      | 100    | 119
> 
> context switch per second
> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> 1    | 1058     | 1162   | 1188
> 24   | 1047     | 1715   | 1105
> 48   | 1109     | 1967   | 1105
> 72   | 1084     | 1908   | 1106
> 
> (2) 1.8TB SSD (set max_sectors_kb=256)
> 
> IOPS (bs=1MB)
> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> 1    | 1077     | 1075   | 1076
> 24   | 1079     | 1075   | 1076
> 48   | 1077     | 1076   | 1076
> 72   | 1077     | 1076   | 1077
> 
> context switch per second
> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
> 1    | 1833     | 5123   | 5264
> 24   | 2143     | 15238  | 3859
> 48   | 2182     | 19015  | 3617
> 72   | 2268     | 19050  | 3662
> 
> (3) 1.5TB nvme (set max_sectors_kb=256)
> 
> 4 read queue, 72 CPU
> 
> IOPS (bs=1MB)
> jobs | 5.6.15 | 5.6.15-patched |
> 1    | 3018   | 3018
> 18   | 3015   | 3016
> 36   | 3001   | 3005
> 54   | 2993   | 2997
> 72   | 2984   | 2990
> 
> context switch per second
> jobs | 5.6.15 | 5.6.15-patched |
> 1    | 6292   | 6469
> 18   | 19428  | 4253
> 36   | 21290  | 3928
> 54   | 23060  | 3957
> 72   | 24221  | 4054
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> Hi,
> 
> We found the problems (excessive context switch and few performance
> degradation) during the performance comparison between blk-sq (4.18)
> and blk-mq (5.16) on HDD, but we can not find a better way to fix it.
> 
> It seems that in order to implement batched request allocation for
> single process, we need to use an atomic variable to track
> the number of busy bits. It's suitable for HDD or SDD, because the
> IO latency is greater than 1ms, but no sure whether or not it's OK
> for NVMe device.

Do you have benchmark on NVMe/SSD with 4k BS?

> 
> Suggestions and comments are welcome.
> 
> Regards,
> Tao
> ---
>  block/blk-mq-tag.c      |  4 ++++
>  include/linux/sbitmap.h |  7 ++++++
>  lib/sbitmap.c           | 49 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 586c9d6e904a..fd601fa6c684 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -180,6 +180,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>  	sbitmap_finish_wait(bt, ws, &wait);
>  
>  found_tag:
> +	if (READ_ONCE(bt->stash_ready) &&
> +	    !atomic_dec_if_positive(&bt->stashed_bits))
> +		WRITE_ONCE(bt->stash_ready, false);
> +

Is it doable to move the above code into sbitmap_queue_do_stash_and_wake_up(),
after wake_up(&ws->wait)?

Or at least it should be done for successful allocation after context
switch?


Thanks, 
Ming

