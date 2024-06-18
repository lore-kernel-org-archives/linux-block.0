Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9970291E
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676025; cv=none; b=aETeZiw5o4m2x/V58lciGteyDniCzEqAkbAP2vMYdiLCU9RjEF/OXkSSgYl/cSENRxgNMb6nSM8F1MhflEdu2+8Abl2+e2qdOSoLZ+TGfVq0FHweCIDdw02yNhSm7o8lwx9eyEuq4bUbU6LjH5cMLzGxrMJ4Hb84RdZEbEu2NTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676025; c=relaxed/simple;
	bh=KOMQBf2jooTzgmw4HBPOPDI0ew7y05JsSw1/ua11ves=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFdBn5PhX5cDtuRrM+yTNCV0m9pt+q+LlFnTRvRA3t7/2xrcbYqIGWBflRmZtvTOdlM3YnvmDTRq42zUVZyTvbPG47CkRhbSZNA5WrVrLDYvA9iS84l0ZFPD8Je+0gqU0SlCLTsc3NTKQMc+ml+oRtdeAz/aIRl5ahz/WRE4tTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qcx4LzWN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qcx4LzWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718676022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MitXCo6aiz4MkM4mByNI2I4K4LBxlCdnWpqnHdjsRyo=;
	b=Qcx4LzWNqQLJf+Yb3yNiarPmXZWk1dEf9qO1LWUmn9YFFh2I68Jo0zJGQA1bV8jZGrQXBM
	ETSxb7xc3qbMcKrxO3ZXaAFmdU53/Mq9KSd7yhiWxtoKKcnTLe+C5lw6rH3jF1Q0+BJo5u
	grlzAgMHvzRv1Kz3FwBJ8kK+PMW8sR0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-nI1DI8k1MIWSifssbm-5rA-1; Mon,
 17 Jun 2024 22:00:19 -0400
X-MC-Unique: nI1DI8k1MIWSifssbm-5rA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E5D919560B1;
	Tue, 18 Jun 2024 02:00:17 +0000 (UTC)
Received: from fedora (unknown [10.72.112.49])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED0101956087;
	Tue, 18 Jun 2024 02:00:13 +0000 (UTC)
Date: Tue, 18 Jun 2024 10:00:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] ublk: check recovery flags for validity
Message-ID: <ZnDqKFtBULaddzov@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-2-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617194451.435445-2-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jun 17, 2024 at 01:44:48PM -0600, Uday Shankar wrote:
> Only certain combinations of recovery flags are valid. For example,
> setting UBLK_F_USER_RECOVERY_REISSUE without also setting
> UBLK_F_USER_RECOVERY is currently silently equivalent to not setting any
> recovery flags. Check for such issues and fail add_dev if they are
> detected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4e159948c912..2752a9afe9d4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -59,6 +59,9 @@
>  		| UBLK_F_USER_COPY \
>  		| UBLK_F_ZONED)
>  
> +#define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> +		| UBLK_F_USER_RECOVERY_REISSUE)
> +
>  /* All UBLK_PARAM_TYPE_* should be included here */
>  #define UBLK_PARAM_TYPE_ALL                                \
>  	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> @@ -2341,6 +2344,18 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))
>  		return -EPERM;
>  
> +	/* forbid nonsense combinations of recovery flags */
> +	switch (info.flags & UBLK_F_ALL_RECOVERY_FLAGS) {
> +	case 0:
> +	case UBLK_F_USER_RECOVERY:
> +	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE):
> +		break;
> +	default:
> +		pr_warn("%s: invalid recovery flags %llx\n", __func__,
> +			info.flags & UBLK_F_ALL_RECOVERY_FLAGS);
> +		return -EINVAL;
> +	}
> +

It could be cleaner and more readable to check the fail condition only:

	if ((info.flags & UBLK_F_USER_RECOVERY_REISSUE) &&
		!(info.flags & UBLK_F_USER_RECOVERY)) {
		...
	}


Thanks,
Ming

