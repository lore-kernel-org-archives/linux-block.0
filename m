Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055135971
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671924; cv=none; b=tXrUyWBP1+k/dsDuFjdm8kFuMaIv3PLk0mFlGmkPazHHxeh/9rhUAb47CL1BR6nv89rC9U1uTcCXfgE5ue8pIi1huyUtI7Jn1y4M5JdUDImxv2oTRfGYF3nJEhQ+ViegcsDaeCFCkmAmPX/EtZ9Z5LCqZh36/nGkdjr39czxNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671924; c=relaxed/simple;
	bh=Pl087Q5BnJEEDKWTt11RvP/5ATkq9CnlOVfTQT27NDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRluiaq5zB80fS3aV7IToWVrqkLW4PuDsdOCNpXB6auNxSdpfNA9T8JeXlSx32IsdPyAj/AbaDuxh+WksnAzxUfusJ1A+GRip5PhBdNnmYMRVmW1W39JfPZUfrkna4f2zbirC66SDb0yuly13LfJPj9o+DZJCRRkUtLo1nxbHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf/GH0q6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf/GH0q6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750671921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yB/vxsK+e/3Bdtb56pQ8PqCsThakc6CCsDtYX7lWIpw=;
	b=Jf/GH0q6SmlHt4d4ar/V5Pja7+GhoueNiRl120Y0ROrQZxLOOZHPtC7IAL9bapeIdOC/Zj
	3K6olhh8HHrLCrqFHvrNaV2ofV4IbmPPQXTdiXQQGQs5XJMmxbwX1Cyuw1QHMHotQK6Rra
	/zAQaT2BxW3unPb9Smm3+tLZaj2/fsM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-33qxtIb_NrWctPOe2uLiww-1; Mon,
 23 Jun 2025 05:45:19 -0400
X-MC-Unique: 33qxtIb_NrWctPOe2uLiww-1
X-Mimecast-MFC-AGG-ID: 33qxtIb_NrWctPOe2uLiww_1750671918
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C748F180120C;
	Mon, 23 Jun 2025 09:45:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2345A18003FC;
	Mon, 23 Jun 2025 09:45:15 +0000 (UTC)
Date: Mon, 23 Jun 2025 17:45:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 12/14] ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on
 daemon task
Message-ID: <aFkiJ-gP8Be5drVj@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-13-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-13-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jun 20, 2025 at 09:10:06AM -0600, Caleb Sander Mateos wrote:
> ublk_io_release() performs an expensive atomic refcount decrement. This
> atomic operation is unnecessary in the common case where the request's
> buffer is registered and unregistered on the daemon task before handling
> UBLK_IO_COMMIT_AND_FETCH_REQ for the I/O. So if ublk_io_release() is
> called on the daemon task and task_registered_buffers is positive, just
> decrement task_registered_buffers (nonatomically). ublk_sub_req_ref()
> will apply this decrement when it atomically subtracts from io->ref.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index b2925e15279a..199028f36ec8 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2012,11 +2012,18 @@ static void ublk_io_release(void *priv)
>  {
>  	struct request *rq = priv;
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
>  	struct ublk_io *io = &ubq->ios[rq->tag];
>  
> -	ublk_put_req_ref(ubq, io, rq);
> +	/*
> +	 * task_registered_buffers may be 0 if buffers were registered off task
> +	 * but unregistered on task. Or after UBLK_IO_COMMIT_AND_FETCH_REQ.
> +	 */
> +	if (current == io->task && io->task_registered_buffers)
> +		io->task_registered_buffers--;
> +	else
> +		ublk_put_req_ref(ubq, io, rq);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

