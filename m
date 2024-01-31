Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7177F473
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685692; cv=none; b=edj0RswxhIta63XMMkTMhLFfEY/WEpi9uOdyh4ePftgQQmegfGrFankLjLRWU+MpPQqkR8fyLNsM7EAIWYJlCWvZ8AMwA8ubTfSPsSwM6WMtEl9po9da5CPCMT4d/x+e7dcYNmAFat3pkYnkdZJlxQDoDW/H/7VHZrUvAbhARmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685692; c=relaxed/simple;
	bh=06YxgZu0oOHFE/TC2VvsQm0isOEeapwiCLgcoebzLZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avSD8s9oHRwSWWLpiWlgdGmqReFg/5iFzFexfSgkbXYzGgW9IlFFSrIH3HRm9wC1xb3wtsupYKpkNj2OwCLYhccskKsa91+8zcBFgcFIR3TZkQYsCX6e6USni/KfPowUsXar0RFp3j1w381zOb5O43QyorXicWAYQAa/QiEIrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99E8B68B05; Wed, 31 Jan 2024 08:21:25 +0100 (CET)
Date: Wed, 31 Jan 2024 08:21:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <20240131072124.GB17498@lst.de>
References: <20240130171206.4845-1-joshi.k@samsung.com> <CGME20240130171927epcas5p2814181a20402d08b96393ce4a5e06e03@epcas5p2.samsung.com> <20240130171206.4845-3-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 10:42:05PM +0530, Kanchan Joshi wrote:
> The block integrity subsystem assumes that PI appears first in the
> metadata buffer.
> Abolish this assumption by adding the ability to handle PI starting at
> a non-zero offset.
> Calculation of the guard tag includes the metadata buffer up to this
> offset.

Maybe rewrite this as:

Block layer integrity processing currently assumes that protection
information is placed in the first bytes of each metadata block.
Remove this this limitation and include the metadata before the
protection information in the calculation of the guard tag.

>  {
>  	unsigned int i;
> +	u8 offset = iter->pi_offset;

Nit: I find it more readable if variables that are initialized at
declaration time come first.  Also (with a few exceptions) it's nice
to read longer declarations first.

