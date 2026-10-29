Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279557;
	b=qxza1/1qqZ4d6xlngj/FECphp4dQVkw9P7Dm+7ahhwK6F+0buyACftcXkTup1VLQxMf1
	 j/jL8bHve2IJwEHCtl4CLgD4+3a3gmMmiZjfysUdQuq9fA05MWJzprQPn3fhoHIDBeOka
	 GcQ0xL7axAQLl0rzPN/gMZkeeLQ3jYFP3GeVvpCbTqI+6b5fcu6PiPI5f7CVetWvmbNX0
	 d062X0wMfydpgd9y5G49yxMehnpeul9S7/4YA63o+HqZbUK6sxllV3KPGKlobLLOle+jP
	 qQoCQUsoHiXMmYrdn6szg54QykT39Vd8v8Rvzrygdj4bBniRpcT5dPqwOon50sQNrow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279557;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=aV4fV5SczxX3UzyR2sqTjiQqwR8G58Svwkty68Bn5sA=;
	b=1cmSBlHUp2FMHDEyN/46YlQozq9a52abBfrWw56CRNjoQdDihCHTZMLlZvdXXRhQVC0K
	 6HxHeL/Z4SelEYuPS0hJ1pTug/uXHBDL1lx/+zlVPq6ABLeyeT8H66SSahUgj2iH03/Ap
	 mA7wWchZDBXUN2+oSEgGxrXNm7nJEnO62BbCr6PtjiJWLfQvamCJOo8UHRaLQ+XXpkxLF
	 w0YEZi+2P9p4aEw3grOoS90Deaogc6Qv9FH1KSZ8v6nQho9tnX+GR0Kk8UXejpcWzwIU4
	 Bf36owZd/0Ybw5VdAvXpCBSAn7YvFKDXb2Hvm7KPw6BaGFo2nyq7tleGQRJPydM41Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="X1F/vYwJ";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12E606A329
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C12E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X1F/vYwJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aV4fV5SczxX3UzyR2sqTjiQqwR8G58Svwkty68Bn5sA=; b=X1F/vYwJ8933zrAjpfIkV3aItd
	br12MFBHLqvejXG6X9t0KnIJY02Ysu2kx1ZkBIKOptz5D+g6uw8653rIoHNZiDjngcMSSpR1dizkl
	c/1bnN/8gqOJkM+/X86KqZcLKHMP6IcAtTfv2q8qcWHvysyoVjOx7GTAO3MRP/AtKkqHgKHSB+qEa
	ci3Fgs5+SyqazYYPsj7MG9gavyprtcNL8LCMMnQwRGIZgPigOIv258XEJbQ5w9hl9/bfH/BTzwmVN
	PkPxht+9WwiejdPG/AlgtdDd/+XzdTPWMhYsrgEsFcw0Cft0lf1rrdUgm5VpIgNDCnCtO9fFf87IE
	bpehnIkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPvo-00000009JAq-429y;
	Thu, 29 Oct 2026 13:12:36 +0000
Date: Thu, 29 Oct 2026 06:12:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 43/98] blk-mq: free the bitmaps of tags in the SRCU
 callback
Message-ID: <auNGRHU0yxEVN0hu@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-44-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-44-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:46AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit ad0d05dbddc1 keeps struct blk_mq_tags and the requests until the
> iterators under tags_srcu are gone, but the two bitmaps they walk are
> still freed right away. When the number of hardware queues shrinks,
> blk_mq_tagset_busy_iter() may be about to walk tags that
> __blk_mq_update_nr_hw_queues() frees. sbitmap_free() clears the map
> pointer, so that's a NULL dereference or a use-after-free, depending on
> the timing.
> 
> Free the bitmaps with the rest in the callback.
> 
> Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU callback")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-tag.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index aaea2e2c2f23..e3edf18697af 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -623,17 +623,17 @@ static void blk_mq_free_tags_callback(struct rcu_head *head)
>  		kmemleak_free(page_address(page));
>  		__free_pages(page, page->private);
>  	}
> +	/* An iterator may walk the bitmaps for as long as it may see the tags */

Missing sentence ending and overly long line. Otherwise looks good.

