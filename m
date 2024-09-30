Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7518BB8E;
	Mon, 30 Sep 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693303; cv=none; b=W2QjFvK6X6vzGeZeRh5MlAc+Craih5CkoRHM0lYYPus4QZ+DyvR3V4z04admQniaZ//lipv80YlwBS507NXtm7WKYy+Szkw81bEYdZ4KGR9mE8Gu8chlqpZrRgN9C5KdAR5mjov/mdy42Z5dCe/ZN+DTSUVhWv5Syonz6l9/aQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693303; c=relaxed/simple;
	bh=A1QdosurTp0ef+7RMeZEr38JQEYF3lsGB4Pabjonqys=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/jiPelI4Hhf7EqM20y/ppVjG1XRgd1D3tTd5EFtnf8VvqsQrB3RQZYT8IMK8Kg87ugDOf7GXv2B2Mc+43aZLqjLYCf3HMTkkv6WKrD6jtVdptMb6VuIKCb7bfNFLqv/xSmHT00k7EO5h1c3nScJdqXQvTvVMXxKXIVze+MUrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnlzcv0C; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnlzcv0C"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2faccccbca7so7512001fa.2;
        Mon, 30 Sep 2024 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727693299; x=1728298099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wFh8kU+qt/WiTGXVF0NW8orHkyxzKHI7cefqhBGwbUI=;
        b=Bnlzcv0CwP9He0lberQaVJ17xFrhq6tG/a7NODHXKyejXiW1RvV1aR1XDiSHWSmGWZ
         03la4hHB3rZMBpIYHTgKarGZETBmBcX8U+rsO035cOrHeklmPUIluZ8/yE+zVcgDbKjS
         pVckf1pCM6QURrxw2xvmRvMEO58+skozq5cz/c5liHP+QhRb8rp2mBHkPxBxQD6+wo3n
         +5Mx95EMhzr0j1XRt32ouuO6BJSUwDveCdf+4vevusa3SPRD3+ubW7cCAh51kcuP0d5U
         6kEvQ2Z9gTFjXLZyqPsT5aifaCogFe/X0MZ5e4im0xQEt1A24oKNR/nDkN4CgxAkpeJ4
         /4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693299; x=1728298099;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFh8kU+qt/WiTGXVF0NW8orHkyxzKHI7cefqhBGwbUI=;
        b=L9TfrZy+B3FVC3iT8zBz//I0378VtVJdOiH5CBlHolInpiQas/Fhog3MlqbaNUMAu8
         fHfHG9dmPOcOq8NDj/5NUdmit9Exnh7FgT1zGppiuiWgG3MpNSpQibaPinIsjZNBh4Dn
         BavaCiDWJOLmxofjkdCeQ1Ry86mkJe7DCEQ6S0Ii1ChRnNm8qGrpulde7F4EqFNDgTpY
         5k6KIZojT7MXvA27du1haDOAR8+6XxNforyeN+vNw/w1A9P4EiWcIA/dFieOmXhE2E4r
         q5GXLicg6wwf1FIOr6i0eygjwSb0iNBOyfAPql2vUcSDwe7E5q5QbPN/MYrAvoBv265b
         SKUA==
X-Forwarded-Encrypted: i=1; AJvYcCU+GUERI8DlelDInDim9Ww/rOgMU9v8dpgL7MayWPu4Vuldpq2+l9L2kt6Y+1s2cj5pappxWEHLhWjRkn4=@vger.kernel.org, AJvYcCUHL77SFvxjOlw5n/yOQrj7DjfEBj/stP3QZoJp9GgkBNGdCYlPPuv3BzNEjQQwwL4XuysTKrfRZsvA@vger.kernel.org, AJvYcCUdvlXtwWHY++MQTGi4ewDIkvAeD6yrYKLvhe59BmPQ8j65sY2C1Q2aShqFE/YrwyhuXoRGEqMZOXCh@vger.kernel.org, AJvYcCVjyfraQFHw3p98u63zmbjQbSygyzQ5MgyHZPjuvsRSiee/Mo0WWKxGn9SOxj84rj/T+5CV0vTCWUk+@vger.kernel.org, AJvYcCXtzEyfPA+9YFFkWlTYnVM6ofmfECMpjmcfB56N9W4k8AxQtKWRJ4G+jJ99bf6+bUMEBbRwbJ8DApfhqKQr@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXCbaIpvTYNk1vVXlA6xqVOVH9s6UcL+YEoJjGqOZMgbNVBW+
	IxR0Imwmgtc4BFJzbIjMIY+R8rR/sTTrsa1NP/Dy5+iMsPDVrisU
X-Google-Smtp-Source: AGHT+IH/V+rGK2bCvCQYKk/IC08xHxURSfbBgJZqxqlIHy8pllnZiZI+dX79uI70VLH/nEeAnsEWuw==
X-Received: by 2002:a05:651c:19aa:b0:2fa:c46a:eb4c with SMTP id 38308e7fff4ca-2fac46aecb9mr31133321fa.3.1727693299138;
        Mon, 30 Sep 2024 03:48:19 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e1392fsm100666965e9.31.2024.09.30.03.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:48:18 -0700 (PDT)
Message-ID: <66fa81f2.050a0220.3358eb.f750@mx.google.com>
X-Google-Original-Message-ID: <ZvqB64jZL8xhSZzO@Ansuel-XPS.>
Date: Mon, 30 Sep 2024 12:48:11 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH v3 3/4] block: add support for partition table defined in
 OF
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
 <20240929140713.6883-4-ansuelsmth@gmail.com>
 <877catlcni.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877catlcni.fsf@prevas.dk>

On Mon, Sep 30, 2024 at 11:21:53AM +0200, Rasmus Villemoes wrote:
> Christian Marangi <ansuelsmth@gmail.com> writes:
> 
> > diff --git a/block/partitions/of.c b/block/partitions/of.c
> > new file mode 100644
> > index 000000000000..bc6200eb86b3
> > --- /dev/null
> > +++ b/block/partitions/of.c
> > @@ -0,0 +1,151 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/blkdev.h>
> > +#include <linux/major.h>
> > +#include <linux/of.h>
> > +#include "check.h"
> > +
> > +#define BOOT0_STR	"boot0"
> > +#define BOOT1_STR	"boot1"
> > +
> > +static struct device_node *get_partitions_node(struct device_node *disk_np,
> > +					       struct gendisk *disk)
> > +{
> > +	const char *node_name = "partitions";
> > +
> > +	/*
> > +	 * JEDEC specification 4.4 for eMMC introduced 3 additional partition
> > +	 * present on every eMMC. These additional partition are always hardcoded
> > +	 * from the eMMC driver as boot0, boot1 and rpmb. While rpmb is used to
> > +	 * store keys and exposed as a char device, the other 2 are exposed as
> > +	 * real separate disk with the boot0/1 appended to the disk name.
> > +	 *
> > +	 * Here we parse the disk_name in search for such suffix and select
> > +	 * the correct partition node.
> > +	 */
> > +	if (disk->major == MMC_BLOCK_MAJOR) {
> > +		const char *disk_name = disk->disk_name;
> > +
> > +		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT0_STR),
> > +			    BOOT0_STR, sizeof(BOOT0_STR)))
> > +			node_name = "partitions-boot0";
> 
> If strlen(disk_name) is less than 5 (and I don't know if that's actually
> possible), this well end up doing out-of-bounds access.
> 
> We have a strstarts() helper, could you also add a strends() helper that
> handles this correctly? Something like
> 
> /**
>  * strends - does @str end with @suffix?
>  * @str: string to examine
>  * @suffix: suffix to look for.
>  */
> static inline bool strends(const char *str, const char *suffix)
> {
> 	size_t n = strlen(str);
>         size_t m = strlen(suffix);
>         return n >= m && !memcmp(str + n - m, suffix, m);
> }
> 
> [or name it str_has_suffix() or str_ends_with(), "strends" is not
> particularly readable, it's unfortunate that the existing strstarts is
> spelled like that].
>

Nice idea and thanks for checking the problem with the out-of-bounds
read.

Out of consistency with the unreadable strstarts I'm tempted to use
strends.

Since checking suffix of a string can't be something that unreal I
searched for the 3 function name and to my surprise all 3 suggested name
have a variant of the function statically defined hahaha.

To not pollute this series I will just introduce the helper but I will
add on my TODO list to convert the other function to make use of this
helper instead.

-- 
	Ansuel
