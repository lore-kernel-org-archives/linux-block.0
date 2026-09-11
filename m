Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737A49DBB5
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152208; cv=none; b=XrksFwnoDQy/1M+QuXgn/7C4Vtm54hXz9nMJe9p8lvs2n+E0qQvNT7Se7nCYYp7Dp6eTPr5jgNKLktDie7HjmdHR1qJyWDnhy41kZ95fTKRiWLAatakS7ZQGpzK01x8a0XY5UmAq632OPKlqlnXLP3QB1pK9YAjuq1sJ75bSqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152208; c=relaxed/simple;
	bh=Vo/Zbo4FmIJeIV5z2fixRdEtyG30qlGNFYOjHoNYkqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfEWeoyhHf9n+idlcn1ZMxgDrks9tAKLdn+3JFraYvLpM2puSouuXDoypNdzDRMs47VTHePpKNj/5R1xOoapgaVIqf6AanfHViwnnwLzKci8r8kMPv6hkgmOX8cPspvDburR0XlWL4la5ceoTLtP4Dg0ohInoXEBY9M6K1nHcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkmGIJbB; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkmGIJbB"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so95786f8f.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152201; x=1789757001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEMRrWkwvFIDZfKdDi5vmlHb7sgj26/s86919xqFCGg=;
        b=hkmGIJbBp4EQG8Uj6bpqrQLLIx6687IoycAymJGV+AQbiulxMddwk/XjuxgBdaOgRh
         vjlGnpEswovnh80F9t8tbcEwpHnU7ilhSJSoW0LTmXGNZMYdKZcQBLvAHXrDgJBDeok7
         ZqmJfVVT1Y2C7Yk7vcFHuRPXWxQ6+IWNvElRuinPE86yblBvn8Wnq2azuUCCa5QWd3bf
         qK4b/vMq22GGwsDShePmi7WSgExb5FsepmNmXsf5rbELNjDZ37OVZnFrpjXxcBMNVauO
         btSHH3MjcKO15Zq7kM/kfsFWwG6wlO9FmPwkucU75k99FIABnvOlg7eQK01Vvw9l03n6
         F2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152201; x=1789757001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEMRrWkwvFIDZfKdDi5vmlHb7sgj26/s86919xqFCGg=;
        b=Xm+C59W5LBGK5vcFcLmVzPIo+I8FjJY1XK/0f6CeHNjjiOrmipVfT8gPITcgfc+KHU
         ZEOvB7MRp7TLw+9gtS4ORkhj68n6rK5Rs/bjs4Xwnd9aLAeinhXrFthC0oqsF8u5ApPW
         gCJfQ9foe/yp6ZHEw/Quwwn/exgx7WDATfcIGz0PyYl+OsCqYIH/J9ayRXSq/sRf0TCH
         XE+phkdHrxHSG+/9gJGWTV0+MtctzBsgxdRt620QmszuKrgnLJiMbex6IMTIzlkKjB6c
         Q6UvkGr77jlZgevQYkKM4CfptYi2dH5P81sgIDDbcdGhXBHYXVl8DhRKQ16ocAZmf9Dy
         0AWA==
X-Forwarded-Encrypted: i=1; AKwUvBwBtAFecWXgFiO9DYNYwJ2PtThZaqpfBXTLb+CTLt3VGu9jKhKAcXNy5wLbGWu22Q7W7lTHfgx6GoUYMg==@vger.kernel.org
X-Gm-Message-State: AFuF++m+G2XFjPPtNlR2dK4eFf01z+3G/c56zffRExoUrXRqihOBz/03
	OiofxOEf4suYbTTyzVsviUUfkRtqqE9nBJo2cH7foSMi7VhT/2rfhQQ5
X-Gm-Gg: AYBFou3DWZO/r9WcG/Z0yOVmWkEZXBpKKFhDLERARe75XkLSjcQ4pJsbYQ6RMtaQjY0
	XvWQjZT7SwEBzMy+7Le87pp0K6g1rVsShCEhuEhnoshQgWDvu+/PIyuwD9nmWHwGsL08X/IaMNg
	9UiYdzjzkVZkVB3/CbWm+dh3+BzLKMW/QcvIoPOScrTdbhI2lvvwXz3v1XWJCZ+LYDclfHJc6Qj
	Cqeed+EpulvRqiO0yLa8Qv7Rtfkotfoz1KYcnLndBKSbcGtMlxBwao3YZDkh6WRQEdb8OZuzcpz
	grSt5M7+wAFbXhuDKIMgfgg1DKNICHBQS5+lm8Tfw16h62Oo0VJgq5TeYw5cibN3oAlkRkpnuAu
	4aaM2ndu4I5mM5EARGKGaesa30jNI1fh/KDMFB9AgY8caRqlFjDjR8LPWzoxSZszzrfqDwhQeb3
	sDq1wtBHi8TxMJxnIypFw67G1fOlOr3X6dFbLW9aSrFDcyxcI7fgDSOXB+AOKO+lblM6WB4kXnL
	AaGrOYUkyJDbXWdxyBx7mbtWlSSHPOTZx15e8Lhk0AkgLIlK1aXJ/Pb4YSr/4cPmh4i77LvR4oE
	RZjMuESLnnGscHZLF/c/L8ji5jFlRNqQ0FsTnansdKrdfzGK5Q==
X-Received: by 2002:a05:6000:4605:b0:485:ac39:36ef with SMTP id ffacd0b85a97d-486eb1d3781mr14290458f8f.5.1789152200719;
        Fri, 11 Sep 2026 11:43:20 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f0403125sm5446009f8f.8.2026.09.11.11.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:43:20 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:42:46 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-omap@vger.kernel.org, Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, 
	Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 03/13] ARM: remove riscpc
Message-ID: <aqRI3N5FPX1dpIlk@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>

On Thu, Sep 10, 2026 at 08:44:34PM +0100, Ethan Nelson-Moore wrote:
> 
> Because I think it's cool that the kernel still supports actual Acorn
> hardware, I patched gcc 16.2 to restore ARMv3m support:
> https://github.com/EthanNelson-Moore/gcc-arm-retro
> 

Nice.

I've made a RiscPC emulator in the browser using QEMU and WASM. It boots
Linux kernels and currently emulates a StrongARM RiscPC:

https://github.com/kmehltretter82/risc_pc_linux_emu

I used LLMs a lot while building it.

Your GCC work looks useful for this. I will look at building the RiscPC
Linux kernel with it, and at emulating the original ARMv3 CPU too.

Thanks,
Karl
