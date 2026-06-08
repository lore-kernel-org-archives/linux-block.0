Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069433AFCEA;
	Mon,  8 Jun 2026 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955869; cv=none; b=Yvekf2cNPVvGWyni075xaU8M0kWDKi7NVqGwfXl136rBMH8EycbiFfiWYZxWZlROC1wl69R6IyI7sDrQCrp0IO6QUqAXOQOi3yLTMFAIJldVkEiBEGelPaSI73bdijSUHII9GedFy7brmhj/TkXBueumUfX5dNVWjXQLi7WEZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955869; c=relaxed/simple;
	bh=C39cKX1nVNI5CE6jNyDDA/uWkY1h7v88IEZywQT+Jgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3BQeLSU3IM8rpPVToomO4Au6vettR9N8jMBWUyJpjjKTcs+odQL45zkISGfuTjeYnIfb9C8MYgljV4XSTdg9Adg/0sKdM39E2hUNehmzj+Km8AT6ymsjeotypQgx2SQbcfiotz2RMu6ZvSa8wru0kllUi/a8AeF1FFJz58h3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Yb7EHkP7; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Yb7EHkP7"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gZ5WH4KVtz1XM0ns;
	Mon,  8 Jun 2026 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780955863; x=1783547864; bh=w2L54oNlQ3fBKWd9hax/eKPA
	6vBuJwK2e81p20dpxzM=; b=Yb7EHkP7EmD/mT6o7UExl+fblmreV/dj6s+Nf60l
	YAA7v0p58kO09Gw5/edMSdDnl6RqIIVfxLlXAl9SzYrwPJjwHlrEcc/2VLZYRdhj
	0ufHay4BQNA1hwfiLml+l0SZVDmcASqVtB5TSn/97kbFovAVx60U/mOGQLX1kL/M
	LBLVjUoBlIXlPPv3zie46EndtfDs03BXFBsiJd/5jPOoRYZ5UAiSPfjwcyBe00v1
	recDmGG+NStl1HqCyvxzuvNCyg5DE9Lyze3gebZe3whb1oR1fLofeRlwFrQIDnCA
	qdmFMmZGyC7xfENl9NTAIpZxhdntNBp4n6H+NO8EjI0p1g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0vBhbo92Ob8H; Mon,  8 Jun 2026 21:57:43 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gZ5W93tX5z1XM0p0;
	Mon,  8 Jun 2026 21:57:41 +0000 (UTC)
Message-ID: <5e738f79-e1d9-4224-ae85-322967682a1a@acm.org>
Date: Mon, 8 Jun 2026 14:57:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] block: add a str_to_blk_op helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <20260608051416.1205282-1-hch@lst.de>
 <20260608051416.1205282-4-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260608051416.1205282-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/26 10:14 PM, Christoph Hellwig wrote:
> +enum req_op str_to_blk_op(const char *op)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(blk_op_name); i++)
> +		if (blk_op_name[i] && !strcmp(blk_op_name[i], op))
> +			return (enum req_op)i;
> +	return REQ_OP_LAST;
> +}
The above function is similar but not identical to
__sysfs_match_string(). Is __sysfs_match_string() good enough in this
context?

Thanks,

Bart.

