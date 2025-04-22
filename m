Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835B5FB95
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319065; cv=none; b=YIS4NIETgl3Cje5XGKWqxsCaQ++fkuZ7Bqk0ocU+SSF6/V544Yt0wSZi5J579MXdEfHc30y5oE3BkGP3rEtcq5ivMSNSvrV2o2UoA1UgVHDy5nhosJyV10L9hGGlYnAE5Y9WY9wE7UftfvYbmk3H/OWKbNDkm3zvzZSUsQ0lMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319065; c=relaxed/simple;
	bh=TzfCKUE8nNhw8ChmZapQVsov6szyvwV+4eI6sOUTxlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaCaL63h/2r7wC3sMasrtAZwH6CSzAaWygAr5tf5tGULhmpsh1TKaBeuN3dz61cBfh+rodHcPDwzcnSwQJ58CNglkMu0V08hUofBXIdmtj9DtFM86e6Q8xqrIC7rJYWCjQ8y+J+5o+lGQ+Dl4C0IL8n7ulYK8QN0mrvkM+XWVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ND5eSUXX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ND5eSUXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745319062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JqnxpNP6Sw5lWQfMVZCyNlXRIb4JneVeUrvXP7ojI8=;
	b=ND5eSUXXxtVtAzPszr/lmZDt18IX084MxQxMaej2r7hpyl8eQesgAMrlvVW7yHjXD8uiX+
	gFuQUbRvNOVaslePET/8NwhI9v8ULwmjMtfs3cho0EY6OWQiq5TO/4Hcu2dwphFAes0WmF
	WIKc4lV2PgX72oEN7ZmDEgF0UMUCUeM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-yQocWRyLNQGZvBZNDkCT3A-1; Tue,
 22 Apr 2025 06:50:58 -0400
X-MC-Unique: yQocWRyLNQGZvBZNDkCT3A-1
X-Mimecast-MFC-AGG-ID: yQocWRyLNQGZvBZNDkCT3A_1745319057
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E2241800874;
	Tue, 22 Apr 2025 10:50:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C6A1180045C;
	Tue, 22 Apr 2025 10:50:52 +0000 (UTC)
Date: Tue, 22 Apr 2025 18:50:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 11/20] block: move blk_unregister_queue() &
 device_del() after freeze wait
Message-ID: <aAd0h_4jQAcAca4u@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-12-ming.lei@redhat.com>
 <97eb54b7-25f1-4691-bbcb-6db18c7bd056@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97eb54b7-25f1-4691-bbcb-6db18c7bd056@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Apr 19, 2025 at 06:08:30PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/18/25 10:06 PM, Ming Lei wrote:
> > Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> > for unifying elevator switch.
> > 
> > This way is just fine, since bdev has been unhashed at the beginning of
> > del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> > with kobject & debugfs thing only.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/genhd.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index d22fdc0d5383..86c3db5b9305 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -749,8 +749,6 @@ static int __del_gendisk(struct gendisk_data *data)
> >  		bdi_unregister(disk->bdi);
> >  	}
> >  
> > -	blk_unregister_queue(disk);
> > -
> >  	kobject_put(disk->part0->bd_holder_dir);
> >  	kobject_put(disk->slave_dir);
> >  	disk->slave_dir = NULL;
> > @@ -759,10 +757,12 @@ static int __del_gendisk(struct gendisk_data *data)
> >  	disk->part0->bd_stamp = 0;
> >  	sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
> >  	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
> > -	device_del(disk_to_dev(disk));
> >  
> >  	blk_mq_freeze_queue_wait(q);
> >  
> > +	blk_unregister_queue(disk);
> > +	device_del(disk_to_dev(disk));
> > +
> >  	blk_throtl_cancel_bios(disk);
> >  
> >  	blk_sync_queue(q);
> As we first freeze the queue and then enter blk_unregister_queue which 
> deals with kobject/debufs, do we need to create memalloc GFP_NOIO scope
> while running blk_unregister_queue? I see that device_del already defines
> the GFP_NOIO scope. 

We actually need to do that with the read lock together.


Thanks,
Ming

