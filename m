Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF9261B71
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809512; cv=none; b=p3UNw17NW+9W2woBun7IeST/LzWPpDKQMWiRL9i2CbtbXMhQ0n6bJSQ+DvQIfTonAqISm+B9DQFB4tG4e7FLQsZO+lkMEM6SDqk4NTf5M08PBHBXNadi9a4yd8D2uyM5nzF1rQyQwaCsAxYHuGO2vdw3CNNsUxTuM77KYZCmwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809512; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAMUMmlV6Ptfzel67V56ZI3W18/GI9GOdZ2bHaIHvQyYL+AlusCplZ9Qc9nkWVuYK69msrLgugmQeT/sDg+BdKYoPxjEBObP0MmANr4X/W2LzNADOewKnCCvrr1Xfc1ptOJwsHzKIim+xvaGhOJY4xEkrby3YzSJHTLxVKWK7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA380227A88; Mon, 15 Dec 2025 15:38:27 +0100 (CET)
Date: Mon, 15 Dec 2025 15:38:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: Re: [PATCH v3 2/2] zloop: use READ_ONCE() to read lo->lo_state in
 queue_rq path
Message-ID: <20251215143827.GB30633@lst.de>
References: <20251215094522.1493061-2-yangyongpeng.storage@gmail.com> <20251215094522.1493061-4-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215094522.1493061-4-yangyongpeng.storage@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

