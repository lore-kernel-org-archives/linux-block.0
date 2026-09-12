Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AE2E718B
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176586; cv=pass; b=G+mqyxocC9RFye5ISoNBB1XUGY7V6YzAx0yeTnUqMVQfaoz+Ppp3vYJjfHqW7DOeHXkLkWKwXYzIxZbPH4b0EzBQYFqOaXxoSrAItChoTrCxb7P4WHqwxTtxOtVJsPNnUvZFuDda/VY6J7QR2R52neWuCD8oOKMlbVgqWib1Wbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176586; c=relaxed/simple;
	bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obWk63JuHcJczXJv5yqv1IHbsm7EMlPChMQ7ry+l9fs0kNl4x7bCrzZ/RI5ImuYdjQTnFSr5kcK1icPabz8XhqC0vw9PXqfie+7iWCPltfzJp0iahxxYj78BASX8ZCk4+16kt4AKXWcBPAlVA8k1a0R2Qojb59Ou5Y32rbcAQZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=QAqLa2iA; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="QAqLa2iA"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso4937825ad.3
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 18:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789176583; cv=none;
        d=google.com; s=arc-20260327;
        b=UF3y1sn77hdVaKZOGT/ZRzV2ua4mIr2PGoca2PdbKddns+rEkkFlc4mc9mkvwjMGHM
         5+PyvqJUfBte47v0ZyZazjpEqN0EmQDzkRI4Kwcl8BaB+/T5Tp6kh0CU1+RbXbU1Yt5I
         72Ga+RlLsrNkCW9Ey2xcFaeJhFi1jyiK+vBCqWjhKKmKENVNIv4pTOzNkgeqEANR7Olv
         ZPpENbfYWCRnq2kFnFkZSQRhrgL8LL2FNVdpMthASzk85O1jfZd5/C3CxVV8Ew1wepgz
         mXLwR9Bi2qeY4DdmHCg/sY1wA7Ps3/B8BoSl9HFzxw5J3ogfN5oz86PIl4X8dUOc8toW
         zGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
        fh=3PqUYbVDLqiWBfm1oi+Tr+DAsSI7VEFcrK5S6xm+yZg=;
        b=PUd4Q13TR9JntE1oGmFYJYq1BHIMqOF4+SERLEwUKKbGmp4SG/ZRSVmTGtJq3VUC74
         CTCjdqq7eU8QdqbzQ4sWTmkJM1vTotTwTkmjpDP4rxi0L53HkXq20f8GIn0VRkzb1wgc
         eUZ5tQN6PHmHBAXZAQoFFSt222oFw8RgXPDg7l1BT/nQ//iOCe0QTVAAJP4d3xUeBpQS
         dup+dLyH8D0qU23KPpha20sl8jyPuPT5cwThFt8qgDCc+3JPzJ7pO3v1i/Z3c1qsPIxS
         r/6+QkPRBbJBy5ANn3nc1NDm8v8jVDAfwqZdt81TU1FUbM60nU4fOVZ/wnqV6aKFN5hm
         iHjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1789176583; x=1789781383; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
        b=QAqLa2iAbwvbRxmC6B/DPpQl65ZVNzEquWN6wGgAhav0o7h1rYsToOePhjX5FWfOwV
         2QVaUBzUttmd9Bo86TSJ6STiOqDzCq4lJcczZXWAE7fbGVZ3m8PWgwWu+anMzWklqRTP
         /wcfwddYmq2X1nPNtWMdy+IL2+QUWEynTsNoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176583; x=1789781383;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MqFZZ1MZCCOk3B2AWbqhU4vVtD/Z+SwXDy5HKI6vso0=;
        b=qjK9M5xg4FzQZA7NJx2njR3sb+JpwexuTvDe9NFSI2JNOEwHCWDyM1ryhQn5BbqeKz
         /q9EwAFX5aEPVMoBiG5WczzdlClzayk+Ijxp2X4D2HjP+UOl8wumqqXY+RjPW8Pt+bFr
         aKPAuBSvJh79ZSKfhf0DMfbCh3BIftPT19HNAXBMxUC0z2gaIAgGBKvLztuXtLWPfidu
         kWDahnm8PqeO2vx6ZovZoBKX22bSHb64tcpiEf3StwCoZufdgjSHLx2yhOFCQ6nZrBtb
         U+dxYEj+zGomkwRH7LlA0YCoeWKiWHXj7NHln0u8rHRlrt2abOPP13SulvtOZmMYgR1V
         by2g==
X-Forwarded-Encrypted: i=1; AKwUvByxUqSffTNwpPdoOl8p1SlH+VyrfW3IaeL3AXuBgdh3MYdYHIXijm6othL7a0LYAU2kYowTDEZxKLZcSA==@vger.kernel.org
X-Gm-Message-State: AFuF++kbeS/JX2FIRBbim36rEYcKyocB9VFE4p3oWj9L1wrgWZeTIH8R
	tMdUIcczpf7YVf36K+LWF0Ng+wrNjb9ey4LW9rOTMjCrAODK7BGdlNLb1EaldY+vd3qhhW9dVGt
	EkmT+LRDeQrSw0Y8khMZ90eWZCW7qWQT18dMrpmKCcA==
X-Gm-Gg: AYBFou0YFmv17bm4Ivi9oojNwlWofUdyAglfmbxdcVJQRxhe0tg3aeiuGwWM/s311/2
	d+iO2WR7kB6G9SbKe9Ok32Uhd96xrKHGEvmBBsyj3JAL1i8QqbhFCYK9GMP7hX2nl9AtELntr14
	x+XQaboZnKPh/pzP9AGErq1ZvEjLiDmhA7LWiuWhof5ZmKETDK2/K8PJKAjuYx8Ve5g0Phimenx
	yU0pCL1rOiN7XHjjunu0c7HMjVo3GKNuLi5TO1BT3krRvFBOhTcBHugkc5dfvD7qRbu/wNxWhh0
	cwkoEyzlLZ952DLHAx2+arZO+vMiOv0KFAK0XxBsHPhal1WMbKPzog==
X-Received: by 2002:a17:90b:4fc2:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39d9bc42d1bmr12376403a91.6.1789176583130; Fri, 11 Sep 2026
 18:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
 <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com> <CAD++jL=zaF1zcTv6Mta5Xw69WeLC30NRcH0_pkSkLJJ0UtnZHQ@mail.gmail.com>
In-Reply-To: <CAD++jL=zaF1zcTv6Mta5Xw69WeLC30NRcH0_pkSkLJJ0UtnZHQ@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 12 Sep 2026 10:29:30 +0900
X-Gm-Features: AcwNN1UYIuhyU3FVES8GlXYNI9phDxlCK3dBrZsiSwUakZtphqfaiRPyo96Awf4
Message-ID: <CAFr9PX=tVOzqGU4k0zSzXheuU5z5LZi4LSGdUvjChrSTrbyjJg@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Linus Walleij <linusw@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

On Sat, 12 Sept 2026 at 03:15, Linus Walleij <linusw@kernel.org> wrote:
> I would say using generic entry would be a prerequisite for
> doing m68k SMP so we don't introduce *more* entry
> oddities, but after that I'm game.

I have started this for one part of the m68k tree (68000), but it's
one of those things that is hard/frustrating to test on real hardware.
For the last few weeks I've had claude create a QEMU that can boot all
of the m68k supported machines to Linux, Netbsd and their original OS.
It already found this:
https://lore.kernel.org/linux-m68k/20260828094940.3882602-1-daniel@0x0f.com/

> As SoC maintainer I see that m68k has a lot of technical debt
> like drivers under arch/m68k and no proper hardware description
> (such as device tree)

I have m68k machines using devicetree... :)

> There are things like
> amiints.c, cia.c, ataints.c, q40ints.c etc that should be in
> drivers/irqchip. So many time.c that should be in
> drivers/clocksource/* and many other unmodern things.

Would be easier with devicetree. But is anyone crazy enough to go
through the pain of merging the devicetree support and then arguing
about devicetree bindings for each of those drivers only to be told
m68k should just be removed?

> Albeit I think actually going and fixing that can't be super-hard
> in the age of LLMs. So listing things like this likely will just make
> someone go and do it. :D

Once you have an emulator that the LLM can operate it can do the
change/build/test/debug cycle all on its own.
With a test harness it can even test the changes work on the real hardware.
But I don't think that's enough to convince people the changes are
worth reviewing/merging.

Cheers,

Daniel
