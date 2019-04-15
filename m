Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B93C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EB720833
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 09:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDOJqG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:46:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfDOJqG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 05:46:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 981F6B020;
        Mon, 15 Apr 2019 09:46:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Apr 2019 11:46:04 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        shirley.ma@oracle.com, martin.petersen@oracle.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block-owner@vger.kernel.org
Subject: Re: [RESEND PATCH] blk-mq: fix hang caused by freeze/unfreeze
 sequence
In-Reply-To: <0763cb5a-5598-69e3-e5ac-765989aab5b1@acm.org>
References: <20190409090828.16282-1-bob.liu@oracle.com>
 <0763cb5a-5598-69e3-e5ac-765989aab5b1@acm.org>
Message-ID: <84cf04edf8f3f3b87b78383a1837aff3@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-04-13 05:42, Bart Van Assche wrote:
> On 4/9/19 2:08 AM, Bob Liu wrote:
>>  void blk_freeze_queue_start(struct request_queue *q)
>>  {
>> -	int freeze_depth;
>> -
>> -	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
>> -	if (freeze_depth == 1) {
>> +	mutex_lock(&q->mq_freeze_lock);
>> +	if (++q->mq_freeze_depth == 1) {
>>  		percpu_ref_kill(&q->q_usage_counter);
>> +		mutex_unlock(&q->mq_freeze_lock);
>>  		if (queue_is_mq(q))
>>  			blk_mq_run_hw_queues(q, false);
>> +	} else {
>> +		mutex_unlock(&q->mq_freeze_lock);
>>  	}
>>  }
> Have you considered to move the mutex_unlock() call to the end of the 
> function
> such that there is only one mutex_unlock() call instead of two? In case 
> you
> would be worried about holding the mutex around the code that runs the 
> queue,
> how about changing the blk_mq_run_hw_queues() call such that the queues 
> are
> run async?

Hi Bart,

The only purpose of 'mq_freeze_lock' is to avoid race between 
mq_freeze_depth
variable and the following usage of q_usage_counter percpu ref.  I admit 
that
my original comment is quite unclear, but locked section should be as 
short
as possible, so returning to your question: better to have two unlock 
calls
instead of expanding locked critical section.

Unfortunately I do not have hardware to play again with the issue, but I 
see
there is a nice candidate for a quick reproduction:  null_blk queues 
with
shared tags.  Having several queues with shared tags and a script, which
powers on/off (I mean 'power' entry of configfs of the null_blk) 
different
null devices from different cpus it is quite possible to trigger the 
issue.
Random short msdelay() in correct places can help to increase 
probability to
hit the issue quite fast.


But Bob, what is the backtrace of the issue you hit?  What is the 
device?
Conditions to reproduce the issue are quite specific and frankly I did 
not
find any "naked" (without any locks) calls of blk_mq_freeze/unfreeze 
sequence,
the only candidate which I found, seems, null_blk (not 100% sure, but 
worth to
try).


--
Roman
