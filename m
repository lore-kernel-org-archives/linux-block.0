Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4E2E7BC4;
	Tue, 12 Aug 2025 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987987; cv=none; b=GUVrCmM1HvPCP/Nu1B0raAxdyrWtHFVvzC8WfsCqYV+eT+KKi+Rw8GOmj2HpcwMQqVkLkHIiDUdBeW28qMOhgclSTdROR91F4+LDOAjYuUNvRnIrzpo5YsZwGSAmrPsvLSMAm4WjXikLJ8wSFHw39TZ8hMEXY29yTyAIawuMyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987987; c=relaxed/simple;
	bh=C2MyFsQ/WvSCWpLhb6tLVFKiE70ztNYk07xB3WLqfcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWyKl9sQQbfEEyawdsb0Y5JssNwFDwzCsJlpWgYCEXQ9mqcFPt//dRnAi2r/mxH3MeeQbEYmZzUlpQYJJppXqThTktE3WZzc3OrAlyLC8FVAO7abzxYrYp4C7P6xCvrZsHiIWHvOv24dbX3xxL6ettNri99rs17KsiczKXrQbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ovM/jSWC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ovM/jSWC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C2MyFsQ/WvSCWpLhb6tLVFKiE70ztNYk07xB3WLqfcQ=; b=ovM/jSWCXrprQZdIniwtIfk+tE
	Bb7LiKFb6elPrx7KOLEnJmBxgztzJOE3CevB/h+v1GgcWWpGexXqXbakt97No4yo18i+qfCPUwO4m
	1zAR6/oM2EU/ELbOgCHFOEZa84fryroL/72PX/dZWMBEEX1fdLGi2+t42izzmXSb4jxLcENn2k+Ha
	48kRLJx+Ep4jO/kOT7YwTnJ1hH3Apz6ckq4VTeU6m/mVhN6mhc9iKLLLzEZxQZTiIcHgexBjWemj5
	7Qw1t1MkYkzZlDyEuliGWnxF1i1a08FYaYaHRnWFFZO969VFjHVNZ2EpIOXmLlHUzgs2+/a8i8ih7
	+uVU3fdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulkXo-0000000AGkg-1hvX;
	Tue, 12 Aug 2025 08:39:44 +0000
Date: Tue, 12 Aug 2025 01:39:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Rajeev Mishra <rajeevm@hpe.com>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
Message-ID: <aJr90KNTe7DLKURj@infradead.org>
References: <20250811190303.222802-1-rajeevm@hpe.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811190303.222802-1-rajeevm@hpe.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +/**
> + * get_size - calculate the effective size of a loop device
> + * @offset: offset into the backing file
> + * @sizelimit: user-specified size limit
> + * @file: the backing file
> + *
> + * Calculate the effective size of the loop device
> + *
> + * Returns: size in 512-byte sectors, or 0 if invalid
> + */

A kerneldoc comment for an internal helper is still a bad idea.

