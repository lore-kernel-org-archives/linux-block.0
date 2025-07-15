Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF61C2DB2
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618934; cv=none; b=G9RvRWnLzeuH5ag0Fn+Ep6n2hsi8wfYKG+HVplnHDxeQhJdAuq6s1cHt12ci//zjwKrFeVuXS+KU49JZduD0OD0CO4TRuumyU9cJ2QSob2pHdIbouc3D57Law8n1esmAzetJ//xNTgoKJg2ey1QETJdL81ANQkSAwMtmAdJPhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618934; c=relaxed/simple;
	bh=QsSxXLU5s7SmQJGIqEdHj0/tg6s0OVjqe1lTEWLQCz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3MJk68C4kpxpz6YYqYoEwvQRQ/BS+0Li00BfNr+pJfcHnPn91Dw+R/jT/mlQmB8eP8tjiC2y13HcGFSTj5SB+ashoQw0hJPRUtuLtRgKRrK09mMTRNYOH1oWtwOdn/coK/TRXL+mFJgfNvmYvZWKiGKOTp5Ck1zpJJuCxfhcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OyFgr/Ld; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OyFgr/Ld"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bhYt531CPzlgqVw;
	Tue, 15 Jul 2025 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752618924; x=1755210925; bh=QsSxXLU5s7SmQJGIqEdHj0/t
	g6s0OVjqe1lTEWLQCz4=; b=OyFgr/LdC9CJktmqzzcUKlanSxxyBzZeTt0pkB7k
	lF8iXoUeh5VlheNwfE0YlGRvP71eS56Si7a7oBMpvgyjOmij1dFlhn5XeL1svCCr
	wUlg+G+TIZ/q/bziyCEmDASvuX3M79nQ4BCV8PiTWCuedwATbtg7In+QGwGk4F8c
	taScPLLKwO10c8aeseJopNuUhkmJ7UDZUuX79036+dMs2XPWsUVSlr7ulLYLp4hF
	jrNF5JGiuiTwMxaQD62WxvvaCE+zdO4oebydFz5FUfKW+BAjyKf2CATnZ4fImqEZ
	cygsUHKbuGZKGd1PdZNsK56kqH0L9GfgwSYNOhyOZ7L5Qw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NgAE9Bxl6JnG; Tue, 15 Jul 2025 22:35:24 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bhYt139p2zlgqVd;
	Tue, 15 Jul 2025 22:35:20 +0000 (UTC)
Message-ID: <9ed44419-ec53-431d-ad71-c19f83c3f98d@acm.org>
Date: Tue, 15 Jul 2025 15:35:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20250715201057.1176740-1-bvanassche@acm.org>
 <20250715214456.GA765749@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250715214456.GA765749@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 2:44 PM, Eric Biggers wrote:
> But if the actual encryption is done using code
> whose developers / maintainers don't really consider encryption to be a
> priority, that's not a great place to be.

Why does the crypto fallback code clone a bio instead of encrypting /
decrypting in place? If encryption and decryption would happen in place,
the crypto fallback code wouldn't have to be called from the block layer
code but instead could be called from the block driver(s) that need
encryption fallback support.

Thanks,

Bart.
