Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79928C009;
	Thu, 26 Jun 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944830; cv=none; b=p77XJub6DEksU4TibJqwqnRZpPQzV1cRGuHHqoMCzW2s/aLd4RHF0XQUzMG2OFJD9AzdmaCt6aBTQ6FJKVCoiF+4p3hYZ36yXA+BHi+iiAjT5jGDU5t9FTfkoo+cc4HB8pQh5s6+iwiyT5wrtQQcpA1Au+e9rX95sZO9+gxnBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944830; c=relaxed/simple;
	bh=d/60YnmlyVjCgsaESfsTR5bhN8Cd5tY+YhEX/ZBs7Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btUl2MWdLpq2FSdgHNbeJPa4DNs8EqDG15UHHUMs0J/ALi4QokwUKdCZbi7+5Sv/55sae4VTRr0a8FIfANnh808Uq0QIikXBQzLI54UYg0iyFnDE7HjZKMxZGSEUSa0iKKM/HmhPYlxLaIbHqo3aYQrWufw8kGgFnr75j8E+VPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sqNElX7f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqNElX7f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iN5oa8WFpQH679cSz3xeEssUmCfX9gDZTweFMclKHvM=; b=sqNElX7fXBTXxTkWkPhQ+KaumA
	fDUmRX8e6QwcX0uyQ+xhXeuuANxa5nHXYWK4Y3AhGyr/XSoUDZ1DZt324kNl/JLJ5ViNHv/F4rbpC
	8YGnryXiMtabm+nc/A3Ixg3XFYYUWEtKm6sdkaRfjMtg+sK4+rCTI9RWsgRut2am5QF8u9SpTQNDK
	U94j9Hd1lxj3rJa6wRM9IwTh6WOUdKDYSZsuqRyb650mBPll21XSTL1mVV56V7Hf2W84j15YbGvSW
	EqjIEFHdMDeAN7Srkz01bPW89lfXX6BTTDxgGiWRPXJZB6fiwmDihdVri8WPFKHnrFcvp9MSGSP8P
	3UPZlBQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmjb-0000000BgSF-0uhn;
	Thu, 26 Jun 2025 13:33:47 +0000
Date: Thu, 26 Jun 2025 06:33:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai3@huawei.com>
Cc: axboe@kernel.dk, hare@suse.de, hch@infradead.org,
	john.g.garry@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@redhat.com,
	calvin@wbinvd.org, david@fromorbit.com, yukuai1@huaweicloud.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2] block: fix false warning in bdev_count_inflight_rw()
Message-ID: <aF1MOxsOm2tcc0Ct@infradead.org>
References: <20250626115743.1641443-1-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626115743.1641443-1-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 26, 2025 at 07:57:43PM +0800, Yu Kuai wrote:
>  static void bdev_count_inflight_rw(struct block_device *part,
>  		unsigned int inflight[2], bool mq_driver)

Why not pass the inflight arguments as signed? (and split it for
reads and writes as you did below)

Anyway, I think this is good enough to get a fix queued up ASAP,
but we can probably clean it up incrementally:

Reviewed-by: Christoph Hellwig <hch@lst.de>

