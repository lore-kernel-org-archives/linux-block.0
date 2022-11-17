Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206DCC4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 02:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiKQCTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 21:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKQCTW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 21:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460FBF3
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 18:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668651503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2CDI9upD7lk0Oa6dhckgxA+jWR930Sy/CNbCfrkqDk=;
        b=VPLE/Wfo7BtJWOjfBDMFYPPQO0bejTj1OA52n/9bWZHnrDmRC4gQqkky2wy4p9mqu7Yy9D
        ZbQnLsfQmLLNwCyt2iKxClOuK4vdMBCN3PNShvYZUSU4T806kqvHUv3sdSO4nRl477obKk
        B2KvK6HoZct1r/Xft+FbeCZoKF/ywXI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-gOkXLVz4NAOQOLqEpf61Nw-1; Wed, 16 Nov 2022 21:18:20 -0500
X-MC-Unique: gOkXLVz4NAOQOLqEpf61Nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A65C5811E67;
        Thu, 17 Nov 2022 02:18:19 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2DD840C83C5;
        Thu, 17 Nov 2022 02:18:16 +0000 (UTC)
Date:   Thu, 17 Nov 2022 10:18:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Reordering of ublk IO requests
Message-ID: <Y3WZ41tKFZHkTSHL@T590>
References: <87sfii99e7.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfii99e7.fsf@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Andreas,

On Wed, Nov 16, 2022 at 04:00:15PM +0100, Andreas Hindborg wrote:
> 
> Hi Ming,
> 
> I have a question regarding ublk. For context, I am working on adding
> zoned storage support to ublk, and you have been very kind to help me on
> Github [1].
> 
> I have a problem with ordering of requests after they are issued to the
> ublk driver. Basically ublk will reverse the ordering of requests that are
> batched. The behavior can be observed with the following fio workload:
> 
> > fio --name=test --ioengine=io_uring --rw=read --bs=4m --direct=1
> > --size=4m --filename=/dev/ublkb0
> 
> For a loopback ublk target I get the following from blktrace:
> 
> > 259,2    0     3469   286.337681303   724  D   R 0 + 1024 [fio]
> > 259,2    0     3470   286.337691313   724  D   R 1024 + 1024 [fio]
> > 259,2    0     3471   286.337694423   724  D   R 2048 + 1024 [fio]
> > 259,2    0     3472   286.337696583   724  D   R 3072 + 1024 [fio]
> > 259,2    0     3473   286.337698433   724  D   R 4096 + 1024 [fio]
> > 259,2    0     3474   286.337700213   724  D   R 5120 + 1024 [fio]
> > 259,2    0     3475   286.337702723   724  D   R 6144 + 1024 [fio]
> > 259,2    0     3476   286.337704323   724  D   R 7168 + 1024 [fio]
> > 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
> > 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
> > 259,1    0     1796   286.337816274   390  D   R 2048 + 2048 [ublk]
> > 259,1    0     1797   286.337821744   390  D   R 0 + 2048 [ublk]
> 
> And enabling debug prints in ublk shows that the reversal happens when
> ublk defers work to the io_uring context:
> 
> > kernel: ublk_queue_rq: qid 0, tag 180, sect 0
> > kernel: ublk_queue_rq: qid 0, tag 181, sect 1024
> > kernel: ublk_queue_rq: qid 0, tag 182, sect 2048
> > kernel: ublk_queue_rq: qid 0, tag 183, sect 3072
> > kernel: ublk_queue_rq: qid 0, tag 184, sect 4096
> > kernel: ublk_queue_rq: qid 0, tag 185, sect 5120
> > kernel: ublk_queue_rq: qid 0, tag 186, sect 6144
> > kernel: ublk_queue_rq: qid 0, tag 187, sect 7168
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 187 io_flags 1 addr 7f245d359000, sect 7168
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 186 io_flags 1 addr 7f245fcfd000, sect 6144
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 185 io_flags 1 addr 7f245fd7f000, sect 5120
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 184 io_flags 1 addr 7f245fe01000, sect 4096
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 183 io_flags 1 addr 7f245fe83000, sect 3072
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 182 io_flags 1 addr 7f245ff05000, sect 2048
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 181 io_flags 1 addr 7f245ff87000, sect 1024
> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 180 io_flags 1 addr 7f2460009000, sect 0
> 
> The problem seems to be that the method used to defer work to the
> io_uring context, task_work_add(), is using a stack to queue the
> callbacks.

Is the observation done on zoned ublk or plain ublk-loop?

If it is plain ublk-loop, the reverse order can be started from
blk_add_rq_to_plug(), but it won't happen for zoned write request
which isn't queued to plug list.

Otherwise, can you observe zoned write req reorder from ublksrv side?

> 
> As you probably are aware, writes to zoned storage must
> happen at the write pointer, so when order is lost there is a problem.
> But I would assume that this behavior is also undesirable in other
> circumstances.
> 
> I am not sure what is the best approach to change this behavor. Maybe
> having a separate queue for the requests and then only scheduling work
> if a worker is not already processing the queue?
> 
> If you like, I can try to implement a fix?

Yeah, I think zoned write requests could be forwarded to ublk server out of order.

Is it possible for re-order the writes in ublksrv side? I guess it is
be doable:

1) zoned write request is sent to ublk_queue_rq() in order always

2) when ublksrv zone target/backend code gets zoned write request in each
zone, it can wait until the next expected write comes, then handle the
write and advance write pointer, then repeat the whole process.

3) because of 1), the next expected zoned write req is guaranteed to
come without much delay, and the per-zone queue won't be long.

Thanks, 
Ming

