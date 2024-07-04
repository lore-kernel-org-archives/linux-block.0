Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA6136E28
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119652; cv=none; b=rNPRn+QoM8HQ5SCqwNqQqACXPRdiPjYXY7Thdwb0pmuCgl0xQSFlW9bsdZZCWfXPHzWSvsgxClodfecyGQvwQUZEjsuHLVO342ZKq4SpW0nRdBeogD0bf3U2o+JIBeGWCZ5vSsFOxJ3l/ezjAQjrLrRnfWRnx/kb1K4ajYO0uHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119652; c=relaxed/simple;
	bh=NtItNwO/2aCZjg4nZ5dSSeFSK1mQZv/1XB0GzdvLLhc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c27r+Ou+GeA3Ty673sdLqbxNI5yR0o7YWwOSZTptlxH0xW6Cu+1115pkl1wGbbiT92tgOiuv02dx01p+q2MhSYDt4NlMQQNDUoDaRvusk5u7OkQwgOLh6qvD2SaFfFEeXmbGBgo3+LdpeYJsHLv6sakBb+jofDLyMgg9Fkx3X0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dgn+HySd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dgn+HySd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720119650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/qwYn98KjC1XCfQ1ZEHhXRILHt8fBZuMz3Loy8zZv8=;
	b=Dgn+HySdR01Oe4Hm14FD8xfQVOovWMof5P/nOddiAu4VY5QRbHKjpwH7mwwEOrYZUs1S6x
	BO21SiglTeuDNsxhXmDlk6Anx4tF5caaFErdNgttOeEIxSzMEJu6PUXFnmMsFAQKGaWFwn
	xfMeBeHztcLS9mA6RtpMP/KWpFn46G4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-9qNX2hRbPFeIQ2o1uxLQ2A-1; Thu,
 04 Jul 2024 15:00:45 -0400
X-MC-Unique: 9qNX2hRbPFeIQ2o1uxLQ2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5622B1955F49;
	Thu,  4 Jul 2024 19:00:43 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D70F3000180;
	Thu,  4 Jul 2024 19:00:42 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id EB62130C1C14; Thu,  4 Jul 2024 19:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id E8BE23FB5B;
	Thu,  4 Jul 2024 21:00:40 +0200 (CEST)
Date: Thu, 4 Jul 2024 21:00:40 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Li Dong <lidong@vivo.com>, Damien Le Moal <dlemoal@kernel.org>, 
    Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
    Jens Axboe <axboe@kernel.dk>
cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    "open list:DEVICE-MAPPER  (LVM)" <dm-devel@lists.linux.dev>, 
    open list <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com, 
    linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Non-power-of-2 zone size (was: [PATCH] dm-table:fix zone block_device
 not aligned with zonesize)
In-Reply-To: <cd05398-cffa-f4ca-2ac3-74433be2316c@redhat.com>
Message-ID: <c4ee654e-3120-e1a9-80b6-cb7073aa5c1a@redhat.com>
References: <20240704151549.1365-1-lidong@vivo.com> <cd05398-cffa-f4ca-2ac3-74433be2316c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



> On Thu, 4 Jul 2024, Li Dong wrote:
> 
> > For zone block devices, device_area_is_invalid may return an incorrect 
> > value.
> > 
> > Failure log:
> > [   19.337657]: device-mapper: table: 254:56: len=836960256 not aligned to
> > h/w zone size 3244032 of sde
> > [   19.337665]: device-mapper: core: Cannot calculate initial queue limits
> > [   19.337667]: device-mapper: ioctl: unable to set up device queue for 
> > new table.
> > 
> > Actually, the device's zone length is aligned to the zonesize.
> > 
> > Fixes: 5dea271b6d87 ("dm table: pass correct dev area size to device_area_is_valid")
> > Signed-off-by: Li Dong <lidong@vivo.com>
> > ---
> >  drivers/md/dm-table.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 33b7a1844ed4..0bddae0bee3c 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -257,7 +257,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
> >  	if (bdev_is_zoned(bdev)) {
> >  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
> >  
> > -		if (start & (zone_sectors - 1)) {
> > +		if (start % zone_sectors) {
> >  			DMERR("%s: start=%llu not aligned to h/w zone size %u of %pg",
> >  			      dm_device_name(ti->table->md),
> >  			      (unsigned long long)start,
> > @@ -274,7 +274,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
> >  		 * devices do not end up with a smaller zone in the middle of
> >  		 * the sector range.
> >  		 */
> > -		if (len & (zone_sectors - 1)) {
> > +		if (len % zone_sectors) {
> >  			DMERR("%s: len=%llu not aligned to h/w zone size %u of %pg",
> >  			      dm_device_name(ti->table->md),
> >  			      (unsigned long long)len,
> > -- 
> > 2.31.1.windows.1

I grepped the kernel for bdev_zone_sectors and there are more assumptions 
that bdev_zone_sectors is a power of 2.

drivers/md/dm-zone.c:           sector_t mask = bdev_zone_sectors(disk->part0) - 1
drivers/nvme/target/zns.c:      if (get_capacity(bd_disk) & (bdev_zone_sectors(ns->bdev) - 1))
drivers/nvme/target/zns.c:      if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
fs/zonefs/super.c:      sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
fs/btrfs/zoned.c:       return (sector_t)zone_number << ilog2(bdev_zone_sectors(bdev));
fs/btrfs/zoned.c:	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
include/linux/blkdev.h: return sector & (bdev_zone_sectors(bdev) - 1);
fs/f2fs/super.c:	if (nr_sectors & (zone_sectors - 1))

So, if we want to support non-power-of-2 zone size, we need some 
systematic fix. Now it appears that Linux doesn't even attempt to support 
disks non-power-of-2 zone size.

I added Damien Le Moal so that he can help with testing disks with 
non-power-of-2 zone size (if WD is actually making them).

Mikulas

