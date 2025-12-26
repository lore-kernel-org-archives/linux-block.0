Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6669313266
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766716708; cv=none; b=boYs15rgk/2hrnWFCaQQPLOnZ58V3u/oc3dezqJljtUG1P4BVvPMMGXaOTc9kBYrq50Mk4cwid3/JAyeTFqtg8IblpB6tZSXA5CXxcLWN3G2j7IeZ+v6Yhv8nLAWzlKNAzg0QFugbxkEXxILKvTLhAOnyRK5EbUu+Sk2+IqXjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766716708; c=relaxed/simple;
	bh=Vtum17rJG+twI5O50l0REHnU8/XzSnR8TZrHHT7CL+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET10yto3B98Rbnszg5Ld1gnyS+RXnvaWmlGwtFTC1nNTRPIcUdFFciNhpiBL9tgqN3mrE+8vcAMW+7FmMrs9AzIV1isnx6oo9b8I/kAJ24FvOpC5HZ5rBgYrhCPxCQdkfySZA/Uf6/8t7WslxrGJnghCdRkbKdjUEmNgkEhtLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7Krz9FA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7Krz9FA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766716706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+esAdRZoQ/WrLttAWJs7hQ5aZZqx/pIj8f6AFk7iorQ=;
	b=T7Krz9FAGdKWlfwRaojO1tVWSHMOxKW5kFg/q6QvHzRjqak8DTelC5DBL057vPwVW5hQRr
	rfHw8xNZ5rKp3PwHMyKZYkijKFv+K0Vn7oV6u+p8Ef4yD5IPZulc6YRhXSbI9wekHQORfM
	ZgqllD0AKBPn9Op8gvYrrfbo/wUfQ+k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-Pjy6p1zINNuf6Wre_fTs-w-1; Thu,
 25 Dec 2025 21:38:22 -0500
X-MC-Unique: Pjy6p1zINNuf6Wre_fTs-w-1
X-Mimecast-MFC-AGG-ID: Pjy6p1zINNuf6Wre_fTs-w_1766716701
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A8B01956058;
	Fri, 26 Dec 2025 02:38:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.63])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D72630001B9;
	Fri, 26 Dec 2025 02:38:15 +0000 (UTC)
Date: Fri, 26 Dec 2025 10:38:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 12/20] ublk: implement integrity user copy
Message-ID: <aU31Ey2jWJi8U_53@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-13-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-13-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 16, 2025 at 10:34:46PM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Add a function ublk_copy_user_integrity() to copy integrity information
> between a request and a user iov_iter. This mirrors the existing
> ublk_copy_user_pages() but operates on request integrity data instead of
> regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
> ublk_user_copy() to choose between copying data or integrity data.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: change offset units from data bytes to integrity data bytes,
>  test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET,
>  fix CONFIG_BLK_DEV_INTEGRITY=n build,
>  rebase on ublk user copy refactor]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 43 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 7fa0a9f0bfae..042df4de9253 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -606,10 +606,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
>  {
>  	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
>  		UBLK_TAG_BITS_MASK;
>  }
>  
> +static inline bool ublk_pos_is_integrity(loff_t pos)
> +{
> +	return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FLAG);
> +}
> +
>  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  {
>  	const struct ublk_param_basic *p = &ub->params.basic;
>  
>  	if (p->attrs & UBLK_ATTR_READ_ONLY)
> @@ -1034,10 +1039,31 @@ static size_t ublk_copy_user_pages(const struct request *req,
>  			break;
>  	}
>  	return done;
>  }
>  
> +static size_t ublk_copy_user_integrity(const struct request *req,
> +		unsigned offset, struct iov_iter *uiter, int dir)
> +{
> +	size_t done = 0;
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	struct bio *bio = req->bio;
> +	struct bvec_iter iter;
> +	struct bio_vec iv;
> +
> +	if (!blk_integrity_rq(req))
> +		return 0;
> +
> +	bio_for_each_integrity_vec(iv, bio, iter) {
> +		if (!ublk_copy_user_bvec(iv, &offset, uiter, dir, &done))
> +			break;
> +	}
> +#endif
> +
> +	return done;
> +}

The usual way is to define the whole helper conditionally:

#ifdef CONFIG_BLK_DEV_INTEGRITY
static size_t ublk_copy_user_integrity(const struct request *req,
		unsigned offset, struct iov_iter *uiter, int dir)
{
	...
}
#else
static inline size_t ublk_copy_user_integrity(const struct request *req,
		unsigned offset, struct iov_iter *uiter, int dir)
{
	return 0;
}
#endif

Otherwise, this patch looks fine.


Thanks, 
Ming

