Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216868;
	b=EdE712hBqmq643BWhQanJatTQ3hsMRdUVw1alTLPtAgzBzz3j6I4Ax1KfQeqyHbaT2N1
	 kimH5vRXdFut7MEWvs9HVqE2DAdAMgRc/2lhsuKnPxwryJWYiL2Cn1PjhKhP2oAeLuL+r
	 2qDb+xEz29XEqBsiOBdnACJ9hp/eOZeD74fH2tXAeLjbjrQYxyDXY+TAquIvkL6XOddwU
	 A0hm7XzBeGGEdTuDc7jYI8xfXLADutY56UZJOIKcpWHGyfLy6pktgJJH9JZvc0ZCWNKka
	 8xpeXeUHJQIevf6vMN91c9rVuNMc2wlFkUyTIflQegw7ZLX3vH0bYdKgwyXQhEhxiaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4imoxujPpEtqGsf7XE/V2EL8GUEHrr9p9yDWFRYN9Co=;
	b=gphRPzj9Gj1uLofmywNF/HKUfi83VgFL3rP7uq/Nc1b/80o6c8kcdVS+uPQwX5xwKelQ
	 iVc7YmT0WQW/reKIUtIHc6OXFFQ7vH/yRvbeL0Ku3C6aR0tcjYg4IVZaN8v7ImzXNcrd6
	 iBVF4tAYIe7g9WvWL/Hszp+D/d1lH3ppRh0f7UIQ7lD80heQCuEUkFaunXit6JBxbWIFk
	 jfi7+WdoUMilcNzSAYfxtstN+GjCgzLlFYJ8LW1OPTfPP7OQw5I/luZDjzDRspjPapQfE
	 stnVHbQrAR1KYmJfMcxV0DOyimbgvhA0sg2bzEo94SFMd3swHRfBF+YgfNviIDkAdgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=3ELSp7aM;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98A606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A98A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=3ELSp7aM
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFHvk6sNlzlfvpc;
	Wed, 28 Oct 2026 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793216865; x=1795808866; bh=4imoxujPpEtqGsf7XE/V2EL8
	GUEHrr9p9yDWFRYN9Co=; b=3ELSp7aMcT6PvBtUTzUpUB8D2ngUB7DlKj0lbBMq
	Q2a5eOsV58YfL7FZRU4x5a4nVNQzxEbTFgUUutXDY7+PYho/WWrg4Le2lzy63ssh
	MObRZaGIBbHYs3Gx/AhrKAoH/IOIBdagZ1X6zUlduxuhDBpitMleZgpfG/Myznix
	wFHUkxYSTSx6gF5s0hxEgApCBLxKo/2zExDayfLa+Uki2sA+qaWWtgxhWHes6YTw
	qR7K7Bz7EXv996q96qt4AbmKtaVZB2dnGgTzYrhE3pGDz4Kl40Bs4BPmw6Y7wdbu
	xoq4wqN5EGLqBjm4co4JXd0XoHmk6wjMEhm/FVWxlBEjpg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f_-Y5Nw266jg; Wed, 28 Oct 2026 19:47:45 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFHvj5R8LzlfvpT;
	Wed, 28 Oct 2026 19:47:45 +0000 (UTC)
Message-ID: <b349b5eb-1bab-48d6-b2d3-c5a6bdd05109@acm.org>
Date: Wed, 28 Oct 2026 12:47:45 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/98] Various block related fixes
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <c16356fc-662e-4939-ad76-355f3a62ed4c@acm.org>
 <3c5a116a-394b-44a1-bcee-0cfdcc43712b@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3c5a116a-394b-44a1-bcee-0cfdcc43712b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 12:29 PM, Jens Axboe wrote:
> And likewise, reading through 60kb of text is also too much.

You don't have to read all the text. Please take at least a look at the
must fix findings. One of the findings is that a patch in this series
includes a new use-after-free bug.

> The plan
> here is that people that are resonsible for their area/driver/whatever
> will grab the patches. Hence I think any kind of review should be
> per-patch, eg reply to the patch with the review. I'm not going to even
> open a giant text file... I might, however, read a targeted review of
> any given patch, but it has to show up as a reply to that patch.

I will convert the must-fix issues into per-patch replies.

Thanks,

Bart.


