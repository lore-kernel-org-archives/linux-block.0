Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187314A60C
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441711; cv=none; b=rJOq/lR465p7iB7+QsrY21WAen//pK5jkIep52TFx5XpuunLJU5zapHBCwuMSQuUgx6dMcHudYZqmB/lrrXLQdrWPXUuvXnMSO88F2HC56d8iW2F7ew0h5hBO339m2xJAR9xMWZEaHPRcRSattVFIqbNitPMtt2ubxGBWfPx7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441711; c=relaxed/simple;
	bh=m/x8JSjxfvSZVJgAxyS6DBf94dT65wIOlCP+6UrS2hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaa4outqVXpbuA+yA0qpaWrLYsvAgx97kKBc2z99Pfkd865U3xKEwFEh2bf+iuUgPDC1nfmcJ4KS70pEs3WCN+CMiZ6uaxdsBsOfJA95cj3r2th6oJO0kZgvZ8bv1/8W8zYOR8k9uiyCXh884iE4ljBb8iwuzg/Blip34T4Ynpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xkm7pDpY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xkm7pDpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768441708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO9IDI1bWk7jZ/9Bp5Q6ncsxwFxdhZKejTxIzgAmr7U=;
	b=Xkm7pDpYfdEq5UHKjsMSYq9RJk+DqoEQtks7QzEBUnrhZ5/+Cu1qLSvlnzTR2JRJtE1ykC
	DPqAD40ElmxBq9aTz/3PklabNjPSFTiYFabqo8m4ae7V0ISQPNPx763OQ9mrWuxibNicKv
	TNPlmFxwPjTmDt04M1OX9Ja8p7aDMT0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-QL3CGPYOPFmRjoJQsPdmsg-1; Wed,
 14 Jan 2026 20:48:26 -0500
X-MC-Unique: QL3CGPYOPFmRjoJQsPdmsg-1
X-Mimecast-MFC-AGG-ID: QL3CGPYOPFmRjoJQsPdmsg_1768441706
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4ED91800350;
	Thu, 15 Jan 2026 01:48:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C061A1800285;
	Thu, 15 Jan 2026 01:48:22 +0000 (UTC)
Date: Thu, 15 Jan 2026 09:48:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Seamus Connor <sconnor@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v3] ublk: fix ublksrv pid handling for pid namespaces
Message-ID: <aWhHYQAP6e86EAJr@fedora>
References: <20260112225614.1817055-1-sconnor@purestorage.com>
 <20260114204705.2249961-1-sconnor@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114204705.2249961-1-sconnor@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jan 14, 2026 at 12:47:04PM -0800, Seamus Connor wrote:
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
> Changes since v2:
>  - Moved pid translation into a helper function
> 
>  drivers/block/ublk_drv.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 67d4a867aec4..01747d256ff5 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2852,6 +2852,15 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
>  	return ub;
>  }
>  
> +static pid_t ublk_translate_user_pid(pid_t ublksrv_pid)
> +{
> +	rcu_read_lock();
> +	ublksrv_pid = pid_nr(find_vpid(ublksrv_pid));
> +	rcu_read_unlock();
> +
> +	return ublksrv_pid;
> +}
> +
>  static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  		const struct ublksrv_ctrl_cmd *header)
>  {
> @@ -2920,6 +2929,8 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  	if (wait_for_completion_interruptible(&ub->completion) != 0)
>  		return -EINTR;
>  
> +	ublksrv_pid = ublk_translate_user_pid(ublksrv_pid);
> +
>  	if (ub->ublksrv_tgid != ublksrv_pid)
>  		return -EINVAL;

The above two lines can be moved to the helper which can be renamed as ublk_validate_user_pid(),
otherwise this patch looks good:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

