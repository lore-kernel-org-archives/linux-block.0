Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A072E7BD9
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299263; cv=none; b=nof5Dp8zgXpCNRrcCjfGMpK7ac35j45YZJws5nziiqYsrEiXTThBJYk4W+s2WeUUyxTqIytO6O7m+L6R9sfJ+b5ZbjhvxHv18ZEvpoJpZq+YJm0my01qohpwdd0mzNzDtVTvtHajIk7DtG5zW5Dgv7pbsDjFH3jCbT8x9YLAOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299263; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgMwGbMFwpptvae81k+U3nbQBtupeWyBF2VsLCQMYF1G5/XQKEsWzJ0Cn78NjUmjpbtSC2m0viLaq1/+j79t/4mOOzuSeN9GFDoQX9Te5tv5SnnN2iLUQgV+HRl0h/pWkADMniYENtCtxqYvOKN4v0DSE8r94Oe1R1RDvI/pn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA56568B05; Mon,  1 Jun 2026 09:34:19 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:34:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v5 10/12] block/kyber: Make the lock context
 annotations compatible with Clang
Message-ID: <20260601073419.GF7799@lst.de>
References: <cover.1779997063.git.bvanassche@acm.org> <5165d212359b6b2ac70f52917282b85ea6c75fdf.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5165d212359b6b2ac70f52917282b85ea6c75fdf.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

