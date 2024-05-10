Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3FFC0B
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374297; cv=none; b=r1GYW9gNb4ue54/WymCu7ztSW+9xjmkWnSxrBDVV/T63WaGLc0Zi8nKYiygJMfSpqHPhjAusWK+l5JNrFPh0CRi/tRA/3qcjYgRfC2yjRz5f/J3OAv+x10mIZM22Hj4kih4+i9hx2pWKk3R1qO1YiOEuF/G6C6gYKhO6IpAOn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374297; c=relaxed/simple;
	bh=nxDeY0QQt4Bh9tHrvzhDjEN4clFZT0MxyFo1QgQVXsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oVXeGUbg2xZ7IciTUJGIfCOIDwLOmzBH7GNnDkn6T2eJZWP3eoRh84RgjvucMlYFY1fCJ9mDyQQht1ZPYZIYIysoxmh6DFPJ7Ri+vn5Kj3i76CIrSNTzKACwAHcIVliZUBbP8ZBjAuxF3w1OgxgORVEDOST2KVYhavdrZ2/Cqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0FoAp9aA; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0FoAp9aA"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VbgzC5GqVzlgVnW;
	Fri, 10 May 2024 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715374293; x=1717966294; bh=BuuaEwcbhswX43BSZfFysQS4
	B/+pIxdLezwxQw9hauQ=; b=0FoAp9aAtwjSJGK+NlFnfYgWUBqktUt+vcvZ2My1
	itD5/kADcL2CKo030WPZjJqrK1Eqz1lrOX1+XKe0R5J5otcijitOajNZmb/kbq4v
	5Octw/qK4ZHV3z16PULjRhplExSLBZXlqkQzWOyg/jJFhUDRD2e56NdJshzXQNlQ
	i3trYMstSOkki8sA9YdGDy2+ixZvx8vPHHSaYP76eYtYjInUooI4MLtHewwEoCeU
	3b6GAtWo1jEg18eEAwnapJaZQko5Vo9uCom4ZZbX3OnxfH1nlmzxPSB/1G75wz3A
	mp/iz3Bd52xgGpkJwtFw+g+jF6g8a3DQTSy2FJxsCnwH4w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0ehdUUu2GdSX; Fri, 10 May 2024 20:51:33 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vbgz835jTzlgVnN;
	Fri, 10 May 2024 20:51:32 +0000 (UTC)
Message-ID: <2786c4cb-86ad-42bb-8998-4d8fe6a537a4@acm.org>
Date: Fri, 10 May 2024 13:51:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block nbd0: Unexpected reply (15) 000000009c07859b
To: Vincent Chen <vincent.chen@sifive.com>
References: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/9/24 10:04 PM, Vincent Chen wrote:
> I occasionally encountered this NBD error on the Linux 6.9.0-rc7
> (commit hash: dd5a440a31fae) arm64 kernel when I executed the
> stress-ng HDD test on NBD. The failure rate is approximately 40% in my
> testing environment. Since this test case can consistently pass on
> Linux 6.2 kernel, I performed a bisect to find the problematic commit.
> Finally, I discovered that this NBD issue might be caused by this
> commit 65a558f66c30 ("block: Improve performance for BLK_MQ_F_BLOCKING
> drivers"). After reverting this commit, I didn't encounter any NBD
> issues when executing this test case. Unfortunately, I was unable to
> determine the root cause of the problem. I hope that experts in this
> area can help clarify this issue. I have posted the execution log and
> all relevant experimental information below for further analysis.

(+Jens, Christoph and Josef)

Thank you for the detailed report. Unfortunately it is nontrivial to
replicate your test setup so I took a look at the nbd source code.

It seems likely to me that the root cause is in nbd. The root cause 
could e.g. be in the signal handling code. If
nbd_queue_rq() is run asynchronously it is run on the context of a
kernel worker thread then it does not receive signals from the process
that submits I/O. If nbd_queue_rq() is run synchronously then it may
receive signals from the process that submits I/O. I think that I have
found a bug in the nbd signal handling code. See also
https://lore.kernel.org/linux-block/20240510202313.25209-1-bvanassche@acm.org/T/#t

Bart.


