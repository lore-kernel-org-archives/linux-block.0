Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5929EC2D0F6
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F4321D7F
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 00:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tYZw2nRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgIPAKM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:10:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13884 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgIOO1d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 10:27:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600180004; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=T07CByCLt8fMh+BxoFxTBhJdisKrHhp41jlw2XwIh7A=;
 b=tYZw2nRt/maOFERn2aSw65O2sMbwBv1MZiBmCex0//Tqwps6Eh+w0nhquu2fgN0uvNMOCYZq
 0m9yY+pL6iipOwYwE+JHjoWahoDIAtV1jo7odRngpLLTEf8wtqYVKnsEwcSUdF1dnlpFzMvW
 reQL/nqsBGYcmk5D2Z1NbkOGnx4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f60c8aad7b4e26913f1c2c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 13:59:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85127C433F1; Tue, 15 Sep 2020 13:59:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 897D5C433C8;
        Tue, 15 Sep 2020 13:59:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 19:29:05 +0530
From:   ppvk@codeaurora.org
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V2] block: Fix use-after-free issue while accessing
 ioscheduler lock
In-Reply-To: <20200915124100.GA778373@T590>
References: <1600161062-43793-1-git-send-email-ppvk@codeaurora.org>
 <20200915100908.GA764869@T590>
 <38dad0eb6f1d719fc877f24cc42902ef@codeaurora.org>
 <20200915124100.GA778373@T590>
Message-ID: <16cea80d8a958c5b93f8d41fa86a6c62@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-15 18:11, Ming Lei wrote:
> On Tue, Sep 15, 2020 at 05:50:33PM +0530, ppvk@codeaurora.org wrote:
>> On 2020-09-15 15:39, Ming Lei wrote:
>> > On Tue, Sep 15, 2020 at 02:41:02PM +0530, Pradeep P V K wrote:
>> > > Observes below crash while accessing (use-after-free) lock member
>> > > of bfq data.
>> > >
>> > > context#1			context#2
>> > > 				process_one_work()
>> > > kthread()			blk_mq_run_work_fn()
>> > > worker_thread()			 ->__blk_mq_run_hw_queue()
>> > > process_one_work()		  ->blk_mq_sched_dispatch_requests()
>> > > __blk_release_queue()		    ->blk_mq_do_dispatch_sched()
>> >
>> > Just found __blk_release_queue killed in v5.9 cycle.
>> >
>> Yes on v5.9 blk_release_queue() will be called directly by q->kobj 
>> when
>> request_queue ref. goes zero but
>> where as on older kernel versions (< 5.9), blk_release_queue() will
>> schedule a work to invoke/call "__blk_release_queue()".
>> 
>> > > ->__elevator_exit()
>> > >   ->blk_mq_exit_sched()
>> > >     ->exit_sched()
>> > >       ->kfree()
>> > >       					->bfq_dispatch_request()
>> > > 					  ->spin_unlock_irq(&bfqd->lock)
>> >
>> > Actually not sure if the above race is easy to trigger in recent kernel,
>> > because we do call cancel_delayed_work_sync() in
>> > blk_mq_hw_sysfs_release(),
>> > which is usually called before __elevator_exit() from
>> > blk_exit_queue()/blk_release_queue().
>> >
>> blk_mq_hw_sysfs_release() will be called from blk_mq_release() i.e. 
>> with
>> kobject_put(hctx->kobj), which is after __elevator_exit()
>> 
>> __elevator_exit() is called from blk_exit_queue() which is prior to
>> blk_mq_release().
>> 
>> > So can you share your kernel version in which the issue is reproduced?
>> > And can you reproduce this issue on v5.8 or v5.9-rc5?
>> >
>> This issue is seen on v5.4 stable and it is very easy to reproduce on 
>> v5.4.
>> sorry, i don't have a resource with v5.8 or with latest kernel. I can 
>> help
>> you
>> to get tested on v5.4. From the issue prospective, both v5.4 kernel 
>> and
>> latest kernels calls blk_mq_release() -> blk_mq_hw_sysfs_release() 
>> after
>> __elevator_exit(). So, i think it wont matter much here.
>> 
>> > >
>> > > This is because of the kblockd delayed work that might got scheduled
>> > > around blk_release_queue() and accessed use-after-free member of
>> > > bfq_data.
>> > >
>> > > 240.212359:   <2> Unable to handle kernel paging request at
>> > > virtual address ffffffee2e33ad70
>> > > ...
>> > > 240.212637:   <2> Workqueue: kblockd blk_mq_run_work_fn
>> > > 240.212649:   <2> pstate: 00c00085 (nzcv daIf +PAN +UAO)
>> > > 240.212666:   <2> pc : queued_spin_lock_slowpath+0x10c/0x2e0
>> > > 240.212677:   <2> lr : queued_spin_lock_slowpath+0x84/0x2e0
>> > > ...
>> > > Call trace:
>> > > 240.212865:   <2>  queued_spin_lock_slowpath+0x10c/0x2e0
>> > > 240.212876:   <2>  do_raw_spin_lock+0xf0/0xf4
>> > > 240.212890:   <2>  _raw_spin_lock_irq+0x74/0x94
>> > > 240.212906:   <2>  bfq_dispatch_request+0x4c/0xd60
>> > > 240.212918:   <2>  blk_mq_do_dispatch_sched+0xe0/0x1f0
>> > > 240.212927:   <2>  blk_mq_sched_dispatch_requests+0x130/0x194
>> > > 240.212940:   <2>  __blk_mq_run_hw_queue+0x100/0x158
>> > > 240.212950:   <2>  blk_mq_run_work_fn+0x1c/0x28
>> > > 240.212963:   <2>  process_one_work+0x280/0x460
>> > > 240.212973:   <2>  worker_thread+0x27c/0x4dc
>> > > 240.212986:   <2>  kthread+0x160/0x170
>> > >
>> > > Fix this by cancelling the delayed work if any before elevator exits.
>> > >
>> > > Changes since V1:
>> > > - Moved the logic into blk_cleanup_queue() as per Ming comments.
>> > >
>> > > Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
>> > > ---
>> > >  block/blk-mq.c | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
>> > > index 4abb714..890fded 100644
>> > > --- a/block/blk-mq.c
>> > > +++ b/block/blk-mq.c
>> > > @@ -2598,6 +2598,7 @@ static void blk_mq_exit_hw_queues(struct
>> > > request_queue *q,
>> > >  			break;
>> > >  		blk_mq_debugfs_unregister_hctx(hctx);
>> > >  		blk_mq_exit_hctx(q, set, hctx, i);
>> > > +		cancel_delayed_work_sync(&hctx->run_work);
>> > >  	}
>> > >  }
>> >
>> > It should be better to move cancel_delayed_work_sync() into
>> > blk_mq_exit_hctx(), exactly before adding hctx into unused list.
>> >
>> Sure. i will do it in my next patch series.
> 
> Thinking of further, looks your 1st post is right, because hw queue
> won't be run when refcount of the queue drops to zero.
> 
ok. Can you help add your Review-by sign off on my V1 patch.
> Sorry for the noise.
> 
never mind - it's ok.

> thanks,
> Ming

Thanks and Regards,
Pradeep

