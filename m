Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4B24DD09
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459777; cv=none; b=tfOK03xy0LWT4HkU37CnNMy4xm1yskQ55pB7WeWsEoVsF53pCdjR3vkBd4KbQL8dzJ3nPMLzui2tVHM1fCofx4yECHAhcf422h5x5AzfOIdVfHxeLnJi6d58nAqNnGBKN3HyRvnvjn0RGLPrcvcdfPzRyKNcebo3BJ7Kou4rHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459777; c=relaxed/simple;
	bh=XXEa42Xq99wKOLyfd3oZa9Jua01KyvdxLYvYUkAsIy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH28THZcqctmUOlYQOvnBuapjxNGXdxEUpGHeA4cK4oPItaKCZSvq+deQWXOtQrI75hbvWbUygeoZtuv1S0ljNJdC9rgdiJJrEwdA/j3zRGpcbyWzV5CZOtngXQnNiNnzaucYsDcf4KmEbx2Ds6c9drRR/hjeUcxZvewHZtz3Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxJKUESh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxJKUESh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749459775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+c1SrI/vIeGZwZ0yUBpAnS8UHNagHMOkcglrCyVMyGc=;
	b=ZxJKUEShSB8MW4oermxbxi5G9vUzwcKau4kP5JiwGCH974w4rf8gAlgal3/tZGa0Jh/IWl
	ezC8dKb3jJRGDsglDTPPHedxdb+fsv7mepvZSHqEdrpimfg2EI6+iLwnPcZvtHPmLnNRcH
	O2MnIudaWV/FPyfbn7BuM7LG0ogIwuU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-grEep_8hNYenl41mz-i9Vw-1; Mon,
 09 Jun 2025 05:02:51 -0400
X-MC-Unique: grEep_8hNYenl41mz-i9Vw-1
X-Mimecast-MFC-AGG-ID: grEep_8hNYenl41mz-i9Vw_1749459770
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5E241800289;
	Mon,  9 Jun 2025 09:02:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54A3319560AB;
	Mon,  9 Jun 2025 09:02:45 +0000 (UTC)
Date: Mon, 9 Jun 2025 17:02:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
Message-ID: <aEajMYnOJ2h82A1-@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-8-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606214011.2576398-8-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jun 06, 2025 at 03:40:10PM -0600, Caleb Sander Mateos wrote:
> ublk_register_io_buf() performs an expensive atomic refcount increment,
> as well as a lot of pointer chasing to look up the struct request.
> 
> Create a separate ublk_daemon_register_io_buf() for the daemon task to
> call. Initialize ublk_rq_data's reference count to a large number, count
> the number of buffers registered on the daemon task nonatomically, and
> atomically subtract the large number minus the number of registered
> buffers in ublk_commit_and_fetch().
> 
> Also obtain the struct request directly from ublk_io's req field instead
> of looking it up on the tagset.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 59 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2084bbdd2cbb..ec9e0fd21b0e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -81,12 +81,20 @@
>  #define UBLK_PARAM_TYPE_ALL                                \
>  	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>  	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
>  	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
>  
> +/*
> + * Initialize refcount to a large number to include any registered buffers.
> + * UBLK_IO_COMMIT_AND_FETCH_REQ will release these references minus those for
> + * any buffers registered on the io daemon task.
> + */
> +#define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
> +
>  struct ublk_rq_data {
>  	refcount_t ref;
> +	unsigned buffers_registered;
>  
>  	/* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
>  	u16 buf_index;
>  	void *buf_ctx_handle;
>  };
> @@ -677,11 +685,12 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
>  		struct request *req)
>  {
>  	if (ublk_need_req_ref(ubq)) {
>  		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
>  
> -		refcount_set(&data->ref, 1);
> +		refcount_set(&data->ref, UBLK_REFCOUNT_INIT);
> +		data->buffers_registered = 0;
>  	}
>  }
>  
>  static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
>  		struct request *req)
> @@ -706,10 +715,19 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
>  	} else {
>  		__ublk_complete_rq(req);
>  	}
>  }
>  
> +static inline void ublk_sub_req_ref(struct request *req)
> +{
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> +	unsigned sub_refs = UBLK_REFCOUNT_INIT - data->buffers_registered;
> +
> +	if (refcount_sub_and_test(sub_refs, &data->ref))
> +		__ublk_complete_rq(req);
> +}
> +
>  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
>  {
>  	return ubq->flags & UBLK_F_NEED_GET_DATA;
>  }
>  
> @@ -1184,14 +1202,12 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
>  
>  static void ublk_auto_buf_reg_fallback(struct request *req)
>  {
>  	const struct ublk_queue *ubq = req->mq_hctx->driver_data;
>  	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
> -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
>  
>  	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
> -	refcount_set(&data->ref, 1);
>  }
>  
>  static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
>  			      unsigned int issue_flags)
>  {
> @@ -1207,13 +1223,12 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
>  			return true;
>  		}
>  		blk_mq_end_request(req, BLK_STS_IOERR);
>  		return false;
>  	}
> -	/* one extra reference is dropped by ublk_io_release */
> -	refcount_set(&data->ref, 2);
>  
> +	data->buffers_registered = 1;
>  	data->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
>  	/* store buffer index in request payload */
>  	data->buf_index = pdu->buf.index;
>  	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
>  	return true;
> @@ -1221,14 +1236,14 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
>  
>  static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
>  				   struct request *req, struct ublk_io *io,
>  				   unsigned int issue_flags)
>  {
> +	ublk_init_req_ref(ubq, req);
>  	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
>  		return ublk_auto_buf_reg(req, io, issue_flags);
>  
> -	ublk_init_req_ref(ubq, req);
>  	return true;
>  }
>  
>  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
>  			  struct ublk_io *io)
> @@ -2019,10 +2034,31 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
>  	}
>  
>  	return 0;
>  }
>  
> +static int ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
> +				       const struct ublk_queue *ubq,
> +				       const struct ublk_io *io,
> +				       unsigned index, unsigned issue_flags)
> +{
> +	struct request *req = io->req;
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> +	int ret;
> +
> +	if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
> +		return -EINVAL;
> +
> +	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
> +				      issue_flags);
> +	if (ret)
> +		return ret;
> +
> +	data->buffers_registered++;

This optimization replaces one ublk_get_req_ref()/refcount_inc_not_zero()
with data->buffers_registered++ in case of registering io buffer from
daemon context.

And in typical implementation, the unregistering io buffer should be done
in daemon context too, then I am wondering if any user-visible improvement
can be observed in this more complicated & fragile way:

- __ublk_check_and_get_req() is bypassed.

- buggy application may overflow ->buffers_registered

So can you share any data about this optimization on workload with local
registering & remote un-registering io buffer? Also is this usage
really one common case?


Thanks, 
Ming

