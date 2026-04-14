Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0E391508;
	Tue, 14 Apr 2026 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154484; cv=none; b=YV+DWgG2h91PrKUWLqmMMtCTJihMCpmbSNDrotpet2SrbNeIdDDJLZFTWQdHbPdgKWTE6iH/BKNeZgu0uiZrSNY7gm5ViW2+14F2idA+q440KufPLtkMw8IEyFSKdURDsyTDZ7C7ySJYZ166tBk1JWxSYSfOvCjm3laMhefRvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154484; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGvJ2XWCfw4hRnvskBCQdy/NqFbZSJCyFAfM0aPaLun/c6gY9hiXJWHWcjYwstSOLJ48/i+v7MH6DgOzu/gDdb/bivXn6KNzIvGadALw7FfcZ/+SMItn9o5HKBjE8pnZTfJV7NTBfAcLdPV09aAt5nB4QE0aPH3DDG8emYkLE+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65FA168CFE; Tue, 14 Apr 2026 10:14:39 +0200 (CEST)
Date: Tue, 14 Apr 2026 10:14:38 +0200
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
Subject: Re: [PATCH v2 2/2] block: relax pgmap check in bio_add_page for
 compatible zone device pages
Message-ID: <20260414081438.GA11445@lst.de>
References: <20260410153414.4159050-1-namjain@linux.microsoft.com> <20260410153414.4159050-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410153414.4159050-3-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

