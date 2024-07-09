Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3D823CB
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506037; cv=none; b=kF5er2T59cw6plYZKFeMLfySDOfc5ROZTl28Etqfcn8Dytu3Vy6zs0HUGea1E9Bf2IxnyQoMg7iyvuyz2dihATSJcm0AoldtUCe/gntVmEQVQTiM3zXLUmoRvv/8odI1xZyXspiEjzhxFV4VCQTrM/d6isjHkXAy4R80WXcEFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506037; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2/An3Ze151sFupaMGH9WQCMLVEdJSeiUHDnloZ5/3hmYy1VB0PPyllOUpEA+11nSSpJBPWVxzqiaY5HmH9FQhodCJdlrhBz5r1aEhf+pmhyull1+hqH9RJSmk2Rn2ZZvvHHC7fBcREjOVm6EgSdjDvBxkrPcyEhkoPJVi19PkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12D2268AFE; Tue,  9 Jul 2024 08:20:33 +0200 (CEST)
Date: Tue, 9 Jul 2024 08:20:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH] block: fix get_max_segment_size() warning
Message-ID: <20240709062032.GC16180@lst.de>
References: <20240709045432.8688-1-kch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709045432.8688-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

