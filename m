Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C827494;
	Mon,  9 Sep 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900979; cv=none; b=e0ECcKXkYzKJgaiQUJ+mkZce3jnjylsvoq7vgK3GvOPoVgFjrFcCXAn8tjXVXeE930fK+/0YKjzE95Eo7AXTJKfl4ld23rm2LG4Wr45BEWFRzTFyEPUXLSDvwxzf00yNzwxD4dluicqBRFl545ktuZo2u2ZH8tZsjPtXZbDUaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900979; c=relaxed/simple;
	bh=hz+muhNlGzPTTXOmV3AgBKyXhVUGgQu1x3C0Pqi1hE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on+P0bgW8qFz0IJLMb2iPrzVl1pi+663yT2xTGj1ucbwnmFBI0jla/7KnR3XQeAoQeyplGx1KziWLRGISFsBn3voMKmC9QwIvKpo/9s1byMNJGRUTxra6hOHHUUFlEUxeX68kfM8wFJ5FMnInlzsEyqYZuRKEEBaNTNRfH0/fVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Wg3F5LCf; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Wg3F5LCf"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X2XzH29GczlgTWQ;
	Mon,  9 Sep 2024 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725900969; x=1728492970; bh=uEzk+UVKk3DtYZ3RGwdE5l5N
	lpjkh/MfDdrJSDrEB2o=; b=Wg3F5LCf6/+JLLss67hdFrwCYpiKYJcvPXWaMPb5
	0UGd5jPmKNn3jnvfs9p3k8jYt/0lVwzZVbYRa/L0v3ac2kY7pFggydPH8IubdsRB
	o9cK34OGXusVLu+POcglH8dUKGwfyQOlpy1BgsvYkkDziK7mWE19d7hNXHTiGCMv
	HaN/oys8ko2XLinPrYyvZDwRMyjcARhEAIOqgylNEfxgeJ/bc1HQeu2+nPV/935c
	VyeSX3+gJSAevSSKeuB0hgfdWvY4aa0BLqZ8cJMSH1NgTcdljq9++XNbUmTf79xW
	n1mBav+j0iMDmsgYIm28V4Hxme1muZOnuzi5s1WN7KAi/A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ojzRlORkKUAf; Mon,  9 Sep 2024 16:56:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X2XzD1QNjzlgTWP;
	Mon,  9 Sep 2024 16:56:07 +0000 (UTC)
Message-ID: <2f13ac77-55e0-408d-96fe-b91d3c860106@acm.org>
Date: Mon, 9 Sep 2024 09:56:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix potential invalid pointer dereference in
 blk_add_partition
To: Riyan Dhiman <riyandhiman14@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20240908171036.71874-1-riyandhiman14@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240908171036.71874-1-riyandhiman14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 10:10 AM, Riyan Dhiman wrote:
> The blk_add_partition() function initially used a single if-condition
> (IS_ERR(part)) to check for errors when adding a partition. This was
> modified to handle the specific case of -ENXIO separately, allowing the
> function to proceed without logging the error in this case. However,
> this change unintentionally left a path where md_autodetect_dev()
> could be called without confirming that part is a valid pointer.
> 
> This commit separates the error handling logic by splitting the
> initial if-condition, improving code readability and handling specific
> error scenarios explicitly. The function now distinguishes the general
> error case from -ENXIO without altering the existing behavior of
> md_autodetect_dev() calls.
> 
> Fixes: b72053072c0b (block: allow partitions on host aware zone devices)
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

No blank line between the Fixes: and Signed-off-by: tags please.
Additionally, please Cc the author of a patch when posting a fix for a
patch.

Thanks,

Bart.

