Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4E146D45;
	Tue, 24 Sep 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218424; cv=none; b=lgSgBZKg0cQX8x2oYVTKwVwuPRscWNUvriUeFnTbNE+x8V8vAZJZB0B2TDJmxzCtkJcE3zZ4NdzqbFkVABSGfCse8o/bENk0jMXRwOU/VKtpoiYReSpJzTh5zbCgy3Z+Pf4GzslQJx6Rd4qMIttGcnpvccVL9puvog1KNXrNs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218424; c=relaxed/simple;
	bh=HoKonSrSZvECoNi9zyjpJDqIafnrRE2PE9Rf0LooWAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZyAPWlT0OgC3d5gWW2/FhMD8i3zfvaY1IZYZMDg/dF0K5LlImmGykY+dRK1f4asxaMwKpZBvAiRsuEq/NfnvLp8VOIH8cp6BnlOvhTsf22wRxHOB2nRIk5uUorZBYt9XgQQEB9HzhwvHpbRbPSrgK73UrPh608aTUu8GuCidn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7aMvoOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7aMvoOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F99C4CEC4;
	Tue, 24 Sep 2024 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727218424;
	bh=HoKonSrSZvECoNi9zyjpJDqIafnrRE2PE9Rf0LooWAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7aMvoOrqN1PhSj7sH+w4Qxn3eO0hOF/URnIPfrJ3mldH3a1bSrqFhPr/5il/wN+d
	 fFsEtrhb43Ve9r6o0G63Ba7XicO5aTY1bQAcUtOHqzB54RbjcDmIOh1vBWaSCgCFmv
	 XZd3VkDeoQBHLzHL1zYDAl8CZSr+0lVJY+E+Pdw5yb+4uRarwIOh3ZEV8nQK+9aLGy
	 JBV05yp9mSAP+z22wABAtryYhzUs01YjjbfXEOVSciwtNqaTVG1g8TYEQZCUXJhKq9
	 KVuwI6EEjcnkGqLJjqLxi8JBqEFU26unJx2zkqj+RuOuqTWBkbCyQ46fmpH1/ZU+5o
	 5v0COFRir9vCQ==
Date: Tue, 24 Sep 2024 17:53:43 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
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
Message-ID: <20240924225343.GA413172-robh@kernel.org>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
 <20240923105937.4374-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923105937.4374-5-ansuelsmth@gmail.com>

On Mon, Sep 23, 2024 at 12:59:33PM +0200, Christian Marangi wrote:
> Document support for defining a partition table in the mmc-card node.
> 
> This is needed if the eMMC doesn't have a partition table written and
> the bootloader of the device load data by using absolute offset of the
> block device. This is common on embedded device that have eMMC installed
> to save space and have non removable block devices.

What if the partition table is written? What does one use? One of them 
or both and merge them?

> eMMC provide a generic disk for user data and if supported also provide
> one or two additional disk (boot0 and boot1) for special usage of boot
> operation where normally is stored the bootloader or boot info.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> index fd347126449a..fab9fa5c170a 100644
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
> @@ -26,6 +30,48 @@ properties:
>        Use this to indicate that the mmc-card has a broken hpi
>        implementation, and that hpi should not be used.
>  
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +patternProperties:
> +  "^partitions(-boot[01])?$":
> +    type: object

You don't define this is fixed partitions with a fixed-partitions 
compatible. Why not reuse that? Then this all goes away with a 
reference to it.

> +
> +    properties:
> +      "#address-cells": true
> +
> +      "#size-cells": true
> +
> +    patternProperties:
> +      "@[0-9a-f]+$":
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: partition's offset and size within the flash (in sector
> +              block, 512byte)

Units are sectors? Use bytes instead because everything else does in DT. 

> +            maxItems: 1
> +
> +
> +          label:
> +            description: The label / name for this partition.
> +
> +          read-only:
> +            description: This parameter, if present, is a hint that this partition
> +              should only be mounted read-only. This is usually used for flash
> +              partitions containing early-boot firmware images or data which should
> +              not be clobbered.
> +            type: boolean
> +
> +        required:
> +          - reg
> +          - label
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false

Put the indented cases of additionalProperties/unevaluatedProperties 
before 'properties'. Easier to see what they apply to that way.

Rob
