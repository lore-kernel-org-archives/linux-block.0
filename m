Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375D3A382F;
	Mon,  8 Jun 2026 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955730; cv=none; b=o8eZAN0x/Hl9i6Uvq7VZgy5YJU488pgxKc5OJres5PXHqTjQF0kMpVhystVUNagInB5Uo7I75MAqEqw5DJWE3osoGE41MswTMj+Bwobv3ZRMRbBjOs/k+N4fccREtcZD85ZEzg0ILe/ers2QLi3Xd94YnIRHUEXrz/TrRJO1U6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955730; c=relaxed/simple;
	bh=7r8NzY1cZD4cXaD0KgBmsv3inI2pb5cmcvZQp9xh6qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hepS6FB4bPnGiSxyMvS2L3ubtncyv0FORZ8wrdIbYYXDhan+Hkni73GhrH7apVHnNEhhuoh+8PXBIOqOgWWS9Wz0sqHSDtcbu08XkbUvITHp+aD4GN408CORl6tETmBNrPWlo80xTkYyenKGKzI4fN/EPP6ZLDGv0NO2J4KZhHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XGeswMJG; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XGeswMJG"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gZ5Sc4nJLz1XM0p0;
	Mon,  8 Jun 2026 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780955723; x=1783547724; bh=KcJ2fXJSf59wloCkSplZmDmc
	m/trw1mJ8ZFti0XwxCY=; b=XGeswMJGDGfpZda4zsDQsHEZE/Bp8GFdwXWcM5c9
	GbSW4SNHYzQMQrSGWuzmGUvTHxqpOq7RAfdl7AMhxv72Nku2qptPHc+bh+QGuJ8p
	fe+RGjmNu+yd8FtEDkOueN9pgw3TlwNBLQx85nGF/yovCiQXVnrGrixrgNw24+8D
	k9s2tvLyFG69vKDIpOnzRR4Xh05C57oGp/Z59yplfQAfJEl3iGvbLm/sAW1QqAEz
	/jOuARpdE4qf03TF0VXJOekrdgzCvp1hX7f4qcnwStSlcvsRyOnHJZtSrtxvidQH
	ib5CngNFAkr6IHdtgh5WXaHzLZFykdg+OjTkg/SrErWtJg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JbVmh-51QUsy; Mon,  8 Jun 2026 21:55:23 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gZ5ST2Z43z1XM0ns;
	Mon,  8 Jun 2026 21:55:21 +0000 (UTC)
Message-ID: <f4c0895b-4758-4eb1-9c3a-38cda0db50d2@acm.org>
Date: Mon, 8 Jun 2026 14:55:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: add a "tag" for block status codes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <20260608051416.1205282-1-hch@lst.de>
 <20260608051416.1205282-3-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260608051416.1205282-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/26 10:14 PM, Christoph Hellwig wrote:
> +const char *blk_status_to_tag(blk_status_t status)
> +{
> +	int idx = (__force int)status;
> +
> +	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
> +		return "<null>";
> +	return blk_errors[idx].tag;
> +}

Since designated initializers are used to initialize blk_errors[], it's
probably a good idea to check the value of blk_errors[idx].tag, e.g. as
follows:

return blk_errors[idx].tag ?: "<null>";

Thanks,

Bart.

