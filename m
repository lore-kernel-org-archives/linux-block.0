Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7D39A066
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150511; cv=none; b=fjtzPLvog4yrDhZoBDSqPZmulwbZhHBF9X8/PDV8KzDqVnaOn1LjLrlH+8gDPn8ljzoDKkpTpHW7/uWg2FnKZGq6BBrkCxL6Hs3m78STHEvARyPEbJPT7Jg8MvtF71A/DrjxcuOB1JXu/WYGpUC2ri0L8FKGp9TUzWlEEgL3B+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150511; c=relaxed/simple;
	bh=Mgahn01sS5gczturDy/G4PNaMknNPNwtvnNftWb1g/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqbdEcKo7Newji4WwTUacuFs778uBctRBtISdXURbzxKikI/tvpEzyb8RFmzTKF+c9VRAR1kfy31lQ+mCFsIHxQ9DK+dJqL51P3aDkXPxYTinEoW9qulorUeh3LXnfbGjLjSv+/Kbu2eFfa2urIKrZEl+du+5W+2WcizVoEcXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6dcLPin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6dcLPin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CDC1F0089D
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150510;
	bh=6+jUOnuRGVnXKnZ3KWqfUO9v4zUR2jeqpm+66XJzwFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U6dcLPinpaKlwlRALrFH4RPaWbGAHDSK/SLwpMlzm/w5iG3i8NNdsnbyhZrHSdLKy
	 awwaN4tpz59egQpc/0FaXrxMN2dbDBZWlDNLr0HbcQZoK+DUMe4j1EvLT95qzJvJsf
	 ji48B6gC+cswel50BzsT/YqnhjE3T/rrX3IDZ5DITGs/xUw9cb00akcnFjgqlUQAQB
	 PqQsS4sJAaLi/yR73kgZNZR0jSp/bDeqvAHtuUfeCLc3ZEwh9BMk5A6n9IPvOzcYpQ
	 PW0cEHcJh3uCODO5ez78rt9j3ZmPVEk59DU5shcGBzlIAgVTJMBYAO2cxRBdXl9z+N
	 NTjSRYD1CId4A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b4af730f8aso1406567e87.1
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 11:15:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByWamD08nDKkoYgEWyMBSLoSo7W06Og8uRaUYzwrGoPrUwapncNPMhZcSEeByXaZs4Qgl7eqNwhOF0hJQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mvG6llYHUhv4FJLHK4MhPfRaw1vL/nF4utdQVGqEO9J1+W0OEf
	WOBGNZi70wLLmEVad39I8JpI+wiqAoQZ2fZI4mmmD7iiFo4ukpw3v34OrEz5Hn7yJJgfgpRpX1v
	BkQsWF8kjvEJ4UATocPUJ7GWfikrZSEE=
X-Received: by 2002:a05:6512:618c:b0:5b6:183c:5c8b with SMTP id
 2adb3069b0e04-5b8a0311474mr1248761e87.41.1789150508682; Fri, 11 Sep 2026
 11:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com> <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com>
In-Reply-To: <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 20:14:56 +0200
X-Gmail-Original-Message-ID: <CAD++jL=zaF1zcTv6Mta5Xw69WeLC30NRcH0_pkSkLJJ0UtnZHQ@mail.gmail.com>
X-Gm-Features: AcwNN1WjZ27WNa2xIf0xCkX2Q7TecAH1yvD-cA-Z7rRTMeFdlwjxtS93LAQhgdg
Message-ID: <CAD++jL=zaF1zcTv6Mta5Xw69WeLC30NRcH0_pkSkLJJ0UtnZHQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: daniel@0x0f.com
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
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 4:38=E2=80=AFPM Daniel Palmer <daniel@0x0f.com> wro=
te:
> On Fri, 11 Sept 2026 at 18:11, Linus Walleij <linusw@kernel.org> wrote:

> > - One camp that are enthusiast like yourself. That kind of people
> >   are running the show inside arch/m68k on Amigas and Ataris.
>
> I have SMP working on m68k (dual 68040, real hardware) among other
> oddities. I think some people would get a kick out of seeing it but
> also I think some people would also ask why we can't just delete
> everything that isn't arm64/amd64/riscv. I'm putting off sending
> patches like that to avoid everything getting deleted. :)

I have actually thought about SMP on m68k from time to time,
because there is Swedish hardware with enough memory to run
Linux with SMP like that (DIAB SMP m68k Unix computers).

I would say using generic entry would be a prerequisite for
doing m68k SMP so we don't introduce *more* entry
oddities, but after that I'm game.

With generic entry in front I think it should just be merged,
but that is me personally.

As SoC maintainer I see that m68k has a lot of technical debt
like drivers under arch/m68k and no proper hardware description
(such as device tree) nor is it migrated to the actually standard
board file structure (fwnode) which we use when we have no
other description style.

There are things like
amiints.c, cia.c, ataints.c, q40ints.c etc that should be in
drivers/irqchip. So many time.c that should be in
drivers/clocksource/* and many other unmodern things.

Albeit I think actually going and fixing that can't be super-hard
in the age of LLMs. So listing things like this likely will just make
someone go and do it. :D

Yours,
Linus Walleij
