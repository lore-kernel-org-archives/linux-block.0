Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248928688C
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708892; cv=none; b=iXDTJmZPoSKEhUnHngsOpdHZrHJQ5OeAMRKwnAqOshz2/xqqpmHPZXnJM0SeGSE6DWFyWSFjQuYhfjGyRhV1FkBEcsqqlFt4CkoyUHfSpEfw50KQz/pp/ULQAII9P1R/6nMdTIuMj7SZteuihLCjXyoc6TEKj4JNhpApjVOjFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708892; c=relaxed/simple;
	bh=3dpD7IwNK9a/TDSQuc2Pv9H05ID8ocV8wp4fyJfIrBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph0YSTogLKw8fD3G9CsoNivkuXO9rZUTZ7vYm/UFMXhZ7b/7zTsm08SFT69X4czFrNzp9zOrpz9rg9jlJ38knyDknBp3Y3EIgtq8ZfiS4LK8niu2Jaz8fF/AysqsRozIt9F+LHlsn0DFs93lRrcDjYdwLvZGHjkQeRV8TV/6Wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpYdArln; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpYdArln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767708889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsKHj46vgfMF4N6TK+1yYkz5WLWyEH5S/5uAYlaLk+Q=;
	b=ZpYdArlnKeb0V8F6nuvkozxHpYKjayWN+ycwVN1YLhhkmUHWL72dNPUi+RApsBuVrVX77u
	BLwWJEjTYztMkEmWFfThpa+tc6jrdgV/1mlN1h8GSbaaDqEfqiicdGtOZA78lX028a0RgD
	F32MgZ6w1Dkb2xOM7LpQXQl9wpxdPU4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-gFH3aHeNNFOofNi2PiwlWg-1; Tue,
 06 Jan 2026 09:14:46 -0500
X-MC-Unique: gFH3aHeNNFOofNi2PiwlWg-1
X-Mimecast-MFC-AGG-ID: gFH3aHeNNFOofNi2PiwlWg_1767708885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F1C918001D1;
	Tue,  6 Jan 2026 14:14:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89A29180049F;
	Tue,  6 Jan 2026 14:14:41 +0000 (UTC)
Date: Tue, 6 Jan 2026 22:14:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: linux-block@vger.kernel.org, csander@purestorage.com,
	jholzman@nvidia.com, omril@nvidia.com
Subject: Re: [PATCH v2 1/2] ublk: make ublk_ctrl_stop_dev return void
Message-ID: <aV0YzBOjurnbip6K@fedora>
References: <20260104084839.30065-1-yoav@nvidia.com>
 <20260104084839.30065-2-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104084839.30065-2-yoav@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Jan 04, 2026 at 10:48:38AM +0200, Yoav Cohen wrote:
> This function always returns 0, so there is no need to return a value.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  drivers/block/ublk_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 837fedb02e0d..2d5602ef05cc 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -3304,10 +3304,9 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
>  			header->data[0], header->addr, header->len);
>  }
>  
> -static int ublk_ctrl_stop_dev(struct ublk_device *ub)
> +static void ublk_ctrl_stop_dev(struct ublk_device *ub)
>  {
>  	ublk_stop_dev(ub);
> -	return 0;
>  }
>  
>  static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
> @@ -3780,7 +3779,8 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
>  		ret = ublk_ctrl_start_dev(ub, header);
>  		break;
>  	case UBLK_CMD_STOP_DEV:
> -		ret = ublk_ctrl_stop_dev(ub);
> +		ublk_ctrl_stop_dev(ub);
> +		ret = 0;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks
Ming

