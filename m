Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B33131182
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501732; cv=none; b=olr4ahm5tQTh4LfQqnQ8Jj0yc+NuLtTErV9FCKDJ6Su64sWuoN89XirWdtjdc97TH3FngugTT4imfzcSu4Sz/LhMcCLvOfBzoVXwiZUlZAZOwwG87pIogM/2tFAzpflRr6/SPLLe5Uxd/DcgCqONSgbHRO08lQBa8rljuVo54co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501732; c=relaxed/simple;
	bh=Jo+xQaYAiyF0OEjnONK+7ZNgxxFZmbjk9nwtOlwakx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g83wMph4+7kKxjyVgk85mjA+/TLZqG8w7ZgsbthMgvHO/QK/1UPnPboVm6SXRvpL+CsYd1TALkZzglQAqXtGH8nSRZUxZ/pSp0rrklShzM/12FxirYow3pRNcMc5dp642FIx1H4qUaYYDIJZuIf84KHkt3H6EaKIiSkHhlYQbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FyWse79A; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FyWse79A"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VtplQ0DfBzlgMVS;
	Tue,  4 Jun 2024 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717501728; x=1720093729; bh=Jo+xQaYAiyF0OEjnONK+7ZNg
	xxFZmbjk9nwtOlwakx8=; b=FyWse79ACIEayNcjdUP9UQnlTd/bCYIoy1f9zhjx
	/3sVf08I6QutWH/mmUbWUorHRpQg4L52fO2jpNN4+xLJMyoWcyE1rOvg1s3Q+8ne
	PAq0WJRefeuGPU5wpMbdKRLWVTdtyA5M/eb0r+Qce3y94+i6TBQntuWJGfKJZInU
	sK5nPowF6TqyDZ1LsAHtj0bgLblGHfpJ3Ilcwv3kTgYV0ZOJFLZGYVONXBZiJjur
	BhvufcBMhjfedhJiqxFBNnhtZvtXVvRiFsYujNVUU9gl/h3OvVNjuL6Qg64zw7YG
	x3flRnqKJzSOvIF9nEEGiVBNl1NArJ8AB8wGk9jh3JCNJQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id noG2Nsdq39UQ; Tue,  4 Jun 2024 11:48:48 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VtplM5F3dzlgMVQ;
	Tue,  4 Jun 2024 11:48:47 +0000 (UTC)
Message-ID: <366285cb-b099-4c8e-ba52-63c34b55db7f@acm.org>
Date: Tue, 4 Jun 2024 05:48:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYyIDIvMl0gYmxvY2svbXEtZGVhZGxp?=
 =?UTF-8?Q?ne=3A_Fix_the_tag_reservation_code?=
To: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 =?UTF-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
 <fcaa5844-e2fb-41d6-8a38-2e318b3e3311@vivo.com>
 <c9900a6e-889d-4b7c-8aba-4ab1a89c3672@acm.org>
 <8bdfaa1201874892b166a5b5c59ee9c7@BJMBX02.spreadtrum.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8bdfaa1201874892b166a5b5c59ee9c7@BJMBX02.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/4/24 02:08, =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) wrote:
> Would you have a plan When will these patch sets be merged into the mai=
nline?

These patches still apply without any changes to Jens' block/for-next
branch. I think the next step is that someone helps by posting
Reviewed-by or Tested-by tags for these patches.

Thanks,

Bart.
