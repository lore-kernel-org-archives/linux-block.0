Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57D8F54
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143950; cv=none; b=lTLMoNXk0KDtt9eIPmsDgwB9Ucb4VthYC99AwpDiNYaaiSJGyhsqTatEMPm03GgbqTQIr5u5Wx1B9HZ2WtjtCxrwqLn7exGgN5DSuqgolqZOmTIplOg+M6gTFDD/dusxDezpg0be9zwbGRxKEgxnIva+qqrCNC6PGgRDsQODOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143950; c=relaxed/simple;
	bh=qrLj293+Rk0RAFVzgKtFinVNCEr1oMUiml9wkOCVhYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSj+rLEDpyJ7PSWlXYkthV2+oa5XPqAUxLPSvllVmfKVHk//Mep3dCRXBq0QVWsOTSZC0yI50ToRhc1iOxxPQ0yKpG1mv2YGuDC4df6zqyFNxlfE2pY+jwo3F76S4A6zLrAYspZ/wUyGa4YHR26Hv+o05Pj+ypoRKDHFIE2de3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xx0wHX5I; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xx0wHX5I"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VZ2nR5D79zlgVnf;
	Wed,  8 May 2024 04:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715143945; x=1717735946; bh=6fx7WPvaLByVsTiFrKVzdUit
	9Wqw/vDq4Z6Ij7axRUc=; b=xx0wHX5IhCLfo4QuT4kHriJEWE9vao/68W+rwSuA
	eKRh1d6MtKbxx59KCnNghiBCMtiLsA0YfyGqtu5zM7wekGaU9E2RV3d03Srzpw/N
	KdCGVhbAdc+j6NSolCeGwLD5/f12ufr6rWsy0mc3DITe08B1TdvC3c7zHLfIesi/
	GokkUS/Wo28QxCe03ZOsmYAsW2tSIQKLjKXpwRUY1gt9xneeBtY+f0LHIanuvbHZ
	GQ8aKT1J6Sybqz4yQzB4tACtUF5ZgFx+vxaVfljFFmaFshU5sDARwPcaTaLkfJEo
	6X6kmXJ5zCvHeKa/uuqNusun/+EuI5LlwNeYg7n4Sw91jA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2gfSmXuQi3st; Wed,  8 May 2024 04:52:25 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VZ2nN3MXMzlgVnW;
	Wed,  8 May 2024 04:52:24 +0000 (UTC)
Message-ID: <b2de558e-5d2b-4e13-b43f-f0aabf99b29e@acm.org>
Date: Tue, 7 May 2024 21:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIDEvMl0gYmxvY2s6IENhbGwgLmxpbWl0?=
 =?UTF-8?Q?=5Fdepth=28=29_after_=2Ehctx_has_been_set?=
To: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?=
 <Ke.Wang@unisoc.com>
References: <20240403212354.523925-1-bvanassche@acm.org>
 <20240403212354.523925-2-bvanassche@acm.org> <20240405084640.GA12705@lst.de>
 <a712785d-9441-45c6-a57b-6a35d802028b@acm.org>
 <8fe8624ac50d49ef9a8aea9de92e93af@BJMBX02.spreadtrum.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8fe8624ac50d49ef9a8aea9de92e93af@BJMBX02.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/7/24 19:28, =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) wrote:
> Excuse me, do you have any comments about this patch set from Bart
> Van Assche, We meet this  "warning issue" about async_depth, more
> detail info is in:=20
> https://lore.kernel.org/all/CAHJ8P3KEOC_DXQmZK3u7PHgZFmWpMVzPa6pgkOgpyo=
H7wgT5nw@mail.gmail.com/
 > please help consider it and it can solve the above warning issue.

Since Christoph posted a comment I think it's up to me to address his
comment. I plan to repost this patch series next week. I'm currently OoO.

Thanks,

Bart.
