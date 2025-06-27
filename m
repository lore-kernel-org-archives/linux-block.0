Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6A201004
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009824; cv=none; b=uhdS5EAhaMO0lq0KSs7iXHpfx7zFhIH4UUDrhmC5Tpi+4vL4qYFeGQzpZq2vZ2Ttt5AA3D24AvnTlSDyCDY8E/8lv/+/sdzD9i6J8Kw/XHCEvGdbpVYWfP8xyTsmlZ4lNVcOoZDuc/mhx4+tqHT3vAYnV/jIvb0Br+usxi6Qp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009824; c=relaxed/simple;
	bh=8tWM2V7SABVM4Zm2xnFjW1gr4tL1mw3yIKCaSFAN2h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMX4GXWMqJzJ1khUWOwN3Nt3Jt+d2uH+PxwnQ+fwd7lmJOGi+MSKDbecggfEdoO9GR0177qrasW6sW9hrDF2L5gxQwVSkUOK61CvuZ+nIwFOlGM/wLtX4mmi2tB/w8Jm+5KMQieUYz71AjNzUE293euAJxgEKvzUT/L57lrvkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpGiayUO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpGiayUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF33C4CEE3;
	Fri, 27 Jun 2025 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751009824;
	bh=8tWM2V7SABVM4Zm2xnFjW1gr4tL1mw3yIKCaSFAN2h8=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LpGiayUOr3w+byudp9Vy4RuM08kkOqWo1NVWnzU63SVuFqAw8aVhqWLSOYwBZHe56
	 A6J+gBthtqorzmOjenBlFBpuEEQTl3wahl6LNGyu2axbGhty/bB68ds5uqsm0boexB
	 IncpGDv3fOODElQ4Vr66d08lYKbLtsdIGITT+5G5WBA1pnNTRWrcugTY2evyH2sp/K
	 E4KSd4wbMzsmnkiz39sR+2g7vu6IsjrgqFfFAAdX/eAhemWpzKufXbCsZubsxzBLbQ
	 V/swmaccvueJ+yG2Xmwwh57SAE5iWLB9rDcP9cycDaG5KmSbWpXlFE6ab5hlDBSNNM
	 7uT5Vu2ICs6XQ==
Message-ID: <cddf9f29-c2e1-4b9c-b3b7-c64e3a513bf4@kernel.org>
Date: Fri, 27 Jun 2025 09:37:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: new DMA API conversion for nvme-pci v3
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250625113531.522027-1-hch@lst.de>
 <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2025 18.38, Jens Axboe wrote:
> 
> On Wed, 25 Jun 2025 13:34:57 +0200, Christoph Hellwig wrote:
>> this series converts the nvme-pci driver to the new IOVA-based DMA API
>> for the data path.
>>
>> Chances since v2:
>>  - fix handling of sgl_threshold=0
>>
>> Chances since v1:
>>  - minor cleanups to the block dma mapping helpers
>>  - fix the metadata SGL supported check for bisectability
>>  - fix SGL threshold check
>>  - fix/simplify metadata SGL force checks
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/8] block: don't merge different kinds of P2P transfers in a single bio
>       commit: 226d6099402d8de166af60b2794fc198360d98fb
> [2/8] block: add scatterlist-less DMA mapping helpers
>       commit: d6c12c69ef4fa33e32ceda4a53991ace01401cd9
> [3/8] nvme-pci: refactor nvme_pci_use_sgls
>       commit: 07c81cbf438b769e0d673be3b5c021a424a4dc6f
> [4/8] nvme-pci: merge the simple PRP and SGL setup into a common helper
>       commit: 06cae0e3f61c4c1ef18726b817bbb88c29f81e57
> [5/8] nvme-pci: remove superfluous arguments
>       commit: 07de960ac7577662c68f1d21bd4907b8dfc790c4
> [6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
>       commit: 235118de382d6545d3822ead0571a05e017ed8f1
> [7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
>       commit: d1df6bd4c551110e0d1b06ee85c7bca057439d28
> [8/8] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
>       commit: 0c34198a16a88878aba455bebe157037c9ab52c5
> 
> Best regards,

Do you still accept new tags/trailers?
