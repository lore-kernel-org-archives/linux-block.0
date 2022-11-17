Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07ABC4332F
	for <linux-block@archiver.kernel.org>; Thu, 17 Nov 2022 08:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiKQIV3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Nov 2022 03:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiKQIV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2022 03:21:28 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470156DCD9
        for <linux-block@vger.kernel.org>; Thu, 17 Nov 2022 00:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668673287; x=1700209287;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=KOufQ+xE07mefp5Jz+x9E1jH8W/Zp/5E8HzRGoaWr2I=;
  b=GYfQM+GcPRZ9BsOGiK/MGru02OjqHqMwCRBgm2/j+K1TEERURzs+yz9w
   +opyO1WWwesM2AQeZa27kFdTraXWO70exnCZ1AZMdZHIRkdVd193f6Opz
   RaMUtIkqlaOFgQzJfHLl1mKhePUC6dKAlf3J8oHUF7yF7nrxhf4FMbGH7
   6AkbWnqm2TxSyXROTLs+UmWU3esCisdl3IySo1tw8N96B6JpHyCBpLM1A
   Spon0uNrZlERGdFHASUxNx6ET6CW11HZN46j0oDVDcwMW9+2K++tPssNi
   E0xqcT3gjaI+8WTeVLSpFi89Klpl9eAr71BMmSVyl5BNNrzO+6SyVtTTj
   A==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665417600"; 
   d="scan'208";a="320839820"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2022 16:21:26 +0800
IronPort-SDR: A2rli0CFk+d+F4MhKODvKG2Uxoax1vqGVK1Q5ZeWazoMQiCpvCs0kPrspmYOZI8O2S0VVKloXq
 iphKQpqqUsSX7I7yjTx/KgTlZav32oeJY5i7yObFdXavqerklUfRQ6K77U7nwQWE8P1Bll5nbK
 6J0rrHPn6ud/YbkwEk60cao1PvIGTaHq9OlNw4bAuQgKDEBLQ9olEm0Qd0JVEfoMCxS8PpeurK
 dwlIb2Hdl/aqA5DtwprYUDr3BINYfkcHPrA92nmXFJKI0U98SR8XB4IErDztAIkSNLl+8EHqhR
 /3k=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Nov 2022 23:40:21 -0800
IronPort-SDR: bEuV4zaDGq/SY0xKL4KMSFNYanH5BHyNq4qr/28+xPkbD34ZEH7sf6lVXgQK7/cnOLNDCkfHDF
 I/Y+h8zzdywqAkXfGGuOIzz8B/7PxtDBmSzmkmCAlbDX7kFLFB2mBztKAzbj4gOPqDS3UuOoaa
 cDOamz8iKdLliIBAFfV9aupl5Va3qllZdAmZTApsYCFhk+rdnGItER6T8hSlCzjdQhuV02y9sM
 CNDch720Jjj1f3oBfbHvZs7byoaQ9do4Ii0/Gj+ObkTZc6hoaCIt7VkP/cNdvcM04Sv5arNYjK
 Tlg=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Nov 2022 00:21:25 -0800
References: <87sfii99e7.fsf@wdc.com> <Y3WZ41tKFZHkTSHL@T590>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <andreas.hindborg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Thu, 17 Nov 2022 09:05:48 +0100
In-reply-to: <Y3WZ41tKFZHkTSHL@T590>
Message-ID: <87o7t67zzv.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> Hi Andreas,
>
> On Wed, Nov 16, 2022 at 04:00:15PM +0100, Andreas Hindborg wrote:
>>
>> Hi Ming,
>>
>> I have a question regarding ublk. For context, I am working on adding
>> zoned storage support to ublk, and you have been very kind to help me on
>> Github [1].
>>
>> I have a problem with ordering of requests after they are issued to the
>> ublk driver. Basically ublk will reverse the ordering of requests that are
>> batched. The behavior can be observed with the following fio workload:
>>
>> > fio --name=test --ioengine=io_uring --rw=read --bs=4m --direct=1
>> > --size=4m --filename=/dev/ublkb0
>>
>> For a loopback ublk target I get the following from blktrace:
>>
>> > 259,2    0     3469   286.337681303   724  D   R 0 + 1024 [fio]
>> > 259,2    0     3470   286.337691313   724  D   R 1024 + 1024 [fio]
>> > 259,2    0     3471   286.337694423   724  D   R 2048 + 1024 [fio]
>> > 259,2    0     3472   286.337696583   724  D   R 3072 + 1024 [fio]
>> > 259,2    0     3473   286.337698433   724  D   R 4096 + 1024 [fio]
>> > 259,2    0     3474   286.337700213   724  D   R 5120 + 1024 [fio]
>> > 259,2    0     3475   286.337702723   724  D   R 6144 + 1024 [fio]
>> > 259,2    0     3476   286.337704323   724  D   R 7168 + 1024 [fio]
>> > 259,1    0     1794   286.337794934   390  D   R 6144 + 2048 [ublk]
>> > 259,1    0     1795   286.337805504   390  D   R 4096 + 2048 [ublk]
>> > 259,1    0     1796   286.337816274   390  D   R 2048 + 2048 [ublk]
>> > 259,1    0     1797   286.337821744   390  D   R 0 + 2048 [ublk]
>>
>> And enabling debug prints in ublk shows that the reversal happens when
>> ublk defers work to the io_uring context:
>>
>> > kernel: ublk_queue_rq: qid 0, tag 180, sect 0
>> > kernel: ublk_queue_rq: qid 0, tag 181, sect 1024
>> > kernel: ublk_queue_rq: qid 0, tag 182, sect 2048
>> > kernel: ublk_queue_rq: qid 0, tag 183, sect 3072
>> > kernel: ublk_queue_rq: qid 0, tag 184, sect 4096
>> > kernel: ublk_queue_rq: qid 0, tag 185, sect 5120
>> > kernel: ublk_queue_rq: qid 0, tag 186, sect 6144
>> > kernel: ublk_queue_rq: qid 0, tag 187, sect 7168
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 187 io_flags 1 addr 7f245d359000, sect 7168
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 186 io_flags 1 addr 7f245fcfd000, sect 6144
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 185 io_flags 1 addr 7f245fd7f000, sect 5120
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 184 io_flags 1 addr 7f245fe01000, sect 4096
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 183 io_flags 1 addr 7f245fe83000, sect 3072
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 182 io_flags 1 addr 7f245ff05000, sect 2048
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 181 io_flags 1 addr 7f245ff87000, sect 1024
>> > kernel: __ublk_rq_task_work: complete: op 33, qid 0 tag 180 io_flags 1 addr 7f2460009000, sect 0
>>
>> The problem seems to be that the method used to defer work to the
>> io_uring context, task_work_add(), is using a stack to queue the
>> callbacks.
>
> Is the observation done on zoned ublk or plain ublk-loop?

I collected this trace on my fork, but since the behavior comes from
task_work.c using a stack to queue work, it would be present on upstream
ublk as well. For completeness, I have verified that this is the case.

> If it is plain ublk-loop, the reverse order can be started from
> blk_add_rq_to_plug(), but it won't happen for zoned write request
> which isn't queued to plug list.

I forgot to mention that I set the deadline scheduler for both ublkb0
and the loopback target. No reordering should happen in mq with the
deadline scheduler, as far as I understand.

>
> Otherwise, can you observe zoned write req reorder from ublksrv side?
>

Yes, the reverse order is observable in ublk server. Reordering happens
in ublk kernel driver.

>>
>> As you probably are aware, writes to zoned storage must
>> happen at the write pointer, so when order is lost there is a problem.
>> But I would assume that this behavior is also undesirable in other
>> circumstances.
>>
>> I am not sure what is the best approach to change this behavor. Maybe
>> having a separate queue for the requests and then only scheduling work
>> if a worker is not already processing the queue?
>>
>> If you like, I can try to implement a fix?
>
> Yeah, I think zoned write requests could be forwarded to ublk server out of order.

In reverse order for requests that are issued without a context switch,
as far as I can tell.

>
> Is it possible for re-order the writes in ublksrv side? I guess it is
> be doable:
>
> 1) zoned write request is sent to ublk_queue_rq() in order always
>
> 2) when ublksrv zone target/backend code gets zoned write request in each
> zone, it can wait until the next expected write comes, then handle the
> write and advance write pointer, then repeat the whole process.
>
> 3) because of 1), the next expected zoned write req is guaranteed to
> come without much delay, and the per-zone queue won't be long.

I think it is not feasible to have per zone data structures. Instead, I
considered adding a sequence number to each request, and then queue up
requests if there is a gap in the numbering.

But really, the issue should be resolved by changing the way
ublk_queue_rq() is sending work to uring context with task_add_work().
Fixing in ublksrv is a bit of a hack and will have performance penalty.

Also, it can not be good for any storage device to have sequential
requests delivered in reverse order? Fixing this would benefit all targets.

Best regards,
Andreas
