Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC65291C10;
	Sun, 13 Sep 2026 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789292830; cv=none; b=FHc+JWAIbiO4Q2SvS3QPVi63aJcrTN4ACeIUvj/sZ6kDeZhdLXxBaD5RXcEMt6X/7tl9QL0kNYGVT5D8p9X8/GUTl9Y4JE08RfDaXRhHoXYVn+lfIQ6uj5RnVpZAtzHRQXvuKK1GfbGxq9LOUt4xpdA1adXYTrQ0b9wyOky5sBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789292830; c=relaxed/simple;
	bh=3fd857Ut9g0Evj4oQmORjmC/wxeI3+D+wmpVTsOChOg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VCz9dzkkn/SsnQG+aCjjHsWpRR2in+bRVUSVvjhxnP+MP3Yf4Ss0sWLsAAsQj+rWRbAGVC0wA4Hr14CxdDgtG9PjurmIwtimMxcpH3/fhlBK40KFpoK+5ELBH+HNoCPlpUnZ073t5VvgFKuskekbqdUe+NTkVJSr9cV+LiPu1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HW70Yekv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiHE1hjN; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HW70Yekv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiHE1hjN"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id C3DD4130011D;
	Sun, 13 Sep 2026 05:47:01 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 13 Sep 2026 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789292821;
	 x=1789300021; bh=C5O02FOgUJV2eD7/Tdr1zfaW0ja5wPl/auwAiWhgveo=; b=
	HW70YekvFj23niORcRwGFQaB6bT2WPD/0+s/xLkCk3zMVq8WODNh5nC+69ella+C
	ReT5db8s6lNLYPCPOxXwSY35vEX+ztbYKZeB+qlBJ/bIj8wUpLre9xdZ/HRAznen
	PSaHTMYgWtIEYSodbfyYJYalptsTmybAPFoqO2KY1ynHN8Ha9B1tgoh6fr+q4wf8
	4M8D//u2nN13V1Cz0NBj/fXifYIFo5KR3v0tcfFVBVtFDn/xgx07boTbXJc1tFja
	7oCMwyla266NeIv32yKAi76/KH85kf5VqyfOJAyVrA7sYyuCmVc27KFANbI2x3if
	oFI6ppjnfd0zABEl8NJHhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789292821; x=
	1789300021; bh=C5O02FOgUJV2eD7/Tdr1zfaW0ja5wPl/auwAiWhgveo=; b=L
	iHE1hjN9Y3WSkiRHfrNxrI+L00RjBOoUHozOrB9rnNmPEfCvuvQOCVwlOEbYPH12
	d+cXPsIf0m0Jlk2OZ39NY7P8xssh7eoDiBdVwn3AdY1CR7uM5pWPUXE5u3IVRd6k
	8dxfJl7THEQG/m3CXqS4/Vd3i4bRYHdpk2CQbgFNjq+AWs1VXef5SD0Rv62ss1Ga
	cQ9zzUexjJqJcwlD1PsZqKtR5BQH6B4YQlUoKQ2Rqr9nHQGLht7foAuez/aBuGaC
	VCFOrMLpoI4sdYDkbITxwTiNm6gTcQk22OkGMDG3yLQksQAUETuHOLJKHQ4Ejnyh
	jiYF5w2+7LUhw4bCKEpNw==
X-ME-Sender: <xms:A3GmancVAvJHPLrYMYu9wr6YNF2YL4l89gqA8pJGadftuykIOdL9LA>
    <xme:A3GmaoDhbsFxENlo91ZSr7lfYh6mbn_Ofx-6UT0pa6_mGcRweWW23kFORML49gGve
    GV5D5An_nKnGYOQVVXW-gOcTOWIBu766dWea-_QBI8QlMxLdoyVmfAJ>
X-ME-Proxy-Cause: dmFkZTEFgH1dd/EM0xmz7dEQ35u2zSjxqIskiFkogcjB21k2Xs8ibvJZKbAoO8xqF/ifqg
    f64y0e81vIeOGQ4A0UOr/EHfHSHZUgs4K7Gn0OCXN/H3nwakaCitt7BB0IsZ06hg4wBElY
    kNbHAEztR5aqPE3W3XWGsxdD7MeniPLVZQfltkta/dB8pyaOhulJ//R1EbKKLPLCspg2HO
    wr7NkLYwHdgRYuOftNjFiLQaPJkomfC9fDn+JShhHkUMLGfMXY4aQX8otOETnfpWg2dyZa
    XdcfmAMX3Tlt9x9J/bLCkSYVsFIK2ddTwubD3xYsaMPfOge5+kz49K+OQrbbIVgWO7wdQO
    HSiFzL8j8qvI6nP3VOncxo4wduXcmUaaOF+4ne8wDnB1yXIToEl6sEJzLNLRdv8UsvUfHV
    MGGtomUiKbvnBIgaFR8FAwDLyMv5tCybT+AsOxVsoRuhCZcNMBfDLvdigkuYr8Oabr00l1
    REahacYuS9YQ+oRSpoJWrEGMrRdGA9JzDbrAnkKgmT3xPoGXHSGzFL+bi6BCrBBWuAn4bp
    BacLF11P2L+PzTXtRtbQg/QGrzsfcIo0q1Wz6eV4eG51tumn98p2k0lFfRg5384ki23OT3
    8MAhwa9QXzlQUPZKldpyfopeUoMp4owpw8kv/tqKxlzyDsyS6UK6zHX9mSxA
X-ME-Proxy: <xmx:C3GmatqBX85FrQG-bwZUp4DsIfnxVGgmJmbbjARzd_J45BCdwZ90jA>
    <xmx:C3Gmag5CpunNiZFKwF3OI9Chb3rFonguZdAosFbF2wQkG4_nf2nrdg>
    <xmx:C3Gmaiq40mateAAwYdhyw5r3ANVyr5GFIvcp9_A_qrLPPqFBDzCpyQ>
    <xmx:C3GmavE2V55VQRcK3z5lS8ozsmX9Yg-Qv-PUz68BdHzK4dpcuOmQWg>
    <xmx:FXGmajHNgJKgjHyJBNpbV-XrXjInUmTt9u1JtnoT9ffdnNo9n-2Utn8W>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B073932A007E; Sun, 13 Sep 2026 05:46:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGTXWeH1PU47
Date: Sun, 13 Sep 2026 11:43:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linusw@kernel.org>,
 "Bart Van Assche" <bvanassche@acm.org>
Cc: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Drew Fustini" <fustini@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Vladimir Zapolskiy" <vz@mleia.com>, "Stefan Agner" <stefan@agner.ch>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Andreas Kemnade" <andreas@kemnade.info>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Roger Quadros" <rogerq@kernel.org>, "Tony Lindgren" <tony@atomide.com>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Andrew Lunn" <andrew@lunn.ch>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
 "Gregory Clement" <gregory.clement@bootlin.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Kristoffer Ericson" <kristoffer.ericson@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 "Shawn Guo" <shawnguo@kernel.org>,
 "Karl Mehltretter" <kmehltretter@gmail.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Nicolas Pitre" <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux-OMAP <linux-omap@vger.kernel.org>, "Ian Molton" <spyro@f2s.com>,
 "Jens Axboe" <axboe@kernel.dk>, "Helge Deller" <deller@gmx.de>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-Id: <0d964e9a-10ce-4f78-8b92-30f55a50ccfd@app.fastmail.com>
In-Reply-To: 
 <CAD++jLmRZek7MjW5LuLUb=u5RmgOyHy4V1OcTv7asAZJpWogtA@mail.gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
 <2144051c-268c-40b1-8c22-4be49f0edd17@acm.org>
 <CAD++jLmRZek7MjW5LuLUb=u5RmgOyHy4V1OcTv7asAZJpWogtA@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026, at 15:37, Linus Walleij wrote:
> On Fri, Sep 11, 2026 at 3:26=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>> On 9/11/26 2:07 AM, Linus Walleij wrote:
>
>> > The community has a built in tension around this:
>> >
>> > - One camp that are enthusiast like yourself. That kind of people
>> >    are running the show inside arch/m68k on Amigas and Ataris.
>> >
>> > - One camp who get their paycheck from present day companies
>> >    and constantly on top of the latest technology. As can be
>> >    seen Qualcomm just taped out a brand new ARMv7 SoC
>> >    named Kuno, for example.
>> >
>> > As you can see this leads to a bit of tension.
>>
>> That summary looks incomplete to me. Every time a kernel API is modif=
ied
>> that is used by the RiscPC code, the RiscPC code has to be modified t=
oo.
>> Removing the RiscPC code makes modifying kernel APIs easier. A recent
>> example is available here: "[PATCH v5] scsi: core: Drop
>> Scsi_Host.default_lock"
>> (https://lore.kernel.org/linux-scsi/20260831095821.3486994-1-john.g.g=
arry@oracle.com/).
>
> Yes that is development churn, but this is the same whether the hardwa=
re
> supported is old or brand new and doesn't really answer the question
> whether it is to be supported or not.
>
> That line of reasoning will always require a supportive hypothesis suc=
h as:
>
> - We don't want to support stuff that is old (deprecation and deletion=
ist
>   stance, I don't want to hear yesterdays news)
>
> - We don't want to support stuff that has very few users (utilitarism,
> basically,
>   the biggest common good for the biggest number of people take
>   precedence)
>
> This is implicit in many statements people make about this. What entus=
iasts
> ask is a completely different question:
>
> - Is this fun (for me/us), makes me feel good to work on etc.
>
> NB: personally I don't take a clear stance here, I mostly want to brea=
k apart
> the argument and clarify what it is all about.

As the discussion is still ongoing, I'll skip this patch for v2 and
anything that depends on it. There is obviously no rush here, but I'd
like to get the settle on which platforms to remove for 7.4 soon in
order to plan the driver removal for 7.5.

This is about 10% of the total size of my board-remove-7.3
branch, but that is mostly because of the oabi/nwfpe support and
the scsi drivers.

       Arnd

75e7f9f13efc ARM: remove riscpc
973b9263fc92 ARM: remove StrongARM CPU support
7d996576dfdb ARM: remove OABI support
c345282c3031 ARM: remove nwfpe floating point emulation
8a752dcb48e6 ARM: remove ISA bus support
1c2ccc5c012a ARM: remove unnecessary CONFIG_USE_OF
6b22ba07131a ARM: remove deprecated params struct
fdb4d531b027 Input: mouse: remove RiscPC mouse driver
67c968a3c911 Input: serio: remove RiscPC keyboard driver
76741210657f i2c: remove unused acorn driver
dd66946baaa8 fbdev: remove unused acornfb driver
925c897547d9 net: i825xx: remove ether1 support
460e5bd08398 net: 8390: remove arm etherh support
f3b06d87c991 net: seeq: remove ether3 support
c0a14d208da6 scsi: remove unused arm/riscpc drivers
5f9f353d4555 serial: 8250: remove acorn driver

 Documentation/arch/arm/index.rst               |    3 -
 Documentation/arch/arm/nwfpe/index.rst         |   13 -
 Documentation/arch/arm/nwfpe/netwinder-fpe.rst |  162 --
 Documentation/arch/arm/nwfpe/notes.rst         |   32 -
 Documentation/arch/arm/nwfpe/nwfpe.rst         |   74 -
 Documentation/arch/arm/nwfpe/todo.rst          |   72 -
 Documentation/arch/arm/setup.rst               |  108 -
 Documentation/staging/magic-number.rst         |    2 -
 arch/arm/Kbuild                                |    3 -
 arch/arm/Kconfig                               |  133 +-
 arch/arm/Kconfig.debug                         |    4 +-
 arch/arm/Kconfig.platforms                     |    4 +-
 arch/arm/Makefile                              |    8 -
 arch/arm/boot/compressed/Makefile              |    3 -
 arch/arm/boot/compressed/head.S                |   14 -
 arch/arm/include/asm/cache.h                   |    4 +-
 arch/arm/include/asm/cmpxchg.h                 |   39 -
 arch/arm/include/asm/div64.h                   |   14 -
 arch/arm/include/asm/dma.h                     |  129 -
 arch/arm/include/asm/floppy.h                  |   81 -
 arch/arm/include/asm/glue-cache.h              |    8 -
 arch/arm/include/asm/glue-proc.h               |   18 -
 arch/arm/include/asm/io.h                      |   28 -
 arch/arm/include/asm/mach/dma.h                |   46 -
 arch/arm/include/asm/page.h                    |    8 -
 arch/arm/include/asm/setup.h                   |    3 -
 arch/arm/include/asm/syscall.h                 |   27 +-
 arch/arm/include/asm/unistd.h                  |   28 -
 arch/arm/include/uapi/asm/setup.h              |    3 -
 arch/arm/include/uapi/asm/unistd.h             |    5 -
 arch/arm/kernel/Makefile                       |    5 +-
 arch/arm/kernel/armksyms.c                     |    2 -
 arch/arm/kernel/atags.h                        |    2 -
 arch/arm/kernel/atags_compat.c                 |  214 --
 arch/arm/kernel/atags_parse.c                  |    8 -
 arch/arm/kernel/dma.c                          |  283 --
 arch/arm/kernel/entry-armv.S                   |    8 +-
 arch/arm/kernel/entry-common.S                 |  144 -
 arch/arm/kernel/isa.c                          |   50 -
 arch/arm/kernel/setup.c                        |   13 -
 arch/arm/kernel/sys_oabi-compat.c              |  514 ----
 arch/arm/lib/Makefile                          |    6 +-
 arch/arm/lib/io-readsw-armv3.S                 |  103 -
 arch/arm/lib/io-writesw-armv3.S                |  123 -
 arch/arm/lib/lib1funcs.S                       |    4 -
 arch/arm/lib/ucmpdi2.S                         |    5 -
 arch/arm/mach-davinci/Kconfig                  |    2 +-
 arch/arm/mach-mmp/Kconfig                      |    4 +-
 arch/arm/mach-omap2/Kconfig                    |    3 +-
 arch/arm/mm/Kconfig                            |   46 +-
 arch/arm/mm/Makefile                           |    4 -
 arch/arm/mm/cache-v4wb.S                       |  259 --
 arch/arm/mm/cache.c                            |   28 -
 arch/arm/mm/copypage-v4mc.c                    |  113 -
 arch/arm/mm/proc-sa110.S                       |  229 --
 arch/arm/mm/proc-sa1100.S                      |  277 --
 arch/arm/mm/proc.c                             |   40 -
 arch/arm/net/bpf_jit_32.c                      |    2 +-
 arch/arm/nwfpe/ARM-gcc.h                       |  121 -
 arch/arm/nwfpe/ChangeLog                       |   91 -
 arch/arm/nwfpe/Makefile                        |   19 -
 arch/arm/nwfpe/double_cpdo.c                   |  155 --
 arch/arm/nwfpe/entry.S                         |  190 --
 arch/arm/nwfpe/extended_cpdo.c                 |  142 -
 arch/arm/nwfpe/fpa11.c                         |  116 -
 arch/arm/nwfpe/fpa11.h                         |  109 -
 arch/arm/nwfpe/fpa11.inl                       |   51 -
 arch/arm/nwfpe/fpa11_cpdo.c                    |  125 -
 arch/arm/nwfpe/fpa11_cpdt.c                    |  395 ---
 arch/arm/nwfpe/fpa11_cprt.c                    |  361 ---
 arch/arm/nwfpe/fpmodule.c                      |  178 --
 arch/arm/nwfpe/fpmodule.h                      |   35 -
 arch/arm/nwfpe/fpmodule.inl                    |   74 -
 arch/arm/nwfpe/fpopcode.c                      |   51 -
 arch/arm/nwfpe/fpopcode.h                      |  469 ----
 arch/arm/nwfpe/fpsr.h                          |   96 -
 arch/arm/nwfpe/milieu.h                        |   48 -
 arch/arm/nwfpe/single_cpdo.c                   |  112 -
 arch/arm/nwfpe/softfloat-macros                |  754 ------
 arch/arm/nwfpe/softfloat-specialize            |  367 ---
 arch/arm/nwfpe/softfloat.c                     | 3435 -----------------=
-------
 arch/arm/nwfpe/softfloat.h                     |  281 --
 arch/arm/tools/Makefile                        |    2 -
 arch/arm/tools/syscall.tbl                     |   69 +-
 drivers/hwtracing/coresight/Kconfig            |    2 +-
 drivers/i2c/busses/Kconfig                     |   10 -
 drivers/i2c/busses/Makefile                    |    1 -
 drivers/i2c/busses/i2c-acorn.c                 |   96 -
 drivers/input/mouse/Kconfig                    |   10 -
 drivers/input/mouse/Makefile                   |    1 -
 drivers/input/mouse/rpcmouse.c                 |  113 -
 drivers/input/serio/Kconfig                    |   11 -
 drivers/input/serio/Makefile                   |    1 -
 drivers/input/serio/rpckbd.c                   |  152 --
 drivers/net/ethernet/8390/Kconfig              |    8 -
 drivers/net/ethernet/8390/Makefile             |    1 -
 drivers/net/ethernet/8390/etherh.c             |  858 ------
 drivers/net/ethernet/i825xx/Kconfig            |    7 -
 drivers/net/ethernet/i825xx/Makefile           |    1 -
 drivers/net/ethernet/i825xx/ether1.c           | 1086 --------
 drivers/net/ethernet/i825xx/ether1.h           |  277 --
 drivers/net/ethernet/seeq/Kconfig              |    7 -
 drivers/net/ethernet/seeq/Makefile             |    1 -
 drivers/net/ethernet/seeq/ether3.c             |  898 -------
 drivers/net/ethernet/seeq/ether3.h             |  174 --
 drivers/scsi/Kconfig                           |    2 -
 drivers/scsi/Makefile                          |    2 -
 drivers/scsi/arm/Kconfig                       |   74 -
 drivers/scsi/arm/Makefile                      |   14 -
 drivers/scsi/arm/acornscsi-io.S                |  135 -
 drivers/scsi/arm/acornscsi.c                   | 2920 -----------------=
---
 drivers/scsi/arm/acornscsi.h                   |  350 ---
 drivers/scsi/arm/arm_scsi.h                    |  136 -
 drivers/scsi/arm/arxescsi.c                    |  363 ---
 drivers/scsi/arm/cumana_1.c                    |  341 ---
 drivers/scsi/arm/cumana_2.c                    |  524 ----
 drivers/scsi/arm/eesox.c                       |  646 -----
 drivers/scsi/arm/fas216.c                      | 3039 -----------------=
----
 drivers/scsi/arm/fas216.h                      |  407 ---
 drivers/scsi/arm/msgqueue.c                    |  168 --
 drivers/scsi/arm/msgqueue.h                    |   79 -
 drivers/scsi/arm/oak.c                         |  213 --
 drivers/scsi/arm/powertec.c                    |  452 ----
 drivers/scsi/arm/queue.c                       |  319 ---
 drivers/scsi/arm/queue.h                       |  104 -
 drivers/tty/serial/8250/8250_acorn.c           |  138 -
 drivers/tty/serial/8250/Kconfig                |    8 -
 drivers/tty/serial/8250/Makefile               |    1 -
 drivers/video/fbdev/Kconfig                    |    9 -
 drivers/video/fbdev/Makefile                   |    1 -
 drivers/video/fbdev/acornfb.c                  | 1102 --------
 drivers/video/fbdev/acornfb.h                  |  166 --
 fs/eventpoll.c                                 |   18 +-
 include/linux/eventpoll.h                      |   23 -
 lib/fonts/Kconfig                              |    1 -
 scripts/package/mkdebian                       |    7 +-
 136 files changed, 80 insertions(+), 26810 deletions(-)
