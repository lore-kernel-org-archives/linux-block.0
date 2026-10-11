Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E73E44ED;
	Sun, 11 Oct 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725724; cv=none; b=eealgFnU3JoCU1lBp6efrzba0kmP+l0jY2mpjkazauM81PWr7B7lynV+fMQI5GKql4DlyrSc0QJlHMIAPbcad9TrZxZgzN0t0uiwnEuUZSv3S+8By0h6Y5r2rry26yq2Zn7+FqBbq0OA/AvkCVo8AuJEdVDkbHuqeC4n3Uq0ZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725724; c=relaxed/simple;
	bh=olEQ7uTMIRyhlqZfPRhlLG7sAoLaTK+ei5OoxwQo/wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/HNAyo8rRfdB5FSsJE2ZYs/PW22ODSzKcvPpir7VV63S3MpuBwdoo/etlXt2ctUgF1obhbKQoZ3iOUBIV9bBcWY1suuI1uqWIPAdH37n+hMwxfqEgy/dyhE2FmugYRvqSw/hrkfP6pHp/YGIwqsEcW0x6FCPElWNMCqEMHdnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eTrTf8PY; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eTrTf8PY"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4j2hRk0hfRzlfvpn;
	Sun, 11 Oct 2026 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791725709; x=1794317710; bh=2BBs7ABEyUHXGEcdvbeBCH4b
	I40jWt5rrxWkfA8f2As=; b=eTrTf8PYm4gxE/vGgQAQ588nJLoYW/+HqvRCg5ZQ
	V/x9+Z2MGz9jWa6HgfWRWv5KmOmgx1rdLIi9FJZIkv9AW1DvE3C6xnro/Ub+CC3i
	d/nyCNZYN3REiF5kuyOqCJVCIATijNcVJiB4M/N6IfS2A0ez1wqvqZcch1jySg3x
	iVoMblvqjGKMqkdBcilC3v5AU5kI7nY3GdsYTTfD7qpuV/EiYuMeW0Dbe0mk2J7b
	dZwQ6HFXFxuaB0JWms7pwuS4KxHawvK1ZQcsdOscxSd5wWxVXr0eskPZWbWWu3Vt
	6XXXdmNKLZfad0lZ+UOJYHvI2xmBktgi5tx288gci6WlxA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GMHwyDnBMJAp; Sun, 11 Oct 2026 13:35:09 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4j2hRc45mMzlfvpb;
	Sun, 11 Oct 2026 13:35:08 +0000 (UTC)
Message-ID: <8733b34f-45be-4395-8575-53690c1c406f@acm.org>
Date: Sun, 11 Oct 2026 06:35:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fail requests stuck on a dead socket when timeout is
 0
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, josef@toxicpanda.com,
 axboe@kernel.dk
Cc: mchristi@redhat.com, linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org,
 syzbot+90895f5bfaa7243c2d20@syzkaller.appspotmail.com
References: <20261011033739.18434-1-ngocthang2710.1999@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261011033739.18434-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/26 8:37 PM, Nguyen Ngoc Thang wrote:
> With a zero command timeout, nbd_xmit_timeout() only logs a "possible
> stuck request" message and resets the timer. A request already sent on
> a socket that has since died is never completed this way, because
> nothing will ever answer it.
> 
> That blocks nbd_set_size(), which freezes the queue while holding
> nbd->config_lock and genl_mutex. The freeze waits for the stuck request
> forever, and reconnecting a socket (which would change the cookie and
> get the request requeued) can't happen as it is handled later by the
> same reconfigure call. Everything touching the device then hangs,
> including partition scanning in udev:
> 
>    INFO: task udevd blocked for more than 143 seconds.
>     __bio_queue_enter+0x369/0x7f0 block/blk-core.c:396
>     blk_mq_submit_bio+0x776/0x2a70 block/blk-mq.c:3127
>     ...
>    INFO: task syz.0.17 blocked for more than 143 seconds.
>     blk_mq_freeze_queue_wait+0x101/0x180 block/blk-mq.c:191
>     queue_limits_commit_update_frozen+0x55/0xd0 block/blk-settings.c:590
>     nbd_set_size+0x4c5/0x7d0 drivers/block/nbd.c:383
>     nbd_genl_reconfigure+0x7e1/0x1040 drivers/block/nbd.c:2444
> 
> Requeue the request when its socket is dead, as is already done when
> the socket was replaced. The submit path then waits for a reconnect up
> to dead_conn_timeout and otherwise fails the request with an I/O error.
> 
> Reported-by: syzbot+90895f5bfaa7243c2d20@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=90895f5bfaa7243c2d20
> Fixes: 2da22da57348 ("nbd: fix zero cmd timeout handling v2")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>   drivers/block/nbd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf008..218b99f9e1ef 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -532,7 +532,8 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
>   			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries);
>   
>   		mutex_lock(&nsock->tx_lock);
> -		if (cmd->cookie != nsock->cookie) {
> +		/* A dead socket will never complete this request. */
> +		if (cmd->cookie != nsock->cookie || nsock->dead) {
>   			nbd_requeue_cmd(cmd);
>   			mutex_unlock(&nsock->tx_lock);
>   			mutex_unlock(&cmd->lock);

If AI was used to create this patch an Assisted-by tag should be added.
See also Documentation/process/coding-assistants.rst. Anyway, since this
patch looks good to me:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

