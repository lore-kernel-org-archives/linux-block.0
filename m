Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC609C636CD
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 02:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBHCNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 21:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHCNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 21:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349946B9
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 18:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675822354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOM/Eo07xSKyVDol3rLVUg70MeDM5ikwhv19TTCtHQo=;
        b=gAzindDIzDufmid+J4r8XGT0zXOQLzF4Cbud5yci55iZkREH9iT3kCwysuj4Qj7Bx/B8bq
        WFvJGhwT910bgx3aRfQHI+9+/rjjuHu8QLpAeVAIl2k3aKpBQZ0pexecsv4POK19msqA0T
        wYB5wsRcSBiPQF1+m5r5kOjVCIis/kk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-YLHdGRFjOK2I80-QU3ltJg-1; Tue, 07 Feb 2023 21:12:33 -0500
X-MC-Unique: YLHdGRFjOK2I80-QU3ltJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FAAD802D19;
        Wed,  8 Feb 2023 02:12:32 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED6F318EC5;
        Wed,  8 Feb 2023 02:12:24 +0000 (UTC)
Date:   Wed, 8 Feb 2023 10:12:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y+MFAzt0Cx9aetf2@T590>
References: <Y+EWCwqSisu3l0Sz@T590>
 <Y+Finej8521IDwzV@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Finej8521IDwzV@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > So far UBLK is only used for implementing virtual block device from
> > userspace, such as loop, nbd, qcow2, ...[1].
> 
> I won't be at LSF/MM so here are my thoughts:

Thanks for the thoughts, :-)

> 
> > 
> > It could be useful for UBLK to cover real storage hardware too:
> > 
> > - for fast prototype or performance evaluation
> > 
> > - some network storages are attached to host, such as iscsi and nvme-tcp,
> > the current UBLK interface doesn't support such devices, since it needs
> > all LUNs/Namespaces to share host resources(such as tag)
> 
> Can you explain this in more detail? It seems like an iSCSI or
> NVMe-over-TCP initiator could be implemented as a ublk server today.
> What am I missing?

The current ublk can't do that yet, because the interface doesn't
support multiple ublk disks sharing single host, which is exactly
the case of scsi and nvme.

> 
> > 
> > - SPDK has supported user space driver for real hardware
> 
> I think this could already be implemented today. There will be extra
> memory copies because SPDK won't have access to the application's memory
> pages.

Here I proposed zero copy, and current SPDK nvme-pci implementation haven't
such extra copy per my understanding.

> 
> > 
> > So propose to extend UBLK for supporting real hardware device:
> > 
> > 1) extend UBLK ABI interface to support disks attached to host, such
> > as SCSI Luns/NVME Namespaces
> > 
> > 2) the followings are related with operating hardware from userspace,
> > so userspace driver has to be trusted, and root is required, and
> > can't support unprivileged UBLK device
> 
> Linux VFIO provides a safe userspace API for userspace device drivers.
> That means memory and interrupts are isolated. Neither userspace nor the
> hardware device can access memory or interrupts that the userspace
> process is not allowed to access.
> 
> I think there are still limitations like all memory pages exposed to the
> device need to be pinned. So effectively you might still need privileges
> to get the mlock resource limits.
> 
> But overall I think what you're saying about root and unprivileged ublk
> devices is not true. Hardware support should be developed with the goal
> of supporting unprivileged userspace ublk servers.
> 
> Those unprivileged userspace ublk servers cannot claim any PCI device
> they want. The user/admin will need to give them permission to open a
> network card, SCSI HBA, etc.

It depends on implementation, please see

	https://spdk.io/doc/userspace.html

	```
	The SPDK NVMe Driver, for instance, maps the BAR for the NVMe device and
	then follows along with the NVMe Specification to initialize the device,
	create queue pairs, and ultimately send I/O.
	```

The above way needs userspace to operating hardware by the mapped BAR,
which can't be allowed for unprivileged user.

> 
> > 
> > 3) how to operating hardware memory space
> > - unbind kernel driver and rebind with uio/vfio
> > - map PCI BAR into userspace[2], then userspace can operate hardware
> > with mapped user address via MMIO
> >
> > 4) DMA
> > - DMA requires physical memory address, UBLK driver actually has
> > block request pages, so can we export request SG list(each segment
> > physical address, offset, len) into userspace? If the max_segments
> > limit is not too big(<=64), the needed buffer for holding SG list
> > can be small enough.
> 
> DMA with an IOMMU requires an I/O Virtual Address, not a CPU physical
> address. The IOVA space is defined by the IOMMU page tables. Userspace
> controls the IOMMU page tables via Linux VFIO ioctls.
> 
> For example, <linux/vfio.h> struct vfio_iommu_type1_dma_map defines the
> IOMMU mapping that makes a range of userspace virtual addresses
> available at a given IOVA.
> 
> Mapping and unmapping operations are not free. Similar to mmap(2), the
> program will be slow if it does this frequently.

Yeah, but SPDK shouldn't use vfio DMA interface, see:

https://spdk.io/doc/memory.html

they just programs DMA directly with physical address of pinned hugepages.

> 
> I think it's effectively the same problem as ublk zero-copy. We want to
> give the ublk server access to just the I/O buffers that it currently
> needs, but doing so would be expensive :(.
> 
> I think Linux has strategies for avoiding the expense like
> iommu.strict=0 and swiotlb. The drawback is that in our case userspace
> and/or the hardware device controller by userspace would still have
> access to the memory pages after I/O has completed. This reduces memory
> isolation :(.
> 
> DPDK/SPDK and QEMU use long-lived Linux VFIO DMA mappings.

Per the above SPDK links, the nvme-pci doesn't use vfio dma mapping.

> 
> What I'm trying to get at is that either memory isolation is compromised
> or performance is reduced. It's hard to have good performance together
> with memory isolation.
> 
> I think ublk should follow the VFIO philosophy of being a safe
> kernel/userspace interface. If userspace is malicious or buggy, the
> kernel's and other process' memory should not be corrupted.

It is tradeoff between performance and isolation, that is why I mention
that directing programming hardware in userspace can be done by root
only.

> 
> > 
> > - small amount of physical memory for using as DMA descriptor can be
> > pre-allocated from userspace, and ask kernel to pin pages, then still
> > return physical address to userspace for programming DMA
> 
> I think this is possible today. The ublk server owns the I/O buffers. It
> can mlock them and DMA map them via VFIO. ublk doesn't need to know
> anything about this.

It depends on if such VFIO DMA mapping is required for each IO. If it
is required, that won't help one high performance driver.

> 
> > - this way is still zero copy
> 
> True zero-copy would be when an application does O_DIRECT I/O and the
> hardware device DMAs to/from the application's memory pages. ublk
> doesn't do that today and when combined with VFIO it doesn't get any
> easier. I don't think it's possible because you cannot allow userspace
> to control a hardware device and grant DMA access to pages that
> userspace isn't allowed to access. A malicious userspace will program
> the device to access those pages :).

But that should be what SPDK nvme/pci is doing per the above links, :-)

> 
> > 
> > 5) notification from hardware: interrupt or polling
> > - SPDK applies userspace polling, this way is doable, but
> > eat CPU, so it is only one choice
> > 
> > - io_uring command has been proved as very efficient, if io_uring
> > command is applied(similar way with UBLK for forwarding blk io
> > command from kernel to userspace) to uio/vfio for delivering interrupt,
> > which should be efficient too, given batching processes are done after
> > the io_uring command is completed
> 
> I wonder how much difference there is between the new io_uring command
> for receiving VFIO irqs that you are suggesting compared to the existing
> io_uring approach IORING_OP_READ eventfd.

eventfd needs extra read/write on the event fd, so more syscalls are
required.

> 
> > - or it could be flexible by hybrid interrupt & polling, given
> > userspace single pthread/queue implementation can retrieve all
> > kinds of inflight IO info in very cheap way, and maybe it is likely
> > to apply some ML model to learn & predict when IO will be completed
> 
> Stefano Garzarella and I have discussed but not yet attempted to add a
> userspace memory polling command to io_uring. IORING_OP_POLL_MEMORY
> would be useful together with IORING_SETUP_IOPOLL. That way kernel
> polling can be combined with userspace polling on a single CPU.

Here I meant the direct polling on mmio or DMA descriptor, so no
need any syscall:

https://spdk.io/doc/userspace.html

```
Polling an NVMe device is fast because only host memory needs to be
read (no MMIO) to check a queue pair for a bit flip and technologies such
as Intel's DDIO will ensure that the host memory being checked is present
in the CPU cache after an update by the device.
```

With the above mentioned direct programming DMA & this kind of polling,
handling IO won't require any syscall, but the userspace has to be
trusted.

> 
> I'm not sure it's useful for ublk because you may not have any reason to
> use IORING_SETUP_IOPOLL. But applications that have an Linux NVMe block

I think it is reasonable for ublk to poll target io, which isn't different
with other polling cases, which should help network recv, IMO.

So ublk is going to support io polling for target io only, but
can't be done for io command.



Thanks, 
Ming

