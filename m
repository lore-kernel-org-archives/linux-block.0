Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41852DF13E;
	Wed,  1 Apr 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052464; cv=none; b=DAHglvrDUd/f3BISjemzjCTOzklPJ/o71tgmsfL6TdzuCrc/q3JSjb52b7sTjSf1gtn0pwQ3fk0OBFQE+SmQLWk6kOOF/9H20Pd9LjGXQoqcrmF42q0Fnw7OutRDzYl0wOpaPQX7OhBWfVQQpwnbW9s3qkU8hiyvxC6aO6WM2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052464; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA2MHdc3dpdTVkJIF6iLVOOQ61hD/lWCNoTfXW5oebP4slFQ5ydy93QQZB3HOMyVilhg7VOf+ELNn4AzoKbLG9/wfOBAKekTISfeLHm4E1jDDL90+ieEyCi7l9Oj9Mj2LxjGMY5eMWkLhBCefeFSV4jXyTZWPiDdXZaPG2Oo2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7817868C4E; Wed,  1 Apr 2026 16:07:39 +0200 (CEST)
Date: Wed, 1 Apr 2026 16:07:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] block: add pgmap check to biovec_phys_mergeable
Message-ID: <20260401140739.GB21703@lst.de>
References: <20260401082329.1602328-1-namjain@linux.microsoft.com> <20260401082329.1602328-2-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401082329.1602328-2-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

