Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8822DFB5
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669749; cv=none; b=Oxt5M8XYFP88RkyLmgv5G2mewm/9HN+JF23wMv2j9P17COcK7sJVMveRJ8yxuZM6DVFzbhSx4x/GQbdBxl/g7gUYAM4eDU8nENQLPZoHPkXRN08dyuvrVH/L0qMY0rSe8dHiebVeAF6S3tygAj3y0+WH/ojj4nP2lAqzIIXMMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669749; c=relaxed/simple;
	bh=/+0X/y1zKQLFjqJVkGOtG6fEGO6zhDWr4qpErC9hdZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDl2MFoIaU83mKkjRs8J9R2CHOCftrMlKZ2s68KHOImTkiQVq6o2pBkHNOfeDzWuBkZ/l2ql+GqXTvMtDDOKq6coE56BynXr4EKR6ooiFQ1mxiXo8MTuiZThl89xEO4QLRb4O0YXh5ryqISVmZtJ//SsDEX2fKmJ4sOVwCaZFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpPsfwpO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpPsfwpO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750669746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnH9HmDl1pOVJO2VTxv0ftvtC9CNKX+MCrBGh+LPabc=;
	b=LpPsfwpO6d21iNfSHIIvizTdTgjnJpXoio/CfTbzD1W6XTSUQxCuSWR2AF+UOvHM5G2syb
	dHGg4436+GjtI83i+zio8BRH82eTs9pp1uvO5FzuVuRvCDYL0P/I4SwuyrwQFjSYu9BKsa
	Nwv1isg84pv+hEfcc9lom+nwmh8vG3A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-zbOY3Oz2M8qpVvAshzriKA-1; Mon,
 23 Jun 2025 05:09:03 -0400
X-MC-Unique: zbOY3Oz2M8qpVvAshzriKA-1
X-Mimecast-MFC-AGG-ID: zbOY3Oz2M8qpVvAshzriKA_1750669742
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A770619560A3;
	Mon, 23 Jun 2025 09:09:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C31FB30001A1;
	Mon, 23 Jun 2025 09:08:59 +0000 (UTC)
Date: Mon, 23 Jun 2025 17:08:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 10/14] ublk: return early if blk_should_fake_timeout()
Message-ID: <aFkZobibAtx-S-uU@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-11-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-11-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jun 20, 2025 at 09:10:04AM -0600, Caleb Sander Mateos wrote:
> Make the unlikely case blk_should_fake_timeout() return early to reduce
> the indentation of the successful path.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 11aa65f36ec9..f53618391141 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2143,13 +2143,14 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
>  	io->res = ub_cmd->result;
>  
>  	if (req_op(req) == REQ_OP_ZONE_APPEND)
>  		req->__sector = ub_cmd->zone_append_lba;
>  
> -	if (likely(!blk_should_fake_timeout(req->q)))
> -		ublk_put_req_ref(ubq, io, req);
> +	if (unlikely(blk_should_fake_timeout(req->q)))
> +		return 0;
>  
> +	ublk_put_req_ref(ubq, io, req);
>  	return 0;
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

