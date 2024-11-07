Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10D10F9
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730957475; cv=none; b=iL90jwhQj8zhiXfnOKpCnuSFF17htGeBTfUiGijtHI27wEJ/nNdtO0cjhqp6D+m0LRw8D4tT3trLP/6uhj2qLIKMoNdMn8R/2O5lXTRuuciNcvXlwE2TFmUGRTuiGEFSkStQtyWHCuJ+rt5eEuMUEZ6sZe87UQVqdddqKVcYILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730957475; c=relaxed/simple;
	bh=dW/H5htJquks8janIYU5w1VJwV/y+wNZ1zFMFmw0X7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA7+ZmDAcMiMJqWZOy0Reys6UhrjWcW4YSzlPyNNx9kUgAZgoF0SpeqBOM/OHxGZeIIpCcOWW6X+Eh9tRwzv/H39UFmZM2oOtmKrn2bMfDGdFj2fHW+s/fqsU7wxPWb29BHZpHB+7JpVCKThpl2P7YQ+zGIxkKI2tCi3ORBrUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 686DD227A87; Thu,  7 Nov 2024 06:31:04 +0100 (CET)
Date: Thu, 7 Nov 2024 06:31:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: pre-calculate max_zone_append_sectors
Message-ID: <20241107053104.GB1947@lst.de>
References: <20241104073955.112324-1-hch@lst.de> <20241104073955.112324-3-hch@lst.de> <Zyu4XuKxAoVEHKp1@kbusch-mbp> <16adf8b3-e7b2-40ca-881f-ecb5056c3342@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16adf8b3-e7b2-40ca-881f-ecb5056c3342@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 06, 2024 at 10:50:01PM +0100, Klara Modin wrote:
>> I think you need to continue clearing max_zone_append_sectors here. The
>> initial stack limits sets max_zone_append_sectors to UINT_MAX, and
>> blk_validate_zoned_limits() wants it to be zero.
>>
>
> This appears to be the case. I hit this on a 32-bit x86 machine. Clearing 
> max_zone_append_sectors here as well resolves the issue for me.

Yes, indeed.

Jens, can you revert this patch (only the second one), please?

Sorry for the mess.
