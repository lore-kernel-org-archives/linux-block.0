Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C61AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 09:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiKQJZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 04:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiKQJYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 04:24:43 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB41571E
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 01:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668677035; x=1700213035;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=CXnzUnnq+Bsgw67iDWzC+M//6YVHNee7b3weGNO/0wA=;
  b=rxll+sEmk1Bgr70FyjH62kSkEsPMVP+9Q1HWDgtD9aRgSqfUA7QJnXIi
   2TQwof47HZcgN7fpyVsYTZ9C1e0wBhVnAEMAQW/SL/peify0ZfXJmWBT7
   ZR95Kf95/CjORi2FmaYJsDEoWsdOuq+P1tdjGj2OnGUjuVQF+lA/X5Dze
   xMR7wLHEKX8SgvKe7JUYetRqvlr8fzvZ5g/z1vnPGlcJQmyyz56elGIOh
   HLvqMyult1YLXFe+GLeVjw1jZaRnZ5yJhOKVUkeGrYVmVoW/uyUQx9KJl
   NNCJpEWbDYN5/+nyAGl8HVBke3ysIhjrnagrf4INNB1P1RIT9Tr1wQanN
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665417600"; 
   d="scan'208";a="328605363"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2022 17:23:54 +0800
IronPort-SDR: P+U3bpwlzW0A7YWCr7/9UpdQL0zFHJ5/RdbHUb/Vv3DgpVBUiOjwrIhnlSfiv+vpTS9Y8oxLBc
 W8PV2s4vdJq/+YIEqK7bmAfHYbr6ujlHsIh0aMvN83L7o/nfi3wvVZNasnBOtNY8Pul3fTsjbM
 /d3bwtUHYsFJKzTjSk87V9muvBJIdpuXQz6x1GOMSgk4jmaaxSREtepjWtZ6tZeylENgN/7RXe
 SnWd3XtXyakT5YufTOSfdijG20356NXN3zzIV94/QVKdoWU/fNd+AS2qZcHtrm66uZqdjvcA3Z
 Scc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2022 00:37:05 -0800
IronPort-SDR: FZwuXNCrO3whymgKqXKN5O7eKnIx9ke50acIzBZ18ws0sK/4dxsKZX5cl9VHYg6S3RhJOU+ErX
 suIwjtvsAIMB9HffEbE6L2TNJ5fIQjYWtObAH4pq05jcODxeCJajzKPMuVLhNW4m9sJ5bqR1jd
 GC3ccSJ6TwLp2Bla3+JSPCJDQj+5Caqr36Fn8dkBZK3Bz3JGfufCZrMGT5OD3F57oTkTkAJQBJ
 M4ehYacHj08Uotk6zBTrV9XuWv52D6/5fSf7eq2Yq0bfQYD1hOixEZug7QKqVujcYHW9NauubS
 OTY=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Nov 2022 01:23:53 -0800
References: <87sfii99e7.fsf@wdc.com> <Y3WZ41tKFZHkTSHL@T590>
 <87o7t67zzv.fsf@wdc.com> <Y3X2M3CSULigQr4f@T590>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <andreas.hindborg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Thu, 17 Nov 2022 10:07:14 +0100
In-reply-to: <Y3X2M3CSULigQr4f@T590>
Message-ID: <87k03u7x3r.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Nov 17, 2022 at 09:05:48AM +0100, Andreas Hindborg wrote:
>>
>> Ming Lei <ming.lei@redhat.com> writes:
>>
>> > Hi Andreas,
>> >
>> > On Wed, Nov 16, 2022 at 04:00:15PM +0100, Andreas Hindborg wrote:
>> >>
>> >> Hi Ming,
>> >>
>> >> I have a question regarding ublk. For context, I am working on adding
>> >> zoned storage support to ublk, and you have been very kind to help me on
>> >> Github [1].
>> >>
>> >> I have a problem with ordering of requests after they are issued to the
>> >> ublk driver. Basically ublk will reverse the ordering of requests that are
>> >> batched. The behavior can be observed with the following fio workload:
>> >>
>> >> > fio --name=test --ioengine=io_uring --rw=read --bs=4m --direct=1
>> >> > --size=4m --filename=/dev/ublkb0
>> >>
>> >> For a loopback ublk target I get the following from blktrace:
>> >>
>> >> > 259,2    0     3469   286.337681303   724  D   R 0 + 1024 [fio]
>> >> > 259,2    0     3470   286.337691313   724  D   R 1024 + 1024 [fio]
>> >> > 259,2    0     3471   286.337694423   724  D   R 2048 + 1024 [fio]
>> >> > 259,2    0     3472   286.337696583   724  D   R 3072 + 1024 [fio]
>> >> > 259,2    0     3473   286.337698433   724  D   R 4096 + 1024 [fio]
>> >> > 259,2    0     3474   286.337700213   724  D   R 5120 + 1024 [fio]
>> >> > 259,2    0     3475   286.337702723   724  D   R 6144 + 1024 [fio]
>> >> > 259,2    0     3476   286.337704323   724  D   R 7168 + 1024 [fio]
>> >> > 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
>> >> > 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
>> >> > 259,1    0     1796   286.337816274   390  D   R 2048 + 2048 [ublk]
>> >> > 259,1    0     1797   286.337821744   390  D   R 0 + 2048 [ublk]
>> >>
>> >> And enabling debug prints in ublk shows that the reversal happens when
>> >> ublk defers work to the io_uring context:
>> >>
>> >> > kernel: ublk_queue_rq: qid 0, tag 180, sect 0
>> >> > kernel: ublk_queue_rq: qid 0, tag 181, sect 1024
>> >> > kernel: ublk_queue_rq: qid 0, tag 182, sect 2048
>> >> > kernel: ublk_queue_rq: qid 0, tag 183, sect 3072
>> >> > kernel: ublk_queue_rq: qid 0, tag 184, sect 4096
>> >> > kernel: ublk_queue_rq: qid 0, tag 185, sect 5120
>> >> > kernel: ublk_queue_rq: qid 0, tag 186, sect 6144
>> >> > kernel: ublk_queue_rq: qid 0, tag 187, sect 7168
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 187 io_flags 1 addr 7f245d359000, sect 7168
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 186 io_flags 1 addr 7f245fcfd000, sect 6144
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 185 io_flags 1 addr 7f245fd7f000, sect 5120
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 184 io_flags 1 addr 7f245fe01000, sect 4096
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 183 io_flags 1 addr 7f245fe83000, sect 3072
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 182 io_flags 1 addr 7f245ff05000, sect 2048
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 181 io_flags 1 addr 7f245ff87000, sect 1024
>> >> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 180 io_flags 1 addr 7f2460009000, sect 0
>> >>
>> >> The problem seems to be that the method used to defer work to the
>> >> io_uring context, task_work_add(), is using a stack to queue the
>> >> callbacks.
>> >
>> > Is the observation done on zoned ublk or plain ublk-loop?
>>
>> I collected this trace on my fork, but since the behavior comes from
>> task_work.c using a stack to queue work, it would be present on upstream
>> ublk as well. For completeness, I have verified that this is the case.
>>
>> > If it is plain ublk-loop, the reverse order can be started from
>> > blk_add_rq_to_plug(), but it won't happen for zoned write request
>> > which isn't queued to plug list.
>>
>> I forgot to mention that I set the deadline scheduler for both ublkb0
>> and the loopback target. No reordering should happen in mq with the
>> deadline scheduler, as far as I understand.
>
> I meant you need to setup one zoned ublk-loop for observing write request
> order, block layer never guarantees request order for other devices.
>
>>
>> >
>> > Otherwise, can you observe zoned write req reorder from ublksrv side?
>> >
>>
>> Yes, the reverse order is observable in ublk server. Reordering happens
>> in ublk kernel driver.
>>
>> >>
>> >> As you probably are aware, writes to zoned storage must
>> >> happen at the write pointer, so when order is lost there is a problem.
>> >> But I would assume that this behavior is also undesirable in other
>> >> circumstances.
>> >>
>> >> I am not sure what is the best approach to change this behavor. Maybe
>> >> having a separate queue for the requests and then only scheduling work
>> >> if a worker is not already processing the queue?
>> >>
>> >> If you like, I can try to implement a fix?
>> >
>> > Yeah, I think zoned write requests could be forwarded to ublk server out of order.
>>
>> In reverse order for requests that are issued without a context switch,
>> as far as I can tell.
>>
>> >
>> > Is it possible for re-order the writes in ublksrv side? I guess it is
>> > be doable:
>> >
>> > 1) zoned write request is sent to ublk_queue_rq() in order always
>> >
>> > 2) when ublksrv zone target/backend code gets zoned write request in each
>> > zone, it can wait until the next expected write comes, then handle the
>> > write and advance write pointer, then repeat the whole process.
>> >
>> > 3) because of 1), the next expected zoned write req is guaranteed to
>> > come without much delay, and the per-zone queue won't be long.
>>
>> I think it is not feasible to have per zone data structures. Instead, I
>
> If one mapping data structure is used for ordering per-zone write
> request, it could be pretty easy, such as C++'s map or hash table, and it
> won't take much memory given the max in-flight IOs are very limited and
> the zone mapping entry can be reused among different zone, and quite easy
> to implement.
>
> Also most of times, the per-zone ordering can be completed in current
> batch(requests completed from single io_uring_enter()), then the extra
> cost could be close to zero, you can simply run the per-zone ordering in
> ->handle_io_background() callback, when all requests could come for each
> zone most of times.
>
>> considered adding a sequence number to each request, and then queue up
>> requests if there is a gap in the numbering.
>
> IMO, that won't be doable, given you don't know when the sequence will be over.

We would not need to know when the sequence is over. If in ubdsrv we see
request number 1,2,4, we could hold 4 until 3 shows up. When 3 shows up
we go ahead and submit all requests from 3 and up, until there is
another gap. If ublk_drv is setting the sequence numbers,
cancelled/aborted requests would not be an issue.

I think this would be less overhead than having per zone data structure.

But I still think it is an unnecessary hack. We could just fix the driver.

>
>>
>> But really, the issue should be resolved by changing the way
>> ublk_queue_rq() is sending work to uring context with task_add_work().
>
> Not sure it can be solved easily given llist is implemented in this way.

If we queue requests on a separate queue, we are fine. I can make a
patch suggestion.

>
>> Fixing in ublksrv is a bit of a hack and will have performance penalty.
>
> As I mentioned, ordering zoned write request in each zone just takes
> a little memory(mapping, or hashing) and the max size of the mapping
> table is queue depth, and basically zero cpu cost, not see extra
> performance penalty is involved.

I could implement all three solutions. 1) fix the dirver, 2) per zone
structure and 3) sequence numbers. Then I benchmark them and we will
know what works. It's a lot of work though.

>
>>
>> Also, it can not be good for any storage device to have sequential
>> requests delivered in reverse order? Fixing this would benefit all targets.
>
> Only zoned target has strict ordering requirement which does take cost, block
> layer never guarantees request order. As I mentioned, blk_add_rq_to_plug()
> can re-order requests in reverse order too.

When mq-deadline scheduler is set for a queue, requests are not
reordered, right?

I am no block layer expert, so I cannot argue about the implementation.
But I think that both spinning rust and flash would benefit from having
sequential requests delivered in order? Would it not hurt performance to
reverse order for sequential requests all the time? I have a hard time
understanding why the block layer would do this by default.

One thing is to offer no guarantees, but to _always_ reverse the
ordering of sequential requests seem a little counter productive to me.

Best regards,
Andreas
