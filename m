Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA543B71C4;
	Wed,  9 Sep 2026 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984668; cv=none; b=WzrUxBKmk7TbKIYly9K/dSU/qhB1YA/o4OoqN27BXxESsJbQU3PQE1h8eQZZsNkeA9e+FMTvsBiX0OpBtZHwKyddGMRmb9Dr9MY2x/zZj9Fbq/OKYEqqelVDM98mgnzgd7dyXOTKOehSoEy2G6rfaZbFqRh+GBsvxMh89jpVxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984668; c=relaxed/simple;
	bh=5HoG3honV/sojWC8vPCS1yQeOGAMvOh2ZbyOcHFktnc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X1pDXokmrpGEEtnOz2VqRfmxI/G0F9OcP4z7z+OWl2utvwtl3ImNTaI3wP/1qdNtwRbsYIh+Yw8mM3rPXFXKYzbGR/UE1308Mdw/eBjIjzmyGJlN0mAMILk4tPy37XVpPCiZUSQ2cDCt3/wtocSY5L1lDG6MJsiPs/i1Jw87LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOzG7z/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOzG7z/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75471F000FF;
	Wed,  9 Sep 2026 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984656;
	bh=dMpeLqTNXDRpS+r+jORTF862uDqb/CqEpFeuPMT9TQY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MOzG7z/WitVOZzXnEIONfv6+fQIabeSSDolWC+rNYrS7Vlwwk1vfEtfYArR3h+6AW
	 BkZjdwcm4wildy8SICewrTrtCKgy1b/k3oor33cNi+NQUhi9t08L42AuUSej2fEUqe
	 qfny4KDHxbZ/xJqwFiumW+2xXGFO5NTmGmjFJsK/R3ZPuIR60+kApLxdoET5/gH2iE
	 rWbH4vbeQZu2OBM+F5Ue964Xfcvu1u56EKpW7dmEAVwazFnXO1VEyiFIhPc6gnzFQs
	 PkgWE1RX2sqolRE0Bgev0hvDTVbQb+YwwFjRG96UwvW36lXSDQI2HmKP52zMD7Vv7T
	 Lhkf7318C1Mlw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 48EF31980052;
	Wed,  9 Sep 2026 16:10:53 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:10:53 -0400
X-ME-Sender: <xms:Sr2hajWlva4lVEbm2EzQ1s3udRWO4ikQFFFPxDegsKQ3CTjZB3r-uA>
    <xme:Sr2hambJl-c3e1UrZYMfqYiLxCHTOQsPkJ8JLd0z0j-CmEmZZXevEai-Q5MqU57rC
    ZZC53tEJfuu9jLPODK6QXBLSGBNaUsNCeOiE3yoJfwKabbHa6Xe7xPZ>
X-ME-Proxy-Cause: dmFkZTGP2bhb/XYhsNLB9S53X9rzoPN54qfE/KjrIQ+39ezusymjgkFG9cet+423ozVpDR
    QFvnmTNBMcgGscLcMMj7nBUY31hzJeOaGY2jSrT3p2YxejgdAUzrKdVOR8lCRBS16Gn88X
    /+XGMDl8CSXVYCQsr0wErwVPc+V6zmpd4d51AzTQO8MWr89uCO460fbix+l7zmvoJuzkvE
    RaO6/PdGwEVTqYIezlus3lDCEAnry2C8vj8V499E/dlZoQ4ScXku67uqDjBlKaXI4HB2gC
    KacujXVdDoEwzQ2dyYPEUzaZ7+e2mOEhOGj1Fetuz0MEj4OcAAwjVvsFr0sHvhPpz277Gf
    eKzGoSn6iqanxzNgqqMPsXCY76vQD+ea58iHSG5APtokUDPToSvfELosscq5Qt4yP2Q9+t
    y1tk8mh/YV6JND1qNbS+O2favpqJYSFmbwPFawNlshEMNgXzINZxwKWiewG0SxhFiQFIL9
    4DpI0upYjn0k3v2eBM7Iml4anYd8gF3WPX86kKH7R0o4H64FA7zDDSXAF3jY5QkB0ZSiW6
    sIKc9JmLSD+i8R4Jef0OcLMUt1jMXi6faA5jYE6vH5UfgYoDR3/ZIP9Q6vSw4pAYMA/Nxa
    V2SShKsn+8CcVH/XBZJ+tLKfo4Kqs/CxHjYl1vrrgz/DIr30WA6FviGoSjxg
X-ME-Proxy: <xmx:Tb2hapOSEggtAzw0YPolcJShgHipiCEz32yrnlma3o-FVpqo5DDtLw>
    <xmx:Tb2hampTwttRtE3MK5w7nObKR1veqSPqSuzHl5qP3-u6Rq2T0fLYYA>
    <xmx:Tb2hau5yJgf9foM2D7YQh1VswYDLBi8VWRuYGaVJdHhtOWFLOMS4ZQ>
    <xmx:Tb2hagpfMYsdVStUsBhPHlcE5fczSNlUCNGOAGT9WGdLMRXUiDZ7qw>
    <xmx:Tb2hasKSPzPUsbdSIk5XCLjXxVPXAZU5O6viFS2qHLW3A3TqPNR5T1ZS>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 78FB232A007B; Wed,  9 Sep 2026 16:10:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGTXWeH1PU47
Date: Wed, 09 Sep 2026 22:09:43 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Bart Van Assche" <bvanassche@acm.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Linus Walleij" <linusw@kernel.org>, "Russell King" <linux@armlinux.org.uk>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 Linux-OMAP <linux-omap@vger.kernel.org>, linux-block@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-Id: <b0705a8d-1b85-44e0-917d-19ba760e8c12@app.fastmail.com>
In-Reply-To: <2da174ef-1d5a-425d-b885-be9482b0be90@acm.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-4-arnd@kernel.org>
 <2da174ef-1d5a-425d-b885-be9482b0be90@acm.org>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026, at 18:42, Bart Van Assche wrote:
> On 9/8/26 8:27 AM, Arnd Bergmann wrote:
>> The Acorn Risc PC is the oldest still support Arm machine in the kern=
el,
>> originally shipped with an ARMv3 ARM610 support in 1994, it later all=
owed
>> faster StrongARM CPUs.
>>=20
>> The main limitation here is the CPU bus that does not allow 16-bit
>> wide data transfers and hence requires the kernel to be built with the
>> -march=3Darmv3 compiler option that was discontinued in gcc-9.
>>=20
>> As gcc-8 is barely supported for compiling the kernel, this one
>> will not see another LTS kernel release, so remove it now.
>
> If this patch has to be reposted, here is the feedback of my AI coding
> assistant (based on an LLM and hence may be wrong):

Most of this was already discussed, but there are two additional
changes that I made based on it.

> Issues & Observations
> ---------------------
> 1. Missed arch/arm/Makefile cleanup
> Patch 03 deletes the entire directory arch/arm/mach-rpc/, but does not=20
> touch arch/arm/Makefile. As a result, two orphaned entries remain:
>
> machine-$(CONFIG_ARCH_RPC)		+=3D rpc
> machdirs-$(CONFIG_ARCH_RPC)		+=3D arch/arm/mach-rpc
> Furthermore, machdirs-$(CONFIG_ARCH_RPC) was the very last user of=20
> machdirs- in arch/arm/Makefile (after Footbridge and SA-1100 are remov=
ed=20
> in patches 1 & 2):

Fixed already after sashiko-bot found the same thing.

> kconfig
>
>
> config FONT_ACORN_8x8
> 	bool "Acorn console 8x8 font" if FONTS
> 	depends on FRAMEBUFFER_CONSOLE || DRM_PANIC
> 	default y if !SPARC && !FONTS && ARM && ARCH_ACORN
> Because ARCH_ACORN is removed, this default can never trigger and the=20
> reference should be cleaned up.

I have this in the patch that removes acornfb. It could go into
either one, but I felt it fits better there

> kconfig
>
>
> config CPU_SA110
> 	bool
> 	select CPU_32v3 if ARCH_RPC
> 	select CPU_32v4 if !ARCH_RPC
> Since ARCH_RPC is removed, select CPU_32v3 if ARCH_RPC references a=20
> non-existent symbol. If CPU_SA110 remains temporarily (before the=20
> architectural cleanup in 7.5), this should be simplified to select CPU=
_32v4.

Also explained already that I preferred removing CPU_32v3 along
with CPU_SA110 in a later patch, not together with ARCH_RPC.

> 4. Dead code in arch/arm/kernel/atags_compat.c
> With CONFIG_ARCH_ACORN removed from arch/arm/Kconfig, two blocks in
> arch/arm/kernel/atags_compat.c
>   are now dead code:
>
> Lines 150=E2=80=93157: #ifdef CONFIG_ARCH_ACORN / if (machine_is_riscp=
c())=20
> memory bank tagging.
> Lines 186=E2=80=93194: #ifdef CONFIG_ARCH_ACORN ATAG_ACORN translation.
> These blocks should be removed as part of this patch.

I have a patch to remove that file.

>
> /*
>   * Now, pick up the machine-defined IO definitions
>   */
> #if IS_ENABLED(CONFIG_PCMCIA) || defined(CONFIG_PCI)
> CONFIG_NEED_MACH_IO_H and #include <mach/io.h> were removed, leaving=20
> this comment describing generic PCI/PCMCIA I/O limits.

Fixed now.

> arch/arm/boot/bootp/Makefile:21
> : # guess an initrd location if possible is left dangling right before=20
> ifdef INITRD_OFFSET after all initrd_offset-$(CONFIG_...) logic has be=
en=20
> stripped out.

Removed that entire block now:

--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -17,12 +17,6 @@ add_hex =3D $(shell printf 0x%x $$(( $(1) + $(2) )) )
 #   INITRD_PHYS must be in RAM
=20
 PARAMS_PHYS :=3D $(call add_hex, $(PHYS_OFFSET), 0x100)
-
-# guess an initrd location if possible
-ifdef INITRD_OFFSET
-INITRD_PHYS :=3D $(call add_hex, $(PHYS_OFFSET), $(INITRD_OFFSET))
-endif
-
 endif
=20
 PHONY +=3D initrd
@@ -30,7 +24,7 @@ initrd:
        @test "$(PARAMS_PHYS)" !=3D "" || \
        (echo bootpImage: You must specify PHYS_OFFSET of PARAMS_PHYS ; =
exit -1)
        @test "$(INITRD_PHYS)" !=3D "" || \
-       (echo bootpImage: You must specify INITRD_OFFSET or INITRD_PHYS =
; exit -1)
+       (echo bootpImage: You must specify INITRD_PHYS ; exit -1)
        @test "$(INITRD)" !=3D "" || \
        (echo bootpImage: You must specify INITRD; exit -1)
=20

> 6. Floppy driver & arch/arm/include/asm/floppy.h status
> The patch removes the ARM MFM AND FLOPPY DRIVERS entry from MAINTAINER=
S:

commented already that this is removed along with CONFIG_ISA in a later
patch.

      Arnd
