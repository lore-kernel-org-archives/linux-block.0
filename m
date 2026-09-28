Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F149892B
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605190; cv=none; b=FBjq3cljJV+yaaFoHSX4Y9wfdmnAL0gzb7fADTrmbiFevWaV1Oy4u6Zygoc/+gmmOIQotM2D8aibExRXqTjJjSvVFrotGaOxhiZXzaTI2hretql3DUUAV3iUl9IyDTfbj3dp/QjATnbom7aAlNDN/Bt+2EoZmVbUKqmxYn7DjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605190; c=relaxed/simple;
	bh=EzD8VcbLsgl7v4VmrNks4hgH97tQxGWWNVtm52Gq5Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCYLdfFit7LEF2nG+xleYTSmT9SFArZhS0+IiO3oVCtl7DDMz2hbW6gbV94S5bibYjVU+GiXuJqVGE3/dxTGCgC4sLHLvQUUQXeEZ9tWj6PH05u7NLPe8mU3iQqy9vjhPazLHnN4fIbb9VkrTBB11qiB9WQXsZOJZVxfbgEHI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vbBj6C33; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vbBj6C33"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4htk325rLqzlfddd;
	Mon, 28 Sep 2026 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790605177; x=1793197178; bh=9X1hCpVhoPgiziZS6p8/R0Ct
	cmstKqCYzEDbCZ3eVJc=; b=vbBj6C33uPyVUvVmFSC1tQSdQWrzvZUObUe4lsJV
	S/tWK6pVYtk9afMUQBJ3YOjVBDy4rAJSdrqs2aB3yrM2XosE5Zq93RFrENsaU9uZ
	LqTbPpDugowcQgEzXVPoJPfqLtCrN8p3PMytXSn2tgNzIPLgdmyUvx2YZwZZH51p
	YAecu3wSoLP3BXsDtw7Cve4fRwn4whXEItxBnoseoKgmJDvQuMNptpzo2j2sWE9h
	NakoqucV2YDj4aDfxR3CQeACXR5iCpt6U+Oxkd0gXQLPdST2sO9+9bYbFy/lpepp
	dxUx7nJCp2oUj67O+KyuGc46Q4vTI48Hv7/sMwSeELOQNg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9_ViBxm0Vmm2; Mon, 28 Sep 2026 14:19:37 +0000 (UTC)
Received: from [192.168.0.215] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4htk2t6bjXzlfgPs;
	Mon, 28 Sep 2026 14:19:34 +0000 (UTC)
Message-ID: <9e43373f-9202-4fa7-b0c8-f1bc80fd81de@acm.org>
Date: Mon, 28 Sep 2026 07:19:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nbd: fix NULL pointer dereference in
 nbd_pending_cmd_work()
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <tom.leiming@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org
References: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
 <20260928091021.2456652-2-joseph.qi@linux.alibaba.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260928091021.2456652-2-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 2:10 AM, Joseph Qi wrote:
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c2c3dbdd631f..9909774dbfbb 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -63,6 +63,7 @@ struct nbd_sock {
>   	int fallback_index;
>   	int cookie;
>   	struct work_struct work;
> +	struct request *partial_req;
>   };
>   
>   struct recv_thread_args {
> @@ -637,12 +638,24 @@ static void nbd_sched_pending_work(struct nbd_device *nbd,
>   {
>   	struct request *req = blk_mq_rq_from_pdu(cmd);
>   
> -	/* pending work should be scheduled only once */
> -	WARN_ON_ONCE(test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags));
> -
>   	nsock->pending = req;
>   	nsock->sent = sent;
> -	set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
> +
> +	/*
> +	 * Already armed: this is nbd_pending_cmd_work() re-entering because the
> +	 * resumed send was interrupted again.  Its work is still running, so
> +	 * just refresh the resume point above and let its loop pick it up
> +	 * instead of taking another config reference and requeueing the work.
> +	 */
> +	if (test_and_set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
> +		return;
> +
> +	/*
> +	 * nbd_mark_nsock_dead() clears ->pending, so the work function cannot
> +	 * rely on it to find the request it owns.  Keep a copy that only it
> +	 * clears.
> +	 */
> +	nsock->partial_req = req;
>   	refcount_inc(&nbd->config_refs);
>   	schedule_work(&nsock->work);
>   }
> @@ -817,11 +830,12 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>   static void nbd_pending_cmd_work(struct work_struct *work)
>   {
>   	struct nbd_sock *nsock = container_of(work, struct nbd_sock, work);
> -	struct request *req = nsock->pending;
> +	struct request *req = nsock->partial_req;
>   	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
>   	struct nbd_device *nbd = cmd->nbd;
>   	unsigned long deadline = READ_ONCE(req->deadline);
>   	unsigned int wait_ms = 2;
> +	bool complete = false;
>   
>   	mutex_lock(&cmd->lock);
>   
> @@ -830,6 +844,18 @@ static void nbd_pending_cmd_work(struct work_struct *work)
>   		goto out;
>   
>   	mutex_lock(&nsock->tx_lock);
> +	/*
> +	 * nbd_mark_nsock_dead() can tear the socket down between schedule_work()
> +	 * and here, and it clears ->pending and ->sent.  The header is already
> +	 * on the wire so this request can never be answered; fail it rather than
> +	 * resuming a send on a socket that is gone.
> +	 */
> +	if (!nsock->pending) {
> +		cmd->status = BLK_STS_IOERR;
> +		__clear_bit(NBD_CMD_INFLIGHT, &cmd->flags);
> +		complete = true;
> +		goto unlock;
> +	}
>   	while (true) {
>   		nbd_send_cmd(nbd, cmd, cmd->index);
>   		if (!nsock->pending)
> @@ -846,16 +872,36 @@ static void nbd_pending_cmd_work(struct work_struct *work)
>   			 * nbd_handle_cmd() requeue every later request forever.
>   			 */
>   			nbd_mark_nsock_dead(nbd, nsock, 1);
> -			blk_mq_complete_request(req);
> +			complete = true;
>   			break;
>   		}
>   		msleep(wait_ms);
>   		wait_ms *= 2;
>   	}
> +unlock:
> +	/*
> +	 * nbd_sched_pending_work() writes partial_req under tx_lock, and
> +	 * cmd->lock is per-command, so this has to be under tx_lock too.
> +	 */
> +	nsock->partial_req = NULL;
>   	mutex_unlock(&nsock->tx_lock);
>   	clear_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
>   out:
>   	mutex_unlock(&cmd->lock);
> +
> +	/*
> +	 * Complete before nbd_config_put(): if this is the last config
> +	 * reference, nbd_put() runs nbd_dev_remove() inline unless
> +	 * NBD_DESTROY_ON_DISCONNECT is set, and del_gendisk() would then wait
> +	 * in blk_mq_freeze_queue_wait() for the q_usage_counter that this
> +	 * request holds until it is completed.  The config reference is what
> +	 * keeps nbd itself alive across the completion, but cmd must not be
> +	 * touched afterwards, since nbd_complete_rq() may run inline and ends
> +	 * the request without taking cmd->lock.
> +	 */
> +	if (complete)
> +		blk_mq_complete_request(req);
> +
>   	nbd_config_put(nbd);
>   }
>   

These changes add significant complexity and hence make the NBD driver
harder to maintain. Has it been considered to increase the request
reference count while nsock->pending != NULL? See also 
req_ref_inc_not_zero() and blk_mq_put_rq_ref().

Thanks,

Bart.
