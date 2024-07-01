Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4394A16D315
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847047; cv=none; b=EQK9rmswxTCgxy8M+0LlgqP/79soiBwJ+TKk88p3XUvUwLls2x+ceaqmSfJllsBG4OihKwscFWeYR5I/pl417AvWLr11Ut2HGG0eTTfqXMNthThm3jKtP63w0e+m/EQc1UyNkOtXg69U5szjD1xG1LmJeImmrb5mgGdYAntkcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847047; c=relaxed/simple;
	bh=nBqXWPdH+HPyZrxj8VAstVQAyrTHpZY9fjz1lJEzHT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5dCQxQ07sqNk2ZbKLabeu3505jcmVqOCyLD/O1CqO+0VlBUG2u7ToAkh3y5JQxrnfo3N6zTfvmE4HCCeBnFxwr1pKs040D43lzoggXLM/RxWX6jKD4MhHYFtRZkaQaZL1HCifWc2OTreV5sITV1mHuU8P1R/jL339TRn17kNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D50368BEB; Mon,  1 Jul 2024 17:17:20 +0200 (CEST)
Date: Mon, 1 Jul 2024 17:17:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/5] block: don't free submitter owned integrity
 payload on I/O completion
Message-ID: <20240701151720.GA1820@lst.de>
References: <20240701050918.1244264-1-hch@lst.de> <CGME20240701050934epcas5p4b2a829697ea9e0f90bf510f511abf19d@epcas5p4.samsung.com> <20240701050918.1244264-5-hch@lst.de> <a4c7b88a-7dca-c443-15c0-a0699976f057@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4c7b88a-7dca-c443-15c0-a0699976f057@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 01, 2024 at 06:30:34PM +0530, Kanchan Joshi wrote:
> The patch will cause regression for nvme-passthrough. For that 
> completion order is:
> (a) bio_endio()
> (b) req->end_io
> (c) blk_rq_unmap_user.
> 
> And current code ensures that integrity is freed explicitly only after 
> (a) and (b).
> With the patch, integrity will get freed during (a) itself.

It is supposed to be freed from (c), specifically from
blk_mq_map_bio_put.
> 
> There are two places in bio_endio() that can free the integrity.
> It first calls bio_integrity_endio() - which is handled fine above.
> But it also calls bio_uninit() - which will free the integrity. We don't 
> want that to happen before passthrough gets the chance to unpin/copy-back.

But yes, that messed it up.  I'm kinda curious why it didn't trip up
during my testing of the passthrough metadata code.  That bio_uninit
in bio_endio is quite bogus and I'm a bit suprised it hasn't caught
more errors - the reason why bio_uninit exists is specifically to deal
with those on-stack or embedded into bigger structure bios.
