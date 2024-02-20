Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AE67E7E
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431428; cv=none; b=iILneO5o01lVGE60UfVGaZNd3/O9kdQWJyBDfYcQ+XPlFsgfdFvysHERR1ZV4KcheCN2y6Q4dba1Lk7N/HeFXsEAM4LPkCcJChltnNsghfG6eFyQ9m+TOCjD8RZs4K3avDhOCP5X0s7LzCwBVT0g+f/18idgEy8nId8YOEplrwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431428; c=relaxed/simple;
	bh=OjbMGETjiXkItgkra+yTo54N/qBJu7LiqdC4Urk5qbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXkPnU/NwwABvMVkqRxMOBV3Nuy+e/mP/qD9h3/HQ/6UHXQM16JqVxkfuS9G7hnDWjPMLqeP0IJbct+dzCi+1ZeL3HdhmImKYSZXjXfazNDlmHhxt6Xz54AX2lcWz2UUx8SOgfFNi4kRg1fHEYRQ1gaeWYydmJw0MgHk6DIK3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yiua1PU2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yiua1PU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708431425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E4fG3BYTgeSZPowDICFjYCK2+rrv98FLB3yHfyUwb/w=;
	b=Yiua1PU2MBB4a9MyObiVvX7nY+IOOK0dvDiycAj5M2bpvbDcp93n/Ymm5b5J8aMCw2JuF+
	rMvr/DPboE+jMLq5PX6WZZRkhQMx3FhHU7DZbLC1m47zwsyxw9iFwlhC6vRLl0aFpbXRmd
	YBrGstnwF/Ibyk1L/nn1Dxxz623JTOY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-zSTkKG2wPpysLNZ7SHRAqQ-1; Tue, 20 Feb 2024 07:17:04 -0500
X-MC-Unique: zSTkKG2wPpysLNZ7SHRAqQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-564753be3deso1210555a12.3
        for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 04:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431423; x=1709036223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4fG3BYTgeSZPowDICFjYCK2+rrv98FLB3yHfyUwb/w=;
        b=B/uRQtt1ZkJp92Ietf+iLv3LIN2Ofu95Doqnyxj8r7D7czu8dUERuaHv24ofXBDQPY
         wHCw+dYE8mRroIqMN5+J2IWLd3aGzgDiOXaq7qWtFV+PWzOsYae1NthGzOVpIePvwDOo
         BmQ6ZynK+vqlylBeNhWlEiszLr6gJFuXLyuIsLWvOHulYVswWze1Yir3eul9xaxVgSDL
         XlyF2ozppF2Kb6VzMkRcukQVpCiUnf/5Qg4eK6yTlkcwIky3R9C/Jb2gzHx7QI2tuwJW
         4aryZzxrsc0r4/qECAF+SU5q6kTzqLevlW1Z+pAPvF2F5rUKavrgowkdvUnrVCknydEI
         ZHlA==
X-Forwarded-Encrypted: i=1; AJvYcCVIQnuK11irg3IT0WglkrliPwaD8GlPh3mL5fUYBz/bNmg9X3czjo1o2Y50DhQxciaw8AJ6+w0aUkkd+BGvIMt/lm//T4o1ZBr4Fm4=
X-Gm-Message-State: AOJu0Yza4irqTMTRHBcs4guA6LUY3HZLwYX4TFr+Q6WDdXLkma9wmsNq
	48MLK5sr9zaN/lhdaetIB/SUj6xGJBqPc4ny8PVA2muoTvBTQ1wvgqAZOPrrl3LRL/MHdSq8k9+
	+PzwzgakwHGjgnbB4Yt7uvfm+8yDEcZunnoAgrScEd33pjHxxlP9baYD8wPsc
X-Received: by 2002:a17:906:2ad3:b0:a3e:5fd8:8d57 with SMTP id m19-20020a1709062ad300b00a3e5fd88d57mr4128884eje.24.1708431423333;
        Tue, 20 Feb 2024 04:17:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWwJSIE6xUAes45StGDCguzVibL9Jaix0pYQe0gTRyJdk/IBeBaqhxFNmDgrsz5ogbuVtP3Q==
X-Received: by 2002:a17:906:2ad3:b0:a3e:5fd8:8d57 with SMTP id m19-20020a1709062ad300b00a3e5fd88d57mr4128870eje.24.1708431422905;
        Tue, 20 Feb 2024 04:17:02 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:1376:5352:3710:49bb:419e])
        by smtp.gmail.com with ESMTPSA id lm7-20020a170906980700b00a3e799969aesm2349484ejb.119.2024.02.20.04.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:17:02 -0800 (PST)
Date: Tue, 20 Feb 2024 07:16:58 -0500
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
Message-ID: <20240220071625-mutt-send-email-mst@kernel.org>
References: <20240217180848.241068-1-parav@nvidia.com>
 <ZdIFpqa23YHwJACh@fedora>
 <PH0PR12MB5481DCCE8127FB12C24EF74DDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240219024301-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548151B646CDE618F71DDAFEDC512@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240219054459-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481478D2F3EFEA552959DE1DC502@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481478D2F3EFEA552959DE1DC502@PH0PR12MB5481.namprd12.prod.outlook.com>

On Tue, Feb 20, 2024 at 12:03:15PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, February 19, 2024 4:17 PM
> > 
> > On Mon, Feb 19, 2024 at 10:39:36AM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, February 19, 2024 1:45 PM
> > > >
> > > > On Mon, Feb 19, 2024 at 03:14:54AM +0000, Parav Pandit wrote:
> > > > > Hi Ming,
> > > > >
> > > > > > From: Ming Lei <ming.lei@redhat.com>
> > > > > > Sent: Sunday, February 18, 2024 6:57 PM
> > > > > >
> > > > > > On Sat, Feb 17, 2024 at 08:08:48PM +0200, Parav Pandit wrote:
> > > > > > > When the PCI device is surprise removed, requests won't
> > > > > > > complete from the device. These IOs are never completed and
> > > > > > > disk deletion hangs indefinitely.
> > > > > > >
> > > > > > > Fix it by aborting the IOs which the device will never
> > > > > > > complete when the VQ is broken.
> > > > > > >
> > > > > > > With this fix now fio completes swiftly.
> > > > > > > An alternative of IO timeout has been considered, however when
> > > > > > > the driver knows about unresponsive block device, swiftly
> > > > > > > clearing them enables users and upper layers to react quickly.
> > > > > > >
> > > > > > > Verified with multiple device unplug cycles with pending IOs
> > > > > > > in virtio used ring and some pending with device.
> > > > > > >
> > > > > > > In future instead of VQ broken, a more elegant method can be used.
> > > > > > > At the moment the patch is kept to its minimal changes given
> > > > > > > its urgency to fix broken kernels.
> > > > > > >
> > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > > virtio pci device")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Reported-by: lirongqing@baidu.com
> > > > > > > Closes:
> > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb7
> > > > > > > 3ca9
> > > > > > > b474
> > > > > > > 1@baidu.com/
> > > > > > > Co-developed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > > > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > ---
> > > > > > >  drivers/block/virtio_blk.c | 54
> > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 54 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > b/drivers/block/virtio_blk.c index 2bf14a0e2815..59b49899b229
> > > > > > > 100644
> > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > @@ -1562,10 +1562,64 @@ static int virtblk_probe(struct
> > > > > > > virtio_device
> > > > > > *vdev)
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > >
> > > > > > > +static bool virtblk_cancel_request(struct request *rq, void *data) {
> > > > > > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > > > > > +
> > > > > > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > > > > > +	if (blk_mq_request_started(rq) &&
> > !blk_mq_request_completed(rq))
> > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > +
> > > > > > > +	return true;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void virtblk_cleanup_reqs(struct virtio_blk *vblk) {
> > > > > > > +	struct virtio_blk_vq *blk_vq;
> > > > > > > +	struct request_queue *q;
> > > > > > > +	struct virtqueue *vq;
> > > > > > > +	unsigned long flags;
> > > > > > > +	int i;
> > > > > > > +
> > > > > > > +	vq = vblk->vqs[0].vq;
> > > > > > > +	if (!virtqueue_is_broken(vq))
> > > > > > > +		return;
> > > > > > > +
> > > > > >
> > > > > > What if the surprise happens after the above check?
> > > > > >
> > > > > >
> > > > > In that small timing window, the race still exists.
> > > > >
> > > > > I think, blk_mq_quiesce_queue(q); should move up before
> > > > > cleanup_reqs()
> > > > regardless of surprise case along with other below changes.
> > > > >
> > > > > Additionally, for non-surprise case, better to have a graceful
> > > > > timeout to
> > > > complete already queued requests.
> > > > > In absence of timeout scheme for this regression, shall we only
> > > > > complete the
> > > > requests which the device has already completed (instead of waiting
> > > > for the grace time)?
> > > > > There was past work from Chaitanaya, for the graceful timeout.
> > > > >
> > > > > The sequence for the fix I have in mind is:
> > > > > 1. quiesce the queue
> > > > > 2. complete all requests which has completed, with its status 3.
> > > > > stop the transport (queues) 4. complete remaining pending requests
> > > > > with error status
> > > > >
> > > > > This should work regardless of surprise case.
> > > > > An additional/optional graceful timeout on non-surprise case can
> > > > > be helpful
> > > > for #2.
> > > > >
> > > > > WDYT?
> > > >
> > > > All this is unnecessarily hard for drivers... I am thinking maybe
> > > > after we set broken we should go ahead and invoke all callbacks.
> > >
> > > Yes, #2 is about invoking the callbacks.
> > >
> > > The issue is not with setting the flag broken. As Ming pointed, the issue is :
> > we may miss setting the broken.
> > 
> > 
> > So if we did get callbacks, we'd be able to test broken flag in the callback.
> > 
> Yes, getting callbacks is fine.
> But when the device is surprise removed, we wont get the callbacks and completions are missed.

exactly and then we should trigger them ourselves.

> > > Without graceful time out it is straight forward code, just rearrangement of
> > APIs in this patch with existing code.
> > >
> > > The question is : it is really if we really care for that grace period when the
> > device or driver is already on its exit path and VQ is not broken.
> > > If we don't wait for the request in progress, is it ok?
> > >
> > 
> > If we are talking about physical hardware, it seems quite possible that removal
> > triggers then user gets impatient and yanks the card out.
> > 
> Yes, regardless of surprise or not, completing the remaining IOs is just good enough.
> Device is anyway on its exit path, so completing 10 commands vs 12, does not make a lot of difference with extra complexity of timeout.
> 
> So better to not complicate the driver, at least not when adding Fixes tag patch.
> 
> > 
> > > > interrupt handling core is not making it easy for us - we must
> > > > disable real interrupts if we do, and in the past we failed to do it.
> > > > See e.g.
> > > >
> > > >
> > > > commit eb4cecb453a19b34d5454b49532e09e9cb0c1529
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Wed Mar 23 11:15:24 2022 +0800
> > > >
> > > >     Revert "virtio_pci: harden MSI-X interrupts"
> > > >
> > > >     This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56.
> > > > Issue
> > > >     were reported for the drivers that are using affinity managed IRQ
> > > >     where manually toggling IRQ status is not expected. And we forget to
> > > >     enable the interrupts in the restore path as well.
> > > >
> > > >     In the future, we will rework on the interrupt hardening.
> > > >
> > > >     Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> > > >
> > > >
> > > >
> > > > If someone can figure out a way to make toggling interrupt state
> > > > play nice with affinity managed interrupts, that would solve a host of
> > issues I feel.
> > > >
> > > >
> > > >
> > > > > > Thanks,
> > > > > > Ming

