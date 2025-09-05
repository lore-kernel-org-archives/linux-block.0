Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AB33987;
	Fri,  5 Sep 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096336; cv=pass; b=aaq7ai+ZR1vnesHup2yvlkh/kngDqhVx9xKC3F5pAUZPMRw/Y8GmHWED/yaRNusJE6dmoAbbG1mA2xBsroBACu2FK66+SwHdf80FyjlUWHy7KW3WDkye3yYKM2GZ6Avi5vnQxDP+JHvZCUX1XmfYJL9PC8W+2r3JPLdQJ2XywMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096336; c=relaxed/simple;
	bh=s8kMAXHqKircdVDaLnBBCpEe4BCEp5Cm1ra60ZMvMpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcrwPwfYnWpDyv8KVrX/wS6OUxrdujwE9+g+7gnyG6RDNPatOywshA3+dCvaYa6JLz2R+o3dM11U7K8BAyPWyjDl836vOldcXL/RJ6qPzgclc4zcekOyqchMbsoMsy5PXEzJT7vIKvCx8n3lw1aAJISfWeGmtrfmf1q+DD8j8eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=LfG1o50Y; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="LfG1o50Y"
ARC-Seal: i=1; a=rsa-sha256; t=1757096313; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KVRu0YOLCajL4JtVTdijGfXPfuo7RsfWaGVQoGh52MTBGZ+1/M2EBeFnRb92jTg6Df0UdEUtBmM4ucITN0IAH2ZOkYFDZWAJc3Eu1BI/dXhqVP6CoQlBV+cNoeCbSuOtuZ5p5SgwVaaQ3Oyoj/l36CkXeROFAwJG9BvHp2kiuq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757096313; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bFID9GaXPzXFmeOV0W1JROYq36B1IZQI0GNGvxsJiEY=; 
	b=ATveCUn0U/ra2/BMSfyfQSWpXtos0CqlqVMn3yr8PLpOtLtaL4p7bXMN+Yr76Jz208xNduZMGtuFHD0UClNTFMMHr/26YnoGWK0VwXiFGTqb+3z5kurbz9uEfo/ZzWf/972roirXkrOojqgMfnSwl+bHwt7kmFRqDROKzQ2PTb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757096313;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bFID9GaXPzXFmeOV0W1JROYq36B1IZQI0GNGvxsJiEY=;
	b=LfG1o50Y8opQPpM3GFy8l7h24FdebaU6tOt8qp+oxCMSz/xoVbkRRVIenWCvbqJy
	e19HUuZxc/Wdknh9CjjcRCh++s4NanNhClEuEALmo2HFdEVKvkBk6F8h/bEOieZNJUz
	tOYNmFCpmYbbKphBDacMuMsWECI8NWwJNhjl/5t8=
Received: by mx.zohomail.com with SMTPS id 1757096311428106.37132658296662;
	Fri, 5 Sep 2025 11:18:31 -0700 (PDT)
Message-ID: <d918a88b-5dff-43e4-8cf6-77d1b716124f@yukuai.org.cn>
Date: Sat, 6 Sep 2025 02:18:27 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blk-throttle: fix access race during throttle policy
 activation
To: Han Guangjiang <gj.han@foxmail.com>, yukuai1@huaweicloud.com,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: hanguangjiang@lixiang.com, fanggeng@lixiang.com, yangchen11@lixiang.com,
 liangjie@lixiang.com
References: <tencent_E009F9D3A4C7F814018C1DFA80304944BA0A@qq.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <tencent_E009F9D3A4C7F814018C1DFA80304944BA0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

在 2025/9/5 18:24, Han Guangjiang 写道:

> From: Han Guangjiang<hanguangjiang@lixiang.com>
>
> On repeated cold boots we occasionally hit a NULL pointer crash in
> blk_should_throtl() when throttling is consulted before the throttle
> policy is fully enabled for the queue. Checking only q->td != NULL is
> insufficient during early initialization, so blkg_to_pd() for the
> throttle policy can still return NULL and blkg_to_tg() becomes NULL,
> which later gets dereferenced.
>
>   Unable to handle kernel NULL pointer dereference
>   at virtual address 0000000000000156
>   ...
>   pc : submit_bio_noacct+0x14c/0x4c8
>   lr : submit_bio_noacct+0x48/0x4c8
>   sp : ffff800087f0b690
>   x29: ffff800087f0b690 x28: 0000000000005f90 x27: ffff00068af393c0
>   x26: 0000000000080000 x25: 000000000002fbc0 x24: ffff000684ddcc70
>   x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
>   x20: 0000000000080000 x19: ffff000684ddcd08 x18: ffffffffffffffff
>   x17: 0000000000000000 x16: ffff80008132a550 x15: 0000ffff98020fff
>   x14: 0000000000000000 x13: 1fffe000d11d7021 x12: ffff000688eb810c
>   x11: ffff00077ec4bb80 x10: ffff000688dcb720 x9 : ffff80008068ef60
>   x8 : 00000a6fb8a86e85 x7 : 000000000000111e x6 : 0000000000000002
>   x5 : 0000000000000246 x4 : 0000000000015cff x3 : 0000000000394500
>   x2 : ffff000682e35e40 x1 : 0000000000364940 x0 : 000000000000001a
>   Call trace:
>    submit_bio_noacct+0x14c/0x4c8
>    verity_map+0x178/0x2c8
>    __map_bio+0x228/0x250
>    dm_submit_bio+0x1c4/0x678
>    __submit_bio+0x170/0x230
>    submit_bio_noacct_nocheck+0x16c/0x388
>    submit_bio_noacct+0x16c/0x4c8
>    submit_bio+0xb4/0x210
>    f2fs_submit_read_bio+0x4c/0xf0
>    f2fs_mpage_readpages+0x3b0/0x5f0
>    f2fs_readahead+0x90/0xe8
>
> Tighten blk_throtl_activated() to also require that the throttle policy
> bit is set on the queue:
>
>    return q->td != NULL &&
>           test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
>
> This prevents blk_should_throtl() from accessing throttle group state
> until policy data has been attached to blkgs.
>
> Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
> Co-developed-by: Liang Jie<liangjie@lixiang.com>
> Signed-off-by: Liang Jie<liangjie@lixiang.com>
> Signed-off-by: Han Guangjiang<hanguangjiang@lixiang.com>
> ---
> v2:
>   - remove the comment about freeze queue in blk_should_throtl()
>   - Retitle: "blk-throttle: fix access race during throttle policy activation"
> v3:
>   - move blkcg_policy_enabled() to blk-cgroup.h
>   - use blkcg_policy_enabled() instead in blk_throtl_activated()
>   - remove the comment about freeze queue in blk_throtl_init()
>   - add some comments to decribe the throttle init synchronization
>   - Link to v2:https://lore.kernel.org/lkml/tencent_2B678DA920124B08854638A6BE68746CCC05@qq.com/
> ---
>   block/blk-cgroup.c   |  6 ------
>   block/blk-cgroup.h   |  6 ++++++
>   block/blk-throttle.c |  6 +-----
>   block/blk-throttle.h | 18 +++++++++++-------
>   4 files changed, 18 insertions(+), 18 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

