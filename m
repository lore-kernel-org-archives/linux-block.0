Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7D3C4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 08:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiKQIxb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 03:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiKQIxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 03:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1049D58035
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668675136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73bC3uZ+dPNh8zRXaoFF4b0c1cVAY8n5fvZmGOT3Z5o=;
        b=ACRFbhCMPLJ+LxhhNkExGj0D08d0ce+BIgc6l4BFTZivKRL1YLKBcfpAD2MQil2ouCb26f
        zbANT1syLhk3eqWZiHa2a6DW9Mp/0abwGTNL1bDOmoWngqi2dacKNvt9T9mCIjNof59ekp
        QHPsTyi3Z4AaoQcwliMXPLzPVhGhHKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-AYSrfNWvNKG6PnQHZMunbg-1; Thu, 17 Nov 2022 03:52:12 -0500
X-MC-Unique: AYSrfNWvNKG6PnQHZMunbg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0AB3185A7AB;
        Thu, 17 Nov 2022 08:52:11 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70C3A49BB60;
        Thu, 17 Nov 2022 08:52:07 +0000 (UTC)
Date:   Thu, 17 Nov 2022 16:52:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Reordering of ublk IO requests
Message-ID: <Y3X2M3CSULigQr4f@T590>
References: <87sfii99e7.fsf@wdc.com>
 <Y3WZ41tKFZHkTSHL@T590>
 <87o7t67zzv.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7t67zzv.fsf@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 17, 2022 at 09:05:48AM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > Hi Andreas,
> >
> > On Wed, Nov 16, 2022 at 04:00:15PM +0100, Andreas Hindborg wrote:
> >>
> >> Hi Ming,
> >>
> >> I have a question regarding ublk. For context, I am working on adding
> >> zoned storage support to ublk, and you have been very kind to help me on
> >> Github [1].
> >>
> >> I have a problem with ordering of requests after they are issued to the
> >> ublk driver. Basically ublk will reverse the ordering of requests that are
> >> batched. The behavior can be observed with the following fio workload:
> >>
> >> > fio --name=test --ioengine=io_uring --rw=read --bs=4m --direct=1
> >> > --size=4m --filename=/dev/ublkb0
> >>
> >> For a loopback ublk target I get the following from blktrace:
> >>
> >> > 259,2    0     3469   286.337681303   724  D   R 0 + 1024 [fio]
> >> > 259,2    0     3470   286.337691313   724  D   R 1024 + 1024 [fio]
> >> > 259,2    0     3471   286.337694423   724  D   R 2048 + 1024 [fio]
> >> > 259,2    0     3472   286.337696583   724  D   R 3072 + 1024 [fio]
> >> > 259,2    0     3473   286.337698433   724  D   R 4096 + 1024 [fio]
> >> > 259,2    0     3474   286.337700213   724  D   R 5120 + 1024 [fio]
> >> > 259,2    0     3475   286.337702723   724  D   R 6144 + 1024 [fio]
> >> > 259,2    0     3476   286.337704323   724  D   R 7168 + 1024 [fio]
> >> > 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
> >> > 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
> >> > 259,1    0     1796   286.337816274   390  D   R 2048 + 2048 [ublk]
> >> > 259,1    0     1797   286.337821744   390  D   R 0 + 2048 [ublk]
> >>
> >> And enabling debug prints in ublk shows that the reversal happens when
> >> ublk defers work to the io_uring context:
> >>
> >> > kernel: ublk_queue_rq: qid 0, tag 180, sect 0
> >> > kernel: ublk_queue_rq: qid 0, tag 181, sect 1024
> >> > kernel: ublk_queue_rq: qid 0, tag 182, sect 2048
> >> > kernel: ublk_queue_rq: qid 0, tag 183, sect 3072
> >> > kernel: ublk_queue_rq: qid 0, tag 184, sect 4096
> >> > kernel: ublk_queue_rq: qid 0, tag 185, sect 5120
> >> > kernel: ublk_queue_rq: qid 0, tag 186, sect 6144
> >> > kernel: ublk_queue_rq: qid 0, tag 187, sect 7168
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 187 io_flags 1 addr 7f245d359000, sect 7168
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 186 io_flags 1 addr 7f245fcfd000, sect 6144
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 185 io_flags 1 addr 7f245fd7f000, sect 5120
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 184 io_flags 1 addr 7f245fe01000, sect 4096
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 183 io_flags 1 addr 7f245fe83000, sect 3072
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 182 io_flags 1 addr 7f245ff05000, sect 2048
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 181 io_flags 1 addr 7f245ff87000, sect 1024
> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 180 io_flags 1 addr 7f2460009000, sect 0
> >>
> >> The problem seems to be that the method used to defer work to the
> >> io_uring context, task_work_add(), is using a stack to queue the
> >> callbacks.
> >
> > Is the observation done on zoned ublk or plain ublk-loop?
> 
> I collected this trace on my fork, but since the behavior comes from
> task_work.c using a stack to queue work, it would be present on upstream
> ublk as well. For completeness, I have verified that this is the case.
> 
> > If it is plain ublk-loop, the reverse order can be started from
> > blk_add_rq_to_plug(), but it won't happen for zoned write request
> > which isn't queued to plug list.
> 
> I forgot to mention that I set the deadline scheduler for both ublkb0
> and the loopback target. No reordering should happen in mq with the
> deadline scheduler, as far as I understand.

I meant you need to setup one zoned ublk-loop for observing write request
order, block layer never guarantees request order for other devices.

> 
> >
> > Otherwise, can you observe zoned write req reorder from ublksrv side?
> >
> 
> Yes, the reverse order is observable in ublk server. Reordering happens
> in ublk kernel driver.
> 
> >>
> >> As you probably are aware, writes to zoned storage must
> >> happen at the write pointer, so when order is lost there is a problem.
> >> But I would assume that this behavior is also undesirable in other
> >> circumstances.
> >>
> >> I am not sure what is the best approach to change this behavor. Maybe
> >> having a separate queue for the requests and then only scheduling work
> >> if a worker is not already processing the queue?
> >>
> >> If you like, I can try to implement a fix?
> >
> > Yeah, I think zoned write requests could be forwarded to ublk server out of order.
> 
> In reverse order for requests that are issued without a context switch,
> as far as I can tell.
> 
> >
> > Is it possible for re-order the writes in ublksrv side? I guess it is
> > be doable:
> >
> > 1) zoned write request is sent to ublk_queue_rq() in order always
> >
> > 2) when ublksrv zone target/backend code gets zoned write request in each
> > zone, it can wait until the next expected write comes, then handle the
> > write and advance write pointer, then repeat the whole process.
> >
> > 3) because of 1), the next expected zoned write req is guaranteed to
> > come without much delay, and the per-zone queue won't be long.
> 
> I think it is not feasible to have per zone data structures. Instead, I

If one mapping data structure is used for ordering per-zone write
request, it could be pretty easy, such as C++'s map or hash table, and it
won't take much memory given the max in-flight IOs are very limited and
the zone mapping entry can be reused among different zone, and quite easy
to implement.

Also most of times, the per-zone ordering can be completed in current
batch(requests completed from single io_uring_enter()), then the extra
cost could be close to zero, you can simply run the per-zone ordering in
->handle_io_background() callback, when all requests could come for each
zone most of times.

> considered adding a sequence number to each request, and then queue up
> requests if there is a gap in the numbering.

IMO, that won't be doable, given you don't know when the sequence will be over.

> 
> But really, the issue should be resolved by changing the way
> ublk_queue_rq() is sending work to uring context with task_add_work().

Not sure it can be solved easily given llist is implemented in this way.

> Fixing in ublksrv is a bit of a hack and will have performance penalty.

As I mentioned, ordering zoned write request in each zone just takes
a little memory(mapping, or hashing) and the max size of the mapping
table is queue depth, and basically zero cpu cost, not see extra
performance penalty is involved.

> 
> Also, it can not be good for any storage device to have sequential
> requests delivered in reverse order? Fixing this would benefit all targets.

Only zoned target has strict ordering requirement which does take cost, block
layer never guarantees request order. As I mentioned, blk_add_rq_to_plug()
can re-order requests in reverse order too.

Thanks,
Ming

