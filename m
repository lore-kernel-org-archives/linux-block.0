Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F6811FE
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721455; cv=none; b=oLvlskACs6uF7eNydJhSqExMFzZ8c+qJkddciUIh9i/2BN+8c0BCW99162Ag9tP4kSQolVROlJhb+NGQB0rLXpjNp4D5ZDlhbADzY4IiamvOP/LXHUs8KllUB2iPyzk8FeVC/ioNKGxF68HfrxjAfyLlsH7vW3FWzcoKXC1xvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721455; c=relaxed/simple;
	bh=/gv3EqxIa/NW+a6IIUvfNQP8xj9fJAx7EWKHHzcGZVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkNhqZG/dXhn59D1n0r0q7k1E9FpZbqHVEneOybzeweFILNqfCZapr/+0RNkP8lm9qZlAI6FizaqVGcpC9MiTM1Or1LwneEGH5tS84CVPwuoHa6rDGxfpKX4m9y0sIDwaU9U3RO+tkf+i4jsYl37OYP/LKA77GYgGnV44HNsTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YYjfI9RC; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YYjfI9RC"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjT92qqhz6CmM6f;
	Thu, 11 Jul 2024 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721451; x=1723313452; bh=iwVhfgNyIbNboXOI4AhBZkBJ
	qnbDIzeWwyE83FC71EQ=; b=YYjfI9RC7GK0bkc91IVLkMrc2hOqKpbL9gI3Bq0c
	vFLIUVI1jdU1rH4lyaozKeJf/621gKz31812n6KCqrxSmXn3jozjkPh+99t0eNka
	NXPTNTHxzG3tLxP+azvvycDigTPBQxEAOj7fSwCO+o5ESJD3j1B9P6xpTFnWiPtJ
	1SGTY+gv1fx31ZyBSXtsu9a3fVO2Hvc3akw5WoW2cW9shkZq9pJFSIGIycpfNJKl
	LFoVlA1GjvlC0ZyW9JOE1agj7w7QW591oBvTFIbDFrfPopaADsTwHzAUBsUN4+zq
	fkgtcdwH5r8dmPEp/nVszRiJf37p/vSX66xwa1EhaYyBzA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dHmgi5qaVxgU; Thu, 11 Jul 2024 18:10:51 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjT71tCzz6CmM6X;
	Thu, 11 Jul 2024 18:10:50 +0000 (UTC)
Message-ID: <cf6cc884-0928-4f82-859b-62407d60604e@acm.org>
Date: Thu, 11 Jul 2024 11:10:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] block: Catch possible entries missing from
 hctx_flag_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-6-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> -	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 7,
> -	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> +	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
> +	BLK_MQ_F_ALLOC_POLICY_START_BIT = 7,
>   	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
>   
>   	/* Keep hctx_state_name[] in sync with the definitions below */

The patch description does not explain why 
BLK_MQ_F_ALLOC_POLICY_START_BIT is modified. Please include
an explanation for this change in the patch description.

Thanks,

Bart.
