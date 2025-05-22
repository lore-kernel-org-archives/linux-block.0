Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40A221FB4;
	Thu, 22 May 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898072; cv=none; b=IDlBIth/aZw9HMHHHf8Ldwdyzz7vjcefEBwTB6iVGhTbttlgr91QqxPlZFtV6EcrtaQtoDRwxaL1IW+R4H+8+LJkcght1WBHBo5pvPoD4Yuthev9OSijLebA9fNDVoUCv933YbZVbXMJFyNCY14A9DSqcIoxM9NQVqukNoBxXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898072; c=relaxed/simple;
	bh=w2VivgJneNBsb2eq07N5u4Cq28KAqeQTx00h/JRQnSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lv4+FBshfN3UHgIMQWbyPj88f7ZG8HXgPSbcgDKmRf3v2K6tVKuLHHooTwQrvF2aI4/YYO5uzJU+g2NZQlVBhdnatOIg5Kgzrim6MX1/W9780kZgPtKcbOqFUusnRdKkHFiNRxbV7CIKpmptWoTxUFDIF3GRX1xkKIRXux6+d+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=TfHE+ukC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="TfHE+ukC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747898050; x=1748502850; i=deller@gmx.de;
	bh=8nwqqFlZ/LYpUKevjhd+tOWs0KvsvOSnP8CP+xY1BYo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TfHE+ukCCKJb/UgRKaT391nbMeFMafBHIqzSuy13d1k5qXyWNXA3+zxEhEEdxVIA
	 a0Cd7EMdESz+H1l7rhTEk2URo8E/7uwMmgm9fw1ItSDsPsNcHY5aQNafUC8b19UKZ
	 ej51lyg/hT7IUnBkUh/JxqrUCK4Y+85VIpqVPa7X8tbW6tXptSOKUZvKhzdIhiLBZ
	 +pRnzjb5vLR8mazuN9V/3SqpofHrZuTVKSgxDHhLGXyAzAIXxcn+1jS5pcqR1bBo1
	 H0MrNiYUJdG9VqYxVcOyb6kSmqBEI1k3hBwx1oruZfqM7FhBsHp44G7aFCoed/Eaf
	 KzFSCzZHQQcZOkV1yQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.249]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1umiG13MpM-00ftUW; Thu, 22
 May 2025 09:14:09 +0200
Message-ID: <17640349-43b4-4d7a-a6d9-2eca3f82165c@gmx.de>
Date: Thu, 22 May 2025 09:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] floppy: Replace custom SZ_64K constant
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
References: <20250521175246.1351596-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250521175246.1351596-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uC+THcg+iF3bdcNuSwR4WnEScXHW5b49F5FkSiitAVdRM4XRwWU
 Q7zNUTR0NX6jAVY5eGvgvI30biCiE1J6TJphuETO+wbIvcUM8bgLaEmeZMO9VB3F6En7GbI
 rllS0dDw4ctuZu1KlecH7ostRf6Sc35b2EcwvXO993zFaIn3gsF0mKUuK9H5+iCDjEJRbFB
 3TT97km/IibB8tQ2OvKuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:24gnkXYFFCs=;P7zslEmD4nir/m/ZxKTFbuRvgtq
 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
 1y89CzWeq4tGE=

On 5/21/25 19:50, Andy Shevchenko wrote:
> There are only two headers using the K_64 custom constant. Moreover,
> its usage tangles a code because the constant is defined in the C
> file, while users are in the headers. Replace it with well defined
> SZ_64K from sizes.h.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>=20
> This should be placed on top of
> https://lore.kernel.org/r/20250521174152.1339379-1-andriy.shevchenko@lin=
ux.intel.com
> for the dependency reason. In case some changes are needed there,
> this one may be attached to v2 of the series.
>=20
>   arch/parisc/include/asm/floppy.h | 5 +++--
>   arch/x86/include/asm/floppy.h    | 3 ++-
>   drivers/block/floppy.c           | 2 --
>   3 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Helge Deller <deller@gmx.de>

