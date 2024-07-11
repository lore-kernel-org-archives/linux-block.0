Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C128FF
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721590; cv=none; b=PfwftBY63rRvKeGRTqR3vi3kuLlnbQFGgivUwoVbodM3nLYkBkqkFwQ1QcaeRUAI6uKQM4sAEvS30vuo5R+zgx6Faa9mgUU7tAOCrC4Sf3NZDf+CEvCHo7cK5GeMVrJaM+zMhzunw3f6AkAxxH/IwHD3A2b0IZzQhvqcejYr3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721590; c=relaxed/simple;
	bh=nP/kGO1/6QDMEYiGhCLPMKTTNGEFkqgspgtmJ/9Wtb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6cnJEk5iVKJlWQit/L+pIShKWxXaQpSRb8m6ofOwDNoSIRpvtS4waREFJmxmVDh/mS5LWrdVHZY+rugE7NmDqoaAhGRB4ZxrzpUScoJxaSDNJfprhyIS9Xv1kBvx2gutN4ngMpVA/hPk6kzxkuQAowXHvz11SJPoq+BbAaCMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=oDJbaEt3; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="oDJbaEt3"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjWm3FBnz6CmM6f;
	Thu, 11 Jul 2024 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721587; x=1723313588; bh=SUjzjQmrmsRIqN3wugJiJPFa
	sqGAsjJD0Pf+kYX3dWw=; b=oDJbaEt3q8D130q5tndNequdf8LvI9k2+kBcwViU
	fPW1v3i+V0N6Ncs8qh+sm6EvsZGxOPVHEhDbVIpZrg+Ld6vW35zWzio8vp0JHDv2
	zoxY89hWgooCbXAFGffAO6sKovu68hND2twXjzw9ju3A8J8+LGKKlLps9bVhsGu+
	1uXPcBz2wx0DGwUTaxO6tSoBZI1dG/I8ncO/HccQQrotvB7NmerXhEmISMjECSTb
	KxvroBIHDZDZJ8p2izbHhuPSccDojb14CnAZd7qk4UM0b5eVIkOcCIw11DVwcvX7
	Haujbaufb8tbK8y/m5dG9s4gEAX9ukn2bzrM+N33nFMAHw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ao-TzfSkcam4; Thu, 11 Jul 2024 18:13:07 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjWk54xhz6CmM6X;
	Thu, 11 Jul 2024 18:13:06 +0000 (UTC)
Message-ID: <73bbfc02-eb8c-4553-a7ab-94fd14fb156b@acm.org>
Date: Thu, 11 Jul 2024 11:13:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] block: Use enum to define RQF_x bit indexes
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-10-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-10-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> +enum {
> +	/* drive already may have started this one */
> +	__RQF_STARTED		=	0,

Why " = 0"? I think this is redundant and can be left out.
Additionally, this enum definition would be easier to read if the
comments would start next to "," instead of occurring on a line of
their own.

Thanks,

Bart.
