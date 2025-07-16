Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA04277030
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686423; cv=none; b=nrkICywJ4+bLHYQKFso1BiB7g1ViW1u3L2p/O4/tOCdA0rYWY3v1DUDE+OQ3Pc346+OLyegAxGS0XZjruVXMzpBjy7j5ntFV4dVubKcS7Pu+ZcRhSzDi9BGoW6i0L/ygvx3BvY1w742w/fkriImIXC7b57IwJkmrDGn3+5wfA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686423; c=relaxed/simple;
	bh=VBoYeeyT5uiPk6sdFVooM1nU4nPGP5c8Rv4Lcf4hqZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUHx+ZaiaXSDAluEqdvnGvmSLnnJFU1czElYPYWuYzE+epJKqb3+LD6U6jROnK41RTnj87PWOGPgbelxUYBmu/PsPXxJ2JeUY5jDomAjkvmG3Dgjl0t0+1pIS4hJpIYdKbd7sZhzL7jnv6TfaXW898HUlWx36qrrOa+hyF0xqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=w56PYkJ2; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="w56PYkJ2"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bj2qy4zq2zm0ySk;
	Wed, 16 Jul 2025 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752686413; x=1755278414; bh=ZRK/Z9xy6iL64Lt/DgG6Xjil
	NPd5df9npBqwp/yubFA=; b=w56PYkJ2TiaP3lu2DHrB3q3tvRK/EfjIw1VT1BT0
	wBfYzd+cbgWVT1QH11crTUeHWyVDpJvDymLg+zEMhM6bA2SHSMR+l7BYfQwmHCKu
	l+etEa065T331b4d1JxWA6PPQe4an9HCGdEYVqvuHA4kjV39LCNG5BZLS4jBJsIe
	/sqUrE5hk2HVnoQmc+Vg38sGc3NDwPiVJJfpWDVktbjadB84GBZHHFEHdiIIF460
	58P0hVLmyeFSiSiiL642TaqDtmdh6epRU01UnYY291naPGhI/6Q751T76eMd5Oa2
	pZXSp/vNFnELIMpRM8RC/czvTGyyVORJABcHXQdr7WjEsA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RED1rr4uXr-l; Wed, 16 Jul 2025 17:20:13 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bj2qr0j3xzm0yQ4;
	Wed, 16 Jul 2025 17:20:07 +0000 (UTC)
Message-ID: <f16d3f34-b39b-4045-91c2-aa174067d44d@acm.org>
Date: Wed, 16 Jul 2025 10:20:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] block: Improve
 blk_crypto_fallback_split_bio_if_needed()
To: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Eric Biggers <ebiggers@kernel.org>, Eric Biggers <ebiggers@google.com>
References: <20250715201057.1176740-1-bvanassche@acm.org>
 <20250715201057.1176740-2-bvanassche@acm.org>
 <f8bb19ca-5e16-491f-9542-51fb44adde69@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f8bb19ca-5e16-491f-9542-51fb44adde69@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 4:49 AM, John Garry wrote:
> On 15/07/2025 21:10, Bart Van Assche wrote:
>> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
> 
> is this really a fix?

I will drop the Fixes: tag before I repost this patch series.

Thanks,

Bart.
