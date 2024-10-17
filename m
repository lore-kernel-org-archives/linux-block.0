Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CF1BFE18
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178033; cv=none; b=nD6pBV1tBUY9qlyiMD/R4hym0ebZ17YGjNBk8n8DUcpFoFloZYgsmV0kxtO0k9ZXwMF3bey2H6pk/BcUN6EG9CCFPd/0ZAmdMt4kiD+vFwXWG3+d+GMw+mXr58NYoklXXJ+3OCuNJ+pvVq2+Ifv6zx7gGf/DD+DX0b4vQAORju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178033; c=relaxed/simple;
	bh=bxrJEYkpnbcJJ0cqyqvUZfGTrDx+yqboVixy05qVlP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc3lhiqiBcqy/Jdr1akUWKoqJ78jCL7zgrZaEiPEgjrG3bUvUOeVTL+gdDcWg+Sd8iSJU5F6ok5OzfvC6t/qScFpVjGHHuAfMJalgCwSr8LhZNR4Pc9XW7y/NitlxvO05NTvj3QF9AKUA2qije55/iM2m5IjvpMwzAE2PkmwpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MnRpCyHL; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MnRpCyHL"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XTrvf6cq6z6ClV8V;
	Thu, 17 Oct 2024 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729178027; x=1731770028; bh=qFYEEpP53KRkg1LINGXAYWdQ
	Wprv/s8I+/BB+KJRCR8=; b=MnRpCyHLSlNcJmg49hapMrJ/5XV81YPK0KYIpE1x
	AnnYV+1xmqyoDkJ9SLR3RR67pmtvofCEh4HAF35mA2NriofMqBbdJwUH+/9BIvc4
	iQQdt/whUiDZPDWCE3rSnqgVvZCaHS0eE62IzG5pVLsdp5hZlizj1u4xsAD3ZXlJ
	EFNl+9x6sP60jjQ/J6u5SGujCKZWWxpuV7WwUpvrPcJtjLt7R5w2ZC4NCmYyURNI
	RBiWQP+rM4JSg7a+3M2dBSIjXpzTN7X0WXuUfiXx2WIoScH52l+amBOTpsMDVDH+
	sBkQo5AtpfzJugsvTrfC7/API0YJobLGfslySZHm9aTJ3Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YN26AkC4Chr8; Thu, 17 Oct 2024 15:13:47 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XTrvY6rxKz6ClSqL;
	Thu, 17 Oct 2024 15:13:45 +0000 (UTC)
Message-ID: <354b464e-4ae0-460b-b6d1-8ae208345bfa@acm.org>
Date: Thu, 17 Oct 2024 08:13:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix partial sending
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
 vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
 Kevin Wolf <kwolf@redhat.com>
References: <20241017113614.2964389-1-ming.lei@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241017113614.2964389-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 4:36 AM, Ming Lei wrote:
> +static blk_status_t nbd_send_pending_cmd(struct nbd_device *nbd,
> +		struct nbd_cmd *cmd)
> +{
> +	struct request *req = blk_mq_rq_from_pdu(cmd);
> +	unsigned long deadline = READ_ONCE(req->deadline);
> +	unsigned int wait_ms = 2;
> +	blk_status_t res;
> +
> +	WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
> +
> +	while (true) {
> +		res = nbd_send_cmd(nbd, cmd, cmd->index);
> +		if (res != BLK_STS_RESOURCE)
> +			return res;
> +		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline)
> +			break;
> +		msleep(wait_ms);
> +		wait_ms *= 2;
> +	}

I think that there are better solutions to wait until more data
can be sent, e.g. by using the kernel equivalent of the C library
function select().

Thanks,

Bart.

