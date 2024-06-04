Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366F56B81
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539033; cv=none; b=C5VGcRmGEBQsIBO1+dm8vwvEVPGmNsVsNLOYNeJHpzUzilhSOSBUuTYLwIwyas6v0E60+hQEazKyzLl/KKuObwfcRH0PucqNNlTYRlwhLq/K9zLrpog1H/p4Ef4NHn7iuKu7BEGOvGcUMIwzKtFshdd7JURr5NEYKp8gAW0o3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539033; c=relaxed/simple;
	bh=yGJXkwga1PYWRGzkMXdPEcn/GkOnna/+613TJ8eMF3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGku3vPND48ZB4g89du9tBI5O8APBn+GlfOqNcPVdjzOvkkY4bmCFiPHHaoLgoLx7CIi+pRbKpFwaUj/xdzsWfoZ5Uwx8yVm3NTBYjx/PaLWKCo2NJExn//zLA2rEo7eL99heCqT2AmC3AstP8QWDHAWtBnOgWtQ7GldtXMKWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hRbCiGLi; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hRbCiGLi"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vv4Xk1hKnz6CmM6L;
	Tue,  4 Jun 2024 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717539028; x=1720131029; bh=DygUESJtP9yiDqi3RDgIMM+K
	TNDPP++1uLs26t2PkSY=; b=hRbCiGLiEZVWdmwBtOJ16NpJm+1YJP1kNzvYd+Ah
	ATb/GILjW3mGNpyatGFNfGMGyxdk98Yig0WGTq+mPiIr8vmcUtVEBbMtA9qN6wzh
	7A8PKC2xcHxQeXCYemvSIlGhdW/LTJGjl3L2zqMTC138MZ4NykMxUOTdyEzwGGfz
	vv5SL+jBrxEDyTmWkvMQ5uXF7uEW21Oo2/xr++OkLCnUIarsZFDCZIfF5JLJ3mgC
	hjsc7CfMnq66yam+IyBXPlkrzkvTeZCfRfiwFlz2WEZN6F5IxApt4YxJeKpsVsII
	yT2tD8Jh/Dg8kKqY8hmFiSoklYAEhSmZiU7lntt3ujnLFA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TfE_MNbkLnOV; Tue,  4 Jun 2024 22:10:28 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vv4Xg6TW0z6CmR5y;
	Tue,  4 Jun 2024 22:10:27 +0000 (UTC)
Message-ID: <027dd678-3e49-4510-a67f-38b5a67c1463@acm.org>
Date: Tue, 4 Jun 2024 16:10:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nbd: Remove __force casts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
References: <20240604215227.321764-1-bvanassche@acm.org>
 <20240604220431.GU1629371@ZenIV>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240604220431.GU1629371@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 16:04, Al Viro wrote:
> On Tue, Jun 04, 2024 at 03:52:27PM -0600, Bart Van Assche wrote:
>> From: Christoph Hellwig <hch@lst.de>
>>
>> Make it again possible for sparse to verify that blk_status_t and Unix
>> error codes are used in the proper context by making nbd_send_cmd()
>> return a struct instead of an integer.
> 
> Not in this version of patch:
> 
>> -static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>> +static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>> +				 int index)
> 
> include/linux/blk_types.h:93:typedef u8 __bitwise blk_status_t;

Thanks for the quick feedback. I will fix the patch description and repost.

Bart.


