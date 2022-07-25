Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F036CC43334
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 15:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiGYPnl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiGYPnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 11:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51D91398
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658763819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNyB7toDFaNajhP2JDMJHQNTTUkvEH3wmLgI2/Fgc9o=;
        b=TQkkX6HvJrfPZwRuxrQrojwVV9SlLRbbYBNeRJe18XJ0mNWR7qjQZUYQU/iYGnHp66bVnF
        qc11m6HY57q5Ie0UoRpLvai9Bve+t/d2g8mZLAO0l8tA0Y9qTxMJy1/BnzzmS8gJvLixWs
        g3ZW1wkRQqnzhP0+noZc5lcrs8RsVZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-T-D4Mgi0P8ilF8Bil2GiCg-1; Mon, 25 Jul 2022 11:43:36 -0400
X-MC-Unique: T-D4Mgi0P8ilF8Bil2GiCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 771D185A584;
        Mon, 25 Jul 2022 15:43:35 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A8891415118;
        Mon, 25 Jul 2022 15:43:30 +0000 (UTC)
Date:   Mon, 25 Jul 2022 23:43:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de, yukuai3@huawei.com,
        "zhangyi (F)" <yi.zhang@huawei.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: run queue after issuing the last request of the
 plug list
Message-ID: <Yt66HebQ9//2ahq6@T590>
References: <20220718123528.178714-1-yuyufen@huawei.com>
 <YtZ4uSRqR/kLdqm+@T590>
 <0baa5b04-7194-54fa-08a5-51425601343e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0baa5b04-7194-54fa-08a5-51425601343e@huaweicloud.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 23, 2022 at 10:50:03AM +0800, Yu Kuai wrote:
> Hi, Ming!
> 
> 在 2022/07/19 17:26, Ming Lei 写道:
> > On Mon, Jul 18, 2022 at 08:35:28PM +0800, Yufen Yu wrote:
> > > We do test on a virtio scsi device (/dev/sda) and the default mq
> > > scheduler is 'none'. We found a IO hung as following:
> > > 
> > > blk_finish_plug
> > >    blk_mq_plug_issue_direct
> > >        scsi_mq_get_budget
> > >        //get budget_token fail and sdev->restarts=1
> > > 
> > > 			     	 scsi_end_request
> > > 				   scsi_run_queue_async
> > >                                     //sdev->restart=0 and run queue
> > > 
> > >       blk_mq_request_bypass_insert
> > >          //add request to hctx->dispatch list
> > 
> > Here the issue shouldn't be related with scsi's get budget or
> > scsi_run_queue_async.
> > 
> > If blk-mq adds request into ->dispatch_list, it is blk-mq core's
> > responsibility to re-run queue for moving on. Can you investigate a
> > bit more why blk-mq doesn't run queue after adding request to
> > hctx dispatch list?
> 
> I think Yufen is probably thinking about the following Concurrent
> scenario:
> 
> blk_mq_flush_plug_list
> # assume there are three rq
>  blk_mq_plug_issue_direct
>   blk_mq_request_issue_directly
>   # dispatch rq1, succeed
>   blk_mq_request_issue_directly
>   # dispatch rq2
>    __blk_mq_try_issue_directly
>     blk_mq_get_dispatch_budget
>      scsi_mq_get_budget
>       atomic_inc(&sdev->restarts);
>       # rq2 failed to get budget
>       # restarts is 1 now
>                                         scsi_end_request
>                                         # rq1 is completed
>                                         ┊scsi_run_queue_async
>                                         ┊ atomic_cmpxchg(&sdev->restarts,
> old, 0) == old
>                                         ┊ # set restarts to 0
>                                         ┊ blk_mq_run_hw_queues
>                                         ┊ # hctx->dispatch list is empty
>   blk_mq_request_bypass_insert
>   # insert rq2 to hctx->dispatch list

After rq2 is added to ->dispatch_list in blk_mq_try_issue_list_directly(),
no matter if list_empty(list) is empty or not, queue will be run either from
blk_mq_request_bypass_insert() or blk_mq_sched_insert_requests().

And rq2 should be visible to the run queue, just wondering why rq2 isn't
issued finally?


Thanks, 
Ming

