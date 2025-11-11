Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BA33D6D1
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762892978; cv=none; b=s6ORe7bYhz2oXNyFfoce4j943Yc+jtHuANtpInXKoLFt9W+FTID5tc0cAsJFrBmPqKc+abSikDCUc5mWmzv19oxyjaby9OXqWqAagngpW5wCkeFRLjDH42oMTSE6BEyBe+yxrMMSGbPuSqm1on9/AVY6zJed1ojieu8XJXXDF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762892978; c=relaxed/simple;
	bh=auy4IsjujBYe8Q2TlUjZPLk/WkEAXFxDFNWccSdxyxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aL/xIylcit4qnOgP2E21No5JNQ/Cb8u0T5dqsmg5Qele0AloHARr0Mb3I3SqiiD5tsUTZ+2DkIJP/P7Z/G9YN6SvQmlfo0IA2/63kXEF+yRYDGFnTFX6a+9U+IWeoz6ez0YVyNLT3ewGk3lRpEZa0BwWLHBUORoOgRZuJnZhKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GMNp/0vX; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GMNp/0vX"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d5dS00W5GzlyqnH;
	Tue, 11 Nov 2025 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762892975; x=1765484976; bh=8+Vxl0W90F6VV8ohY8wsgK9D
	QzzrbA9Pgpt1h68MEks=; b=GMNp/0vXG+v8VMabVarxWcIjrdo1tRdylf5fLV0l
	RWhx7a4uG2VT6eRbdVt2Peu5PzfPyiECzo9owRLfiQvRpKcuKBuht0zUJF1byyul
	CO34LMcp5h/0S0WDL2HkFNUK1eWqAgWw1TO+TYhGtrAZUzpaZCpTcQjiGdJGo68c
	bftlWpSSbklvt06XwZNQeha490+2wekQiA4icDTS0XllMJCszyLReqR0qTfmqnga
	/2mCKTc7Lk00FZcNdJy1p6/omIHWhZPOccopIOiF8UvT+58VZYc2ERahvJuyNYIf
	bE57EmEqYfniqfln92O6ufYmDM5ZZQu9kIiu72r8HEWxbw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bWbjVbIFhAtd; Tue, 11 Nov 2025 20:29:35 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d5dRw5YFzzlywm2;
	Tue, 11 Nov 2025 20:29:32 +0000 (UTC)
Message-ID: <3fc17e82-b643-48ef-9d80-0b8994246127@acm.org>
Date: Tue, 11 Nov 2025 12:29:30 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] blk-zoned: Fix a typo in a source code comment
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20251110223003.2900613-1-bvanassche@acm.org>
 <20251110223003.2900613-2-bvanassche@acm.org> <20251111074906.GB6596@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251111074906.GB6596@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 11:49 PM, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 02:29:59PM -0800, Bart Van Assche wrote:
>> Remove a superfluous parenthesis that was introduced by commit fa8555630b32
>> ("blk-zoned: Improve the queue reference count strategy documentation").
> 
> Or just drop the pointless parenthesis entirely?

Hi Christoph,

The parentheses make it clear that disk_zone_wplug_add_bio() is the name 
of a function and not the name of a variable.

Thanks,

Bart.

