Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173273;
	b=RU40+7yS1A6iLJfjG3c+Y2tJCBZ1Fx+blSAWlCmShPQHmbJEYBF1eTiYZrEo3vx2CxfK
	 qVnBbalSCnP+RdkEunUbWOps71IR6vpZnYLsSMckbNFA+22i/BCqe8jGzyiVzYFeFBteh
	 NaQhxsDb2lyw/Ya9LAxvNCnSsBhUKYhrLJfnFDxNXGNQWyNm8lRvcextVPE/jdmEu4yOv
	 OC73DcVK03rjyjP/J05LuCxvLuQPqndyZAfn4vLdXhW9pVrY50HtYsm+kjDwjlUL7XiKV
	 PxR166S8hg23a3FAbJmOx1KY2sWAwVJwuEEWEzAWwU1Q2LZoIX+aLPo5iAKQ699GY3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173273;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r9krR42dCc1R/MygVNC6/W4IONRVpaDXMDjUD/jXYko=;
	b=vNbGQ/E3EncCGDg5jWW0gUih7gddDo7ln4ZVJ55OvRPmoBbdkuNZq70jy0k9afzw/p/S
	 qMfJHMHiCdkMxYY2m7yKg1kpcW43R3zLWiShzkgljmf5K17o+qiFF3D14qIKm2+LoSBhE
	 l5R0PLYaPmRIaGe3cQhzRXHPgGrqgcAaQ0eVWVnS3j/VscxJ/Dg6br2uh/3vCNzBFz7dK
	 H2V/GGf0QQso5ExeucEhu0K15dwNItJ50Hw7S8xZivybFzqey9KcaXsHnD5xBD3NTvn7s
	 qOAhPLS0/n4zZPcH8YbX7+IbM62HwzJ+8OLWKYbXAvZ2sog+t7jDUfq6MTu1SJMknwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMdebML7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DF606A331;
	Fri, 20 Nov 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMdebML7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448741F00AE3;
	Fri, 20 Nov 2026 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173273;
	bh=r9krR42dCc1R/MygVNC6/W4IONRVpaDXMDjUD/jXYko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XMdebML7wUZ/sz2xc/apBDOavf3ksv9LxUyAootCAlGpmavA+qGqUX+xacg9T4q19
	 wwn9JuvYS9vQct9s/PiUsxliWccbmZzmFmMkZvnhxlpcjky17mlisXMePXth7F6c4t
	 QeubADI+90ig7Irnvf5uD8GzRtBkb+tjfuV7eSPetGY8vTGaFEDM4SxLk3daOjep7h
	 3WInP/fqpcN4wBs2Zsk8q/ANStBEHB5wRJyiEv0N9iLH8w5WiZzMkD4c4UDPCHD4T4
	 JBIZcEBVmjhIcXFNuSH2M6LbjvNrNy4/P53VcN4wFq/9gZvLyL3jZ7n45DHlMg1TKm
	 FlUX75wJ2oVAg==
Date: Fri, 20 Nov 2026 12:14:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Huang Shijie <huangsj@hygon.cn>, Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, jack@suse.cz, 
	zhongyuan@hygon.cn, fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, agruenba@redhat.com, 
	mic@digikod.net, gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, david@kernel.org, 
	sandeen@redhat.com, ebiggers@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-security-module@vger.kernel.org, sunjunchao@bytedance.com, shijie8@gmail.com
Subject: Re: [PATCH v2 1/3] vfs: add inode iteration methods
Message-ID: <20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner>
References: <20261113115702.586594-1-huangsj@hygon.cn>
 <20261113115702.586594-2-huangsj@hygon.cn>
 <avcBTMvzFWuCkwkn@infradead.org>
 <avqmmP4dbwu4ziKz@hsj-2U-Workstation>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avqmmP4dbwu4ziKz@hsj-2U-Workstation>

On Mon, Nov 16, 2026 at 02:45:44PM +0800, Huang Shijie wrote:
> > 	struct inode_iter_contex ctx = INODE_ITER_CTX_INIT;
> > 
> > 	while ((inode = sb_inode_iter()))) {
> > 		/* do stuff */
> > 	}
> > 
> How to manage the sb->s_inode_list_lock in this code?
> 
> I have no idea how to hide the sb->s_inode_list_lock in this code.

I think Christoph is right. The lock shouldn't be held across
iterations. Let the iterator take it, grab a reference to the next
inode, drop the lock again and hand the inode out. The reference keeps the
inode on s_inodes so the next call can continue from there.

This is how drop_pagecache_sb() does it today. Sm like (UNTESTED and not
nice-ified):

struct sb_inode_iter {
	struct super_block *sb;
	struct inode *inode;
	bool done;
};

struct inode *sb_inode_iter_next(struct sb_inode_iter *it)
{
	struct super_block *sb = it->sb;
	struct inode *prev = it->inode, *inode;

	if (it->done)
		return NULL;

	spin_lock(&sb->s_inode_list_lock);
	inode = list_prepare_entry(prev, &sb->s_inodes, i_sb_list);
	list_for_each_entry_continue(inode, &sb->s_inodes, i_sb_list) {
		spin_lock(&inode->i_lock);
		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
			spin_unlock(&inode->i_lock);
			continue;
		}
		__iget(inode);
		spin_unlock(&inode->i_lock);
		spin_unlock(&sb->s_inode_list_lock);
		it->inode = inode;
		iput(prev);
		return inode;
	}
	spin_unlock(&sb->s_inode_list_lock);
	it->inode = NULL;
	it->done = true;
	iput(prev);
	return NULL;
}

void sb_inode_iter_end(struct sb_inode_iter *it)
{
	iput(it->inode);
	it->inode = NULL;
	it->done = true;
}

and then drop_pagecache_sb() becomes:

	struct sb_inode_iter it = { .sb = sb };
	struct inode *inode;

	while ((inode = sb_inode_iter_next(&it))) {
		invalidate_mapping_pages(inode->i_mapping, 0, -1);
		cond_resched();
	}

Make it a cleanup class and a caller that breaks out early doesn't have
to remember sb_inode_iter_end() either.

This will end because new inodes are added at the head and the cursor
stays on the list. So these assumptions should get
VFS_WARN_ON_ONCE()-es.

Walkers that can't take a reference might need different solution.
I'm not sure if there are any?
