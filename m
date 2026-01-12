Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CE22AE65
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768196436; cv=none; b=diN1jvVoOjBTSnJjE4lKE/oNnaFm4HFVNGhskbSVUN4PN1L9rh+HtD3E78Brn632/DfSysBwo5YIlOTfPs32wO/vP1fAV9eLE3JakjKi7KWk1cAMQVFHmEp1kETEVhVyE+Bs6/ZYe+usA5UuBjLws4nWUDEGzGbJtb8u0o0hMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768196436; c=relaxed/simple;
	bh=PHw/+BMzpdwZVAyAXhbv02n447R+EAZTmHifaichADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l81WZSzMh9k7PzD84hON7aZ7dtA8Kv9MPBGFuJ2hR2Cwe+D3XA+AHRDadZjGETtBx9QRH1FfGpU7qmKtS58kwXSXw79hJYqrB1mWkH34HjIUPYqumz3Ohh1UjCQqQQQbUwVwsuCPZ6XO2INiZFK+WoS6Fz5J+ePjjqXEhsKLXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jamh9ApZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jamh9ApZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768196434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ch0WtTqfAzSn33u9u9LW5lpCUVUydnD/jEupG2LR628=;
	b=Jamh9ApZN/E5HTvP1bfl4OqLcIfnFVVEbgrThZTvYyU3Ij/1gfq5OxaXY2hT6Qs+LIfYf2
	5fx5Tj5kbKofbYgXB7dZuP0H9H535DYlse2rrDEY3AKdk5t/JSlNRDHwks98LoYqlX8kgM
	sMZLKAxyYzMOqIshZxl1IUF4ZIPRrKA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-OD1ykJJEMQi8oKFGjzBW-Q-1; Mon,
 12 Jan 2026 00:40:30 -0500
X-MC-Unique: OD1ykJJEMQi8oKFGjzBW-Q-1
X-Mimecast-MFC-AGG-ID: OD1ykJJEMQi8oKFGjzBW-Q_1768196429
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DB8218005A7;
	Mon, 12 Jan 2026 05:40:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D2121800665;
	Mon, 12 Jan 2026 05:40:25 +0000 (UTC)
Date: Mon, 12 Jan 2026 13:40:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Seamus Connor <sconnor@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander <csander@purestorage.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: fix ublksrv pid handling for pid namespaces
Message-ID: <aWSJRAEbC3SUuRk-@fedora>
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Jan 10, 2026 at 04:00:15PM -0800, Seamus Connor wrote:
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
>  drivers/block/ublk_drv.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 79847e0b9e88..9ef6432fef7c 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2858,7 +2858,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>   const struct ublksrv_ctrl_cmd *header)
>  {
>   const struct ublk_param_basic *p = &ub->params.basic;
> - int ublksrv_pid = (int)header->data[0];
>   struct queue_limits lim = {
>   .logical_block_size = 1 << p->logical_bs_shift,
>   .physical_block_size = 1 << p->physical_bs_shift,
> @@ -2874,8 +2873,6 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>   struct gendisk *disk;
>   int ret = -EINVAL;
> 
> - if (ublksrv_pid <= 0)
> - return -EINVAL;
>   if (!(ub->params.types & UBLK_PARAM_TYPE_BASIC))
>   return -EINVAL;
> 
> @@ -2922,7 +2919,7 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>   if (wait_for_completion_interruptible(&ub->completion) != 0)
>   return -EINTR;
> 
> - if (ub->ublksrv_tgid != ublksrv_pid)
> + if (ub->ublksrv_tgid != current->tgid)

This way requires that START_DEV command can only be submitted from ublk server
daemon context, which may break implementation sending `START_DEV` command
from remote process context.

Can we fix it in the following way?

+       struct pid *pid = find_vpid(ublksrv_pid);
+
+       if (!pid || pid_nr(pid) != ub->ublksrv_tgid)
+               return -EINVAL;

Also your patch has patch style issue, please check it before posting out
by `./scripts/checkpatch.pl`. Or you may have to use `git send-email` to
send patch file.


Thanks,
Ming

