Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841D13B58E
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186016; cv=none; b=Dud1Yp++d+3iQ6jeB7lT7/rQzEoHzpX+J+Jhw5X0SXuB0UKwJEDSQDcBYLwTsrxiKnoH18DuTDCG9VXL0e/iE4gwYV3cSyKWoFersNit4w+A1KDvH/9oz41/vKqVour7/2qhXMKtGyS4u8urXPS6tlCZy3+l1bWGMt1OxDUInQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186016; c=relaxed/simple;
	bh=Jb3PmjI9hztjuRoyI2/QJvmoZfAVfk6C77mZ/5Peo+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcW4eI3qh0khEqXLy3DVJ0wyAqIOfiCDXhdSZydLeNJwmj81lwUsazrDuC0AVVXoqTIKaQ8A5zF8zNopGqrkixn+kEkyuy+eoMzfXlX2siB0ZGimo9sxA4iJ6d2G69d8wVe8O4z0IE0COINLmUo/ugtdezRmq/4aPYtbtBwIFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Xw2gdp5T; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Xw2gdp5T"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YRhcS2fLtz6CmLxj;
	Mon,  6 Jan 2025 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1736186006; x=1738778007; bh=92vHsI266rTA+xh1ztM13XHG
	L1yaXizos5H18uSjzGY=; b=Xw2gdp5T22r6lZSfNIKdXjlWRUZ43WcTaDkVtkMO
	xJxIDJoMlxvDXd6Wzwg1laex0AodiH3NAzOVJ3ZMdNTkl2oJVPCofd0P8UMepEFz
	zkXvXhy9JOrUN2w7Day/NekKbUuV/+Wk72o/NzppWUUIJFKbXZBpw5bv8DWl5dn0
	r/Lb5ZC0jofKo/51GYJoy0iC+ewCjn+thlG4BoVQZlZ8S2xr0B31h4iOQSiWPniw
	hHxHc1E7siKc2MsHT3XyvdK9qDfN0c315LxbMXg6QN92H+IxvgiD0U/35VkUYljO
	goEdcAmIV2isx6zDZou8pACkfPzJAayFSPpzYHwCxzZBKw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id I4z4unn5NuBN; Mon,  6 Jan 2025 17:53:26 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YRhcN45YRz6CmLxd;
	Mon,  6 Jan 2025 17:53:23 +0000 (UTC)
Message-ID: <75c395f1-606d-44c3-9fa7-434e056c03ac@acm.org>
Date: Mon, 6 Jan 2025 09:53:22 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/4] null_blk: generate null_blk configfs
 features string
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241225100949.930897-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/25/24 2:09 AM, Shin'ichiro Kawasaki wrote:
> Also, modify order of the
> nullb_device_attrs table to not change the list order of the generated
> string.

No software should depend on the order of the names of the attributes in
the help text, isn't it? Mentioning that the order has been changed into
alphabetical order may be sufficient.

> +/*
> + * Place the elements in alphabetical order to keep the confingfs
> + * 'features' string readable.
> + */

confingfs -> configfs

Thank you for having sorted this list in alphabetical order.

Additionally, I don't think that a reference to the 'features' string is
necessary here. It is a common practice in Linux kernel code to keeps
list of things sorted if the order doesn't matter.

> +		if (!*(entry + 1))
> +			fmt = "%s\n";
> +		ret = snprintf(page + written, left, fmt, (*entry)->ca_name);

Compilers do not support checking the format specifiers if the format
specification is not constant. Please make the format specification
constant, e.g. "%s%c" instead of fmt.

Thanks,

Bart.
