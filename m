Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567617A5BD;
	Sun, 29 Sep 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727615643; cv=none; b=kvTkJgN6YrDAM2lROCNAX+uw+2rh/JmbRfGDuklLvXsDiwnmfIQKcZ7fjuU1h+2PstEq06J3K3sgZukeanhOQVOfXgp++K0OhO1Dxw2yN6+ZSG/+BODO/fTzla55U0AyjcN2vNa5VX+qc1n8iGK5tw236pikL7BqdXL9/vfkTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727615643; c=relaxed/simple;
	bh=j0dKc3yhBOgL2knFOA/0CV+Tdfh+N5XOfQDFyGorQSg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3/AY76p/Ak7Nh82lOWKbkkI2Ramt7MoNILjT+/i+HDhLeplqwb9/OZVhkE4EhoFsGEjuCo8LhSp5TBLgUHniXot9e4KcZsJNJ4OLLaxp3xdM4ahefks4N+73iXDxLcdHkn7Ai/srjhPKQSPOcpRofJWJQoO07KomgccZqoCo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHXR6RXf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHXR6RXf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so28422425e9.3;
        Sun, 29 Sep 2024 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727615640; x=1728220440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tIfkI/k5mUOou3QQlG3Flb+/Aulbsc0ROAg9MJCB1rA=;
        b=hHXR6RXfDmkkVBZ2EESD5RTiLgWSU5PX0UyBhzsxmeJw0+WmbcLU+Tk6CvQHWS0sfp
         9rRprdCeSc04lAUTbuphtRQXwPd92JgCRdEHl2nNqev++NhenikKjcxuMHOa8OotUAoR
         jjsVsCKzTVXVR+p0ZZ66KwY6FUsej+vjiOs5JUDOV0P79BVSVtVt1gbHq6tKhEf3asC/
         w7EoYWVcjaD2OdUzOL/bNSUZOLFZL6xKexU+PtImpdD3Cam5Ee5RDwiwj9DPLjG35605
         XJmK2XGkx0Hdsy6o0PxcZ5Dz+C1BX/l7d/H7N7Nqg9yvpnQg1Y4CRA/vp6n++XLr1kWU
         6cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727615640; x=1728220440;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIfkI/k5mUOou3QQlG3Flb+/Aulbsc0ROAg9MJCB1rA=;
        b=nVP8uxE3SOh7pVj7T6epgjVW73ExOf1NZjyVk3jhSliVkNAwifVSFRWoxRlgjWZPuy
         DvsOQnpbh0zGof1GiZIrfpjZMG8Pj39W/TUk0HL9oQ5ZsxO6ytsDw4K3rS6TiH6fr7nE
         EGZWi6oWtzLQcE52eSLY7lg0YsxazEV/wRlTwQXfuUNdD/hgN1EbTM9aJ7WKD2yCO0Tg
         8rEjRnf5V7rV5WFOgdAr31b5BaSCXV6bhzBfWjYXRp+eTZPRWSkAW5M6kI1PuEy4Yep3
         MZlWwJjOFO3ih/GrAuxCioN8F5/qXhMM67tMOybkgRYCb8vQZV/jVxOzeVKBxkt6WbNS
         Xqcw==
X-Forwarded-Encrypted: i=1; AJvYcCUPpnfeszDbos3GRYXz3r5fje5Dd94Lr4fraTnxFqgr931tmuO/MgLvJHawlNmjgfY/j4UdKreCt5xH@vger.kernel.org, AJvYcCUmzMFi81PjoHyulZarn8x8uqIqkoE83zuBahMT0pbkTZ72OexaZnCf4U2/TpRvkUxx83kUp57w2oYc@vger.kernel.org, AJvYcCVC27liEDlnCaPEAAcZWgHHVUCaMN8xXvRtwB8K8FYSGueepX2/gRcty8+cNrkWFeJyAZNdWuiZEmCh@vger.kernel.org, AJvYcCVFoicfwm60pA1gz54fXggDh46k6TjA2dXtsd6zoOjQOD8hRBf8GSIiHfZkGzBFyIZKS4+AI4Hrzq2IV+oe@vger.kernel.org, AJvYcCWDDfPQoFLfGD91rEz5+BfSDPd/2IjD4FvdScqVlhfPKu3X6xubRJG6ui6E8mteoQEvh9TeniCGOxw5cj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhk2TaQwhkvrp3YpLMTPDB7XHvqtBruKRjJtDfR/nkGvSR307
	u1iyE4eHKa4+J3w/npXbu/+/tqE01RYfIerkPStXPlcBv8P/ZiNn
X-Google-Smtp-Source: AGHT+IHaZE8qeiri03N0inPTGys9IBvkOvGroq5f+OgTAi0LQdMR6CD7GKs6HkbHM02iugLdROZ+NA==
X-Received: by 2002:a05:600c:3552:b0:426:6eac:8314 with SMTP id 5b1f17b1804b1-42f5840ef00mr71570555e9.1.1727615639673;
        Sun, 29 Sep 2024 06:13:59 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6875sm6837684f8f.55.2024.09.29.06.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 06:13:59 -0700 (PDT)
Message-ID: <66f95297.050a0220.221772.5da3@mx.google.com>
X-Google-Original-Message-ID: <ZvlSkRi60iluQduI@Ansuel-XPS.>
Date: Sun, 29 Sep 2024 15:13:53 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Glass <sjg@chromium.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RFC PATCH v2 5/5] dt-bindings: mmc: Document support for
 partition table in mmc-card
References: <20240925214544.6114-1-ansuelsmth@gmail.com>
 <20240925214544.6114-6-ansuelsmth@gmail.com>
 <20240926141541.GA2625953-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926141541.GA2625953-robh@kernel.org>

On Thu, Sep 26, 2024 at 09:15:41AM -0500, Rob Herring wrote:
> On Wed, Sep 25, 2024 at 11:45:25PM +0200, Christian Marangi wrote:
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
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mmc/mmc-card.yaml     | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> > index fd347126449a..58b6593a0f60 100644
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
> > @@ -26,6 +30,30 @@ properties:
> >        Use this to indicate that the mmc-card has a broken hpi
> >        implementation, and that hpi should not be used.
> >  
> > +  "#address-cells":
> > +    const: 0
> > +
> > +  "#size-cells":
> > +    const: 0
> 
> Don't need these properties.
> 
> > +
> > +patternProperties:
> > +  "^partitions(-boot[01])?$":
> > +    $ref: /schemas/block/partitions/partitions.yaml
> > +
> > +    patternProperties:
> > +      "^partition@[0-9a-f]+$":
> > +        $ref: /schemas/block/partitions/partition.yaml
> > +
> > +        properties:
> > +          reg:
> > +            multipleOf: 512
> 
> I was going to suggest this, but I think it won't actually work because 
> it could be 2 cells for address and/or size.
>

While checking I was surprised for this multipleOf and was very happy to
have something like this but I also had some fear it didn't work due to
the 2 cell thing... Very sad. I will add a description to it.

The driver will validate the values anyway, at least on that part we are
on the safe side.

-- 
	Ansuel
