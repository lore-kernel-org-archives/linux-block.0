Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D81F37A9
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546085; cv=none; b=qTHZDJClunnaN9TZmzfILghPsVvnnjUaDQ98Sbly9wnVg1tkNv/XRyQTySqS6D5REwZ+ozhNSCpNINu2fWZP7Lk/+jM4LxgXBa3/pJ3i5wQhr//cekahOHY2FU5kjqVMKkAqn5IIXvSent1PZK91TBzj+VhrtO98f/6K/sRrWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546085; c=relaxed/simple;
	bh=j0o7kPYE5PafE4gN5bs/Fw9gqcxkiwvHuaFGoeOtrpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdX9gw/Vs98szvvAoaLdnnIDrgJSi0xLIGLeiTyRgQEkfMPN562gVfltCcCrFZncXzLGsDXx+JDmDNQNeRnFrQ37XL5toEtrZkSOjktilIZVp0P+e9L74LU+2WafyeHZFHTM3QFsf0N1JabR4OOBgZC4P61XaIj0cKfX1W+8o6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aP7vROPY; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aP7vROPY"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YD27R0kYlz6ClY8q;
	Wed, 18 Dec 2024 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734546080; x=1737138081; bh=KLkIZIrQ455AtJ87xBoIQI3K
	A7h3qf81sJNIzcF+6Ik=; b=aP7vROPY3t0dwVgmYDjCZoMZAk0RDq6FSFXA6JaC
	VIRWEredI0xHbzeSi9hi4SqP3k8IjidkK4Yb7NUjOOrtDrPN+Cx8SnUq4LWZwvks
	mUV9tWPTKv0KYT8YOja2EejvGK5zv/+IDktyXrHpGdL6F3Ml1mQqNTWHjBMcfua6
	PeWsOsu9OQ3XeZe9AmYPqDeWLbyCFTZDbB9GR3ELvifX7NYH4CZUGPy6hhxXWjFR
	lSg5XuXLFUj+FbV4TInox8+kdsGbSKaKQ8l9I9ddSbBsUcP8fe5lZQBEei9BNdc6
	9c/JItZDwiEGfxd5FY9hlzrQP682godElLVvnJyIXcldsQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6GvJpoHl2rxI; Wed, 18 Dec 2024 18:21:20 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YD27N0yYhz6ClbJ9;
	Wed, 18 Dec 2024 18:21:19 +0000 (UTC)
Message-ID: <c91558c0-6c01-462d-958a-2cb96740f415@acm.org>
Date: Wed, 18 Dec 2024 10:21:18 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] blk-zoned: Move more error handling into
 blk_mq_submit_bio()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241217223809.683035-1-bvanassche@acm.org>
 <20241217223809.683035-4-bvanassche@acm.org>
 <49e2abf5-5c3f-4f0d-bf06-d382a79da393@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <49e2abf5-5c3f-4f0d-bf06-d382a79da393@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 3:47 PM, Damien Le Moal wrote:
> On 2024/12/17 14:38, Bart Van Assche wrote:
>> The error handling code in blk_zone_plug_bio() and in the functions
>> called by blk_zone_plug_bio() cannot be understood without knowing
>> that these functions are only called by blk_mq_submit_bio(). Move
>> the error handling code in blk_mq_submit_bio() such that all error
>> handling code for blk_mq_submit_bio() occurs inside blk_mq_submit_bio()
>> itself.
> 
> I am not a big fan of this. Furthermore, blk_zone_plug_bio() is also called from
> drivers/md/dm.c, which would need to have the same amount of additional code.
> Not nice.

I will drop this patch.

Thanks,

Bart.

