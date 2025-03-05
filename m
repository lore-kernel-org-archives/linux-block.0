Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF163FBA7
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142113; cv=none; b=NaVMaG7QFIY93Mu57fg5i1VEzifXyHY0JUYsXspjA/nZFKMXOFkXQu/6fs/FV6wJ5U8EcHAhU9Iz8dKgMEHzO8Ef6uN91d1cndgfcjWlq/VsnBX05HApyy+I2eixTk2wl4/WjFBfCg5MqbjNQyLo0gPDwt+BRjCBpPvwP0j/EVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142113; c=relaxed/simple;
	bh=oalmuokynTYNy3luwovJpLTXGeZ+vidGa6/5MKBtuso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ7WMijhDEKi719VXtInVpY1D70GK2pr81ZfpdKHKRmqmO24BDGlyyltb2MqpwxmX2Q2gUqJS7D5CZjpxs3t0/WxT7s2Gm8S/ccn0gbf8d/h9ciTmGoZp3La6qLr2GK9tSjNBw0Ea0QELM/7Vx45xVsl0VOoJKERufOcb3RJEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIc1gvjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIc1gvjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741142110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/SM/oneiVr3TeaCLe7mFniK7hBij3Psk7IGebqdTnw=;
	b=ZIc1gvjdEf1bCAvAL0lnd/98cj04o/zp4l/4jOxRcbJRzOen+BhWereNJohYRfj0aT7MoF
	o56ZaZ7p0Z4+txxng0Bt5v7A9YMK0a7HQl5ZvaX1lHe7xtgTh/eRlVrVXuBjaUVCqY5s4g
	FEwtrFqM2uLkmnZK0sR4KlCbbw/pZtE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-g5EIYkWyNROsjJ3xL6FUlA-1; Tue,
 04 Mar 2025 21:35:07 -0500
X-MC-Unique: g5EIYkWyNROsjJ3xL6FUlA-1
X-Mimecast-MFC-AGG-ID: g5EIYkWyNROsjJ3xL6FUlA_1741142106
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3949E1944D38;
	Wed,  5 Mar 2025 02:35:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA851180087C;
	Wed,  5 Mar 2025 02:35:02 +0000 (UTC)
Date: Wed, 5 Mar 2025 10:34:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: set_params: properly check if parameters can be
 applied
Message-ID: <Z8e4UY-niL16yF2N@fedora>
References: <20250304-set_params-v1-1-17b5e0887606@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-set_params-v1-1-17b5e0887606@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 04, 2025 at 02:34:26PM -0700, Uday Shankar wrote:
> The parameters set by the set_params call are only applied to the block
> device in the start_dev call. So if a device has already been started, a
> subsequently issued set_params on that device will not have the desired
> effect, and should return an error. There is an existing check for this
> - set_params fails on devices in the LIVE state. But this check is not
> sufficient to cover the recovery case. In this case, the device will be
> in the QUIESCED or FAIL_IO states, so set_params will succeed. But this
> success is misleading, because the parameters will not be applied, since
> the device has already been started (by a previous ublk server). The bit
> UB_STATE_USED is set on completion of the start_dev; use it to detect
> and fail set_params commands which arrive too late to be applied (after
> start_dev).
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2955900ee713c5d8f3cbc2a69f6f6058348e5253..aa34594c76ad02b1480b9ef4a2bd52a095ca6f3f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2782,9 +2782,12 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
>  	if (ph.len > sizeof(struct ublk_params))
>  		ph.len = sizeof(struct ublk_params);
>  
> -	/* parameters can only be changed when device isn't live */
>  	mutex_lock(&ub->mutex);
> -	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
> +	if (test_bit(UB_STATE_USED, &ub->state)) {
> +		/*
> +		 * Parameters can only be changed when device hasn't
> +		 * been started yet
> +		 */
>  		ret = -EACCES;
>  	} else if (copy_from_user(&ub->params, argp, ph.len)) {
>  		ret = -EFAULT;

Good catch,

Fixes: 0aa73170eba5 ("ublk_drv: add SET_PARAMS/GET_PARAMS control command")
Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

