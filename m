Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D928725D
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770014330; cv=none; b=ilWJ3uRdTeuEtwXqK/xowu7xyglUuC4/TI45tY4HVNvWalx5d+AZgYRn86hzWdE3zBjBSCggoIL0hLAfVF+nWYXCarq3waryoFvcg1V4MWrWRRarzbUAl+UMSTJRWAG+EZ6DPNqxAz2SJ+98cf802RsBRhg4Hsq46rurdqCKHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770014330; c=relaxed/simple;
	bh=Jh1jlZKS37nYXwIDYK+AU6fguh1hXy9VXogl0+CQnFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgjP3cZ3EB66V9VRMFA5As5IhoT0C3dj+dUg3wukwblOBad/5Yw/mVqg81sekvCyJUwy24W4PhMbiqkmM9I4u8Qk0i+3iX99DcbWXr8Zws6hPp3XizYhNiP1V2fFdso2/v6W6SKkfgkMtAyXHqDD99Kk46pPVagprASVLhGopCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4H3z3ycvzYQtxh
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 14:37:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE9E940574
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 14:38:36 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgAXxfVqRoBpe7TlFw--.61719S3;
	Mon, 02 Feb 2026 14:38:36 +0800 (CST)
Message-ID: <e109f724-128c-4d67-a7b2-2165d6036962@huaweicloud.com>
Date: Mon, 2 Feb 2026 14:38:34 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] blk-cgroup: skip dying blkg in
 blkcg_activate_policy()
To: Yu Kuai <yukuai@fnnas.com>
Cc: mkoutny@suse.com, hch@infradead.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, tj@kernel.org, nilay@linux.ibm.com,
 ming.lei@redhat.com, Zheng Qixing <zhengqixing@huawei.com>
References: <20260115163818.162968-1-yukuai@fnnas.com>
 <20260115163818.162968-5-yukuai@fnnas.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <20260115163818.162968-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXxfVqRoBpe7TlFw--.61719S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF17Xw4rCFy8ZrW7AF17trb_yoWkKrg_Ww
	4UGrySvFWkCws5Crs0vFyYqrs8Kr4qqr12grWfur97GF1UJFsxAw13Jws5XFW3CFW7CryU
	JryDXrn3Gr4vqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

Hi Kuai,
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index a6ac6ba9430d..8d9273f61dd5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1625,6 +1625,8 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
>   			 * GFP_NOWAIT failed.  Free the existing one and
>   			 * prealloc for @blkg w/ GFP_KERNEL.
>   			 */
> +			if (hlist_unhashed(&blkg->blkcg_node))
> +				continue;
>   			if (pinned_blkg)
>   				blkg_put(pinned_blkg);
>   			blkg_get(blkg);

We can check hlist_unhashed(&blkg->blkcg_node) earlier, before calling
->pd_alloc_fn(GFP_NOWAIT, ...).

Like this:
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index dbd18b75ec91..aa566f039f88 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1334,6 +1334,9 @@ int blkcg_activate_policy(struct request_queue *q,
         list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
                 struct blkg_policy_data *pd;

+               if (hlist_unhashed(&blkg->blkcg_node))
+                       continue;
+
                 if (blkg->pd[pol->plid])
                         continue;


Thanks,

Qixing

