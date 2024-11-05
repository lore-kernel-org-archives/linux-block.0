Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3C1C07C8;
	Tue,  5 Nov 2024 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804683; cv=none; b=aB0zMj4kcApqhpUV6svCbqlWWcTqs9qQsAMJl9V/QukqYoeQT/PeoPRFN5u0G4zGBcOPllVEj6EfHx9FowzngdnNBx1LSmxE/5ZpxgAnVqzzPuCNuTE9IbCq8J8qburZ741yXDXqu5nlMz31SRDQYXOVJWwJ8+wmVBXRjjrjUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804683; c=relaxed/simple;
	bh=wo1zgfGnEXM+JgIeRtdAg2C2V/ondOuwWv27eag6hiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY5TRTwWsARcyC5/1to4LaabwMM9x8VTnx/zKLa8u7FkoLLTYpJVY7RhN0MsTdSvzWcydu+RdLhhuFypFZSOUA+mzivdUVPtVu3a1FyFq/K6p6GT2NVRWeZ9/n+damhnK9ixkb0zSzGZtp297hQfXA2ojv4WaO1obAEDUhd/6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1270F68CFE; Tue,  5 Nov 2024 12:04:36 +0100 (CET)
Date: Tue, 5 Nov 2024 12:04:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Message-ID: <20241105110435.GA1822@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-2-m@bjorling.me> <20241011081452.GA3337@lst.de> <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 01, 2024 at 04:45:17PM -0600, Keith Busch wrote:
> I've got the rest of the required logs and identifications implemented
> in nvmet to support this.

Cool!

> There's one more issue, though, if we do
> restrict the identify to >= 2.0 or 2.1. nvmet reports 1.3, and I suspect
> there's a bit more work than just changing the value of NVMET_DEFAULT_VS
> in order to comply with claiming that version.

I don't think there were a lot of new mandatory requirements added that
we didn't already do, or already we already ignored anyway, but it is
worth a double check.
