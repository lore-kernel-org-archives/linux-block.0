Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B525C822
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855156; cv=none; b=YCMOboOGzlNFtQyYBKYw8qT+4NV6yvBeAKJ14v1IpJBNodJeAI2dqMzZbcr+SsmT4xBoycE/Hvd3sgB/ERex+3orjDTSlmeduOJSmq8L6R2tpXo6x4rap+3wdVf3Mo5aQoKZC2d05iPCANLJfNyoev3cYjeLB7BMCPGYDfQL3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855156; c=relaxed/simple;
	bh=+4o3PIxGblecPLXQPo7HXJT+oP1v6Y4BbGilVIDxAXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqXmRe2N962GaX5inWgc7MQ8L1evhEnDTkCtj8Awn2O37a3n+RYw40yIRPKcloYqiCREkvrfeHwDdjgP7LjFVpw7GpCfw6H7BHrAq8AHdTIoQFSE+fzaGfDQi/d8JwUcXS6dmNGDu14gh9081EI61DwAkD6UidqvTi2gnEHs64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiS3c4GK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiS3c4GK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750855154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4bNJPQhEh1mvM7sPpimO979n6aXsflGYx498uhPxi4=;
	b=UiS3c4GKnNSc+UEd7c+Npt4QWkDk5T4lyafX5dQ3LvzXgLXGTZD6e16p6S6CbLv0ZQSR2H
	XiYgkbJsnGcbHtmPfSd9kAFTS/eBVLxK1zsfQcC/LgwvWp3iaGDQ57SRMazDHfnBS4WleQ
	I6G8wwlyy1auTXqef59q1Pnznqxul6o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-pWqKB_j8MIyhtNtK8XDTPw-1; Wed, 25 Jun 2025 08:39:12 -0400
X-MC-Unique: pWqKB_j8MIyhtNtK8XDTPw-1
X-Mimecast-MFC-AGG-ID: pWqKB_j8MIyhtNtK8XDTPw_1750855151
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so453227f8f.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 05:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855151; x=1751459951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4bNJPQhEh1mvM7sPpimO979n6aXsflGYx498uhPxi4=;
        b=KIIJWahUcgUTQc8BrQsSyC2K8Ml3M7/omv4hAO4tdTaIdQHqeEo/zF6BNdQ97JPhQD
         5FrlzgPdCROatFiUVVNnSxTnFt+HrhZz22PlsnXPD/CyMNc3ISBpUtzfMmUG91FRFi2l
         pNQHzAZlK511RWaKI5m6r1ODcrQ6b4f4yjK1cKsmtkaLcokPHOqBxJZHnn8zUr9g+omS
         7Gc0qgziLW4RmIWyW0XZ/dPKcVy6jahNIwAJhMHSvsQGYrg3yPs3yZOq5Un+13pLarJ6
         tomLk21avOjf3DfmzWhd4R66g5MM/NUMPkP5/GCKK4S/pVAH+j9NKTECgsFpqqofT/Y1
         E+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVEolFlToDpIIPymNalYIU/aZ3+n+CJxYRl8ZFXg0W56MOt2PH9VyZMiWbugy2dKco6Aiggjc5j9BG6/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdPmFv3jdD+gKLr+sDvVlZmbtVC59rOtDAj+r/BQMXFzZvoYW
	ypxP4a93jTKHQRJFC6tghu2dD1oevQ3kzck5CDulKG1SCxKufq/fpqWLwM85gaHh+Db4wR2+j/I
	eQrAIrrYxPaHMjVSB/WKek7TeIyRaL3IwOldb7xiaDiei3IxRXN7amlgCSZVidqIe
X-Gm-Gg: ASbGnct9rOIX7NMyJSWwagyPo5C3tJoREC39777zr6ng0K328RNidhr4Q03pl9eLbxL
	dJ4u9dxO2Ct74Rr00TGsQQuzsMzNpzHOdd8M9FW770DkqNCeNY2Sf7pkMWF0nSwuoda+aHhny0X
	NWBsCnn3C7KyAcRkwSfiV/eS00s1eqXJZ8bK8kb8wgbg1FLGOxuW/ku5hX5/tu9EbWRDBliKeUT
	8J9t8rv1mLcgXebY7G/hfuXyV9Xv1V4SL8JOJyrmfbNOagnvJxkwyHyAcEwq4LP9flRRc/u6pnF
	uvjQZ1/vRmmQLmiR
X-Received: by 2002:a5d:588d:0:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a6e71b86f6mr6479137f8f.4.1750855151345;
        Wed, 25 Jun 2025 05:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoof/kcQj6EiHD8phskEoSt5Jd80UBJdNlsfnTMCY5+ROTqwx0M7qzM/M2LNKp+Y8Bpd1tLg==
X-Received: by 2002:a5d:588d:0:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a6e71b86f6mr6479099f8f.4.1750855150779;
        Wed, 25 Jun 2025 05:39:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823671cbsm18931125e9.29.2025.06.25.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:39:10 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:39:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org, lirongqing@baidu.com, kch@nvidia.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	jasowang@redhat.com, alok.a.tiwari@oracle.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250625083746-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624185622.GB5519@fedora>

On Tue, Jun 24, 2025 at 02:56:22PM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests may not complete
> > the device as the VQ is marked as broken. Due to this, the disk
> > deletion hangs.
> 
> There are loops in the core virtio driver code that expect device
> register reads to eventually return 0:
> drivers/virtio/virtio_pci_modern.c:vp_reset()
> drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> 
> Is there a hang if these loops are hit when a device has been surprise
> removed? I'm trying to understand whether surprise removal is fully
> supported or whether this patch is one step in that direction.
> 
> Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Is this as simple as this?

-->


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7182f43ed055..df983fa9046a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -555,8 +555,12 @@ static void vp_reset(struct virtio_device *vdev)
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_modern_get_status(mdev))
+	while (vp_modern_get_status(mdev)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 
 	vp_modern_avq_cleanup(vdev);
 
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 0d3dbfaf4b23..7177ce0d63be 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -523,11 +523,19 @@ void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 	vp_iowrite16(index, &cfg->cfg.queue_select);
 	vp_iowrite16(1, &cfg->queue_reset);
 
-	while (vp_ioread16(&cfg->queue_reset))
+	while (vp_ioread16(&cfg->queue_reset)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 
-	while (vp_ioread16(&cfg->cfg.queue_enable))
+	while (vp_ioread16(&cfg->cfg.queue_enable)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
 

