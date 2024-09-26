Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E69474;
	Thu, 26 Sep 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360142; cv=none; b=r/0oeG0UQ0C+OpFDkDn4iL+y49jlK3mws52567W9+Ode5wh8+enben3ijCCky37YZvfFnxzm73HMU+BWEUZ3A+yH1c6sLBZDLc4bVrNb5uQLx1ce6zhepmgQNWfU7s5ZsBF7FQm4zG/gy0apzLbosjHqzS+ZL5cuLjpgSpUuBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360142; c=relaxed/simple;
	bh=Kv1Cdy6l+gouokDZ3e4xVwNd6beXKTj/+T6t59ybc2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBjac+CexHR0HAFZlQ30Vng14sRpVgZnAUrVs0haY7+xDLTIEauLdA+0EEIxgzUxrL1gKJHyP2QoaqVyeTaG+W+zbXgg5W57VisUMryU3WzLF9pFBn9O8hoPFDbzPOR9o8CgzuegFbNiYnmqvC/Kpnm0Frq5kvTwNJm0UnEsTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7B2f0rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7B2f0rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECBCC4CEC5;
	Thu, 26 Sep 2024 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727360142;
	bh=Kv1Cdy6l+gouokDZ3e4xVwNd6beXKTj/+T6t59ybc2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7B2f0rcTDtiVBhyi6eeIT3fTA82VCjbUR0AY1bfVe8pnmhl8uVy+JDFnVDxuikdY
	 blzfgrjf+udZhHHqnk5feo9ATaHui45Hp3V9VvMylh8yxWbARg/0VreYeJ4uOnDX+/
	 BErfw9UvWnepSpuMxj5lmJ5due2iWYH5iUNrBwU5+iEpru8pYYGem9HZjr1/CM4jQ0
	 n2/r+GERvb58j5IGvJq4I1gWuUDOiWT8f3oi8L2xhQU+InsAO2GWA1zXZdwkWtAtyA
	 UfKZd0SNxWLg46UCZ1vKg8jlsxeaOHjSVuE9qNgD2HA2OKj2MVQDBd5KIMTIeowgmD
	 fCg9LNU/RxXKQ==
Date: Thu, 26 Sep 2024 09:15:41 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
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
Message-ID: <20240926141541.GA2625953-robh@kernel.org>
References: <20240925214544.6114-1-ansuelsmth@gmail.com>
 <20240925214544.6114-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925214544.6114-6-ansuelsmth@gmail.com>

On Wed, Sep 25, 2024 at 11:45:25PM +0200, Christian Marangi wrote:
> Document support for defining a partition table in the mmc-card node.
> 
> This is needed if the eMMC doesn't have a partition table written and
> the bootloader of the device load data by using absolute offset of the
> block device. This is common on embedded device that have eMMC installed
> to save space and have non removable block devices.
> 
> If an OF partition table is detected, any partition table written in the
> eMMC will be ignored and won't be parsed.
> 
> eMMC provide a generic disk for user data and if supported (JEDEC 4.4+)
> also provide two additional disk ("boot0" and "boot1") for special usage
> of boot operation where normally is stored the bootloader or boot info.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> index fd347126449a..58b6593a0f60 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -13,6 +13,10 @@ description: |
>    This documents describes the devicetree bindings for a mmc-host controller
>    child node describing a mmc-card / an eMMC.
>  
> +  It's possible to define a fixed partition table for an eMMC for the user
> +  partition and one of the 2 boot partition (boot0/boot1) if supported by the
> +  eMMC.
> +
>  properties:
>    compatible:
>      const: mmc-card
> @@ -26,6 +30,30 @@ properties:
>        Use this to indicate that the mmc-card has a broken hpi
>        implementation, and that hpi should not be used.
>  
> +  "#address-cells":
> +    const: 0
> +
> +  "#size-cells":
> +    const: 0

Don't need these properties.

> +
> +patternProperties:
> +  "^partitions(-boot[01])?$":
> +    $ref: /schemas/block/partitions/partitions.yaml
> +
> +    patternProperties:
> +      "^partition@[0-9a-f]+$":
> +        $ref: /schemas/block/partitions/partition.yaml
> +
> +        properties:
> +          reg:
> +            multipleOf: 512

I was going to suggest this, but I think it won't actually work because 
it could be 2 cells for address and/or size.

Rob
