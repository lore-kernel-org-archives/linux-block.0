Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF931DF744
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335812; cv=none; b=JR2nmw/pOjC0suxbJicyS1eBgXMZF7yjee7s5/C0kP0F/EGVK6pA0IGBvYKe6aJmMV8SGW0oJAzLRK5SDFC94lF9DfgZ/QTUxmVP78gOmywzb32gJHqTuZqUdLMxf5iTLueDuWda/bd3ktbeDDam0oHe3pPtbkVi0apaIuGTWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335812; c=relaxed/simple;
	bh=khxj7baollN6tKPpDs535oc7tDAvfa/VkO/Qu/pf/rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYrm8LoOqDJLMSIYQN/7HHNHk1WdSoxo5teOY1JE1jWj1jhzDUiOBxRui+7umPHc+/2yRhjlp2Zh7jX77Q6jIkSV+Ja5k2myUwQW4JFCRsAJrBNRK1DKVulrpdcT5YVfv5iHl2T8BHpgdPI0v/QZ/g62bGCV+eG2NfDrtvX5qkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+BwupGS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+BwupGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742335809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNBBDhtZR+j1rFU2QPO7CjAk6CumeAeXjh8sXEmCw3A=;
	b=A+BwupGSGuDtERmR9T20PyeiFbbrzIvVYLsGK/gmh7sAOQN6AM1ZtoTXnn7XzcqZH3kEyC
	N2nJnjvea7FJXGZjTReKjx41wg4pIkJrskNKZ/3Xyr0qE4tgkKo6G4Ye5lV6oXyugmu3Eh
	Ki0FjB0f0/gycVYn0tXLgVF36ZvSTKE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-8_KXTYjuP-m6YybbA2NBUg-1; Tue,
 18 Mar 2025 18:10:06 -0400
X-MC-Unique: 8_KXTYjuP-m6YybbA2NBUg-1
X-Mimecast-MFC-AGG-ID: 8_KXTYjuP-m6YybbA2NBUg_1742335805
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E001C195608A;
	Tue, 18 Mar 2025 22:10:04 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAB9B1800946;
	Tue, 18 Mar 2025 22:10:03 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52IMA2uF2272791
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 18:10:02 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52IMA16j2272790;
	Tue, 18 Mar 2025 18:10:01 -0400
Date: Tue, 18 Mar 2025 18:10:01 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 5/6] dm: fix dm_blk_report_zones
Message-ID: <Z9nvOcQRrxopHfrF@redhat.com>
References: <20250317044510.2200856-1-bmarzins@redhat.com>
 <20250317044510.2200856-6-bmarzins@redhat.com>
 <20250318065721.GB16259@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318065721.GB16259@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 18, 2025 at 07:57:21AM +0100, Christoph Hellwig wrote:
> On Mon, Mar 17, 2025 at 12:45:09AM -0400, Benjamin Marzinski wrote:
> > __bind(). Otherwise the zone resources could change while accessing
> > them. Finally, it is possible that md->zone_revalidate_map will change
> > while calling this function. Only read it once, so that we are always
> > using the same value. Otherwise we might miss a call to
> > dm_put_live_table().
> 
> This checking for calling context is pretty ugly.  Can you just use
> a separate report zones helper or at least a clearly documented flag for it?

Not sure how that would work. The goal is to keep another process,
calling something like blkdev_report_zones_ioctl(), from being able to
call its report_zones_cb, while DM is in blk_revalidate_disk_zones()
which needs to use that same disk->fops->report_zones() interface in
order to call blk_revalidate_zone_cb(). We need some way to distinguish
between the callers. We could export blk_revalidate_zone_cb() and have
dm_blk_report_zones() check if it was called with that report_zones_cb.
That seems just as ugly to me. But if you like that better, fine.
Otherwise I don't see how we can distinguish between the call from
blk_revalidate_disk_zones() and a call from something like
blkdev_report_zones_ioctl(). Am I not understanding your suggestion?

Allowing the blkdev_report_zones_ioctl() call to go ahead using
md->zone_revalidate_map runs into three problems.

1. It's running while the device is switching tables, and there's no
guarantee that DM won't encounter an error and have to fail back. So it
could report information for this unused table. We could just say that
this is what you get from trying to grab the zone information of a
device while it's switching tables. Fine.

2. Without this patch, it's possible that while
blkdev_report_zones_ioctl() is still running its report_zones_cb, DM
fails switching tables and frees the new table that's being used by
blkdev_report_zones_ioctl(), causing use-after-free errors. However,
this is solvable by calling srcu_read_lock(&md->io_barrier) to make sure
that we're in a SRCU read section while using md->zone_revalidate_map.
Making that chage should make DM as safe as any other zoned device,
which brings me to...

3. On any zoned device, not just DM, what's stopping
one process from syncing the zone write plug offsets:
blkdev_report_zones_ioctl() -> blkdev_report_zones() ->
various.report_zones() -> disk_report_zones_cb() ->
disk_zone_wplug_sync_wp_offset()

While another process is running into problems while dealing with the
gendisk's zone configuration changing:

blk_revalidate_disk_zones() -> disk_free_zone_resources()

I don't see any synchronizing between these two call paths. Am I missing
something that stops this? Can this only happen for DM devices, for some
reason? If this can't happen, I'm fine with just adding a
srcu_read_lock() to dm_blk_report_zones() and calling it good.  If it
can happen, then we should fix that.

-Ben

