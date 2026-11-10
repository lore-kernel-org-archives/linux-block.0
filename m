Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292192;
	b=KVHCGmbsUPf9rjLdm+rHMj/kzEe9CTXpV7CexTMgzivPGAXqWZXiGkHy2m1xyjhHYS6H
	 h5EOUgaLgMSoIy/SHQQAlSDp68rg7Gxum8hvRE3nFUUJwMvNwCmxobPMyI1zK6RhTxlAP
	 T4K51Q/XAVV4BMMK5DF74/4iGYCv5YOOBrsUL3orDIu/SnGVuP+y5/bjjJU/dz6+ZUEjK
	 VG8uZfhzDUQdgH3+C9RkMVA+WL+LdqL8yP/lfWOfyVj+Tz1tV4s9mst6qf6Km+xrvY4lL
	 ILemvXcwVJh48v8x8ou4E0I7XtFdqjpJ0hqUG1plUxLWYRNpvFNjAMraaMRvmVLVM8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292192;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=mgKCRgRdNiIKmHGzM5jiXbcVj17jpTU0EAW2FbfsR2g=;
	b=LsLrv4CFg8tXjAn5mH6NtmykcVqWGYPfZjMMiUHe7EfvIgHrUqbKnwEmFySr+gySLp+O
	 Lad2RnPORZab68xhuoVYduGXZsM970Wj+LEOhVu8zGCfEesnvOTBAKEfg+xHQwdN9Gr9W
	 GcoMUeHJY6jsPX3HpUtW46eOg+UAOobxeJcnZHf35khEUKJqETN2MNAczTVGKMWRCaBU+
	 k/21mxOsXZ600dT7wdzFNkOJah9wnok1HEUhvBEmGRtvtmvqwtA88TY/T+XIy4YUNjZmK
	 l/dbvKAEddGU1g/s7wlzY41Ix1wojf8sVRS7QdimGXbX53HC08CEmjpJWiBymj8LlHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4078606A321;
	Tue, 10 Nov 2026 06:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4078606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNxZh5z6fzBCqx8;
	Tue, 10 Nov 2026 14:29:32 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNxZf5vhYzBCqx6;
	Tue, 10 Nov 2026 14:29:30 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id E35FE30A6439;
	Tue, 10 Nov 2026 14:28:45 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 10 Nov
 2026 14:29:28 +0800
Date: Tue, 10 Nov 2026 14:29:26 +0800
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
Subject: Re: [PATCH 3/3] vfs: convert sb->s_inodes iteration to
 super_iter_inodes()
Message-ID: <avK5xg_TYW66t2PE@hsj-2U-Workstation>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-4-huangsj@hygon.cn>
 <wrknznlm52ffratfpdoe3otqhkgyd45vgmvtjkixrvurwpplyu@sfpz3yiwhidy>
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
In-Reply-To: <wrknznlm52ffratfpdoe3otqhkgyd45vgmvtjkixrvurwpplyu@sfpz3yiwhidy>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Mon, Nov 09, 2026 at 11:31:41AM +0100，Jan Kara 写道：
> > +static int sync_bdev_fn(struct inode *inode, void *data)
> >  {
> > -	struct inode *inode, *old_inode = NULL;
> > +	struct block_device *bdev;
> > +	bool wait = *(bool *)data;
> >  
> > -	spin_lock(&blockdev_superblock->s_inode_list_lock);
> > -	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
> > -		struct address_space *mapping = inode->i_mapping;
> > -		struct block_device *bdev;
> > +	if (inode->i_mapping->nrpages == 0)
> 
> Seeing these various checks iterators are doing before actually paying the
> cost of grabbing (and dropping) the inode reference, I'd add a
> ->elegible(inode) function to the iterator which will get called under
> i_lock after other checks pass and can decide inode is not worth bothering
> with and put the checks there. If it is NULL, the behavior would be as
> currently.
Okay.
I will add the ->eligible() function to the iterator in next version.

Thanks
Huang Shijie

