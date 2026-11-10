Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283313;
	b=LrdtT5Dd7D7ZjZK5N2475GjXaE7Oky204oT7sRqQCvS6+thOrz3xbZ+Nb9p0s3BlIIgJ
	 jt/rd/QDIedpACvFbh4goBS+AZTMfp+OTOepwQMdjHrLGhqpFDogo3cz+Jyt0uLTJL+qc
	 aR0KmAkx4QIhxJrN5F7Vq9Jj18TOjUdkNxtTinKo6DTrjjksdcNTrFVU6T5BI0ncd9Mwa
	 S4bJi6qncXAzjhcq0jj5Ab4PI58QkkSepF2nc0NPJ8BQ5Hp7eAQb9zgZ70Knw2Y5an2Lf
	 hzeYWoP6E58LJRuxiMQ9gbw/sStZa001gBy8ciBzY0KUVR3So38IGHzVqZY1T4snrug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283313;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=Hvig8NCy10BZJadWO3yd2CYf8PCGOn5+JUtgjupFJOs=;
	b=QUCoso50j1OB0bcLr7MzkXAYctwVbqPQxMfGRj59Y+s9oYPQndt/cnB17MTeJAOOQNwk
	 yK9sELmSCQlFOEIqnYxLZovS+LecV/T/byCD44uO1GuR1PiudcwggJCGi8xWG2SZVUF/a
	 5a+pIRby33ugYv6B+ZrIWYD+a1Veq7fEqH0Sh8IwWJgGMRZUmR8TtYitaMIlVRHBD3u9J
	 7WPtQOAFRGqLsODNhY1F+2Sarpn0CbUn4ZKS2s9rehHyhvAXW6aXhuwiTDhNTzabva7xJ
	 ODKrhmtesHXi/zELpN5rYEQOQcoYks82lnv8DNmjyPwSGvp6W8jBjJQtU70CAwEwepQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0D606A335;
	Tue, 10 Nov 2026 04:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D0D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNtHz0w7RzCQsZK;
	Tue, 10 Nov 2026 12:01:35 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNtHy6HWnzCQsZB;
	Tue, 10 Nov 2026 12:01:34 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 1D73230A6439;
	Tue, 10 Nov 2026 12:00:50 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 10 Nov
 2026 12:01:33 +0800
Date: Tue, 10 Nov 2026 12:01:31 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Jan Kara <jack@suse.cz>
CC: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<agruenba@redhat.com>, <mic@digikod.net>, <gnoack@google.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<aleksa@amutable.com>, <legion@kernel.org>, <david@kernel.org>,
	<sandeen@redhat.com>, <ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>
Subject: Re: [PATCH 2/3] vfs: convert inode iterators to the unsafe
 super_iter_inodes()
Message-ID: <avKXG8jGHhokoXtC@hsj-2U-Workstation>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-3-huangsj@hygon.cn>
 <phaorzf3wo3qg3dwxwzemtvc3xk644lecgoeeu3th2zx3cv5ml@xzhc2jw7vobi>
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
In-Reply-To: <phaorzf3wo3qg3dwxwzemtvc3xk644lecgoeeu3th2zx3cv5ml@xzhc2jw7vobi>
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Mon, Nov 09, 2026 at 11:08:00AM +0100，Jan Kara 写道：
> On Thu 15-10-26 17:38:53, Huang Shijie wrote:
> > Convert VFS internal superblock inode iterators that cannot use
> > referenced inodes to super_iter_inodes() with INO_ITER_F_UNSAFE set:
> >   - Dquot removal
> >   - inode eviction
> >   - The nr_blockdev_pages()
> >   - generic_shutdown_super()
> > 
> > Signed-off-by: Huang Shijie <huangsj@hygon.cn>
> 
> See some comments below.
> 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index a9d37be390a1..139c56ee9d11 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -853,8 +853,11 @@ static void evict(struct inode *inode)
> >   * Dispose-list gets a local list with local inodes in it, so it doesn't
> >   * need to worry about list corruption and SMP locks.
> >   */
> > -static void dispose_list(struct list_head *head)
> > +static bool dispose_list(struct list_head *head)
> >  {
> > +	if (list_empty(head))
> > +		return false;
> > +
> >  	while (!list_empty(head)) {
> >  		struct inode *inode;
> >  
> > @@ -864,6 +867,29 @@ static void dispose_list(struct list_head *head)
> >  		evict(inode);
> >  		cond_resched();
> >  	}
> > +	return true;
> > +}
> > +
> > +static int evict_inode_fn(struct inode *inode, void *data)
> > +{
> > +	struct list_head *dispose = data;
> > +
> 
> Here we miss the unlocked check
>             if (icount_read_once(inode))
>                     continue;
Thanks for pointing this.
	
> so every inode will now go through the i_lock roundtrip.
> 
> > +	spin_lock(&inode->i_lock);
> > +	if (icount_read(inode) ||
> > +	    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
> > +		spin_unlock(&inode->i_lock);
> > +		return INO_ITER_RET_DONE;
> > +	}
> > +
> > +	inode_state_set(inode, I_FREEING);
> > +	inode_lru_list_del(inode);
> > +	spin_unlock(&inode->i_lock);
> > +	list_add(&inode->i_lru, dispose);
> > +
> > +	/* Abort so evict_inodes() can dispose of the queued inodes first. */
> > +	if (need_resched())
> > +		return INO_ITER_RET_ABORT;
> > +	return INO_ITER_RET_DONE;
> >  }
> 
> The need_resched() handling needs more thought here. The way you've done it
> will just abort the iteration, evict gathered inodes and then restart the
> whole iteration (which will then have to skip again all the inodes we could
> not evict). Which is not what evict_inodes() does today and we really had
> to resort to those tricks to avoid softlockups under certain loads.
> Frankly, this iteration is so special that I'd be willing to leave it
> unconverted for now rather than trying to bend the general iterator for its
> needs.
okay. I will think over it again.

If I really cannot find a good way to avoid the softlockups,
I will keep the code unconverted.

Thanks
Huang Shijie


