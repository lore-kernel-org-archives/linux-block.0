Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BE1F1507
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329841; cv=none; b=HTQORRcOjGKR1da1fqc1Qc8biczEXNhoHIdK77bdGqv6lhd8p9aQBDltgjcscIcKy0IspOdtAr1DGLRosAHMttatSFFaRqjqAni3CTSzA9jRVwktWIHby9fXFvw0IlCHWrjQ6XgsjKWUNRm0ZI+/D96UuYd+/W2BIqgI0sYjbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329841; c=relaxed/simple;
	bh=0rcfdt/JnX3Fe6CtB3lwKe3A/SCrT9j7YCvb1oy4/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLfUqKNPKtv53RDLjyZ3vsc6do7D7ftI5NS5ivvV7z/MMk2Oe39O8zUvE2X6ULku68xUWw4du7cDEWFbH8c5OrWDYtkUDmoOyNRZ5F9+QcZx19HB6LLjSNzBQ9o/UVvEB0qaTUkmiZy5Eo+rpwqB9kt4UqOn9Nn+ggkDU10XCQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9CE4F67373; Tue, 22 Apr 2025 15:50:34 +0200 (CEST)
Date: Tue, 22 Apr 2025 15:50:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 5/5] brd: use memcpy_{to,from]_page in brd_rw_bvec
Message-ID: <20250422135033.GB23131@lst.de>
References: <20250421072641.1311040-1-hch@lst.de> <20250421072641.1311040-6-hch@lst.de> <1f084ee5-098f-6588-5f13-068240682c8b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f084ee5-098f-6588-5f13-068240682c8b@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 07:18:05PM +0800, Yu Kuai wrote:
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

If you think some or all of this is useful for your discard fixes feel
free to pull some or all of it into that.  Otherwise I'll repost on top
of that once it is finalized.

