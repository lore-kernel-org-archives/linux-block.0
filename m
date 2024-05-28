Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2610E9
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855139; cv=none; b=l8xp/6/Hom6zlTyxIqduAciudSk4HTKT9gxcv0vAa+TrZMPjvWqugIBDBQghgRXfGcLTSywkJC1Rrnb0rOKb4s/zsatWq1/z8gczVNb48h8pfecLESlpxny2Yam5bgeWEpwsn1dBmP/piU77x222/j09U+PKWPm+J34cy9vVLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855139; c=relaxed/simple;
	bh=A8DALDHd3MMh4OXdcMx5E3c0mAWR9NDzuk63Jb+1Yfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz8AGYfWac/DTb8Auz0CipmY13muxJ/z3XY4AaYyzNWsdT9YyXxSvvwAsadCfg/nitslFQq9z36PA/Xx6dOw5vPuL0ZSJHGpt18d21RnhCM1v82wHPKqwbk8VqZTWD78befpwGlEInJTX0xS88m/GolTFqlm98sTPO3k38537dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ETclSgOB; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ETclSgOB"
X-Envelope-To: f.weber@proxmox.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716855135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMJ0eL3rp/jBrLY+934O2yj2Yff8RteD+peA5AFBPDM=;
	b=ETclSgOBPawhuiJFChrFz0JsNyCvbhlqdJIsq2W/x40B21KJdvsG/9P30h1qDRutJIcRzp
	gYkYUItWeuzdccAxOnB8LnkzvrMiyFsSqN4GqcNqpIgltEtUquFn4cZ1RzhrZiSNY4NQ7z
	Xl3iKDsQSkwD6xRt3+Uw6FzC63F/cIs=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: hch@lst.de
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zhouchengming@bytedance.com
Message-ID: <87f495c2-7504-4d22-b355-608b13c456cd@linux.dev>
Date: Tue, 28 May 2024 08:12:07 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
Content-Language: en-US
To: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
 ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
 <20230717040058.3993930-5-chengming.zhou@linux.dev>
 <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com>
 <984f1f77-288c-441a-a649-5f320249b576@linux.dev>
 <4d799672-378b-42b1-896b-38df2c5e9c84@proxmox.com>
 <0783d367-4608-4b16-9b88-6eaf5d5706eb@linux.dev>
 <8b1400e6-b35e-486b-8ea0-de76270267c0@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <8b1400e6-b35e-486b-8ea0-de76270267c0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/5/28 07:50, Chengming Zhou wrote:
> On 2024/5/28 07:34, Chengming Zhou wrote:
>> On 2024/5/28 00:04, Friedrich Weber wrote:
>>> Hi Chengming,
>>>
>>> Thank you for taking a look at this!
>>>
>>> On 27/05/2024 07:09, Chengming Zhou wrote:
>>>>> I've used this reproducer for a bisect, which produced
>>>>>
>>>>>  81ada09cc25e (blk-flush: reuse rq queuelist in flush state machine)
>>>>>
>>>>> as the first commit with which I can reproduce the crashes. I'm not 100%
>>>>> sure it is this one because the reproducer is a bit flaky. But it does
>>>>> sound plausible, as the commit is included in our 6.8 kernel, and
>>>>> touches `queuelist` which is AFAICT where blk_flush_complete_seq
>>>>> dereferences the NULL pointer.
>>>>
>>>> Ok, it will be better that I can reproduce it locally, will try later.
>>>
>>> Interestingly, so far I haven't been able to reproduce the crash when
>>> generating IO on the host itself, I only got crashes when generating IO
>>> in a QEMU VM.
>>>
>>> The reproducer in more detail:
>>
>> Thanks for these details, I will try to setup and reproduce when I back to work.
>>
>>>
>>> - Compile Linux 6.9 with CONFIG_FAULT_INJECTION,
>> [...]
>>>>
>>>> BUG shows it panic on 0000000000000008, not sure what it's accessing then,
>>>> does it means rq->queuelist.next == 0 or something? Could you use add2line
>>>> to show the exact source code line that panic? I use blk_flush_complete_seq+0x296/0x2e0
>>>> and get block/blk-flush.c:190, which is "fq->flush_data_in_flight++;",
>>>> obviously fq can't be NULL. (I'm using the v6.9 kernel)
>>>
>>> Sorry for the confusion, the crash dump was from a kernel compiled at
>>> 81ada09cc25e -- with 6.9, the offset seems to be different. See [2] for
>>> a kernel 6.9 crash dump.
>>>
>>> I don't know too much about kernel debugging, but I tried to get
>>> something useful out of addr2line:
>>>
>>> # addr2line -f -e /usr/lib/debug/vmlinux-6.9.0-debug2
>>> blk_flush_complete_seq+0x291/0x2d0
>>> __list_del
>>> /[...]./include/linux/list.h:195
>>>
>>> I tried to find the relevant portions in `objdump -SD blk-flush.o`, see
>>> [3]. If I'm not mistaken, blk_flush_complete_seq+0x291 should point to
>>>
>>> 351:   48 89 4f 08             mov    %rcx,0x8(%rdi)
>>>
>>> To me this looks like part of
>>>
>>> 	list_move_tail(&rq->queuelist, pending);
>>>
>>> What do you think?
>>
>> Yeah, it seems correct, so the rq->queuelist.next == NULL. It can't be NULL
>> if went through REQ_FSEQ_POSTFLUSH, so it must be REQ_FSEQ_PREFLUSH. It means
>> we allocated a request but its queuelist is not initialized or corrupted?
>>
>> Anyway, I will use below changes for debugging when reproduce, and you could
>> also try this to see if we could get something useful. :)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 3b4df8e5ac9e..6e3a6cd7739d 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2989,6 +2989,8 @@ void blk_mq_submit_bio(struct bio *bio)
>>                 blk_mq_use_cached_rq(rq, plug, bio);
>>         }
>>
>> +       BUG_ON(rq->queuelist.next == NULL);
>> +
>>         trace_block_getrq(bio);
>>
>>         rq_qos_track(q, rq, bio);
>> @@ -3006,6 +3008,8 @@ void blk_mq_submit_bio(struct bio *bio)
>>         if (bio_zone_write_plugging(bio))
>>                 blk_zone_write_plug_init_request(rq);
>>
>> +       BUG_ON(rq->queuelist.next == NULL);
>> +
>>         if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
>>                 return;
>>
> 
> Ah, I forgot to change to your kernel version, then should be:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d98654869615..908fdfb62132 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2963,6 +2963,8 @@ void blk_mq_submit_bio(struct bio *bio)
>                         return;
>         }
> 
> +       BUG_ON(rq->queuelist.next == NULL);
> +
>         trace_block_getrq(bio);
> 
>         rq_qos_track(q, rq, bio);
> @@ -2977,6 +2979,8 @@ void blk_mq_submit_bio(struct bio *bio)
>                 return;
>         }
> 
> +       BUG_ON(rq->queuelist.next == NULL);
> +
>         if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
>                 return;
> 

Another possibility is that drivers may change rq->queuelist even after
rq->end_io(). So add two more BUG_ON() to detect this:

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e73dc22d05c1..0eb684a468e5 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -179,7 +179,10 @@ static void blk_flush_complete_seq(struct request *rq,

        switch (seq) {
        case REQ_FSEQ_PREFLUSH:
+               BUG_ON(rq->queuelist.next == NULL);
+               fallthrough;
        case REQ_FSEQ_POSTFLUSH:
+               BUG_ON(rq->queuelist.next == NULL);
                /* queue for flush */
                if (list_empty(pending))
                        fq->flush_pending_since = jiffies;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d98654869615..908fdfb62132 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2963,6 +2963,8 @@ void blk_mq_submit_bio(struct bio *bio)
                        return;
        }

+       BUG_ON(rq->queuelist.next == NULL);
+
        trace_block_getrq(bio);

        rq_qos_track(q, rq, bio);
@@ -2977,6 +2979,8 @@ void blk_mq_submit_bio(struct bio *bio)
                return;
        }

+       BUG_ON(rq->queuelist.next == NULL);
+
        if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
                return;
