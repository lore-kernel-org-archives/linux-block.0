Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811563;
	b=SB49wEbAfgErLe/KBvaFT/Nt+T0DQRbdWZXeGfoBlbdQIVetjP7oC/QTO+FPk/YuSkxb
	 INb3WPvbpWlmAED9vezCG0naFjiK4GcP5c68RPD5rU42Pcgijak+r87kcQuVyGxvimWhm
	 Gopg7XuuDp6MQJCjZqxioM8R/uTxhD9BAArrBo0kd/hJtPY//dc5CynqVTdp812V9nXZt
	 HMlGBkKMaF8afAYqXBFxpiSfj8BsxgV8BbeVOs8pWEgYwO1uUcRyPRMWJ0pXhIOtVIIZZ
	 12Yvu8Wu7oUXesp8JeMLkwenhBBQcfzI7vWQwpZpJkzCAv/PJuIGWeuOf8T2B8/P94w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811563;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=Y1QRMBakR36puGC50kkOYilGUR+cqqph7fCXotl+ai4=;
	b=ofpI9b4XjuKPjGeymnuslO3L+MNUdEeoPdZ0Vl9+pjXGO+hPAI67jVspl+dNF/uhMQv/
	 FOy8H7J41xE0aobl/FesX98lL0b9XUm15g7bSSYdZsr9V5dBvRNYbUkpMc2Ofp86GcTbL
	 kebFQL2aMZmHm+Vu4jMvr/UaN5t2qCtkmNvjE9PeDQauDchG5aytVOL7/6ILzllAXYGP3
	 DOXh+KNCpJEwH05wFcWH4awOrHqAGoh+qYCia7QJxfRXf0f+IrV2rKzJgUgTGO9un5RZe
	 ab1qJiqwv+6kMTA7zFT3u089q0F1zxZJLT2gJrjRjZ0v3Rlz6YMcRpezra4Z80MNw+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8C606A323;
	Mon, 16 Nov 2026 06:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F8C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jSdfh6B84zVcB6;
	Mon, 16 Nov 2026 14:45:48 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jSdfh1YmVzVhfS;
	Mon, 16 Nov 2026 14:45:48 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 8B3987756;
	Mon, 16 Nov 2026 14:45:45 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 16 Nov
 2026 14:45:46 +0800
Date: Mon, 16 Nov 2026 14:45:44 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Christoph Hellwig <hch@infradead.org>
CC: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <agruenba@redhat.com>, <mic@digikod.net>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<david@kernel.org>, <sandeen@redhat.com>, <ebiggers@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <gfs2@lists.linux.dev>,
	<linux-security-module@vger.kernel.org>, <sunjunchao@bytedance.com>,
	<shijie8@gmail.com>
Subject: Re: [PATCH v2 1/3] vfs: add inode iteration methods
Message-ID: <avqmmP4dbwu4ziKz@hsj-2U-Workstation>
References: <20261113115702.586594-1-huangsj@hygon.cn>
 <20261113115702.586594-2-huangsj@hygon.cn>
 <avcBTMvzFWuCkwkn@infradead.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avcBTMvzFWuCkwkn@infradead.org>
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Fri, Nov 13, 2026 at 04:23:40AM -0800，Christoph Hellwig 写道：
> On Fri, Nov 13, 2026 at 07:57:00PM +0800, Huang Shijie wrote:
> > +/*
> > + * Unsafe iteration for internal VFS use only:
> > + *   @ctx->iter_fn runs in atomic context with only
> > + *   an inode existence guarantee, so it must not block
> > + *   and must perform its own inode state checks.
> > + *
> > + * Return INO_ITER_RET_ABORT if the iteration stops early.
> > + * Return INO_ITER_RET_DONE if the iteration runs to the end.
> > + */
> > +static inline int super_iter_inodes_unsafe(struct super_block *sb,
> > +				struct inode_iter_context *ctx)
> > +{
> > +	struct inode *inode;
> > +	int ret = INO_ITER_RET_NEXT;
> > +
> > +	rcu_read_lock();
> > +	spin_lock(&sb->s_inode_list_lock);
> > +	inode = list_prepare_entry(ctx->prev, &sb->s_inodes, i_sb_list);
> > +
> > +	list_for_each_entry_continue(inode, &sb->s_inodes, i_sb_list) {
> 
> This is a really odd way to write a list iteration.  I also don't see
This is for the evict_inodes() which will break and then resume the iteration.

> how the RCU lock is needed when you already hold the spinlock.
okay. I will remove the rcu_read_lock in future.

> 
> I honestly don't get this "iterator.  It is trivial, the _unsafe is
> wrong naming.  What is the point?
What about super_iter_inodes_locked()? ore super_iter_inodes_noref()?

We use this function to hide the fs systems to use the sb->s_inode_list_lock
directly. Then we can add more code to optimize the iteration. 

> 
> > +/**
> > + * super_iter_inodes - iterate all the cached inodes on a superblock
> > + * @sb: superblock to iterate
> > + * @ctx: the context which has the metadata
> > + *
> > + * This function iterates all cached inodes on a superblock that are not in
> > + * the process of being initialised or torn down. It will run @ctx->iter_fn()
> > + * with a valid, referenced inode, so it is safe for the caller to do
> > + * anything it wants with the inode except drop the reference the iterator
> > + * holds.
> > + *
> > + * Return INO_ITER_RET_DONE if the iteration runs to the end.
> > + * Return other value if the iteration breaks.
> > + */
> > +int super_iter_inodes(struct super_block *sb, struct inode_iter_context *ctx)
> 
> This one makes a lot more sense, but the callback pattern is a bit
> annoying as it requires to stuff all information into the context.
> Im much of the core kernel we're slowly switching to an iterator
> model that allows the caller to keep the state.  In this case something
> like
> 
> 	struct inode_iter_contex ctx = INODE_ITER_CTX_INIT;
> 
> 	while ((inode = sb_inode_iter()))) {
> 		/* do stuff */
> 	}
> 
How to manage the sb->s_inode_list_lock in this code?

I have no idea how to hide the sb->s_inode_list_lock in this code.


> which should be easily possibly with this model.
> 
> You probably also want to split the core iterator and switching each
> user into separate patches.
no problem. I can split them later.

Thanks
Huang Shijie

