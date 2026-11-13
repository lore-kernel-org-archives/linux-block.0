Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572632;
	b=35OpGVZ85jTIhFYCuu8/6iimUQ37gu8Ap7gib9Ancq4PWbsFfof9mOTFh7ylGWGE3b6A
	 T+66WxOXl8LgN3wXS891gBoSA5s0uRjMzGZXqtyyBWLGejfIpwaNj/9YJJt7z2yOWoHZL
	 D9rvKVTE8WoU7A7asuurCXsv0/YCNRb81rsZ9I/ZK3W6vl8DjZLcCreazHqAMs/lw0Mlj
	 GZByZb3ec0+NNVXK+BKAzFW1fbQ2c+KYN7hYBgo5oht5Ba4lyoVsMPWSWAmgCixDdfQhI
	 Ea/mPdOgJxZXuw4lxMs4i9k3S26av3ieNJ4x+dLHoEb2wEDf7c+Yvs+gy/NXV/BKNyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572632;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=UUwGnNabeXn9g9AT85r9uGe6hw2FIWAFW2WrXxAEedo=;
	b=bHktssH5yt8S9NRURWJMn3FhcV489IocfqtQDBR/RvmdftOqCNy/JXc9ZrdwXVYxe3xD
	 3pSh0Xc1QL81bvplJ8ztSfrV0dgPQgKJEHNW5w/9DtnvhYVKafgaHrHPzBhaRrMdNjkji
	 YsPbIHQTOqIDJCaPGLFXkLfg/CQeN4ysJptO9MC/aCuiTq8rudkIXAUB3Ll+ISX48Vx2T
	 9TboWo2ETG8H3Y3RiSyPSmtc877KB+4qIZyQiJzte5pmVAo0U4ydd34++lf261gPArCzj
	 m02UzURkf40zMPCqZ3kGQlYBfKnM78bL7cwsalEQtREeX3xMQZfqKTSLaJGzPuLiiGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rceoDK3Z;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141C606A327;
	Fri, 13 Nov 2026 12:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6141C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rceoDK3Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UUwGnNabeXn9g9AT85r9uGe6hw2FIWAFW2WrXxAEedo=; b=rceoDK3ZMiyK1QHXmONYz2tinf
	dwbW5gUCb1g1CbtANNvrDjoyPxoWQ+JBaFH55Co5ZDuo1kc+yV1MCJMAcJo8+8M5f5d+2AEHUlukW
	SdcgMSyIZE8LdxDnjlOItdmukkn2mrwQBvY1OeXvGXYagJZEWaNdbsPg//HG7kCET5Hb6ev3BldvV
	UoE8BfqUWs/URkdMyUAlZ9IhsrILT5xLVZe+4RFbiexs2Sb6tx4L1KzwM71s52WjzSW90OwkQPagL
	kYnCdH5v9Y9thIMhR22up8OdzLnymkFRt+uVtJj/zwjgCibcfwlwKqSIMJl67wRg3o370Fsln0LZw
	WOZn2ozw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRqJg-0000000CivL-1Wm0;
	Fri, 13 Nov 2026 12:23:40 +0000
Date: Fri, 13 Nov 2026 04:23:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, zhongyuan@hygon.cn, fangbaoshun@hygon.cn,
	yingzhiwei@hygon.cn, agruenba@redhat.com, mic@digikod.net,
	gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, aleksa@amutable.com, legion@kernel.org,
	david@kernel.org, sandeen@redhat.com, ebiggers@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org, sunjunchao@bytedance.com,
	shijie8@gmail.com
Subject: Re: [PATCH v2 1/3] vfs: add inode iteration methods
Message-ID: <avcBTMvzFWuCkwkn@infradead.org>
References: <20261113115702.586594-1-huangsj@hygon.cn>
 <20261113115702.586594-2-huangsj@hygon.cn>
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
In-Reply-To: <20261113115702.586594-2-huangsj@hygon.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 13, 2026 at 07:57:00PM +0800, Huang Shijie wrote:
> +/*
> + * Unsafe iteration for internal VFS use only:
> + *   @ctx->iter_fn runs in atomic context with only
> + *   an inode existence guarantee, so it must not block
> + *   and must perform its own inode state checks.
> + *
> + * Return INO_ITER_RET_ABORT if the iteration stops early.
> + * Return INO_ITER_RET_DONE if the iteration runs to the end.
> + */
> +static inline int super_iter_inodes_unsafe(struct super_block *sb,
> +				struct inode_iter_context *ctx)
> +{
> +	struct inode *inode;
> +	int ret = INO_ITER_RET_NEXT;
> +
> +	rcu_read_lock();
> +	spin_lock(&sb->s_inode_list_lock);
> +	inode = list_prepare_entry(ctx->prev, &sb->s_inodes, i_sb_list);
> +
> +	list_for_each_entry_continue(inode, &sb->s_inodes, i_sb_list) {

This is a really odd way to write a list iteration.  I also don't see
how the RCU lock is needed when you already hold the spinlock.

I honestly don't get this "iterator.  It is trivial, the _unsafe is
wrong naming.  What is the point?

> +/**
> + * super_iter_inodes - iterate all the cached inodes on a superblock
> + * @sb: superblock to iterate
> + * @ctx: the context which has the metadata
> + *
> + * This function iterates all cached inodes on a superblock that are not in
> + * the process of being initialised or torn down. It will run @ctx->iter_fn()
> + * with a valid, referenced inode, so it is safe for the caller to do
> + * anything it wants with the inode except drop the reference the iterator
> + * holds.
> + *
> + * Return INO_ITER_RET_DONE if the iteration runs to the end.
> + * Return other value if the iteration breaks.
> + */
> +int super_iter_inodes(struct super_block *sb, struct inode_iter_context *ctx)

This one makes a lot more sense, but the callback pattern is a bit
annoying as it requires to stuff all information into the context.
Im much of the core kernel we're slowly switching to an iterator
model that allows the caller to keep the state.  In this case something
like

	struct inode_iter_contex ctx = INODE_ITER_CTX_INIT;

	while ((inode = sb_inode_iter()))) {
		/* do stuff */
	}

which should be easily possibly with this model.

You probably also want to split the core iterator and switching each
user into separate patches.
