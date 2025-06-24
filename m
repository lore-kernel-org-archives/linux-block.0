Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95F26B2AC
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761572; cv=none; b=Xa2axVI6yDyGvgdjZNP9ACGJymKfFJb5+I2N1SBeobCzJvJp370/buASv8Q6DQ8iAwTRfx9nb0ccmiOPFr93LN/dTMWtPUriNzSUnFQegyDtFXRlNamS9ROyuYJDuBtVP7qnh5ehTAlLTeS7Fu1UlGNBegAMaCiyiqfbmlkIMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761572; c=relaxed/simple;
	bh=LRCNJSxt7d6f+0QSYZL1Cj+fE27Z/JVDf8nhHeA8MQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb/abYAP3QhEPIDBv8jiUZpjI3asPAj3gdkS29DNYhTCRkrY1S/+upcI0R78Z5ggrk5tdhekrITgtjl1/QDZQl0quadA1tWCQLstwpiEaImy33fLv7HMjJUMm+iQfWD8fxYZL6mwb0IkrYczLYGJfcENEn9DeKNyf9pzH+jFdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SX5MoIac; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SX5MoIac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750761569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiWzAZPkVXfG8bt/dZN2XYhUEw1yEdHEr1JTx9nwrnk=;
	b=SX5MoIacDBTO/f1PcHRvTs6rYu11zGiaR6GxegfLg7kvFk/QYFFFfOwAVmzccyO432LSE3
	eMAsVz/aEw1ctpyIXUQi1SoGC7P7aptOkN0INH21OGx4PzCgE5kDlvxBGWCTcxOhPHWFV6
	9vDXz0cXVbe4NrbfE4NmLAflE8zFxDw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-63U_O0cENzuI9xHkISxlBg-1; Tue,
 24 Jun 2025 06:39:24 -0400
X-MC-Unique: 63U_O0cENzuI9xHkISxlBg-1
X-Mimecast-MFC-AGG-ID: 63U_O0cENzuI9xHkISxlBg_1750761562
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64D1119560B5;
	Tue, 24 Jun 2025 10:39:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77DC330001A1;
	Tue, 24 Jun 2025 10:39:17 +0000 (UTC)
Date: Tue, 24 Jun 2025 18:39:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] ublk: setup ublk_io correctly in case of ublk_get_data()
 failure
Message-ID: <aFqAUElamyZlmC6B@fedora>
References: <20250624022049.825370-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022049.825370-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 24, 2025 at 10:20:49AM +0800, Ming Lei wrote:
> If ublk_get_data() fails, -EIOCBQUEUED is returned and the current command
> becomes ASYNC. And the only reason is that mapping data can't move on,
> because of no enough pages or pending signal, then the current ublk request
> has to be requeued.
> 
> Once the request need to be requeued, we have to setup `ublk_io` correctly,
> including io->cmd and flags, otherwise the request may not be forwarded to
> ublk server successfully.
> 
> Fixes: 9810362a57cb ("ublk: don't call ublk_dispatch_req() for NEED_GET_DATA")
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/linux-block/CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index d36f44f5ee80..03ac394c69a7 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1148,8 +1148,8 @@ static inline void __ublk_complete_rq(struct request *req)
>  	blk_mq_end_request(req, res);
>  }
>  
> -static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
> -				 int res, unsigned issue_flags)
> +static struct io_uring_cmd *__ublk_prep_compl_io_cmd(struct ublk_io *io,
> +						     struct request *req)
>  {
>  	/* read cmd first because req will overwrite it */
>  	struct io_uring_cmd *cmd = io->cmd;
> @@ -1164,6 +1164,13 @@ static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
>  	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
>  
>  	io->req = req;
> +	return cmd;
> +}
> +
> +static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
> +				 int res, unsigned issue_flags)
> +{
> +	struct io_uring_cmd *cmd = __ublk_prep_compl_io_cmd(io, req);
>  
>  	/* tell ublksrv one io request is coming */
>  	io_uring_cmd_done(cmd, res, 0, issue_flags);
> @@ -2148,10 +2155,9 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
>  	return 0;
>  }
>  
> -static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
> +static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
> +			  struct request *req)
>  {
> -	struct request *req = io->req;
> -
>  	/*
>  	 * We have handled UBLK_IO_NEED_GET_DATA command,
>  	 * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
> @@ -2178,6 +2184,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  	u32 cmd_op = cmd->cmd_op;
>  	unsigned tag = ub_cmd->tag;
>  	int ret = -EINVAL;
> +	struct request *req;
>  
>  	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
>  			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
> @@ -2237,10 +2244,19 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  		break;
>  	case UBLK_IO_NEED_GET_DATA:
>  		io->addr = ub_cmd->addr;
> -		if (!ublk_get_data(ubq, io))
> -			return -EIOCBQUEUED;
> -
> -		return UBLK_IO_RES_OK;
> +		/*
> +		 * ublk_get_data() may fail and fallback to requeue, so keep
> +		 * uring_cmd active first and prepare for handling new requeued
> +		 * request
> +		 */
> +		req = io->req;
> +		ublk_fill_io_cmd(io, cmd, io->addr);

The above io->addr assignment can be moved to ublk_fill_io_cmd(), so please ignore
this one.


Thanks, 
Ming

