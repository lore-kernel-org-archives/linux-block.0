Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945622F12AE
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 03:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771559934; cv=none; b=SK2IvREj3LRlJ6UXAXDljiNe4mwYUmcpdwLcjMyiA9UAMY8dc4gWfG1f+kaXBxDcudB8kxe+IfA/qUc2cAzLWaAnuLMULhV6KldRKlRw3AqorBjPn5CI6HMSm7LvYzMzNMMw6BYAdnjRtc3gTmTmRMXHRhch7ZcIqREDyRXojpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771559934; c=relaxed/simple;
	bh=RFPaj2sMXj0/UPf+cRwATGGq5SpwCVyXqk9EUpgXs40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6OEFyiS/eCFFw9JBtQg9yK3o1+u0eJXLoq8Rk3pUog/YNOwR+8CMTiFfXpC03plcjB+vSi+fq02yesCRtVcTwWMVkjgt0S6usKVG/tj/l9mIoxFJkiT8+K4ojIgQsbX83Y+xNUyqauBv9MAQC1ifWKHl6lz4nWc0zmEHtzTWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPycxwOl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPycxwOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771559931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XoeZpuGAODXkhmnhOxTSdlpoNCpJ49cCaJHNZjsA+i8=;
	b=hPycxwOlG7cDObdvphdFe/ZQr4XuQ19/54IIUXBhpYcsaJEKtr/fWd8P527qEhTyo66sxK
	1uvohCpxsaJulvHlChZrmDj8/lWzn/tB+1eARFmnnHuSUJmYWrCW5P0ZTSu/9y/pR0fL5E
	iidjFerRpSE14yXyUZop5aoDqFEwQlw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-IOH0HWCANc6aFH6LccK7Og-1; Thu,
 19 Feb 2026 22:58:48 -0500
X-MC-Unique: IOH0HWCANc6aFH6LccK7Og-1
X-Mimecast-MFC-AGG-ID: IOH0HWCANc6aFH6LccK7Og_1771559927
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA84D1800464;
	Fri, 20 Feb 2026 03:58:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A46ED3000C26;
	Fri, 20 Feb 2026 03:58:42 +0000 (UTC)
Date: Fri, 20 Feb 2026 11:58:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Yoav Cohen <yoav@nvidia.com>
Subject: Re: [PATCH] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
Message-ID: <aZfb7aQTMRbRaRgb@fedora>
References: <20260212152553.1737373-1-alex@zazolabs.com>
 <aY6fAlXmzQZCKwmM@fedora>
 <efe851c6-cb40-4e6f-a382-047b33753ee1@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe851c6-cb40-4e6f-a382-047b33753ee1@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Alexander,

On Fri, Feb 13, 2026 at 01:05:40PM +0200, Alexander Atanasov wrote:
> On 13.02.26 5:48, Ming Lei wrote:
> > On Thu, Feb 12, 2026 at 03:25:52PM +0000, Alexander Atanasov wrote:
> > > Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> > > as it tries to use it as a switch for the auto partition scan.
> > > When UBLK_F_NO_AUTO_PART_SCAN is not passed a proper
> > > auto partition scanning is not done because the first
> > > call to ublk_partition_scan_work will clear the bit
> > > GD_SUPPRESS_PART_SCAN but not actually load the partitions.
> > > 
> > > How it should work:
> > > Unprivileged daemons - never scan partitions, they have
> > > GD_SUPPRESS_PART_SCAN always set - they are marked as devices
> > > without partitions. While ioctl(BLKRRPART) does require
> > > CAP_SYS_ADMIN, block layer have its own a check in
> > > disk_has_partscan(...) if partitions are supported.
> > > 
> > > Trusted daemons - auto scan partitions by default
> > > and they do not have the bit set, so they do have partitions.
> > > 
> > > For trusted daemons auto partitions scan is performed but it can
> > > be skipped if user have set UBLK_F_NO_AUTO_PART_SCAN flag.
> > > 
> > > Rework the code to work as described above:
> > > - remove checks in ublk_partition_scan_work and rely on
> > > the caller to schedule the work only if it has to be done.
> > > - keep GD_SUPPRESS_PART_SCAN always set on unprivileged
> > > - keep GD_SUPPRESS_PART_SCAN always clear on trusted
> > > - Properly handle user request to skip auto partitioning scanning
> > > 
> > > Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> > > Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> > > ---
> > >   drivers/block/ublk_drv.c | 14 ++++----------
> > >   1 file changed, 4 insertions(+), 10 deletions(-)
> > > 
> > > Cc: Yoav Cohen <yoav@nvidia.com>
> > > 
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 3c918db4905c..e662c6e8e722 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -2361,14 +2361,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
> > >   	if (!disk)
> > >   		return;
> > > -	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> > > -					     &disk->state)))
> > > -		goto out;
> > > -
> > 
> > It is wrong to remove clearing GD_SUPPRESS_PART_SCAN, otherwise ioctl(BLKRRPART)
> > can't succeed.
> 
> If you agree with how should it work in the message then it is not a
> problems. GD_SUPPRESS_PART_SCAN is set only on unprivileged - no
> partitions on them. Trusted have it always clear - they
> schedule the scan and get their partitions automatically.
> If user passes the UBLK_F_NO_AUTO_PART_SCAN, then the scan is not scheduled
> and it is up to the user to reread partitions.
> This ublk_partition_scan_work is used inside ublk_drv only,
> ioctl uses different code path. Double checked and the only
> way to reach it is thru ublk_ctrl_add_dev and from ublk_ctrl_uring_cmd.
> 
> 
> > 
> > >   	mutex_lock(&disk->open_mutex);
> > >   	bdev_disk_changed(disk, false);
> > >   	mutex_unlock(&disk->open_mutex);
> > > -out:
> > >   	ublk_put_disk(disk);
> > >   }
> > > @@ -4429,12 +4424,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> > >   	set_bit(UB_STATE_USED, &ub->state);
> > > -	/* Skip partition scan if disabled by user */
> > > -	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> > > +	if (!ub->unprivileged_daemons) {
> > > +		/* Enable partition scanning for trusted daemons */
> > >   		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > > -	} else {
> > > -		/* Schedule async partition scan for trusted daemons */
> > > -		if (!ub->unprivileged_daemons)
> > > +		/* Skip auto partition scan if requested by user */
> > > +		if (!(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
> > >   			schedule_work(&ub->partition_scan_work);
> > 
> > We may switch to disallow partition scan permanently for UBLK_F_NO_AUTO_PART_SCAN
> > per discussion in the following thread:
> > 
> > https://lore.kernel.org/linux-block/0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk/
> > 
> > So the change may can be simplified as below, meantime
> > selftests/ublk/test_part_01.sh need to be updated.
> 
> Ok, tests and docs are next as Jens requested.
> 
> > 
> > Alexander, please let us know if you'd like work this way?
> 
> https://lore.kernel.org/linux-block/c95b3de4-f4f8-4b35-a3e4-a83da98ced0b@zazolabs.com/T/#mbb410ceb3f4c6f23e6c566911dfc833365ce9cdc
> 
> in short - having partitions and auto scan are two different features, why
> merge them?

Yoav's original requirement has been addressed by scheduling scan work in
wq already.

So I think it makes more sense to switch to UBLK_F_NO_PART_SCAN.

> 
> If we want to cover all cases i thing we should go like this:
> 
> /* Enable partitions support on device */
> #define UBLK_F_PARTITIONS (1ULL << 18)
> 
> /* Do not perform automatic partition scanning when device is added */
> #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 19)
> 
> Added value is to have partitions enabled/disabled explicitly for trusted
> devices. Where by default they will be disabled.
> 
> Also may be change from UBLK_F_NO_AUTO_PART_SCAN to UBLK_F_AUTO_PART_SCAN -
> to make it explicit instead and be like
> the rest of the flags - all are enable flags
> 
> Then these variants become possible:
> - unprivileged without partitions (can we add security checks to allow
> partitions for them too?)
> - trusted with or without partitions (UBLK_F_PARTITIONS bound to
> GD_SUPPRESS_PART_SCAN)
> - If it is a device with partitions then UBLK_F_NO_AUTO_PART_SCAN controls
> if initial auto scan is performed or not.
> 
> Having them separate can allow emulation of removable media where data is
> not available at device creation time but is known when available by
> external event so you can load partitions. Two step device bring up, i.e.
> partition scan at device creation time will block you, but you know when
> data is available from an external event, and then you can load partitions.
> 
> What do you think?
> 
> I'be added CC Yoav since i think he requested that feature in first place. I
> beleive Hannes may have a different use case, so let's get some more input
> on this.

Yoav's original requirement is to not scan partition during ADD_DEV
command for avoiding hang, which is addressed already by scheduling scan work in wq
context.

So I think it is fine to change UBLK_F_NO_AUTO_PART_SCAN into
UBLK_F_NO_PART_SCAN, which can be implemented by GENHD_FL_NO_PART, as you
mentioned.


Thanks,
Ming

