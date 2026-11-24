Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546358;
	b=EaRquUJMYPKn3v8MhWBNM+W+7GU64q/yBIKgKM6Q7H/rwQw2v5QOSuSKI2mLd1n6LK8y
	 C/rtZ+qdP94ZXI1p7EZ+hhATmW1SREhN6A7vhwUcfOYqL9XealznA03E3Oskbd0z35Zmj
	 wUE7AxnIiOTnmdriwoWOuahuiIpk41BNpSaBQQolLKQVf5wQLPFR8sY3jg00z3lLCHgbX
	 rRHeUzDCEYtMuwFlz08H82na/j11lthcTdfO2wh3Fw8aXAeB/P2Ocg2JWxRz2uHR1OJjf
	 fGjiGSkNyK8XkHWJeCQItEgGHuLWFBz8tdiRZPmyTer7EnSMSmiRf4xZ52BD7iSAssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=H+mbjkkwUvN3bbv55coMpVxNkeApHp5u50AA+NJr+Uw=;
	b=1rjVfHafYz7JcxSfpImNrFh8soMLuvwrZjepl69XzvUPT8Hn+KEBpRTnZFWDadjC2Jwd
	 QZbYcL1RxPN4pZvd8wTaNJeyPjYhHBzaxxzarJzDgpxaHh9eTzzo+j1pI8wJ+4Hcup7b2
	 FHamChGNzdOaKuV10mVTsV1vPvxRrxmcTvGCJDm0RpXtTfHQXSogPrspjvE0mKuRXEb8O
	 6YMPaT922u/xauAsdovlugrQoQh/lu6nGub+Poe/ui8cu+GEnM4zbzC3hBKJ9RZ1JdZbM
	 BG4jyDWcKEfg9Mu+pYa/ldRSF2XLP9jSy7ixi6eS9zpAnhwqHNsBmoQ3U/t6O/4JX6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ffDLWibd;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474D606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 18:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5474D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ffDLWibd
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jYsPd5gMmzlknw6;
	Tue, 24 Nov 2026 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795546356; x=1798138357; bh=H+mbjkkwUvN3bbv55coMpVxN
	keApHp5u50AA+NJr+Uw=; b=ffDLWibdXFVkL3pQ5ffLMlSgWJ8XPqRe+rQVfhcP
	597znt/avWgWa9DYDgTwOEC1lqSd84b243qPmLwycrkIx9LOHOvtEtOV21RShWW3
	5cZZQ9XGXoP5FB+Uk3r+e5PLHUzG+B+QlQ4f6pKZv76VMZ4CCCy+ZnIUUWeSArab
	ON6XkHlNMPlhfrkZVMDpQ58Z+hS9yujG7er6eF9/rnDQ7ouxfalfqKfhPdV6YiF2
	W/vHlH8gxa8XDDMz5mqD2v2qBFxXBojZR2fRK2j9zWROBnLwAtcDVywLiKla6qzi
	gF60p2JIvGNlMMPwVwegsMp5ILzjzlj9F1qJbR1IKp/j5g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id C8_eFP7RyBoN; Tue, 24 Nov 2026 18:52:36 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jYsPc3PMjzlpHxP;
	Tue, 24 Nov 2026 18:52:36 +0000 (UTC)
Message-ID: <5bc4f7fb-9ce7-4cd6-829c-c178ad884843@acm.org>
Date: Tue, 24 Nov 2026 10:52:34 -0800
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
Subject: Re: [PATCH] null_blk: use page_private() accessors
To: Nilay Vaish <nilayvaish@google.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20261124033630.832566-1-nilayvaish@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261124033630.832566-1-nilayvaish@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 7:36 PM, Nilay Vaish wrote:
 > Use page_private() and set_page_private() instead, like the rest of the
 > kernel, so that the driver no longer depends on where struct page keeps
 > the field.

Has it been considered to store the page index in struct nullb_page
instead of in page->private? That would remove the dependency of this
driver on page->private entirely, which seems more future-proof given
the memdesc work.

Anyway, this patch looks good to me, hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
