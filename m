Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D32853F7
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269714; cv=none; b=epDmCgNmr7u0+3z2g4LWhZS2bDRpo0UqUqBVmowjf5Nn36HrfILtIbtIYR6SY2HI2aEPrtqU/WV9rGPXdGCIH2KmFUMHZEoHsAMliIXHnaTXCWx+Jp4HcsCJ1bjzZ5a/SfINzaWxHzklOrU6brLSUYuFS7NNOw98LCQafIiDal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269714; c=relaxed/simple;
	bh=wQiw39IjT8czb/0Aglc82cbfsDbbONQWhopUhKaQOFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcjTzA1qOZ9BA5XZTNqI8WFvqfIBJ18+WRL9ShzdY33uUDasaYJBZbyVbjoE2zskADCVdeTIxUvciu1BGmwPHWwScsS6fUfy1eOND9C6SBomrCytMGzEts5SlLyXYKtcavRw6KSvXMU7gxcRQC1NXqhckZsEs7ll289NsTSAd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhUKoXbm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhUKoXbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768269711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eJDEZm34En/rNpoE91ME/pYGQ09hSljQKYKT81zW1c=;
	b=NhUKoXbmGAOywafGTMSgGxYkLZG9ZaeuMkyphY9pRI2+pzt/xxGthdV9TNzKnnizppiSRm
	+E/bbIHRmnpBCuXSSLPOWoxj4z9gM5okOk3p/11/1CLoTKjG7B32Zu12CaSRDcGUHlzxw4
	cYIawi1up+7yaiYx2VGON9NH/M6Y7kM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-50xiQRGVNOK12-yzxNvLDw-1; Mon,
 12 Jan 2026 21:01:50 -0500
X-MC-Unique: 50xiQRGVNOK12-yzxNvLDw-1
X-Mimecast-MFC-AGG-ID: 50xiQRGVNOK12-yzxNvLDw_1768269709
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 090C419560B7;
	Tue, 13 Jan 2026 02:01:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 017DD19560BA;
	Tue, 13 Jan 2026 02:01:45 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:01:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Seamus Connor <sconnor@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2] ublk: fix ublksrv pid handling for pid namespaces
Message-ID: <aWWnhX7h3m9w2wc6@fedora>
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260112225614.1817055-1-sconnor@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112225614.1817055-1-sconnor@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jan 12, 2026 at 02:56:14PM -0800, Seamus Connor wrote:
> When ublksrv runs inside a pid namespace, START/END_RECOVERY compared
> the stored init-ns tgid against the userspace pid (getpid vnr), so the
> check failed and control ops could not proceed. Compare against the
> caller’s init-ns tgid and store that value, then translate it back to
> the caller’s pid namespace when reporting GET_DEV_INFO so ublk list
> shows a sensible pid.
> 
> Testing: start/recover in a pid namespace; `ublk list` shows
> reasonable pid values in init, child, and sibling namespaces.
> 
> Fixes: d37a224fc119 ("ublk: validate ublk server pid")
> Signed-off-by: Seamus Connor <sconnor@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
> Changes since v1:
>  - Updated start_dev and end_recovery to respect the user-supplied pid
> 
>  drivers/block/ublk_drv.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 79847e0b9e88..4a4673e64668 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2922,6 +2922,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  	if (wait_for_completion_interruptible(&ub->completion) != 0)
>  		return -EINTR;
>  
> +	rcu_read_lock();
> +	ublksrv_pid = pid_nr(find_vpid(ublksrv_pid));
> +	rcu_read_unlock();
> +

`ublksrv_pid` is from userspace, so it may be invalid, then you may have to
check result of find_vpid().

>  	if (ub->ublksrv_tgid != ublksrv_pid)
>  		return -EINVAL;

Please add one helper of ublk_validate_ublksrv_pid() by moving all above
change into the helper, then two code paths can use the single helper.


Otherwise, this patch looks fine.

Thanks, 
Ming

