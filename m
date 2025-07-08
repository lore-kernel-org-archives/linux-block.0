Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884E2264C8
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968111; cv=none; b=l4+tNOShTnd97auNFbsXwj0z+1CqVyDfas+yoRNlSssPXYyngw6gn4Cy41iaTt8EljzOZDCA/zFCyFWn5rf5RHA6rRWd3Gi+W6y7N4VoqE1Ta6OpwlxifghLVykIL/6RjbHTVkoHbi4afCIYUA1W3RyECTuKPsTx2YXLTTA+xb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968111; c=relaxed/simple;
	bh=LAQpXsFb3/0GEm8v58bKjJqP4pRbMdJNvXJ0Svahw20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTofLBnWTLuW5SsIA7ZNM+UC23Up5uEc1g0YzIIm/fqYht9MRqnbtatoZEKbhtRugVFz0IuvWEi8piF9GdEYs2SswRVAeOffHTrf64cvrbCOFMuNy8OLSLb6lwM2iuvrQkuA4G5pXMWLyM017KIhSN338yjIQFx3pj2YTGmBetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0349E68C4E; Tue,  8 Jul 2025 11:48:25 +0200 (CEST)
Date: Tue, 8 Jul 2025 11:48:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <20250708094825.GC27634@lst.de>
References: <20250707141834.GA30198@lst.de> <aGznAUVxSl5_Xa3E@ryzen>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGznAUVxSl5_Xa3E@ryzen>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 08, 2025 at 11:38:09AM +0200, Niklas Cassel wrote:
> But NVMe should probably push to deprecate AUWPF, and introduce a new field
> that is like AUWPF but which is specified in a fixed unit, e.g. bytes or
> CAP.MPSMIN. (I'm thinking of e.g. Zone Append Size Limit (ZASL) which is also
> a per controller limit, but the value is specified in units of CAP.MPSMIN,
> just like the Maximum Data Transfer Size (MDTS).)

There's not advantage in having yet another field vs mandating NAWUPF.

