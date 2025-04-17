Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F57E1
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848145; cv=none; b=o4pBwCCiSLW/+qEHr14KM+SzISJgIsty/wnPoeXNuTd2UnApHs/S9b62DnuX8YurydrtdtR6Jbn5OFOW9PqxYkqY0GF14M7HsZQa04n0HB5UlaNGb6eg1KSuUrN27jF5dO3Zm4s3Id0H3rwqd7h90Dh7Aw5foLm3PCfl+qSiyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848145; c=relaxed/simple;
	bh=leTkvuBL2+CH2NIWIXHwfaqIV4DIQSCQR9GO9YuXAAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORxPjNfgOsWNIMJSBlG5O29pB4W+n74MCDEqaOCIps4dgFAHiRplUsKxziocr4DkE4ItQZ8uJLVRTKtLO34PWLBeC+QHoPw527+bjSCy/6M+7VOwDB8+Y5Ax7ABGu1deTlW0/ObJBnK66rS9cxIdVnM6GonncmgCjvb06FHEblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLBanZs7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLBanZs7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744848143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7C8pt7xjKTm03hAbrHAkAPdxLOrqJf60jzN2DFbg1R0=;
	b=OLBanZs7rZCPQrNOamkTk6KuSV5mdEaMLYMSnV2WAmQTz4Xg3+ymtWsezTOTpDcXluj2sE
	tCkfoGBOUFO2bvRWyipDJjhkWXv3VIa8zRxIefDuZWrF7Nn/uWkrLNHaqGVKdnUV6HxZhO
	a+LRtOzRTU5EdIMRVM3i2Ng19gUdwx8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-iGQLUlroOPGrFGNe8uC6cw-1; Wed,
 16 Apr 2025 20:02:19 -0400
X-MC-Unique: iGQLUlroOPGrFGNe8uC6cw-1
X-Mimecast-MFC-AGG-ID: iGQLUlroOPGrFGNe8uC6cw_1744848138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DABE195608C;
	Thu, 17 Apr 2025 00:02:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.82])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67451180045C;
	Thu, 17 Apr 2025 00:02:15 +0000 (UTC)
Date: Thu, 17 Apr 2025 08:02:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove unnecessary ubq checks
Message-ID: <aABFAg563W1g_4QS@fedora>
References: <20250416170154.3621609-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416170154.3621609-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Apr 16, 2025 at 11:01:53AM -0600, Caleb Sander Mateos wrote:
> ublk_init_queues() ensures that all nr_hw_queues queues are initialized,
> with each ublk_queue's q_id set to its index. And ublk_init_queues() is
> called before ublk_add_chdev(), which creates the cdev. Is is therefore
> impossible for the !ubq || ub_cmd->q_id != ubq->q_id condition to hit in
> __ublk_ch_uring_cmd(). Remove it to avoids some branches in the I/O path.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cdb1543fa4a9..bc86231f5e27 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1947,13 +1947,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  
>  	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
>  		goto out;
>  
>  	ubq = ublk_get_queue(ub, ub_cmd->q_id);
> -	if (!ubq || ub_cmd->q_id != ubq->q_id)
> -		goto out;
> -

Looks correct, ubq->q_id is always same with the index passed to
ublk_get_queue().

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

