Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9006BC636D3
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 20:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBFU2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 15:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBFU2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 15:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EDF1EBCB
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 12:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675715237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=21MdfgLU4MDJKkLed4d5FtEI3hBnyD7/nVTv+YdAiEk=;
        b=fEQ/Ocs79nJfBGgBqtCVH6NOiywWaVrJUHJqX2Vy00MQNlBrjakcBtg0sqJ4Swx0bCQOBN
        wO5cP39As1Nhv1iQC7qfWPcUHkO6V2OtyiKS/6uFlrRTVzeXBc7BAUPfnmrqk6pxZH9SWF
        /RSnapscYsfUL1hf2eRKFAXVRxzW45c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-EsZkLU69MrurOnxdt9j3Gw-1; Mon, 06 Feb 2023 15:27:13 -0500
X-MC-Unique: EsZkLU69MrurOnxdt9j3Gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECE55811E9C;
        Mon,  6 Feb 2023 20:27:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 293302166B29;
        Mon,  6 Feb 2023 20:27:10 +0000 (UTC)
Date:   Mon, 6 Feb 2023 15:27:09 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y+Finej8521IDwzV@fedora>
References: <Y+EWCwqSisu3l0Sz@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WzfuwvhnYEVCI/tz"
Content-Disposition: inline
In-Reply-To: <Y+EWCwqSisu3l0Sz@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--WzfuwvhnYEVCI/tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> Hello,
>=20
> So far UBLK is only used for implementing virtual block device from
> userspace, such as loop, nbd, qcow2, ...[1].

I won't be at LSF/MM so here are my thoughts:

>=20
> It could be useful for UBLK to cover real storage hardware too:
>=20
> - for fast prototype or performance evaluation
>=20
> - some network storages are attached to host, such as iscsi and nvme-tcp,
> the current UBLK interface doesn't support such devices, since it needs
> all LUNs/Namespaces to share host resources(such as tag)

Can you explain this in more detail? It seems like an iSCSI or
NVMe-over-TCP initiator could be implemented as a ublk server today.
What am I missing?

>=20
> - SPDK has supported user space driver for real hardware

I think this could already be implemented today. There will be extra
memory copies because SPDK won't have access to the application's memory
pages.

>=20
> So propose to extend UBLK for supporting real hardware device:
>=20
> 1) extend UBLK ABI interface to support disks attached to host, such
> as SCSI Luns/NVME Namespaces
>=20
> 2) the followings are related with operating hardware from userspace,
> so userspace driver has to be trusted, and root is required, and
> can't support unprivileged UBLK device

Linux VFIO provides a safe userspace API for userspace device drivers.
That means memory and interrupts are isolated. Neither userspace nor the
hardware device can access memory or interrupts that the userspace
process is not allowed to access.

I think there are still limitations like all memory pages exposed to the
device need to be pinned. So effectively you might still need privileges
to get the mlock resource limits.

But overall I think what you're saying about root and unprivileged ublk
devices is not true. Hardware support should be developed with the goal
of supporting unprivileged userspace ublk servers.

Those unprivileged userspace ublk servers cannot claim any PCI device
they want. The user/admin will need to give them permission to open a
network card, SCSI HBA, etc.

>=20
> 3) how to operating hardware memory space
> - unbind kernel driver and rebind with uio/vfio
> - map PCI BAR into userspace[2], then userspace can operate hardware
> with mapped user address via MMIO
>
> 4) DMA
> - DMA requires physical memory address, UBLK driver actually has
> block request pages, so can we export request SG list(each segment
> physical address, offset, len) into userspace? If the max_segments
> limit is not too big(<=3D64), the needed buffer for holding SG list
> can be small enough.

DMA with an IOMMU requires an I/O Virtual Address, not a CPU physical
address. The IOVA space is defined by the IOMMU page tables. Userspace
controls the IOMMU page tables via Linux VFIO ioctls.

For example, <linux/vfio.h> struct vfio_iommu_type1_dma_map defines the
IOMMU mapping that makes a range of userspace virtual addresses
available at a given IOVA.

Mapping and unmapping operations are not free. Similar to mmap(2), the
program will be slow if it does this frequently.

I think it's effectively the same problem as ublk zero-copy. We want to
give the ublk server access to just the I/O buffers that it currently
needs, but doing so would be expensive :(.

I think Linux has strategies for avoiding the expense like
iommu.strict=3D0 and swiotlb. The drawback is that in our case userspace
and/or the hardware device controller by userspace would still have
access to the memory pages after I/O has completed. This reduces memory
isolation :(.

DPDK/SPDK and QEMU use long-lived Linux VFIO DMA mappings.

What I'm trying to get at is that either memory isolation is compromised
or performance is reduced. It's hard to have good performance together
with memory isolation.

I think ublk should follow the VFIO philosophy of being a safe
kernel/userspace interface. If userspace is malicious or buggy, the
kernel's and other process' memory should not be corrupted.

>=20
> - small amount of physical memory for using as DMA descriptor can be
> pre-allocated from userspace, and ask kernel to pin pages, then still
> return physical address to userspace for programming DMA

I think this is possible today. The ublk server owns the I/O buffers. It
can mlock them and DMA map them via VFIO. ublk doesn't need to know
anything about this.

> - this way is still zero copy

True zero-copy would be when an application does O_DIRECT I/O and the
hardware device DMAs to/from the application's memory pages. ublk
doesn't do that today and when combined with VFIO it doesn't get any
easier. I don't think it's possible because you cannot allow userspace
to control a hardware device and grant DMA access to pages that
userspace isn't allowed to access. A malicious userspace will program
the device to access those pages :).

>=20
> 5) notification from hardware: interrupt or polling
> - SPDK applies userspace polling, this way is doable, but
> eat CPU, so it is only one choice
>=20
> - io_uring command has been proved as very efficient, if io_uring
> command is applied(similar way with UBLK for forwarding blk io
> command from kernel to userspace) to uio/vfio for delivering interrupt,
> which should be efficient too, given batching processes are done after
> the io_uring command is completed

I wonder how much difference there is between the new io_uring command
for receiving VFIO irqs that you are suggesting compared to the existing
io_uring approach IORING_OP_READ eventfd.

> - or it could be flexible by hybrid interrupt & polling, given
> userspace single pthread/queue implementation can retrieve all
> kinds of inflight IO info in very cheap way, and maybe it is likely
> to apply some ML model to learn & predict when IO will be completed

Stefano Garzarella and I have discussed but not yet attempted to add a
userspace memory polling command to io_uring. IORING_OP_POLL_MEMORY
would be useful together with IORING_SETUP_IOPOLL. That way kernel
polling can be combined with userspace polling on a single CPU.

I'm not sure it's useful for ublk because you may not have any reason to
use IORING_SETUP_IOPOLL. But applications that have an Linux NVMe block
device open with IORING_SETUP_IOPOLL could use the new
IORING_OP_POLL_MEMORY command to also watch for activity on a VIRTIO or
VFIO PCI device or maybe just to get kicked by another userspace thread.

> 6) others?
>=20
>=20
>=20
> [1] https://github.com/ming1/ubdsrv
> [2] https://spdk.io/doc/userspace.html
> =20
>=20
> Thanks,=20
> Ming
>=20

--WzfuwvhnYEVCI/tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPhYp0ACgkQnKSrs4Gr
c8gsTwgAwkNH6oEvSpGOdx9DnNNdFvNT7YZ57LsDO9P37rvPheUGTEkhVCx9TJjy
F2krnbkmKSeq+SdD9FUXxNKqOHb9Y3DOl30X8fbhWgr0rzXALzInY4J1LWltad16
9rdpi+T3ZKklfuTCOtEh248XLM2e0FFr2glGJhCS24ud5mYwtvFS/AXP7Fz6VZkp
JvnZfvLothsIx5iBt/nMKwgJqTyTp7TA424D2HkeU9UAz3K4l/QlN+W1UdKotV0s
pjgkcRSp0wvnilJpCLkYIAzk3lnnrWscNowZhsO+pqqlstF0/gZ+WlMa9lAHhID+
3KM0WEK6uRbwNtckViFJAArcuXsyjQ==
=Bjad
-----END PGP SIGNATURE-----

--WzfuwvhnYEVCI/tz--

