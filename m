Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501D2144AD;
	Thu,  5 Dec 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399690; cv=none; b=U/DiC8cTCc1UUHDqFuVpyhjqlqcXyLeXWz9U2f0EcGdOXzZxvbyASgRgiIpwqe/LzmxAfWDJZWJCFC8J0iAO0KZC6Ydrw4HM89QH64xR2h5YEZiQt2Et2D/XT1LZTnEPFQ/PVfaqS7uEXf5dBK8UzfhIWyVKejCTJfHWvf0/YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399690; c=relaxed/simple;
	bh=dSIIXx/hG/P8NaDTqNYGqJ91TW5o+zpLS+ZKMEElSyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3ar85wBwFq/Z13v7o8OrC0tnJSnXITb8RnhnJAcVCKFm+ArcAa1NBm17BMh5ydha1wGaQxFiBStmBq1ei2kdKPOINN0ZsRWrolNx/E9mSS2rPxFzLgzkyM8sAHb3aoMy/eldklID01aeU3Nd7eUmNDDELf2RiGHEs+O43aw3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlol3QSm; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlol3QSm"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d885705595so7371496d6.0;
        Thu, 05 Dec 2024 03:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733399687; x=1734004487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HVC6GBY+m69vIBL5eFFh1SDeg76uxLTl04NzD89f2u0=;
        b=Vlol3QSmRRkG6deX3GATYhXfrnsGlcw+YTOTa8fPlItHP1EI71ylCN7CiK6Uf60LHE
         Jj2eGGNZOAO0SCcL1dw0Tmx7xOmyfWqmWL2cL2kkrumMND2kA+CumlSaypHDDTtXuYkD
         aO8ixQenoQRYXYvBHJ4FnGWu3I3VX0Ru+MwGSzR+HoJ6shdCYJtKwjICUaL4PcC8iox9
         gQA9WKcEHCR+lKIMxndTgNQ/CB55oS5mWVNYkpPDPLIHkILQgUADrxMXMuTXIhsaIcxh
         20VAJhFk8eLl1x099wUYfPeeDgtxShSHjNt3D+Vr3iwo9eBzGf+n9x9Xaa5dFcZRhX2b
         3v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399687; x=1734004487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVC6GBY+m69vIBL5eFFh1SDeg76uxLTl04NzD89f2u0=;
        b=bip9UTOx3frZdOmZ/10cvpKS/yep0MdyD/1aIJ1MQzEe6WRns1lFmXWl8AcUY06atF
         fdcbfiMMrlbv0Wl6a4yDQ/+pf81lLH4aD9WQT+nnBxaWNz5y/lckGtL6pNWihedWoQtP
         3qfweZalwlxQAhCZBXjElopurPvNHl2fkRertecFvFmyqzcoxZHMt2/gkD88SS5RS7Z8
         /PXOznVhOaeO9JinSnXxzSOwyt54bmSoUi+flxSU4wV1fJRhgNyukJ1FddJV8vQ33m/X
         E8A9fR4bgygLtURzuOJcycApIoljhrV4RpE2BRc+zxl9tIbUjKnAdjVhvEWyi17ot2Bj
         PCmw==
X-Forwarded-Encrypted: i=1; AJvYcCUruCC4sORaFsEXHUsRXp67nfjaarbpkjpPdSsgMk4Usvs0X0PA//+QrHC56CrP4K6Dk0XNbAbVfE2r@vger.kernel.org, AJvYcCWOZgblG8Zjhy8GVMhq3CeoCIXaffu0kgAlbi2MgP2OJSIxwC/ZSBxk/a/bBURAv3CbESsRdLeIu6eZK5xP@vger.kernel.org, AJvYcCWo6vudeAvV2GAmZrVnsYXSgiLdFwNDZ/vC2+Lhzp3X2XNQ0o0MTU5oDE+fbbDm0ZYNA5JDvs7j8Oyy@vger.kernel.org, AJvYcCXE/Qn1Cy0nzok4SA1sVCf6ykEZgLf/+HHPZo0qYQrIiS++7C2ohc4rVyLVL2MtWHxmm8AJgBQp7fbY@vger.kernel.org, AJvYcCXXFNYxbZ3+OEPB+IBGqvWUmYswbf9kjeVlz/Yjwt2MYut6LR7M5E5zc4oVC9u684eozHH1L1jFv4pPl/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIgWygOW9LRiljtdNJ8TU6MUTWFxUWeZshXmnXiYVw17A6soY
	mW2+os9hKnls2kw6PzYrmZB2HWDKEIwU9TdDSUVof4fyi3PIgmuIjgHjp2nyjl33T6kZKlVk9CG
	u8LRe4CMaC0GSJEqu7p+zEmJK8Xw=
X-Gm-Gg: ASbGncttD6q9JCZoBaQppZWLw+3i8CJ+whNPYl9CYGphsZDbTy1ZTYd14L+hppOTaYx
	8kwR3MiDItOzDjeN7qLjsz5zhK7dmLA==
X-Google-Smtp-Source: AGHT+IE0SWEWRPj055WxDD22N0C04Zp8iMRPWR1HYzCrZPeSFsqycgRAlqP80+PjPdfn8HXmH3tMrDD0IAzDRoTKD4E=
X-Received: by 2002:ad4:5de3:0:b0:6d8:9065:2033 with SMTP id
 6a1803df08f44-6d8b740e95amr129267216d6.31.1733399687140; Thu, 05 Dec 2024
 03:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002221306.4403-1-ansuelsmth@gmail.com> <20241002221306.4403-6-ansuelsmth@gmail.com>
 <5e9a80d6-6c89-478e-99c9-584647661f5e@pengutronix.de>
In-Reply-To: <5e9a80d6-6c89-478e-99c9-584647661f5e@pengutronix.de>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Thu, 5 Dec 2024 12:54:34 +0100
Message-ID: <CA+_ehUwa69Qa96yy0=K9AiCEJbaZt9oGCRf5gJDh-0_14shbtA@mail.gmail.com>
Subject: Re: Co-existence of GPT and fixed partitions (Was: Re: [PATCH v6 5/6]
 block: add support for partition table defined in OF)
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Golle <daniel@makrotopia.org>, INAGAKI Hiroshi <musashino.open@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ming Lei <ming.lei@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Riyan Dhiman <riyandhiman14@gmail.com>, Mikko Rapeli <mikko.rapeli@linaro.org>, 
	Jorge Ramirez-Ortiz <jorge@foundries.io>, Li Zhijian <lizhijian@fujitsu.com>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Jens Wiklander <jens.wiklander@linaro.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com, 
	Christoph Hellwig <hch@infradead.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

>
> Hi,
>
> sorry for not writing sooner. I only noticed this now.
>
> On 03.10.24 00:11, Christian Marangi wrote:
> > Add support for partition table defined in Device Tree. Similar to how
> > it's done with MTD, add support for defining a fixed partition table in
> > device tree.
> >
> > A common scenario for this is fixed block (eMMC) embedded devices that
> > have no MBR or GPT partition table to save storage space. Bootloader
> > access the block device with absolute address of data.
>
> How common are these? I never worked with a system that didn't use MBR
> or GPT for the user partition.
>

On router devices this is the approach for Mediatek and Airoha and also
other vendor for anything that have an eMMC.

Other device have a mixed nor/nand + eMMC but the eMMC
is used entirely for rootfs and not foor bootloader or other special partition.

> > This is to complete the functionality with an equivalent implementation
> > with providing partition table with bootargs, for case where the booargs
> > can't be modified and tweaking the Device Tree is the only solution to
> > have an usabe partition table.
> >
> > The implementation follow the fixed-partitions parser used on MTD
> > devices where a "partitions" node is expected to be declared with
> > "fixed-partitions" compatible in the OF node of the disk device
> > (mmc-card for eMMC for example) and each child node declare a label
> > and a reg with offset and size. If label is not declared, the node name
> > is used as fallback. Eventually is also possible to declare the read-only
> > property to flag the partition as read-only.
>
> barebox has for many years supported defining fixed partitions on SD/MMC
> nodes and it's used heavily to define e.g. the location of the barebox
> environment. Many who do so, do this either before the first partition
> of the MBR/GPT or overlay the fixed partition to be identical to
> an existing MBR/GPT partition.
>
> barebox also by default copies all fixed partitions it is aware of
> into the kernel DT, so if the kernel now stops parsing GPT/MBR when
> a fixed partition node is defined, this would break compatibility of
> existing barebox-booting systems with new kernels.
>

I'm not following... is that a downstream thing? Also fixed-partition
in DT for SD/MMC were never supported, why the partition was
copied in DT? Userspace tools made use of them?

> > +config OF_PARTITION
> > +     bool "Device Tree partition support" if PARTITION_ADVANCED
> > +     depends on OF
> > +     help
> > +       Say Y here if you want to enable support for partition table
> > +       defined in Device Tree. (mainly for eMMC)
> > +       The format for the device tree node is just like MTD fixed-partition
> > +       schema.
>
> Thanks for making this configurable and disabled by default, so users
> won't experience breakage if they just do a make olddefconfig.
>
> > diff --git a/block/partitions/core.c b/block/partitions/core.c
> > index abad6c83db8f..dc21734b00ec 100644
> > --- a/block/partitions/core.c
> > +++ b/block/partitions/core.c
> > @@ -43,6 +43,9 @@ static int (*const check_part[])(struct parsed_partitions *) = {
> >  #ifdef CONFIG_CMDLINE_PARTITION
> >       cmdline_partition,
> >  #endif
> > +#ifdef CONFIG_OF_PARTITION
> > +     of_partition,           /* cmdline have priority to OF */
> > +#endif
> >  #ifdef CONFIG_EFI_PARTITION
> >       efi_partition,          /* this must come before msdos */
> >  #endif
>
> If I understand correctly, it's possible to have both partitions-boot1 and
> a GPT on the user area with your patch, right?
>

No, this array works by, first is found WIN. If OF_PARTITION is enabled
and an OF partition is declared in DT, then efi partition parse is skipped.

> So this only leaves the matter of dealing with both fixed-partitions and
> GPT for the same device node.
>

The logic is applied to skip exactly this scenario. GPT partition can
be edited at
runtime and change, DT is more deterministic. It's one or the other.

If downstream someone have GPT then OF_PARTITION should not
be used at all... Eventually downstream for this special approach, an additional
downstream patch can be added that define a special property in the node to
disable OF parsing. (it's a 3 line patch and since everything is downstream it
really doesn't matter)

> What are the thoughts on this? An easy way out would be to make of_partition
> come later than efi_partition/mbr_partition, but I think it would be
> nice if the kernel could consume partition info out of both of_partition
> and efi_partition as long they don't collide.
>

The 2 thing would conflicts and would introduce so much complexity it might
be not worth at all. Also you would have situation where someone declare
OF partition in the space where the GPT partition table is located, adding
the possibility of corrupting it.

Again would love more explanation of your case because by the looks of it,
you use GPT for partition parsing and just overload the DT with the additional
info maybe for userspace usage. (and that case can be handled by just keeping
OF_PARTITION disabled or adding a little downstream patch)

Or you are telling me you had a downstream patch that declares additional
partition in addition to a disk with a GPT partition table?
If that's the case, I'm confused of why the additional partition can't
be declared
directly in GPT.
