Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559715CD60
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921662; cv=none; b=aIWANtLW+qsAA+XNpD+9rYwXw00cEqdc8JEpIxILp0QMlbQ+FafZui6qKJwGN6UIAVQUxVWPJUEMLxkP1sxKWCu2bs6UdHvKTfibEwdN/byT4ohI+Ket1/beeCN2unTHyA5vl+GgAyUYVSJrbc98s6WoC0aQd1xBRt99vBbIhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921662; c=relaxed/simple;
	bh=DuWVXKAieBNn6Tx6LmhMkTBjadLX/I27dWIMUW5S160=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu0g1JQiBOZVfLL5mp1dVGtdZrbNSxmfqL117Ne2sMFxE4E0qgaHnkE/vV8/wmJnDNsP3J2949cwcg59IKwOUTLukbQ7ZaC7VnvAFmG+BS2wVu8gN+7AzwPE9Hw90tLewuHjNnUAYQP7a1qVLebQ1SCaJwhCWO1xOz2pSSMWhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9EDB868BEB; Tue,  2 Jul 2024 14:00:56 +0200 (CEST)
Date: Tue, 2 Jul 2024 14:00:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	joshi.k@samsung.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: reuse original bio_vec array for integrity
 during clone
Message-ID: <20240702120056.GA16610@lst.de>
References: <CGME20240702101517epcas5p3f651d9307bab6ece4d3e450ed61deb82@epcas5p3.samsung.com> <20240702100753.2168-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702100753.2168-1-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This looks good on it's own:

Signed-off-by: Christoph Hellwig <hch@lst.de>

but while looking for potentially issues with it I noticed the
integrity_req_gap_back_merge / integrity_req_gap_front_merge helpers
that directly access bip->bip_vec.  Given how even the old clone
implementation always clones the entire bvec array this patch
isn't even making things worse on it's own, but if we get more uses
of biovec clones we'll probably run into issues there.

For nvme there current is only a single integrity segments, so we
can't ever hits this code (at least until we implement SGL support
for metadata, which would be really nice - any takers?).

For SCSI mpi3mr can set a virt_mask and supports multiple integrity
segments.  But I don't know if the two can be combined as the
virt_mask is only set when it is fronting nvme and it might or
might not support integrity data for that use case.

