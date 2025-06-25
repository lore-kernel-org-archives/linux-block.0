Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7952DAFBC
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879353; cv=none; b=SiRgzlsPYpai7s9ruQgLoCPzrzwgf8bAG0n91lmf1h7nsKKksbAAWjsIoi2UCbJRdCyH3k36MMkvNnd+rKdF0u2b+BHZDsL0jd01A6Ry/Ft+mEu6UMNo2MskUHe1tHbOYCXIWA9cl+AzIFCh0QHm9/dZuUDCegszh1PIrNYWCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879353; c=relaxed/simple;
	bh=TZukVxz12wAawGzxfjF0nOuecD24OP44dEwoMUeVK04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1mgnift8FxuHhq2q5Zu8WRFHrBRjqToHsh4LlMrHROl7FExcQTKSqUuZqaXQZ/dANOWDcJUJPOYRUAoES6CnQbhG5VYtQXGhPIm2BFDnn8A7G63m5Iz7M8tp6TAxHayffaC//L9Wm+sVNIDuCoR9aXeGMhBLOZp86l5ubISRdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ip23sjfQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ip23sjfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750879349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmbbdvGGUch83jcvDLzRPMQ1v479H1xLF+wdT1WqzfU=;
	b=Ip23sjfQNB2PQDUuTE+xtFkLbibpiHCrHMImizMN9Gmss+ElCqWf26JgV66VtO80zaKrut
	fW0ClCYjzP/qQeFSLZhfjPVcF0fCFz5thx9WXD+v4Lf9FgicESG8ygA0Welo9veTQYOoV/
	PxBUsfr3IBtD4VXs0M6LloKVhsW92l8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-hI4Vso3QN4uQpVT9Ahm2Xg-1; Wed, 25 Jun 2025 15:22:26 -0400
X-MC-Unique: hI4Vso3QN4uQpVT9Ahm2Xg-1
X-Mimecast-MFC-AGG-ID: hI4Vso3QN4uQpVT9Ahm2Xg_1750879345
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso69200f8f.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 12:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750879345; x=1751484145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmbbdvGGUch83jcvDLzRPMQ1v479H1xLF+wdT1WqzfU=;
        b=WvMapxlVrjjDkYUVhBpaQCZSP8kI3E/y2maaQAqvi7JU4NCeyejUjj1qqUdhYZJt2R
         +CDKKtHK2lWSctENTx6+So5aFY4YFzELnCnd+jkFSYVQeg5lBeEkHMr5t0buH4VzRWLM
         l6dyFTG2cIVAMXAfDjXlPhS6rvr4TlRS3Z+xSfswXR3ngYNRcvdeRBPC13sPxnUkc6Si
         yPtJmAPYF0vMEPXKPhzpVAn6G36Qz+Q51a2RD0ETgvenCQZpY2Ft/BGor1Jd9z06g3G6
         9J9GvDimQMP1kRGhhlNvllSkvgzYAy2UEZXQm0rI8KXq1bgw5+Jm07uZMWorq2HF/KcW
         eJig==
X-Forwarded-Encrypted: i=1; AJvYcCULT6lRevMbTD/6gVZmFL97eBhWuQS2rl31FMdd6J3sOQCrBFd4j1BBS3+jDZAOY2/OiIZYCNy7TLt1Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4AU7FE/lil/bsHulYETH2KWxFuwCAhnGCR8qdRT7Ga6tux1+
	k6qQNKJZ0oKdDVXL4Gsvg5ygfMI6U/FzrOOf5d2sksqJ5Xl/ljsmPWHe1syupWx4Nm+Kib+mWxA
	1VUncCjpJHMdK6Vas+FVT2qoyFCVrKvPTOLLCVLjcyDBDJ9CSBqzr3P0k0hNaD2Mt
X-Gm-Gg: ASbGnctkLYDRpBGVwSjCpTJHNjmj1B32X9EXW8Rv5f0l9U3WJBSBUQXh7adRowuIYtj
	frKBuX1JxQSwrgOreQc4NtyZARC+G3huNAraf5d965EXqW44g9NyhiqGPmzgsl1kea3CikMn5Pl
	KcU5W833LpWAY39trYeL4g1hSPl8q4lUqCUbMD60XA8jpYLRFkyeNgoUKC2KKV/VKi5c+nlsSUB
	ZMI6BUb5v95F+vBf50gz0n5H8x4UvhOAaaADFl/uaeuLOOAxH0sTBGBhZL6JawzTbhB10aumwKQ
	DeKhUeZh5Ck2Sqwv
X-Received: by 2002:a05:6000:4a04:b0:3a5:8934:b10d with SMTP id ffacd0b85a97d-3a6ed61a578mr3935140f8f.10.1750879345034;
        Wed, 25 Jun 2025 12:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxYcFdTsBU4eLFsXdwdUZ5HU/I95PFaxHHbWivb37BifiJ+hE4e5lF6GxTG0qDS1BQf+dwfw==
X-Received: by 2002:a05:6000:4a04:b0:3a5:8934:b10d with SMTP id ffacd0b85a97d-3a6ed61a578mr3935122f8f.10.1750879344525;
        Wed, 25 Jun 2025 12:22:24 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382373c6esm28803835e9.34.2025.06.25.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 12:22:24 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:22:21 -0400
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
Message-ID: <20250625151732-mutt-send-email-mst@kernel.org>
References: <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, Jun 25, 2025 at 07:08:54PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 25 June 2025 05:15 PM
> > 
> > On Wed, Jun 25, 2025 at 11:08:42AM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 25 June 2025 04:34 PM
> > > >
> > > > On Wed, Jun 25, 2025 at 02:55:27AM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: 25 June 2025 01:24 AM
> > > > > >
> > > > > > On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> > > > > > >
> > > > > > >
> > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > Sent: 25 June 2025 12:37 AM
> > > > > > > >
> > > > > > > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > > > Sent: 25 June 2025 12:26 AM
> > > > > > > > > >
> > > > > > > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit
> > wrote:
> > > > > > > > > > > When the PCI device is surprise removed, requests may
> > > > > > > > > > > not complete the device as the VQ is marked as broken.
> > > > > > > > > > > Due to this, the disk deletion hangs.
> > > > > > > > > >
> > > > > > > > > > There are loops in the core virtio driver code that
> > > > > > > > > > expect device register reads to eventually return 0:
> > > > > > > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > > > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_que
> > > > > > > > > > ue_r
> > > > > > > > > > eset
> > > > > > > > > > ()
> > > > > > > > > >
> > > > > > > > > > Is there a hang if these loops are hit when a device has
> > > > > > > > > > been surprise removed? I'm trying to understand whether
> > > > > > > > > > surprise removal is fully supported or whether this
> > > > > > > > > > patch is one step in that
> > > > > > direction.
> > > > > > > > > >
> > > > > > > > > In one of the previous replies I answered to Michael, but
> > > > > > > > > don't have the link
> > > > > > > > handy.
> > > > > > > > > It is not fully supported by this patch. It will hang.
> > > > > > > > >
> > > > > > > > > This patch restores driver back to the same state what it
> > > > > > > > > was before the fixes
> > > > > > > > tag patch.
> > > > > > > > > The virtio stack level work is needed to support surprise
> > > > > > > > > removal, including
> > > > > > > > the reset flow you rightly pointed.
> > > > > > > >
> > > > > > > > Have plans to do that?
> > > > > > > >
> > > > > > > Didn't give enough thoughts on it yet.
> > > > > >
> > > > > > This one is kind of pointless then? It just fixes the specific
> > > > > > race window that your test harness happens to hit?
> > > > > >
> > > > > It was reported by Li from Baidu, whose tests failed.
> > > > > I missed to tag "reported-by" in v5. I had it until v4. :(
> > > > >
> > > > > > Maybe it's better to wait until someone does a comprehensive fix..
> > > > > >
> > > > > >
> > > > > Oh, I was under impression is that you wanted to step forward in
> > > > > discussion
> > > > of v4.
> > > > > If you prefer a comprehensive support across layers of virtio, I
> > > > > suggest you
> > > > should revert the cited patch in fixes tag.
> > > > >
> > > > > Otherwise, it is in degraded state as virtio never supported surprise
> > removal.
> > > > > By reverting the cited patch (or with this fix), the requests and
> > > > > disk deletion
> > > > will not hang.
> > > >
> > > > But they will hung in virtio core on reset, will they not? The tests
> > > > just do not happen to trigger this?
> > > >
> > > It will hang if it a true surprise removal which no device did so far because it
> > never worked.
> > > (or did, but always hung that no one reported yet)
> > >
> > > I am familiar with 2 or more PCI devices who reports surprise removal,
> > which do not complete the requests but yet allows device reset flow.
> > > This is because device is still there on the PCI bus. Only via side band signals
> > device removal was reported.
> > 
> > So why do we care about it so much? I think it's great this patch exists, for
> > example it makes it easier to test surprise removal and find more bugs. But is
> > it better to just have it hang unconditionally? Are we now making a
> > commitment that it's working - one we don't seem to intend to implement?
> >
> The patch improves the situation from its current state.
> But as you posted, more changes in pci layer are needed.
> I didn't audit where else it may be needed.
> 
> vp_reset() may need to return the status back of successful/failure reset.
> Otherwise during probe(), vp_reset() aborts the reset and attempts to load the driver for removed device.

yes however this is not at all different that hotunplug right after
reset.

> I guess suspend() callback also infinitely waits during freezing the queue also needs adaptation.

Which callback is that I don't understand.


> > > But I agree that for full support, virtio all layer changes would be needed as
> > new functionality (without fixes tag  :) ).
> > 
> > 
> > Or with a fixes tag - lots of people just use it as a signal to mean "where can
> > this be reasonably backported to".
> >
> Yes, I think the fix for the older kernels is needed, hence I cced stable too.
>  
> > 
> > > > > Please let me know if I should re-send to revert the patch listed in fixes
> > tag.
> > > > >
> > > > > > > > > > Apart from that, I'm happy with the virtio_blk.c aspects
> > > > > > > > > > of the
> > > > patch:
> > > > > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > > > > > > >
> > > > > > > > > > > With this fix now fio completes swiftly.
> > > > > > > > > > > An alternative of IO timeout has been considered,
> > > > > > > > > > > however when the driver knows about unresponsive block
> > > > > > > > > > > device, swiftly clearing them enables users and upper
> > > > > > > > > > > layers to react
> > > > quickly.
> > > > > > > > > > >
> > > > > > > > > > > Verified with multiple device unplug iterations with
> > > > > > > > > > > pending requests in virtio used ring and some pending
> > > > > > > > > > > with the
> > > > device.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > > > > > > > removal of virtio pci device")
> > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > > > > > > > Closes:
> > > > > > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd472
> > > > > > > > > > > 38c5
> > > > > > > > > > > 5fb7
> > > > > > > > > > > 3ca9
> > > > > > > > > > > b474
> > > > > > > > > > > 1@baidu.com/
> > > > > > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > v4->v5:
> > > > > > > > > > > - fixed comment style where comment to start with one
> > > > > > > > > > > empty line at start
> > > > > > > > > > > - Addressed comments from Alok
> > > > > > > > > > > - fixed typo in broken vq check
> > > > > > > > > > > v3->v4:
> > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > - renamed virtblk_request_cancel() to
> > > > > > > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > > > > > > - Added comments for
> > > > > > > > > > > virtblk_complete_request_with_ioerr()
> > > > > > > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > > > > > > >   virtblk_cleanup_broken_device()
> > > > > > > > > > > - Added comments for virtblk_cleanup_broken_device()
> > > > > > > > > > > - Moved the broken vq check in virtblk_remove()
> > > > > > > > > > > - Fixed comment style to have first empty line
> > > > > > > > > > > - replaced freezed to frozen
> > > > > > > > > > > - Fixed comments rephrased
> > > > > > > > > > >
> > > > > > > > > > > v2->v3:
> > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > - updated comment for synchronizing with callbacks
> > > > > > > > > > >
> > > > > > > > > > > v1->v2:
> > > > > > > > > > > - Addressed comments from Stephan
> > > > > > > > > > > - fixed spelling to 'waiting'
> > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > - Dropped checking broken vq from queue_rq() and
> > queue_rqs()
> > > > > > > > > > >   because it is checked in lower layer routines in
> > > > > > > > > > > virtio core
> > > > > > > > > > >
> > > > > > > > > > > v0->v1:
> > > > > > > > > > > - Fixed comments from Stefan to rename a cleanup
> > > > > > > > > > > function
> > > > > > > > > > > - Improved logic for handling any outstanding requests
> > > > > > > > > > >   in bio layer
> > > > > > > > > > > - improved cancel callback to sync with ongoing done()
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > >  1 file changed, 95 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > > > > > b/drivers/block/virtio_blk.c index
> > > > > > > > > > > 7cffea01d868..c5e383c0ac48
> > > > > > > > > > > 100644
> > > > > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > > > > > > > > virtio_device
> > > > > > > > > > *vdev)
> > > > > > > > > > >  	return err;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +/*
> > > > > > > > > > > + * If the vq is broken, device will not complete requests.
> > > > > > > > > > > + * So we do it for the device.
> > > > > > > > > > > + */
> > > > > > > > > > > +static bool
> > > > > > > > > > > +virtblk_complete_request_with_ioerr(struct
> > > > > > > > > > > +request *rq, void *data) {
> > > > > > > > > > > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
> > > > > > > > > > > +	struct virtio_blk *vblk = data;
> > > > > > > > > > > +	struct virtio_blk_vq *vq;
> > > > > > > > > > > +	unsigned long flags;
> > > > > > > > > > > +
> > > > > > > > > > > +	vq = &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > > > > > > +
> > > > > > > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > > > > > > +
> > > > > > > > > > > +	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
> > > > > > > > > > > +	if (blk_mq_request_started(rq) &&
> > > > > > !blk_mq_request_completed(rq))
> > > > > > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > > > > > +
> > > > > > > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > > > > > > +	return true;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +/*
> > > > > > > > > > > + * If the device is broken, it will not use any
> > > > > > > > > > > +buffers and waiting
> > > > > > > > > > > + * for that to happen is pointless. We'll do the
> > > > > > > > > > > +cleanup in the driver,
> > > > > > > > > > > + * completing all requests for the device.
> > > > > > > > > > > + */
> > > > > > > > > > > +static void virtblk_cleanup_broken_device(struct
> > > > > > > > > > > +virtio_blk *vblk)
> > > > {
> > > > > > > > > > > +	struct request_queue *q = vblk->disk->queue;
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * Start freezing the queue, so that new requests
> > > > > > > > > > > +keeps
> > > > > > waiting at the
> > > > > > > > > > > +	 * door of bio_queue_enter(). We cannot fully freeze
> > > > > > > > > > > +the queue
> > > > > > > > > > because
> > > > > > > > > > > +	 * frozen queue is an empty queue and there are
> > > > > > > > > > > +pending
> > > > > > requests, so
> > > > > > > > > > > +	 * only start freezing it.
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	blk_freeze_queue_start(q);
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * When quiescing completes, all ongoing dispatches
> > > > > > > > > > > +have
> > > > > > completed
> > > > > > > > > > > +	 * and no new dispatch will happen towards the
> > driver.
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * Synchronize with any ongoing VQ callbacks that
> > > > > > > > > > > +may have
> > > > > > started
> > > > > > > > > > > +	 * before the VQs were marked as broken. Any
> > > > > > > > > > > +outstanding
> > > > > > requests
> > > > > > > > > > > +	 * will be completed by
> > > > > > virtblk_complete_request_with_ioerr().
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * At this point, no new requests can enter the
> > > > > > > > > > > +queue_rq()
> > > > > > and
> > > > > > > > > > > +	 * completion routine will not complete any new
> > > > > > > > > > > +requests either for
> > > > > > > > > > the
> > > > > > > > > > > +	 * broken vq. Hence, it is safe to cancel all requests
> > which are
> > > > > > > > > > > +	 * started.
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > > > > > > +
> > 	virtblk_complete_request_with_ioerr,
> > > > > > vblk);
> > > > > > > > > > > +
> > > > > > > > > > > +blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * All pending requests are cleaned up. Time to
> > > > > > > > > > > +resume so
> > > > > > that disk
> > > > > > > > > > > +	 * deletion can be smooth. Start the HW queues so
> > > > > > > > > > > +that when queue
> > > > > > > > > > is
> > > > > > > > > > > +	 * unquiesced requests can again enter the driver.
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * Unquiescing will trigger dispatching any pending
> > > > > > > > > > > +requests
> > > > > > to the
> > > > > > > > > > > +	 * driver which has crossed bio_queue_enter() to the
> > driver.
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * Wait for all pending dispatches to terminate
> > > > > > > > > > > +which may
> > > > > > have been
> > > > > > > > > > > +	 * initiated after unquiescing.
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > > > > > > +
> > > > > > > > > > > +	/*
> > > > > > > > > > > +	 * Mark the disk dead so that once we unfreeze the
> > > > > > > > > > > +queue,
> > > > > > requests
> > > > > > > > > > > +	 * waiting at the door of bio_queue_enter() can be
> > > > > > > > > > > +aborted right
> > > > > > > > > > away.
> > > > > > > > > > > +	 */
> > > > > > > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > > > > > > +
> > > > > > > > > > > +	/* Unfreeze the queue so that any waiting requests
> > > > > > > > > > > +will be
> > > > > > aborted. */
> > > > > > > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > > > > > > > > >  	struct virtio_blk *vblk = vdev->priv; @@ -1561,6
> > > > > > > > > > > +1653,9 @@ static void virtblk_remove(struct virtio_device
> > *vdev)
> > > > > > > > > > >  	/* Make sure no work handler is accessing the device.
> > */
> > > > > > > > > > >  	flush_work(&vblk->config_work);
> > > > > > > > > > >
> > > > > > > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > > > > > > +
> > > > > > > > > > >  	del_gendisk(vblk->disk);
> > > > > > > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > 2.34.1
> > > > > > > > > > >

