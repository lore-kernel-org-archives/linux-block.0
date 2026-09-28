Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB944DAFA2
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605337; cv=none; b=D0M9lhPrUPey8wwuVBlI8SfQN21aKU1vRDxRw+b69v7UeGerw5jIWSsCzztVtrVMheCG981+4cb/ePABZsWSfRaxWqQ1bhII5N3lgWYbJogyZM8PZGoBcIub7PDS7HGWVN5+aBZA5CcKJh8saKacQ7yqCBNV1XrVE+RIamv2/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605337; c=relaxed/simple;
	bh=jCvT3cCYAsnJeFHfUfVLrmEsDjDdoOGtScTzFaXmdLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1uWeLKuwgyBhDeIqpd9DLWOHDjcxva+7g+hebPNLGEXuz1JAonkShevIa36NO0k0Z0UJchy0w8+MYzd9LRM4CyxYONWoQmJ7DCY5K9QDH8GqnMzDVv0SrcxGrPlWgVkU4JSIboeTe2yVWdpryttcx7m9ME5UjegT1kD94CGUz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0U3HzOj4; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0U3HzOj4"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4htk5s1vkKzlfddw;
	Mon, 28 Sep 2026 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790605326; x=1793197327; bh=iLyurYF9QblGgPFait9hx3I4
	WYp/NOPbr98rCn+tWxs=; b=0U3HzOj4pd2+pwdvgG1pyLVFrlmfbcwiHW+NNksi
	XeTc7yOe0MpWdeFTbKTZOXeaW4zJ4/7P4Lq5D0Y3Ft/SwZTEwU1U9sb1VMRL/mYd
	pYrlzJtHF8ke5rN6atvhgr9K9vpsQIMzI76a4nSejjAA8yHYvbfII9TXmJxja8WI
	MCy76SrrLPcfehbN23CTwbKn8LsUAk0sObji7da1Zq13tfXAl4sRzC1PSdUFi3UR
	cK2vdkcxVzGARNGdE8ew9EUMnZbtHwMc2fsdlFpHPcH/LDu4tbEoskWAUGMxQbbh
	L+bawnwdwn1GIZoABQGn8RlCQWdKyPRbs8QHPRMEIPObEg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id u_ylX2VRlezl; Mon, 28 Sep 2026 14:22:06 +0000 (UTC)
Received: from [192.168.0.215] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4htk5l0rjszlfgPv;
	Mon, 28 Sep 2026 14:22:02 +0000 (UTC)
Message-ID: <3055910d-cbe3-4753-b372-413852cc4a46@acm.org>
Date: Mon, 28 Sep 2026 07:22:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nbd: mark the socket dead when a partial send
 times out
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <tom.leiming@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org
References: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260928091021.2456652-1-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 2:10 AM, Joseph Qi wrote:
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ffce519bf008..c2c3dbdd631f 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -838,6 +838,14 @@ static void nbd_pending_cmd_work(struct work_struct *work)
>   		/* don't bother timeout handler for partial sending */
>   		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline) {
>   			cmd->status = BLK_STS_IOERR;
> +			/*
> +			 * The header is on the wire but the rest of the payload
> +			 * never will be, so the stream is out of sync with the
> +			 * server.  Marking the socket dead also drops the stale
> +			 * nsock->pending, which would otherwise make
> +			 * nbd_handle_cmd() requeue every later request forever.
> +			 */
> +			nbd_mark_nsock_dead(nbd, nsock, 1);
>   			blk_mq_complete_request(req);
>   			break;
>   		}

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
