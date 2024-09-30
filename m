Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3B18DF83;
	Mon, 30 Sep 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698964; cv=none; b=Bzai6Um7+Mx7bXs5HYY0tXNEFnkcdFCPDK3sSKSXM0zin7K1XL1xveZfniB6fZIZ25l1sRUcrkjxk7X02ZCh6zAHGJtrxiPLOD5aYlQfTazEDgczVdem+DEXvyIEfECl+mM7igi4+t+2FUsF//SgNp07rvrG2ysNXZM/1/2qfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698964; c=relaxed/simple;
	bh=3S46tDDMKvVAtWH9TyzQtUSoNz5PYw/L1ZWfttCLLl8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUufjzxQ/dlAZA5wJvMy1a7smE6ratm8riXaoC62cqR+BgJ2kYIu+NgnvjfBOoqcA5+I+J2oPeCFJPi3E/2/e9v4aKs+5RGK3dTsWrMC09iVu3FWXqA/v9EObH4I4ekUpPmlrpfgqN4FhVNZ7xMMVlQ3I33jpP51wrnSgrFqtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRigXjUd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRigXjUd"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3770320574aso2849314f8f.2;
        Mon, 30 Sep 2024 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727698961; x=1728303761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hCcXMOeGRNjeeRcTKij9Pz4e0oSkHZciMkj5Jz2xO3I=;
        b=HRigXjUdjoPtZXn3Nh7owUXTn9idxgjB7shjtkVpOCnfQFCcH4bL9Tj2ksU3OQD7MS
         FquRnrkWHSoz6SYmMXz6FO/X0T/Xq4H0z9Mo2BG7LYC+PCfUMjrLWqKkeeoJ+Btw3UgL
         PJBXBTqa8S25S7YsPwzRdvv0N5Mydo8tPovj3/O3oLI0QrDLfMSlvUkb3YzZIZ8ho1Lq
         jkA/+bPLNxsBntIJrZs/mo6pJMm3V7J+qTiPY4V83BI04HU8uaJxm72n/3GjQpdJQQJ/
         Vs9fYhmhEyDdTUHqtPHxF7gGDlVeAxiNn4IKi660ZQC4nrOb3Ne/wBDHHprBxFkyU4qP
         K8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727698961; x=1728303761;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCcXMOeGRNjeeRcTKij9Pz4e0oSkHZciMkj5Jz2xO3I=;
        b=ndYRpP500Zz0uUistyS8ZML7YC9XbjkfeFKsXIpv+JFzIPn5tXU8WMTpoxCLuuKvTx
         bMUI6iahE2KHY+c33vmGX2Y44+Z+HLM24saJS15m8sLVYDXASzH7/BjK9pfdwkDJdxrj
         pD0CuAcgJAysnVOonePA7sQ8TpgHeIcENPNabh3yOFUNJgmLC8m29jsoaiD2tkqrHfz7
         /QUwLBdoDSn+jnL9Z+g2fLkJDHympcBIJTA/Lg6Ss5Rfbq1RHv7HTvsbG7RKUv2OGchU
         n4Rx7DJJvpHvk0Wu9SZIOi6beaOuGKz18fzw3TMFQ1DK66T6wUhDgtBnTEkdiS9k8yct
         iV9g==
X-Forwarded-Encrypted: i=1; AJvYcCUSb83DM4d8pJUqxtq4BLV1yqnsny6bP0x+UJfbVBvh1oZgsQGYlH2aaZeRLD2ZWd/V8LUqy9i7HLWmV0FF@vger.kernel.org, AJvYcCVLFtQqtS+Yjl0pOHRaAbjI4jZmuJv0T4m4r5GvAUtlYJP8QUAHwKAyonMe49HWwNMGx/z3fmv7fmeD@vger.kernel.org, AJvYcCWJjorD830qPTuyY0amLkGVMxpKr7X2jsKGrwf9JvpG7xsP6gIm6pXHyw3gy8q7XucsG1VPQK70tYRVF/HDC20o@vger.kernel.org, AJvYcCWNIvXMDxcbqAnWSY4vR3bQHIvnpl5Iqzt/m7sKaPGuKb8V//rCY+jfLtuyh+eF2F8s6kXPML/pInJh@vger.kernel.org, AJvYcCWTqcMJ6q58EIcCGoy0sbBDiyydoEwJnGfjV3TH1qpmDP5sFk6XBrxp4wENXa5tM50QEFYCZI7JMoZXK38=@vger.kernel.org, AJvYcCXLiHDCmhrGebaiY0AuEEppsiZRtYLNvkQaowWqxVbI2UtsbxGuToqYMNLaCtrn1se5dEWs7c8XePQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YzxmtlvFjOW5Ku0izZPI6Aiw0aVVQ1PooXU646/Hr4jgqxXRoH4
	AalOoUS2ejzPB0fzXIXFint8s6Bzc5m22a6OkBiSqbaT/8h9XPu/
X-Google-Smtp-Source: AGHT+IHUVqqs1Gac4ysUjva3xcy7rS88I/wK5Q8dXqHNLoKm+Ub/xwJkn9z1fYNYAU0phc8BMawJOA==
X-Received: by 2002:adf:a2de:0:b0:374:c606:df0a with SMTP id ffacd0b85a97d-37cd5ad1423mr6525810f8f.36.1727698960484;
        Mon, 30 Sep 2024 05:22:40 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd57310f6sm8955352f8f.78.2024.09.30.05.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:22:40 -0700 (PDT)
Message-ID: <66fa9810.050a0220.3b136f.bc29@mx.google.com>
X-Google-Original-Message-ID: <ZvqYCMYL--XyJzAB@Ansuel-XPS.>
Date: Mon, 30 Sep 2024 14:22:32 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH v4 5/5] dt-bindings: mmc: Document support for partition
 table in mmc-card
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
 <20240930113045.28616-6-ansuelsmth@gmail.com>
 <87y139jpx5.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y139jpx5.fsf@prevas.dk>

On Mon, Sep 30, 2024 at 02:18:14PM +0200, Rasmus Villemoes wrote:
> Christian Marangi <ansuelsmth@gmail.com> writes:
> 
> > Document support for defining a partition table in the mmc-card node.
> >
> > This is needed if the eMMC doesn't have a partition table written and
> > the bootloader of the device load data by using absolute offset of the
> > block device. This is common on embedded device that have eMMC installed
> > to save space and have non removable block devices.
> >
> > If an OF partition table is detected, any partition table written in the
> > eMMC will be ignored and won't be parsed.
> >
> > eMMC provide a generic disk for user data and if supported (JEDEC 4.4+)
> > also provide two additional disk ("boot0" and "boot1") for special usage
> > of boot operation where normally is stored the bootloader or boot info.
> >
> 
> This looks quite useful.
> 
> Could this be extended to also be applicable to the four "general
> purpose" hardware partitions, i.e. what is exposed as /dev/mmcblkXgpY ?
> These would often also contain some fundamental boot data at various
> offsets but also, as for the boot partitions, often without a regular
> partition table.
> 
> The eMMC spec consistently refers to the boot partitions as "boot
> partition 1" and "boot partition 2"; the boot0/boot1 naming is kind of a
> linux'ism. Similarly, the general purpose partitions are _almost_
> exclusively referred to as 1 through 4, except (at least in my copy),
> the heading for 7.4.89 says GP_SIZE_MULT_GP0 - GP_SIZE_MULT_GP3, but
> then goes on to describe GP_SIZE_MULT_1_y through GP_SIZE_MULT_4_y. So I
> wonder if on the binding level one should use partitions-{boot1,boot2}
> and, if implemented, partitions-{gp1,gp2,gp3,gp4} ?
>

Just to make sure, they are exposed as disk or char device? This is the
case of rpmb.

Adding support for this should be no-brainer as it's just a matter of
more case of the strends and more regex case on the binding.

I also notice the conflicting names, to adapt to JEDEC naming I will rename
the property to boot1 and boot2.

-- 
	Ansuel
