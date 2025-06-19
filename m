Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE23085D4
	for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300574; cv=none; b=onCqWn/h1x6UVCIG4s9SdYUlPfYSjplCfel90PBFoAej9t5peAbDq6O5dRO5AaGF+nSTLW9cx38/A1pZswRn6++tr1o7dDNTeWfoTTDo26WM1Z1sFyl4tPsShgzfMAQQq7ISio6mjOJSw5JwhN1gH5QyzNb/bw5EiWL0eLRDXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300574; c=relaxed/simple;
	bh=ukYZEz8YDZy79maza/LTrJcr6Ps45sWCaaa01E2gYeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWLhdr2hfOM4hYJXIuIp4iUmITnPOi8fB4i3quLznoShW9A9msvLH9h3qsxn7BNqmTSp/7hoXGqizYNTDWgbFO4lkoRi0BdLmSEEkCbqyNoyZLKG8eH/zQByf2CJM4MbW9LEqSvL7hDraaKb0Bcvr0VdMDL7DWLVRsna4M5xDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O21H20P+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O21H20P+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750300570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o7G3mqsKFkMj5FJwTxPCXJja5MYVMLzp8C2riHjj0NM=;
	b=O21H20P+b0JQ/zEqccmTsIcn4ISTi0+l3iWhKiewhR4SSP9ceLK8j5ulBc7Z9Ic54e7E6/
	oT8i1+HpXNB4CWeFyUrqVBQs9FKdBHQ711eAYcNkqRf7O6MnibONnb/CR+SIADBnauhJ24
	r3UVjvf+zqC2iahPInCPVDr5JF/Ohi4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-d3zV--svM9e-X2AJ5Rnqcw-1; Wed,
 18 Jun 2025 22:36:09 -0400
X-MC-Unique: d3zV--svM9e-X2AJ5Rnqcw-1
X-Mimecast-MFC-AGG-ID: d3zV--svM9e-X2AJ5Rnqcw_1750300568
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACF7D195609F;
	Thu, 19 Jun 2025 02:36:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AC3519560B3;
	Thu, 19 Jun 2025 02:36:05 +0000 (UTC)
Date: Thu, 19 Jun 2025 10:36:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: santizize the arguments from userspace when adding
 a device
Message-ID: <aFN3kNtyG_0xcyUY@fedora>
References: <20250619021031.181340-1-ronniesahlberg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619021031.181340-1-ronniesahlberg@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jun 19, 2025 at 12:10:31PM +1000, Ronnie Sahlberg wrote:
> From: Ronnie Sahlberg <rsahlberg@whamcloud.com>
> 
> Sanity check the values for queue depth and number of queues
> we get from userspace when adding a device.
> 
> Signed-off-by: Ronnie Sahlberg <rsahlberg@whamcloud.com>
> ---
>  drivers/block/ublk_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 374e4efa8759..febdb5609e95 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2336,6 +2336,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  	if (copy_from_user(&info, argp, sizeof(info)))
>  		return -EFAULT;
>  
> +	if (info.queue_depth > UBLK_MAX_QUEUE_DEPTH || info.nr_hw_queues > UBLK_MAX_NR_QUEUES)
> +		return -EINVAL;
> +
>  	if (capable(CAP_SYS_ADMIN))
>  		info.flags &= ~UBLK_F_UNPRIVILEGED_DEV;
>  	else if (!(info.flags & UBLK_F_UNPRIVILEGED_DEV))

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Fixes: 62fe99cef94a ("ublk: add read()/write() support for ublk char device")


Thanks,
Ming

