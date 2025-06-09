Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745492701DC
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749441531; cv=none; b=WLqRRF3Sscrj9JQXh41hXQlKfyibDfmRezxijzBVc/VkiyYOpGO6h3eOKrGgp7lVgbL5OZSEoL9daoMU88Rw57DZ80YZhlLN/unNLDM7IQ4fKAXl439KJtTmLFtnHkkM3aFxg3slazj1RTEs6X2vItNEEKmSrW4fZMzWr5cLscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749441531; c=relaxed/simple;
	bh=Mg+oGtxc0FmzHbVLRbBtietu5YHFeZT2qLlTPlylHTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuKN1MKrcXV9x+XRLka9EaU49/xzMKlBInkzo34T1lEg9GuyhpxHAS5SkuEJlY7S89eaxL/70ERRGvFTVjWyoz33pMTEYwXKzb+YPrkTDYrBLhPgMr3TZGYudCYpwoHudQ8i0h7fIhOmHSgESyc/5yA/VtIaufNXpt1v3SJbAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65B9168B05; Mon,  9 Jun 2025 05:58:44 +0200 (CEST)
Date: Mon, 9 Jun 2025 05:58:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250609035844.GB26025@lst.de>
References: <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de> <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org> <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org> <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org> <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org> <907cf988-372c-4535-a4a8-f68011b277a3@acm.org> <20250526052434.GA11639@lst.de> <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org> <d8f5f6eb-42b8-4ce8-ac86-18db6d3d03d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f5f6eb-42b8-4ce8-ac86-18db6d3d03d0@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 09, 2025 at 07:47:38AM +0900, Damien Le Moal wrote:
> To be honest, I have never tested the block layer inline crypto feature using
> zoned devices. All the use cases I have with crypto are using dm-crypt.
> A quick look tells me that the issue is with that particular feature, especially
> the fallback path, as it is using work items to asynchronously handle write data
> encryption.

Nothing asynchronous in the fallback write path, just weird open coded
bio splitting like the one I just got rid of with the bounce buffering..

> One additional thing: why do you need f2fs with your reproducer ? Problems
> should happen also doing writes directly to the block device, no ?

Because fscrypt is the only user of the block crypto code, and f2fs
is the only user of that that works on zoned devices.

