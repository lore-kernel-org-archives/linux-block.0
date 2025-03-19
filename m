Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E641FB3
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411257; cv=none; b=AmMAuqVGa/xVqVPv0srizuIQibLWIaJHb/GH8AGRfMo0OZP5+g/I9JiQN5enlSqbFSrUnIUdMpdyfWAKFyb3SyoPZu/RTgHZkCTop0hfVaYnCFGXDospO7dzBlMvC7Yt/NpsoJ7xDnaIwDTtriUoi//0G7nBahvOc+GRKf6em9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411257; c=relaxed/simple;
	bh=hc8niUt8v/9/GCK4VXBm0yx6h1QT7YGX5MABwhSvCd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltwR205ksESV5Nzp8ATQB6drUAGsgrEkTaQdLNlkoGZXAlEAqDukpzL4mp6M7u5CnDWpXaZ9G1vhQnNJg+Sm8V3Z2NV62YbXf6rKmLobvRXrqMi7bK8QPuw8HT82HkUXji35K/m3Zpu4NqY1DhiB0mzNBQDnWMV8jPNAT+LIcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L01y397S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L01y397S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742411253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTtKeadc2EJ6wZ4tqEct53alfdvnMFDx/DalHKIKvw8=;
	b=L01y397SDN2IguEUhz5+j+5NJD4ZFM20xZyX67KEzQBCQD1+BU1cD8gCO9phl8g44Reyt4
	F+jsnfycxuXPxzEnT/3pAUwmbG+q8lbxxMWhHa4UeLHto7dAOUY8TgY64DGjtc9kRg7eVc
	eouk2AxChQYipX9SSt+DlhGx2LxeHYQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-OHuexILqPkSkY3LaJrzDaQ-1; Wed,
 19 Mar 2025 15:07:29 -0400
X-MC-Unique: OHuexILqPkSkY3LaJrzDaQ-1
X-Mimecast-MFC-AGG-ID: OHuexILqPkSkY3LaJrzDaQ_1742411248
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BE9419560AF;
	Wed, 19 Mar 2025 19:07:27 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E3761955BEE;
	Wed, 19 Mar 2025 19:07:26 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52JJ7OER2308457
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 15:07:24 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52JJ7Ovx2308456;
	Wed, 19 Mar 2025 15:07:24 -0400
Date: Wed, 19 Mar 2025 15:07:24 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/6] dm: fix issues with swapping dm tables
Message-ID: <Z9sV7N9c-W8-qy6s@redhat.com>
References: <20250317044510.2200856-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317044510.2200856-1-bmarzins@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

I noticed another issue while playing areound with this.  If you have a
linear device stacked on top of a zoned dm-crypt device, it will
allocate zone write plug resources, although it won't use them.
Actually, this is also true if you create a linear device on top of the
a zoned scsi_debug device.

The reason is that both dm-crypt and scsi_debug set
lim->max_hw_zone_append_sectors to 0. This makes sense, both of them are
simply emulating zone append. DM's check for devices that need zone
append emulation, dm_table_supports_zone_append(), correctly identifies
these linear devices as not needing emulation, so the
DMF_EMULATE_ZONE_APPEND isn't set and dm doesn't do zone write plugging.
But since these devices have lim->max_hw_zone_append_sectors = 0,
blk_revalidate_disk_zones() thinks they do need zone append emulation,
and allocates resources for it.

My question is "How do we solve this?" The easy DM answer is to change
dm_set_zones_restrictions() to do something like:

if (!dm_table_supports_zone_append(t))
	lim->max_hw_zone_append_sectors = 0;
else if (lim->max_hw_zone_append_sectors == 0)
	lim->max_hw_zone_append_sectors = lim->max_zone_append_sectors;

But I wonder if the correct fix is to change blk_stack_limits()
to do something like:

t->max_hw_zone_append_sectors = min(t->max_hw_zone_append_sectors,
                                    b->max_zone_append_sectors);

Even if the bottom device is emulating zone appends, from the point
of view of the top device, that is the max zone append sectors that
the underlying *hardware* supports. It's just that more drivers
than just DM use this, and prehaps some really do need to know what
the actual hardware supports, and not just what the device below then
can support or emulate.

Thoughts?

-Ben

On Mon, Mar 17, 2025 at 12:45:04AM -0400, Benjamin Marzinski wrote:
> There were multiple places in dm's __bind() function where it could fail
> and not completely roll back, leaving the device using the the old
> table, but with device limits and resources from the new table.
> Additionally, unused mempools for request-based devices were not always
> freed immediately.
> 
> Finally, there were a number of issues with switching zoned tables that
> emulate zone append (in other words, dm-crypt on top of zoned devices).
> dm_blk_report_zones() could be called while the device was suspended and
> modifying zoned resources or could possibly fail to end a srcu read
> section.  More importantly, blk_revalidate_disk_zones() would never get
> called when updating a zoned table. This could cause the dm device to
> see the wrong zone write offsets, not have a large enough zwplugs
> reserved in its mempool, or read invalid memory when checking the
> conventional zones bitmap.
> 
> This patchset fixes these issues. It deals with the problems around
> blk_revalidate_disk_zones() by only calling it for devices that have no 
> zone write plug resources. This will always correctly update the zoned
> settings. If a device has zone write plug resources, calling
> blk_revalidate_disk_zones() will not correctly update them in many
> cases, so DM simply doesn't call it for devices with zone write plug
> resources. Instead of allowing people to load tables that can break the
> device, like currently happens, DM disallosw any table reloads that
> change the zoned setting for devices that already have zone write plug
> resources.
> 
> Specifically, if a device already has zone plug resources allocated, it
> can only switch to another zoned table that also emulates zone append.
> Also, it cannot change the device size or the zone size. There are some
> tweaks to make sure that a device can always switch to an error target.
> 
> Changes in V2:
> - Made queue_limits_set() optionally return the old limits (grabbed
>   while holding the limits_lock), and used this in
>   dm_table_set_restrictions()
> - dropped changes to disk_free_zone_resources() and the
>   blk_revalidate_disk_zones() code path (removed patches 0005 & 0006)
> - Instead of always calling blk_revalidate_disk_zones(), disallow
>   changes that would change zone settings if the device has
>   zone write plug resources (final patch).
> 
> Benjamin Marzinski (6):
>   dm: don't change md if dm_table_set_restrictions() fails
>   dm: free table mempools if not used in __bind
>   block: make queue_limits_set() optionally return old limits
>   dm: handle failures in dm_table_set_restrictions
>   dm: fix dm_blk_report_zones
>   dm: limit swapping tables for devices with zone write plugs
> 
>  block/blk-settings.c   |  9 ++++-
>  drivers/md/dm-core.h   |  1 +
>  drivers/md/dm-table.c  | 66 ++++++++++++++++++++++++++-------
>  drivers/md/dm-zone.c   | 84 +++++++++++++++++++++++++++++-------------
>  drivers/md/dm.c        | 36 +++++++++++-------
>  drivers/md/dm.h        |  6 +++
>  drivers/md/md-linear.c |  2 +-
>  drivers/md/raid0.c     |  2 +-
>  drivers/md/raid1.c     |  2 +-
>  drivers/md/raid10.c    |  2 +-
>  drivers/md/raid5.c     |  2 +-
>  include/linux/blkdev.h |  3 +-
>  12 files changed, 154 insertions(+), 61 deletions(-)
> 
> -- 
> 2.48.1
> 

