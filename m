Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708753D6CD5
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284378; cv=none; b=sg7x+xYKdI5/8HAsMyD43nGBC+MCYagbm0eY4WxNz56x0IEa2Frcd4TLBdMoMzrYB64yVmMWodxeU7r/oAQWnW3iQntSqcicdsjqIaLBpDgcP8dKHGnQR/6RarejS91CXswF19s7S0DrdwznexnCExLi0WV9ZgbfRPWopTSXRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284378; c=relaxed/simple;
	bh=uaylMnCNhhHYh+V/e77ZSe/RAF0I1AmP1cCt/jTZXBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9DsnDdiQ4ZS1hOFnIk0mnGAJawfXWXlZKhl6ZeVZ6+4s4ut9BXRVGTy/yjvSrtJxrZuuk/s3TL/lCR/gDbMoakeR9Tj1F19J4jgNdv+2ls/ogz/oAJJPTNpAcWsteK6hEqiWrvFjPf14+Ty7czbWEMj1QNIHjjJ6HyFy6IneZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4MULm9jb; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4MULm9jb"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gcR0g1w6Fz1XM5kt;
	Fri, 12 Jun 2026 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781284368; x=1783876369; bh=uaylMnCNhhHYh+V/e77ZSe/R
	AF0I1AmP1cCt/jTZXBM=; b=4MULm9jbzSSYnTl/k5ym2EPZR3gnBosO+KzHwKlC
	TccFjNdiKGHOQKGGF+kL4vdwO2xPj08A8IQ1xxsguUpn83Gv0t+JinqzxJjR8gms
	/Hunsf1wXoyc4AZjPGHPMgk/REahZpCNJ46ALu5LF9+HL+iWo/oA9bBnBIbF3bBy
	QGR2OwCPizYtGF5G4TpfgKGw6jwHlX3Rd7+zogjhS0fouv269wRF165BXoJpGd3L
	CouwbcLlwx1ZVwk/vW/zhi3spHfuEFJgG4zGo97Eqo3N4YmOpwKCk+Ak251BklCJ
	FlOSB4SJKWn+APa9keX4hkwf9xizFp+l9PjSKOaQYU9StQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id m8uiVeypMxDY; Fri, 12 Jun 2026 17:12:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gcR0b39MLz1XMFjH;
	Fri, 12 Jun 2026 17:12:46 +0000 (UTC)
Message-ID: <231ae188-a34f-49a5-9b9d-56da83be8fbd@acm.org>
Date: Fri, 12 Jun 2026 10:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/27] loop: Split loop_configure()
To: Haris Iqbal <haris.iqbal@linux.dev>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Marco Elver <elver@google.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <f001b652198021d586af28c4c2c27be4b1824f3d.1781042470.git.bvanassche@acm.org>
 <667e352d-afad-412e-8f2a-ad5f5f8a737b@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <667e352d-afad-412e-8f2a-ad5f5f8a737b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/12/26 9:16 AM, Haris Iqbal wrote:
> On 6/10/26 00:05, Bart Van Assche wrote:
>> -static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct block_device *bdev,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const struct loop_config *config)
>> +static int __loop_configure(struct loop_device *lo, blk_mode_t mode,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct block_device *bdev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct loop_config *config, struct file *file=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool *partscan)
>> =C2=A0 {
>=20
> I wonder if we can add "__must_hold(&lo->lo_mutex)" to this.
> Same for the function __loop_change_fd()
I will look into this.

Thanks,

Bart.
