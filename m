Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C739CD08
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789705229; cv=none; b=bE3xoBCF5/9M69iUJrU3OkvbHAPoVAzv+FPA0i0MhEMTQCGI4igXd3Tn2P5RiDTSiPdFrVC7ZbeWg+XsqVucYtkCaqsXNj0ttRAogovcalgonnAPXcJiDAsb+aHK3Va/KhIZGCb73rnT+pnYR+oi22Twuk7IaGmsvkv9N1B9sMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789705229; c=relaxed/simple;
	bh=4tdY4Nfbp0zM9DiVLocaK1bcmB+KB1nfM1YBPTpz6Gk=;
	h=Subject:In-Reply-To:Content-Type:From:References:Mime-Version:To:
	 Cc:Date:Message-Id; b=hotWKBoyaPmrNJRQT0SeVjxlMpI7+HWucTr+4cAECvCGyU4grbWktvJI8uDMf8gr2dItg5xFb9XJidLmTexxoqVfLXg/Dqow4O4yZ0hBVUVfMrYleiYPQfMe0sk6CKY9rQPQUJI9xdb98u2t6EEwZ7YYpYnPM7eT3dghg+O98mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=gOHXTN/J; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="gOHXTN/J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1789705216;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=aHjF+snUB7WsHjLwAEnV2J7aPUtJxbViNwazCqeh7NA=;
 b=gOHXTN/JNPWkcbFkpznywkh2LWUY6t5DzsuZxWdrCTAP/LuEeQCPXTJNYdexscjTYejQdM
 W1u8lVEwAvfKBvE/Vr9LuN50/HeoWF3F770ur4J20GJJbanUH2m7sdlkgWshkxUhkgl5wq
 UY234VmLpvXSxD4QZQtL+ww8swKYvillcDSM5ChE8wJL+KvrECB3gGdVIujKPemQBHagMx
 TKzZf9jYmRbxQI1VQ/9OHBlzDmmJZWKCFeCv85gJjXqnYB6BSFKIjBRDlrneoNrz9BOYuw
 +6wsWp8Ozqb3exyC5RzZPK5ohO7swISa8s6OHJbP+ESpljNXhDimgcP3/bl2+Q==
Subject: Re: [PATCH] blk-cgroup: wait for old blkgs to leave queue before disk rebind
In-Reply-To: <20260818065823.753357-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
References: <20260818065823.753357-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Cc: <hch@lst.de>, <tj@kernel.org>, <josef@toxicpanda.com>, 
	<ming.lei@redhat.com>, <linux-kernel@vger.kernel.org>
Date: Fri, 18 Sep 2026 12:20:11 +0800
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.142]) by smtp.larksuite.com with ESMTPS; Fri, 18 Sep 2026 04:20:14 +0000
X-Lms-Return-Path: <lba+26aacbbff+a96743+vger.kernel.org+yukuai@fygo.io>
Reply-To: yukuai@fygo.io
User-Agent: Mozilla Thunderbird
Message-Id: <65258a92-967e-457b-a367-0e484006f3c0@fygo.io>

Hi, Jens

=E5=9C=A8 2026/8/18 14:58, Yu Kuai =E5=86=99=E9=81=93:

> From: Yu Kuai <yukuai@fygo.io>
>
> blkcg_init_disk() currently waits for q->root_blkg to become NULL before
> initializing blkcg state for a rebound disk. However, blkg_destroy_all()
> clears q->root_blkg after calling blkg_destroy() for each blkg. At that
> point the initial references have only been killed, and the blkgs remain
> on q->blkg_list until the remaining references drain and
> blkg_free_workfn() removes them.
>
> A rebound disk can therefore install new blkcg state while old blkgs are
> still attached to the request queue. Wait for q->blkg_list to become empt=
y
> instead, and wake the waiter when the final blkg is removed. This covers
> the complete queue-side blkg lifetime without adding separate state.
>
> Fixes: 3dbaacf6ab68 ("blk-cgroup: wait for blkcg cleanup before initializ=
ing new disk")
> Signed-off-by: Yu Kuai <yukuai@fygo.io>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-cgroup.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Friendly ping ...

>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 2b5c29434e42..6e1e12841880 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -136,6 +136,8 @@ static void blkg_free_workfn(struct work_struct *work=
)
>   		blkg_put(blkg->parent);
>   	spin_lock_irq(&q->queue_lock);
>   	list_del_init(&blkg->q_node);
> +	if (list_empty(&q->blkg_list))
> +		wake_up_var(&q->blkg_list);
>   	spin_unlock_irq(&q->queue_lock);
>   	mutex_unlock(&q->blkcg_mutex);
>  =20
> @@ -612,8 +614,6 @@ static void blkg_destroy_all(struct gendisk *disk)
>   	q->root_blkg =3D NULL;
>   	spin_unlock_irq(&q->queue_lock);
>   	mutex_unlock(&q->blkcg_mutex);
> -
> -	wake_up_var(&q->root_blkg);
>   }
>  =20
>   static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat=
 *src)
> @@ -1472,14 +1472,10 @@ int blkcg_init_disk(struct gendisk *disk)
>   	/*
>   	 * If the queue is shared across disk rebind (e.g., SCSI), the
>   	 * previous disk's blkcg state is cleaned up asynchronously via
> -	 * disk_release() -> blkcg_exit_disk(). Wait for that cleanup to
> -	 * finish (indicated by root_blkg becoming NULL) before setting up
> -	 * new blkcg state. Otherwise, we may overwrite q->root_blkg while
> -	 * the old one is still alive, and radix_tree_insert() in
> -	 * blkg_create() will fail with -EEXIST because the old entries
> -	 * still occupy the same queue id slot in blkcg->blkg_tree.
> +	 * disk_release() -> blkcg_exit_disk(). Wait for all old blkgs to be
> +	 * removed from the queue list before setting up new blkcg state.
>   	 */
> -	wait_var_event(&q->root_blkg, !READ_ONCE(q->root_blkg));
> +	wait_var_event(&q->blkg_list, list_empty_careful(&q->blkg_list));
>  =20
>   	new_blkg =3D blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
>   	if (!new_blkg)

--=20
Thanks,
Kuai
