Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E4184D
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545541; cv=none; b=DmYQGbfXnKjLGcaIA6Sv7cC+VJ4L7/evcjE184+ayyYs1mrkfIim8heroW1I2ZMpyftmOGs6VwonEicNW38FA7HQloihyfPFo3uayR3g8N5VH9aYwzj8rwIGuE01JvfPMhwluU3DAY5QNvGMImjlTOy3yk4YJGeoaQgU6xZ5PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545541; c=relaxed/simple;
	bh=kd3HmlL1J5TPVa464Uum7Rl/V73kiLZS6zLooEMh0c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUJorqeoa+gSzKYW5KYSSP5UodZp1khzdSlhGl6lpUu/x3KNdq1GYDz4QwDkJERqxK7HLAoe6zaTieuY340QkDsmPHN89mwy7FUpXHGcrlTqZQ7wci6f1MisJr84TrCNHZTMxSxdSPg4njxb/zsF+oDx20N8oJBs7jYMlBI1Pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmTfs2br; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmTfs2br"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712545538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2Hfu0a2BL9dtIWKplhcoibT4GCFoFLfLGhdY6cHz34=;
	b=DmTfs2brlJXKciTCtM9xng7iU3vrQs8I+oxgLuIRyAK1xyDgHa4SbiiwqKRInMDQi36EYE
	DLQVUPyBYHQPkuUuhFOr7wjHn8i31jjdozDYQwJymujhjDo9vclHH3ZCSgAT14vhuXIPxL
	pSr8Kqrg5ARDIHs609rLFzbkbVR8MNw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-vfaJJTuwNsWHmNbeKacOiw-1; Sun, 07 Apr 2024 23:05:33 -0400
X-MC-Unique: vfaJJTuwNsWHmNbeKacOiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D87B388807F;
	Mon,  8 Apr 2024 03:05:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B25F3210FD20;
	Mon,  8 Apr 2024 03:05:29 +0000 (UTC)
Date: Mon, 8 Apr 2024 11:05:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: fix q->blkg_list corruption during disk rebind
Message-ID: <ZhNe8R8uAO1ehydo@fedora>
References: <20240407125910.4053377-1-ming.lei@redhat.com>
 <eaa3d105-f37b-3c3b-9e3d-340ae8f5f252@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaa3d105-f37b-3c3b-9e3d-340ae8f5f252@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Sun, Apr 07, 2024 at 09:40:52PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/04/07 20:59, Ming Lei 写道:
> > Multiple gendisk instances can allocated/added for single request queue
> > in case of disk rebind. blkg may still stay in q->blkg_list when calling
> > blkcg_init_disk() for rebind, then q->blkg_list becomes corrupted.
> > 
> > Fix the list corruption issue by:
> > 
> > - add blkg_init_queue() to initialize q->blkg_list & q->blkcg_mutex only
> > - move calling blkg_init_queue() into blk_alloc_queue()
> > 
> > The list corruption should be started since commit f1c006f1c685 ("blk-cgroup:
> > synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> > which delays removing blkg from q->blkg_list into blkg_free_workfn().
> 
> I'm not familiar with how bind/unbind works yet, however, the patch
> itself looks reasonable to me, the initialization of fields related to
> queue should not be delayed to disk allocation.
> 
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Thanks!

> 
> BTW, it looks like the whole blkcg_init_disk() can go away:
>  - init of ioprio and blk-throttle can be delayed to the first user
> configuration;
>  - root_blkg allocation doesn't rely on disk at all;
> 
> Or is there any plan to move the blkcg related field or code path to
> gendisk instead of queue? I might missing some previous discussions.

Christoph worked towards this direction, but not succeed:

a06377c5d01e Revert "blk-cgroup: pin the gendisk in struct blkcg_gq"
9a9c261e6b55 Revert "blk-cgroup: pass a gendisk to blkg_lookup"
1231039db31c Revert "blk-cgroup: move the cgroup information to struct gendisk"
dcb522014351 Revert "blk-cgroup: simplify blkg freeing from initialization failure paths"



Thanks, 
Ming

