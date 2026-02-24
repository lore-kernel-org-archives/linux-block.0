Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B636C590
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925535; cv=none; b=k1k0n59mvND4tbk/x/AqXODS7FKepS5/Ny5ca2eBoByUb7n1FV3ZLGd+ZsZ1iVYcF91+JQtv+R8Lfujl01KHjNh7gthuXMgDb6PBFfT26LzgoakNTAH2Sm+g1TV/BPfiO6QJNQ7CiKHAwdBHeWcjNa/jHLBUA+z1a1Eup9oB7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925535; c=relaxed/simple;
	bh=dx2DqMZocdH3JfxmfK4LI0egNlaiSdCMsrVmaZvTROI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO02RLI3uXSsqjqvbASS+RWHxN7h5Y63J3vKfQFpOSRNK6PZ/U9H4Y+Xh35nq5z1dIz1/w3+1cJLTl5DzYO8a99s/KwKEI2H38kkcqhK1+z+MqwhnvimLrB5vq30Nv8QfOjIcViDyB68FnZ2ZlhZX+vmyXeaW5U6jSZzlPzicCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R33f058z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R33f058z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771925533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZo7J5v2wu5VuImWv7jNTGjlQ02cqos0MvhyKRT3xNg=;
	b=R33f058zvWAYFA11YbXnuDi2oVXypJuG/Jk/wBbiqB7E6CGEVcZSzs5Ss241FiRM2x3hk5
	COp9HqW5DN/3GBRPXJLwa1klut1XzRX/pBF25EisMb/LlTYLSm7PWNWbt2a3UpwaLE4lxQ
	6MyeXfI0wm4XD8yU2xMIhGG8rF1bi/M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-zLkrOi-jO2iulyW4rNiOxQ-1; Tue,
 24 Feb 2026 04:32:07 -0500
X-MC-Unique: zLkrOi-jO2iulyW4rNiOxQ-1
X-Mimecast-MFC-AGG-ID: zLkrOi-jO2iulyW4rNiOxQ_1771925526
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41FD31956088;
	Tue, 24 Feb 2026 09:32:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90AB31800465;
	Tue, 24 Feb 2026 09:32:02 +0000 (UTC)
Date: Tue, 24 Feb 2026 17:31:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Alexander Atanasov <alex@zazolabs.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
Message-ID: <aZ1wDStqgU5vjyFR@fedora>
References: <20260223121515.3296983-1-alex@zazolabs.com>
 <20260223121515.3296983-2-alex@zazolabs.com>
 <CADUfDZp-jX98mfERO0OUoMePfws5yRtvfmLfzD2tzfi+HDPyLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp-jX98mfERO0OUoMePfws5yRtvfmLfzD2tzfi+HDPyLQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 23, 2026 at 07:59:54AM -0800, Caleb Sander Mateos wrote:
> On Mon, Feb 23, 2026 at 4:17 AM Alexander Atanasov <alex@zazolabs.com> wrote:
> >
> > Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> > as it tries to use it as a switch for the auto partition scan.
> > To fully disable creation of partitions GENHD_FL_NO_PART must
> > be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
> >
> > Using the new flags rules for partitions become:
> >  - Unprivileged daemons - never scan partitions, they have
> > GENHD_FL_NO_PART always set - they are devices without partitions.
> >
> >  - Trusted daemons - by default have partitions disabled.
> > Partitions can be enabled via UBLK_F_PARTITIONS flag and
> > automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN flag.
> >
> > Rework the code to work as described above:
> > - remove checks in ublk_partition_scan_work and rely on
> > the caller to schedule the work only if it has to be done.
> > - set GENHD_FL_NO_PART on unprivileged devices
> > - set GENHD_FL_NO_PART depending on UBLK_F_PARTITIONS on trusted
> > devices.
> >
> > Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> > Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> > ---
> >  drivers/block/ublk_drv.c      | 34 +++++++++++++++++++---------------
> >  include/uapi/linux/ublk_cmd.h |  7 +++++--
> >  2 files changed, 24 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 3c918db4905c..d0c646eb9435 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -81,7 +81,8 @@
> >                 | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
> >                 | UBLK_F_SAFE_STOP_DEV \
> >                 | UBLK_F_BATCH_IO \
> > -               | UBLK_F_NO_AUTO_PART_SCAN)
> > +               | UBLK_F_PARTITIONS \
> > +               | UBLK_F_AUTO_PART_SCAN)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >                 | UBLK_F_USER_RECOVERY_REISSUE \
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
> > @@ -4409,9 +4405,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> >          * wait while holding ub->mutex, which can deadlock with other
> >          * operations that need the mutex. Defer partition scan to async
> >          * work.
> > -        * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
> > -        * permanently.
> > +        * For unprivileged daemons, set GENHD_FL_NO_PART to
> > +        * disable partitions.
> >          */
> > +       if (ub->unprivileged_daemons)
> > +               disk->flags |= GENHD_FL_NO_PART;
> > +
> > +       /* Disable partition scans */
> >         set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> >
> >         ublk_get_device(ub);
> > @@ -4429,13 +4429,17 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
> >
> >         set_bit(UB_STATE_USED, &ub->state);
> >
> > -       /* Skip partition scan if disabled by user */
> > -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> > -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > -       } else {
> > -               /* Schedule async partition scan for trusted daemons */
> > -               if (!ub->unprivileged_daemons)
> > -                       schedule_work(&ub->partition_scan_work);
> > +       if (!ub->unprivileged_daemons) {
> > +               if (!(ub->dev_info.flags & UBLK_F_PARTITIONS)) {
> > +                       /* disable partitions on trusted device */
> > +                       disk->flags |= GENHD_FL_NO_PART;
> > +               } else {
> > +                       /* Enable partition scan on device */
> > +                       clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > +                       /* Schedule auto partition scan if requested */
> > +                       if (ub->dev_info.flags & UBLK_F_AUTO_PART_SCAN)
> > +                               schedule_work(&ub->partition_scan_work);
> > +               }
> >         }
> >
> >  out_put_cdev:
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index a88876756805..467ecaa20ac1 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -367,8 +367,11 @@
> >   */
> >  #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
> >
> > -/* Disable automatic partition scanning when device is started */
> > -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> > +/* Enable partitions on the device */
> > +#define UBLK_F_PARTITIONS (1ULL << 18)
> 
> This is not backwards compatible. Existing ublk servers expect their
> devices to support partitioning. If you want to introduce a feature
> flag to control this, it needs to be opt-out rather than opt-in.
> UBLK_F_AUTO_PART_SCAN probably also needs to remain as
> UBLK_F_NO_AUTO_PART_SCAN.

UBLK_F_AUTO_PART_SCAN is just merged in 7.0-rc, which isn't released yet,
so it is fine to change it before 7.0 formal release, IMO.


Thanks,
Ming

