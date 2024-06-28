Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2046544
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554544; cv=none; b=ejttqmk52o3fQa6PHryrfIqdqXlHMBjdD7l8BgRXtynJxPqT8+wkcsVjU1CII/1P0trTu6lWvO9r/cfyVxW4dpt/VhE956WRDkKf/mhX9HH7bs3/9Xf9O8H3CNdCb7Zv199ALZhIEeIaIdDUzMXRwyZjzVCXli1Or250cc6xDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554544; c=relaxed/simple;
	bh=FoZ9unpsc4wULLUpRjoYYMI1GjsJk3aX0rrAHijN+8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMCRXwJFLhWOyCGcEc9OsjSrp6y7mVi3/efev2B19B5dkFbV101bVTz8RhsKtC0ZBqDtGUr2faSb45ZqDbua0aHPX7tjLauxxTDsKlrP1q+aefLIqrePpuY7EeF75k1WJBAx8xM8ltmdjEzaxZg8JbAWKPYr1KMkTx81D5q3VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D09268D05; Fri, 28 Jun 2024 08:02:19 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:02:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 5/5] block: remove bio_integrity_process
Message-ID: <20240628060218.GB26206@lst.de>
References: <20240626045950.189758-1-hch@lst.de> <CGME20240626050052epcas5p29fc1cf1ef40fdec63860f6d6df9ffad1@epcas5p2.samsung.com> <20240626045950.189758-6-hch@lst.de> <a7fd0e31-63bd-8fff-d7d4-6ba990098e7a@samsung.com> <20240627154759.GA25261@lst.de> <d482d9a0-9d9f-1b4b-5511-c787f43a31af@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d482d9a0-9d9f-1b4b-5511-c787f43a31af@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 28, 2024 at 12:03:09AM +0530, Kanchan Joshi wrote:
> In general yes. Maybe I can profile this particular case someday and get 
> myself convinced. But regardless, I am unsure what the patch buys.

It avoid a pointless indirection that make the code hard to follow.

