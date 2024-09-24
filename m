Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F5184554;
	Tue, 24 Sep 2024 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218910; cv=none; b=qE389WR45bvAoCBxqmOydYzluqzVz/Wut8ES5BukuN2F1GHh/5YX5TmkS0Fh7AA+r0uOqN+1uEyacLFvMtfjkhq5Uz1XUJ2X3RQLy3fT9O58T4DWeTU/dhUgHMGC0MzsdZOVKDvJAKB+/dTL5N4F9yW124bLkGZv4OZfs/pxsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218910; c=relaxed/simple;
	bh=iCpstCu67Jc2MNXnXgMRYbHpsGMR/seZfOB+2ddMqn0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuF6Mgxwq7qesHdXBnd+AQ0wTJYoJ0ggALTAqW6JFNWXXFqQyMrVHXAYVapvXmS1VnXBy77IahCAieXiae57nCVf3N06odFIZjKll+1sXvHeCWhbNNXNVCrWCo5YO+5SbOPia8uA+oXLZjBzlOYmmkutj5Y5NXwiaY/qwYEUycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqc4ac9s; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqc4ac9s"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-375e5c12042so3206418f8f.3;
        Tue, 24 Sep 2024 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727218907; x=1727823707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EiHP41TD7xH9XF/qUpUvxLVEqhRCLzxrTYdZWcoiVUM=;
        b=nqc4ac9s9JB09+R/ruP233XyvLhpliVaQCRLWrqdg5AAzxGMeFTdSYWE1oUj74kCJs
         Eleg6yTqyYZVOGte2pUqxCtxu8PJzd8//Yc2mIElVNJ2lO2lH/izwxR+NEdh1RnrOs5+
         j4nemyUaEYvPP2t+G4At665BE1tnxZmGjf3SAn7fArNUjk8OdRnHL3QPZoCfERONVfIK
         Baa7lvTJDYd+g+4E+YwCmazVR6ExwR+ct2wIvzbBKkHRHKMwd/H2/nBrdzacqxXlJg4c
         lAPRR5KGWfkxzVz7FD/MEMJ1FJ2xujGB5/QjvZ76Bmkk6USLpZ5Zv9q+xSDIFt+uR1dT
         jRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727218907; x=1727823707;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiHP41TD7xH9XF/qUpUvxLVEqhRCLzxrTYdZWcoiVUM=;
        b=Cd4FtVBCMJWHSEqElrWOtUeACZzd8ksPL2keoGhfBL6BGYR8WOR+2c4y8TCO2pWebO
         sfYU2IOr2O8BNUdFwzeZNymFF8iayIO7Jxh6+ILVGlkvRTzMVSMTlVDZSQJjNM8wrUXZ
         OybGEo2o2KOjFPsP2a+bnZyKDFBEK977ww+5q+YcBpqSaIl1W2g04uxo8ig7+3o75ze9
         QKEW63sKCGD/WId4GW7smTOCbkYIKuDdnGUALmwPC+hrbgPdu8Myy2ir3/lkWTIzvQXW
         TgGdLC2MQvO67EGYJIuwhaj5WHlcQmjSbI9IyaarZgldiNpc1QGgY3Hpcw2oWDCIc1Hs
         9f3A==
X-Forwarded-Encrypted: i=1; AJvYcCUR3wd7BiqWCSJQVJnIFVck68iWAkAMkDTOK+jUpErjMsEwcnPewWK8cxJuzWiIdHNdxGBcDcMuZR2uJAIm@vger.kernel.org, AJvYcCVFd4W1EsR/VgKb0YW1ULEveedVZNtLJBPP2H/zvZqGyzhXMNCVmWaTOU1m2Q6oZxJTVRArhdDQrVMz@vger.kernel.org, AJvYcCWLaFwmnDK3cIEWa6bci9TYz0PfMyCdpw1yFQqnsOIQYpNNba9V6VCZKtns+q9Zf+pc8y5cZh3J+uHR1kM=@vger.kernel.org, AJvYcCX7KqQ3njwgcosJqSSUx68UHw/IB8iF81eJwXw1iscULAO/mzDtfnTMPBO7H7jHpt/1ZR1Qe1eVXpjh@vger.kernel.org, AJvYcCXJ2VOZrLLfoeH0Xq6hDsIhsRt/hT0T9BzSfORM0rR5FidsgdwTveG/9/hftWB9QKWSjJSBsA+DKRY4@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVs0uRQRESe58yVwE5PX9+ExC2ioL3daS/JViNJVImaJ8muNR
	Ryf8ssNtkFrhIdifxzLzkc3fDPizUxpKrjmnr6UEvpAU1UhXZ62k
X-Google-Smtp-Source: AGHT+IHhJIoOphxVKhmWmmKjq29jIYBLCsWBccEN8ZbNLrKJ6c6VCv3EmW4t5yVT7uEqTdAjLsEgVQ==
X-Received: by 2002:a05:6000:5:b0:374:c69b:5a16 with SMTP id ffacd0b85a97d-37cc24ca382mr433421f8f.50.1727218906570;
        Tue, 24 Sep 2024 16:01:46 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a54dd4sm1345465e9.45.2024.09.24.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:01:45 -0700 (PDT)
Message-ID: <66f344d9.050a0220.3a46fd.0723@mx.google.com>
X-Google-Original-Message-ID: <ZvNE1qfnCfFPm6hV@Ansuel-XPS.>
Date: Wed, 25 Sep 2024 01:01:42 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RFC PATCH 4/4] dt-bindings: mmc: Document support for partition
 table in mmc-card
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
 <20240923105937.4374-5-ansuelsmth@gmail.com>
 <20240924225343.GA413172-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924225343.GA413172-robh@kernel.org>

On Tue, Sep 24, 2024 at 05:53:43PM -0500, Rob Herring wrote:
> On Mon, Sep 23, 2024 at 12:59:33PM +0200, Christian Marangi wrote:
> > Document support for defining a partition table in the mmc-card node.
> > 
> > This is needed if the eMMC doesn't have a partition table written and
> > the bootloader of the device load data by using absolute offset of the
> > block device. This is common on embedded device that have eMMC installed
> > to save space and have non removable block devices.
> 
> What if the partition table is written? What does one use? One of them 
> or both and merge them?
>

Hi Rob,
thanks a lot for the review!

The block code parse partition table with some kind of priority system.

Example if cmdline is found, then anything else is ignored. (simple
logic, first parser that match an expected structure win)

We apply the same logic. So with partition table defined in OF, then
anything written will be ignored.

> > eMMC provide a generic disk for user data and if supported also provide
> > one or two additional disk (boot0 and boot1) for special usage of boot
> > operation where normally is stored the bootloader or boot info.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mmc/mmc-card.yaml     | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > index fd347126449a..fab9fa5c170a 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > @@ -13,6 +13,10 @@ description: |
> >    This documents describes the devicetree bindings for a mmc-host controller
> >    child node describing a mmc-card / an eMMC.
> >  
> > +  It's possible to define a fixed partition table for an eMMC for the user
> > +  partition and one of the 2 boot partition (boot0/boot1) if supported by the
> > +  eMMC.
> > +
> >  properties:
> >    compatible:
> >      const: mmc-card
> > @@ -26,6 +30,48 @@ properties:
> >        Use this to indicate that the mmc-card has a broken hpi
> >        implementation, and that hpi should not be used.
> >  
> > +  "#address-cells": true
> > +
> > +  "#size-cells": true
> > +
> > +patternProperties:
> > +  "^partitions(-boot[01])?$":
> > +    type: object
> 
> You don't define this is fixed partitions with a fixed-partitions 
> compatible. Why not reuse that? Then this all goes away with a 
> reference to it.
> 

My problem is that the fixed-partition schema in MTD have some
additional property that can't be supported.

Ideally I should define a generic schema that can be shared and then
expand it in MTD. Any hint on the directory structure tho?

Where should I put this generic schema?

> > +
> > +    properties:
> > +      "#address-cells": true
> > +
> > +      "#size-cells": true
> > +
> > +    patternProperties:
> > +      "@[0-9a-f]+$":
> > +        type: object
> > +
> > +        properties:
> > +          reg:
> > +            description: partition's offset and size within the flash (in sector
> > +              block, 512byte)
> 
> Units are sectors? Use bytes instead because everything else does in DT. 
> 

Ok will try to convert value to bytes internally.

> > +            maxItems: 1
> > +
> > +
> > +          label:
> > +            description: The label / name for this partition.
> > +
> > +          read-only:
> > +            description: This parameter, if present, is a hint that this partition
> > +              should only be mounted read-only. This is usually used for flash
> > +              partitions containing early-boot firmware images or data which should
> > +              not be clobbered.
> > +            type: boolean
> > +
> > +        required:
> > +          - reg
> > +          - label
> > +
> > +        additionalProperties: false
> > +
> > +    additionalProperties: false
> 
> Put the indented cases of additionalProperties/unevaluatedProperties 
> before 'properties'. Easier to see what they apply to that way.
> 

ack.

-- 
	Ansuel
