Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE6C8CE
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770954513; cv=none; b=TX33EXk9YLE6dFw7L2tsK98O/sKrzeGO5DtKpXOxAWVK0G+KNTJdFJz0Raq49iiKWtfZ+jvsNJdyHYao8A+XxZ3B1act2LyCXP18Fum22m5wwUN9baRth1ML1GKNxzISI8btVAIYc6B28d2YJkm/hvT3lwAvJOAnSNEZr1yiPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770954513; c=relaxed/simple;
	bh=EZUVCeqAOUrkbaJ0dr6mKEyhXOnREzZaJGhzCikTbrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBJrG9Jueiyibmm9zfb2GnAE95Lw2ihR51pxWSHFJE8bthw5UsD8JS1KBu6I1cx766ftJXHIWBPscKZI8dZXtOkRQU5si3Dsw8sSl5JSgKzFopIFrZXCZq4cNB9KBoWGpC0eO/ds9NaLUf+AnPYDpPTZDPI4ySQ4ufZw12o5yQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZBlf28c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZBlf28c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770954511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mlfnPtmSjITWDGfkUvX1+3XEkBteJKupdUjPDWC1Clw=;
	b=CZBlf28cKFcZ405euTDK5kly3t+nGkb6jZzg0GnK8cNFDiXSi2fvIKisRZgYokCxedTKx4
	RbGC7QIbtOgockIWmd+2brcwtIYQ1FowX2j8uL0cFCC+qvA9EY4cFjEoXrjG+g8I73uOZb
	GQhQ1Bi6Sa1NBAbfx9nNPtUCz1dO1+M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-tR3cYMWENUybzyPf0zIqCQ-1; Thu,
 12 Feb 2026 22:48:28 -0500
X-MC-Unique: tR3cYMWENUybzyPf0zIqCQ-1
X-Mimecast-MFC-AGG-ID: tR3cYMWENUybzyPf0zIqCQ_1770954507
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F58F195605A;
	Fri, 13 Feb 2026 03:48:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B84F1800464;
	Fri, 13 Feb 2026 03:48:23 +0000 (UTC)
Date: Fri, 13 Feb 2026 11:48:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yoav Cohen <yoav@nvidia.com>
Subject: Re: [PATCH] ublk: cleanup flag handling and fix
 UBLK_F_NO_AUTO_PART_SCAN
Message-ID: <aY6fAlXmzQZCKwmM@fedora>
References: <20260212152553.1737373-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212152553.1737373-1-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 12, 2026 at 03:25:52PM +0000, Alexander Atanasov wrote:
> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> as it tries to use it as a switch for the auto partition scan.
> When UBLK_F_NO_AUTO_PART_SCAN is not passed a proper
> auto partition scanning is not done because the first
> call to ublk_partition_scan_work will clear the bit
> GD_SUPPRESS_PART_SCAN but not actually load the partitions.
> 
> How it should work:
> Unprivileged daemons - never scan partitions, they have
> GD_SUPPRESS_PART_SCAN always set - they are marked as devices
> without partitions. While ioctl(BLKRRPART) does require
> CAP_SYS_ADMIN, block layer have its own a check in
> disk_has_partscan(...) if partitions are supported.
> 
> Trusted daemons - auto scan partitions by default
> and they do not have the bit set, so they do have partitions.
> 
> For trusted daemons auto partitions scan is performed but it can
> be skipped if user have set UBLK_F_NO_AUTO_PART_SCAN flag.
> 
> Rework the code to work as described above:
> - remove checks in ublk_partition_scan_work and rely on
> the caller to schedule the work only if it has to be done.
> - keep GD_SUPPRESS_PART_SCAN always set on unprivileged
> - keep GD_SUPPRESS_PART_SCAN always clear on trusted
> - Properly handle user request to skip auto partitioning scanning
> 
> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  drivers/block/ublk_drv.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> Cc: Yoav Cohen <yoav@nvidia.com>
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3c918db4905c..e662c6e8e722 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2361,14 +2361,9 @@ static void ublk_partition_scan_work(struct work_struct *work)
>  	if (!disk)
>  		return;
>  
> -	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> -					     &disk->state)))
> -		goto out;
> -

It is wrong to remove clearing GD_SUPPRESS_PART_SCAN, otherwise ioctl(BLKRRPART)
can't succeed.

>  	mutex_lock(&disk->open_mutex);
>  	bdev_disk_changed(disk, false);
>  	mutex_unlock(&disk->open_mutex);
> -out:
>  	ublk_put_disk(disk);
>  }
>  
> @@ -4429,12 +4424,11 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  
>  	set_bit(UB_STATE_USED, &ub->state);
>  
> -	/* Skip partition scan if disabled by user */
> -	if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> +	if (!ub->unprivileged_daemons) {
> +		/* Enable partition scanning for trusted daemons */
>  		clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> -	} else {
> -		/* Schedule async partition scan for trusted daemons */
> -		if (!ub->unprivileged_daemons)
> +		/* Skip auto partition scan if requested by user */
> +		if (!(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
>  			schedule_work(&ub->partition_scan_work);

We may switch to disallow partition scan permanently for UBLK_F_NO_AUTO_PART_SCAN
per discussion in the following thread:

https://lore.kernel.org/linux-block/0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk/

So the change may can be simplified as below, meantime
selftests/ublk/test_part_01.sh need to be updated.

Alexander, please let us know if you'd like work this way?

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a88876756805..d6f479fff75b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -367,8 +367,8 @@
  */
 #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)

-/* Disable automatic partition scanning when device is started */
-#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
+/* Disable partition scanning */
+#define UBLK_F_NO_PART_SCAN    (1ULL << 18)

 /* device state */
 #define UBLK_S_DEV_DEAD        0
[root@ktest-40 linux]# git diff
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c13cda58a7c6..f1a104222fb1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -81,7 +81,7 @@
                | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
                | UBLK_F_SAFE_STOP_DEV \
                | UBLK_F_BATCH_IO \
-               | UBLK_F_NO_AUTO_PART_SCAN)
+               | UBLK_F_NO_PART_SCAN)

 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
                | UBLK_F_USER_RECOVERY_REISSUE \
@@ -4438,14 +4438,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,

        set_bit(UB_STATE_USED, &ub->state);

-       /* Skip partition scan if disabled by user */
-       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
-               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
-       } else {
-               /* Schedule async partition scan for trusted daemons */
-               if (!ub->unprivileged_daemons)
-                       schedule_work(&ub->partition_scan_work);
-       }
+       /*
+        * Only schedule async partition scan in case of
+        * !UBLK_F_NO_PART_SCAN and trusted daemons
+        */
+       if (!(ub->dev_info.flags & UBLK_F_NO_PART_SCAN) &&
+                       !ub->unprivileged_daemons)
+               schedule_work(&ub->partition_scan_work);

 out_put_cdev:
        if (ret) {
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a88876756805..d6f479fff75b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -367,8 +367,8 @@
  */
 #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)

-/* Disable automatic partition scanning when device is started */
-#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
+/* Disable partition scanning */
+#define UBLK_F_NO_PART_SCAN    (1ULL << 18)

 /* device state */
 #define UBLK_S_DEV_DEAD        0



Thanks,
Ming

