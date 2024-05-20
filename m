Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06F1847
	for <linux-block@vger.kernel.org>; Mon, 20 May 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241799; cv=none; b=DZ5okbp84o5WiTSsgEGkpJSPFSy6JWpyIJdJXcKEdHsRmG9MMsKZD2o7HnQw4wQCyKRzP7B30BLuDscNWqWMOsh58NKGy/jz88rHXr2rZZeSPJUuUrIqUST85LW0rNzdrSwial5WB+jXpYS0rxJNs1WWpuPQuRYKL+XEMSOc4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241799; c=relaxed/simple;
	bh=UHWlQ4EgEVFuXTjURZVMzoSQXoJctPh8Eg4BqJ1zPMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwEpY4qsb8IFonI604ofSP81h/8PCD5fe17wlNnKKCqImJcDQXmZQ+1e6oJQHgoZq1ssUoQTJzzIXHjwP1DVj8oKRuGU+nZCd2cdohLWTC9oMe1zBPFsos5iVCcE7pgyx9r/qfIYmiHekDtvP7NAMvFa0f/5NckGpAIgDM7wE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0zVmFgIA; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0zVmFgIA"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vjrnx35lqzlgMVL;
	Mon, 20 May 2024 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716241795; x=1718833796; bh=UHWlQ4EgEVFuXTjURZVMzoSQ
	XoJctPh8Eg4BqJ1zPMQ=; b=0zVmFgIAAVDFvjp4ly694peGlG1IUNCSCSGR8Jn/
	oKiXNa2mDGLPlLCHTewfQt3cj6XL7fO+rj6hdEG6B75rp2Z+lNpffSPxXRL6RWgb
	i1iD6dEr/y20FVOjf4Qa8ZHrlEGnf4W5wBVP+SAsElsJILKPOTvS0J9X10rfP3sE
	GQ0CNQXrfro+/VWSv94DxJIo9BTZ8xavvffGpcEoSLyll6NelRPEV9CgMdYnCVQO
	kZQgMoS8jm40BeWZVDPTeZ4jVR71PsKZVK1QmR6MhO6kMSFn7WmXW3OrVpPPI82d
	QZAM9E7Tzz9IVeY61p9AGdAD5yHSFDlGbT42AnAt+SbK7w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mxzb0nfz7y6K; Mon, 20 May 2024 21:49:55 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vjrnt4CptzlgT1K;
	Mon, 20 May 2024 21:49:54 +0000 (UTC)
Message-ID: <162da790-2824-4090-97a0-564c15ac793f@acm.org>
Date: Mon, 20 May 2024 14:49:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block nbd0: Unexpected reply (15) 000000009c07859b
To: Vincent Chen <vincent.chen@sifive.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
References: <CABvJ_xhxR22i4_xfuFjf9PQxJHVUmW-Xr8dut_1F4Ys7gxW5pw@mail.gmail.com>
 <2786c4cb-86ad-42bb-8998-4d8fe6a537a4@acm.org>
 <CABvJ_xhqBRXPLvVDmKg9Jub7hc6vXE02S=iSR7RWW-a8UtU7WQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CABvJ_xhqBRXPLvVDmKg9Jub7hc6vXE02S=iSR7RWW-a8UtU7WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/12/24 18:59, Vincent Chen wrote:
> Thank you very much for providing the fixed patches. I applied them to =
my environment, but unfortunately, I still encountered similar issues.
>=20
> [ =C2=A0 96.784384] block nbd0: Double reply on req 00000000619eb9fb, c=
md_cookie 51, handle cookie 49
> [ =C2=A0 96.847731] block nbd0: Dead connection, failed to find a fallb=
ack
> [ =C2=A0 96.848661] block nbd0: shutting down sockets

Hi Vincent,

That's unfortunate. Since the provided qemu command did not work on my se=
tup,
I have tried to reproduce this issue as follows (in a VM):

modprobe brd
nbd-server 1234 /dev/ram0
nbd-client localhost 1234 /dev/nbd0
mkfs.ext4 /dev/nbd0
mount /dev/nbd0 /mnt
cd /mnt
stress-ng --seq 0 -t 60 --pathological --verbose --times --tz --metrics -=
-hdd 4

I ran the above stress-ng command several times and every time I run that=
 command
it succeeds. I'm not sure how to proceed since I cannot reproduce the rep=
orted
issue.

Thanks,

Bart.
