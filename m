Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B719C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44255218D2
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfAYI4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:56:42 -0500
Received: from gfuc.org ([88.99.83.187]:47886 "EHLO gfuc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfAYI4m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 03:56:42 -0500
Received: from [192.168.178.72] (dslb-092-075-200-083.092.075.pools.vodafone-ip.de [92.75.200.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by gfuc.org (Postfix) with ESMTPSA id 847B01E00A5;
        Fri, 25 Jan 2019 08:56:40 +0000 (UTC)
Subject: Re: fsync hangs after scsi rejected a request
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
 <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
 <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
 <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
From:   Florian Stecker <m19@florianstecker.de>
Message-ID: <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de>
Date:   Fri, 25 Jan 2019 09:56:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/19 4:49 AM, jianchao.wang wrote:
> 
> It sounds like not so easy to trigger.
> 
> blk_mq_dispatch_rq_list
>    scsi_queue_rq
>       if (atomic_read(&sdev->device_busy) ||
>         scsi_device_blocked(sdev))
>         ret = BLK_STS_DEV_RESOURCE;             scsi_end_request
>                                                   __blk_mq_end_request
>                                                     blk_mq_sched_restart // clear RESTART
>                                                       blk_mq_run_hw_queue
>                                                   blk_mq_run_hw_queues
>   
>    list_splice_init(list, &hctx->dispatch)
>    needs_restart = blk_mq_sched_needs_restart(hctx)
> 
> The 'needs_restart' will be false, so the queue would be rerun.
> 
> Thanks
> Jianchao

Good point. So the RESTART flag is supposed to protect against this? Now 
I see, this is also sort of what the lengthy comment in 
blk_mq_dispatch_rq_list is saying.

May I complain that this is very unintuitive (the queue gets rerun when 
the RESTART flag is _not_ set) and also unreliable, as not every caller 
of blk_mq_dispatch_rq_list seems to set the flag, and also it does not 
always get cleared in __blk_mq_end_request?

__blk_mq_end_request does the following:

	if (rq->end_io) {
		rq_qos_done(rq->q, rq);
		rq->end_io(rq, error);
	} else {
		if (unlikely(blk_bidi_rq(rq)))
			blk_mq_free_request(rq->next_rq);
		blk_mq_free_request(rq);
	}

and blk_mq_free_request then calls blk_mq_sched_restart, which clears 
the flag. But in my case, rq->end_io != 0, so blk_mq_free_request is 
never called.

On 1/25/19 5:05 AM, Bart Van Assche wrote:
 >
 > Can you have a look at
 > https://bugzilla.kernel.org/show_bug.cgi?id=202353 and see whether that
 > issue is related to what you encountered?
 >
 > Thanks,
 >
 > Bart.

I don't know. My hangs are only up to 30 sec (but that's because BTRFS 
does a transaction every 30s, I don't know what would happen with ext4), 
and for me only one process blocks, everything else still works 
flawlessly. Especially programs which do not fsync are not affected at 
all. If I find some time, I can also try downgrading my kernel to 4.18 
and see if the problem persists.

