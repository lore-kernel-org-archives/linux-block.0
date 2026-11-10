Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278315;
	b=zQmP2mzH2IXCel1W+QoNhlZLoJNhu2dYr2lvbi4uADRBO3T3wIpOPNWoudItttm8garZ
	 wDokIShToFMOiRVCQKXKlrTgYb968MiwyqKJxz54Z0vlY/+G9IgMwTtqnI67kNXUBv4KR
	 UTd2iGywF6QvvvWjefw4HZgXOUBDzmZ//EbpTPMG4VRSK5UfC6wdnkWEv8fwnn+lJvql9
	 lsCrxSmcbj1L6J6o9/H6sUgdRzBrjUqkiHk5geAWxA4bb8Z626mqfEuiPa2bgSSpJ9G0o
	 DyXpjIP/x6KvhtB5dhksSOKInjzelf83P011AMudly/TYRhyzb6XojnT5USqvZ9Ps+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278315;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=wAHGin8u6AIZQh7OflkkxvchjlB5l41zuY+9P+ij+ys=;
	b=T1/R2mU+MIvz7qvVy02mPHRMid0FSTdRwZ+nV8+Q6e1ibAhJV0lOnuMtwDBY5uXxzyNQ
	 pTbNX76gVNf5jlRjRKxDLIhzbhrS4bcviKo81eGvL/Uscd9lFv4SfA8hC8FAZkspwTHh3
	 F7hJYZtUC9N4//brJYoG8Q+Kn99B4nD9IuuUE29cMI1Ry0T/wRo7RUebAix62OKjxK9+g
	 A60iAKwjzMRJqJbMMH+xRTOlb2/x9nELx9rIj45cO8Dyboos72OaZvENVidBzmsZYza0l
	 qFTVKPoPqOCNVmRPBLuSGAvJL68SPOoZqucGqvSFlsYFU7RxPDSHgUCpnHs5Gu04WIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2D606A325;
	Tue, 10 Nov 2026 02:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC2D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNrRv4jyTz9j97c;
	Tue, 10 Nov 2026 10:38:19 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNrRs51X7z9j97X;
	Tue, 10 Nov 2026 10:38:17 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 10FAE30A6439;
	Tue, 10 Nov 2026 10:37:33 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 10 Nov
 2026 10:38:16 +0800
Date: Tue, 10 Nov 2026 10:38:14 +0800
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
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
Message-ID: <avKDlkJG0Rj872Cd@hsj-2U-Workstation>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-2-huangsj@hygon.cn>
 <symrqnxn6tkrahynz7rm5b7n3tolkifpbubmwfd3y6q4q2xnt2@vhh7plsok3kh>
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
In-Reply-To: <symrqnxn6tkrahynz7rm5b7n3tolkifpbubmwfd3y6q4q2xnt2@vhh7plsok3kh>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Mon, Nov 09, 2026 at 11:43:19AM +0100，Jan Kara 写道：
> On Thu 15-10-26 17:38:52, Huang Shijie wrote:
> > +static bool super_iter_iget(struct inode *inode, int flags)
> > +{
> > +	bool ret = false;
> > +
> 
> Here I'd do a lockless icount_read_once(inode) check if INO_ITER_F_REFERENCED
> is set to avoid unnecessary i_lock round trip.
okay. I will add icount_read_once() in later version.

> 
> > +	spin_lock(&inode->i_lock);
> > +	if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))
> > +		goto out_unlock;
> > +
> > +	if ((flags & INO_ITER_F_REFERENCED) && !icount_read(inode))
> > +		goto out_unlock;
> > +
> > +	__iget(inode);
> > +	ret = true;
> > +out_unlock:
> > +	spin_unlock(&inode->i_lock);
> > +	return ret;
> > +}
> > +
> > +static int generic_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > +			       void *private_data, int flags)
> > +{
> > +	struct inode *inode, *old_inode = NULL;
> > +	int ret = INO_ITER_RET_DONE;
> > +
> > +	spin_lock(&sb->s_inode_list_lock);
> > +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > +		if (!super_iter_iget(inode, flags))
> > +			continue;
> > +
> > +		spin_unlock(&sb->s_inode_list_lock);
> > +		iput(old_inode);
> > +
> > +		ret = iter_fn(inode, private_data);
> > +
> > +		old_inode = inode;
> > +		if (ret == INO_ITER_RET_ABORT) {
> > +			ret = INO_ITER_RET_DONE;
> > +			goto out_loop;
> > +		}
> > +		if (ret < 0)
> > +			goto out_loop;
> > +
> > +		cond_resched();
> > +		spin_lock(&sb->s_inode_list_lock);
> > +	}
> > +	spin_unlock(&sb->s_inode_list_lock);
> > +out_loop:
> > +	iput(old_inode);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Unsafe iteration for internal VFS use only: @iter_fn runs in atomic
> > + * context with only an inode existence guarantee, so it must not block
> > + * and must perform its own inode state checks. Return INO_ITER_RET_ABORT
> > + * to stop the iteration early.
> > + */
> > +static int generic_iter_inodes_unsafe(struct super_block *sb, ino_iter_fn iter_fn,
> > +				      void *private_data)
> > +{
> > +	struct inode *inode;
> > +	int ret = INO_ITER_RET_DONE;
> > +
> > +	rcu_read_lock();
> > +	spin_lock(&sb->s_inode_list_lock);
> > +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> > +		ret = iter_fn(inode, private_data);
> 
> After some thought, I'd probably make this function inline in some VFS
> internal header. That way the compiler can inline everything and avoid the
No problem. 
I will try to convert it to inline function later.

> extra costs of indirect function calls, etc. These iterators tend to be
> rather lightweight so it would avoid performance regressions from the
> conversion.
> 
> I was considering the same for the generic iterator as well but there I
> don't have so strong opinion as the function is already relatively big and
> the callbacks are usually more heavy. Might still be worth some more
> detailed investigation and performance measurements...
Yes.
This function is already big enough.

Let's keep it as it is.

Thanks
Huang Shijie

