Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBDF28691
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503832; cv=none; b=Ks6L+I2tgHzhb9YL82TUJZ7NSppLGWwQ3ZIJG0xu8g7950IOmb5gOGgpxEZYSGcGt58f+fjNojW6Dh0QQNqL9a97TqNHqvq3dcfI75T/DA/F6lDcy7HJ4isPWdAniY7jb0x+xsKBzCXbvwfiiJzhmmFL4G5HBpbArS0IKg3JYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503832; c=relaxed/simple;
	bh=auQ+6JNGmxuYoySz87Iiz3UvPdmUkG1r31DfVx5Z5u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqE7F92V+azuQFUSNLAiHFgn112B6AQe13bGuphyHKc+ZhPRWBewYjwzRL9YhxVlsj845hmRxMimXxU6TL5Zz16mRxi13U9T6czONIYdQL8f8/jJt1M4LhR2p5wlkL+O1nCb2k64wt6DVWsjI+kkhZ5ixuzp8SbexaVEO35UfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bS5BIkV9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bS5BIkV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739503829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjUHYY/ju5RxBcfd1kJd6fuyd2cD4tYY6MBYoyzN+tI=;
	b=bS5BIkV95120Td4Zy2OFsjp4006BQgu20CiKJlQnydxqQ+3JickNmNVDwDf6lTaJkwiKYA
	euMNFt9KHLCuaPcuqjtdTaUk2IKa9SHcpze8hQ2c5XwfRaYZPLoNZmrzChLuRKOk+zMiQD
	gCjpErvVqrJbHnPap/W01DwKS8u0lZs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-EjTbHjz6OxmcEo8rrYBuyA-1; Thu,
 13 Feb 2025 22:30:24 -0500
X-MC-Unique: EjTbHjz6OxmcEo8rrYBuyA-1
X-Mimecast-MFC-AGG-ID: EjTbHjz6OxmcEo8rrYBuyA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 293E51801A16;
	Fri, 14 Feb 2025 03:30:23 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 767141800365;
	Fri, 14 Feb 2025 03:30:16 +0000 (UTC)
Date: Fri, 14 Feb 2025 11:30:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 3/6] io_uring: add support for kernel registered bvecs
Message-ID: <Z664w0GrgA8LjYko@fedora>
References: <20250211005646.222452-1-kbusch@meta.com>
 <20250211005646.222452-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211005646.222452-4-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Feb 10, 2025 at 04:56:43PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
> 
> User space must register an empty fixed buffer table with io_uring in
> order for the kernel to make use of it.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

...

>  
> +int io_buffer_register_bvec(struct io_ring_ctx *ctx, struct request *rq,
> +			    void (*release)(void *), unsigned int index)
> +{
> +	struct io_rsrc_data *data = &ctx->buf_table;
> +	struct req_iterator rq_iter;
> +	struct io_mapped_ubuf *imu;
> +	struct io_rsrc_node *node;
> +	struct bio_vec bv;
> +	u16 nr_bvecs;
> +	int i = 0;
> +
> +	lockdep_assert_held(&ctx->uring_lock);
> +
> +	if (!data->nr)
> +		return -EINVAL;
> +	if (index >= data->nr)
> +		return -EINVAL;
> +
> +	node = data->nodes[index];
> +	if (node)
> +		return -EBUSY;
> +
> +	node = io_rsrc_node_alloc(IORING_RSRC_KBUFFER);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->release = release;
> +	node->priv = rq;
> +
> +	nr_bvecs = blk_rq_nr_phys_segments(rq);
> +	imu = kvmalloc(struct_size(imu, bvec, nr_bvecs), GFP_KERNEL);
> +	if (!imu) {
> +		kfree(node);
> +		return -ENOMEM;
> +	}
> +
> +	imu->ubuf = 0;
> +	imu->len = blk_rq_bytes(rq);
> +	imu->acct_pages = 0;
> +	imu->nr_bvecs = nr_bvecs;
> +	refcount_set(&imu->refs, 1);
> +	node->buf = imu;

request buffer direction needs to be stored in `imu`, for READ,
the buffer is write-only, and for WRITE, the buffer is read-only,
which isn't different with user mapped buffer.

Meantime in read_fixed/write_fixed side or buffer lookup abstraction
helper, the buffer direction needs to be validated.


Thanks,
Ming

