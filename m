Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA13612DB
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643772; cv=none; b=Ev6sDDnuDIgaWsZ9s1f7/jT7Yb17d14DpWnaDFuYZpNfuDxh0j95DHEc4KQqhAOdi0TrV8Tl3+1EXUrq+SzJhb8LaoCoRnvlE46uNgOkP95PEwOOXnBwy7QU/OI5bPZ1ZTLAaz6tyPGWp2KLzqDM/AQ4pVApBnW3+fDATIYMEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643772; c=relaxed/simple;
	bh=ANNkJxR3/ChrTjPG4Dts/JsR1B14whDVjR7zy47PeCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhgCLUh2XKaXv+dgtRSPwhMXebS3RGFlY7AkKHLfUpxdBF9mHnlFVWVmJYJCTe1A+93/0c/IpuCK0vaetxP0jgSudOJb40XHHbRfSimh3c/L48yB+ZfFJNN2pM0i/Qd2Hp2aPE2mLwIpSz9USc+PMxBZCQ5Wn6IMS+1baZwcf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lArfSTYM; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lArfSTYM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790643766; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i6UohfTDEtrOZmN1+kGyzSeiwH1Za//Zz5svk6oDlAI=;
	b=lArfSTYM9TmrFY32tXjrSme45NkP7j21GpkDBVAdGlozKUQlLbCdQDhZyKHQLdngFqmufyIsvWsP9B9ZgrHn7ozHNfm4TAHtng82UV3nYvESTlRoJZdaGnTr0S7EPs1/on06iVFpsEbwtdBLVUorZ/yEo33wdEAT/skHraVl6dg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XBrLlLz_1790643764;
Received: from 30.221.128.147(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XBrLlLz_1790643764 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 09:02:45 +0800
Message-ID: <616f687a-417e-4fd5-b0dc-9bd519db3920@linux.alibaba.com>
Date: Tue, 29 Sep 2026 09:02:44 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nbd: fix NULL pointer dereference in
 nbd_pending_cmd_work()
To: Bart Van Assche <bvanassche@acm.org>, Josef Bacik <josef@toxicpanda.com>,
 Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org
References: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
 <20260928091021.2456652-2-joseph.qi@linux.alibaba.com>
 <9e43373f-9202-4fa7-b0c8-f1bc80fd81de@acm.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <9e43373f-9202-4fa7-b0c8-f1bc80fd81de@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bart,

On 9/28/26 10:19 PM, Bart Van Assche wrote:
> On 9/28/26 2:10 AM, Joseph Qi wrote:
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index c2c3dbdd631f..9909774dbfbb 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -63,6 +63,7 @@ struct nbd_sock {
>>       int fallback_index;
>>       int cookie;
>>       struct work_struct work;
>> +    struct request *partial_req;
>>   };
>>     struct recv_thread_args {
>> @@ -637,12 +638,24 @@ static void nbd_sched_pending_work(struct nbd_device *nbd,
>>   {
>>       struct request *req = blk_mq_rq_from_pdu(cmd);
>>   -    /* pending work should be scheduled only once */
>> -    WARN_ON_ONCE(test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags));
>> -
>>       nsock->pending = req;
>>       nsock->sent = sent;
>> -    set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
>> +
>> +    /*
>> +     * Already armed: this is nbd_pending_cmd_work() re-entering because the
>> +     * resumed send was interrupted again.  Its work is still running, so
>> +     * just refresh the resume point above and let its loop pick it up
>> +     * instead of taking another config reference and requeueing the work.
>> +     */
>> +    if (test_and_set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
>> +        return;
>> +
>> +    /*
>> +     * nbd_mark_nsock_dead() clears ->pending, so the work function cannot
>> +     * rely on it to find the request it owns.  Keep a copy that only it
>> +     * clears.
>> +     */
>> +    nsock->partial_req = req;
>>       refcount_inc(&nbd->config_refs);
>>       schedule_work(&nsock->work);
>>   }
>> @@ -817,11 +830,12 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>>   static void nbd_pending_cmd_work(struct work_struct *work)
>>   {
>>       struct nbd_sock *nsock = container_of(work, struct nbd_sock, work);
>> -    struct request *req = nsock->pending;
>> +    struct request *req = nsock->partial_req;
>>       struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
>>       struct nbd_device *nbd = cmd->nbd;
>>       unsigned long deadline = READ_ONCE(req->deadline);
>>       unsigned int wait_ms = 2;
>> +    bool complete = false;
>>         mutex_lock(&cmd->lock);
>>   @@ -830,6 +844,18 @@ static void nbd_pending_cmd_work(struct work_struct *work)
>>           goto out;
>>         mutex_lock(&nsock->tx_lock);
>> +    /*
>> +     * nbd_mark_nsock_dead() can tear the socket down between schedule_work()
>> +     * and here, and it clears ->pending and ->sent.  The header is already
>> +     * on the wire so this request can never be answered; fail it rather than
>> +     * resuming a send on a socket that is gone.
>> +     */
>> +    if (!nsock->pending) {
>> +        cmd->status = BLK_STS_IOERR;
>> +        __clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
>> +        complete = true;
>> +        goto unlock;
>> +    }
>>       while (true) {
>>           nbd_send_cmd(nbd, cmd, cmd->index);
>>           if (!nsock->pending)
>> @@ -846,16 +872,36 @@ static void nbd_pending_cmd_work(struct work_struct *work)
>>                * nbd_handle_cmd() requeue every later request forever.
>>                */
>>               nbd_mark_nsock_dead(nbd, nsock, 1);
>> -            blk_mq_complete_request(req);
>> +            complete = true;
>>               break;
>>           }
>>           msleep(wait_ms);
>>           wait_ms *= 2;
>>       }
>> +unlock:
>> +    /*
>> +     * nbd_sched_pending_work() writes partial_req under tx_lock, and
>> +     * cmd->lock is per-command, so this has to be under tx_lock too.
>> +     */
>> +    nsock->partial_req = NULL;
>>       mutex_unlock(&nsock->tx_lock);
>>       clear_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
>>   out:
>>       mutex_unlock(&cmd->lock);
>> +
>> +    /*
>> +     * Complete before nbd_config_put(): if this is the last config
>> +     * reference, nbd_put() runs nbd_dev_remove() inline unless
>> +     * NBD_DESTROY_ON_DISCONNECT is set, and del_gendisk() would then wait
>> +     * in blk_mq_freeze_queue_wait() for the q_usage_counter that this
>> +     * request holds until it is completed.  The config reference is what
>> +     * keeps nbd itself alive across the completion, but cmd must not be
>> +     * touched afterwards, since nbd_complete_rq() may run inline and ends
>> +     * the request without taking cmd->lock.
>> +     */
>> +    if (complete)
>> +        blk_mq_complete_request(req);
>> +
>>       nbd_config_put(nbd);
>>   }
>>   
> 
> These changes add significant complexity and hence make the NBD driver
> harder to maintain. Has it been considered to increase the request
> reference count while nsock->pending != NULL? See also req_ref_inc_not_zero() and blk_mq_put_rq_ref().
> 

Thanks for taking a look.

It seems a request reference can't replace the extra pointer, since the
two answer different questions.

A reference keeps the request object alive, but it doesn't stop
nsock->pending from being cleared, which is what breaks the worker:

  nbd_mark_nsock_dead()
    nsock->dead = true;
    nsock->pending = NULL;
    nsock->sent = 0;

  nbd_pending_cmd_work()
    struct request *req = nsock->pending;
    struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
    struct nbd_device *nbd = cmd->nbd;

Nothing between schedule_work() and the worker starting takes a lock the
teardown path also takes, so pinning the request still leaves the worker
reading NULL from ->pending and faulting on cmd->nbd.

Thanks,
Joseph

