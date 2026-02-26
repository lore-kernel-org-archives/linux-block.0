Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D43F23BE
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120024; cv=none; b=GZMOV50+cMcYIysRs5xeTPWFpwl+J5ffkrK6D6Xty9RleL5FNUKrB3B5gW5dzSiTMIFOOxuMLqetyO18TDwXRmmafdq5hEQWq4ZslvSqzsBz4kBiOlPA8DDxUDoAvVk1IPXz8W05PFgwq/bPRmDW28XhV+w1gZfKPVCAUnH/Bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120024; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpbnpPIJWIuI1fQW9Inlib3NfEy8kPfuPkmUetlytyBkjUw9eQE1ninFIe719Gx3nB+viu1petu0/n41f4hkbDEwDoqD9iU0OM9QdCuL4YRUVd9q9trNZf0NW72tPUOAB4CFOyThhxsq0tAGOhjAEP6WhIq/Ag/EHC6l80k7BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 063D868C4E; Thu, 26 Feb 2026 16:33:40 +0100 (CET)
Date: Thu, 26 Feb 2026 16:33:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, wagi@monom.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 2/2] block: clear BIO_QOS flags in blk_steal_bios()
Message-ID: <20260226153339.GB31398@lst.de>
References: <20260226031243.87200-1-kch@nvidia.com> <20260226031243.87200-3-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226031243.87200-3-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

