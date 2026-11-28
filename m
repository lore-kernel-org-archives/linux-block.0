Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795898141;
	b=l52d2ukN/ea+vDcGqObZppEGpOkL82c7El1+ujEDOnURtJSHAhme1CopkailisDbtcJn
	 Hjcfubx4puan0/0el8Qvfg8SX2yeu1mi0XczH82Iz7nCAZIkWyHQopV7tF7jG1m011XJr
	 AoH6frYvhDpAiPuzRYuKDGJb/p2FxRLP6yBOlmUvJNcGJv8/Ftl0kGFsi1xaftO82lEZo
	 YCn2XXh0s/BWsak1XIh4N5JNBQiDBv19PVRZr04A3jP+ajbNFI9JyDOuVHTl0cBmJqp/K
	 rxL0nOj41rZ19LJnQkU+afstz81Tuvp8kUVoLhm3HHKvRLnZEKgkluq3/+/3VRCyqoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795898141;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=TQs8KeF3qOCZCKGNZC6BmMSUbHbh7n768vONY2+i758=;
	b=H9RIkbQT2SBsC+b4MRaYgcHZ25uXNo7qUxSggtY9BWt8g2xDEds4Bdso8s3T8SofbRR2
	 qVSL3CQZkJwzOZkJ4rp9D1cyVMpzvN3ZI7X5UwEzkksC9mF0R7sEsaM1hvLQ3IaHYXApQ
	 27tqUNrfmrJSi1hBptt3E1XMLGTB3m5hJlmqzJAWvLESN2+XFbRQN0ud0HzsMzt/LdqhR
	 YRHTduAapB+iqrZo1ET/ACczLPXZNbRF+Vc8V71fRUH9FvtR1txJ/TcyQB4stlq1nMgk/
	 2xZVapl60Djnvf/VQ0yn7agMdCIDY4HV6xY/iplRv7ej6Q5CqbH85akm0+w84VGf+iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=a6ISksRX;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8BB606A321
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 20:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A8BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=a6ISksRX
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EE0F524010A
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 21:35:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1795898131;
	bh=TQs8KeF3qOCZCKGNZC6BmMSUbHbh7n768vONY2+i758=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=a6ISksRXxvR4fCepOkifuyL7qkAEfnYaoD1BUwrYxsVa+lyq0Ie0svSMrusoRBKN5
	 uZm/k8JblNLcKO+cBQp+mGXtXVpsmhULa5lAgDQRURzXOvUnF9wV+1cNHG39GCB5bs
	 atxKNERAVeGMS2+hBYOfsfTzFGYfdqPCsMCDOjaI6NpXP+BbVw5dB/B85sLT2jzr1+
	 Hgn89FO4BUuZiXgtDtGJSkzNzxK/CBTxt5oKzsc2hNbym+2gfIFVk39puWIgeQ/kqF
	 l4IS3slsIoRGXX/T44BJe5jTnOwxOIKdCI0rJhdbE7YieWt0Uxc2yCRi/XmECDQbd9
	 ceMtLE+cZvoHA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jcMVT0FZhz9rxD;
	Sat, 28 Nov 2026 21:35:29 +0100 (CET)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sat, 28 Nov 2026 20:35:31 +0000
From: Tobias Laas <tobias.laas@posteo.de>
To: 70sp <70sp@protonmail.com>
Cc: Laurence Oberman <loberman@redhat.com>, Bart Van Assche
 <bvanassche@acm.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Damien Le Moal <dlemoal@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, regressions@lists.linux.dev, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Will
 Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase =?UTF-8?Q?BLK=5FDEF=5FMAX=5FSECTORS=5FCAP=22=20=28=36=2E?=
 =?UTF-8?Q?=31=37-rc=31=29?=
In-Reply-To: <l7ImnFzOgVkMzGhZoxCBcI1dAbMnO2NlsstuK-4sh3CyOpWhWAC1RqFIr4CW82iTy3FZe2r1k4EFFtecv5PClmy_mvh10vI9W_W5Z5p-jlo=@protonmail.com>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen>
 <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
 <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
 <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
 <uJluFNYGCCrdvnYT3MatN_4Om8UczTJX_dzxumJxyCAC7F-Ubrekb7LPwlRxhCW0J91UBf-TqeRoJQfgYIYBRvMsPmE-Qs1eAg5zbDP0s58=@protonmail.com>
 <0edb9525-5068-42e6-b6c3-a1dcebcbcea7@acm.org>
 <f323c3d62265dfe90fa71514028af4d35f6e2420.camel@redhat.com>
 <e_efhbm0Vxq0FxO3-QqPkyhGrjzTvBDYmUOsGgmebVSyd0qsXXxYFXwC9sSjRAP06gcpsttHunBLtc0Mmt0cIjEI_0sDXL61lnxHhmuaxWs=@protonmail.com>
 <l7ImnFzOgVkMzGhZoxCBcI1dAbMnO2NlsstuK-4sh3CyOpWhWAC1RqFIr4CW82iTy3FZe2r1k4EFFtecv5PClmy_mvh10vI9W_W5Z5p-jlo=@protonmail.com>
Message-ID: <8af3946c0809f007bf0669ec82f701ec@posteo.de>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable

Am 27.11.2026 14:57 schrieb 70sp:
> Hi all,
>=20
> I have taken a look at the patches and the entire problem much more in
> depth, and there probably isn't a significantly better variant to do
> this.
>=20
> In the state before the regression, the kernel was assigning smaller
> page sizes for some cases, so it wasn't ideal as I thought. I also
> haven't found a better place for the quirk to belong as there are
> already exemptions for specific platforms in the code (I thought there
> weren't). This one is probably fine.
>=20
> I am sorry to Bart and Laurence who had to handle this. I thought my
> patch was bad, so I thought the same about Barts, but it looks like
> it's the correct way to approach it.
>=20
> I was told to repost my patch formally by Lu Baolu (
> https://lore.kernel.org/regressions/d931a389-c143-4a6a-931c-bc7025bcefb9@=
linux.intel.com/
> ), probably because it fixes at least my case.
Hi =C5=A0imon,

thanks for the update. I highly appreciate your high standards.

I see that your patch sets intel_iommu_superpage=3D0 similarly to the=20
sp_off command line parameter on Haswell desktop&mobile, whose=20
datasheets (volume 1) all say: "IGD Intel VT-d engine does not support=20
superpage and BIOS should disable superpage in default Intel VT-d engine=20
when iGFX is enabled." I just wonder whether one can use superpages in=20
the default VT-d engine when the iGFX is disabled. If this was the case,=20
an additional check whether the iGFX is enabled similarly to Bart's=20
patch (or by checking bit 4 of the DEVEN register, see section 3.1.14 of=20
volume 2 of the datasheets) would be great.

> I think we should wait for confirmation from Tobias and if it's
> positive, we can send out the final patch closing both cases.
 From what I can tell, the patch is highly likely to fix the issue,=20
because it automatically sets intel_iommu_superpage=3D0 similarly to the=20
sp_off command line parameter that I tested, which resolved the problem.=20
I am afraid I have only limited access to the system at the moment, and=20
other than my question above, I don't want to delay the process, because=20
the patch works correctly on your Haswell system as far as I have=20
understood, and because setting intel_iommu_superpage=3D0 with your patch=
=20
is the same for all Haswell systems.

Best regards,
Tobias Laas

> Thank you for listening to me.
>=20
> Best regards,
> =C5=A0imon Posp=C3=ADchal
