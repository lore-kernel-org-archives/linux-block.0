Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B13EBF31
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902255; cv=none; b=iaTdLuY3zxObtEMWn8HyM5GteZVELeQW/TgJldCLR26ZIrU+yNbqcGSkfCHE3T4cnFbpjWyHc9QWjijez2u2iGv6kgOyeMI2NYd5h1AgIO7aRMZl6ntnkhkH5yfod7HOwp6qKPpGogHF/FrpMQebV0YzLV9HYI3FEmrXe744zGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902255; c=relaxed/simple;
	bh=wxaWSZnS8qbaK3Qa248qNlYIkw2rmFXSElf0GSybOH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3M27uaxcNcvNGelLbbL2iDPdNvedgCpbSbECLt1+KETexcc5pq8isozMK602jjVWPCbYnxb1GfEKBLbFxJ6Rn8MZeKwmXYao9WuXx4aaOmLFIJt1vHPoPEfj/KYVZl2sgEC7PQgT7Wu2I3gdNYOUO0BLiONtJm3l+g7n5o+8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qf0D8kcP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qf0D8kcP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770902253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6if2Gxkboy4r6oj6hdqWwzymrdqK1FC6PTJxJ0mC2Z8=;
	b=Qf0D8kcP9sLxbhvgkXO0uj1j8l4zb9oWBZ3MjURaJ0+j1jVYEudmju3Y7dbnbZ4Th2j0UO
	IN3OYbov/jfpcV96fzQiJhJMwerocDXSv2fXYIpjcBFwSYEKWwmmWH3CvPUReoI92ES3mf
	ONTAjkNyhsdPrxJ4+de3rE0SgVjc1WY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-_1Gz70pHPZqc59HTkq341g-1; Thu,
 12 Feb 2026 08:17:30 -0500
X-MC-Unique: _1Gz70pHPZqc59HTkq341g-1
X-Mimecast-MFC-AGG-ID: _1Gz70pHPZqc59HTkq341g_1770902249
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBE831955D8D;
	Thu, 12 Feb 2026 13:17:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE9F319560B9;
	Thu, 12 Feb 2026 13:17:25 +0000 (UTC)
Date: Thu, 12 Feb 2026 21:17:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: ublk invert part scan bit logic
Message-ID: <aY3S32Qotb59tAik@fedora>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <9e656591-a57c-474c-b3dd-8ee1f75ca9a7@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e656591-a57c-474c-b3dd-8ee1f75ca9a7@zazolabs.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Feb 12, 2026 at 03:08:17PM +0200, Alexander Atanasov wrote:
> Hi,
> 
> On 12.02.26 13:05, Jens Axboe wrote:
> > Hi,
> > 
> > For ublk, there's this logic in in ublk_ctrl_start_dev():
> > 
> > /* Skip partition scan if disabled by user */
> > if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> > 	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > } else {
> > 	/* Schedule async partition scan for trusted daemons */
> > 	if (!ub->unprivileged_daemons)
> > 		schedule_work(&ub->partition_scan_work);
> > }
> > 
> > where the
> > 
> > clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > 
> > seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
> > UBLK_F_NO_AUTO_PART_SCAN is set? Added in:
> > 
> > 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> > 
> 
> There is more to this :
> a comment few lines above states that:
> 	 * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
> 	 * permanently.
> 	 */
> 	set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> 
> next in ublk_partition_scan_work it is
> if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> it is not used anywhere else but at least for debug it is good to stay
> and align with the comment.

Actually ioctl(BLKRRPART) does require CAP_SYS_ADMIN, so either we
modify above comment or not clear GD_SUPPRESS_PART_SCAN for
ub->unprivileged_daemons.

> 
> So if i've untwisted it right:
> do not clear the bit before scanning and invert logic to clear the
> bit only(enable) scan only if UBLK_F_NO_AUTO_PART_SCAN is not requested
> by the user for a trusted daemon.
> 
> Ming - what do you think?
> 
> -- 
> have fun,
> alex
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3c918db4905c..0d6d840b4f21 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2361,7 +2361,7 @@ static void ublk_partition_scan_work(struct
> work_struct *work)
>         if (!disk)
>                 return;
> 
> -       if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> +       if (WARN_ON_ONCE(test_bit(GD_SUPPRESS_PART_SCAN,
>                                              &disk->state)))

This way will fail future ioctl(BLKRRPART).

>                 goto out;
> 
> @@ -4429,13 +4429,13 @@ static int ublk_ctrl_start_dev(struct ublk_device
> *ub,
> 
>         set_bit(UB_STATE_USED, &ub->state);
> 
> -       /* Skip partition scan if disabled by user */
> -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> +       /* Skip partition scan if disabled by user only for trusted daemons
> */
> +       if (!ub->unprivileged_daemons &&
> +           !(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN)) {

The above change looks fine.

> +               /* Enable partition scanning */
>                 clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> -       } else {
>                 /* Schedule async partition scan for trusted daemons */
> -               if (!ub->unprivileged_daemons)
> -                       schedule_work(&ub->partition_scan_work);
> +               schedule_work(&ub->partition_scan_work);

We shouldn't or can't schedule the part scan work in case of
ub->unprivileged_daemons.

Thanks,
Ming

