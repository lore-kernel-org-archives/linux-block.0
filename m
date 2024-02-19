Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EAA21344
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330538; cv=none; b=R7ZBnUroTet5/p3O5WcQjMajKKatV68O7nKfz5kVw4T8nTyCqDgVpjjj9ggkGi74HPI61ClPY3tPcqkWMMHAS2XSha+QJsb8PS3ZBobROlV+nZgXdutZNqz3qfzmVgCRQZYkfatuphLFD+tHl0dBu5LD3mi9F3sVwJJxl+7grf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330538; c=relaxed/simple;
	bh=j2cEZt/3VW2eWmx0fQmIEA3xNdXltuZf/QYncINHNYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyPZBozn/pqieDYY3WVnmKVkagcHYJiIdt55dFkhBUnddW78qhAzTACU9+/4WUY6l7vmuGb2hbviI2KQh5mZdTpbr7cEDWSJVDUXgrMRzXaev3Zz+lWaeMhjOH26oix63gRi+Yt+Ln005RMaAXKG3Alhgp9NTxZwA5hzfxgFVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9nit5iv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9nit5iv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708330535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9ztVhk86xA+0X7WQqXAbuoW3FEkGwUIycwMn/Iz/us=;
	b=W9nit5ivDVhOlhgn0/XG4gtkQJnNpb20QnwoAUgnvgiSX92YBIl9y8h0UJkLo7kWeM00o5
	mnM079Bdng8/3cBy7GWuhWIE7B44eF9jJ+7eUsWMywxo7aaVn460ENzxzv+PzeH8psdJaD
	ZNlbzocENtl0al1L94ql3uM6GWJPu4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-ajWQanRDPmagXKbAlDzsYA-1; Mon, 19 Feb 2024 03:15:32 -0500
X-MC-Unique: ajWQanRDPmagXKbAlDzsYA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412567128ebso8486565e9.0
        for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 00:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330531; x=1708935331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9ztVhk86xA+0X7WQqXAbuoW3FEkGwUIycwMn/Iz/us=;
        b=All+GD4OZlVHGqNUC0r/bXFB0et7sU0Ke9vNTRm4tWmaM/Wwevf6D8XeY8uGr38Ddg
         OmsGKUqSDJqAIvzuIj4q8BON7cJEFphjBWgA3Aetuci2Wvue+VvK3LVDOmZVy+ndlm9k
         TxjDF1jYorEONGpkECDgJv9ZLLs8mJPVkbQGIVHSrn7eBibtWDAo7c3rtMgVQztH6bMb
         zqPDXc/pwRbzCeqbkG52O/YNgqE9k0MRRwfdDnlfR5p6NVnMsx8t1OFKHEuV1ZtkTSVw
         xkrvXwcno3hYa3W1rl2aPCXNLXMVerD6wjYgeP6RRttjfbn6UcGuoPHmpdXVCM13svm4
         adIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlmQkAnAbQT1FyUy32kd49ihGsOtFrnScsmlIkbf5SxosMOKTRqeSOr+d7Lp5441hCK4rg53Y+6vEAL7Er3CPGVYzyx/jdPXeAVz4=
X-Gm-Message-State: AOJu0YxC4wmDgrxNuVKQrefLkjq4sIw/yrbuM71yU1Efh+DYhNsVLam7
	oxk9PwJs/H/HfNOvqOv2z05Lm25snGNpYdpjEpSNGUa8ZLKq0nUFIc2g3J8Nt9iCKGJkHP4J47K
	AO0y9m9BcQXsj4K3ZpNUa6E7Js5Y8+zzAi3myC+ZlXl+iuNDCQqq8l4s0SJUx
X-Received: by 2002:a05:600c:1d8d:b0:412:69c5:90cd with SMTP id p13-20020a05600c1d8d00b0041269c590cdmr276889wms.11.1708330531320;
        Mon, 19 Feb 2024 00:15:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJcuIHQcR+otvj2WKFUc1crPHTHmIPqh64OpmF5NjW8PDxVGNwrrlpaSUxJJOg9upLS5Ljmg==
X-Received: by 2002:a05:600c:1d8d:b0:412:69c5:90cd with SMTP id p13-20020a05600c1d8d00b0041269c590cdmr276874wms.11.1708330530909;
        Mon, 19 Feb 2024 00:15:30 -0800 (PST)
Received: from redhat.com ([2.52.19.211])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b004101f27737asm10493845wmi.29.2024.02.19.00.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:15:30 -0800 (PST)
Date: Mon, 19 Feb 2024 03:15:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] virtio_blk: Fix device surprise removal
Message-ID: <20240219024301-mutt-send-email-mst@kernel.org>
References: <20240217180848.241068-1-parav@nvidia.com>
 <ZdIFpqa23YHwJACh@fedora>
 <PH0PR12MB5481DCCE8127FB12C24EF74DDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481DCCE8127FB12C24EF74DDC512@PH0PR12MB5481.namprd12.prod.outlook.com>

On Mon, Feb 19, 2024 at 03:14:54AM +0000, Parav Pandit wrote:
> Hi Ming,
> 
> > From: Ming Lei <ming.lei@redhat.com>
> > Sent: Sunday, February 18, 2024 6:57 PM
> > 
> > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests won't complete from
> > > the device. These IOs are never completed and disk deletion hangs
> > > indefinitely.
> > >
> > > Fix it by aborting the IOs which the device will never complete when
> > > the VQ is broken.
> > >
> > > With this fix now fio completes swiftly.
> > > An alternative of IO timeout has been considered, however when the
> > > driver knows about unresponsive block device, swiftly clearing them
> > > enables users and upper layers to react quickly.
> > >
> > > Verified with multiple device unplug cycles with pending IOs in virtio
> > > used ring and some pending with device.
> > >
> > > In future instead of VQ broken, a more elegant method can be used. At
> > > the moment the patch is kept to its minimal changes given its urgency
> > > to fix broken kernels.
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > > 1@baidu.com/
> > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 54
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 2bf14a0e2815..59b49899b229 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> > >  	return err;
> > >  }
> > >
> > > +static bool virtblk_cancel_request(struct request *rq, void *data) {
> > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > +
> > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > +		blk_mq_complete_request(rq);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > +	struct virtio_blk_vq *blk_vq;
> > > +	struct request_queue *q;
> > > +	struct virtqueue *vq;
> > > +	unsigned long flags;
> > > +	int i;
> > > +
> > > +	vq = vblk->vqs[0].vq;
> > > +	if (!virtqueue_is_broken(vq))
> > > +		return;
> > > +
> > 
> > What if the surprise happens after the above check?
> > 
> > 
> In that small timing window, the race still exists.
> 
> I think, blk_mq_quiesce_queue(q); should move up before cleanup_reqs() regardless of surprise case along with other below changes.
> 
> Additionally, for non-surprise case, better to have a graceful timeout to complete already queued requests.
> In absence of timeout scheme for this regression, shall we only complete the requests which the device has already completed (instead of waiting for the grace time)?
> There was past work from Chaitanaya, for the graceful timeout.
> 
> The sequence for the fix I have in mind is:
> 1. quiesce the queue
> 2. complete all requests which has completed, with its status
> 3. stop the transport (queues)
> 4. complete remaining pending requests with error status
> 
> This should work regardless of surprise case.
> An additional/optional graceful timeout on non-surprise case can be helpful for #2.
> 
> WDYT?

All this is unnecessarily hard for drivers... I am thinking
maybe after we set broken we should go ahead and invoke all
callbacks. The issue is really interrupt handling core
is not making it easy for us - we must disable real
interrupts if we do, and in the past we failed to do it.
See e.g.


commit eb4cecb453a19b34d5454b49532e09e9cb0c1529
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Mar 23 11:15:24 2022 +0800

    Revert "virtio_pci: harden MSI-X interrupts"
    
    This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56. Issue
    were reported for the drivers that are using affinity managed IRQ
    where manually toggling IRQ status is not expected. And we forget to
    enable the interrupts in the restore path as well.
    
    In the future, we will rework on the interrupt hardening.
    
    Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")



If someone can figure out a way to make toggling interrupt state
play nice with affinity managed interrupts, that would solve
a host of issues I feel.



> > Thanks,
> > Ming

