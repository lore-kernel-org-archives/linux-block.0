Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CF2F6931
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137513; cv=pass; b=Fdgdi01DIPxxZuljSCtyfBmf3KjFBfCpKmz6iYu08QKBP/+9spOT6EdcxNllFnnqSjVAIisItTN4LO8i5KhNdk5bWCYgN76U3idNms9MbATjIQq0CxYbPzHEAMU63YLEGdpGIUn7AkttJbbRLo8ZXsMjPTxdbxrGxpGh6fmMv70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137513; c=relaxed/simple;
	bh=XLpKjuu4srfrU1du6/lAaUzD7jl948KYiIqSg/FlWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEwRmpJYB8iH8S7jQ79ZX3eaviE1GW0MCDqUBhQqXwyphBwRsM/yzRcRLwOUY9ZNIxt4X96C9UPpS5osRoyTZvOH6F+UaKBg/ySjErexU56rRZkSalkapk14SjZHJKZCKfiNk9ZQMStqr9oJrrZnCukRRBuGU0cQTV/1p90lsGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=HB8Y+RT4; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="HB8Y+RT4"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8588583a7c3so9079337b3.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 07:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789137507; cv=none;
        d=google.com; s=arc-20260327;
        b=GMz9R1tgO7wprE9wE4ORJRkaXig0wBgnkIRTG2s8EN8QNO5BLCpdQLnvTk/AGm19On
         3topssr3rHjb2+YBtHsGeVfLhNu7+bZi5R8uroUZfmYLGCytGLFTriq6Tk2vVn4Sab06
         DripZ0EDcmnonVeBGhIAcNKFub5rDp1kdzf0oYgSfW4hp9wdSnpzKotj+aJAXYRFuokJ
         vuu4AJSTYmk96F/9e1qPT8Zt7asl1Dm2tHxIKXn/VldUacmL/hlx65D8Eq4DLDu98aBH
         8PnfGpA1X8VmINPxdXfM7nwVl7X/dYskvnb00W29QpCnZAZE6dK8V2Iop8ak9TI++pwQ
         YTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        fh=Q3vMwBXUVfZT6d6P+dHsyxbyHTepgO33i+Y+uXYAXzg=;
        b=WXYGxsbg7NvYiu813Enf46YSGKP2RSQG6Pmfzwuow17S6JNIH1OCewDJK1gxGxYAjB
         X2M4A1t0/OpmZtKu3yu6haKciHcbA3OQTpS/W/s9Vn2KLukwa4wYvIu0lpf/87iDdmiC
         bQpp8VHcnEVIsHQhVtBlY7R/hUfp+tMGouQPiRKgdZ0LY6dqQi8X1+a9oz8UmHCz8o21
         4NSeXte+RF8IneDi1znKqyumSPxqHP5x34BTkD0oQZmEGxiROwJ2TRwCqRHIBoQGrsmW
         K9oA5KRwgedbZkIJYa9kGX5TpXI+a3a0LFIpfX4kCFAKoRMPWH9WMSG1MfcCJaNV4hOE
         zxDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1789137507; x=1789742307; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=HB8Y+RT4TRPooM8mqpi8DeLFRTPVsBx9aCjZB/tdFSV51HaKr7YUqtjHQkphkOVbT6
         uuwIWKH3SAN0TzGoi7GXFe0YJRT5iKtXrRz5k8GxzTLnZPeidsaT8lGynlHxy7GjzZ9r
         wzrI72QggorLaBikBSbsEG1noEYrmgMFuOan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137507; x=1789742307;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jpJbb5DSDD0uOBnoN5sYAo9U83labpJz6g7jqXOS7q0=;
        b=kG3kU9NwAVxOl1CUUVAVm8AIHJtyH4iGWnpz0u5kL/IMvUCD7MQRGobJiSoGPsSLTl
         5TmAt0wANwEIYkDXQaDeRBQo97E1W7XsY/tRMK9we43maFRLq4DMoGwPVjiKR3KwU7gH
         y3iThAiCJIUqf+FhxkILL5c1+PC+OxNQNSndCNTbUxW8WtH/rJHTJUgEVfFc0/Xu3pXp
         r1xwAI1ihSPWhLx5qp7/e0R7tS01BTjFVENZsQnkWbu1+QvUg3oUMlkTJckEH4AEmw/y
         uLV399Tfy2Uyo++2+2G1hw+0j1bVJGq99gtzSn37gPRNg4u1yci6LpAdMurP27rnywtY
         xeEw==
X-Forwarded-Encrypted: i=1; AKwUvBzyYE+KSZLZAl7FfKKLpW9wgg/DbQCvC5o5iHruK4kCrNklrAo44zj4m8bERInDQt8nVcdGblFnbWI1pA==@vger.kernel.org
X-Gm-Message-State: AFuF++kJSm6NVgDUDZRAraI03cRD8QUMQ+0mtNA/kZyL7xycI5NMa8WY
	j9okwogLGX7/3m+8kXCblUrfCRH6UUVsVgZO/GDCvDB6l+0uzVa/U+BBea79sjcwtoOiceGnO5k
	eQG5TzvxU8WeYens6Jc36Z8cRkQ9dV729HmV9U8Mo5Q==
X-Gm-Gg: AYBFou3FgM7sRIbmsA+0NLk6DhHJfye0fSMlllMwTfAc0DD3ylKwCxtkueBw2Ab9Ew1
	n3KLsa4K1O+GkV3s3yz3YiFoRMHzfNOLhEacCWvNWCLPW0Uq5QkxKMJH8UhcOqL5SAhEsbix2th
	/1eA1Rd74JhPCUmakUbqbG3Q7wa/1scU6+kkyLP7jxX0IyiHTnLV8l0KjO65FxQ48D6jAtzs5Zb
	EdNfsxvSmCImIeY3yBvnwgESVQiXH/ADOhF1hYZUC+HliXD1VuN+/N3YcUQIUNcyfbSpVyj/lWA
	tsDnJ/kg1h43GUY+VgReh4S+0FIJU5na+uit104wMGoxSSMSD14MZQQ0+74/crs0
X-Received: by 2002:a05:690c:399:b0:873:5bb2:6c10 with SMTP id
 00721157ae682-884b7316b4dmr14810657b3.58.1789137507274; Fri, 11 Sep 2026
 07:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com> <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
In-Reply-To: <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Fri, 11 Sep 2026 23:38:14 +0900
X-Gm-Features: AcwNN1V8w1uOymS_yob5PvYfeWzm1NprI6fjxQoUm4Mlo3gyAoZUnypuVT5lDl8
Message-ID: <CAFr9PX=_FmMdR4TeP+tqURZdZCTjw8UYxAxeszs_vcpTbX+_aw@mail.gmail.com>
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

On Fri, 11 Sept 2026 at 18:11, Linus Walleij <linusw@kernel.org> wrote:
> - One camp that are enthusiast like yourself. That kind of people
>   are running the show inside arch/m68k on Amigas and Ataris.

I have SMP working on m68k (dual 68040, real hardware) among other
oddities. I think some people would get a kick out of seeing it but
also I think some people would also ask why we can't just delete
everything that isn't arm64/amd64/riscv. I'm putting off sending
patches like that to avoid everything getting deleted. :)

Cheers,

Daniel
