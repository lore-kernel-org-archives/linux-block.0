Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468522;
	b=IrD03AIiqKXsVI+JavWJ0d13Ety455AvP7GKcI6WBYI9Vsf4N7OoENejvM+AEmAiOpLP
	 fY0d3MfBnF2nMobMqQUr8BqUFuzIz5x3MzK1MybdWn8DEWBt25jgKessmbGs8xdT7MIiP
	 HtBdV5XofyibYAi67i83a6WUoCP136RJ5ypjOKtF969mW5liiphjaf8lSRZChCBMl5n85
	 veUl2xIWPvgurVem5lulxbUXPFUgkZJPWS4exBxZ5bQcLN1DNiAP+BI8XbIzpbGz9fJhK
	 NIIAIP2PtMVOx+WpSGcZO1r3PLPTS6rbAEptrp34Pz4FNiwskFCBfbDVu5qp5vaI8Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468522;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Pa5EdlkdDb/8+dEJ6DLCijzWJy6bbnHlLA0WayAjHwA=;
	b=zZbaQBd1hOCApb26gXvpvFFjMy3HQXnQHmWi1eUGWctuE5X2lPN9txBvkVfBF6+B6Elt
	 1IxUizdhjCPIJ01mqcaW83QGWJJMd/EXOxiLbwFaS9bb01q21pBjVvnnAfx9Z100crVfi
	 nYb9FRxsCFGzmfMor/bervD3lomX7zofzV+BwsLuBXxfHYa4KJPk6TygjRyHfkk4/DELk
	 qrLcJs1K4lQFj4z7JbDA72KHVJqrX2b4eX3I3LCCJ+8tYTCFM4Kwp+Umju/rLDHyKyuaj
	 2e/NQQVigXtIlxn9WehydmaqcG5P5mb33nwG6BM6NyslMyJ6xu+Vi8n4HLDgopqKnYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJiFhBSx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF11606A31E;
	Mon, 23 Nov 2026 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJiFhBSx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91401F000C6;
	Mon, 23 Nov 2026 21:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468521;
	bh=Pa5EdlkdDb/8+dEJ6DLCijzWJy6bbnHlLA0WayAjHwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kJiFhBSxHPORYVNKPHnnY4+Rqmcrw7VtygV5tDRb7+pvruQZMuKdbNQcNpb0YwzK1
	 gVtYh7g8OYIKdzL53h6AgG7LpsuYjY4mMZUu/stx+7HuPwCjZoJu0QihYddGCC9kKV
	 OtE2nOsiwrY1A+jkUOZ1FbI3R2sgNEZLQ7Mfqizjze7K67Q6p+rPdSFsw+fkEIGIbM
	 qgRkAXuK1DdXAwnxcudxQdsV0HlJ7ue9aeywjslEgLXX2t8y+O7Z/+XNz8N8ga6ki5
	 e9XCvZtJrhU6XRvuIr9OXeHxUz1gH5PZN8mtUjA/akZoApPDD6JyTd7GZJrQ7ZJ4eh
	 TzADUz558OY5w==
Date: Mon, 23 Nov 2026 22:15:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	regressions@lists.linux.dev, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
Message-ID: <awSs5Cw3hFkf4O4T@ryzen>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>

Hello Tobias,

On Mon, Nov 23, 2026 at 06:51:03PM +0000, Tobias Laas wrote:
> One way forward could be to a new entry to __ata_dev_max_sec_quirks
> similarly to the recent commit a12cc63129380a5364e787d92b30a3257f66c250
> ("ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8"). However,
> I wonder, whether that would fix the underlying issue or rather be a
> workaround, because 4088 does not fit the pattern of all other entries,
> which specify either a power of 2 or a power of 2 minus 1.

Your attached kernel log shows that you have a
Samsung SSD 860 PRO 1TB, FW: RVM02B6Q

This SSD is probably quite common, so I somewhat doubt that it is the
SSD that is at fault here.


> 
> Furthermore, the first error messages are DMAR faults, and a SATA SSD that
> isn't functioning properly shouldn't cause any DMAR faults, because the SATA
> controller should never read from or write to areas outside its memory
> region.
> Since the issue with mounting the rootfs disappears with intel_iommu=off, I
> wonder, whether there is a limitation on the maxmium block size either by
> the hardware or from the configuration of the IOMMU and SATA controller by
> the kernel.

Considering how common your SSD is, my guess is that it is somehow an
IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI tables -
DMAR on Intel).


We have seen similar reports here:
https://bugzilla.kernel.org/show_bug.cgi?id=220693
https://bugzilla.kernel.org/show_bug.cgi?id=221713

Does it work if you revert:
d373449d8e97 ("iommu/vt-d: Use the generic iommu page table") ?


It would be nice if we could involve some Intel IOMMU experts.

If the ACPI DMAR is at fault, perhaps it is possible for the kernel to
patch the ACPI DMAR for your platform.


Kind regards,
Niklas
