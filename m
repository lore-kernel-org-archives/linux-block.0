Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175004;
	b=nOC6OBuQ112cQngMQO2wJDhGI/22a6Xd7p5AHMpAl/mQS1AuGD6G1yDxVSLTHp5QUQyi
	 7DJN7BBjsuGYXIBZF8ybLx8C+R62JIS8aPrJxtk+CeSfs6JOI2hrgo0A7ZFhhWigBBxnQ
	 WzQTckJt+o8jP88636H+eqFKl2NLfVpfAr9lO3ZkrK5YQ177SDiccT73Xc1zEki3Lm2yA
	 ZeF9vnMpOm2FNskkYO81K223idMOZ/fyTDtrsGwY9L63dkFDUNKpV3+eRGopxFw9uKs2I
	 RhwHVXrfWSNdjpKslRUiA+n/BwJCxrJR1ThzqmVkjRwznbjKLC1wCobbhGcA/4Gjumw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175004;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=8HrHU6q7cUwC44mKCqsCYf3Tfsp+5D/gKCLIsZFQVSA=;
	b=sJLm4O8FSo5uUdxIi7yQt8qy7To3dvbB/W1moychMY64ZQ6MbBtIFVHpjUwNRxfSsJi6
	 gWV2gZuQS5dhrH/rkqdUc3wJv0JhbtL9S1i1W5iI/3Mh4VUcKGDHa6Jol1wsJWWXR8U8c
	 sb2ghEFXm9kswOT+uXvZb890gEwkkaXhA+iQZNonwQJPXrdYlatOwecQCHT7rRe2Tt8oI
	 v6ngHe53PvPJh/1C/kh4d9iHh8Ohxqq+t+rzpH3x/C8xTu8bBasu9Gbp4UUgQIyr8VBaw
	 Wk6GNMAS/z5260/byavz0zk5nyu5pgoUQ2MoubUkHo7S7rNwpq+3sQInR/18XAIiJpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A08606A326;
	Fri, 20 Nov 2026 11:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A08606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jWD3t14szzVcB6;
	Fri, 20 Nov 2026 19:43:06 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jWD3s0Pp3zVcB6;
	Fri, 20 Nov 2026 19:43:05 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 3E53A16E7;
	Fri, 20 Nov 2026 19:42:56 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 20 Nov
 2026 19:43:03 +0800
Date: Fri, 20 Nov 2026 19:43:01 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Christian Brauner <brauner@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, <axboe@kernel.dk>,
	<viro@zeniv.linux.org.uk>, <jack@suse.cz>, <zhongyuan@hygon.cn>,
	<fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>, <agruenba@redhat.com>,
	<mic@digikod.net>, <gnoack@google.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <aleksa@amutable.com>,
	<legion@kernel.org>, <david@kernel.org>, <sandeen@redhat.com>,
	<ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>, <shijie8@gmail.com>
Subject: Re: [PATCH v2 1/3] vfs: add inode iteration methods
Message-ID: <awAyRVD3URaBPhw7@hsj-2U-Workstation>
References: <20261113115702.586594-1-huangsj@hygon.cn>
 <20261113115702.586594-2-huangsj@hygon.cn>
 <avcBTMvzFWuCkwkn@infradead.org>
 <avqmmP4dbwu4ziKz@hsj-2U-Workstation>
 <20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner>
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
In-Reply-To: <20261120-mitverantwortlich-drehbaren-kantholz-241300d20168@brauner>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Fri, Nov 20, 2026 at 12:14:24PM +0100，Christian Brauner 写道：
> On Mon, Nov 16, 2026 at 02:45:44PM +0800, Huang Shijie wrote:
> > > 	struct inode_iter_contex ctx = INODE_ITER_CTX_INIT;
> > > 
> > > 	while ((inode = sb_inode_iter()))) {
> > > 		/* do stuff */
> > > 	}
> > > 
> > How to manage the sb->s_inode_list_lock in this code?
> > 
> > I have no idea how to hide the sb->s_inode_list_lock in this code.
> 
> I think Christoph is right. The lock shouldn't be held across
> iterations. Let the iterator take it, grab a reference to the next
> inode, drop the lock again and hand the inode out. The reference keeps the
okay. 

If we can accept this method, I can change the code following it in future.

> inode on s_inodes so the next call can continue from there.
> 
> This is how drop_pagecache_sb() does it today. Sm like (UNTESTED and not
> nice-ified):
> 
> struct sb_inode_iter {
> 	struct super_block *sb;
> 	struct inode *inode;
> 	bool done;
> };
> 
> struct inode *sb_inode_iter_next(struct sb_inode_iter *it)
> {
> 	struct super_block *sb = it->sb;
> 	struct inode *prev = it->inode, *inode;
> 
> 	if (it->done)
> 		return NULL;
> 
> 	spin_lock(&sb->s_inode_list_lock);
> 	inode = list_prepare_entry(prev, &sb->s_inodes, i_sb_list);
> 	list_for_each_entry_continue(inode, &sb->s_inodes, i_sb_list) {
> 		spin_lock(&inode->i_lock);
> 		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
> 			spin_unlock(&inode->i_lock);
> 			continue;
> 		}
> 		__iget(inode);
> 		spin_unlock(&inode->i_lock);
> 		spin_unlock(&sb->s_inode_list_lock);
> 		it->inode = inode;
> 		iput(prev);
> 		return inode;
> 	}
> 	spin_unlock(&sb->s_inode_list_lock);
> 	it->inode = NULL;
> 	it->done = true;
> 	iput(prev);
> 	return NULL;
> }
> 
> void sb_inode_iter_end(struct sb_inode_iter *it)
> {
> 	iput(it->inode);
> 	it->inode = NULL;
> 	it->done = true;
> }
> 
> and then drop_pagecache_sb() becomes:
> 
> 	struct sb_inode_iter it = { .sb = sb };
> 	struct inode *inode;
> 
> 	while ((inode = sb_inode_iter_next(&it))) {
> 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
> 		cond_resched();
> 	}
> 
> Make it a cleanup class and a caller that breaks out early doesn't have
> to remember sb_inode_iter_end() either.
> 
> This will end because new inodes are added at the head and the cursor
> stays on the list. So these assumptions should get
> VFS_WARN_ON_ONCE()-es.
> 
> Walkers that can't take a reference might need different solution.
> I'm not sure if there are any?
I will think about it.

Thanks
Huang Shijie

