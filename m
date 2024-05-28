Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB000140E5E;
	Tue, 28 May 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888158; cv=none; b=SpxsiRRnd6TI24vMAIAAnIxBSddOObxZl0tqAYdZdOIHeCVeM5QJQQBFk2u+kSQkdAVqGyiRGzFv9fYoSvWIatF+bXM/H/IS2qXkq2tz5suzsOBi3oGILrnHZ7ybLz/9a/22KwAo7n3MmMnaYynpb4qu3TX2v7hsDlLHXTsDubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888158; c=relaxed/simple;
	bh=GwLFmpw97dTVYyGyXOWlFoh5Bpf1I6pea4ghGTgTLHA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JrZZSt6AfELDsGs9vPS93qr/jD4gJfjzCCOAo+ibJxVXSypAfhxbPga9AyZynNh4kKJRQFLj2yUbyBtX4QzrzZddJXZmJAhEr+cDVmR3+dBh2jrY9lb9a2d23rpuExjMuDMacD1mVlkvJsFFotmFnoXJg7VZvQ9Wm4y0dwFhv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BCP5g6DC; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BCP5g6DC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716888144; x=1717492944; i=markus.elfring@web.de;
	bh=KK4Se9epQ/qlMcMAbFV7gUJ2n7pL1maRb0tzRBLSB0M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BCP5g6DCabvTJVw7DA6C1tR+bAwAGCopnt5wzzgHi6Tn2IO2a0lt+Rh8h0pzWPu8
	 T8aUrXGPTXqjDXND6uRZs35R+QxOsEOjvscrC+JPGOpK/7QsTLx/dP/2pgO+RAh+a
	 4hl6MbhVFOT+O6tqY2OumtHxyzszX/YgDt/BaLVyTvWPbSYQIk+qzl2GQI31Ejdr4
	 pyiGTKLV1rlJOBGCji3op6HwuKNBmRCSYOnIS+Aq7aQgEA7ztXiYyUWr+cyRbrWK8
	 n9Q2zwjuwstgmjVen+8n79GjEy6vEx2TXoBVjgPU+9BtZw+m19gj0qsOxU3tWnLTC
	 QnDfcNLlqa/J8M19MA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1sGoio2xM2-00Dn4P; Tue, 28
 May 2024 11:22:24 +0200
Message-ID: <534687df-c200-4741-ad00-a847e8fb8b12@web.de>
Date: Tue, 28 May 2024 11:22:23 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li zeming <zeming@nfschina.com>, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240318025525.16439-1-zeming@nfschina.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_blk-zoned=3A_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240318025525.16439-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eM83rr2d+zGxhfDZp62dOSXDrvp87wT2RucariXmvV4AU2oKs/e
 lnyxVqawxhdmBoiRoZ/sYbo7IpxR1LIz8stnY+iviVZgFJWuXhMtho7gP+1/sbsZHOa4BCT
 MrTnn2nmk0hpQOw5qst9MlO9GuX9iKoBb9lo1CNRkrGRv6PWiImpEUHRCk5o67XeoLudQUY
 deChX3bHs6L7v07b3VD9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4oaWStMKZV4=;4V9uRLua0azCPe4/J6EQ+VvExt2
 wQblOJ4PAX5S92ilATNsmXfG8vboBHf3M3pWcaKwsuU01yrMxJWQf9SqKoEENj9apkPe24LS0
 pi/8+NuJObbamUHL8C48uupKW/Olta9ktqWccD2riSEZbJmLBk3kVLV+n4cORfN9HXG69coiw
 /mE+vPQOev40xCf9nbqPqEZGaYnvUuL9BJk2mqz/UXQljJufkcz6TQ5fR7AHQr+9j/vecmRGX
 e2mwUYfmdqOpNEZDkjYN3X78vbO8H+CaZkR3P6clcmiIvgVNpuvnBUgQ/Lm/HiB7/kabJaVRW
 LNfAeX78YYl5RO/5nmCFg0NZDx12c843NGci6qRpxUXuqhGswQ9VAyHXWxt2tcB32rvEqpS0F
 yS+2Whsc8rfPqrUAilfZUEl3oOR3lwVirwlgu7tblhcRumr41R2FDC6BY9I93duj4djif9Be7
 kKC2jb3FDsch3FB+TkfqscdDAECkUVwHkWfjlWdKBY0Br30HSLvOa5Bp3GgZ7SnoG1jStduCL
 xpWlbEGfNJvfIV4bQBOgUnthzzHo8MDXYS352e3WMuQJFE2viZPvGDfsSzxyuqR7j3X3vrF6G
 f4sgrxpVMqYcfHLSX2oNCzQgoS62LhMLMAEHiYTs+hY5RgjnnBaOpfSEUNyo0ZncOq5/je7Mw
 P7nlF8vrADWIXDrfqFkk3J5QPUlNFUmANy7RhoPeMB9JnN+/UbsTpRSca4atUhCb6qRLw1V7N
 aEdKHv1YcO+9KwD8NIrJ/DU16KzDY0ik64Wozk9iBPHn+XpKVpgSEJwRJSYzns14FUGQUerYf
 bRTVugUhx/qb/wghrPAYh19Wuvj/FSnBUk6mM5rsO2DAg=

> ret is assigned first, so it does not need to initialize the assignment.

* Would a wording approach (like the following) be a bit nicer?

  The variable =E2=80=9Cret=E2=80=9D will eventually be set to an appropri=
ate value
  a bit later. Thus omit the explicit initialisation at the beginning.

* How do you think about to use the summary phrase
  =E2=80=9CDelete an unnecessary initialisation in blkdev_zone_mgmt()=E2=
=80=9D?


Regards,
Markus
