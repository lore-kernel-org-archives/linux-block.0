Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924337F313
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342990; cv=none; b=MtEgQcHZn2/RsLtMJHqtPAWmnY9anaK91ViqZYM/EodLhCdXKHz8dScZ09YyeF38Rfqmb8PTTqW4s3gFjiCQ92Q3NXjYvJnODgRCRVCn6TfsQEzCadZsEX3Hmgqhepi/IMnfg+EC6K2C3EqYpezMJcsdhpz08p4C6kNHh5Y/bYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342990; c=relaxed/simple;
	bh=CL3X1O2vNTR8rCDYsz1fgV8vYCK1Bc4ZPwJoxBwu00c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHnt9ykB0uDCPyIyp35diFJ7F0SdeJwebalgxBvI8/qrb5/zYBj7x8UrV250qTPhPi0SJ09UeHNgHPkYyTZAVWlrt+CXUrUq5MsiU42O/uPCurXmNe5YzqG3i2wNKjhZtYCVwuCE1JmyUjxJcEB56Hr+38jjkxZBDGoNX2r1dUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITx7t0Vk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l56PXJ8o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITx7t0Vk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l56PXJ8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786342988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HzXPQnozqWnPo5236EWypdZ47CBguSfl6g0bCZAQVQ4=;
	b=ITx7t0VkdU8SdayRlji5gOnUN6dDimWMN2n8kdgcc/6xml/BSlUwiZOVDSqMOCqWhaXiAT
	QcqouPBM4XFVkwb9hzx6zyHE4rP52CjGAaeoY2g1hCffjyJYcTv+lcOBN5NyusLCfCIgW1
	JMRrYqnQhDWE9+4cEl0KxB2846sGNXI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-H4mI2kkxPLqhqqWudvbKVQ-1; Mon, 10 Aug 2026 02:23:06 -0400
X-MC-Unique: H4mI2kkxPLqhqqWudvbKVQ-1
X-Mimecast-MFC-AGG-ID: H4mI2kkxPLqhqqWudvbKVQ_1786342986
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47407691804so820961f8f.1
        for <linux-block@vger.kernel.org>; Sun, 09 Aug 2026 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786342985; x=1786947785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HzXPQnozqWnPo5236EWypdZ47CBguSfl6g0bCZAQVQ4=;
        b=l56PXJ8oxEE5T+N87oDpiX8y+BaJEcfg/pHlOVAHWmLaIuc9fd1NauWhCU11Si5FWg
         GOuHYw6bHH/PsDWDBZjmG9CytzEyD4WoFzNtibo8WPVMxdX6c0ZTvfm06rBrVmpiwQPh
         poeBU7hnZbAzj9+CEs5PUZA4jTeovNy2vvKu1vfRsOeCUg8RBaAETzz1gWKvAC0Xpg/t
         mmZsy2pcJikxb43Klj//I2LYqhZ0rPWfOwJ311wVvWfkzU9Tw08pwF7GlOtp8NvtpX/M
         JTwvZ7HZRSym9XtY8Ka/5m4GORbG6XQMxEahGbl0ZKa8o8AdyFuaoyJOhwLFB/6nyaOy
         9Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786342985; x=1786947785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzXPQnozqWnPo5236EWypdZ47CBguSfl6g0bCZAQVQ4=;
        b=hFstZz3HSpIXy5lcm2RBezAY/++DvuLEEICsmT50p9KKLAkCtsnIf0st/l+CgCuBCK
         qisklpQisIpdr0IOTC6oD/L/6CaSsJDd0Di3jjqPozvRBCozpddpi5ZWwvxy6JGKaKpE
         dUlLRr90ghUY7qICOXzkJ/FwoIrfvR4jdYiWUUucFE7tkSpwph+4A8mEuMfuqy04fP9L
         FErbtWRNTnzFz31aYQvWd7OufPkLs8ndPVL3LPDLDEXbuzbL78CX342jKKKZngXCFlrn
         KmJWEWr9+2VTOYJGqVpIoI/RQv/rA06zcCLMFNl79IRyXmdoLS/e3r5QoHe7AeHLhvo+
         GtnA==
X-Forwarded-Encrypted: i=1; AHgh+RouJgdowe8PFwYqoYXA2NJxPyI7bbiipVyvh4bUHVuB1zYM8O1mnRF45+k6C4VlQoUxcTjebVHbVZplcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZ6p9oZuxzqmBK8edD9aKEFXve4DrlBEAM5Wz3CGcmzf7w6mJ
	A4af6w5H6BS24EDkqyBFDc9Vg5xmEHm6louUOee51HeU9vP2lZqGELXeG1A+Fh/m6nat0tjv+k8
	RFKMr/OgUFea7HRnkMpTCtm4cGtLr+sz5btkMy8IAfkyAe/wDN5Tc72nfK+c789CF
X-Gm-Gg: AR+sD10UUqujfrY5LXAsP8cZVOnvSNQIvnYvbM9l/EraOyunUKm3PgmTeyUzFCPr+EH
	6VAw7Y52ncooDrINFeo7JQPiFF+SXxurMFSAe6a305GmdIFXiuOGKPpz6+pZhycoIhd90E2nphO
	Ra+n15whfNSeayltqFzSCjd8fcqPShwn43PFlWT6J4XTmV+dy/Q/r218mUUBCL4F3HGGnfQCqK8
	mV8Ckk5lkA6CabTLj7JVYSDiVnTtI9lLqjy5+YsEOpyqh0sR5B3bb1eV5EDbpBdY46r/XmMLR64
	CNeSzV9edjQcViSbHnK9xRx02lkwU8I2ha/7b0HAtNNJIxzMvE3+7c2Nm9aytYRfUX03BQGFaoS
	kNIPXvaQHKYuQQRBHvNrsTw==
X-Received: by 2002:a05:6000:41d3:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-47fec628b57mr64771495f8f.15.1786342985396;
        Sun, 09 Aug 2026 23:23:05 -0700 (PDT)
X-Received: by 2002:a05:6000:41d3:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-47fec628b57mr64771414f8f.15.1786342984878;
        Sun, 09 Aug 2026 23:23:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220aa83sm26809797f8f.36.2026.08.09.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 23:23:04 -0700 (PDT)
Date: Mon, 10 Aug 2026 02:23:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
	David Airlie <airlied@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	dri-devel@lists.freedesktop.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	nvdimm@lists.linux.dev, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC PATCH 00/12] virtio: support devices that own their
 virtqueue memory
Message-ID: <20260810021450-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809182010.32931-1-graf@amazon.com>

On Sun, Aug 09, 2026 at 06:19:58PM +0000, Alexander Graf wrote:
> Virtio drivers use guest memory to back virtqueues and their buffers.
> That means a VMM needs to be able to map guest memory. That is ok in the
> normal virt case. It gets icky with confidential computing (where we use
> swiotlb as workaround) and it defeats the purpose of isolated vhost-user
> backing devices, because they end up with full RAM access to the guest.
> 
> So instead, I'm proposing an extension to virtio which allows it to give
> each virtio device its own dedicated memory region to communicate with the
> host, called DMB (Device Memory Buffer). A trusted hypervisor can force
> DMB to be present, which then enables safer, more isolated and resilient
> communication between guest and host.
> 
> With DMB, the device provides a shared memory region that both parties
> agree is the full memory map both have access to. All memory offsets
> that previously would have been into guest RAM, are then offsets into
> this shared memory buffer region. One nice property of this is that it
> is a generic mechanism in the virtio transport layer, so higher level
> drivers work unmodified.
> 
> I was exploring to use swiotlb instead to create individual pools. But
> that approach has multiple downsides:
> 
> 1. Swiotlb is an OS primitive which is not available in all Operating
> Systems. DMB however lives in the virtio transport layer, which means we
> can add support for it in any OS independent of generic layers. This
> helps with Windows support.


How does it help, if you are going to put a pool in
the driver, put a pool in the driver. Maybe with virtio mem to
simplify allocation.

> 2. We munge DMA space together. DMB provides a separate DMA space per
> virtio device. This means we can for example implement a device in
> vhost-user and give the implementing process only visibility to the DMB
> region, not all of guest memory. That reduces the exposure the
> vhost-user provider has, improving security.
> 
> 3. Devices can opt-in. A hypervisor can choose to use standard virtio
> semantics for self-implemented devices (e.g. NSM), while requiring DMB
> for devices implemented by less trustworthy providers. The
> non-trustworthy devices do not get any visibility into the trustworthy
> ones, even with DMB in place for both.



So I am not sure whether the implication is that it's purely a software
construct. But if it is, can we extend virtio iommu to
add a way to discover and enforce trust boundaries?
And maybe translate offsets to BARs, if that is desired?



It seems to be that the result would be that we don't need fiddly
special casing in virtio ring specifically, and a lot of things like
pre-mapped dma will begin to work.



> == Limitations ==
> 
>   - Only PCI is wired up.
>   - Feature bit 44 and the shared memory id register at offset 0x40 of the
>     PCI common configuration are provisional: the OASIS technical
>     committee has the specification and has allocated neither.
> 
>   https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
> 
>   - The device I ran this against is not public, so you cannot reproduce
>     the numbers below. The KUnit test you can.
> 
> == Testing ==
> 
> Without patches 10 and 12 a receive refill livelocks and queues starve
> each other: 29,319,791 receive softirqs in five seconds with not one
> packet received, against 4 with them, and 2 of 7 receive queues that never
> see a buffer, against none. Earlier revisions moved 512 MiB of O_DIRECT
> block I/O and 2.7 GB of verified vsock through a region with no error.
> 
> The KUnit test for patch 12's guarantee you can run yourself, and two of
> its five cases fail if I take the fix out:
> 
>   tools/testing/kunit/kunit.py run --arch=x86_64 \
>       --kconfig_add CONFIG_VIRTIO_MMIO=y \
>       --kconfig_add CONFIG_VIRTIO_DMB=y virtio_dmb
> 
> Patch 1 can be taken on its own: a stale worked example in a vdpa
> comment. Patch 10 fixes something older than this series too, a failed
> mapping arriving as -EIO from a packed ring, failing an I/O that on a
> split ring is only back-pressure, but it does not apply alone: it wants
> patch 2, and patch 9 for the file its documentation hunk edits. Both
> carry Fixes:. Patch 12 wants 10 first.
> 
> I wrote this series with an AI coding assistant, which drafted the code,
> the changelogs and this cover letter. I reviewed and reworked all of it,
> and every commit carries an Assisted-by: trailer.
> 
> Alex
> 
> Alexander Graf (12):
>   vdpa: correct the VIRTIO_DEVICE_F_MASK example value
>   virtio_ring: validate premapped addresses through the device's map
>   virtio: add the VIRTIO_F_DMB feature bit
>   virtio_pci: read the device memory buffer shared memory id
>   virtio_pci: create virtqueues with the device's mapping token
>   virtio: add a device memory buffer region allocator
>   virtio: locate the device memory buffer after feature negotiation
>   virtio_pci: support VIRTIO_F_DMB
>   Documentation: virtio: describe the device memory buffer
>   virtio_ring: report a bounded pool's exhaustion as -ENOSPC
>   virtio: expose device memory buffer occupancy over debugfs
>   virtio: guarantee a virtqueue can publish its first descriptor chain
> 
>  Documentation/driver-api/virtio/index.rst     |    1 +
>  .../driver-api/virtio/virtio-dmb.rst          |  803 ++++++++
>  drivers/vdpa/vdpa.c                           |    2 +-
>  drivers/virtio/Kconfig                        |   29 +
>  drivers/virtio/Makefile                       |    3 +-
>  drivers/virtio/virtio.c                       |   15 +-
>  drivers/virtio/virtio_dmb.c                   | 1719 +++++++++++++++++
>  drivers/virtio/virtio_dmb.h                   |   34 +
>  drivers/virtio/virtio_dmb_test.c              |  279 +++
>  drivers/virtio/virtio_pci_modern.c            |  100 +-
>  drivers/virtio/virtio_pci_modern_dev.c        |   23 +-
>  drivers/virtio/virtio_ring.c                  |  216 ++-
>  include/linux/virtio.h                        |    3 +
>  include/linux/virtio_config.h                 |   41 +
>  include/linux/virtio_pci_modern.h             |    1 +
>  include/uapi/linux/virtio_config.h            |   17 +-
>  include/uapi/linux/virtio_pci.h               |   10 +
>  17 files changed, 3254 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/driver-api/virtio/virtio-dmb.rst
>  create mode 100644 drivers/virtio/virtio_dmb.c
>  create mode 100644 drivers/virtio/virtio_dmb.h
>  create mode 100644 drivers/virtio/virtio_dmb_test.c
> 
> 
> base-commit: fc02acf6ac0ccde0c805c2daa9148683cdd01ba8

