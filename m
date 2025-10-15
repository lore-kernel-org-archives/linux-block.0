Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BC1C5496
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501317; cv=none; b=I9PkkcawBADchE+H6n02IcOMBkfRm7X4e0ZEWr32pDHN5ITpNrS272wkNhFRdhQ+t9WNQxKGcraRZwmt0ef7N5DWCArijYPf2XsqhAGiKxxeWjKp7gXTyDmRTU6dK7YYoUxWXD/ZlgGBgfKvzliYH5qIdT1X+g1G6tIAo8wsOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501317; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Moiu/neR70tcrma/BCURe3+gsnCZYYj95AfzFfCuRBqMDtZL9fn3Fpu59SBgxoMvz24kg20D7q1NmNraGmUwdgm4rHTpmId3p7N/fYiVsjlLFCshweok/P7mTMw0pBgrjseGKfknEnrH+rsgJmwYgnicXZuX70zOdXVZzJdr6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69B5B227A87; Wed, 15 Oct 2025 06:08:23 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:08:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251015040823.GA6880@lst.de>
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014150456.2219261-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

