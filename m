Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415E199EBB;
	Mon, 14 Apr 2025 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611155; cv=none; b=s2P1uxHhHgtyz9x7QF1cMeBXo2873xsS3LmpE1jIUwr7FMq1LCgpS2LxFQOhvIt/7GajUr/TV1I9FJtrcUrLSP4Zy38NJSm+ddkKSkONMD7GaZpx5QTrWtUp60oMcHSjZ7WRl7c14S9P9i+CQxFci+nJGoNEvcn478UJb5JevaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611155; c=relaxed/simple;
	bh=8MksK2DEf2rFH3dMIh//sigVgHD7ef7c82o84kELogs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn/s0sbnyPDDZXi8eSqfztzhEn5r9m8d7mHFD76ISjfV4jVjV3ZPSaceHTSLvMILicqFasTG0stTnqUqIJHznehdxBy38Ft14HZH4imdvfpW3B2enozpu72rHogSSQlr/8OCQxOq9LnH9UH9TU2rGR3YncD2isThxnO5V1rErIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vzQrWLma; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vzQrWLma"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=33Kg15f5EgFF5oe5572PJXG6LcB3N0VYcj227yuB48I=; b=vzQrWLmaWeLUeJBYnpfvpvbsU2
	HAidqISmC4LKDRG1iC4GvFDjltk0DRH1DDbYo5qRxicsUyLAR4hEOeopn0mwVfKpL63efhd9ELEoJ
	eSeJj1P/HjPkxQA+2cwLtYiZR0LVyaZtxVNF/PyHPpmoqLb2sWG0FG4y0wptLmkBEp20803JgGCu9
	hojc9BKmhs88UzdsSBN1N2WfcFlrsDTlAC0sEXngvxMJhqj+FmBxLB10vCRDUQTybbced4xnTEYxe
	boJnyKRzcnq6AS7p+l0lEqP3veMw3AVgzFPADSpmilUCkEWnCv4k4luMCvbfF1ThXr1vFIMnh3OJw
	mMoAQE2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4D3V-00000000m1c-1l3E;
	Mon, 14 Apr 2025 06:12:29 +0000
Date: Sun, 13 Apr 2025 23:12:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yunlong Xing <yunlong.xing@unisoc.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bvanassche@acm.org,
	niuzhiguo84@gmail.com, yunlongxing23@gmail.com,
	linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com,
	zhiguo.niu@unisoc.com
Subject: Re: [PATCH V2] loop: aio inherit the ioprio of original request
Message-ID: <Z_ynTcEZGhPKm5wY@infradead.org>
References: <20250414030159.501180-1-yunlong.xing@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414030159.501180-1-yunlong.xing@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 14, 2025 at 11:01:59AM +0800, Yunlong Xing wrote:
> Set cmd->iocb.ki_ioprio to the ioprio of loop device's request.
> The purpose is to inherit the original request ioprio in the aio
> flow.

This looks good, but has a mechanical conflict with my
"loop: stop using vfs_iter_{read,write} for buffered I/O" patch
that fixes setting the block size for direct I/O.

Jens, any preference how we should order the patches?  Should I resend
on top of this smaller one or the other way around?

Reviewed-by: Christoph Hellwig <hch@lst.de>
