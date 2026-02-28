Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403017A2E8
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772244408; cv=none; b=fE50NcLb/P4OC4cU0vIT0/ciZRbFTemvTRnfmFEgs7ouE046IbQ8nuW9ar/i2ykmFwb8KSFkwLnHjRqz5LgCwXgLg2WGUvMHqiQFlTFiAzAGPEZ99I0vzXwItoK6g5OxIX6wNjol3Qflj22T/cRYHIv82fLqFCzPaQIWrJ1gbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772244408; c=relaxed/simple;
	bh=PfBrXXJtTvpk6kT9ffiwWNzNJxv0b5d8SLpuyJEUZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8gHQ8W61EMwGX6J4aCY010faAiQMWOM+4TriHvn1vczN7FzAyMgxlTi5t52b5Hy/MwW4aJgi0ZhSmwm7dnMtPkp6r7auWWr+JIg3S5he4Ox02Soq2+moSQZmx3ApL3M7cP/idw7siO7lighJzoHWpTL61mfp4YvLEpc1UQkbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPIuSrn0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPIuSrn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772244405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=335014J6gxQcJYvf6ravSWYnWA1xsouaJ2hhJcn7rxs=;
	b=XPIuSrn0Dfp8DFWtq5+HLK+JV6DVvT0KIEkjVfXpTo3V/erE/f5ciGqgjAOQcQNyJ4nTr/
	FhtfX0yF07/D3dNFpgTwr6EsbDjGWQgAMbaKbLHBI7eWtllcasg+XeiXsDHyJ73o6YRiEK
	ZDJ94Xi38tUFoDSHSUk9lKQiO4e82gE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-2UDhjxnTOgKuSl1kXtVpqg-1; Fri,
 27 Feb 2026 21:06:44 -0500
X-MC-Unique: 2UDhjxnTOgKuSl1kXtVpqg-1
X-Mimecast-MFC-AGG-ID: 2UDhjxnTOgKuSl1kXtVpqg_1772244403
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15C2C1800464;
	Sat, 28 Feb 2026 02:06:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DB621800352;
	Sat, 28 Feb 2026 02:06:37 +0000 (UTC)
Date: Sat, 28 Feb 2026 10:06:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Alexander Atanasov <alex@zazolabs.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ublk: cleanup partition flags handling and
 introduce UBLK_F_NO_PARTITONS
Message-ID: <aaJNp6Ga-EdscEny@fedora>
References: <20260227145756.3877069-1-alex@zazolabs.com>
 <20260227145756.3877069-2-alex@zazolabs.com>
 <CADUfDZqo2KWB9aDjAgxwKQkJLK-TU1GuWtqcdLCnRpLrfMmHKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqo2KWB9aDjAgxwKQkJLK-TU1GuWtqcdLCnRpLrfMmHKg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Feb 27, 2026 at 10:29:56AM -0800, Caleb Sander Mateos wrote:
> On Fri, Feb 27, 2026 at 7:07 AM Alexander Atanasov <alex@zazolabs.com> wrote:
> >
> > Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> > as it tries to use it as a switch for the auto partition scan.
> > To fully disable creation of partitions GENHD_FL_NO_PART must
> > be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
> >
> > Rules for partitions become:
> >  - Unprivileged daemons - never scan partitions, they have
> > GENHD_FL_NO_PART always set - they are devices without partitions.
> >
> >  - Trusted daemons - by default have partitions enabled,
> > automatic initial scan can be disabled via UBLK_F_NO_AUTO_PART_SCAN flag.
> > Partitions can be disabled via UBLK_F_NO_PARTITIONS flag.
> >
> > Rework the code to work as described above:
> > - remove checks in ublk_partition_scan_work and rely on
> > the caller to schedule the work only if it has to be done.
> > - set GENHD_FL_NO_PART on unprivileged devices
> > - set GENHD_FL_NO_PART depending on UBLK_F_NO_PARTITIONS on trusted
> > devices.
> >
> > Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> > Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> > ---
> >  drivers/block/ublk_drv.c      | 23 +++++++++--------------
> >  include/uapi/linux/ublk_cmd.h |  3 +++
> >  2 files changed, 12 insertions(+), 14 deletions(-)
> >
> > -v1->v2:
> >   - remove code duplication and extra flag settings
> >   - switch from out-in to out-out to preserve backwards compatibility
> >
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 3c918db4905c..36da63ba2a57 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -81,6 +81,7 @@
> >                 | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
> >                 | UBLK_F_SAFE_STOP_DEV \
> >                 | UBLK_F_BATCH_IO \
> > +               | UBLK_F_NO_PARTITIONS \
> >                 | UBLK_F_NO_AUTO_PART_SCAN)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > @@ -2361,14 +2362,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
> >         if (!disk)
> >                 return;
> >
> > -       if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> > -                                            &disk->state)))
> > -               goto out;
> > -
> >         mutex_lock(&disk->open_mutex);
> >         bdev_disk_changed(disk, false);
> >         mutex_unlock(&disk->open_mutex);
> > -out:
> >         ublk_put_disk(disk);
> >  }
> >
> > @@ -4409,10 +4405,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> >          * wait while holding ub->mutex, which can deadlock with other
> >          * operations that need the mutex. Defer partition scan to async
> >          * work.
> > -        * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
> > -        * permanently.
> > +        * For unprivileged daemons, set GENHD_FL_NO_PART to
> > +        * disable partitions.
> >          */
> > -       set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > +       disk->flags |= GENHD_FL_NO_PART;
> >
> >         ublk_get_device(ub);
> >         ub->dev_info.state = UBLK_S_DEV_LIVE;
> > @@ -4429,12 +4425,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> >
> >         set_bit(UB_STATE_USED, &ub->state);
> >
> > -       /* Skip partition scan if disabled by user */
> > -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> > -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > -       } else {
> > -               /* Schedule async partition scan for trusted daemons */
> > -               if (!ub->unprivileged_daemons)
> > +       if (!ub->unprivileged_daemons && !(ub->dev_info.flags & UBLK_F_NO_PARTITIONS)) {
> > +               /* Enable partitions on device */
> > +               disk->flags &= ~GENHD_FL_NO_PART;
> 
> Is it safe to modify disk->flags after the disk has been added? This looks racy.

Yeah, GENHD_FL_NO_PART should cover unprivileged_daemons & UBLK_F_NO_PARTITIONS only
in static way.

Normal partition scanning still need GD_SUPPRESS_PART_SCAN.


Thanks,
Ming

