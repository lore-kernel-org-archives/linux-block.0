Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841392E7F03
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113512; cv=none; b=OZwbILHCkCbWZNCOXMGyegJqCt+78x2xRCEfCA4qKYo0/xSmvu+EtoTW4DljE0MBmB/9vnLZVjoHTF7FTi9GlK2N35qk+KmHmIOvVvnGU2XSW0EjDaGXE2yuKBw7qMjRpCywIvuy1wIgfeB4+wRsQGQPbsVzuMY6Rf/h2sT7gVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113512; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyO2J/dhk2901Jlwwsb3fmGVsbjMKJaOTBN1Fb5SOU09+aB+7gzNpOR5iABG2AJG2Aj1I8l5Cn5Q8o6ZTd0y6aNd9/LauvQ7Uyb/ecsdvq1yij04kvgOqA2UF+/BN9TGxupAla8r5zTPObEw4xwiTuP0L+lZmUUtLOyeJmwDB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D5FC1227A88; Wed, 22 Oct 2025 08:11:45 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:11:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	ming.lei@redhat.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] block: rename min_segment_size
Message-ID: <20251022061145.GA4317@lst.de>
References: <20251020204715.3664483-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020204715.3664483-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
