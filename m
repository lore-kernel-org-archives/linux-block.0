Received: from mail-qv2-f2.google.com (mail-qv2-f2.google.com [74.125.230.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05523EC82E
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098288; cv=pass; b=UVYlMZyj4CKO/kPro+C0xV4mMOy4Ga1TtAZGcNxcE4wQuvCAvWQJeYk7SQzn2UBUEJTAizO9lWM7M9Bn/4yj3wgiWhWcUCXPSiXMLQp01CmfcjMd600kd/vR73Od4ESLfKj8KYs4nlq0dz5YVP+JcYJba9wcVr2/aaDSM6L/Qeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098288; c=relaxed/simple;
	bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbFX36SfTi/z7uQmLWT9Av3Xb2O/hEhJpum8yGQIRtPLRmuoVXoDHoWHOB0gEJXleUobAl/NOb8OGVHzMHWWF61++5nSjKsS1BPOD0HgwCz9BuSTBLtcXvaXQaMjVqtyhg26yc3ZaASlYlu5XdpR+j51gHLCoinCVl6Kp2k8vdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2V24x4G; arc=pass smtp.client-ip=74.125.230.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2V24x4G"
Received: by mail-qv2-f2.google.com with SMTP id 6a1803df08f44-90cbfa89a42so2802656d6.0
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789098286; cv=none;
        d=google.com; s=arc-20260327;
        b=hdFzo+B4kCsgjmsi/rFgMpl7y1lp+kw7ac81BUkbXDgJweAY1BoKcjGUGFtQ9414AK
         d/LpjmhR8/myAP4sLCJIG+P23btgMt6FZCr3G7sfxfJB9U7kQn23vTe1r1LmtC08cCbO
         9FiLGj2BocRc8kLO4cT5qV0F1fHfMCXzzfVMXD1CJhA6cryExXRw4/AAz07AfAyCAkiu
         lMPpIbgqGIRYbwdkmTGNHVYq+jjkQvz5+szPGZI4VOtA8cTWqee1hmu6OEp8F1JFVkDM
         z6HbmvUqcZGYqmprcOvaQ6X/pG/iOx8hEjgdDUS3U6Be6x1r2DqOqBxIL54nxtSsFgcg
         37gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        fh=jUC1kZzBlXfTrwVrF/RFb+Pmgid345VD5NJ7idF7V3s=;
        b=c/5fwFrPecCmEI3AyNItVTh2dRn6RCjRwVB0C9uxb5cw2xXsQKFlBeJR9bkK5+vAr2
         u69qoS4FoHZ4asy84AvK09wYNQrUU1l5UH6h39+zWonNvVUG3/cr6aHhearh5xVo3fgK
         squeDsYxr2XNl24GqjfCOVdEoz509VZGuh+vtlt4VgQlGLfezRM1UtN9LCJk41IdOCuf
         evfq5vGjEMZAQ9vlGtgdj5goY4ZtHWqrPu/JvsAvvjJrsKq5CspMu2V+5O3GRhVSGnd7
         yHZRRXMmSxn9GWorDjT0H0cHZf6itpbwLMRLiUdp9pygfSZjILqRG//oXW5Vno05AWJl
         rIQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098286; x=1789703086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        b=G2V24x4GGyCwAd8LaJ2X8PGNbql6wdGj7itobGHv+DWtilwCENd20LNJWE0FPLHB3/
         0AjlkwMCGqs9CTmfIsOad/o7305l5dxeD1ZFHVPrHnNcoEDHmmOEkUoLBmMXN0uGF9mA
         NFt62u0bdoESjLGcIpLtJ0v7+FmJRxrD/o1lT5g+LldSZZhD3Og4hV+mUCCZhqbjd2JS
         rECTuLTUzPCSAjku7N+dnRXlt7UYkl6EGUg9xcf0TT9TiheCSHMZR1kposahxXE8JxLQ
         5XMF89T6zDhqWdtlqtNhZhEm9Fss7ApuSwbHeeM2sCdkBm+3v8htMXW4iBX0va4HMp+v
         aDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098286; x=1789703086;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9MUCzlT67j02Tdxv5MkPUdx0rDyVjNu0IwYTyNrltgs=;
        b=SjT0arFlFpkznsW56/qpq5uRh2bofInwFCULDerbb2txQAU5a6jtRM79y9EN2IK1uD
         mi1ANVD+CzqjIaugBhTv8ChzsSE0cO3SqnZCPG/l0MYHj8QYOVTBq1N/06mdOmgX3Ycf
         ogsTf6ms9giNynei8OQ+v+1aDi/WzYbiJpu8tX7gOhBrUp931IAMwXFyG1KuJhU3lJSz
         sr/xCeB6cIcOadnlQYBJPUAaKKUeDxpf0B6YX6VUMsfuGZ8AzupBKP06PA26my3GQI+Z
         1QRsCy0O8/dy2GXoMja1sU5n7ajc6PB8aoI7xvMHNbuL+8Ht1X/RI/UdGA5A4a+UtQpv
         mw4Q==
X-Forwarded-Encrypted: i=1; AKwUvByWweDgICqdVRqgTSld6RX/zyo0Fe9mNpGLe54dgcDh11wytvYZnwrdk2NeYp5YO/bzz+9BsmKJPaD4+A==@vger.kernel.org
X-Gm-Message-State: AFuF++lSf47SyEApkthy0NCJaxkorDNngU+4+CqD59V2IVD8BHB4A5Ek
	SAIKTBx36owODOUImM4I+otcy2wRFOj8u/kdlHDHlCEhGI8D996tlKaarpNXVIO1E99AcdswBs3
	QDUjVaR1KnAUganKa11yKiqqFBjtlv80=
X-Gm-Gg: AYBFou2QJg4tUmvALlfccTZRtMZDY4HlS7nj2weA6A0P+dbrKDocmMS2TT1Do8Ij2M2
	31k0guIcTZc6B9QrrSm+K8vtZV0jG1mAjGb+/V5p7o6VKwPpQYa/PGWH2ifOEuzHV8FH5nqB1y7
	gHpc0Hqx9kvCH9FdMQvo6tyZ+AliP5Q3/gzhWjqS8eWoWsCFlr7Ea7eQcN9LD/LC7rtor4FxExX
	4GoDW1r2Sum/8iq8k4oNKh+7vHKiswWOyPdi5pFRCp4P1BN6kZYjnt9mt9FezLgkKKCmmQ38lK8
	FbVC4Ql1TwqsdgNu5MaI6Uo0wXSo+D9eq3J33s49BC8xEUKoF0hfQSOQXYwcU1HBvUsJSwcBnFc
	Uc9D5IQ7ytjq18sY7anS5e8ywNHtS+pthEbFs2PCB
X-Received: by 2002:a05:622a:5987:b0:52d:918b:92e1 with SMTP id
 d75a77b69052e-530c84f326bmr40390581cf.5.1789098285727; Thu, 10 Sep 2026
 20:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
In-Reply-To: <20260908152808.3928630-4-arnd@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 10 Sep 2026 20:44:34 -0700
X-Gm-Features: AcwNN1V1fOC0jmd_i5r-nVHD_ZWN_P0KCiZNA7MUoO0nuGcjQ9okMtkGALkOIWk
Message-ID: <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
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

Hi, everyone,

On Tue, Sep 8, 2026 at 8:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> The main limitation here is the CPU bus that does not allow 16-bit
> wide data transfers and hence requires the kernel to be built with the
> -march=3Darmv3 compiler option that was discontinued in gcc-9.
>
> As gcc-8 is barely supported for compiling the kernel, this one
> will not see another LTS kernel release, so remove it now.

Because I think it's cool that the kernel still supports actual Acorn
hardware, I patched gcc 16.2 to restore ARMv3m support:
https://github.com/EthanNelson-Moore/gcc-arm-retro

This ended up being surprisingly straightforward - only a couple
hundred lines changed - and it would be even fewer lines had I not
reverted a commit that adds a use of ldrh instead of fixing it.

It is able to compile a kernel successfully (once you update the GCC
version check to check for -march=3Darmv3m support instead - I can send
my patch). I haven't tested it, but I am fairly confident that it
would run, because the assembler will reject code the compiler
generates with unsupported instructions - this is how I found the
commit I needed to revert.

I am working on a clocksource driver, which uses both timers (to
hopefully fix the awful time drift), and removes the dependency on
LEGACY_TIMER_TICK.

I also have patches for several cleanups to Risc PC-related code.

I am aware that this has no actual use case, but it was fun. No LLM
was used for any part of the work.

Ethan
