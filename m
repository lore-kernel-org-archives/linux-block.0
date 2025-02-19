Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6095A4D5
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939052; cv=none; b=QySJGJiQKFt4Kt4pq4JLYFa7XngxsovR7MiiAFwTXrgJknydz36U1RE6pFgaGjIMKMI/yIurIlx6enQKLR4rheiKY3pQTqCOznet/BzXU8chGuO38qh6/tXUgp7zLL4ppakB70B1P0a7pmAcKpIU6gAcvDe3EqFa780QjZnFRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939052; c=relaxed/simple;
	bh=3CD/ZPjsCQPmETMb5DZKcjnBwYgxhAE4QS/QVnf3sGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deNWNUfJ338Meq8XIkpwmXSY7bwiowN18Yx6yweW9oO5abAgKoKe7ljDxU1VhRFUTAwJzHzy8Hj8SMZIMWxN9K2aVfcIoqp6YMcPeAh3pq2F1cTSL30u6Yt28F6lTFKrPwwI7m56WhHo3D/BWG83+mLY8NriZI0duB9vK93yQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+0KPANA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+0KPANA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739939048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCl7k57En+hDzI4osxx0dMsVaAr0wyGyPuMHH/iPr44=;
	b=c+0KPANAE278gH2WxO4NXgFezbkFuhE2ZGvyskkP8k9Yn3grAG2iRumZ45526jjiZvi1MM
	qb1ZYoy3VDpctm2sB4zdvKJXlKY63AVcIgNZHkiw7gwKua5u17+GRIsnecWU6xo092z3Rj
	/LyFs9dZB7lKkaSVwl1QiHRW2eJs7tc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-NeB7cSpMNKOB4WYe2rfYbQ-1; Tue,
 18 Feb 2025 23:24:04 -0500
X-MC-Unique: NeB7cSpMNKOB4WYe2rfYbQ-1
X-Mimecast-MFC-AGG-ID: NeB7cSpMNKOB4WYe2rfYbQ_1739939040
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC12219560BC;
	Wed, 19 Feb 2025 04:23:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EAFB1800357;
	Wed, 19 Feb 2025 04:23:52 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:23:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/5] io_uring: move fixed buffer import to issue path
Message-ID: <Z7Vc0gWj-NNxqLME@fedora>
References: <20250218224229.837848-1-kbusch@meta.com>
 <20250218224229.837848-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218224229.837848-2-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Feb 18, 2025 at 02:42:25PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Similar to the fixed file path, requests may depend on a previous one
> to set up an index, so we need to allow linking them. The prep callback
> happens too soon for linked commands, so the lookup needs to be deferred
> to the issue path. Change the prep callbacks to just set the buf_index
> and let generic io_uring code handle the fixed buffer node setup, just
> like it already does for fixed files.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

...

> diff --git a/io_uring/net.c b/io_uring/net.c
> index 000dc70d08d0d..39838e8575b53 100644
> --- a/io_uring/net.c
> +++ b/io_uring/net.c
> @@ -1373,6 +1373,10 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  #endif
>  	if (unlikely(!io_msg_alloc_async(req)))
>  		return -ENOMEM;
> +	if (zc->flags & IORING_RECVSEND_FIXED_BUF) {
> +		req->buf_index = zc->buf_index;
> +		req->flags |= REQ_F_FIXED_BUFFER;
> +	}
>  	if (req->opcode != IORING_OP_SENDMSG_ZC)
>  		return io_send_setup(req, sqe);
>  	return io_sendmsg_setup(req, sqe);
> @@ -1434,25 +1438,10 @@ static int io_send_zc_import(struct io_kiocb *req, unsigned int issue_flags)
>  	struct io_async_msghdr *kmsg = req->async_data;
>  	int ret;
>  
> -	if (sr->flags & IORING_RECVSEND_FIXED_BUF) {
> -		struct io_ring_ctx *ctx = req->ctx;
> -		struct io_rsrc_node *node;
> -
> -		ret = -EFAULT;
> -		io_ring_submit_lock(ctx, issue_flags);
> -		node = io_rsrc_node_lookup(&ctx->buf_table, sr->buf_index);
> -		if (node) {
> -			io_req_assign_buf_node(sr->notif, node);

Here the node buffer is assigned to ->notif req, instead of the current
request, and you may have to deal with this case here.

Otherwise, this patch looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

