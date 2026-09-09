Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1F3148D0;
	Wed,  9 Sep 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941071; cv=none; b=LT657iJaL2/QlTP9PIDj4ZHJHectm2JfesS5H0weohieIs3EVcs6bmWmGI4FmtDeBWrjrxpvpd+aHNSI/QRbR42oCoO/upxGwJt39ae14qM5bW3JAMhETxfFlkHcqlGd5SGUmfy2NUXBNX3zJBriS6ThpTc7EzEIBsiUckdlf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941071; c=relaxed/simple;
	bh=zHOPmNGk456EyDm3R0dyWYr9/AehwcooPi4u9U7l2LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDk3Hj3n+t6OQecpfe4leDNdTSksj/Q078tzkoXW2tZgiziFZHhNkIE3cI4STENuBQt1IoUvgkU3RtD/uo/jBWMMuup185whF+GNXShJhLx8qlyS6n/GHNDH7EkpYXIy1KiDq6aTmP6kexQZeYTLgjgIN0As/hLY3/2Y/rYp7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VGXsLxRw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d5VwoqKS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jDgT1FOn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rodwpOsr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VGXsLxRw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d5VwoqKS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jDgT1FOn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rodwpOsr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 580BA1F7C7;
	Wed,  9 Sep 2026 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788941057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m+YD4mZ7Kj8aNsdjGb3pMG2l+eZ9/XDUDpbtKJ8/J60=;
	b=VGXsLxRwllXSIcRrnhy1Lg+v2TL2wMvpoO2Z0mJbG2khxqbXDteZPhqkfs5Ez8cdbsVtHk
	ZUx3OAKjaofBlrI3mHVmGyIPxZg+/LRpuxWemOm4y/0navX6j0t/2DcBYs8bUMJ4AslZif
	dS78fPtrc8AWD4FzSKCeWlxbbAU3DpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788941057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m+YD4mZ7Kj8aNsdjGb3pMG2l+eZ9/XDUDpbtKJ8/J60=;
	b=d5VwoqKSAQttc1bOeZ0xnMjHtzJWo6umgzw5EP59DUL5+0i6gTlUVWdkwCbLCoD47/AJef
	NQANJJdxpaO6h5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788941053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m+YD4mZ7Kj8aNsdjGb3pMG2l+eZ9/XDUDpbtKJ8/J60=;
	b=jDgT1FOnQv90d8s9SkYXPwG7TLrkBqZziHYTaMk+TsY51xCrqx3TgkzCyeTrsdV5TyeIN6
	i5u0TOoyNmTu8GkhBpTENEfsSylP7URWuRBOzXBQTVkYfp0HmApOsUDHJfUsOcRcj85SLw
	cG3eEkv+1/svBpsxnVp3wCPAY03FINY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788941053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m+YD4mZ7Kj8aNsdjGb3pMG2l+eZ9/XDUDpbtKJ8/J60=;
	b=rodwpOsrVux/ScXKQRKmx8ZUs5Ozjq1FhxyOW3K/UYFwlhlsSrOnMyPXIHsB8fQFlI2al5
	W2sTHiBBdNa1abCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF92D13354;
	Wed,  9 Sep 2026 08:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AcU6OfsSoWp0HAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:04:11 +0000
Message-ID: <8d5d04f6-50b3-49b3-93bf-e36d825963b3@suse.de>
Date: Wed, 9 Sep 2026 10:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>,
 Helge Deller <deller@gmx.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-block@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260908152808.3928630-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,f2s.com:email,suse.com:url,armlinux.org.uk:url,armlinux.org.uk:email,arm.com:email,sntech.de:email,suse.de:mid,suse.de:email,infradead.org:email];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,arm.com,nxp.com,pengutronix.de,gmail.com,mleia.com,agner.ch,foss.st.com,iki.fi,kemnade.info,baylibre.com,atomide.com,microchip.com,tuxon.dev,lunn.ch,bootlin.com,free.fr,linux-m68k.org,siemens.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,f2s.com,kernel.dk,gmx.de];
	R_RATELIMIT(0.00)[to_ip_from(RL6e75e7xiqh135443e1d3zo16)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,suse.de:mid,suse.de:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Flag: NO

Hi

Am 08.09.26 um 17:27 schrieb Arnd Bergmann:
[...]

>   lib/fonts/font_acorn_8x8.c                  |    4 -

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de> # lib/fonts


>   41 files changed, 12 insertions(+), 3688 deletions(-)
>   delete mode 100644 arch/arm/boot/compressed/font.c
>   delete mode 100644 arch/arm/boot/compressed/ll_char_wr.S
>   delete mode 100644 arch/arm/configs/rpc_defconfig
>   delete mode 100644 arch/arm/include/asm/ecard.h
>   delete mode 100644 arch/arm/include/asm/hardware/ioc.h
>   delete mode 100644 arch/arm/include/asm/hardware/iomd.h
>   delete mode 100644 arch/arm/include/asm/hardware/memc.h
>   delete mode 100644 arch/arm/mach-rpc/Kconfig
>   delete mode 100644 arch/arm/mach-rpc/Makefile
>   delete mode 100644 arch/arm/mach-rpc/dma.c
>   delete mode 100644 arch/arm/mach-rpc/ecard-loader.S
>   delete mode 100644 arch/arm/mach-rpc/ecard.c
>   delete mode 100644 arch/arm/mach-rpc/ecard.h
>   delete mode 100644 arch/arm/mach-rpc/fiq.S
>   delete mode 100644 arch/arm/mach-rpc/floppydma.S
>   delete mode 100644 arch/arm/mach-rpc/include/mach/acornfb.h
>   delete mode 100644 arch/arm/mach-rpc/include/mach/hardware.h
>   delete mode 100644 arch/arm/mach-rpc/include/mach/io.h
>   delete mode 100644 arch/arm/mach-rpc/include/mach/irqs.h
>   delete mode 100644 arch/arm/mach-rpc/include/mach/isa-dma.h
>   delete mode 100644 arch/arm/mach-rpc/include/mach/memory.h
>   delete mode 100644 arch/arm/mach-rpc/include/mach/uncompress.h
>   delete mode 100644 arch/arm/mach-rpc/io-acorn.S
>   delete mode 100644 arch/arm/mach-rpc/irq.c
>   delete mode 100644 arch/arm/mach-rpc/riscpc.c
>   delete mode 100644 arch/arm/mach-rpc/time.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4380d5660402..6e8fe7640064 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2350,12 +2350,6 @@ F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
>   F:	Documentation/gpu/afbc.rst
>   F:	drivers/gpu/drm/arm/
>   
> -ARM MFM AND FLOPPY DRIVERS
> -M:	Ian Molton <spyro@f2s.com>
> -S:	Maintained
> -F:	arch/arm/include/asm/floppy.h
> -F:	arch/arm/mach-rpc/floppydma.S
> -
>   ARM PMU PROFILING AND DEBUGGING
>   M:	Will Deacon <will@kernel.org>
>   M:	Mark Rutland <mark.rutland@arm.com>
> @@ -3494,20 +3488,6 @@ F:	include/linux/soc/renesas/
>   N:	rcar
>   K:	\brenesas,
>   
> -ARM/RISCPC ARCHITECTURE
> -M:	Russell King <linux@armlinux.org.uk>
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -W:	http://www.armlinux.org.uk/
> -F:	arch/arm/include/asm/hardware/ioc.h
> -F:	arch/arm/include/asm/hardware/iomd.h
> -F:	arch/arm/include/asm/hardware/memc.h
> -F:	arch/arm/mach-rpc/
> -F:	drivers/net/ethernet/8390/etherh.c
> -F:	drivers/net/ethernet/i825xx/ether1*
> -F:	drivers/net/ethernet/seeq/ether3*
> -F:	drivers/scsi/arm/
> -
>   ARM/Rockchip SoC support
>   M:	Heiko Stuebner <heiko@sntech.de>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c3d6b8abc815..5770deca136d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -55,7 +55,7 @@ config ARM
>   	select ARCH_WANT_LD_ORPHAN_WARN
>   	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>   	select BUILDTIME_TABLE_SORT if MMU
> -	select COMMON_CLK if !ARCH_RPC
> +	select COMMON_CLK
>   	select CLONE_BACKWARDS
>   	select CPU_PM if SUSPEND || CPU_IDLE
>   	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
> @@ -155,13 +155,13 @@ config ARM
>   	select PCI_SYSCALL if PCI
>   	select PERF_USE_VMALLOC
>   	select RTC_LIB
> -	select SPARSE_IRQ if !ARCH_RPC
> +	select SPARSE_IRQ
>   	select SYS_SUPPORTS_APM_EMULATION
>   	select THREAD_INFO_IN_TASK
>   	select TIMER_OF if OF
>   	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
>   	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
> -	select USE_OF if !ARCH_RPC
> +	select USE_OF
>   	# Above selects are sorted alphabetically; please add new ones
>   	# according to that.  Thanks.
>   	help
> @@ -277,25 +277,11 @@ config ARM_PATCH_PHYS_VIRT
>   	  this feature (eg, building a kernel for a single machine) and
>   	  you need to shrink the kernel to the minimal size.
>   
> -config NEED_MACH_IO_H
> -	bool
> -	help
> -	  Select this when mach/io.h is required to provide special
> -	  definitions for this platform.  The need for mach/io.h should
> -	  be avoided when possible.
> -
> -config NEED_MACH_MEMORY_H
> -	bool
> -	help
> -	  Select this when mach/memory.h is required to provide special
> -	  definitions for this platform.  The need for mach/memory.h should
> -	  be avoided when possible.
> -
>   config PHYS_OFFSET
>   	hex "Physical address of main memory" if MMU
>   	depends on !ARM_PATCH_PHYS_VIRT || !AUTO_ZRELADDR
>   	default DRAM_BASE if !MMU
> -	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
> +	default 0x10000000 if ARCH_OMAP1
>   	default 0xa0000000 if ARCH_PXA
>   	default 0xc0000000 if ARCH_EP93XX
>   	default 0
> @@ -337,7 +323,7 @@ config ARCH_MMAP_RND_BITS_MAX
>   
>   config ARCH_MULTIPLATFORM
>   	bool "Require kernel to be portable to multiple machines" if EXPERT
> -	depends on MMU && !ARCH_RPC
> +	depends on MMU
>   	default y
>   	help
>   	  In general, all Arm machines can be supported in a single
> @@ -429,8 +415,6 @@ source "arch/arm/mach-qcom/Kconfig"
>   
>   source "arch/arm/mach-realtek/Kconfig"
>   
> -source "arch/arm/mach-rpc/Kconfig"
> -
>   source "arch/arm/mach-rockchip/Kconfig"
>   
>   source "arch/arm/mach-s3c/Kconfig"
> @@ -490,9 +474,6 @@ config ARCH_MPS2
>   	  This platform is scheduled for removal in early 2027
>   
>   # Definitions to make life easier
> -config ARCH_ACORN
> -	bool
> -
>   config PLAT_ORION
>   	bool
>   	select CLKSRC_MMIO
> @@ -1191,7 +1172,7 @@ config ARCH_SELECT_MEMORY_MODEL
>   	def_bool y
>   
>   config ARCH_FLATMEM_ENABLE
> -	def_bool !ARCH_RPC
> +	def_bool y
>   
>   config ARCH_SPARSEMEM_ENABLE
>   	def_bool y
> @@ -1594,7 +1575,7 @@ config ARCH_DEFAULT_CRASH_DUMP
>   
>   config AUTO_ZRELADDR
>   	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
> -	default !ARCH_RPC
> +	default y
>   	help
>   	  ZRELADDR is the physical address where the decompressed kernel
>   	  image will be placed. If AUTO_ZRELADDR is selected, the address
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index f2a80955b7a0..56c090840c5a 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1446,7 +1446,7 @@ config DEBUG_STM32_UART
>   config DEBUG_UART_FLOW_CONTROL
>   	bool "Enable flow control (CTS) for the debug UART"
>   	depends on DEBUG_LL
> -	default y if DEBUG_GEMINI || ARCH_RPC
> +	default y if DEBUG_GEMINI
>   	help
>   	  Some UART ports are connected to terminals that will use modem
>   	  control signals to indicate whether they are ready to receive text.
> @@ -1516,7 +1516,7 @@ config DEBUG_UART_PL01X
>   
>   # Compatibility options for 8250
>   config DEBUG_UART_8250
> -	def_bool ARCH_IXP4XX || ARCH_RPC
> +	def_bool ARCH_IXP4XX
>   
>   config DEBUG_UART_PHYS
>   	hex "Physical base address of debug UART"
> @@ -1527,7 +1527,6 @@ config DEBUG_UART_PHYS
>   	default 0x01f02800 if DEBUG_SUNXI_R_UART
>   	default 0x02530c00 if DEBUG_KEYSTONE_UART0
>   	default 0x02531000 if DEBUG_KEYSTONE_UART1
> -	default 0x03010fe0 if ARCH_RPC
>   	default 0x07000000 if DEBUG_SUN9I_UART0
>   	default 0x09530000 if DEBUG_STIH418_SBC_ASC0
>   	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || \
> @@ -1654,7 +1653,6 @@ config DEBUG_UART_VIRT
>   	default 0xc881f000 if DEBUG_RV1108_UART2
>   	default 0xc8821000 if DEBUG_RV1108_UART1
>   	default 0xc8912000 if DEBUG_RV1108_UART0
> -	default 0xe0010fe0 if ARCH_RPC
>   	default 0xe0824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
>   	default 0xf0010000 if DEBUG_ASM9260_UART
>   	default 0xf0100000 if DEBUG_DIGICOLOR_UA0
> @@ -1779,7 +1777,6 @@ config DEBUG_UART_8250_PALMCHIP
>   config DEBUG_UNCOMPRESS
>   	bool "Enable decompressor debugging via DEBUG_LL output"
>   	depends on !ARCH_MULTIPLATFORM
> -	depends on !ARCH_RPC
>   	depends on DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
>   		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
>   		     !DEBUG_BRCMSTB_UART && !DEBUG_SEMIHOSTING
> @@ -1789,7 +1786,6 @@ config DEBUG_UNCOMPRESS
>   
>   config UNCOMPRESS_INCLUDE
>   	string
> -	default "mach/uncompress.h" if ARCH_RPC
>   	default "debug/uncompress.h"
>   
>   config EARLY_PRINTK
> diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
> index 12c61684b97f..1e47bf10069d 100644
> --- a/arch/arm/boot/bootp/Makefile
> +++ b/arch/arm/boot/bootp/Makefile
> @@ -19,8 +19,6 @@ add_hex = $(shell printf 0x%x $$(( $(1) + $(2) )) )
>   PARAMS_PHYS := $(call add_hex, $(PHYS_OFFSET), 0x100)
>   
>   # guess an initrd location if possible
> -initrd_offset-$(CONFIG_ARCH_RPC)	+= 0x08000000
> -INITRD_OFFSET := $(initrd_offset-y)
>   ifdef INITRD_OFFSET
>   INITRD_PHYS := $(call add_hex, $(PHYS_OFFSET), $(INITRD_OFFSET))
>   endif
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index d8d81ba741a2..32def10f5e03 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -25,10 +25,6 @@ endif
>   #
>   # Architecture dependencies
>   #
> -ifeq ($(CONFIG_ARCH_ACORN),y)
> -OBJS		+= ll_char_wr.o font.o
> -endif
> -
>   ifeq ($(CONFIG_CPU_XSCALE),y)
>   OBJS		+= head-xscale.o
>   endif
> diff --git a/arch/arm/boot/compressed/font.c b/arch/arm/boot/compressed/font.c
> deleted file mode 100644
> index 46a677649db4..000000000000
> --- a/arch/arm/boot/compressed/font.c
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -#include "../../../../lib/fonts/font_acorn_8x8.c"
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 845abffbc2d6..af579905b630 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -668,14 +668,6 @@ LC1:		.word	.L_user_stack_end - LC1	@ sp
>   .Linflated_image_size_offset:
>   		.long	(input_data_end - 4) - .
>   
> -#ifdef CONFIG_ARCH_RPC
> -		.globl	params
> -params:		ldr	r0, =0x10000100		@ params_phys for RPC
> -		mov	pc, lr
> -		.ltorg
> -		.align
> -#endif
> -
>   /*
>    * dcache_line_size - get the minimum D-cache line size from the CTR register
>    * on ARMv7.
> diff --git a/arch/arm/boot/compressed/ll_char_wr.S b/arch/arm/boot/compressed/ll_char_wr.S
> deleted file mode 100644
> index 1ec8cb2898b1..000000000000
> --- a/arch/arm/boot/compressed/ll_char_wr.S
> +++ /dev/null
> @@ -1,131 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  linux/arch/arm/lib/ll_char_wr.S
> - *
> - *  Copyright (C) 1995, 1996 Russell King.
> - *
> - *  Speedups & 1bpp code (C) 1996 Philip Blundell & Russell King.
> - *
> - *  10-04-96	RMK	Various cleanups & reduced register usage.
> - *  08-04-98	RMK	Shifts re-ordered
> - */
> -
> -@ Regs: [] = corruptible
> -@       {} = used
> -@       () = do not use
> -
> -#include <linux/linkage.h>
> -#include <asm/assembler.h>
> -	.text
> -
> -LC0:	.word	LC0
> -	.word	bytes_per_char_h
> -	.word	video_size_row
> -	.word	acorndata_8x8
> -	.word	con_charconvtable
> -
> -/*
> - * r0 = ptr
> - * r1 = char
> - * r2 = white
> - */
> -ENTRY(ll_write_char)
> -	stmfd	sp!, {r4 - r7, lr}
> -@
> -@ Smashable regs: {r0 - r3}, [r4 - r7], (r8 - fp), [ip], (sp), [lr], (pc)
> -@
> -	/*
> -	 * calculate offset into character table
> -	 */
> -	mov	r1, r1, lsl #3
> -	/*
> -	 * calculate offset required for each row.
> -	 */
> -	adr	ip, LC0
> -	ldmia	ip, {r3, r4, r5, r6, lr}
> -	sub	ip, ip, r3
> -	add	r6, r6, ip
> -	add	lr, lr, ip
> -	ldr	r4, [r4, ip]
> -	ldr	r5, [r5, ip]
> -	/*
> -	 * Go to resolution-dependent routine...
> -	 */
> -	cmp	r4, #4
> -	blt	Lrow1bpp
> -	add	r0, r0, r5, lsl #3		@ Move to bottom of character
> -	orr	r1, r1, #7
> -	ldrb	r7, [r6, r1]
> -	teq	r4, #8
> -	beq	Lrow8bpplp
> -@
> -@ Smashable regs: {r0 - r3}, [r4], {r5 - r7}, (r8 - fp), [ip], (sp), {lr}, (pc)
> -@
> -Lrow4bpplp:
> -	ldr	r7, [lr, r7, lsl #2]
> -	mul	r7, r2, r7
> -	sub	r1, r1, #1			@ avoid using r7 directly after
> -	str	r7, [r0, -r5]!
> -	ldrb	r7, [r6, r1]
> -	ldr	r7, [lr, r7, lsl #2]
> -	mul	r7, r2, r7
> -	tst	r1, #7				@ avoid using r7 directly after
> -	str	r7, [r0, -r5]!
> -	subne	r1, r1, #1
> -	ldrbne	r7, [r6, r1]
> -	bne	Lrow4bpplp
> -	ldmfd	sp!, {r4 - r7, pc}
> -
> -@
> -@ Smashable regs: {r0 - r3}, [r4], {r5 - r7}, (r8 - fp), [ip], (sp), {lr}, (pc)
> -@
> -Lrow8bpplp:
> -	mov	ip, r7, lsr #4
> -	ldr	ip, [lr, ip, lsl #2]
> -	mul	r4, r2, ip
> -	and	ip, r7, #15			@ avoid r4
> -	ldr	ip, [lr, ip, lsl #2]		@ avoid r4
> -	mul	ip, r2, ip			@ avoid r4
> -	sub	r1, r1, #1			@ avoid ip
> -	sub	r0, r0, r5			@ avoid ip
> -	stmia	r0, {r4, ip}
> -	ldrb	r7, [r6, r1]
> -	mov	ip, r7, lsr #4
> -	ldr	ip, [lr, ip, lsl #2]
> -	mul	r4, r2, ip
> -	and	ip, r7, #15			@ avoid r4
> -	ldr	ip, [lr, ip, lsl #2]		@ avoid r4
> -	mul	ip, r2, ip			@ avoid r4
> -	tst	r1, #7				@ avoid ip
> -	sub	r0, r0, r5			@ avoid ip
> -	stmia	r0, {r4, ip}
> -	subne	r1, r1, #1
> -	ldrbne	r7, [r6, r1]
> -	bne	Lrow8bpplp
> -	ldmfd	sp!, {r4 - r7, pc}
> -
> -@
> -@ Smashable regs: {r0 - r3}, [r4], {r5, r6}, [r7], (r8 - fp), [ip], (sp), [lr], (pc)
> -@
> -Lrow1bpp:
> -	add	r6, r6, r1
> -	ldmia	r6, {r4, r7}
> -	strb	r4, [r0], r5
> -	mov	r4, r4, lsr #8
> -	strb	r4, [r0], r5
> -	mov	r4, r4, lsr #8
> -	strb	r4, [r0], r5
> -	mov	r4, r4, lsr #8
> -	strb	r4, [r0], r5
> -	strb	r7, [r0], r5
> -	mov	r7, r7, lsr #8
> -	strb	r7, [r0], r5
> -	mov	r7, r7, lsr #8
> -	strb	r7, [r0], r5
> -	mov	r7, r7, lsr #8
> -	strb	r7, [r0], r5
> -	ldmfd	sp!, {r4 - r7, pc}
> -
> -	.bss
> -ENTRY(con_charconvtable)
> -	.space	1024
> diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
> deleted file mode 100644
> index edb52d56f679..000000000000
> --- a/arch/arm/configs/rpc_defconfig
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -# CONFIG_LOCALVERSION_AUTO is not set
> -CONFIG_SYSVIPC=y
> -CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_BLK_DEV_INITRD=y
> -CONFIG_EXPERT=y
> -CONFIG_ARCH_MULTI_V4=y
> -# CONFIG_ARCH_MULTI_V7 is not set
> -CONFIG_ARCH_RPC=y
> -CONFIG_CPU_SA110=y
> -CONFIG_FPE_NWFPE=y
> -# CONFIG_AEABI is not set
> -CONFIG_ATAGS=y
> -CONFIG_MODULES=y
> -CONFIG_MODULE_UNLOAD=y
> -CONFIG_PARTITION_ADVANCED=y
> -CONFIG_BSD_DISKLABEL=y
> -CONFIG_NET=y
> -CONFIG_PACKET=y
> -CONFIG_UNIX=y
> -CONFIG_INET=y
> -CONFIG_IP_MULTICAST=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
> -# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET6_XFRM_MODE_BEET is not set
> -CONFIG_PARPORT=y
> -CONFIG_PARPORT_PC=y
> -CONFIG_PARPORT_PC_FIFO=y
> -CONFIG_BLK_DEV_FD=y
> -CONFIG_BLK_DEV_LOOP=m
> -CONFIG_BLK_DEV_RAM=y
> -CONFIG_BLK_DEV_SD=y
> -CONFIG_CHR_DEV_ST=m
> -CONFIG_BLK_DEV_SR=y
> -CONFIG_CHR_DEV_SG=y
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_SCSI_CONSTANTS=y
> -CONFIG_SCSI_LOGGING=y
> -CONFIG_SCSI_ARXESCSI=m
> -CONFIG_SCSI_CUMANA_2=m
> -CONFIG_SCSI_EESOXSCSI=m
> -CONFIG_SCSI_POWERTECSCSI=y
> -CONFIG_SCSI_CUMANA_1=m
> -CONFIG_SCSI_OAK1=m
> -CONFIG_ATA=y
> -CONFIG_PATA_ICSIDE=y
> -CONFIG_PATA_PLATFORM=y
> -CONFIG_NETDEVICES=y
> -CONFIG_ARM_ETHER1=y
> -CONFIG_ARM_ETHER3=y
> -CONFIG_ARM_ETHERH=y
> -CONFIG_PPP=m
> -CONFIG_PPPOE=m
> -CONFIG_INPUT_EVDEV=y
> -# CONFIG_MOUSE_PS2 is not set
> -CONFIG_MOUSE_RISCPC=y
> -# CONFIG_SERIO_SERPORT is not set
> -CONFIG_LEGACY_PTY_COUNT=64
> -CONFIG_SERIAL_8250=y
> -CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_8250_NR_UARTS=16
> -CONFIG_SERIAL_8250_RUNTIME_UARTS=8
> -CONFIG_SERIAL_8250_ACORN=y
> -CONFIG_PRINTER=m
> -# CONFIG_HW_RANDOM is not set
> -CONFIG_I2C=y
> -CONFIG_I2C_CHARDEV=y
> -# CONFIG_HWMON is not set
> -CONFIG_FB=y
> -CONFIG_FB_ACORN=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
> -CONFIG_LOGO=y
> -CONFIG_SOUND=m
> -CONFIG_SOUND_PRIME=m
> -CONFIG_SOUND_OSS=m
> -CONFIG_SOUND_VIDC=m
> -# CONFIG_USB_SUPPORT is not set
> -CONFIG_RTC_CLASS=y
> -CONFIG_RTC_DRV_PCF8583=y
> -CONFIG_EXT2_FS=y
> -CONFIG_EXT4_FS=y
> -CONFIG_AUTOFS_FS=m
> -CONFIG_ISO9660_FS=y
> -CONFIG_JOLIET=y
> -CONFIG_MSDOS_FS=m
> -CONFIG_VFAT_FS=m
> -CONFIG_ADFS_FS=y
> -CONFIG_NFS_FS=y
> -# CONFIG_ACORN_PARTITION_CUMANA is not set
> -# CONFIG_ACORN_PARTITION_EESOX is not set
> -CONFIG_NLS_CODEPAGE_437=m
> -CONFIG_NLS_CODEPAGE_737=m
> -CONFIG_NLS_CODEPAGE_775=m
> -CONFIG_NLS_CODEPAGE_850=m
> -CONFIG_NLS_CODEPAGE_852=m
> -CONFIG_NLS_CODEPAGE_855=m
> -CONFIG_NLS_CODEPAGE_857=m
> -CONFIG_NLS_CODEPAGE_860=m
> -CONFIG_NLS_CODEPAGE_861=m
> -CONFIG_NLS_CODEPAGE_862=m
> -CONFIG_NLS_CODEPAGE_863=m
> -CONFIG_NLS_CODEPAGE_864=m
> -CONFIG_NLS_CODEPAGE_865=m
> -CONFIG_NLS_CODEPAGE_866=m
> -CONFIG_NLS_CODEPAGE_869=m
> -CONFIG_NLS_CODEPAGE_874=m
> -CONFIG_NLS_ISO8859_8=m
> -CONFIG_NLS_ASCII=y
> -CONFIG_NLS_ISO8859_1=m
> -CONFIG_NLS_ISO8859_2=m
> -CONFIG_NLS_ISO8859_3=m
> -CONFIG_NLS_ISO8859_4=m
> -CONFIG_NLS_ISO8859_5=m
> -CONFIG_NLS_ISO8859_6=m
> -CONFIG_NLS_ISO8859_7=m
> -CONFIG_NLS_ISO8859_9=m
> -CONFIG_NLS_KOI8_R=m
> -CONFIG_FONTS=y
> -CONFIG_FONT_8x16=y
> -CONFIG_FONT_ACORN_8x8=y
> -CONFIG_DEBUG_KERNEL=y
> -CONFIG_MAGIC_SYSRQ=y
> -CONFIG_DEBUG_USER=y
> -CONFIG_DEBUG_LL=y
> -CONFIG_DEBUG_LL_UART_8250=y
> diff --git a/arch/arm/include/asm/ecard.h b/arch/arm/include/asm/ecard.h
> deleted file mode 100644
> index 7cbe001bf9cc..000000000000
> --- a/arch/arm/include/asm/ecard.h
> +++ /dev/null
> @@ -1,219 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * arch/arm/include/asm/ecard.h
> - *
> - * definitions for expansion cards
> - *
> - * This is a new system as from Linux 1.2.3
> - *
> - * Changelog:
> - *  11-12-1996	RMK	Further minor improvements
> - *  12-09-1997	RMK	Added interrupt enable/disable for card level
> - *
> - * Reference: Acorns Risc OS 3 Programmers Reference Manuals.
> - */
> -
> -#ifndef __ASM_ECARD_H
> -#define __ASM_ECARD_H
> -
> -/*
> - * Currently understood cards (but not necessarily
> - * supported):
> - *                        Manufacturer  Product ID
> - */
> -#define MANU_ACORN		0x0000
> -#define PROD_ACORN_SCSI			0x0002
> -#define PROD_ACORN_ETHER1		0x0003
> -#define PROD_ACORN_MFM			0x000b
> -
> -#define MANU_ANT2		0x0011
> -#define PROD_ANT_ETHER3			0x00a4
> -
> -#define MANU_ATOMWIDE		0x0017
> -#define PROD_ATOMWIDE_3PSERIAL		0x0090
> -
> -#define MANU_IRLAM_INSTRUMENTS	0x001f
> -#define MANU_IRLAM_INSTRUMENTS_ETHERN	0x5678
> -
> -#define MANU_OAK		0x0021
> -#define PROD_OAK_SCSI			0x0058
> -
> -#define MANU_MORLEY		0x002b
> -#define PROD_MORLEY_SCSI_UNCACHED	0x0067
> -
> -#define MANU_CUMANA		0x003a
> -#define PROD_CUMANA_SCSI_2		0x003a
> -#define PROD_CUMANA_SCSI_1		0x00a0
> -
> -#define MANU_ICS		0x003c
> -#define PROD_ICS_IDE			0x00ae
> -
> -#define MANU_ICS2		0x003d
> -#define PROD_ICS2_IDE			0x00ae
> -
> -#define MANU_SERPORT		0x003f
> -#define PROD_SERPORT_DSPORT		0x00b9
> -
> -#define MANU_ARXE		0x0041
> -#define PROD_ARXE_SCSI			0x00be
> -
> -#define MANU_I3			0x0046
> -#define PROD_I3_ETHERLAN500		0x00d4
> -#define PROD_I3_ETHERLAN600		0x00ec
> -#define PROD_I3_ETHERLAN600A		0x011e
> -
> -#define MANU_ANT		0x0053
> -#define PROD_ANT_ETHERM			0x00d8
> -#define PROD_ANT_ETHERB			0x00e4
> -
> -#define MANU_ALSYSTEMS		0x005b
> -#define PROD_ALSYS_SCSIATAPI		0x0107
> -
> -#define MANU_MCS		0x0063
> -#define PROD_MCS_CONNECT32		0x0125
> -
> -#define MANU_EESOX		0x0064
> -#define PROD_EESOX_SCSI2		0x008c
> -
> -#define MANU_YELLOWSTONE	0x0096
> -#define PROD_YELLOWSTONE_RAPIDE32	0x0120
> -
> -#ifdef ECARD_C
> -#define CONST
> -#else
> -#define CONST const
> -#endif
> -
> -#define MAX_ECARDS	9
> -
> -struct ecard_id {			/* Card ID structure		*/
> -	unsigned short	manufacturer;
> -	unsigned short	product;
> -	void		*data;
> -};
> -
> -struct in_ecid {			/* Packed card ID information	*/
> -	unsigned short	product;	/* Product code			*/
> -	unsigned short	manufacturer;	/* Manufacturer code		*/
> -	unsigned char	id:4;		/* Simple ID			*/
> -	unsigned char	cd:1;		/* Chunk dir present		*/
> -	unsigned char	is:1;		/* Interrupt status pointers	*/
> -	unsigned char	w:2;		/* Width			*/
> -	unsigned char	country;	/* Country			*/
> -	unsigned char	irqmask;	/* IRQ mask			*/
> -	unsigned char	fiqmask;	/* FIQ mask			*/
> -	unsigned long	irqoff;		/* IRQ offset			*/
> -	unsigned long	fiqoff;		/* FIQ offset			*/
> -};
> -
> -typedef struct expansion_card ecard_t;
> -typedef unsigned long *loader_t;
> -
> -typedef struct expansion_card_ops {	/* Card handler routines	*/
> -	void (*irqenable)(ecard_t *ec, int irqnr);
> -	void (*irqdisable)(ecard_t *ec, int irqnr);
> -	int  (*irqpending)(ecard_t *ec);
> -	void (*fiqenable)(ecard_t *ec, int fiqnr);
> -	void (*fiqdisable)(ecard_t *ec, int fiqnr);
> -	int  (*fiqpending)(ecard_t *ec);
> -} expansioncard_ops_t;
> -
> -#define ECARD_NUM_RESOURCES	(6)
> -
> -#define ECARD_RES_IOCSLOW	(0)
> -#define ECARD_RES_IOCMEDIUM	(1)
> -#define ECARD_RES_IOCFAST	(2)
> -#define ECARD_RES_IOCSYNC	(3)
> -#define ECARD_RES_MEMC		(4)
> -#define ECARD_RES_EASI		(5)
> -
> -#define ecard_resource_start(ec,nr)	((ec)->resource[nr].start)
> -#define ecard_resource_end(ec,nr)	((ec)->resource[nr].end)
> -#define ecard_resource_len(ec,nr)	((ec)->resource[nr].end - \
> -					 (ec)->resource[nr].start + 1)
> -#define ecard_resource_flags(ec,nr)	((ec)->resource[nr].flags)
> -
> -/*
> - * This contains all the info needed on an expansion card
> - */
> -struct expansion_card {
> -	struct expansion_card  *next;
> -
> -	struct device		dev;
> -	struct resource		resource[ECARD_NUM_RESOURCES];
> -
> -	/* Public data */
> -	void __iomem		*irqaddr;	/* address of IRQ register	*/
> -	void __iomem		*fiqaddr;	/* address of FIQ register	*/
> -	unsigned char		irqmask;	/* IRQ mask			*/
> -	unsigned char		fiqmask;	/* FIQ mask			*/
> -	unsigned char  		claimed;	/* Card claimed?		*/
> -	unsigned char		easi;		/* EASI card			*/
> -
> -	void			*irq_data;	/* Data for use for IRQ by card	*/
> -	void			*fiq_data;	/* Data for use for FIQ by card	*/
> -	const expansioncard_ops_t *ops;		/* Enable/Disable Ops for card	*/
> -
> -	CONST unsigned int	slot_no;	/* Slot number			*/
> -	CONST unsigned int	dma;		/* DMA number (for request_dma)	*/
> -	CONST unsigned int	irq;		/* IRQ number (for request_irq)	*/
> -	CONST unsigned int	fiq;		/* FIQ number (for request_irq)	*/
> -	CONST struct in_ecid	cid;		/* Card Identification		*/
> -
> -	/* Private internal data */
> -	const char		*card_desc;	/* Card description		*/
> -	CONST loader_t		loader;		/* loader program */
> -	u64			dma_mask;
> -};
> -
> -void ecard_setirq(struct expansion_card *ec, const struct expansion_card_ops *ops, void *irq_data);
> -
> -struct in_chunk_dir {
> -	unsigned int start_offset;
> -	union {
> -		unsigned char string[256];
> -		unsigned char data[1];
> -	} d;
> -};
> -
> -/*
> - * Read a chunk from an expansion card
> - * cd : where to put read data
> - * ec : expansion card info struct
> - * id : id number to find
> - * num: (n+1)'th id to find.
> - */
> -extern int ecard_readchunk (struct in_chunk_dir *cd, struct expansion_card *ec, int id, int num);
> -
> -/*
> - * Request and release ecard resources
> - */
> -extern int ecard_request_resources(struct expansion_card *ec);
> -extern void ecard_release_resources(struct expansion_card *ec);
> -
> -void __iomem *ecardm_iomap(struct expansion_card *ec, unsigned int res,
> -			   unsigned long offset, unsigned long maxsize);
> -#define ecardm_iounmap(__ec, __addr)	devm_iounmap(&(__ec)->dev, __addr)
> -
> -extern const struct bus_type ecard_bus_type;
> -
> -#define ECARD_DEV(_d)	container_of((_d), struct expansion_card, dev)
> -
> -struct ecard_driver {
> -	int			(*probe)(struct expansion_card *, const struct ecard_id *id);
> -	void			(*remove)(struct expansion_card *);
> -	void			(*shutdown)(struct expansion_card *);
> -	const struct ecard_id	*id_table;
> -	unsigned int		id;
> -	struct device_driver	drv;
> -};
> -
> -#define ECARD_DRV(_d)	container_of((_d), struct ecard_driver, drv)
> -
> -#define ecard_set_drvdata(ec,data)	dev_set_drvdata(&(ec)->dev, (data))
> -#define ecard_get_drvdata(ec)		dev_get_drvdata(&(ec)->dev)
> -
> -int ecard_register_driver(struct ecard_driver *);
> -void ecard_remove_driver(struct ecard_driver *);
> -
> -#endif
> diff --git a/arch/arm/include/asm/hardware/ioc.h b/arch/arm/include/asm/hardware/ioc.h
> deleted file mode 100644
> index 6edd27fcd048..000000000000
> --- a/arch/arm/include/asm/hardware/ioc.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/include/asm/hardware/ioc.h
> - *
> - *  Copyright (C) Russell King
> - *
> - *  Use these macros to read/write the IOC.  All it does is perform the actual
> - *  read/write.
> - */
> -#ifndef __ASMARM_HARDWARE_IOC_H
> -#define __ASMARM_HARDWARE_IOC_H
> -
> -#ifndef __ASSEMBLY__
> -
> -/*
> - * We use __raw_base variants here so that we give the compiler the
> - * chance to keep IOC_BASE in a register.
> - */
> -#define ioc_readb(off)		__raw_readb(IOC_BASE + (off))
> -#define ioc_writeb(val,off)	__raw_writeb(val, IOC_BASE + (off))
> -
> -#endif
> -
> -#define IOC_CONTROL	(0x00)
> -#define IOC_KARTTX	(0x04)
> -#define IOC_KARTRX	(0x04)
> -
> -#define IOC_IRQSTATA	(0x10)
> -#define IOC_IRQREQA	(0x14)
> -#define IOC_IRQCLRA	(0x14)
> -#define IOC_IRQMASKA	(0x18)
> -
> -#define IOC_IRQSTATB	(0x20)
> -#define IOC_IRQREQB	(0x24)
> -#define IOC_IRQMASKB	(0x28)
> -
> -#define IOC_FIQSTAT	(0x30)
> -#define IOC_FIQREQ	(0x34)
> -#define IOC_FIQMASK	(0x38)
> -
> -#define IOC_T0CNTL	(0x40)
> -#define IOC_T0LTCHL	(0x40)
> -#define IOC_T0CNTH	(0x44)
> -#define IOC_T0LTCHH	(0x44)
> -#define IOC_T0GO	(0x48)
> -#define IOC_T0LATCH	(0x4c)
> -
> -#define IOC_T1CNTL	(0x50)
> -#define IOC_T1LTCHL	(0x50)
> -#define IOC_T1CNTH	(0x54)
> -#define IOC_T1LTCHH	(0x54)
> -#define IOC_T1GO	(0x58)
> -#define IOC_T1LATCH	(0x5c)
> -
> -#define IOC_T2CNTL	(0x60)
> -#define IOC_T2LTCHL	(0x60)
> -#define IOC_T2CNTH	(0x64)
> -#define IOC_T2LTCHH	(0x64)
> -#define IOC_T2GO	(0x68)
> -#define IOC_T2LATCH	(0x6c)
> -
> -#define IOC_T3CNTL	(0x70)
> -#define IOC_T3LTCHL	(0x70)
> -#define IOC_T3CNTH	(0x74)
> -#define IOC_T3LTCHH	(0x74)
> -#define IOC_T3GO	(0x78)
> -#define IOC_T3LATCH	(0x7c)
> -
> -#endif
> diff --git a/arch/arm/include/asm/hardware/iomd.h b/arch/arm/include/asm/hardware/iomd.h
> deleted file mode 100644
> index 53006ba5350f..000000000000
> --- a/arch/arm/include/asm/hardware/iomd.h
> +++ /dev/null
> @@ -1,182 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/include/asm/hardware/iomd.h
> - *
> - *  Copyright (C) 1999 Russell King
> - *
> - *  This file contains information out the IOMD ASIC used in the
> - *  Acorn RiscPC and subsequently integrated into the CLPS7500 chips.
> - */
> -#ifndef __ASMARM_HARDWARE_IOMD_H
> -#define __ASMARM_HARDWARE_IOMD_H
> -
> -
> -#ifndef __ASSEMBLY__
> -
> -/*
> - * We use __raw_base variants here so that we give the compiler the
> - * chance to keep IOC_BASE in a register.
> - */
> -#define iomd_readb(off)		__raw_readb(IOMD_BASE + (off))
> -#define iomd_readl(off)		__raw_readl(IOMD_BASE + (off))
> -#define iomd_writeb(val,off)	__raw_writeb(val, IOMD_BASE + (off))
> -#define iomd_writel(val,off)	__raw_writel(val, IOMD_BASE + (off))
> -
> -#endif
> -
> -#define IOMD_CONTROL	(0x000)
> -#define IOMD_KARTTX	(0x004)
> -#define IOMD_KARTRX	(0x004)
> -#define IOMD_KCTRL	(0x008)
> -
> -#define IOMD_IRQSTATA	(0x010)
> -#define IOMD_IRQREQA	(0x014)
> -#define IOMD_IRQCLRA	(0x014)
> -#define IOMD_IRQMASKA	(0x018)
> -
> -#define IOMD_IRQSTATB	(0x020)
> -#define IOMD_IRQREQB	(0x024)
> -#define IOMD_IRQMASKB	(0x028)
> -
> -#define IOMD_FIQSTAT	(0x030)
> -#define IOMD_FIQREQ	(0x034)
> -#define IOMD_FIQMASK	(0x038)
> -
> -#define IOMD_T0CNTL	(0x040)
> -#define IOMD_T0LTCHL	(0x040)
> -#define IOMD_T0CNTH	(0x044)
> -#define IOMD_T0LTCHH	(0x044)
> -#define IOMD_T0GO	(0x048)
> -#define IOMD_T0LATCH	(0x04c)
> -
> -#define IOMD_T1CNTL	(0x050)
> -#define IOMD_T1LTCHL	(0x050)
> -#define IOMD_T1CNTH	(0x054)
> -#define IOMD_T1LTCHH	(0x054)
> -#define IOMD_T1GO	(0x058)
> -#define IOMD_T1LATCH	(0x05c)
> -
> -#define IOMD_ROMCR0	(0x080)
> -#define IOMD_ROMCR1	(0x084)
> -#ifdef CONFIG_ARCH_RPC
> -#define IOMD_DRAMCR	(0x088)
> -#endif
> -#define IOMD_REFCR	(0x08C)
> -
> -#define IOMD_FSIZE	(0x090)
> -#define IOMD_ID0	(0x094)
> -#define IOMD_ID1	(0x098)
> -#define IOMD_VERSION	(0x09C)
> -
> -#ifdef CONFIG_ARCH_RPC
> -#define IOMD_MOUSEX	(0x0A0)
> -#define IOMD_MOUSEY	(0x0A4)
> -#endif
> -
> -#ifdef CONFIG_ARCH_RPC
> -#define IOMD_DMATCR	(0x0C0)
> -#endif
> -#define IOMD_IOTCR	(0x0C4)
> -#define IOMD_ECTCR	(0x0C8)
> -#ifdef CONFIG_ARCH_RPC
> -#define IOMD_DMAEXT	(0x0CC)
> -#endif
> -
> -#ifdef CONFIG_ARCH_RPC
> -#define DMA_EXT_IO0	1
> -#define DMA_EXT_IO1	2
> -#define DMA_EXT_IO2	4
> -#define DMA_EXT_IO3	8
> -
> -#define IOMD_IO0CURA	(0x100)
> -#define IOMD_IO0ENDA	(0x104)
> -#define IOMD_IO0CURB	(0x108)
> -#define IOMD_IO0ENDB	(0x10C)
> -#define IOMD_IO0CR	(0x110)
> -#define IOMD_IO0ST	(0x114)
> -
> -#define IOMD_IO1CURA	(0x120)
> -#define IOMD_IO1ENDA	(0x124)
> -#define IOMD_IO1CURB	(0x128)
> -#define IOMD_IO1ENDB	(0x12C)
> -#define IOMD_IO1CR	(0x130)
> -#define IOMD_IO1ST	(0x134)
> -
> -#define IOMD_IO2CURA	(0x140)
> -#define IOMD_IO2ENDA	(0x144)
> -#define IOMD_IO2CURB	(0x148)
> -#define IOMD_IO2ENDB	(0x14C)
> -#define IOMD_IO2CR	(0x150)
> -#define IOMD_IO2ST	(0x154)
> -
> -#define IOMD_IO3CURA	(0x160)
> -#define IOMD_IO3ENDA	(0x164)
> -#define IOMD_IO3CURB	(0x168)
> -#define IOMD_IO3ENDB	(0x16C)
> -#define IOMD_IO3CR	(0x170)
> -#define IOMD_IO3ST	(0x174)
> -#endif
> -
> -#define IOMD_SD0CURA	(0x180)
> -#define IOMD_SD0ENDA	(0x184)
> -#define IOMD_SD0CURB	(0x188)
> -#define IOMD_SD0ENDB	(0x18C)
> -#define IOMD_SD0CR	(0x190)
> -#define IOMD_SD0ST	(0x194)
> -
> -#ifdef CONFIG_ARCH_RPC
> -#define IOMD_SD1CURA	(0x1A0)
> -#define IOMD_SD1ENDA	(0x1A4)
> -#define IOMD_SD1CURB	(0x1A8)
> -#define IOMD_SD1ENDB	(0x1AC)
> -#define IOMD_SD1CR	(0x1B0)
> -#define IOMD_SD1ST	(0x1B4)
> -#endif
> -
> -#define IOMD_CURSCUR	(0x1C0)
> -#define IOMD_CURSINIT	(0x1C4)
> -
> -#define IOMD_VIDCUR	(0x1D0)
> -#define IOMD_VIDEND	(0x1D4)
> -#define IOMD_VIDSTART	(0x1D8)
> -#define IOMD_VIDINIT	(0x1DC)
> -#define IOMD_VIDCR	(0x1E0)
> -
> -#define IOMD_DMASTAT	(0x1F0)
> -#define IOMD_DMAREQ	(0x1F4)
> -#define IOMD_DMAMASK	(0x1F8)
> -
> -#define DMA_END_S	(1 << 31)
> -#define DMA_END_L	(1 << 30)
> -
> -#define DMA_CR_C	0x80
> -#define DMA_CR_D	0x40
> -#define DMA_CR_E	0x20
> -
> -#define DMA_ST_OFL	4
> -#define DMA_ST_INT	2
> -#define DMA_ST_AB	1
> -
> -/*
> - * DMA (MEMC) compatibility
> - */
> -#define HALF_SAM	vram_half_sam
> -#define VDMA_ALIGNMENT	(HALF_SAM * 2)
> -#define VDMA_XFERSIZE	(HALF_SAM)
> -#define VDMA_INIT	IOMD_VIDINIT
> -#define VDMA_START	IOMD_VIDSTART
> -#define VDMA_END	IOMD_VIDEND
> -
> -#ifndef __ASSEMBLY__
> -extern unsigned int vram_half_sam;
> -#define video_set_dma(start,end,offset)				\
> -do {								\
> -	outl (SCREEN_START + start, VDMA_START);		\
> -	outl (SCREEN_START + end - VDMA_XFERSIZE, VDMA_END);	\
> -	if (offset >= end - VDMA_XFERSIZE)			\
> -		offset |= 0x40000000;				\
> -	outl (SCREEN_START + offset, VDMA_INIT);		\
> -} while (0)
> -#endif
> -
> -#endif
> diff --git a/arch/arm/include/asm/hardware/memc.h b/arch/arm/include/asm/hardware/memc.h
> deleted file mode 100644
> index 1d4ebe0a9678..000000000000
> --- a/arch/arm/include/asm/hardware/memc.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/include/asm/hardware/memc.h
> - *
> - *  Copyright (C) Russell King.
> - */
> -#define VDMA_ALIGNMENT	PAGE_SIZE
> -#define VDMA_XFERSIZE	16
> -#define VDMA_INIT	0
> -#define VDMA_START	1
> -#define VDMA_END	2
> -
> -#ifndef __ASSEMBLY__
> -extern void memc_write(unsigned int reg, unsigned long val);
> -
> -#define video_set_dma(start,end,offset)				\
> -do {								\
> -	memc_write (VDMA_START, (start >> 2));			\
> -	memc_write (VDMA_END, (end - VDMA_XFERSIZE) >> 2);	\
> -	memc_write (VDMA_INIT, (offset >> 2));			\
> -} while (0)
> -
> -#endif
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index e6bd9e79737c..c3661af2ca2a 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -207,16 +207,13 @@ void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size);
>   /*
>    * Now, pick up the machine-defined IO definitions
>    */
> -#ifdef CONFIG_NEED_MACH_IO_H
> -#include <mach/io.h>
> -#else
>   #if IS_ENABLED(CONFIG_PCMCIA) || defined(CONFIG_PCI)
>   #define IO_SPACE_LIMIT	((resource_size_t)0xfffff)
>   #else
>   #define IO_SPACE_LIMIT ((resource_size_t)0)
>   #endif
> +
>   #define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
> -#endif
>   
>   /*
>    *  IO port access primitives
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 7c2fa7dcec6d..e10363ebdd1f 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -20,9 +20,6 @@
>   #include <linux/types.h>
>   #include <linux/sizes.h>
>   
> -#ifdef CONFIG_NEED_MACH_MEMORY_H
> -#include <mach/memory.h>
> -#endif
>   #include <asm/kasan_def.h>
>   
>   /*
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 42cae73fcc19..3cbbcdb63f7d 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -221,19 +221,6 @@ str_p2:	.asciz	").\n"
>   ENDPROC(__error_p)
>   
>   __error:
> -#ifdef CONFIG_ARCH_RPC
> -/*
> - * Turn the screen red on a error - RiscPC only.
> - */
> -	mov	r0, #0x02000000
> -	mov	r3, #0x11
> -	orr	r3, r3, r3, lsl #8
> -	orr	r3, r3, r3, lsl #16
> -	str	r3, [r0], #4
> -	str	r3, [r0], #4
> -	str	r3, [r0], #4
> -	str	r3, [r0], #4
> -#endif
>   1:	mov	r0, r0
>   	b	1b
>   ENDPROC(__error)
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index b12fe41e579b..2ffaea2c4c9b 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -347,18 +347,6 @@ __create_page_tables:
>   	/* we don't need any serial debugging mappings */
>   	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
>   #endif
> -#ifdef CONFIG_ARCH_RPC
> -	/*
> -	 * Map in screen at 0x02000000 & SCREEN2_BASE
> -	 * Similar reasons here - for debug.  This is
> -	 * only for Acorn RiscPC architectures.
> -	 */
> -	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
> -	orr	r3, r7, #0x02000000
> -	str	r3, [r0]
> -	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
> -	str	r3, [r0]
> -#endif
>   #endif
>   #ifdef CONFIG_ARM_LPAE
>   	sub	r4, r4, #0x1000		@ point to the PGD table
> diff --git a/arch/arm/lib/delay-loop.S b/arch/arm/lib/delay-loop.S
> index 33b08ca1c242..56f9eea56268 100644
> --- a/arch/arm/lib/delay-loop.S
> +++ b/arch/arm/lib/delay-loop.S
> @@ -9,10 +9,6 @@
>   #include <asm/assembler.h>
>   #include <asm/delay.h>
>   
> -#ifdef CONFIG_ARCH_RPC
> -		.arch	armv4
> -#endif
> -
>   		.text
>   
>   .LC0:		.word	loops_per_jiffy
> diff --git a/arch/arm/mach-rpc/Kconfig b/arch/arm/mach-rpc/Kconfig
> deleted file mode 100644
> index 60b3823b690c..000000000000
> --- a/arch/arm/mach-rpc/Kconfig
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -config ARCH_RPC
> -	bool "RiscPC (DEPRECATED)"
> -	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
> -	depends on !(ARCH_FOOTBRIDGE || ARCH_SA1100 || ARCH_MOXART || ARCH_GEMINI)
> -	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
> -	depends on CPU_LITTLE_ENDIAN
> -	depends on ATAGS
> -	depends on MMU
> -	select ARCH_ACORN
> -	select ARCH_MAY_HAVE_PC_FDC
> -	select CPU_SA110
> -	select FIQ
> -	select HAVE_PATA_PLATFORM
> -	select ISA_DMA_API
> -	select LEGACY_TIMER_TICK
> -	select NEED_MACH_IO_H
> -	select NEED_MACH_MEMORY_H
> -	select NO_IOPORT_MAP
> -	help
> -	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
> -	  CD-ROM interface, serial and parallel port, and the floppy drive.
> -
> -	  Support for these machines will go away in 2027,
> -	  unless there are any remaining users that speak up.
> diff --git a/arch/arm/mach-rpc/Makefile b/arch/arm/mach-rpc/Makefile
> deleted file mode 100644
> index 90a645a18444..000000000000
> --- a/arch/arm/mach-rpc/Makefile
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile for the linux kernel.
> -#
> -
> -# Object file lists.
> -
> -obj-y	:=dma.o ecard.o ecard-loader.o fiq.o floppydma.o io-acorn.o irq.o \
> -	  riscpc.o time.o
> diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
> deleted file mode 100644
> index 50e0f97afd75..000000000000
> --- a/arch/arm/mach-rpc/dma.c
> +++ /dev/null
> @@ -1,393 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/arch/arm/mach-rpc/dma.c
> - *
> - *  Copyright (C) 1998 Russell King
> - *
> - *  DMA functions specific to RiscPC architecture
> - */
> -#include <linux/mman.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/io.h>
> -
> -#include <asm/page.h>
> -#include <asm/dma.h>
> -#include <asm/fiq.h>
> -#include <asm/irq.h>
> -#include <mach/hardware.h>
> -#include <linux/uaccess.h>
> -
> -#include <asm/mach/dma.h>
> -#include <asm/hardware/iomd.h>
> -
> -struct iomd_dma {
> -	struct dma_struct	dma;
> -	void __iomem		*base;		/* Controller base address */
> -	int			irq;		/* Controller IRQ */
> -	unsigned int		state;
> -	dma_addr_t		cur_addr;
> -	unsigned int		cur_len;
> -	dma_addr_t		dma_addr;
> -	unsigned int		dma_len;
> -};
> -
> -#if 0
> -typedef enum {
> -	dma_size_8	= 1,
> -	dma_size_16	= 2,
> -	dma_size_32	= 4,
> -	dma_size_128	= 16
> -} dma_size_t;
> -#endif
> -
> -#define TRANSFER_SIZE	2
> -
> -#define CURA	(0)
> -#define ENDA	(IOMD_IO0ENDA - IOMD_IO0CURA)
> -#define CURB	(IOMD_IO0CURB - IOMD_IO0CURA)
> -#define ENDB	(IOMD_IO0ENDB - IOMD_IO0CURA)
> -#define CR	(IOMD_IO0CR - IOMD_IO0CURA)
> -#define ST	(IOMD_IO0ST - IOMD_IO0CURA)
> -
> -static void iomd_get_next_sg(struct iomd_dma *idma)
> -{
> -	unsigned long end, offset, flags = 0;
> -
> -	if (idma->dma.sg) {
> -		idma->cur_addr = idma->dma_addr;
> -		offset = idma->cur_addr & ~PAGE_MASK;
> -
> -		end = offset + idma->dma_len;
> -
> -		if (end > PAGE_SIZE)
> -			end = PAGE_SIZE;
> -
> -		if (offset + TRANSFER_SIZE >= end)
> -			flags |= DMA_END_L;
> -
> -		idma->cur_len = end - TRANSFER_SIZE;
> -
> -		idma->dma_len -= end - offset;
> -		idma->dma_addr += end - offset;
> -
> -		if (idma->dma_len == 0) {
> -			if (idma->dma.sgcount > 1) {
> -				idma->dma.sg = sg_next(idma->dma.sg);
> -				idma->dma_addr = idma->dma.sg->dma_address;
> -				idma->dma_len = idma->dma.sg->length;
> -				idma->dma.sgcount--;
> -			} else {
> -				idma->dma.sg = NULL;
> -				flags |= DMA_END_S;
> -			}
> -		}
> -	} else {
> -		flags = DMA_END_S | DMA_END_L;
> -		idma->cur_addr = 0;
> -		idma->cur_len = 0;
> -	}
> -
> -	idma->cur_len |= flags;
> -}
> -
> -static irqreturn_t iomd_dma_handle(int irq, void *dev_id)
> -{
> -	struct iomd_dma *idma = dev_id;
> -	void __iomem *base = idma->base;
> -	unsigned int state = idma->state;
> -	unsigned int status, cur, end;
> -
> -	do {
> -		status = readb(base + ST);
> -		if (!(status & DMA_ST_INT))
> -			goto out;
> -
> -		if ((state ^ status) & DMA_ST_AB)
> -			iomd_get_next_sg(idma);
> -
> -		// This efficiently implements state = OFL != AB ? AB : 0
> -		state = ((status >> 2) ^ status) & DMA_ST_AB;
> -		if (state) {
> -			cur = CURA;
> -			end = ENDA;
> -		} else {
> -			cur = CURB;
> -			end = ENDB;
> -		}
> -		writel(idma->cur_addr, base + cur);
> -		writel(idma->cur_len, base + end);
> -
> -		if (status & DMA_ST_OFL &&
> -		    idma->cur_len == (DMA_END_S|DMA_END_L))
> -			break;
> -	} while (1);
> -
> -	state = ~DMA_ST_AB;
> -	disable_irq_nosync(irq);
> -out:
> -	idma->state = state;
> -	return IRQ_HANDLED;
> -}
> -
> -static int iomd_request_dma(unsigned int chan, dma_t *dma)
> -{
> -	struct iomd_dma *idma = container_of(dma, struct iomd_dma, dma);
> -
> -	return request_irq(idma->irq, iomd_dma_handle,
> -			   0, idma->dma.device_id, idma);
> -}
> -
> -static void iomd_free_dma(unsigned int chan, dma_t *dma)
> -{
> -	struct iomd_dma *idma = container_of(dma, struct iomd_dma, dma);
> -
> -	free_irq(idma->irq, idma);
> -}
> -
> -static struct device isa_dma_dev = {
> -	.init_name		= "fallback device",
> -	.coherent_dma_mask	= ~(dma_addr_t)0,
> -	.dma_mask		= &isa_dma_dev.coherent_dma_mask,
> -};
> -
> -static void iomd_enable_dma(unsigned int chan, dma_t *dma)
> -{
> -	struct iomd_dma *idma = container_of(dma, struct iomd_dma, dma);
> -	void __iomem *base = idma->base;
> -	unsigned int ctrl = TRANSFER_SIZE | DMA_CR_E;
> -
> -	if (idma->dma.invalid) {
> -		idma->dma.invalid = 0;
> -
> -		/*
> -		 * Cope with ISA-style drivers which expect cache
> -		 * coherence.
> -		 */
> -		if (!idma->dma.sg) {
> -			idma->dma.sg = &idma->dma.buf;
> -			idma->dma.sgcount = 1;
> -			idma->dma.buf.length = idma->dma.count;
> -			idma->dma.buf.dma_address = dma_map_single(&isa_dma_dev,
> -				idma->dma.addr, idma->dma.count,
> -				idma->dma.dma_mode == DMA_MODE_READ ?
> -				DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -		}
> -
> -		idma->dma_addr = idma->dma.sg->dma_address;
> -		idma->dma_len = idma->dma.sg->length;
> -
> -		writeb(DMA_CR_C, base + CR);
> -		idma->state = DMA_ST_AB;
> -	}
> -
> -	if (idma->dma.dma_mode == DMA_MODE_READ)
> -		ctrl |= DMA_CR_D;
> -
> -	writeb(ctrl, base + CR);
> -	enable_irq(idma->irq);
> -}
> -
> -static void iomd_disable_dma(unsigned int chan, dma_t *dma)
> -{
> -	struct iomd_dma *idma = container_of(dma, struct iomd_dma, dma);
> -	void __iomem *base = idma->base;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	if (idma->state != ~DMA_ST_AB)
> -		disable_irq(idma->irq);
> -	writeb(0, base + CR);
> -	local_irq_restore(flags);
> -}
> -
> -static int iomd_set_dma_speed(unsigned int chan, dma_t *dma, int cycle)
> -{
> -	int tcr, speed;
> -
> -	if (cycle < 188)
> -		speed = 3;
> -	else if (cycle <= 250)
> -		speed = 2;
> -	else if (cycle < 438)
> -		speed = 1;
> -	else
> -		speed = 0;
> -
> -	tcr = iomd_readb(IOMD_DMATCR);
> -	speed &= 3;
> -
> -	switch (chan) {
> -	case DMA_0:
> -		tcr = (tcr & ~0x03) | speed;
> -		break;
> -
> -	case DMA_1:
> -		tcr = (tcr & ~0x0c) | (speed << 2);
> -		break;
> -
> -	case DMA_2:
> -		tcr = (tcr & ~0x30) | (speed << 4);
> -		break;
> -
> -	case DMA_3:
> -		tcr = (tcr & ~0xc0) | (speed << 6);
> -		break;
> -
> -	default:
> -		break;
> -	}
> -
> -	iomd_writeb(tcr, IOMD_DMATCR);
> -
> -	return speed;
> -}
> -
> -static struct dma_ops iomd_dma_ops = {
> -	.type		= "IOMD",
> -	.request	= iomd_request_dma,
> -	.free		= iomd_free_dma,
> -	.enable		= iomd_enable_dma,
> -	.disable	= iomd_disable_dma,
> -	.setspeed	= iomd_set_dma_speed,
> -};
> -
> -static struct fiq_handler fh = {
> -	.name	= "floppydma"
> -};
> -
> -struct floppy_dma {
> -	struct dma_struct	dma;
> -	unsigned int		fiq;
> -};
> -
> -static void floppy_enable_dma(unsigned int chan, dma_t *dma)
> -{
> -	struct floppy_dma *fdma = container_of(dma, struct floppy_dma, dma);
> -	void *fiqhandler_start;
> -	unsigned int fiqhandler_length;
> -	struct pt_regs regs;
> -
> -	if (fdma->dma.sg)
> -		BUG();
> -
> -	if (fdma->dma.dma_mode == DMA_MODE_READ) {
> -		extern unsigned char floppy_fiqin_start, floppy_fiqin_end;
> -		fiqhandler_start = &floppy_fiqin_start;
> -		fiqhandler_length = &floppy_fiqin_end - &floppy_fiqin_start;
> -	} else {
> -		extern unsigned char floppy_fiqout_start, floppy_fiqout_end;
> -		fiqhandler_start = &floppy_fiqout_start;
> -		fiqhandler_length = &floppy_fiqout_end - &floppy_fiqout_start;
> -	}
> -
> -	regs.ARM_r9  = fdma->dma.count;
> -	regs.ARM_r10 = (unsigned long)fdma->dma.addr;
> -	regs.ARM_fp  = (unsigned long)FLOPPYDMA_BASE;
> -
> -	if (claim_fiq(&fh)) {
> -		printk("floppydma: couldn't claim FIQ.\n");
> -		return;
> -	}
> -
> -	set_fiq_handler(fiqhandler_start, fiqhandler_length);
> -	set_fiq_regs(&regs);
> -	enable_fiq(fdma->fiq);
> -}
> -
> -static void floppy_disable_dma(unsigned int chan, dma_t *dma)
> -{
> -	struct floppy_dma *fdma = container_of(dma, struct floppy_dma, dma);
> -	disable_fiq(fdma->fiq);
> -	release_fiq(&fh);
> -}
> -
> -static int floppy_get_residue(unsigned int chan, dma_t *dma)
> -{
> -	struct pt_regs regs;
> -	get_fiq_regs(&regs);
> -	return regs.ARM_r9;
> -}
> -
> -static struct dma_ops floppy_dma_ops = {
> -	.type		= "FIQDMA",
> -	.enable		= floppy_enable_dma,
> -	.disable	= floppy_disable_dma,
> -	.residue	= floppy_get_residue,
> -};
> -
> -/*
> - * This is virtual DMA - we don't need anything here.
> - */
> -static void sound_enable_disable_dma(unsigned int chan, dma_t *dma)
> -{
> -}
> -
> -static struct dma_ops sound_dma_ops = {
> -	.type		= "VIRTUAL",
> -	.enable		= sound_enable_disable_dma,
> -	.disable	= sound_enable_disable_dma,
> -};
> -
> -static struct iomd_dma iomd_dma[6];
> -
> -static struct floppy_dma floppy_dma = {
> -	.dma		= {
> -		.d_ops	= &floppy_dma_ops,
> -	},
> -	.fiq		= FIQ_FLOPPYDATA,
> -};
> -
> -static dma_t sound_dma = {
> -	.d_ops		= &sound_dma_ops,
> -};
> -
> -static int __init rpc_dma_init(void)
> -{
> -	unsigned int i;
> -	int ret;
> -
> -	iomd_writeb(0, IOMD_IO0CR);
> -	iomd_writeb(0, IOMD_IO1CR);
> -	iomd_writeb(0, IOMD_IO2CR);
> -	iomd_writeb(0, IOMD_IO3CR);
> -
> -	iomd_writeb(0xa0, IOMD_DMATCR);
> -
> -	/*
> -	 * Setup DMA channels 2,3 to be for podules
> -	 * and channels 0,1 for internal devices
> -	 */
> -	iomd_writeb(DMA_EXT_IO3|DMA_EXT_IO2, IOMD_DMAEXT);
> -
> -	iomd_dma[DMA_0].base	= IOMD_BASE + IOMD_IO0CURA;
> -	iomd_dma[DMA_0].irq	= IRQ_DMA0;
> -	iomd_dma[DMA_1].base	= IOMD_BASE + IOMD_IO1CURA;
> -	iomd_dma[DMA_1].irq	= IRQ_DMA1;
> -	iomd_dma[DMA_2].base	= IOMD_BASE + IOMD_IO2CURA;
> -	iomd_dma[DMA_2].irq	= IRQ_DMA2;
> -	iomd_dma[DMA_3].base	= IOMD_BASE + IOMD_IO3CURA;
> -	iomd_dma[DMA_3].irq	= IRQ_DMA3;
> -	iomd_dma[DMA_S0].base	= IOMD_BASE + IOMD_SD0CURA;
> -	iomd_dma[DMA_S0].irq	= IRQ_DMAS0;
> -	iomd_dma[DMA_S1].base	= IOMD_BASE + IOMD_SD1CURA;
> -	iomd_dma[DMA_S1].irq	= IRQ_DMAS1;
> -
> -	for (i = DMA_0; i <= DMA_S1; i++) {
> -		iomd_dma[i].dma.d_ops = &iomd_dma_ops;
> -
> -		ret = isa_dma_add(i, &iomd_dma[i].dma);
> -		if (ret)
> -			printk("IOMDDMA%u: unable to register: %d\n", i, ret);
> -	}
> -
> -	ret = isa_dma_add(DMA_VIRTUAL_FLOPPY, &floppy_dma.dma);
> -	if (ret)
> -		printk("IOMDFLOPPY: unable to register: %d\n", ret);
> -	ret = isa_dma_add(DMA_VIRTUAL_SOUND, &sound_dma);
> -	if (ret)
> -		printk("IOMDSOUND: unable to register: %d\n", ret);
> -	return 0;
> -}
> -core_initcall(rpc_dma_init);
> diff --git a/arch/arm/mach-rpc/ecard-loader.S b/arch/arm/mach-rpc/ecard-loader.S
> deleted file mode 100644
> index eb8ac0412da6..000000000000
> --- a/arch/arm/mach-rpc/ecard-loader.S
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  linux/arch/arm/lib/ecard.S
> - *
> - *  Copyright (C) 1995, 1996 Russell King
> - *
> - * 27/03/03 Ian Molton Clean up CONFIG_CPU
> - */
> -#include <linux/linkage.h>
> -#include <asm/assembler.h>
> -
> -#define CPSR2SPSR(rt) \
> -		mrs	rt, cpsr; \
> -		msr	spsr_cxsf, rt
> -
> -@ Purpose: call an expansion card loader to read bytes.
> -@ Proto  : char read_loader(int offset, char *card_base, char *loader);
> -@ Returns: byte read
> -
> -ENTRY(ecard_loader_read)
> -		stmfd	sp!, {r4 - r12, lr}
> -		mov	r11, r1
> -		mov	r1, r0
> -		CPSR2SPSR(r0)
> -		mov	lr, pc
> -		mov	pc, r2
> -		ldmfd	sp!, {r4 - r12, pc}
> -
> -@ Purpose: call an expansion card loader to reset the card
> -@ Proto  : void read_loader(int card_base, char *loader);
> -@ Returns: byte read
> -
> -ENTRY(ecard_loader_reset)
> -		stmfd	sp!, {r4 - r12, lr}
> -		mov	r11, r0
> -		CPSR2SPSR(r0)
> -		mov	lr, pc
> -		add	pc, r1, #8
> -		ldmfd	sp!, {r4 - r12, pc}
> -
> diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
> deleted file mode 100644
> index 972465840548..000000000000
> --- a/arch/arm/mach-rpc/ecard.c
> +++ /dev/null
> @@ -1,1146 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/arch/arm/kernel/ecard.c
> - *
> - *  Copyright 1995-2001 Russell King
> - *
> - *  Find all installed expansion cards, and handle interrupts from them.
> - *
> - *  Created from information from Acorns RiscOS3 PRMs
> - *
> - *  08-Dec-1996	RMK	Added code for the 9'th expansion card - the ether
> - *			podule slot.
> - *  06-May-1997	RMK	Added blacklist for cards whose loader doesn't work.
> - *  12-Sep-1997	RMK	Created new handling of interrupt enables/disables
> - *			- cards can now register their own routine to control
> - *			interrupts (recommended).
> - *  29-Sep-1997	RMK	Expansion card interrupt hardware not being re-enabled
> - *			on reset from Linux. (Caused cards not to respond
> - *			under RiscOS without hard reset).
> - *  15-Feb-1998	RMK	Added DMA support
> - *  12-Sep-1998	RMK	Added EASI support
> - *  10-Jan-1999	RMK	Run loaders in a simulated RISC OS environment.
> - *  17-Apr-1999	RMK	Support for EASI Type C cycles.
> - */
> -#define ECARD_C
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/sched.h>
> -#include <linux/sched/mm.h>
> -#include <linux/interrupt.h>
> -#include <linux/completion.h>
> -#include <linux/reboot.h>
> -#include <linux/mm.h>
> -#include <linux/slab.h>
> -#include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
> -#include <linux/device.h>
> -#include <linux/init.h>
> -#include <linux/mutex.h>
> -#include <linux/kthread.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -
> -#include <asm/dma.h>
> -#include <asm/ecard.h>
> -#include <mach/hardware.h>
> -#include <asm/irq.h>
> -#include <asm/mmu_context.h>
> -#include <asm/mach/irq.h>
> -#include <asm/tlbflush.h>
> -
> -#include "ecard.h"
> -
> -struct ecard_request {
> -	void		(*fn)(struct ecard_request *);
> -	ecard_t		*ec;
> -	unsigned int	address;
> -	unsigned int	length;
> -	unsigned int	use_loader;
> -	void		*buffer;
> -	struct completion *complete;
> -};
> -
> -struct expcard_quirklist {
> -	unsigned short	 manufacturer;
> -	unsigned short	 product;
> -	const char	*type;
> -	void (*init)(ecard_t *ec);
> -};
> -
> -static ecard_t *cards;
> -static ecard_t *slot_to_expcard[MAX_ECARDS];
> -static unsigned int ectcr;
> -
> -static void atomwide_3p_quirk(ecard_t *ec);
> -
> -/* List of descriptions of cards which don't have an extended
> - * identification, or chunk directories containing a description.
> - */
> -static struct expcard_quirklist quirklist[] __initdata = {
> -	{ MANU_ACORN, PROD_ACORN_ETHER1, "Acorn Ether1" },
> -	{ MANU_ATOMWIDE, PROD_ATOMWIDE_3PSERIAL, NULL, atomwide_3p_quirk },
> -};
> -
> -asmlinkage extern int
> -ecard_loader_reset(unsigned long base, loader_t loader);
> -asmlinkage extern int
> -ecard_loader_read(int off, unsigned long base, loader_t loader);
> -
> -static inline unsigned short ecard_getu16(unsigned char *v)
> -{
> -	return v[0] | v[1] << 8;
> -}
> -
> -static inline signed long ecard_gets24(unsigned char *v)
> -{
> -	return v[0] | v[1] << 8 | v[2] << 16 | ((v[2] & 0x80) ? 0xff000000 : 0);
> -}
> -
> -static inline ecard_t *slot_to_ecard(unsigned int slot)
> -{
> -	return slot < MAX_ECARDS ? slot_to_expcard[slot] : NULL;
> -}
> -
> -/* ===================== Expansion card daemon ======================== */
> -/*
> - * Since the loader programs on the expansion cards need to be run
> - * in a specific environment, create a separate task with this
> - * environment up, and pass requests to this task as and when we
> - * need to.
> - *
> - * This should allow 99% of loaders to be called from Linux.
> - *
> - * From a security standpoint, we trust the card vendors.  This
> - * may be a misplaced trust.
> - */
> -static void ecard_task_reset(struct ecard_request *req)
> -{
> -	struct expansion_card *ec = req->ec;
> -	struct resource *res;
> -
> -	res = ec->slot_no == 8
> -		? &ec->resource[ECARD_RES_MEMC]
> -		: ec->easi
> -		  ? &ec->resource[ECARD_RES_EASI]
> -		  : &ec->resource[ECARD_RES_IOCSYNC];
> -
> -	ecard_loader_reset(res->start, ec->loader);
> -}
> -
> -static void ecard_task_readbytes(struct ecard_request *req)
> -{
> -	struct expansion_card *ec = req->ec;
> -	unsigned char *buf = req->buffer;
> -	unsigned int len = req->length;
> -	unsigned int off = req->address;
> -
> -	if (ec->slot_no == 8) {
> -		void __iomem *base = (void __iomem *)
> -				ec->resource[ECARD_RES_MEMC].start;
> -
> -		/*
> -		 * The card maintains an index which increments the address
> -		 * into a 4096-byte page on each access.  We need to keep
> -		 * track of the counter.
> -		 */
> -		static unsigned int index;
> -		unsigned int page;
> -
> -		page = (off >> 12) * 4;
> -		if (page > 256 * 4)
> -			return;
> -
> -		off &= 4095;
> -
> -		/*
> -		 * If we are reading offset 0, or our current index is
> -		 * greater than the offset, reset the hardware index counter.
> -		 */
> -		if (off == 0 || index > off) {
> -			writeb(0, base);
> -			index = 0;
> -		}
> -
> -		/*
> -		 * Increment the hardware index counter until we get to the
> -		 * required offset.  The read bytes are discarded.
> -		 */
> -		while (index < off) {
> -			readb(base + page);
> -			index += 1;
> -		}
> -
> -		while (len--) {
> -			*buf++ = readb(base + page);
> -			index += 1;
> -		}
> -	} else {
> -		unsigned long base = (ec->easi
> -			 ? &ec->resource[ECARD_RES_EASI]
> -			 : &ec->resource[ECARD_RES_IOCSYNC])->start;
> -		void __iomem *pbase = (void __iomem *)base;
> -
> -		if (!req->use_loader || !ec->loader) {
> -			off *= 4;
> -			while (len--) {
> -				*buf++ = readb(pbase + off);
> -				off += 4;
> -			}
> -		} else {
> -			while(len--) {
> -				/*
> -				 * The following is required by some
> -				 * expansion card loader programs.
> -				 */
> -				*(unsigned long *)0x108 = 0;
> -				*buf++ = ecard_loader_read(off++, base,
> -							   ec->loader);
> -			}
> -		}
> -	}
> -
> -}
> -
> -static DECLARE_WAIT_QUEUE_HEAD(ecard_wait);
> -static struct ecard_request *ecard_req;
> -static DEFINE_MUTEX(ecard_mutex);
> -
> -/*
> - * Set up the expansion card daemon's page tables.
> - */
> -static void ecard_init_pgtables(struct mm_struct *mm)
> -{
> -	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, VM_EXEC);
> -
> -	/* We want to set up the page tables for the following mapping:
> -	 *  Virtual	Physical
> -	 *  0x03000000	0x03000000
> -	 *  0x03010000	unmapped
> -	 *  0x03210000	0x03210000
> -	 *  0x03400000	unmapped
> -	 *  0x08000000	0x08000000
> -	 *  0x10000000	unmapped
> -	 *
> -	 * FIXME: we don't follow this 100% yet.
> -	 */
> -	pgd_t *src_pgd, *dst_pgd;
> -
> -	src_pgd = pgd_offset(mm, (unsigned long)IO_BASE);
> -	dst_pgd = pgd_offset(mm, IO_START);
> -
> -	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (IO_SIZE / PGDIR_SIZE));
> -
> -	src_pgd = pgd_offset(mm, (unsigned long)EASI_BASE);
> -	dst_pgd = pgd_offset(mm, EASI_START);
> -
> -	memcpy(dst_pgd, src_pgd, sizeof(pgd_t) * (EASI_SIZE / PGDIR_SIZE));
> -
> -	flush_tlb_range(&vma, IO_START, IO_START + IO_SIZE);
> -	flush_tlb_range(&vma, EASI_START, EASI_START + EASI_SIZE);
> -}
> -
> -static int ecard_init_mm(void)
> -{
> -	struct mm_struct * mm = mm_alloc();
> -	struct mm_struct *active_mm = current->active_mm;
> -
> -	if (!mm)
> -		return -ENOMEM;
> -
> -	current->mm = mm;
> -	current->active_mm = mm;
> -	activate_mm(active_mm, mm);
> -	mmdrop_lazy_tlb(active_mm);
> -	ecard_init_pgtables(mm);
> -	return 0;
> -}
> -
> -static int
> -ecard_task(void * unused)
> -{
> -	/*
> -	 * Allocate a mm.  We're not a lazy-TLB kernel task since we need
> -	 * to set page table entries where the user space would be.  Note
> -	 * that this also creates the page tables.  Failure is not an
> -	 * option here.
> -	 */
> -	if (ecard_init_mm())
> -		panic("kecardd: unable to alloc mm\n");
> -
> -	while (1) {
> -		struct ecard_request *req;
> -
> -		wait_event_interruptible(ecard_wait, ecard_req != NULL);
> -
> -		req = xchg(&ecard_req, NULL);
> -		if (req != NULL) {
> -			req->fn(req);
> -			complete(req->complete);
> -		}
> -	}
> -}
> -
> -/*
> - * Wake the expansion card daemon to action our request.
> - *
> - * FIXME: The test here is not sufficient to detect if the
> - * kcardd is running.
> - */
> -static void ecard_call(struct ecard_request *req)
> -{
> -	DECLARE_COMPLETION_ONSTACK(completion);
> -
> -	req->complete = &completion;
> -
> -	mutex_lock(&ecard_mutex);
> -	ecard_req = req;
> -	wake_up(&ecard_wait);
> -
> -	/*
> -	 * Now wait for kecardd to run.
> -	 */
> -	wait_for_completion(&completion);
> -	mutex_unlock(&ecard_mutex);
> -}
> -
> -/* ======================= Mid-level card control ===================== */
> -
> -static void
> -ecard_readbytes(void *addr, ecard_t *ec, int off, int len, int useld)
> -{
> -	struct ecard_request req;
> -
> -	req.fn		= ecard_task_readbytes;
> -	req.ec		= ec;
> -	req.address	= off;
> -	req.length	= len;
> -	req.use_loader	= useld;
> -	req.buffer	= addr;
> -
> -	ecard_call(&req);
> -}
> -
> -int ecard_readchunk(struct in_chunk_dir *cd, ecard_t *ec, int id, int num)
> -{
> -	struct ex_chunk_dir excd;
> -	int index = 16;
> -	int useld = 0;
> -
> -	if (!ec->cid.cd)
> -		return 0;
> -
> -	while(1) {
> -		ecard_readbytes(&excd, ec, index, 8, useld);
> -		index += 8;
> -		if (c_id(&excd) == 0) {
> -			if (!useld && ec->loader) {
> -				useld = 1;
> -				index = 0;
> -				continue;
> -			}
> -			return 0;
> -		}
> -		if (c_id(&excd) == 0xf0) { /* link */
> -			index = c_start(&excd);
> -			continue;
> -		}
> -		if (c_id(&excd) == 0x80) { /* loader */
> -			if (!ec->loader) {
> -				ec->loader = kmalloc(c_len(&excd),
> -							       GFP_KERNEL);
> -				if (ec->loader)
> -					ecard_readbytes(ec->loader, ec,
> -							(int)c_start(&excd),
> -							c_len(&excd), useld);
> -				else
> -					return 0;
> -			}
> -			continue;
> -		}
> -		if (c_id(&excd) == id && num-- == 0)
> -			break;
> -	}
> -
> -	if (c_id(&excd) & 0x80) {
> -		switch (c_id(&excd) & 0x70) {
> -		case 0x70:
> -			ecard_readbytes((unsigned char *)excd.d.string, ec,
> -					(int)c_start(&excd), c_len(&excd),
> -					useld);
> -			break;
> -		case 0x00:
> -			break;
> -		}
> -	}
> -	cd->start_offset = c_start(&excd);
> -	memcpy(cd->d.string, excd.d.string, 256);
> -	return 1;
> -}
> -
> -/* ======================= Interrupt control ============================ */
> -
> -static void ecard_def_irq_enable(ecard_t *ec, int irqnr)
> -{
> -}
> -
> -static void ecard_def_irq_disable(ecard_t *ec, int irqnr)
> -{
> -}
> -
> -static int ecard_def_irq_pending(ecard_t *ec)
> -{
> -	return !ec->irqmask || readb(ec->irqaddr) & ec->irqmask;
> -}
> -
> -static void ecard_def_fiq_enable(ecard_t *ec, int fiqnr)
> -{
> -	panic("ecard_def_fiq_enable called - impossible");
> -}
> -
> -static void ecard_def_fiq_disable(ecard_t *ec, int fiqnr)
> -{
> -	panic("ecard_def_fiq_disable called - impossible");
> -}
> -
> -static int ecard_def_fiq_pending(ecard_t *ec)
> -{
> -	return !ec->fiqmask || readb(ec->fiqaddr) & ec->fiqmask;
> -}
> -
> -static expansioncard_ops_t ecard_default_ops = {
> -	ecard_def_irq_enable,
> -	ecard_def_irq_disable,
> -	ecard_def_irq_pending,
> -	ecard_def_fiq_enable,
> -	ecard_def_fiq_disable,
> -	ecard_def_fiq_pending
> -};
> -
> -/*
> - * Enable and disable interrupts from expansion cards.
> - * (interrupts are disabled for these functions).
> - *
> - * They are not meant to be called directly, but via enable/disable_irq.
> - */
> -static void ecard_irq_unmask(struct irq_data *d)
> -{
> -	ecard_t *ec = irq_data_get_irq_chip_data(d);
> -
> -	if (ec) {
> -		if (!ec->ops)
> -			ec->ops = &ecard_default_ops;
> -
> -		if (ec->claimed && ec->ops->irqenable)
> -			ec->ops->irqenable(ec, d->irq);
> -		else
> -			printk(KERN_ERR "ecard: rejecting request to "
> -				"enable IRQs for %d\n", d->irq);
> -	}
> -}
> -
> -static void ecard_irq_mask(struct irq_data *d)
> -{
> -	ecard_t *ec = irq_data_get_irq_chip_data(d);
> -
> -	if (ec) {
> -		if (!ec->ops)
> -			ec->ops = &ecard_default_ops;
> -
> -		if (ec->ops && ec->ops->irqdisable)
> -			ec->ops->irqdisable(ec, d->irq);
> -	}
> -}
> -
> -static struct irq_chip ecard_chip = {
> -	.name		= "ECARD",
> -	.irq_ack	= ecard_irq_mask,
> -	.irq_mask	= ecard_irq_mask,
> -	.irq_unmask	= ecard_irq_unmask,
> -};
> -
> -void ecard_enablefiq(unsigned int fiqnr)
> -{
> -	ecard_t *ec = slot_to_ecard(fiqnr);
> -
> -	if (ec) {
> -		if (!ec->ops)
> -			ec->ops = &ecard_default_ops;
> -
> -		if (ec->claimed && ec->ops->fiqenable)
> -			ec->ops->fiqenable(ec, fiqnr);
> -		else
> -			printk(KERN_ERR "ecard: rejecting request to "
> -				"enable FIQs for %d\n", fiqnr);
> -	}
> -}
> -
> -void ecard_disablefiq(unsigned int fiqnr)
> -{
> -	ecard_t *ec = slot_to_ecard(fiqnr);
> -
> -	if (ec) {
> -		if (!ec->ops)
> -			ec->ops = &ecard_default_ops;
> -
> -		if (ec->ops->fiqdisable)
> -			ec->ops->fiqdisable(ec, fiqnr);
> -	}
> -}
> -
> -static void ecard_dump_irq_state(void)
> -{
> -	ecard_t *ec;
> -
> -	printk("Expansion card IRQ state:\n");
> -
> -	for (ec = cards; ec; ec = ec->next) {
> -		const char *claimed;
> -
> -		if (ec->slot_no == 8)
> -			continue;
> -
> -		claimed = ec->claimed ? "" : "not ";
> -
> -		if (ec->ops && ec->ops->irqpending &&
> -		    ec->ops != &ecard_default_ops)
> -			printk("  %d: %sclaimed irq %spending\n",
> -			       ec->slot_no, claimed,
> -			       ec->ops->irqpending(ec) ? "" : "not ");
> -		else
> -			printk("  %d: %sclaimed irqaddr %p, mask = %02X, status = %02X\n",
> -			       ec->slot_no, claimed,
> -			       ec->irqaddr, ec->irqmask, readb(ec->irqaddr));
> -	}
> -}
> -
> -static void ecard_check_lockup(struct irq_desc *desc)
> -{
> -	static unsigned long last;
> -	static int lockup;
> -
> -	/*
> -	 * If the timer interrupt has not run since the last million
> -	 * unrecognised expansion card interrupts, then there is
> -	 * something seriously wrong.  Disable the expansion card
> -	 * interrupts so at least we can continue.
> -	 *
> -	 * Maybe we ought to start a timer to re-enable them some time
> -	 * later?
> -	 */
> -	if (last == jiffies) {
> -		lockup += 1;
> -		if (lockup > 1000000) {
> -			printk(KERN_ERR "\nInterrupt lockup detected - "
> -			       "disabling all expansion card interrupts\n");
> -
> -			desc->irq_data.chip->irq_mask(&desc->irq_data);
> -			ecard_dump_irq_state();
> -		}
> -	} else
> -		lockup = 0;
> -
> -	/*
> -	 * If we did not recognise the source of this interrupt,
> -	 * warn the user, but don't flood the user with these messages.
> -	 */
> -	if (!last || time_after(jiffies, last + 5*HZ)) {
> -		last = jiffies;
> -		printk(KERN_WARNING "Unrecognised interrupt from backplane\n");
> -		ecard_dump_irq_state();
> -	}
> -}
> -
> -static void ecard_irq_handler(struct irq_desc *desc)
> -{
> -	ecard_t *ec;
> -	int called = 0;
> -
> -	desc->irq_data.chip->irq_mask(&desc->irq_data);
> -	for (ec = cards; ec; ec = ec->next) {
> -		int pending;
> -
> -		if (!ec->claimed || !ec->irq || ec->slot_no == 8)
> -			continue;
> -
> -		if (ec->ops && ec->ops->irqpending)
> -			pending = ec->ops->irqpending(ec);
> -		else
> -			pending = ecard_default_ops.irqpending(ec);
> -
> -		if (pending) {
> -			generic_handle_irq(ec->irq);
> -			called ++;
> -		}
> -	}
> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
> -
> -	if (called == 0)
> -		ecard_check_lockup(desc);
> -}
> -
> -static void __iomem *__ecard_address(ecard_t *ec, card_type_t type, card_speed_t speed)
> -{
> -	void __iomem *address = NULL;
> -	int slot = ec->slot_no;
> -
> -	if (ec->slot_no == 8)
> -		return ECARD_MEMC8_BASE;
> -
> -	ectcr &= ~(1 << slot);
> -
> -	switch (type) {
> -	case ECARD_MEMC:
> -		if (slot < 4)
> -			address = ECARD_MEMC_BASE + (slot << 14);
> -		break;
> -
> -	case ECARD_IOC:
> -		if (slot < 4)
> -			address = ECARD_IOC_BASE + (slot << 14);
> -		else
> -			address = ECARD_IOC4_BASE + ((slot - 4) << 14);
> -		if (address)
> -			address += speed << 19;
> -		break;
> -
> -	case ECARD_EASI:
> -		address = ECARD_EASI_BASE + (slot << 24);
> -		if (speed == ECARD_FAST)
> -			ectcr |= 1 << slot;
> -		break;
> -
> -	default:
> -		break;
> -	}
> -
> -#ifdef IOMD_ECTCR
> -	iomd_writeb(ectcr, IOMD_ECTCR);
> -#endif
> -	return address;
> -}
> -
> -static int ecard_prints(struct seq_file *m, ecard_t *ec)
> -{
> -	seq_printf(m, "  %d: %s ", ec->slot_no, ec->easi ? "EASI" : "    ");
> -
> -	if (ec->cid.id == 0) {
> -		struct in_chunk_dir incd;
> -
> -		seq_printf(m, "[%04X:%04X] ",
> -			ec->cid.manufacturer, ec->cid.product);
> -
> -		if (!ec->card_desc && ec->cid.cd &&
> -		    ecard_readchunk(&incd, ec, 0xf5, 0)) {
> -			ec->card_desc = kmalloc(strlen(incd.d.string)+1, GFP_KERNEL);
> -
> -			if (ec->card_desc)
> -				strcpy((char *)ec->card_desc, incd.d.string);
> -		}
> -
> -		seq_printf(m, "%s\n", ec->card_desc ? ec->card_desc : "*unknown*");
> -	} else
> -		seq_printf(m, "Simple card %d\n", ec->cid.id);
> -
> -	return 0;
> -}
> -
> -static int ecard_devices_proc_show(struct seq_file *m, void *v)
> -{
> -	ecard_t *ec = cards;
> -
> -	while (ec) {
> -		ecard_prints(m, ec);
> -		ec = ec->next;
> -	}
> -	return 0;
> -}
> -
> -static struct proc_dir_entry *proc_bus_ecard_dir = NULL;
> -
> -static void ecard_proc_init(void)
> -{
> -	proc_bus_ecard_dir = proc_mkdir("bus/ecard", NULL);
> -	proc_create_single("devices", 0, proc_bus_ecard_dir,
> -			ecard_devices_proc_show);
> -}
> -
> -#define ec_set_resource(ec,nr,st,sz)				\
> -	do {							\
> -		(ec)->resource[nr].name = dev_name(&ec->dev);	\
> -		(ec)->resource[nr].start = st;			\
> -		(ec)->resource[nr].end = (st) + (sz) - 1;	\
> -		(ec)->resource[nr].flags = IORESOURCE_MEM;	\
> -	} while (0)
> -
> -static void __init ecard_free_card(struct expansion_card *ec)
> -{
> -	int i;
> -
> -	for (i = 0; i < ECARD_NUM_RESOURCES; i++)
> -		if (ec->resource[i].flags)
> -			release_resource(&ec->resource[i]);
> -
> -	kfree(ec);
> -}
> -
> -static struct expansion_card *__init ecard_alloc_card(int type, int slot)
> -{
> -	struct expansion_card *ec;
> -	unsigned long base;
> -	int i;
> -
> -	ec = kzalloc_obj(ecard_t);
> -	if (!ec) {
> -		ec = ERR_PTR(-ENOMEM);
> -		goto nomem;
> -	}
> -
> -	ec->slot_no = slot;
> -	ec->easi = type == ECARD_EASI;
> -	ec->irq = 0;
> -	ec->fiq = 0;
> -	ec->dma = NO_DMA;
> -	ec->ops = &ecard_default_ops;
> -
> -	dev_set_name(&ec->dev, "ecard%d", slot);
> -	ec->dev.parent = NULL;
> -	ec->dev.bus = &ecard_bus_type;
> -	ec->dev.dma_mask = &ec->dma_mask;
> -	ec->dma_mask = (u64)0xffffffff;
> -	ec->dev.coherent_dma_mask = ec->dma_mask;
> -
> -	if (slot < 4) {
> -		ec_set_resource(ec, ECARD_RES_MEMC,
> -				PODSLOT_MEMC_BASE + (slot << 14),
> -				PODSLOT_MEMC_SIZE);
> -		base = PODSLOT_IOC0_BASE + (slot << 14);
> -	} else
> -		base = PODSLOT_IOC4_BASE + ((slot - 4) << 14);
> -
> -#ifdef CONFIG_ARCH_RPC
> -	if (slot < 8) {
> -		ec_set_resource(ec, ECARD_RES_EASI,
> -				PODSLOT_EASI_BASE + (slot << 24),
> -				PODSLOT_EASI_SIZE);
> -	}
> -
> -	if (slot == 8) {
> -		ec_set_resource(ec, ECARD_RES_MEMC, NETSLOT_BASE, NETSLOT_SIZE);
> -	} else
> -#endif
> -
> -	for (i = 0; i <= ECARD_RES_IOCSYNC - ECARD_RES_IOCSLOW; i++)
> -		ec_set_resource(ec, i + ECARD_RES_IOCSLOW,
> -				base + (i << 19), PODSLOT_IOC_SIZE);
> -
> -	for (i = 0; i < ECARD_NUM_RESOURCES; i++) {
> -		if (ec->resource[i].flags &&
> -		    request_resource(&iomem_resource, &ec->resource[i])) {
> -			dev_err(&ec->dev, "resource(s) not available\n");
> -			ec->resource[i].end -= ec->resource[i].start;
> -			ec->resource[i].start = 0;
> -			ec->resource[i].flags = 0;
> -		}
> -	}
> -
> - nomem:
> -	return ec;
> -}
> -
> -static ssize_t irq_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	return sprintf(buf, "%u\n", ec->irq);
> -}
> -static DEVICE_ATTR_RO(irq);
> -
> -static ssize_t dma_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	return sprintf(buf, "%u\n", ec->dma);
> -}
> -static DEVICE_ATTR_RO(dma);
> -
> -static ssize_t resource_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	char *str = buf;
> -	int i;
> -
> -	for (i = 0; i < ECARD_NUM_RESOURCES; i++)
> -		str += sprintf(str, "%08x %08x %08lx\n",
> -				ec->resource[i].start,
> -				ec->resource[i].end,
> -				ec->resource[i].flags);
> -
> -	return str - buf;
> -}
> -static DEVICE_ATTR_RO(resource);
> -
> -static ssize_t vendor_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	return sprintf(buf, "%u\n", ec->cid.manufacturer);
> -}
> -static DEVICE_ATTR_RO(vendor);
> -
> -static ssize_t device_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	return sprintf(buf, "%u\n", ec->cid.product);
> -}
> -static DEVICE_ATTR_RO(device);
> -
> -static ssize_t type_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	return sprintf(buf, "%s\n", ec->easi ? "EASI" : "IOC");
> -}
> -static DEVICE_ATTR_RO(type);
> -
> -static struct attribute *ecard_dev_attrs[] = {
> -	&dev_attr_device.attr,
> -	&dev_attr_dma.attr,
> -	&dev_attr_irq.attr,
> -	&dev_attr_resource.attr,
> -	&dev_attr_type.attr,
> -	&dev_attr_vendor.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(ecard_dev);
> -
> -int ecard_request_resources(struct expansion_card *ec)
> -{
> -	int i, err = 0;
> -
> -	for (i = 0; i < ECARD_NUM_RESOURCES; i++) {
> -		if (ecard_resource_end(ec, i) &&
> -		    !request_mem_region(ecard_resource_start(ec, i),
> -					ecard_resource_len(ec, i),
> -					ec->dev.driver->name)) {
> -			err = -EBUSY;
> -			break;
> -		}
> -	}
> -
> -	if (err) {
> -		while (i--)
> -			if (ecard_resource_end(ec, i))
> -				release_mem_region(ecard_resource_start(ec, i),
> -						   ecard_resource_len(ec, i));
> -	}
> -	return err;
> -}
> -EXPORT_SYMBOL(ecard_request_resources);
> -
> -void ecard_release_resources(struct expansion_card *ec)
> -{
> -	int i;
> -
> -	for (i = 0; i < ECARD_NUM_RESOURCES; i++)
> -		if (ecard_resource_end(ec, i))
> -			release_mem_region(ecard_resource_start(ec, i),
> -					   ecard_resource_len(ec, i));
> -}
> -EXPORT_SYMBOL(ecard_release_resources);
> -
> -void ecard_setirq(struct expansion_card *ec, const struct expansion_card_ops *ops, void *irq_data)
> -{
> -	ec->irq_data = irq_data;
> -	barrier();
> -	ec->ops = ops;
> -}
> -EXPORT_SYMBOL(ecard_setirq);
> -
> -void __iomem *ecardm_iomap(struct expansion_card *ec, unsigned int res,
> -			   unsigned long offset, unsigned long maxsize)
> -{
> -	unsigned long start = ecard_resource_start(ec, res);
> -	unsigned long end = ecard_resource_end(ec, res);
> -
> -	if (offset > (end - start))
> -		return NULL;
> -
> -	start += offset;
> -	if (maxsize && end - start > maxsize)
> -		end = start + maxsize;
> -	
> -	return devm_ioremap(&ec->dev, start, end - start);
> -}
> -EXPORT_SYMBOL(ecardm_iomap);
> -
> -static void atomwide_3p_quirk(ecard_t *ec)
> -{
> -	void __iomem *addr = __ecard_address(ec, ECARD_IOC, ECARD_SYNC);
> -	unsigned int i;
> -
> -	/* Disable interrupts on each port */
> -	for (i = 0x2000; i <= 0x2800; i += 0x0400)
> -		writeb(0, addr + i + 4);	
> -}
> -
> -/*
> - * Probe for an expansion card.
> - *
> - * If bit 1 of the first byte of the card is set, then the
> - * card does not exist.
> - */
> -static int __init ecard_probe(int slot, unsigned irq, card_type_t type)
> -{
> -	ecard_t **ecp;
> -	ecard_t *ec;
> -	struct ex_ecid cid;
> -	void __iomem *addr;
> -	int i, rc;
> -
> -	ec = ecard_alloc_card(type, slot);
> -	if (IS_ERR(ec)) {
> -		rc = PTR_ERR(ec);
> -		goto nomem;
> -	}
> -
> -	rc = -ENODEV;
> -	if ((addr = __ecard_address(ec, type, ECARD_SYNC)) == NULL)
> -		goto nodev;
> -
> -	cid.r_zero = 1;
> -	ecard_readbytes(&cid, ec, 0, 16, 0);
> -	if (cid.r_zero)
> -		goto nodev;
> -
> -	ec->cid.id	= cid.r_id;
> -	ec->cid.cd	= cid.r_cd;
> -	ec->cid.is	= cid.r_is;
> -	ec->cid.w	= cid.r_w;
> -	ec->cid.manufacturer = ecard_getu16(cid.r_manu);
> -	ec->cid.product = ecard_getu16(cid.r_prod);
> -	ec->cid.country = cid.r_country;
> -	ec->cid.irqmask = cid.r_irqmask;
> -	ec->cid.irqoff  = ecard_gets24(cid.r_irqoff);
> -	ec->cid.fiqmask = cid.r_fiqmask;
> -	ec->cid.fiqoff  = ecard_gets24(cid.r_fiqoff);
> -	ec->fiqaddr	=
> -	ec->irqaddr	= addr;
> -
> -	if (ec->cid.is) {
> -		ec->irqmask = ec->cid.irqmask;
> -		ec->irqaddr += ec->cid.irqoff;
> -		ec->fiqmask = ec->cid.fiqmask;
> -		ec->fiqaddr += ec->cid.fiqoff;
> -	} else {
> -		ec->irqmask = 1;
> -		ec->fiqmask = 4;
> -	}
> -
> -	for (i = 0; i < ARRAY_SIZE(quirklist); i++)
> -		if (quirklist[i].manufacturer == ec->cid.manufacturer &&
> -		    quirklist[i].product == ec->cid.product) {
> -			if (quirklist[i].type)
> -				ec->card_desc = quirklist[i].type;
> -			if (quirklist[i].init)
> -				quirklist[i].init(ec);
> -			break;
> -		}
> -
> -	ec->irq = irq;
> -
> -	/*
> -	 * hook the interrupt handlers
> -	 */
> -	if (slot < 8) {
> -		irq_set_chip_and_handler(ec->irq, &ecard_chip,
> -					 handle_level_irq);
> -		irq_set_chip_data(ec->irq, ec);
> -		irq_clear_status_flags(ec->irq, IRQ_NOREQUEST);
> -	}
> -
> -#ifdef CONFIG_ARCH_RPC
> -	/* On RiscPC, only first two slots have DMA capability */
> -	if (slot < 2)
> -		ec->dma = 2 + slot;
> -#endif
> -
> -	for (ecp = &cards; *ecp; ecp = &(*ecp)->next);
> -
> -	*ecp = ec;
> -	slot_to_expcard[slot] = ec;
> -
> -	rc = device_register(&ec->dev);
> -	if (rc)
> -		goto nodev;
> -
> -	return 0;
> -
> - nodev:
> -	ecard_free_card(ec);
> - nomem:
> -	return rc;
> -}
> -
> -/*
> - * Initialise the expansion card system.
> - * Locate all hardware - interrupt management and
> - * actual cards.
> - */
> -static int __init ecard_init(void)
> -{
> -	struct task_struct *task;
> -	int slot, irqbase;
> -
> -	irqbase = irq_alloc_descs(-1, 0, 8, -1);
> -	if (irqbase < 0)
> -		return irqbase;
> -
> -	task = kthread_run(ecard_task, NULL, "kecardd");
> -	if (IS_ERR(task)) {
> -		printk(KERN_ERR "Ecard: unable to create kernel thread: %ld\n",
> -		       PTR_ERR(task));
> -		irq_free_descs(irqbase, 8);
> -		return PTR_ERR(task);
> -	}
> -
> -	printk("Probing expansion cards\n");
> -
> -	for (slot = 0; slot < 8; slot ++) {
> -		if (ecard_probe(slot, irqbase + slot, ECARD_EASI) == -ENODEV)
> -			ecard_probe(slot, irqbase + slot, ECARD_IOC);
> -	}
> -
> -	ecard_probe(8, 11, ECARD_IOC);
> -
> -	irq_set_chained_handler(IRQ_EXPANSIONCARD, ecard_irq_handler);
> -
> -	ecard_proc_init();
> -
> -	return 0;
> -}
> -
> -subsys_initcall(ecard_init);
> -
> -/*
> - *	ECARD "bus"
> - */
> -static const struct ecard_id *
> -ecard_match_device(const struct ecard_id *ids, struct expansion_card *ec)
> -{
> -	int i;
> -
> -	for (i = 0; ids[i].manufacturer != 65535; i++)
> -		if (ec->cid.manufacturer == ids[i].manufacturer &&
> -		    ec->cid.product == ids[i].product)
> -			return ids + i;
> -
> -	return NULL;
> -}
> -
> -static int ecard_drv_probe(struct device *dev)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	struct ecard_driver *drv = ECARD_DRV(dev->driver);
> -	const struct ecard_id *id;
> -	int ret;
> -
> -	id = ecard_match_device(drv->id_table, ec);
> -
> -	ec->claimed = 1;
> -	ret = drv->probe(ec, id);
> -	if (ret)
> -		ec->claimed = 0;
> -	return ret;
> -}
> -
> -static void ecard_drv_remove(struct device *dev)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	struct ecard_driver *drv = ECARD_DRV(dev->driver);
> -
> -	drv->remove(ec);
> -	ec->claimed = 0;
> -
> -	/*
> -	 * Restore the default operations.  We ensure that the
> -	 * ops are set before we change the data.
> -	 */
> -	ec->ops = &ecard_default_ops;
> -	barrier();
> -	ec->irq_data = NULL;
> -}
> -
> -/*
> - * Before rebooting, we must make sure that the expansion card is in a
> - * sensible state, so it can be re-detected.  This means that the first
> - * page of the ROM must be visible.  We call the expansion cards reset
> - * handler, if any.
> - */
> -static void ecard_drv_shutdown(struct device *dev)
> -{
> -	struct expansion_card *ec = ECARD_DEV(dev);
> -	struct ecard_driver *drv = ECARD_DRV(dev->driver);
> -	struct ecard_request req;
> -
> -	if (dev->driver) {
> -		if (drv->shutdown)
> -			drv->shutdown(ec);
> -		ec->claimed = 0;
> -	}
> -
> -	/*
> -	 * If this card has a loader, call the reset handler.
> -	 */
> -	if (ec->loader) {
> -		req.fn = ecard_task_reset;
> -		req.ec = ec;
> -		ecard_call(&req);
> -	}
> -}
> -
> -int ecard_register_driver(struct ecard_driver *drv)
> -{
> -	drv->drv.bus = &ecard_bus_type;
> -
> -	return driver_register(&drv->drv);
> -}
> -
> -void ecard_remove_driver(struct ecard_driver *drv)
> -{
> -	driver_unregister(&drv->drv);
> -}
> -
> -static int ecard_match(struct device *_dev, const struct device_driver *_drv)
> -{
> -	struct expansion_card *ec = ECARD_DEV(_dev);
> -	struct ecard_driver *drv = ECARD_DRV(_drv);
> -	int ret;
> -
> -	if (drv->id_table) {
> -		ret = ecard_match_device(drv->id_table, ec) != NULL;
> -	} else {
> -		ret = ec->cid.id == drv->id;
> -	}
> -
> -	return ret;
> -}
> -
> -const struct bus_type ecard_bus_type = {
> -	.name		= "ecard",
> -	.dev_groups	= ecard_dev_groups,
> -	.match		= ecard_match,
> -	.probe		= ecard_drv_probe,
> -	.remove		= ecard_drv_remove,
> -	.shutdown	= ecard_drv_shutdown,
> -};
> -
> -static int ecard_bus_init(void)
> -{
> -	return bus_register(&ecard_bus_type);
> -}
> -
> -postcore_initcall(ecard_bus_init);
> -
> -EXPORT_SYMBOL(ecard_readchunk);
> -EXPORT_SYMBOL(ecard_register_driver);
> -EXPORT_SYMBOL(ecard_remove_driver);
> -EXPORT_SYMBOL(ecard_bus_type);
> diff --git a/arch/arm/mach-rpc/ecard.h b/arch/arm/mach-rpc/ecard.h
> deleted file mode 100644
> index 873dd3d9f274..000000000000
> --- a/arch/arm/mach-rpc/ecard.h
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  ecard.h
> - *
> - *  Copyright 2007 Russell King
> - */
> -
> -/* Definitions internal to ecard.c - for it's use only!!
> - *
> - * External expansion card header as read from the card
> - */
> -struct ex_ecid {
> -	unsigned char	r_irq:1;
> -	unsigned char	r_zero:1;
> -	unsigned char	r_fiq:1;
> -	unsigned char	r_id:4;
> -	unsigned char	r_a:1;
> -
> -	unsigned char	r_cd:1;
> -	unsigned char	r_is:1;
> -	unsigned char	r_w:2;
> -	unsigned char	r_r1:4;
> -
> -	unsigned char	r_r2:8;
> -
> -	unsigned char	r_prod[2];
> -
> -	unsigned char	r_manu[2];
> -
> -	unsigned char	r_country;
> -
> -	unsigned char	r_fiqmask;
> -	unsigned char	r_fiqoff[3];
> -
> -	unsigned char	r_irqmask;
> -	unsigned char	r_irqoff[3];
> -};
> -
> -/*
> - * Chunk directory entry as read from the card
> - */
> -struct ex_chunk_dir {
> -	unsigned char r_id;
> -	unsigned char r_len[3];
> -	unsigned long r_start;
> -	union {
> -		char string[256];
> -		char data[1];
> -	} d;
> -#define c_id(x)		((x)->r_id)
> -#define c_len(x)	((x)->r_len[0]|((x)->r_len[1]<<8)|((x)->r_len[2]<<16))
> -#define c_start(x)	((x)->r_start)
> -};
> -
> -typedef enum ecard_type {		/* Cards address space		*/
> -	ECARD_IOC,
> -	ECARD_MEMC,
> -	ECARD_EASI
> -} card_type_t;
> -
> -typedef enum {				/* Speed for ECARD_IOC space	*/
> -	ECARD_SLOW	 = 0,
> -	ECARD_MEDIUM	 = 1,
> -	ECARD_FAST	 = 2,
> -	ECARD_SYNC	 = 3
> -} card_speed_t;
> diff --git a/arch/arm/mach-rpc/fiq.S b/arch/arm/mach-rpc/fiq.S
> deleted file mode 100644
> index 087bdf4bc093..000000000000
> --- a/arch/arm/mach-rpc/fiq.S
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <linux/linkage.h>
> -#include <asm/assembler.h>
> -#include <mach/hardware.h>
> -
> -	.equ	ioc_base_high, IOC_BASE & 0xff000000
> -	.equ	ioc_base_low, IOC_BASE & 0x00ff0000
> -
> -	.text
> -	.global	rpc_default_fiq_end
> -ENTRY(rpc_default_fiq_start)
> -	mov	r12, #ioc_base_high
> -	.if	ioc_base_low
> -	orr	r12, r12, #ioc_base_low
> -	.endif
> -	strb	r12, [r12, #0x38]	@ Disable FIQ register
> -	subs	pc, lr, #4
> -rpc_default_fiq_end:
> diff --git a/arch/arm/mach-rpc/floppydma.S b/arch/arm/mach-rpc/floppydma.S
> deleted file mode 100644
> index 6698b83050dc..000000000000
> --- a/arch/arm/mach-rpc/floppydma.S
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  linux/arch/arm/lib/floppydma.S
> - *
> - *  Copyright (C) 1995, 1996 Russell King
> - */
> -#include <linux/linkage.h>
> -#include <asm/assembler.h>
> -		.text
> -
> -		.global	floppy_fiqin_end
> -ENTRY(floppy_fiqin_start)
> -		subs	r9, r9, #1
> -		ldrbgt	r12, [r11, #-4]
> -		ldrble	r12, [r11], #0
> -		strb	r12, [r10], #1
> -		subs	pc, lr, #4
> -floppy_fiqin_end:
> -
> -		.global	floppy_fiqout_end
> -ENTRY(floppy_fiqout_start)
> -		subs	r9, r9, #1
> -		ldrbge	r12, [r10], #1
> -		movlt	r12, #0
> -		strble	r12, [r11], #0
> -		subsle	pc, lr, #4
> -		strb	r12, [r11, #-4]
> -		subs	pc, lr, #4
> -floppy_fiqout_end:
> diff --git a/arch/arm/mach-rpc/include/mach/acornfb.h b/arch/arm/mach-rpc/include/mach/acornfb.h
> deleted file mode 100644
> index 2bf18ab3d699..000000000000
> --- a/arch/arm/mach-rpc/include/mach/acornfb.h
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-rpc/include/mach/acornfb.h
> - *
> - *  Copyright (C) 1999 Russell King
> - *
> - *  AcornFB architecture specific code
> - */
> -
> -#define acornfb_bandwidth(var) ((var)->pixclock * 8 / (var)->bits_per_pixel)
> -
> -static inline int
> -acornfb_valid_pixrate(struct fb_var_screeninfo *var)
> -{
> -	u_long limit;
> -
> -	if (!var->pixclock)
> -		return 0;
> -
> -	/*
> -	 * Limits below are taken from RISC OS bandwidthlimit file
> -	 */
> -	if (current_par.using_vram) {
> -		if (current_par.vram_half_sam == 2048)
> -			limit = 6578;
> -		else
> -			limit = 13157;
> -	} else {
> -		limit = 26315;
> -	}
> -
> -	return acornfb_bandwidth(var) >= limit;
> -}
> -
> -/*
> - * Try to find the best PLL parameters for the pixel clock.
> - * This algorithm seems to give best predictable results,
> - * and produces the same values as detailed in the VIDC20
> - * data sheet.
> - */
> -static inline u_int
> -acornfb_vidc20_find_pll(u_int pixclk)
> -{
> -	u_int r, best_r = 2, best_v = 2;
> -	int best_d = 0x7fffffff;
> -
> -	for (r = 2; r <= 32; r++) {
> -		u_int rr, v, p;
> -		int d;
> -
> -		rr = 41667 * r;
> -
> -		v = (rr + pixclk / 2) / pixclk;
> -
> -		if (v > 32 || v < 2)
> -			continue;
> -
> -		p = (rr + v / 2) / v;
> -
> -		d = pixclk - p;
> -
> -		if (d < 0)
> -			d = -d;
> -
> -		if (d < best_d) {
> -			best_d = d;
> -			best_v = v - 1;
> -			best_r = r - 1;
> -		}
> -
> -		if (d == 0)
> -			break;
> -	}
> -
> -	return best_v << 8 | best_r;
> -}
> -
> -static inline void
> -acornfb_vidc20_find_rates(struct vidc_timing *vidc,
> -			  struct fb_var_screeninfo *var)
> -{
> -	u_int div;
> -
> -	/* Select pixel-clock divisor to keep PLL in range */
> -	div = var->pixclock / 9090; /*9921*/
> -
> -	/* Limit divisor */
> -	if (div == 0)
> -		div = 1;
> -	if (div > 8)
> -		div = 8;
> -
> -	/* Encode divisor to VIDC20 setting */
> -	switch (div) {
> -	case 1:	vidc->control |= VIDC20_CTRL_PIX_CK;  break;
> -	case 2:	vidc->control |= VIDC20_CTRL_PIX_CK2; break;
> -	case 3:	vidc->control |= VIDC20_CTRL_PIX_CK3; break;
> -	case 4:	vidc->control |= VIDC20_CTRL_PIX_CK4; break;
> -	case 5:	vidc->control |= VIDC20_CTRL_PIX_CK5; break;
> -	case 6:	vidc->control |= VIDC20_CTRL_PIX_CK6; break;
> -	case 7:	vidc->control |= VIDC20_CTRL_PIX_CK7; break;
> -	case 8: vidc->control |= VIDC20_CTRL_PIX_CK8; break;
> -	}
> -
> -	/*
> -	 * With VRAM, the FIFO can be set to the highest possible setting
> -	 * because there are no latency considerations for other memory
> -	 * accesses. However, in 64 bit bus mode the FIFO preload value
> -	 * must not be set to VIDC20_CTRL_FIFO_28 because this will let
> -	 * the FIFO overflow. See VIDC20 manual page 33 (6.0 Setting the
> -	 * FIFO preload value).
> -	 */
> -	if (current_par.using_vram) {
> -		if (current_par.vram_half_sam == 2048)
> -			vidc->control |= VIDC20_CTRL_FIFO_24;
> -		else
> -			vidc->control |= VIDC20_CTRL_FIFO_28;
> -	} else {
> -		unsigned long bandwidth = acornfb_bandwidth(var);
> -
> -		/* Encode bandwidth as VIDC20 setting */
> -		if (bandwidth > 33334)		/* < 30.0MB/s */
> -			vidc->control |= VIDC20_CTRL_FIFO_16;
> -		else if (bandwidth > 26666)	/* < 37.5MB/s */
> -			vidc->control |= VIDC20_CTRL_FIFO_20;
> -		else if (bandwidth > 22222)	/* < 45.0MB/s */
> -			vidc->control |= VIDC20_CTRL_FIFO_24;
> -		else				/* > 45.0MB/s */
> -			vidc->control |= VIDC20_CTRL_FIFO_28;
> -	}
> -
> -	/* Find the PLL values */
> -	vidc->pll_ctl = acornfb_vidc20_find_pll(var->pixclock / div);
> -}
> -
> -#define acornfb_default_control()	(VIDC20_CTRL_PIX_VCLK)
> -#define acornfb_default_econtrol()	(VIDC20_ECTL_DAC | VIDC20_ECTL_REG(3))
> diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
> deleted file mode 100644
> index 6f197706f979..000000000000
> --- a/arch/arm/mach-rpc/include/mach/hardware.h
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-rpc/include/mach/hardware.h
> - *
> - *  Copyright (C) 1996-1999 Russell King.
> - *
> - *  This file contains the hardware definitions of the RiscPC series machines.
> - */
> -#ifndef __ASM_ARCH_HARDWARE_H
> -#define __ASM_ARCH_HARDWARE_H
> -
> -#include <mach/memory.h>
> -
> -/*
> - * What hardware must be present
> - */
> -#define HAS_IOMD
> -#define HAS_VIDC20
> -
> -/* Hardware addresses of major areas.
> - *  *_START is the physical address
> - *  *_SIZE  is the size of the region
> - *  *_BASE  is the virtual address
> - */
> -#define RPC_RAM_SIZE		0x10000000
> -#define RPC_RAM_START		0x10000000
> -
> -#define EASI_SIZE		0x08000000	/* EASI I/O */
> -#define EASI_START		0x08000000
> -#define EASI_BASE		IOMEM(0xe5000000)
> -
> -#define IO_START		0x03000000	/* I/O */
> -#define IO_SIZE			0x01000000
> -#define IO_BASE			IOMEM(0xe0000000)
> -
> -#define SCREEN_START		0x02000000	/* VRAM */
> -#define SCREEN_END		0xdfc00000
> -#define SCREEN_BASE		0xdf800000
> -
> -#define UNCACHEABLE_ADDR	(FLUSH_BASE + 0x10000)
> -
> -/*
> - * IO Addresses
> - */
> -#define ECARD_EASI_BASE		(EASI_BASE)
> -#define VIDC_BASE		(IO_BASE + 0x00400000)
> -#define EXPMASK_BASE		(IO_BASE + 0x00360000)
> -#define ECARD_IOC4_BASE		(IO_BASE + 0x00270000)
> -#define ECARD_IOC_BASE		(IO_BASE + 0x00240000)
> -#define IOMD_BASE		(IO_BASE + 0x00200000)
> -#define IOC_BASE		(IO_BASE + 0x00200000)
> -#define ECARD_MEMC8_BASE	(IO_BASE + 0x0002b000)
> -#define FLOPPYDMA_BASE		(IO_BASE + 0x0002a000)
> -#define PCIO_BASE		(IO_BASE + 0x00010000)
> -#define ECARD_MEMC_BASE		(IO_BASE + 0x00000000)
> -
> -#define vidc_writel(val)	__raw_writel(val, VIDC_BASE)
> -
> -#define NETSLOT_BASE		0x0302b000
> -#define NETSLOT_SIZE		0x00001000
> -
> -#define PODSLOT_IOC0_BASE	0x03240000
> -#define PODSLOT_IOC4_BASE	0x03270000
> -#define PODSLOT_IOC_SIZE	(1 << 14)
> -#define PODSLOT_MEMC_BASE	0x03000000
> -#define PODSLOT_MEMC_SIZE	(1 << 14)
> -#define PODSLOT_EASI_BASE	0x08000000
> -#define PODSLOT_EASI_SIZE	(1 << 24)
> -
> -#define	EXPMASK_STATUS		(EXPMASK_BASE + 0x00)
> -#define EXPMASK_ENABLE		(EXPMASK_BASE + 0x04)
> -
> -#endif
> diff --git a/arch/arm/mach-rpc/include/mach/io.h b/arch/arm/mach-rpc/include/mach/io.h
> deleted file mode 100644
> index 8a8f28406691..000000000000
> --- a/arch/arm/mach-rpc/include/mach/io.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-rpc/include/mach/io.h
> - *
> - *  Copyright (C) 1997 Russell King
> - *
> - * Modifications:
> - *  06-Dec-1997	RMK	Created.
> - */
> -#ifndef __ASM_ARM_ARCH_IO_H
> -#define __ASM_ARM_ARCH_IO_H
> -
> -#include <mach/hardware.h>
> -
> -#define IO_SPACE_LIMIT 0xffff
> -
> -/*
> - * We need PC style IO addressing for:
> - *  - floppy (at 0x3f2,0x3f4,0x3f5,0x3f7)
> - *  - parport (at 0x278-0x27a, 0x27b-0x27f, 0x778-0x77a)
> - *  - 8250 serial (only for compile)
> - *
> - * These peripherals are found in an area of MMIO which looks very much
> - * like an ISA bus, but with registers at the low byte of each word.
> - */
> -#define __io(a)		(PCIO_BASE + ((a) << 2))
> -
> -#endif
> diff --git a/arch/arm/mach-rpc/include/mach/irqs.h b/arch/arm/mach-rpc/include/mach/irqs.h
> deleted file mode 100644
> index 0c3428fd9729..000000000000
> --- a/arch/arm/mach-rpc/include/mach/irqs.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-rpc/include/mach/irqs.h
> - *
> - *  Copyright (C) 1996 Russell King
> - */
> -
> -#define IRQ_PRINTER		0
> -#define IRQ_BATLOW		1
> -#define IRQ_FLOPPYINDEX		2
> -#define IRQ_VSYNCPULSE		3
> -#define IRQ_POWERON		4
> -#define IRQ_TIMER0		5
> -#define IRQ_TIMER1		6
> -#define IRQ_IMMEDIATE		7
> -#define IRQ_EXPCARDFIQ		8
> -#define IRQ_HARDDISK		9
> -#define IRQ_SERIALPORT		10
> -#define IRQ_FLOPPYDISK		12
> -#define IRQ_EXPANSIONCARD	13
> -#define IRQ_KEYBOARDTX		14
> -#define IRQ_KEYBOARDRX		15
> -
> -#define IRQ_DMA0		16
> -#define IRQ_DMA1		17
> -#define IRQ_DMA2		18
> -#define IRQ_DMA3		19
> -#define IRQ_DMAS0		20
> -#define IRQ_DMAS1		21
> -
> -#define FIQ_FLOPPYDATA		0
> -#define FIQ_ECONET		2
> -#define FIQ_SERIALPORT		4
> -#define FIQ_EXPANSIONCARD	6
> -#define FIQ_FORCE		7
> -
> -/*
> - * This is the offset of the FIQ "IRQ" numbers
> - */
> -#define FIQ_START		64
> -
> -#define NR_IRQS			128
> diff --git a/arch/arm/mach-rpc/include/mach/isa-dma.h b/arch/arm/mach-rpc/include/mach/isa-dma.h
> deleted file mode 100644
> index d9c3af1ef718..000000000000
> --- a/arch/arm/mach-rpc/include/mach/isa-dma.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-rpc/include/mach/isa-dma.h
> - *
> - *  Copyright (C) 1997 Russell King
> - */
> -#ifndef __ASM_ARCH_DMA_H
> -#define __ASM_ARCH_DMA_H
> -
> -#define MAX_DMA_CHANNELS	8
> -
> -#define DMA_0			0
> -#define DMA_1			1
> -#define DMA_2			2
> -#define DMA_3			3
> -#define DMA_S0			4
> -#define DMA_S1			5
> -#define DMA_VIRTUAL_FLOPPY	6
> -#define DMA_VIRTUAL_SOUND	7
> -
> -#define DMA_FLOPPY		DMA_VIRTUAL_FLOPPY
> -
> -#define IOMD_DMA_BOUNDARY	(PAGE_SIZE - 1)
> -
> -#endif /* _ASM_ARCH_DMA_H */
> -
> diff --git a/arch/arm/mach-rpc/include/mach/memory.h b/arch/arm/mach-rpc/include/mach/memory.h
> deleted file mode 100644
> index a586eb31b18d..000000000000
> --- a/arch/arm/mach-rpc/include/mach/memory.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-rpc/include/mach/memory.h
> - *
> - *  Copyright (C) 1996,1997,1998 Russell King.
> - *
> - *  Changelog:
> - *   20-Oct-1996 RMK	Created
> - *   31-Dec-1997 RMK	Fixed definitions to reduce warnings
> - *   11-Jan-1998 RMK	Uninlined to reduce hits on cache
> - *   08-Feb-1998 RMK	Added __virt_to_bus and __bus_to_virt
> - *   21-Mar-1999 RMK	Renamed to memory.h
> - *		 RMK	Added TASK_SIZE and PAGE_OFFSET
> - */
> -#ifndef __ASM_ARCH_MEMORY_H
> -#define __ASM_ARCH_MEMORY_H
> -
> -/*
> - * Cache flushing area - ROM
> - */
> -#define FLUSH_BASE_PHYS		0x00000000
> -#define FLUSH_BASE		0xdf000000
> -
> -/*
> - * Sparsemem support.  Each section is a maximum of 64MB.  The sections
> - * are offset by 128MB and can cover 128MB, so that gives us a maximum
> - * of 29 physmem bits.
> - */
> -#define MAX_PHYSMEM_BITS	29
> -#define SECTION_SIZE_BITS	26
> -
> -#endif
> diff --git a/arch/arm/mach-rpc/include/mach/uncompress.h b/arch/arm/mach-rpc/include/mach/uncompress.h
> deleted file mode 100644
> index 1fbe7eb956fd..000000000000
> --- a/arch/arm/mach-rpc/include/mach/uncompress.h
> +++ /dev/null
> @@ -1,181 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  arch/arm/mach-rpc/include/mach/uncompress.h
> - *
> - *  Copyright (C) 1996 Russell King
> - */
> -#define VIDMEM ((char *)SCREEN_START)
> -
> -#include <linux/io.h>
> -#include <mach/hardware.h>
> -#include <asm/setup.h>
> -#include <asm/page.h>
> -
> -int video_size_row;
> -unsigned char bytes_per_char_h;
> -extern unsigned long con_charconvtable[256];
> -
> -struct param_struct {
> -	unsigned long page_size;
> -	unsigned long nr_pages;
> -	unsigned long ramdisk_size;
> -	unsigned long mountrootrdonly;
> -	unsigned long rootdev;
> -	unsigned long video_num_cols;
> -	unsigned long video_num_rows;
> -	unsigned long video_x;
> -	unsigned long video_y;
> -	unsigned long memc_control_reg;
> -	unsigned char sounddefault;
> -	unsigned char adfsdrives;
> -	unsigned char bytes_per_char_h;
> -	unsigned char bytes_per_char_v;
> -	unsigned long unused[256/4-11];
> -};
> -
> -static const unsigned long palette_4[16] = {
> -	0x00000000,
> -	0x000000cc,
> -	0x0000cc00,             /* Green   */
> -	0x0000cccc,             /* Yellow  */
> -	0x00cc0000,             /* Blue    */
> -	0x00cc00cc,             /* Magenta */
> -	0x00cccc00,             /* Cyan    */
> -	0x00cccccc,             /* White   */
> -	0x00000000,
> -	0x000000ff,
> -	0x0000ff00,
> -	0x0000ffff,
> -	0x00ff0000,
> -	0x00ff00ff,
> -	0x00ffff00,
> -	0x00ffffff
> -};
> -
> -#define palette_setpixel(p)	*(unsigned long *)(IO_START+0x00400000) = 0x10000000|((p) & 255)
> -#define palette_write(v)	*(unsigned long *)(IO_START+0x00400000) = 0x00000000|((v) & 0x00ffffff)
> -
> -/*
> - * params_phys is a linker defined symbol - see
> - * arch/arm/boot/compressed/Makefile
> - */
> -extern __attribute__((pure)) struct param_struct *params(void);
> -#define params (params())
> -
> -#ifndef STANDALONE_DEBUG
> -unsigned long video_num_cols;
> -unsigned long video_num_rows;
> -unsigned long video_x;
> -unsigned long video_y;
> -unsigned char bytes_per_char_v;
> -int white;
> -
> -/*
> - * This does not append a newline
> - */
> -static inline void putc(int c)
> -{
> -	extern void ll_write_char(char *, char c, char white);
> -	int x,y;
> -	char *ptr;
> -
> -	x = video_x;
> -	y = video_y;
> -
> -	if (c == '\n') {
> -		if (++y >= video_num_rows)
> -			y--;
> -	} else if (c == '\r') {
> -		x = 0;
> -	} else {
> -		ptr = VIDMEM + ((y*video_num_cols*bytes_per_char_v+x)*bytes_per_char_h);
> -		ll_write_char(ptr, c, white);
> -		if (++x >= video_num_cols) {
> -			x = 0;
> -			if ( ++y >= video_num_rows ) {
> -				y--;
> -			}
> -		}
> -	}
> -
> -	video_x = x;
> -	video_y = y;
> -}
> -
> -static inline void flush(void)
> -{
> -}
> -
> -/*
> - * Setup for decompression
> - */
> -static void arch_decomp_setup(void)
> -{
> -	int i;
> -	struct tag *t = (struct tag *)params;
> -	unsigned int nr_pages = 0, page_size = PAGE_SIZE;
> -
> -	if (t->hdr.tag == ATAG_CORE) {
> -		for (; t->hdr.size; t = tag_next(t)) {
> -			if (t->hdr.tag == ATAG_VIDEOTEXT) {
> -				video_num_rows = t->u.videotext.video_lines;
> -				video_num_cols = t->u.videotext.video_cols;
> -				video_x = t->u.videotext.x;
> -				video_y = t->u.videotext.y;
> -			} else if (t->hdr.tag == ATAG_VIDEOLFB) {
> -				bytes_per_char_h = t->u.videolfb.lfb_depth;
> -				bytes_per_char_v = 8;
> -			} else if (t->hdr.tag == ATAG_MEM) {
> -				page_size = PAGE_SIZE;
> -				nr_pages += (t->u.mem.size / PAGE_SIZE);
> -			}
> -		}
> -	} else {
> -		nr_pages = params->nr_pages;
> -		page_size = params->page_size;
> -		video_num_rows = params->video_num_rows;
> -		video_num_cols = params->video_num_cols;
> -		video_x = params->video_x;
> -		video_y = params->video_y;
> -		bytes_per_char_h = params->bytes_per_char_h;
> -		bytes_per_char_v = params->bytes_per_char_v;
> -	}
> -
> -	video_size_row = video_num_cols * bytes_per_char_h;
> -	
> -	if (bytes_per_char_h == 4)
> -		for (i = 0; i < 256; i++)
> -			con_charconvtable[i] =
> -				(i & 128 ? 1 << 0  : 0) |
> -				(i & 64  ? 1 << 4  : 0) |
> -				(i & 32  ? 1 << 8  : 0) |
> -				(i & 16  ? 1 << 12 : 0) |
> -				(i & 8   ? 1 << 16 : 0) |
> -				(i & 4   ? 1 << 20 : 0) |
> -				(i & 2   ? 1 << 24 : 0) |
> -				(i & 1   ? 1 << 28 : 0);
> -	else
> -		for (i = 0; i < 16; i++)
> -			con_charconvtable[i] =
> -				(i & 8   ? 1 << 0  : 0) |
> -				(i & 4   ? 1 << 8  : 0) |
> -				(i & 2   ? 1 << 16 : 0) |
> -				(i & 1   ? 1 << 24 : 0);
> -
> -
> -	palette_setpixel(0);
> -	if (bytes_per_char_h == 1) {
> -		palette_write (0);
> -		palette_write (0x00ffffff);
> -		for (i = 2; i < 256; i++)
> -			palette_write (0);
> -		white = 1;
> -	} else {
> -		for (i = 0; i < 256; i++)
> -			palette_write (i < 16 ? palette_4[i] : 0);
> -		white = 7;
> -	}
> -
> -	if (nr_pages * page_size < 4096*1024) error("<4M of mem\n");
> -}
> -#endif
> diff --git a/arch/arm/mach-rpc/io-acorn.S b/arch/arm/mach-rpc/io-acorn.S
> deleted file mode 100644
> index aa9bf0d771c0..000000000000
> --- a/arch/arm/mach-rpc/io-acorn.S
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  linux/arch/arm/lib/io-acorn.S
> - *
> - *  Copyright (C) 1995, 1996 Russell King
> - *
> - * 27/03/03 Ian Molton Clean up CONFIG_CPU
> - */
> -#include <linux/linkage.h>
> -#include <linux/kern_levels.h>
> -#include <asm/assembler.h>
> -
> -		.text
> -		.align
> -
> -.Liosl_warning:
> -		.ascii	KERN_WARNING "insl/outsl not implemented, called from %08lX\0"
> -		.align
> -
> -/*
> - * These make no sense on Acorn machines.
> - * Print a warning message.
> - */
> -ENTRY(insl)
> -ENTRY(outsl)
> -		adr	r0, .Liosl_warning
> -		mov	r1, lr
> -		b	_printk
> diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
> deleted file mode 100644
> index dc29384b6ef8..000000000000
> --- a/arch/arm/mach-rpc/irq.c
> +++ /dev/null
> @@ -1,226 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/init.h>
> -#include <linux/list.h>
> -#include <linux/io.h>
> -
> -#include <asm/mach/irq.h>
> -#include <asm/hardware/iomd.h>
> -#include <asm/irq.h>
> -#include <asm/fiq.h>
> -
> -// These are offsets from the stat register for each IRQ bank
> -#define STAT	0x00
> -#define REQ	0x04
> -#define CLR	0x04
> -#define MASK	0x08
> -
> -static const u8 irq_prio_h[256] = {
> -	 0, 8, 9, 8,10,10,10,10,11,11,11,11,10,10,10,10,
> -	12, 8, 9, 8,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -	14,14,14,14,10,10,10,10,11,11,11,11,10,10,10,10,
> -	14,14,14,14,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
> -	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
> -	15,15,15,15,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -	13,13,13,13,10,10,10,10,11,11,11,11,10,10,10,10,
> -};
> -
> -static const u8 irq_prio_d[256] = {
> -	 0,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	20,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	23,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	23,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	22,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -	21,16,17,16,18,16,17,16,19,16,17,16,18,16,17,16,
> -};
> -
> -static const u8 irq_prio_l[256] = {
> -	 0, 0, 1, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
> -	 4, 0, 1, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
> -	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
> -	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
> -	 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 3, 3, 3, 3, 3,
> -	 6, 6, 6, 6, 6, 6, 6, 6, 3, 3, 3, 3, 3, 3, 3, 3,
> -	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
> -	 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -	 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
> -};
> -
> -static int iomd_get_irq_nr(void)
> -{
> -	int irq;
> -	u8 reg;
> -
> -	/* get highest priority first */
> -	reg = readb(IOC_BASE + IOMD_IRQREQB);
> -	irq = irq_prio_h[reg];
> -	if (irq)
> -		return irq;
> -
> -	/* get DMA  */
> -	reg = readb(IOC_BASE + IOMD_DMAREQ);
> -	irq = irq_prio_d[reg];
> -	if (irq)
> -		return irq;
> -
> -	/* get low priority */
> -	reg = readb(IOC_BASE + IOMD_IRQREQA);
> -	irq = irq_prio_l[reg];
> -	if (irq)
> -		return irq;
> -	return 0;
> -}
> -
> -static void iomd_handle_irq(struct pt_regs *regs)
> -{
> -	int irq;
> -
> -	do {
> -		irq = iomd_get_irq_nr();
> -		if (irq)
> -			generic_handle_irq(irq);
> -	} while (irq);
> -}
> -
> -static void __iomem *iomd_get_base(struct irq_data *d)
> -{
> -	void *cd = irq_data_get_irq_chip_data(d);
> -
> -	return (void __iomem *)(unsigned long)cd;
> -}
> -
> -static void iomd_set_base_mask(unsigned int irq, void __iomem *base, u32 mask)
> -{
> -	struct irq_data *d = irq_get_irq_data(irq);
> -
> -	d->mask = mask;
> -	irq_set_chip_data(irq, (void *)(unsigned long)base);
> -}
> -
> -static void iomd_irq_mask_ack(struct irq_data *d)
> -{
> -	void __iomem *base = iomd_get_base(d);
> -	unsigned int val, mask = d->mask;
> -
> -	val = readb(base + MASK);
> -	writeb(val & ~mask, base + MASK);
> -	writeb(mask, base + CLR);
> -}
> -
> -static void iomd_irq_mask(struct irq_data *d)
> -{
> -	void __iomem *base = iomd_get_base(d);
> -	unsigned int val, mask = d->mask;
> -
> -	val = readb(base + MASK);
> -	writeb(val & ~mask, base + MASK);
> -}
> -
> -static void iomd_irq_unmask(struct irq_data *d)
> -{
> -	void __iomem *base = iomd_get_base(d);
> -	unsigned int val, mask = d->mask;
> -
> -	val = readb(base + MASK);
> -	writeb(val | mask, base + MASK);
> -}
> -
> -static struct irq_chip iomd_chip_clr = {
> -	.irq_mask_ack	= iomd_irq_mask_ack,
> -	.irq_mask	= iomd_irq_mask,
> -	.irq_unmask	= iomd_irq_unmask,
> -};
> -
> -static struct irq_chip iomd_chip_noclr = {
> -	.irq_mask	= iomd_irq_mask,
> -	.irq_unmask	= iomd_irq_unmask,
> -};
> -
> -extern unsigned char rpc_default_fiq_start, rpc_default_fiq_end;
> -
> -void __init rpc_init_irq(void)
> -{
> -	unsigned int irq, clr, set;
> -
> -	iomd_writeb(0, IOMD_IRQMASKA);
> -	iomd_writeb(0, IOMD_IRQMASKB);
> -	iomd_writeb(0, IOMD_FIQMASK);
> -	iomd_writeb(0, IOMD_DMAMASK);
> -
> -	set_fiq_handler(&rpc_default_fiq_start,
> -		&rpc_default_fiq_end - &rpc_default_fiq_start);
> -
> -	set_handle_irq(iomd_handle_irq);
> -
> -	for (irq = 0; irq < NR_IRQS; irq++) {
> -		clr = IRQ_NOREQUEST;
> -		set = 0;
> -
> -		if (irq <= 6 || (irq >= 9 && irq <= 15))
> -			clr |= IRQ_NOPROBE;
> -
> -		if (irq == 21 || (irq >= 16 && irq <= 19) ||
> -		    irq == IRQ_KEYBOARDTX)
> -			set |= IRQ_NOAUTOEN;
> -
> -		switch (irq) {
> -		case 0 ... 7:
> -			irq_set_chip_and_handler(irq, &iomd_chip_clr,
> -						 handle_level_irq);
> -			irq_modify_status(irq, clr, set);
> -			iomd_set_base_mask(irq, IOMD_BASE + IOMD_IRQSTATA,
> -					   BIT(irq));
> -			break;
> -
> -		case 8 ... 15:
> -			irq_set_chip_and_handler(irq, &iomd_chip_noclr,
> -						 handle_level_irq);
> -			irq_modify_status(irq, clr, set);
> -			iomd_set_base_mask(irq, IOMD_BASE + IOMD_IRQSTATB,
> -					   BIT(irq - 8));
> -			break;
> -
> -		case 16 ... 21:
> -			irq_set_chip_and_handler(irq, &iomd_chip_noclr,
> -						 handle_level_irq);
> -			irq_modify_status(irq, clr, set);
> -			iomd_set_base_mask(irq, IOMD_BASE + IOMD_DMASTAT,
> -					   BIT(irq - 16));
> -			break;
> -
> -		case 64 ... 71:
> -			irq_set_chip(irq, &iomd_chip_noclr);
> -			irq_modify_status(irq, clr, set);
> -			iomd_set_base_mask(irq, IOMD_BASE + IOMD_FIQSTAT,
> -					   BIT(irq - 64));
> -			break;
> -		}
> -	}
> -
> -	init_FIQ(FIQ_START);
> -}
> diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
> deleted file mode 100644
> index f70fb9c4b0cb..000000000000
> --- a/arch/arm/mach-rpc/riscpc.c
> +++ /dev/null
> @@ -1,225 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/arch/arm/mach-rpc/riscpc.c
> - *
> - *  Copyright (C) 1998-2001 Russell King
> - *
> - *  Architecture specific fixups.
> - */
> -#include <linux/kernel.h>
> -#include <linux/tty.h>
> -#include <linux/delay.h>
> -#include <linux/pm.h>
> -#include <linux/init.h>
> -#include <linux/sched.h>
> -#include <linux/device.h>
> -#include <linux/serial_8250.h>
> -#include <linux/ata_platform.h>
> -#include <linux/io.h>
> -#include <linux/i2c.h>
> -#include <linux/reboot.h>
> -
> -#include <asm/elf.h>
> -#include <asm/mach-types.h>
> -#include <mach/hardware.h>
> -#include <asm/hardware/iomd.h>
> -#include <asm/page.h>
> -#include <asm/domain.h>
> -#include <asm/setup.h>
> -#include <asm/system_misc.h>
> -
> -#include <asm/mach/map.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/time.h>
> -
> -extern void rpc_init_irq(void);
> -
> -unsigned int vram_size;
> -unsigned int memc_ctrl_reg;
> -unsigned int number_mfm_drives;
> -
> -static int __init parse_tag_acorn(const struct tag *tag)
> -{
> -	memc_ctrl_reg = tag->u.acorn.memc_control_reg;
> -	number_mfm_drives = tag->u.acorn.adfsdrives;
> -
> -	switch (tag->u.acorn.vram_pages) {
> -	case 512:
> -		vram_size += PAGE_SIZE * 256;
> -		fallthrough;	/* ??? */
> -	case 256:
> -		vram_size += PAGE_SIZE * 256;
> -		break;
> -	default:
> -		break;
> -	}
> -#if 0
> -	if (vram_size) {
> -		desc->video_start = 0x02000000;
> -		desc->video_end   = 0x02000000 + vram_size;
> -	}
> -#endif
> -	return 0;
> -}
> -
> -__tagtable(ATAG_ACORN, parse_tag_acorn);
> -
> -static struct map_desc rpc_io_desc[] __initdata = {
> - 	{	/* VRAM		*/
> -		.virtual	=  SCREEN_BASE,
> -		.pfn		= __phys_to_pfn(SCREEN_START),
> -		.length		= 	2*1048576,
> -		.type		= MT_DEVICE
> -	}, {	/* IO space	*/
> -		.virtual	=  (u32)IO_BASE,
> -		.pfn		= __phys_to_pfn(IO_START),
> -		.length		= 	IO_SIZE	 ,
> -		.type		= MT_DEVICE
> -	}, {	/* EASI space	*/
> -		.virtual	= (unsigned long)EASI_BASE,
> -		.pfn		= __phys_to_pfn(EASI_START),
> -		.length		= EASI_SIZE,
> -		.type		= MT_DEVICE
> -	}
> -};
> -
> -static void __init rpc_map_io(void)
> -{
> -	iotable_init(rpc_io_desc, ARRAY_SIZE(rpc_io_desc));
> -
> -	/*
> -	 * Turn off floppy.
> -	 */
> -	writeb(0xc, PCIO_BASE + (0x3f2 << 2));
> -
> -	/*
> -	 * RiscPC can't handle half-word loads and stores
> -	 */
> -	elf_hwcap &= ~HWCAP_HALF;
> -}
> -
> -static struct resource acornfb_resources[] = {
> -	/* VIDC */
> -	DEFINE_RES_MEM(0x03400000, 0x00200000),
> -	DEFINE_RES_IRQ(IRQ_VSYNCPULSE),
> -};
> -
> -static struct platform_device acornfb_device = {
> -	.name			= "acornfb",
> -	.id			= -1,
> -	.dev			= {
> -		.coherent_dma_mask = 0xffffffff,
> -	},
> -	.num_resources		= ARRAY_SIZE(acornfb_resources),
> -	.resource		= acornfb_resources,
> -};
> -
> -static struct resource iomd_resources[] = {
> -	DEFINE_RES_MEM(0x03200000, 0x10000),
> -};
> -
> -static struct platform_device iomd_device = {
> -	.name			= "iomd",
> -	.id			= -1,
> -	.num_resources		= ARRAY_SIZE(iomd_resources),
> -	.resource		= iomd_resources,
> -};
> -
> -static struct resource iomd_kart_resources[] = {
> -	DEFINE_RES_IRQ(IRQ_KEYBOARDRX),
> -	DEFINE_RES_IRQ(IRQ_KEYBOARDTX),
> -};
> -
> -static struct platform_device kbd_device = {
> -	.name			= "kart",
> -	.id			= -1,
> -	.dev			= {
> -		.parent 	= &iomd_device.dev,
> -	},
> -	.num_resources		= ARRAY_SIZE(iomd_kart_resources),
> -	.resource		= iomd_kart_resources,
> -};
> -
> -static struct plat_serial8250_port serial_platform_data[] = {
> -	{
> -		.mapbase	= 0x03010fe0,
> -		.irq		= IRQ_SERIALPORT,
> -		.uartclk	= 1843200,
> -		.regshift	= 2,
> -		.iotype		= UPIO_MEM,
> -		.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_SKIP_TEST,
> -	},
> -	{ },
> -};
> -
> -static struct platform_device serial_device = {
> -	.name			= "serial8250",
> -	.id			= PLAT8250_DEV_PLATFORM,
> -	.dev			= {
> -		.platform_data	= serial_platform_data,
> -	},
> -};
> -
> -static struct pata_platform_info pata_platform_data = {
> -	.ioport_shift		= 2,
> -};
> -
> -static struct resource pata_resources[] = {
> -	DEFINE_RES_MEM(0x030107c0, 0x20),
> -	DEFINE_RES_MEM(0x03010fd8, 0x04),
> -	DEFINE_RES_IRQ(IRQ_HARDDISK),
> -};
> -
> -static struct platform_device pata_device = {
> -	.name			= "pata_platform",
> -	.id			= -1,
> -	.num_resources		= ARRAY_SIZE(pata_resources),
> -	.resource		= pata_resources,
> -	.dev			= {
> -		.platform_data	= &pata_platform_data,
> -		.coherent_dma_mask = ~0,	/* grumble */
> -	},
> -};
> -
> -static struct platform_device *devs[] __initdata = {
> -	&iomd_device,
> -	&kbd_device,
> -	&serial_device,
> -	&acornfb_device,
> -	&pata_device,
> -};
> -
> -static struct i2c_board_info i2c_rtc = {
> -	I2C_BOARD_INFO("pcf8583", 0x50)
> -};
> -
> -static int __init rpc_init(void)
> -{
> -	i2c_register_board_info(0, &i2c_rtc, 1);
> -	return platform_add_devices(devs, ARRAY_SIZE(devs));
> -}
> -
> -arch_initcall(rpc_init);
> -
> -static void rpc_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	iomd_writeb(0, IOMD_ROMCR0);
> -
> -	/*
> -	 * Jump into the ROM
> -	 */
> -	soft_restart(0);
> -}
> -
> -void ioc_timer_init(void);
> -
> -MACHINE_START(RISCPC, "Acorn-RiscPC")
> -	/* Maintainer: Russell King */
> -	.atag_offset	= 0x100,
> -	.reserve_lp0	= 1,
> -	.reserve_lp1	= 1,
> -	.map_io		= rpc_map_io,
> -	.init_irq	= rpc_init_irq,
> -	.init_time	= ioc_timer_init,
> -	.restart	= rpc_restart,
> -MACHINE_END
> diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
> deleted file mode 100644
> index 9f8edcfe9357..000000000000
> --- a/arch/arm/mach-rpc/time.c
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/arch/arm/common/time-acorn.c
> - *
> - *  Copyright (c) 1996-2000 Russell King.
> - *
> - *  Changelog:
> - *   24-Sep-1996	RMK	Created
> - *   10-Oct-1996	RMK	Brought up to date with arch-sa110eval
> - *   04-Dec-1997	RMK	Updated for new arch/arm/time.c
> - *   13=Jun-2004	DS	Moved to arch/arm/common b/c shared w/CLPS7500
> - */
> -#include <linux/clocksource.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/io.h>
> -
> -#include <mach/hardware.h>
> -#include <asm/hardware/ioc.h>
> -
> -#include <asm/mach/time.h>
> -
> -#define RPC_CLOCK_FREQ 2000000
> -#define RPC_LATCH DIV_ROUND_CLOSEST(RPC_CLOCK_FREQ, HZ)
> -
> -static u32 ioc_time;
> -
> -static u64 ioc_timer_read(struct clocksource *cs)
> -{
> -	unsigned int count1, count2, status;
> -	unsigned long flags;
> -	u32 ticks;
> -
> -	local_irq_save(flags);
> -	ioc_writeb (0, IOC_T0LATCH);
> -	barrier ();
> -	count1 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
> -	barrier ();
> -	status = ioc_readb(IOC_IRQREQA);
> -	barrier ();
> -	ioc_writeb (0, IOC_T0LATCH);
> -	barrier ();
> -	count2 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
> -	ticks = ioc_time + RPC_LATCH - count2;
> -	local_irq_restore(flags);
> -
> -	if (count2 < count1) {
> -		/*
> -		 * The timer has not reloaded between reading count1 and
> -		 * count2, check whether an interrupt was actually pending.
> -		 */
> -		if (status & (1 << 5))
> -			ticks += RPC_LATCH;
> -	} else if (count2 > count1) {
> -		/*
> -		 * The timer has reloaded, so count2 indicates the new
> -		 * count since the wrap.  The interrupt would not have
> -		 * been processed, so add the missed ticks.
> -		 */
> -		ticks += RPC_LATCH;
> -	}
> -
> -	return ticks;
> -}
> -
> -static struct clocksource ioctime_clocksource = {
> -	.read = ioc_timer_read,
> -	.mask = CLOCKSOURCE_MASK(32),
> -	.rating = 100,
> -};
> -
> -void __init ioctime_init(void)
> -{
> -	ioc_writeb(RPC_LATCH & 255, IOC_T0LTCHL);
> -	ioc_writeb(RPC_LATCH >> 8, IOC_T0LTCHH);
> -	ioc_writeb(0, IOC_T0GO);
> -}
> -
> -static irqreturn_t
> -ioc_timer_interrupt(int irq, void *dev_id)
> -{
> -	ioc_time += RPC_LATCH;
> -	legacy_timer_tick(1);
> -	return IRQ_HANDLED;
> -}
> -
> -/*
> - * Set up timer interrupt.
> - */
> -void __init ioc_timer_init(void)
> -{
> -	WARN_ON(clocksource_register_hz(&ioctime_clocksource, RPC_CLOCK_FREQ));
> -	ioctime_init();
> -	if (request_irq(IRQ_TIMER0, ioc_timer_interrupt, 0, "timer", NULL))
> -		pr_err("Failed to request irq %d (timer)\n", IRQ_TIMER0);
> -}
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 350f6dcc24cc..07c2fda4d422 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -1112,7 +1112,7 @@ static void __init fill_pmd_gaps(void)
>   #define fill_pmd_gaps() do { } while (0)
>   #endif
>   
> -#if defined(CONFIG_PCI) && !defined(CONFIG_NEED_MACH_IO_H)
> +#if defined(CONFIG_PCI)
>   static void __init pci_reserve_io(void)
>   {
>   	struct static_vm *svm;
> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
> index ce17e41451af..94e7df547e7a 100644
> --- a/block/partitions/Kconfig
> +++ b/block/partitions/Kconfig
> @@ -19,13 +19,11 @@ config PARTITION_ADVANCED
>   
>   config ACORN_PARTITION
>   	bool "Acorn partition support" if PARTITION_ADVANCED
> -	default y if ARCH_ACORN
>   	help
>   	  Support hard disks partitioned under Acorn operating systems.
>   
>   config ACORN_PARTITION_CUMANA
>   	bool "Cumana partition support" if PARTITION_ADVANCED
> -	default y if ARCH_ACORN
>   	depends on ACORN_PARTITION
>   	help
>   	  Say Y here if you would like to use hard disks under Linux which
> @@ -33,12 +31,10 @@ config ACORN_PARTITION_CUMANA
>   
>   config ACORN_PARTITION_EESOX
>   	bool "EESOX partition support" if PARTITION_ADVANCED
> -	default y if ARCH_ACORN
>   	depends on ACORN_PARTITION
>   
>   config ACORN_PARTITION_ICS
>   	bool "ICS partition support" if PARTITION_ADVANCED
> -	default y if ARCH_ACORN
>   	depends on ACORN_PARTITION
>   	help
>   	  Say Y here if you would like to use hard disks under Linux which
> @@ -46,7 +42,6 @@ config ACORN_PARTITION_ICS
>   
>   config ACORN_PARTITION_ADFS
>   	bool "Native filecore partition support" if PARTITION_ADVANCED
> -	default y if ARCH_ACORN
>   	depends on ACORN_PARTITION
>   	help
>   	  The Acorn Disc Filing System is the standard file system of the
> @@ -56,7 +51,6 @@ config ACORN_PARTITION_ADFS
>   
>   config ACORN_PARTITION_POWERTEC
>   	bool "PowerTec partition support" if PARTITION_ADVANCED
> -	default y if ARCH_ACORN
>   	depends on ACORN_PARTITION
>   	help
>   	  Support reading partition tables created on Acorn machines using
> @@ -64,7 +58,6 @@ config ACORN_PARTITION_POWERTEC
>   
>   config ACORN_PARTITION_RISCIX
>   	bool "RISCiX partition support" if PARTITION_ADVANCED
> -	default y if ARCH_ACORN
>   	depends on ACORN_PARTITION
>   	help
>   	  Once upon a time, there was a native Unix port for the Acorn series
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index c41d850b29c6..9770c83aea74 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -1308,7 +1308,7 @@ static void kbd_bh(struct tasklet_struct *unused)
>   #if defined(CONFIG_X86) || defined(CONFIG_ALPHA) ||\
>       defined(CONFIG_MIPS) || defined(CONFIG_PPC) || defined(CONFIG_SPARC) ||\
>       defined(CONFIG_PARISC) || defined(CONFIG_SUPERH) ||\
> -    (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD) && !defined(CONFIG_ARCH_RPC))
> +    (defined(CONFIG_ARM) && defined(CONFIG_KEYBOARD_ATKBD))
>   
>   static inline bool kbd_is_hw_raw(const struct input_dev *dev)
>   {
> diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
> index 4ff52c79f8c4..ec2b1e463ab9 100644
> --- a/lib/fonts/font_acorn_8x8.c
> +++ b/lib/fonts/font_acorn_8x8.c
> @@ -277,9 +277,5 @@ const struct font_desc font_acorn_8x8 = {
>   	.height	= 8,
>   	.charcount = 256,
>   	.data	= acorndata_8x8.data,
> -#ifdef CONFIG_ARCH_ACORN
> -	.pref	= 20,
> -#else
>   	.pref	= 0,
> -#endif
>   };

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


