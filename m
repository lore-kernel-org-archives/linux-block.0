Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8312CDBE;
	Sun, 10 Aug 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838526; cv=none; b=stTDPjX5FyXSPd3pkw3sCJoJ2sPVa2Gl3TiNXrq6OZpWk4kakfVgQXD6BGlH5WLJ3kDw+5cF3V9aQFg9q/AvYNiDYSvNdtJOPKLnoUS6n/c5WoCp9gs9lqkWpeq+57va8E4jSZ+cn2H6rE3PhvuPdi/yWPZdfHaU5eLcGMGP+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838526; c=relaxed/simple;
	bh=vuvdCN3TtX7Lv7G/Q5IZnJ6/KYiH57KTkCeT7t6F7UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1yQYACnZiDE4IZyboKm60sis+BJbMEzEmsAWFXljbeZN8TOTQGhEuJTY2J23CkhDA+CmTVULnw3fJbXE6CjjsXKwbSRQ3JeXUnOJUGXhVi2hz3uvWAoIawyImFimm4cYeeEGl/eQKH1vhe5Aog0qR6nXzJi5A/vf6fMYdb3WDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Az+B4DkN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Az+B4DkN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NwQA/kUwLcnseb4R1LILS72zcZ0LIFtkQopBodDweyc=; b=Az+B4DkNzkrYcz/2d72W9jg4Nd
	TA1jA6x7WoADTpMY/D6SQh1C/O3RuThMds4e30nIkZsvBwqi/g5oX77ByBAx6VMLnr/CcPjherVj6
	Vsu20mNulMamcP69WRa7TufJhsOGYbAF601bpOq77iF4gzsObL23LOMhw9co7sutBeWK6NEaKJoXw
	CZ+RjFX34xQq6zuw2ApSmV4RlLH91gmpklIEZ34Qk84tVwyutL2lNrUd3tWM5948eu1kr/WA+2FNW
	Xcttd8z0scHErOiBTUWbhOhAoa5BwljF/YZrTbIuEPjZztZHpplVdOBisuI/KIrTE6eXuD6yYwwR6
	qWYQeptA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7f8-00000005jYT-2CQN;
	Sun, 10 Aug 2025 15:08:42 +0000
Date: Sun, 10 Aug 2025 08:08:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
	zhengqixing@huawei.com, lilingfeng3@huawei.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2] block: fix kobject double initialization in add_disk
Message-ID: <aJi1-l0ye4Xxv3IH@infradead.org>
References: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 08, 2025 at 01:36:09PM +0800, Zheng Qixing wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> Device-mapper can call add_disk() multiple times for the same gendisk
> due to its two-phase creation process (dm create + dm load).

We'll need to fix that, instead of adding complex workarounds in the
block layer for something that should not happen.

