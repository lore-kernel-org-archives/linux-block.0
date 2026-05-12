Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11A360EC3;
	Tue, 12 May 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586485; cv=none; b=qr1rOflS8gJ7ujFZ+sK1E9Op7FBbMC7Nff+wZ2aB6i4EFF74LUDyYxF8kOCdqwVzRIFuseyd24pb6ILwD1EkaT+ZM7J00qubdD0alLckH2C5Y1aNVwt0z7XmZKdeygKW+TvdaNQDOksj/1Lk5BHD64Z2CEwg5u1oAGBKBrJgRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586485; c=relaxed/simple;
	bh=xW0IXLghbN2fcgVFjinBuP6pTZHAYH4U0nAUGnGBIlc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eshBKX+0AiuIIFFI7j8zOqleoEIRHB4tqhoew+boxZUok/OLPmEL5PIBXkbV4Re+bf5MeCML2c5WwB2af1jMsG3eKYgaH77t4ygnYnpFna4IxLSZ99+syNcDM/Ep8KsvwsVAAVPrkHtF+F6wY9za+6xN1gGHC4qMn+zogP53f+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64CBkqIY090642;
	Tue, 12 May 2026 20:46:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64CBkq4o090638
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 12 May 2026 20:46:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <af2205e3-205e-4743-a767-8593c2c4747a@I-love.SAKURA.ne.jp>
Date: Tue, 12 May 2026 20:46:51 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: Fix NULL pointer dereference by synchronizing
 lo_release and loop_queue_rq
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com>
 <e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp>
 <e33b4060-69d9-4d02-a330-2fbd19249237@I-love.SAKURA.ne.jp>
 <c0047a38-3d02-4ce5-88b0-2b7d0b9b69fa@acm.org>
 <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <f720dd8b-4aa3-48e4-a1bb-c0b43eb70f19@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

Commit 99ebc509eef5 ("mm: memcontrol: fix rcu unbalance in get_non_dying_memcg_end()") fixed
RCU imbalance bug, and it seems that so far only trees without that commit is reproducing RCU
imbalance bug.

But since this NULL pointer dereference bug was reproduced in linux-next-20260508 which already
includes that commit, I suspect that some change in the block layer broke protection by RCU
synchronization or flushing of lo->workqueue.

Can you check that there was no commit that might break protection by RCU synchronization or
flushing of lo->workqueue?

On 2026/05/12 2:43, Tetsuo Handa wrote:
> Thank you for responding.
> 
> Given it is protected by RCU, this might be yet another manifestation of
> "is trying to release lock (rcu_read_lock) at:" + "but there are no more locks to release!"-type of
> hidden RCU imbalance bugs recently introduced? Andrew, was any progress made for RCU imbalance bugs?
> 
> On 2026/04/21 20:05, Tetsuo Handa wrote:
>> Since this problem started after the merge window opened, the culprit commit
>> might be in between commit a028739a4330 ("Merge tag 'block-7.0-20260305' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux") and
>> commit 7fe6ac157b7e ("Merge tag 'for-7.1/block-20260411' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux").
>> Also, syzbot was not testing changes in linux-next since next-20260403,
>> and found this problem in next-20260413.
> 
> On 2026/05/12 0:58, Bart Van Assche wrote:
>> Why SRCU instead of RCU? The loop driver doesn't set BLK_MQ_F_BLOCKING
>> and hence must not sleep inside loop_queue_rq(). Additionally, the block
>> layer already holds an RCU lock around all loop_queue_rq() calls. From
>> block/blk-mq.h:
>>
>> /* run the code block in @dispatch_ops with rcu/srcu read lock held */
>> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)    \
>> do {                                \
>>     if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {        \
>>         struct blk_mq_tag_set *__tag_set = (q)->tag_set; \
>>         int srcu_idx;                    \
>>                                 \
>>         might_sleep_if(check_sleep);            \
>>         srcu_idx = srcu_read_lock(__tag_set->srcu);    \
>>         (dispatch_ops);                    \
>>         srcu_read_unlock(__tag_set->srcu, srcu_idx);    \
>>     } else {                        \
>>         rcu_read_lock();                \
>>         (dispatch_ops);                    \
>>         rcu_read_unlock();                \
>>     }                            \
>> } while (0)

