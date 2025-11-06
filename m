Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74543245006
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403279; cv=none; b=NIFGf6bn6CYwux4ztwHQRQeez51+lVf6+wsW0TT2cCKEu7A35q4aJO45CTQpTXAdaxK7gZ3NZIwob1I29TavwmQG69MKOfPiSiPsz5zl9znzVqcV+JYC/zjAiZDZk/Y7WxTpTZp5hLkCzJYZB98XnjUEYbanltWdu5VEr1vWak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403279; c=relaxed/simple;
	bh=uT2zzEe6rtu8oBGdqI7+U9ippLJiZCCOdHqn6R2mDbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO+tilQUIsVoW8Umn5JD39BrbAUYI618lr4MP5l0wuL2YkD0SkdFW1Z7zk49xjzIDrU4EhI6egsabZQKsJ22G0NNnH3LSevU5B3+YBdOX33LcJcxZJ09XPDm1rlUmf67EyE9v329n1EiaC/e2a4IPF71ff8+qxYXDJIX1GMA70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmVMRwYn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmVMRwYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762403276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9Vfrw1KRujThrbFg2bU5JBZHEnXRsqM1wEXeXjFpQE=;
	b=MmVMRwYn4FZQUOew3Fct8GZYZxSZuq1OqOJVJ9MqLAEjxq+7Z9NnXfKr8uwTXu+BvzFqaU
	vsOYUHdYE1/fHHodOw8LDuhNofUgl4oVHAVUAUGmJ6Vna/j288XygX8UJbgUpsI/OWDMwx
	RuSth1LUF9K0Z7ZCLuldb49QJAkhIB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-nPUykFD6Mc-VsMw55TC4qg-1; Wed,
 05 Nov 2025 23:27:53 -0500
X-MC-Unique: nPUykFD6Mc-VsMw55TC4qg-1
X-Mimecast-MFC-AGG-ID: nPUykFD6Mc-VsMw55TC4qg_1762403272
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D22411955F3E;
	Thu,  6 Nov 2025 04:27:51 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25BC5180049F;
	Thu,  6 Nov 2025 04:27:47 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:27:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ublk: use rq_for_each_bvec() for user copy
Message-ID: <aQwjvu-bFZRT-8Ol@fedora>
References: <20251105202823.2198194-1-csander@purestorage.com>
 <20251105202823.2198194-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105202823.2198194-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Nov 05, 2025 at 01:28:23PM -0700, Caleb Sander Mateos wrote:
> ublk_advance_io_iter() and ublk_copy_io_pages() currently open-code the
> iteration over request's bvecs. Switch to the rq_for_each_bvec() macro
> provided by blk-mq to avoid reaching into the bio internals and simplify
> the code. Unlike bio_iter_iovec(), rq_for_each_bvec() can return
> multi-page bvecs. So switch from copy_{to,from}_iter() to
> copy_page_{to,from}_iter() to map and copy each page in the bvec.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 78 ++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 40eee3e15a4c..929d40fe0250 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -911,81 +911,49 @@ static const struct block_device_operations ub_fops = {
>  	.open =		ublk_open,
>  	.free_disk =	ublk_free_disk,
>  	.report_zones =	ublk_report_zones,
>  };
>  
> -struct ublk_io_iter {
> -	struct bio *bio;
> -	struct bvec_iter iter;
> -};
> -
> -/* return how many bytes are copied */
> -static size_t ublk_copy_io_pages(struct ublk_io_iter *data,
> -		struct iov_iter *uiter, int dir)
> +/*
> + * Copy data between request pages and io_iter, and 'offset'
> + * is the start point of linear offset of request.
> + */
> +static size_t ublk_copy_user_pages(const struct request *req,
> +		unsigned offset, struct iov_iter *uiter, int dir)
>  {
> +	struct req_iterator iter;
> +	struct bio_vec bv;
>  	size_t done = 0;
>  
> -	for (;;) {
> -		struct bio_vec bv = bio_iter_iovec(data->bio, data->iter);
> -		void *bv_buf = bvec_kmap_local(&bv);
> +	rq_for_each_bvec(bv, req, iter) {
>  		size_t copied;
>  
> +		if (offset >= bv.bv_len) {
> +			offset -= bv.bv_len;
> +			continue;
> +		}
> +
> +		bv.bv_offset += offset;
> +		bv.bv_len -= offset;
> +		bv.bv_page += bv.bv_offset / PAGE_SIZE;
> +		bv.bv_offset %= PAGE_SIZE;

The above two lines are not needed because copy_page_*_iter() handles
it already.

>  		if (dir == ITER_DEST)
> -			copied = copy_to_iter(bv_buf, bv.bv_len, uiter);
> +			copied = copy_page_to_iter(
> +				bv.bv_page, bv.bv_offset, bv.bv_len, uiter);

WARN in page_copy_sane() is triggered because copy_page_*_iter() requires 
all pages belong to one same compound page.

One quick fix is to replace rq_for_each_bvec() with rq_for_each_segment().

thanks,
Ming

