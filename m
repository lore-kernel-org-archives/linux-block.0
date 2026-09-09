Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909CA3BB110;
	Wed,  9 Sep 2026 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982414; cv=none; b=XHRx5kqCK3brpG6BCTHt2mebnd6wlH3tjSZcUK96QeyqQC6NsGtN5qjktuIadEEbYV4ITSKQwJThCGGdmYdPwf6eIzfVI+3AJmUWsBjtTVg7SdrUnhWzOsSX2XFS4z/gw4r+6Ru89U2sQt5Yp+EJ+AcA1NmckqpkU0NkVtWcM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982414; c=relaxed/simple;
	bh=lRf4doFxjh5R8Got29jD6qo6e/jvro8p8JR2RMP5SYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc3dYQ/FbLBbfjablok+Ya8OoacmL11KSceWJT34vwF1iO6n+GubWugwfykdmiEfjsPovWcMT/fNKtpIKJBdidDu1wDcTCQEepv97rsA77daXfpa99fjfG+vzSjyPTJdQ4Ly/DokvmEYiiPDdxt8vwM3GOTbVQ9b9TI9pWg24uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tL18RP3Q; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tL18RP3Q"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hg9vv54kwzlfvpK;
	Wed,  9 Sep 2026 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1788982402; x=1791574403; bh=bjzNIaOj3ImqFo+3+IGtBCE/
	TeEVVpDzTJPPWjdYOcY=; b=tL18RP3QqkeqxSX/qQ/tdjqu5D3lefHdMcJEb6dN
	8M3UE3fFsdFEEL4fMvU8FjIGm/I8ZJfbz9ff3rUnwTm/qVvSiOMUsAlMr5mA/XBZ
	4UoZWDkAriWR0KFfT/zm7CYvhq7IiKB6cIdpqjn+xymx56QL/OXS2w8jTOuBfD34
	mX0vupFX4Cc+2NoIPnyLjLrkHr36/jMBvHqrXrY3NAQTqbZdOrX8AARfwzgiDOGu
	oI0HyeKnTBts9O//dWB3By3P+GZlnQ/949/ay2qpk3texjKIT7kKY36OUNRx5wi0
	HxCBz662O9PncK57/p92BYugNpIYzUhAkgudq+u8jjBLbQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id V8ccHdv1lQOk; Wed,  9 Sep 2026 19:33:22 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:4c9b:48ad:ee5f:1c23] (unknown [104.135.182.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hg9vf336GzlfvpG;
	Wed,  9 Sep 2026 19:33:17 +0000 (UTC)
Message-ID: <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
Date: Wed, 9 Sep 2026 12:33:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 linux-block <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 3:49 AM, Tetsuo Handa wrote:
> -static void __loop_clr_fd(struct loop_device *lo)
> +static void __loop_clr_fd(struct work_struct *work)
>   {
> +	struct loop_device *lo = container_of(work, struct loop_device, lo_clr_work);
> +	struct gendisk *disk = lo->lo_disk;
>   	struct queue_limits lim;
>   	struct file *filp;
>   	gfp_t gfp = lo->old_gfp_mask;
>   	int err;
>   
> +	/* Step 1: Flush all outstanding I/O, without open_mutex held. */
> +	/*
> +	 * Since loop_queue_rq() is called with RCU read lock, this synchronize_rcu()
> +	 * makes sure that no more queue_work() calls are made from loop_queue_work()
> +	 * from loop_queue_rq(). Subsequent loop_queue_rq() calls which are made after
> +	 * this synchronize_rcu() returned shall see lo->lo_state != Lo_bound and
> +	 * return with BLK_STS_IOERR.
> +	 */
> +	synchronize_rcu();
> +	/*
> +	 * This drain_workqueue() makes sure that no more loop_handle_cmd() calls are
> +	 * made from loop_process_work() from loop_workfn()/loop_rootcg_workfn().
> +	 */
> +	drain_workqueue(lo->workqueue);
> +	/*
> +	 * This blk_mq_freeze_queue() waits for completion of all outstanding I/O
> +	 * which has been scheduled via loop_queue_rq(), by waiting for q_usage_counter
> +	 * to reach 0. Since the lo->lo_state != Lo_bound check in loop_queue_rq()
> +	 * guarantees that no more new I/O requests are made, we can call
> +	 * blk_mq_unfreeze_queue() immediately after blk_mq_freeze_queue() returns.
> +	 */
> +	blk_mq_unfreeze_queue(lo->lo_queue, blk_mq_freeze_queue(lo->lo_queue));
> +
> +	/* Step 2: Perform remaining cleanup, with open_mutex held. */
> +	mutex_lock(&disk->open_mutex);
> +	WARN_ON_ONCE(lo->lo_state != Lo_rundown);
__loop_clr_fd() is queued from the lo_post_release() callback and hence
may be called concurrently with or after another thread has called
bdev_open(). Hence, lo->lo->state should be checked instead of assuming
that it equals Lo_rundown.

Thanks,

Bart.
