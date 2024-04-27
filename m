Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A040841
	for <linux-block@vger.kernel.org>; Sat, 27 Apr 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714205668; cv=none; b=oyjfS6boyKpt0prg44lr9haWZwsYGdo57xxKHz/mj7eFpXlNmJV2joQJZrGDcE+k1UsTwqQc12K3wsI9FZdK+nGaizof7VG5zobsIg0o1e2JkqEwGAfzPgcKYruaxoHnGC4W7sfaQr5uSn1t91ezmcsY6M+rqVtbTrvS7GQHpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714205668; c=relaxed/simple;
	bh=8mqNeDr0u3iqIl+g9uy8SsNEbjd1LyySMYp+4lxEDBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgex39EmcgRv7YwvvwCQwxcihvEs5aIL9Cuxus7v2eTXhiVp95mqLms8SJ0WUvc5zdwszUVB1F3SDuxQLvZFXseC9LlpaGylJ2hLiK2uz4NFopna73GVmoOD6VVrSas4K2JuwdKs8+e8WSHiupquhe/97oABXUHyFKeBJ4wfvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE1B8227AA8; Sat, 27 Apr 2024 10:14:21 +0200 (CEST)
Date: Sat, 27 Apr 2024 10:14:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, willy@infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH] block : add larger order folio size instead of pages
Message-ID: <20240427081421.GA5666@lst.de>
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com> <20240419091721.1790-1-kundan.kumar@samsung.com> <20240422111407.GA10989@lst.de> <20240424132246.7ny74cec7cvphg5i@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424132246.7ny74cec7cvphg5i@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 24, 2024 at 06:52:46PM +0530, Kundan Kumar wrote:
> On 22/04/24 01:14PM, Christoph Hellwig wrote:
>>> +		folio = page_folio(page);
>>> +
>>> +		if (!folio_test_large(folio) ||
>>> +		   (bio_op(bio) == REQ_OP_ZONE_APPEND)) {
>>
>> I don't understand why you need this branch.  All the arithmetics
>> below should also work just fine for non-large folios
>
> The branch helps to skip these calculations for zero order folio:
> A) folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) + offset;
> B) folio_size(folio)

Well, we'll need to just handle folio and stop special casing
order 0 ones eventually.

> If we convert bio_iov_add_page() to bio_iov_add_folio()/bio_add_folio(),
> we see a decline of about 11% for 4K I/O. When mTHP is enabled we may get
> a large order folio even for a 4K I/O. The folio_offset may become larger
> than 4K and we endup using expensive mempool_alloc during nvme_map_data in
> NVMe driver[1].
>
> [1]
> static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>                struct nvme_command *cmnd)
> {
> ...
> ...
>                        if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)

We can replace this with:

	if ((bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) + bv.bv_len <=
	    NVME_CTRL_PAGE_SIZE * 2)

as nvme_setup_prp_simple just masks away the high bits anyway.

