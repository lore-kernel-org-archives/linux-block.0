Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AD1D31B5;
	Tue,  5 Nov 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805575; cv=none; b=QoaHCP8QdTQMJ9KrVF5/kPdiVE6SitVdyC1G4XzCbhqBc4yfnC8zqO7ffIF4+aon4vvIwJOMEzqXYUNDlH3JMA8VFOQXryn5cnc6Z6uCW1nJVfR/Kqi96TKdyoE8PcAedCIOfmYey1fCgksRMBHi6SEgIRCs1wC+NLgfhORGar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805575; c=relaxed/simple;
	bh=5FsWv5GL4rmAkh67s7MV28ZJfG3NGrDIYxPqUIMPVd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUqrSIv8Wd1IEXWiDQAEFO2WgCqfXHu1YkbiN0zgq6Yqyb0KAx7q6Y5GKMcq6XhCtfvPN6QBMHLsQmyexx9PcHGGNaY9e8a2w/ysbMCvdRnzXf/kLEowdBIQSSmru89DFcYOQmRHfpdTiyqkU48Yy23+Y+tmBDl1vozhxML9IJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f1QabGN5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1QabGN5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TW75WpCTCHl8zs9aUcjDRG4OOLl+qqXWcA1mAxlm/9o=; b=f1QabGN555DK9tkb0F0OL43C41
	b7Uygjr3XfklzkmL4IXSEgRjgRc8sMsA4Q/VeOfHi7thLm8E459VDPuZrsbFGvI/RiHBf+EuWMAXq
	R2kSLNTWZK2pyzd8VqMlGxIWhhAdmJyM/JlPZHJp2fyBmpI/CukBQ6sT8WARU0BaNM3jbb8WJ1uXt
	vAEGVhJIVSy7WRUHET9Xa6mo+oYrBdlRMsNAa0Nrg6vjDuiQqMEsf+Xgl4Z2idH8gOCv6QvVONjBV
	14m8vuuFW40QB51hlncB/9/CbXZKR4EFg8iSLCb4KoWW44ni04e2I5P/+HLDMl5q5N20HwSynjumJ
	JfWqiEHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Hau-0000000GpQt-2LHo;
	Tue, 05 Nov 2024 11:19:32 +0000
Date: Tue, 5 Nov 2024 03:19:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
Message-ID: <Zyn_RGV2i9COvNQl@infradead.org>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
> atomic mode after del_gendisk"), hence for disk like scsi, following
> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
> cause following uaf that is found by our syzkaller for v6.6:

Which means we leave the flush request lingering after del_gendisk,
which sounds like the real bug.  I suspect we just need to move the
call to blk_mq_clear_flush_rq_mapping so that it is called from
del_gendisk and doesn't leave the flush tag lingering around.
