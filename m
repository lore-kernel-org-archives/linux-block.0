Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB63FC7
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974013; cv=none; b=fNhY5/IIDZIStlr+AidkWwiDiRWAf6LJA9F1yLvTMppbxj8E+vYGkCGDf+xjb2+kdJWOVS/hBVe5murhB15f7ZFwazvnKaOhBm0nYkCgOw/i5/3CynAXwHgG3ySpNihiQP4agzaGvRqA6WLJd9IGwMJZRo8OPItMlhavt6w6DKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974013; c=relaxed/simple;
	bh=hImT2GLeUDh1VEdcdk0y5atTFxRG8/6nbYn3gdWEqoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBU62seDViI/wbJR2Wh/1i2VcBXo2MDJGHKGsEXngRlQ+QC0kFf9SHhExAialFM4aVdKQ7419EYQXJceAP0DrJNudA0ZzpgBafWI/l2MsjDOFvR1GpX05RAbkJG9bgYc2bdN94r7wo7nK3bQYf/jB0Ew5jJgTS2RDTf+8HRSS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHwZ1R3E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHwZ1R3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745974010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNAw7paRDVx59MvrzksVHKc1SmkNctbf5DGsvHH1QL4=;
	b=iHwZ1R3EKSQZ4g2Mk/ohG4zt6cP+pGJT7lXyS42sZQ32Zxb/VTtiSpCJMXmLr0HCUUqhHa
	Zr+LqVN/DzTjN841R75DDPLyw3k4Cw98Cr2InEi9/0kj2X67T37Rd3w3w9VDUhD80r/nsW
	NwEOc3OzAbseqVxvNg6txQysvif9cJg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-BEM-wg-hPwC3nyNho3OEpw-1; Tue,
 29 Apr 2025 20:46:46 -0400
X-MC-Unique: BEM-wg-hPwC3nyNho3OEpw-1
X-Mimecast-MFC-AGG-ID: BEM-wg-hPwC3nyNho3OEpw_1745974005
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536A31800980;
	Wed, 30 Apr 2025 00:46:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FE1A180047F;
	Wed, 30 Apr 2025 00:46:39 +0000 (UTC)
Date: Wed, 30 Apr 2025 08:46:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 13/20] block: unifying elevator change
Message-ID: <aBFy6rb0_Ay0sWGn@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-14-ming.lei@redhat.com>
 <a201f5f0-b33e-4de1-8773-4d905bc83578@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a201f5f0-b33e-4de1-8773-4d905bc83578@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Apr 25, 2025 at 06:33:37PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/24/25 8:51 PM, Ming Lei wrote:
> > @@ -564,12 +558,7 @@ static int __add_disk_fwnode(struct device *parent, struct gendisk *disk,
> >  out_free_ext_minor:
> >  	if (disk->major == BLOCK_EXT_MAJOR)
> >  		blk_free_ext_minor(disk->first_minor);
> > -out_exit_elevator:
> > -	if (disk->queue->elevator) {
> > -		mutex_lock(&disk->queue->elevator_lock);
> > -		elevator_exit(disk->queue);
> > -		mutex_unlock(&disk->queue->elevator_lock);
> > -	}
> 
> After restructuring __add_disk_fwnode() we may still need elevator_exit()
> in case when blk_register_queue is successful and so we should have set
> q->elevator to default. Now if after queue is registered successfully, 
> for instance, bdi_register fails then in that case we still have to exit 
> elevator to free its resources, isn't it? 

If blk_register_queue is successful, it is blk_unregister_queue()'s
responsibility for covering it, elevator_exit() isn't needed here.


Thanks,
Ming

