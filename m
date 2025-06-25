Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9F25C702
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851891; cv=none; b=VW2Sh+iDOwBf2ORswnLu2ZPA8HoLjdWUFbqVXkOgQHDYN7+QVNKtUe1q/Vf3s1m1SrAozZJELWvvE2g+VqDo9IdMTN8VPLvvThdkGc6kQO/jLPnnLueq6b2U450vKagClXlOFCqgzSpXUUZCAaT+1eMsoozRX1piSxH89XdjxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851891; c=relaxed/simple;
	bh=EbNIsfrmAZkrndwEZjq7e5aA3eEJpyRlElb12KOXufw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq3grmCJ+3ozyhH9xCIAeA84SqdKgExWOmR4awC4cisM3viDg/AKAPi8u8KGAAOkO8G5uktHmhjmKu08T9QbF9g/zChboPtXowmBXcEUi6S/frBFtDg7gPNyeE9lZjjAID6widHT+DbsQI0Db4Aa/hvzHn5GngE9RcFyxWRbMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzGaQ/lC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzGaQ/lC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750851887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7DB0M+XZEXpWtzl3X/ZrT9+loEBDTTEz/btHO9PtKE=;
	b=YzGaQ/lCE/dRgST//8jv4VsnweO/OUjf/HohoGkNgH6STf1ucHR6yKRXG3iqYvPtZDKfTa
	n+zvD9NMu3OLxNUcI9Nt5k1dPGaskRM+4OOXtioCyJ6e5DDJtsM9SiDH5dXUsBpHyVRvJn
	6dmY1TrWsF0mIpHL97F8gaFuqGQCG74=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-k4laZxy5M0yy-km0XsdsNg-1; Wed, 25 Jun 2025 07:44:46 -0400
X-MC-Unique: k4laZxy5M0yy-km0XsdsNg-1
X-Mimecast-MFC-AGG-ID: k4laZxy5M0yy-km0XsdsNg_1750851885
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0ba0eb825so79938066b.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 04:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750851885; x=1751456685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7DB0M+XZEXpWtzl3X/ZrT9+loEBDTTEz/btHO9PtKE=;
        b=YKkOv+1sR1kRPhLFgX8uSap7OglKvpLK+yg/FbSFIwgiAR8EoFr2dJLYxLo+snO8NB
         knguqWvd6zGT4cVJmMe+ki1z0EVRsePFjV5YX9E14fF0WQiPeVUEnQoNzzUMAQ6U3GXa
         PW9U+52X8AneQUN//Yq3Sprp82kviOhB72r1hsq4HNad7wde9hxOGJPOcttdBOjNKgoo
         ZMvSDg6GdX4oRvaTiKeWRyE36Y7ldwFkUio8/xhXRq2lAXPK24xpzGc7t+yFjsOedUq/
         OdfYUWJrOM+QsRhg0cQdKVKzDHC/r904UCK5uxZLvY6VJUiy17jtT4UIHQiODejSxc5s
         cFuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZcSRmgLdNAV2s0c65IyvrhR0HjC+jTqeNuXi0sRGBcauyNKw7wHvMeuDrQ03UTRJqPXPcgtOm1hqQtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnuDJb+dKQ3Q2LQznm8bXA3007LVou+EOWfyRqyX4WlpkLwXN
	9JXK87G/6oMhlQ+lo6F3WfdB2hESucZ4YGThK2yiIPPNjLTKS35FS2JYlmu7D1Uyj/cu0/D9zZO
	nvmtZOnft9/mwRA890YYysMqA2EvV1b6pfWndRCct4wbqHQrnaKUIk2tD39EXVlm48OJ+LWpq
X-Gm-Gg: ASbGnctc+CakA97w45nDK0xvtxrNPJCXQg6QYQMOiF0rt+XCbmEH8Xq0iWKs9X3x/Mp
	dVt9wswSJpZKssXkwn3VsNan2nKT7TyqLJMtIgJ/ndsb6E3da63//lHMfR/QG8ZV1NN9fs8otF0
	7qUoQxpgkZkRzrDdy+3bGI+sEdkZSvadCl53RCXUYy2zEpYMQcoVn1VaUJGqAbRH/RFjQhBMK+p
	RnzZ4Jj9/GmA/Mh+1+Ih3tbwNGXL55se/0p6A36tlBl50FhYT4oHmt6NCr9kluSjOIHG8XiQKBf
	tc8AuNtL4Kg=
X-Received: by 2002:a17:907:9447:b0:ae0:cccd:3e7d with SMTP id a640c23a62f3a-ae0cccd6667mr39299766b.33.1750851884612;
        Wed, 25 Jun 2025 04:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0tg5rtdPZNJkQBFwtpTQY99Q02pZ9j+qthvcbP3Q1RGnnnHKHcxH0x4kHVE92NcOHkdubZA==
X-Received: by 2002:a17:907:9447:b0:ae0:cccd:3e7d with SMTP id a640c23a62f3a-ae0cccd6667mr39296466b.33.1750851884038;
        Wed, 25 Jun 2025 04:44:44 -0700 (PDT)
Received: from redhat.com ([31.187.78.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b4fb52dbsm201758666b.123.2025.06.25.04.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:44:43 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:44:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250625074112-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, Jun 25, 2025 at 11:08:42AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 25 June 2025 04:34 PM
> > 
> > On Wed, Jun 25, 2025 at 02:55:27AM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 25 June 2025 01:24 AM
> > > >
> > > > On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: 25 June 2025 12:37 AM
> > > > > >
> > > > > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> > > > > > >
> > > > > > >
> > > > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > Sent: 25 June 2025 12:26 AM
> > > > > > > >
> > > > > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > > > > > > > When the PCI device is surprise removed, requests may not
> > > > > > > > > complete the device as the VQ is marked as broken. Due to
> > > > > > > > > this, the disk deletion hangs.
> > > > > > > >
> > > > > > > > There are loops in the core virtio driver code that expect
> > > > > > > > device register reads to eventually return 0:
> > > > > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_r
> > > > > > > > eset
> > > > > > > > ()
> > > > > > > >
> > > > > > > > Is there a hang if these loops are hit when a device has
> > > > > > > > been surprise removed? I'm trying to understand whether
> > > > > > > > surprise removal is fully supported or whether this patch is
> > > > > > > > one step in that
> > > > direction.
> > > > > > > >
> > > > > > > In one of the previous replies I answered to Michael, but
> > > > > > > don't have the link
> > > > > > handy.
> > > > > > > It is not fully supported by this patch. It will hang.
> > > > > > >
> > > > > > > This patch restores driver back to the same state what it was
> > > > > > > before the fixes
> > > > > > tag patch.
> > > > > > > The virtio stack level work is needed to support surprise
> > > > > > > removal, including
> > > > > > the reset flow you rightly pointed.
> > > > > >
> > > > > > Have plans to do that?
> > > > > >
> > > > > Didn't give enough thoughts on it yet.
> > > >
> > > > This one is kind of pointless then? It just fixes the specific race
> > > > window that your test harness happens to hit?
> > > >
> > > It was reported by Li from Baidu, whose tests failed.
> > > I missed to tag "reported-by" in v5. I had it until v4. :(
> > >
> > > > Maybe it's better to wait until someone does a comprehensive fix..
> > > >
> > > >
> > > Oh, I was under impression is that you wanted to step forward in discussion
> > of v4.
> > > If you prefer a comprehensive support across layers of virtio, I suggest you
> > should revert the cited patch in fixes tag.
> > >
> > > Otherwise, it is in degraded state as virtio never supported surprise removal.
> > > By reverting the cited patch (or with this fix), the requests and disk deletion
> > will not hang.
> > 
> > But they will hung in virtio core on reset, will they not? The tests just do not
> > happen to trigger this?
> > 
> It will hang if it a true surprise removal which no device did so far because it never worked.
> (or did, but always hung that no one reported yet)
> 
> I am familiar with 2 or more PCI devices who reports surprise removal, which do not complete the requests but yet allows device reset flow.
> This is because device is still there on the PCI bus. Only via side band signals device removal was reported.

So why do we care about it so much? I think it's great this patch
exists, for example it makes it easier to test surprise removal
and find more bugs. But is it better to just have it hang
unconditionally? Are we now making a commitment that it's working -
one we don't seem to intend to implement?

> But I agree that for full support, virtio all layer changes would be needed as new functionality (without fixes tag  :) ).


Or with a fixes tag - lots of people just use it as a signal to mean
"where can this be reasonably backported to".


> > > Please let me know if I should re-send to revert the patch listed in fixes tag.
> > >
> > > > > > > > Apart from that, I'm happy with the virtio_blk.c aspects of the
> > patch:
> > > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > > > >
> > > > > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > > > > >
> > > > > > > > > With this fix now fio completes swiftly.
> > > > > > > > > An alternative of IO timeout has been considered, however
> > > > > > > > > when the driver knows about unresponsive block device,
> > > > > > > > > swiftly clearing them enables users and upper layers to react
> > quickly.
> > > > > > > > >
> > > > > > > > > Verified with multiple device unplug iterations with
> > > > > > > > > pending requests in virtio used ring and some pending with the
> > device.
> > > > > > > > >
> > > > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal
> > > > > > > > > of virtio pci device")
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > > > > > Closes:
> > > > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c5
> > > > > > > > > 5fb7
> > > > > > > > > 3ca9
> > > > > > > > > b474
> > > > > > > > > 1@baidu.com/
> > > > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > > v4->v5:
> > > > > > > > > - fixed comment style where comment to start with one
> > > > > > > > > empty line at start
> > > > > > > > > - Addressed comments from Alok
> > > > > > > > > - fixed typo in broken vq check
> > > > > > > > > v3->v4:
> > > > > > > > > - Addressed comments from Michael
> > > > > > > > > - renamed virtblk_request_cancel() to
> > > > > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > > > > - Added comments for virtblk_complete_request_with_ioerr()
> > > > > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > > > > >   virtblk_cleanup_broken_device()
> > > > > > > > > - Added comments for virtblk_cleanup_broken_device()
> > > > > > > > > - Moved the broken vq check in virtblk_remove()
> > > > > > > > > - Fixed comment style to have first empty line
> > > > > > > > > - replaced freezed to frozen
> > > > > > > > > - Fixed comments rephrased
> > > > > > > > >
> > > > > > > > > v2->v3:
> > > > > > > > > - Addressed comments from Michael
> > > > > > > > > - updated comment for synchronizing with callbacks
> > > > > > > > >
> > > > > > > > > v1->v2:
> > > > > > > > > - Addressed comments from Stephan
> > > > > > > > > - fixed spelling to 'waiting'
> > > > > > > > > - Addressed comments from Michael
> > > > > > > > > - Dropped checking broken vq from queue_rq() and queue_rqs()
> > > > > > > > >   because it is checked in lower layer routines in virtio
> > > > > > > > > core
> > > > > > > > >
> > > > > > > > > v0->v1:
> > > > > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > > > > - Improved logic for handling any outstanding requests
> > > > > > > > >   in bio layer
> > > > > > > > > - improved cancel callback to sync with ongoing done()
> > > > > > > > > ---
> > > > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 95 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > > > b/drivers/block/virtio_blk.c index
> > > > > > > > > 7cffea01d868..c5e383c0ac48
> > > > > > > > > 100644
> > > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > > > > > > virtio_device
> > > > > > > > *vdev)
> > > > > > > > >  	return err;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +/*
> > > > > > > > > + * If the vq is broken, device will not complete requests.
> > > > > > > > > + * So we do it for the device.
> > > > > > > > > + */
> > > > > > > > > +static bool virtblk_complete_request_with_ioerr(struct
> > > > > > > > > +request *rq, void *data) {
> > > > > > > > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > > > > > > > +	struct virtio_blk *vblk = data;
> > > > > > > > > +	struct virtio_blk_vq *vq;
> > > > > > > > > +	unsigned long flags;
> > > > > > > > > +
> > > > > > > > > +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > > > > +
> > > > > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > > > > +
> > > > > > > > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > > > > > > > +	if (blk_mq_request_started(rq) &&
> > > > !blk_mq_request_completed(rq))
> > > > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > > > +
> > > > > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > > > > +	return true;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > + * If the device is broken, it will not use any buffers
> > > > > > > > > +and waiting
> > > > > > > > > + * for that to happen is pointless. We'll do the cleanup
> > > > > > > > > +in the driver,
> > > > > > > > > + * completing all requests for the device.
> > > > > > > > > + */
> > > > > > > > > +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk)
> > {
> > > > > > > > > +	struct request_queue *q = vblk->disk->queue;
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * Start freezing the queue, so that new requests keeps
> > > > waiting at the
> > > > > > > > > +	 * door of bio_queue_enter(). We cannot fully freeze the
> > > > > > > > > +queue
> > > > > > > > because
> > > > > > > > > +	 * frozen queue is an empty queue and there are pending
> > > > requests, so
> > > > > > > > > +	 * only start freezing it.
> > > > > > > > > +	 */
> > > > > > > > > +	blk_freeze_queue_start(q);
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * When quiescing completes, all ongoing dispatches have
> > > > completed
> > > > > > > > > +	 * and no new dispatch will happen towards the driver.
> > > > > > > > > +	 */
> > > > > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * Synchronize with any ongoing VQ callbacks that may
> > > > > > > > > +have
> > > > started
> > > > > > > > > +	 * before the VQs were marked as broken. Any outstanding
> > > > requests
> > > > > > > > > +	 * will be completed by
> > > > virtblk_complete_request_with_ioerr().
> > > > > > > > > +	 */
> > > > > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * At this point, no new requests can enter the
> > > > > > > > > +queue_rq()
> > > > and
> > > > > > > > > +	 * completion routine will not complete any new requests
> > > > > > > > > +either for
> > > > > > > > the
> > > > > > > > > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > > > > > > > > +	 * started.
> > > > > > > > > +	 */
> > > > > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > > > > +				virtblk_complete_request_with_ioerr,
> > > > vblk);
> > > > > > > > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * All pending requests are cleaned up. Time to resume
> > > > > > > > > +so
> > > > that disk
> > > > > > > > > +	 * deletion can be smooth. Start the HW queues so that
> > > > > > > > > +when queue
> > > > > > > > is
> > > > > > > > > +	 * unquiesced requests can again enter the driver.
> > > > > > > > > +	 */
> > > > > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * Unquiescing will trigger dispatching any pending
> > > > > > > > > +requests
> > > > to the
> > > > > > > > > +	 * driver which has crossed bio_queue_enter() to the driver.
> > > > > > > > > +	 */
> > > > > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * Wait for all pending dispatches to terminate which
> > > > > > > > > +may
> > > > have been
> > > > > > > > > +	 * initiated after unquiescing.
> > > > > > > > > +	 */
> > > > > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > > > > +
> > > > > > > > > +	/*
> > > > > > > > > +	 * Mark the disk dead so that once we unfreeze the
> > > > > > > > > +queue,
> > > > requests
> > > > > > > > > +	 * waiting at the door of bio_queue_enter() can be
> > > > > > > > > +aborted right
> > > > > > > > away.
> > > > > > > > > +	 */
> > > > > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > > > > +
> > > > > > > > > +	/* Unfreeze the queue so that any waiting requests will
> > > > > > > > > +be
> > > > aborted. */
> > > > > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > > > > > > >  	struct virtio_blk *vblk = vdev->priv; @@ -1561,6 +1653,9
> > > > > > > > > @@ static void virtblk_remove(struct virtio_device *vdev)
> > > > > > > > >  	/* Make sure no work handler is accessing the device. */
> > > > > > > > >  	flush_work(&vblk->config_work);
> > > > > > > > >
> > > > > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > > > > +
> > > > > > > > >  	del_gendisk(vblk->disk);
> > > > > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.34.1
> > > > > > > > >

