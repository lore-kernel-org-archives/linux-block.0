Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA521386D1
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464476; cv=none; b=p1iF0CdiQcPNeJMdoC44bJb03yJy4t6JcUWUsZzWZ+YOSboVQCQSu95zm3O/jkCZQzgDll98VXIuaYHiJAOYhdbRuV/+vKonINr9o2krfKJPX16qSmtooNZonvFi2xKxzUsdJis7wJpLYjsrcuAMA/UVb6OJcjzISNczK2kpUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464476; c=relaxed/simple;
	bh=90tuKrUWcNjEg3Qnxq7XEyrl7dqi8tX3BxxtJmME1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms3XMswtjlJUNE38r4Dvoi2f7deJIP5HnpOTsq4joTsu4gB5yUeeohdCl64PreZeVIt01bLpiRAIi2GN35Rs/LVOp96i+QCmCJyWLtwMuWiSIER5RcIh0Rh6/I4epQzAinLP37FMddt/5Cuoqo3YfehF39pwSoIYs2HzbagU/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4jA24/p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4jA24/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717464474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Z7SRvzAMckA3XNXJwgjMYaITshj7fSHWjmozr7eVY8=;
	b=E4jA24/p47AyQowE0S9BB5byrtpeQTGBNucA/DOBJu1Lzt2ONqtdCqs6pan6NdorSeD9ys
	vrSwxunO2VUd4X4af+y+VhGZljFxLay9rYsIdpwieWuSQDXNn13cBn+aSeaU1ENDYJgmL+
	g5bW/wzNhM/kQXeh2zdbTlzRmvftfBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-RGD_dGosNgWi7FEPvIMLBA-1; Mon, 03 Jun 2024 21:27:48 -0400
X-MC-Unique: RGD_dGosNgWi7FEPvIMLBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD671800CAC;
	Tue,  4 Jun 2024 01:27:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AD641000552;
	Tue,  4 Jun 2024 01:27:42 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:27:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] null_blk: fix validation of block size
Message-ID: <Zl5tilC7VGtmNHBe@fedora>
References: <20240603192645.977968-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603192645.977968-1-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Mon, Jun 03, 2024 at 09:26:45PM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
> check does not validate this, so update the check.
> 
> Without this patch, null_blk would Oops due to a null pointer deref when
> loaded with bs=1536 [1].
> 
> Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
> 
> Changes from v2:
> 
>  - Use blk_validate_block_size instead of open coding the check.
>  - Change upper bound of chec from 4096 to PAGE_SIZE.
> 
> V1: https://lore.kernel.org/all/20240601202351.691952-1-nmi@metaspace.dk/
> 
>  drivers/block/null_blk/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eb023d267369..967d39d191ca 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1823,8 +1823,9 @@ static int null_validate_conf(struct nullb_device *dev)
>  		dev->queue_mode = NULL_Q_MQ;
>  	}
>  
> -	dev->blocksize = round_down(dev->blocksize, 512);
> -	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
> +	if (blk_validate_block_size(dev->blocksize) != 0) {
> +		return -EINVAL;
> +	}

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

