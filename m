Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0524CEC2;
	Fri, 21 Feb 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158445; cv=none; b=fczxN5bPuM+qzkJlLjdba84Vi1ao5JREe9N9Co9VDdc0dL6/5LdmBJ9o0P5phUl220+vQxjz2TFydp0S9Gq7+eS1o7i55aqoElr/DYtJ2FIHtzib/bOFx6fIif2H4i3yvn+udKFpOZnYVZDiEWq5AkeOYQFVaFhkc/LEDGO7h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158445; c=relaxed/simple;
	bh=YP/GbMbb14gVkIGGTvmC3uo5Ye3nBEof8p0iszwrF84=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ns/LlFAgYu0zgrxCnH8jt1uTXUvRcsI0L4goL1RemkM8ZIkoleyszV7MqRnqtAZorU2mhl7MZlYlTm0Dj5ZiR1uKBz8Kc8EnltwM1CdBUruY8z9Hyvjpi3+Dh1RE9fRHW7bFbGfPFqJa5M34D8YvDi1qsxeOepXsdYNT41tr+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hizW+RFl; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hizW+RFl"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YzxjJ20z5zlgTtm;
	Fri, 21 Feb 2025 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1740158434; x=1742750435; bh=V4HPbolKkx19anJM1Gqh7WZZ
	3xWBSdCrPrn2bOeUKBU=; b=hizW+RFlkxLRDYYkJiI+vnQtoGynxf7Q2QgH4ta+
	U9Q6p3xdy4RAmdnHmfiv9R2e7a6fNB1SSfyAapJO83jOXcVjbBT3myfhcTgjt6On
	j/ulfd2nY3GLMdaJUf6ZdhbMB5E6OjUQ/Tk0NIS73Ogjae1L+MxVMRhjU0jMXAY+
	utzgdS89Xm/PI1Z/ahPaMft6zuEYiqwHzIZ0Ts49sGXEpBHWjCZB2f3ynIv9xRx9
	94YRy2gg7izKIdSU5EROQx3ZEQOzuuwTvcyAMgE3w2mbR3WS9xPjfNNuQepovybF
	yAXk/HTHccgQoLduZxQQuxRkTkQxUctZqG2EOcigV8dAbw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ctS_PheqcY_J; Fri, 21 Feb 2025 17:20:34 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YzxjG54KDzlgTyC;
	Fri, 21 Feb 2025 17:20:34 +0000 (UTC)
Message-ID: <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org>
Date: Fri, 21 Feb 2025 09:20:33 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmc0: error -95 doing runtime resume
To: Thomas Haschka <thomas.haschka@tuwien.ac.at>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 James.Bottomley@HansenPartnership.com, martin.peterson@oracle.com
References: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at>
Content-Language: en-US
Cc: Ulf Hansson <ulf.hansson@linaro.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2/21/25 7:41 AM, Thomas Haschka wrote:
> Bug Fix: block: Improve stability of SD cards in Microsoft Surface GO 2=
 and
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 possibly other devices.
>=20
>=20
> The commit 65a558f66c308
>  =C2=A0=C2=A0=C2=A0 block: Improve performance for BLK_MQ_F_BLOCKING dr=
ivers
>=20
> basically made the use of SD cards in my Microsoft Surface GO 2 impossi=
ble.
> The cards do stop functioning after about 15 minutes. Mostly at io=20
> intensive
> tasks.
>=20
> As outlined in https://bugzilla.kernel.org/show_bug.cgi?id=3D218821
> i bisected the problem that yielded an unstable operation of the cardre=
ader
> on my Surface GO 2.
> I successfully reversed the commit 65a558f66c308 in 6.12.16 using
> the attached patch. As I suppose the bug introduced with this commit mi=
ght
> hit other users of sd-cards in similar hardware I suggest this commit s=
hall
> be reversed, even if the improved performance might be gone.

Thank you for having bisected this issue and for having shared the
result of the bisection process. This is very useful information.

Since the commit mentioned above is about 1.5 years old and has not
caused any issues for anyone who is not using an SD card reader, that
commit is probably not the root cause of the reported behavior. Are SD
cards controlled by the MMC driver? If so, I think the next step is to
take a close look at the MMC driver. I have Cc-ed the MMC driver maintain=
er.

Bart.
