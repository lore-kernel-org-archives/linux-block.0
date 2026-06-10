Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536673264E4
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111268; cv=none; b=I5uiUeJfbyzRy3zdULkSMZBd0k79IN84bpgXXxl+Pr56Ioguq/7PQfAPySPJ8jJXJWbFQfyBFAdvzUk5hd3+IMhk4L5zzeqaB8GnxCAR2Nf8dbw/rKeTgg0izg3+lbkhvgYm2tT0bZxbFlh2JDT2eh8SP4NYMyf76NJ+05Dzudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111268; c=relaxed/simple;
	bh=qdLiYS2GgFKVEVQFMLxnZ6DUsIK2tH5v15WGpo2qUlI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KaxRO+Xwf3K1b7fBANVLGn5zbBJKhghgD5uK9zFMOJ3QLVJycpmDngKf3TJYxyxDm6WZDSwDjWPRSS9zaZ+unXSEhYW8mh3STtZXIY/2vnKVsj5wmeCMg9/6nSdITe7qPu6zcYi9P1r/isSIf2uemd6zEQZT2WH380tnHTfHnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xP2TTsf3; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xP2TTsf3"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gbBzk6klYzlfdfW;
	Wed, 10 Jun 2026 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781111263; x=1783703264; bh=qdLiYS2GgFKVEVQFMLxnZ6DU
	sIK2tH5v15WGpo2qUlI=; b=xP2TTsf3yW2zlbcRg6JEoWjfqIbyWq+tskGl/Zps
	uprd3DEJ/7ELEotGRbY0m87Dw78qMRdOAr6jgfZV8wWKpyBTo8XDz6N/e+f7eAhy
	RVBCN4RrpZ7RqTybWQoddLzNjj1tYBAVDYXpB3RS6AV0BNJmgJN1P1idxzEBs6Pb
	DNijFbcfLqdH9JFed8tlErLon/BM7java1nQArSwW5d1EEbumnpv4323bTVcYm+F
	rdxXKIgQKYIPQpLDfndqXgHe1k0we2ANAY1Ir942xkGDrKhuLc2vjt3R7P1Q0PIp
	jA+OQ3jyVn0hfqIKKc7X3QDTEKhltFo8G1Mvv3WuPHCi/Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rVKgP3MMizgm; Wed, 10 Jun 2026 17:07:43 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gbBzd63l3zlh2ry;
	Wed, 10 Jun 2026 17:07:41 +0000 (UTC)
Message-ID: <de233718-f02f-4db2-9e79-18732ead26c4@acm.org>
Date: Wed, 10 Jun 2026 10:07:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] drbd: Split drbd_req_state()
From: Bart Van Assche <bvanassche@acm.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Marco Elver <elver@google.com>, Philipp Reisner
 <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <83d144f376580f491b42d7533e004aced7d26d7a.1781042470.git.bvanassche@acm.org>
 <aij1DtWM8N7O3q-E@infradead.org>
 <61eb3024-f9bb-465a-938c-c12db1218923@acm.org>
Content-Language: en-US
In-Reply-To: <61eb3024-f9bb-465a-938c-c12db1218923@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/26 10:05 AM, Bart Van Assche wrote:
> Do you perhaps want me to combine this patch and the next patch in this
> series (12/27)?

Answering my own question: I just noticed that this has been requested
in the review comment on the next patch. I will combine these two
patches.

Bart.
