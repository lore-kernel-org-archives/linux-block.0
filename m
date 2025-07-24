Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4922686A0
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353718; cv=none; b=Bt5AAFZPqX25Cw37h2jSe4x42W0ZjGMTgpwlsDR6DYXWYzs0RS2J2MJrE52ro53Dxilfpcn9EtQ9e80oCFGySkMInv+YARqL7iUnRXDNXlw1vGbD5WyqQktl30+evYJxQBhGeVImYOVgtq3Tj+DbFjRxkwUgLBeX9J2mNR8prM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353718; c=relaxed/simple;
	bh=hCF7FdHCRwuJPa8uCwRiYaseY4iI6ylafVZdvfXsxwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEydz/ZtwjWluD5DgcrOIiw9Y7+ERezhxpyTdMTpz06RGNfBMiZD9lwohUu7MM3W5gRHZwWc/MkEbOQNpWQpsoB5l6Cg8ku5qzY8kxao22TwBSK0rACBAvf+eNXnNutgnZQXnAw5YkveslPjzm1ozLFFRq8EFlWTqXrpXGs5ETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz1jGcDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz1jGcDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4335DC4AF09;
	Thu, 24 Jul 2025 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753353718;
	bh=hCF7FdHCRwuJPa8uCwRiYaseY4iI6ylafVZdvfXsxwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jz1jGcDkCGt/pXMc/dACxeV0b7m9wKUifCcYLADSTWfkjaxf3eoEtkL/STQ+JlBrn
	 Bhl6TlwGa9DPZdTk5ChCeHWtRtEN7xHargNfNYGFQJQBx3afoEZG1K12zA1IW78BOE
	 fhOEBeXMzf5l0E0AzK3WV+7KwBoCWQ44ZTOLrkp7g4f4e6k+qVQ1J4kmkLR2KQTEqS
	 Tjf/3vG5ghDr6Ghr9JLclyq4wo0wrkEj1g17ocKDwg8RIkFIvs0iJXp3xhiCu7ioqN
	 kTq3/rQe59jHliOmkQoNly//+H6Wdv3Vi/hUmGxC6bOPMsnM3lGWRvIXYrcvGnvKQH
	 T90YdQ4x4vIdQ==
Message-ID: <aa4b8526-5346-4004-a3b7-abcffd201b1a@kernel.org>
Date: Thu, 24 Jul 2025 19:41:56 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
 hare@suse.com
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
 <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 19:06, John Garry wrote:
> On 22/07/2025 11:26, John Garry wrote:

> drivers/block/virtio_blk.c - not sure, as we use
> zone_write_granularity and I don't know if that must be a power-of-2,
> but from sd_zbc_read_zones() we use physical_block_size, so prob ok

Yes, zone_write_granularity must be a power of 2. Its default should be the LBA
size. There is only one case were it can be different than LBA size: on 512e
HDDs (512 B logical, 4K physical) in which case it must be equal to the physical
block size.

-- 
Damien Le Moal
Western Digital Research
