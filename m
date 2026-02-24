Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18D77F39
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931113; cv=none; b=l3FqCllB7TliQvh8auQXv49hJZqXp70XZWflRZNBdsoU4h8Tu8Qox3IxibZ0GSJ18PDz6oMuoLs46WVVTIMlDKBsoMHwvvloAXKv/2iFKJKJTqZgx/GRchGsVRPnV7ndaYHcsgTCM7jfzsBDNhtx+qQ7HgJiAAGtAeVqTAvaNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931113; c=relaxed/simple;
	bh=CMYLu/FjXNePvswjTTR/FOd8oi5kP5ug7ib3Z9f5GdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoA7gX9oAvsapXheIicrDE1JLSkB85du/O95M4LvcNAkJXvND8YfPCm3bfDIEwTYeHFkdsX4DV6wX4QWEHjUlQnp7GSZI/70LEDwLugqEpqTnO0vndJ8C/C0noIBUfhZvokDsOPnYoiXnrlAY6gU/dxrvbBOFaNMsgxl/UNtO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV8P0D9o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV8P0D9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771931111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/eoOPnI20jSHQXZytKyjy7pUBnJnTQhijpG/jpqSmo=;
	b=gV8P0D9ox2JRVvC8gGgrJYFy5ZAJ7wDfsIQI6xVBh/msSYiXpxMURr6p3fa1MP3qbutNqK
	6yxwwA4sx02wGrxjdmb0yDLNAj38Tri+hR/bLOkk6fZRlGqap2yQebANjCWJgX6qRxMJw0
	j7IFuZIlrOUsQVOUWakAoGr2LhPVDaM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-Arll-6kWMgOf0691QT5ziw-1; Tue,
 24 Feb 2026 06:05:09 -0500
X-MC-Unique: Arll-6kWMgOf0691QT5ziw-1
X-Mimecast-MFC-AGG-ID: Arll-6kWMgOf0691QT5ziw_1771931108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E535B195605C;
	Tue, 24 Feb 2026 11:05:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C000D19560A2;
	Tue, 24 Feb 2026 11:05:04 +0000 (UTC)
Date: Tue, 24 Feb 2026 19:04:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
Message-ID: <aZ2F24VQcnFOySji@fedora>
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-2-alex@zazolabs.com>
 <aZ1wrIbONgxopbIa@fedora>
 <182C75BB-3CBC-4627-9F15-AE8FE675260C@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182C75BB-3CBC-4627-9F15-AE8FE675260C@zazolabs.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Feb 24, 2026 at 12:54:49PM +0200, Alexander Atanasov wrote:
> 
> 
> > On 24 Feb 2026, at 11:34, Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > On Mon, Feb 23, 2026 at 12:15:11PM +0000, Alexander Atanasov wrote:
> >> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> >> as it tries to use it as a switch for the auto partition scan.
> >> To fully disable creation of partitions GENHD_FL_NO_PART must
> >> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
> >> 
> >> Using the new flags rules for partitions become:
> >> - Unprivileged daemons - never scan partitions, they have
> >> GENHD_FL_NO_PART always set - they are devices without partitions.
> >> 
> >> - Trusted daemons - by default have partitions disabled.
> >> Partitions can be enabled via UBLK_F_PARTITIONS flag and
> >> automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN flag.
> >> 
> >> Rework the code to work as described above:
> >> - remove checks in ublk_partition_scan_work and rely on
> >> the caller to schedule the work only if it has to be done.
> >> - set GENHD_FL_NO_PART on unprivileged devices
> >> - set GENHD_FL_NO_PART depending on UBLK_F_PARTITIONS on trusted
> >> devices.
> >> 
> >> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> >> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> >> ---
> >> drivers/block/ublk_drv.c      | 34 +++++++++++++++++++---------------
> >> include/uapi/linux/ublk_cmd.h |  7 +++++--
> >> 2 files changed, 24 insertions(+), 17 deletions(-)
> >> 
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index 3c918db4905c..d0c646eb9435 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -81,7 +81,8 @@
> >> 		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
> >> 		| UBLK_F_SAFE_STOP_DEV \
> >> 		| UBLK_F_BATCH_IO \
> >> -		| UBLK_F_NO_AUTO_PART_SCAN)
> >> +		| UBLK_F_PARTITIONS \
> >> +		| UBLK_F_AUTO_PART_SCAN)
> >> 
> >> #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >> 		| UBLK_F_USER_RECOVERY_REISSUE \
> >> @@ -2361,14 +2362,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
> >> 	if (!disk)
> >> 		return;
> >> 
> >> -	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> >> -					     &disk->state)))
> >> -		goto out;
> >> -
> >> 	mutex_lock(&disk->open_mutex);
> >> 	bdev_disk_changed(disk, false);
> >> 	mutex_unlock(&disk->open_mutex);
> >> -out:
> >> 	ublk_put_disk(disk);
> >> }
> >> 
> >> @@ -4409,9 +4405,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> >> 	 * wait while holding ub->mutex, which can deadlock with other
> >> 	 * operations that need the mutex. Defer partition scan to async
> >> 	 * work.
> >> -	 * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
> >> -	 * permanently.
> >> +	 * For unprivileged daemons, set GENHD_FL_NO_PART to
> >> +	 * disable partitions.
> >> 	 */
> >> +	if (ub->unprivileged_daemons)
> >> +		disk->flags |= GENHD_FL_NO_PART;
> > 
> > The above code block can cover UBLK_F_PARTITIONS too.
> 
> Yes, as Hannes noted. I will merge flag update fragments in one place where possible.
> Only clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state); needs to be after add_disk(disk);
> which will trigger partition scan that we want to do manually when ready.
> 
> 
> >> +
> >> +	/* Disable partition scans */
> >> 	set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> >> 
> >> 	ublk_get_device(ub);
> >> @@ -4429,13 +4429,17 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> >> 
> >> 	set_bit(UB_STATE_USED, &ub->state);
> >> 
> >> -	/* Skip partition scan if disabled by user */
> >> -	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> >> -		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> >> -	} else {
> >> -		/* Schedule async partition scan for trusted daemons */
> >> -		if (!ub->unprivileged_daemons)
> >> -			schedule_work(&ub->partition_scan_work);
> >> +	if (!ub->unprivileged_daemons) {
> >> +		if (!(ub->dev_info.flags & UBLK_F_PARTITIONS)) {
> >> +			/* disable partitions on trusted device */
> >> +			disk->flags |= GENHD_FL_NO_PART;
> >> +		} else {
> >> +			/* Enable partition scan on device */
> >> +			clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> >> +			/* Schedule auto partition scan if requested */
> >> +			if (ub->dev_info.flags & UBLK_F_AUTO_PART_SCAN)
> >> +				schedule_work(&ub->partition_scan_work);
> >> +		}
> >> 	}
> >> 
> >> out_put_cdev:
> >> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> >> index a88876756805..467ecaa20ac1 100644
> >> --- a/include/uapi/linux/ublk_cmd.h
> >> +++ b/include/uapi/linux/ublk_cmd.h
> >> @@ -367,8 +367,11 @@
> >>  */
> >> #define UBLK_F_SAFE_STOP_DEV	(1ULL << 17)
> >> 
> >> -/* Disable automatic partition scanning when device is started */
> >> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> >> +/* Enable partitions on the device */
> >> +#define UBLK_F_PARTITIONS (1ULL << 18)
> >> +
> >> +/* Perform automatic partition scanning when device is started */
> >> +#define UBLK_F_AUTO_PART_SCAN (1ULL << 19)
> > 
> > I think it isn't necessary to add UBLK_F_AUTO_PART_SCAN, and the default
> > behavior is to scan partitions automatically just like other block device.
> 
> 
> If we want by default to scan there should be  UBLK_F_NO_AUTO_PART_SCAN to disable
> scanning when desired - are you ok with it?

I am fine with either way:

- keep UBLK_F_NO_AUTO_PART_SCAN as it is, which just disallow partition
  scan during add disk; meantime add UBLK_F_NO_PART_SCAN, which disables part
  scan permanently

- remove UBLK_F_NO_AUTO_PART_SCAN, as no one requires it, meantime add
  UBLK_F_NO_PART_SCAN, which disables part scan permanently

But looks Hannes prefers to the latter, which is cleaner from UAPI
viewpoint.


Thanks,
Ming

