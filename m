Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999EF54F95;
	Thu, 26 Sep 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359432; cv=none; b=NuJjR0tzDkOIJXikqO7x9NasusYhnqUYm9Bfrfq7wXijKLQb7rjUNpGsO7HlrN/FNKhYy8NRGpm7/H8Nh9w4Ro5PDrpiAk/kxcwj7dHJ98opNtKwwNVp6INN7tWBt87bQLMCtD+O478iarePJLQmDUngHKLrRAvnyyUbLPT30ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359432; c=relaxed/simple;
	bh=jtCshB+kbsn9FzIzIwY86oEMwzDjCbBE1nTqG/gsx9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp99mhI83Xtr/b20oCMSyOIRIb3nxftZKmDLA7TxXpt4RMjonKRuG6evv0xPiJ42cxt4VetRPqeQZPW5qWAFmfqMEG8XhWPLHokzf56ga/kW2rMAAf3tHHffH7YvO41y9vQYmZ1dsUb/dtMMt+nGgAkCCJLJ7CQdTeXjDvzEvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue6+eDGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue6+eDGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085A0C4CEC5;
	Thu, 26 Sep 2024 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727359432;
	bh=jtCshB+kbsn9FzIzIwY86oEMwzDjCbBE1nTqG/gsx9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ue6+eDGlWGKfphSJdEdkbSB0MTnPYtfZ6oX/1NUUtZTB3BncchmRwnjY/aSG9Xqgu
	 vJh7HohBkSAlYbMWvh7cngB2t1BpoMg6fZuNz6zJyeIKHZo6cmQvx67b5SY0+9+Zct
	 2KMSEM0mPDm4K2G27car0LT3NUfn5eXeUEVFzNmF4uKv5o4Pw7H0+bXI2/5q2Gdybp
	 LIv6yuWL2nKqUQyIeAVm0Tc/lMyPpi3RrODjUEA+5AwK/we7lrOZoYy8SM5eDALJJv
	 0vh6dNdKCbD4rjzo6WwTCu4hS6IvmJ9U2UHoyoyISHi6V0n0OZjH8CojCmP/wFW2EO
	 D5Cnl6bdEuVng==
Date: Thu, 26 Sep 2024 09:03:51 -0500
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
Subject: Re: [RFC PATCH v2 4/5] dt-bindings: block: Generalize and introduce
 property for partitions
Message-ID: <20240926140351.GA2596132-robh@kernel.org>
References: <20240925214544.6114-1-ansuelsmth@gmail.com>
 <20240925214544.6114-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925214544.6114-5-ansuelsmth@gmail.com>

On Wed, Sep 25, 2024 at 11:45:24PM +0200, Christian Marangi wrote:
> Generalize property from MTD partitions schema and introduce property for
> block partitions defined in OF.
> 
> Partition schema for block devices is a reduced schema of the MTD as
> only a few property are supported for it. (reg, label and read-only)
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/block/partitions/partition.yaml  | 33 +++++++++++++++++++
>  .../bindings/block/partitions/partitions.yaml | 27 +++++++++++++++
>  .../bindings/mtd/partitions/partition.yaml    | 10 ++----
>  3 files changed, 62 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/block/partitions/partition.yaml
>  create mode 100644 Documentation/devicetree/bindings/block/partitions/partitions.yaml

Partitions are partitions. We don't need them defined in both mtd and 
block. Could perhaps move them to bindings/partitions/, but that's not 
really worth it in my opinion. Just use and add to what's in mtd.

> 
> diff --git a/Documentation/devicetree/bindings/block/partitions/partition.yaml b/Documentation/devicetree/bindings/block/partitions/partition.yaml
> new file mode 100644
> index 000000000000..b9b1d8139e56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/block/partitions/partition.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/block/partitions/partition.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Partition
> +
> +description: |

Don't need '|' if no formatting.

> +  This binding describes a single flash partition. Each partition must have its
> +  relative offset and size specified. Depending on partition function extra
> +  properties can be used.
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +properties:
> +  reg:
> +    description: partition's offset and size within the flash (in sector
> +      block, 512byte)
> +    maxItems: 1
> +
> +  label:
> +    description: The label / name for this partition.
> +
> +  read-only:
> +    description: This parameter, if present, is a hint that this partition
> +      should only be mounted read-only. This is usually used for flash
> +      partitions containing early-boot firmware images or data which should
> +      not be clobbered.
> +    type: boolean
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/block/partitions/partitions.yaml b/Documentation/devicetree/bindings/block/partitions/partitions.yaml
> new file mode 100644
> index 000000000000..9c161aac364d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/block/partitions/partitions.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/block/partitions/partitions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Partitions
> +
> +description: |
> +  This binding is generic and describes the content of the partitions container
> +  node.
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +properties:
> +  '#address-cells':
> +    enum: [1, 2]
> +
> +  '#size-cells':
> +    enum: [1, 2]


Like *all* other 'partitions' nodes, you need a compatible to say what 
kind of partitions you have. It's conceivable that some vendor invented 
their own scheme just like MTD devices.

As I said before, this is just 'fixed-partitions'. If some properties 
aren't supported, that's fine. All the 'align' properties are for 
flashing tools and aren't supported in Linux. 

Rob
