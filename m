Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8913C636D4
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 19:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBMTxw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 14:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjBMTxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 14:53:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDFBCC2D
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676317981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1toP3Xx6dYPfLlHxPx6AV9qSyT16F0XtjTWH5NFdIms=;
        b=avItxtRkmRZ4uupzU7Ytu1rO945AmZeNMSSN5c7l9rKqg9GC41aIO02aKGsUk4rvzY4T7+
        zP0m1XvoBhkUdUSHJTeRHv68M7BgvX0x4ROci9C70U55kubdVx9DvS5R4xQYd2u6zKrC2d
        SnOWrQJqSgiQ4XkWNZszoxWXJILD0cM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-cYt83FFPPzGJMtxcRiOBuA-1; Mon, 13 Feb 2023 14:52:58 -0500
X-MC-Unique: cYt83FFPPzGJMtxcRiOBuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 342309710B4;
        Mon, 13 Feb 2023 19:52:53 +0000 (UTC)
Received: from localhost (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5187E1415108;
        Mon, 13 Feb 2023 19:52:51 +0000 (UTC)
Date:   Mon, 13 Feb 2023 14:13:59 -0500
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
Message-ID: <Y+qL9z7rtApszoBf@fedora>
References: <Y+EWCwqSisu3l0Sz@T590>
 <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/tN0SRkonO6+O07N"
Content-Disposition: inline
In-Reply-To: <Y+my03K5MbSSRvQq@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--/tN0SRkonO6+O07N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > > > > Hello,
> > > > >=20
> > > > > So far UBLK is only used for implementing virtual block device fr=
om
> > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > >=20
> > > > I won't be at LSF/MM so here are my thoughts:
> > >=20
> > > Thanks for the thoughts, :-)
> > >=20
> > > >=20
> > > > >=20
> > > > > It could be useful for UBLK to cover real storage hardware too:
> > > > >=20
> > > > > - for fast prototype or performance evaluation
> > > > >=20
> > > > > - some network storages are attached to host, such as iscsi and n=
vme-tcp,
> > > > > the current UBLK interface doesn't support such devices, since it=
 needs
> > > > > all LUNs/Namespaces to share host resources(such as tag)
> > > >=20
> > > > Can you explain this in more detail? It seems like an iSCSI or
> > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
> > > > What am I missing?
> > >=20
> > > The current ublk can't do that yet, because the interface doesn't
> > > support multiple ublk disks sharing single host, which is exactly
> > > the case of scsi and nvme.
> >=20
> > Can you give an example that shows exactly where a problem is hit?
> >=20
> > I took a quick look at the ublk source code and didn't spot a place
> > where it prevents a single ublk server process from handling multiple
> > devices.
> >=20
> > Regarding "host resources(such as tag)", can the ublk server deal with
> > that in userspace? The Linux block layer doesn't have the concept of a
> > "host", that would come in at the SCSI/NVMe level that's implemented in
> > userspace.
> >=20
> > I don't understand yet...
>=20
> blk_mq_tag_set is embedded into driver host structure, and referred by qu=
eue
> via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> that said all LUNs/NSs share host/queue tags, current every ublk
> device is independent, and can't shard tags.

Does this actually prevent ublk servers with multiple ublk devices or is
it just sub-optimal?

Also, is this specific to real storage hardware? I guess userspace
NVMe-over-TCP or iSCSI initiators would be affected  regardless of
whether they simply use the Sockets API (software) or userspace device
drivers (hardware).

Sorry for all these questions, I think I'm a little confused because you
said "doesn't support such devices" and I thought this discussion was
about real storage hardware. Neither of these seem to apply to the
tag_set issue.

>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > - SPDK has supported user space driver for real hardware
> > > >=20
> > > > I think this could already be implemented today. There will be extra
> > > > memory copies because SPDK won't have access to the application's m=
emory
> > > > pages.
> > >=20
> > > Here I proposed zero copy, and current SPDK nvme-pci implementation h=
aven't
> > > such extra copy per my understanding.
> > >=20
> > > >=20
> > > > >=20
> > > > > So propose to extend UBLK for supporting real hardware device:
> > > > >=20
> > > > > 1) extend UBLK ABI interface to support disks attached to host, s=
uch
> > > > > as SCSI Luns/NVME Namespaces
> > > > >=20
> > > > > 2) the followings are related with operating hardware from usersp=
ace,
> > > > > so userspace driver has to be trusted, and root is required, and
> > > > > can't support unprivileged UBLK device
> > > >=20
> > > > Linux VFIO provides a safe userspace API for userspace device drive=
rs.
> > > > That means memory and interrupts are isolated. Neither userspace no=
r the
> > > > hardware device can access memory or interrupts that the userspace
> > > > process is not allowed to access.
> > > >=20
> > > > I think there are still limitations like all memory pages exposed t=
o the
> > > > device need to be pinned. So effectively you might still need privi=
leges
> > > > to get the mlock resource limits.
> > > >=20
> > > > But overall I think what you're saying about root and unprivileged =
ublk
> > > > devices is not true. Hardware support should be developed with the =
goal
> > > > of supporting unprivileged userspace ublk servers.
> > > >=20
> > > > Those unprivileged userspace ublk servers cannot claim any PCI devi=
ce
> > > > they want. The user/admin will need to give them permission to open=
 a
> > > > network card, SCSI HBA, etc.
> > >=20
> > > It depends on implementation, please see
> > >=20
> > > 	https://spdk.io/doc/userspace.html
> > >=20
> > > 	```
> > > 	The SPDK NVMe Driver, for instance, maps the BAR for the NVMe device=
 and
> > > 	then follows along with the NVMe Specification to initialize the dev=
ice,
> > > 	create queue pairs, and ultimately send I/O.
> > > 	```
> > >=20
> > > The above way needs userspace to operating hardware by the mapped BAR,
> > > which can't be allowed for unprivileged user.
> >=20
> > From https://spdk.io/doc/system_configuration.html:
> >=20
> >   Running SPDK as non-privileged user
> >=20
> >   One of the benefits of using the VFIO Linux kernel driver is the
> >   ability to perform DMA operations with peripheral devices as
> >   unprivileged user. The permissions to access particular devices still
> >   need to be granted by the system administrator, but only on a one-time
> >   basis. Note that this functionality is supported with DPDK starting
> >   from version 18.11.
> >=20
> > This is what I had described in my previous reply.
>=20
> My reference on spdk were mostly from spdk/nvme doc.
> Just take quick look at spdk code, looks both vfio and direct
> programming hardware are supported:
>=20
> 1) lib/nvme/nvme_vfio_user.c
> const struct spdk_nvme_transport_ops vfio_ops {
> 	.qpair_submit_request =3D nvme_pcie_qpair_submit_request,

Ignore this, it's the userspace vfio-user UNIX domain socket protocol
support. It's not kernel VFIO and is unrelated to what we're discussing.
More info on vfio-user: https://spdk.io/news/2021/05/04/vfio-user/

>=20
>=20
> 2) lib/nvme/nvme_pcie.c
> const struct spdk_nvme_transport_ops pcie_ops =3D {
> 	.qpair_submit_request =3D nvme_pcie_qpair_submit_request
> 		nvme_pcie_qpair_submit_tracker
> 			nvme_pcie_qpair_submit_tracker
> 				nvme_pcie_qpair_ring_sq_doorbell
>=20
> but vfio dma isn't used in nvme_pcie_qpair_submit_request, and simply
> write/read mmaped mmio.

I have only a small amount of SPDK code experienced, so this might be
wrong, but I think the NVMe PCI driver code does not need to directly
call VFIO APIs. That is handled by DPDK/SPDK's EAL operating system
abstractions and device driver APIs.

DMA memory is mapped permanently so the device driver doesn't need to
perform individual map/unmap operations in the data path. NVMe PCI
request submission builds the NVMe command structures containing device
addresses (i.e. IOVAs when IOMMU is enabled).

This code probably supports both IOMMU (VFIO) and non-IOMMU operation.

>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > 3) how to operating hardware memory space
> > > > > - unbind kernel driver and rebind with uio/vfio
> > > > > - map PCI BAR into userspace[2], then userspace can operate hardw=
are
> > > > > with mapped user address via MMIO
> > > > >
> > > > > 4) DMA
> > > > > - DMA requires physical memory address, UBLK driver actually has
> > > > > block request pages, so can we export request SG list(each segment
> > > > > physical address, offset, len) into userspace? If the max_segments
> > > > > limit is not too big(<=3D64), the needed buffer for holding SG li=
st
> > > > > can be small enough.
> > > >=20
> > > > DMA with an IOMMU requires an I/O Virtual Address, not a CPU physic=
al
> > > > address. The IOVA space is defined by the IOMMU page tables. Usersp=
ace
> > > > controls the IOMMU page tables via Linux VFIO ioctls.
> > > >=20
> > > > For example, <linux/vfio.h> struct vfio_iommu_type1_dma_map defines=
 the
> > > > IOMMU mapping that makes a range of userspace virtual addresses
> > > > available at a given IOVA.
> > > >=20
> > > > Mapping and unmapping operations are not free. Similar to mmap(2), =
the
> > > > program will be slow if it does this frequently.
> > >=20
> > > Yeah, but SPDK shouldn't use vfio DMA interface, see:
> > >=20
> > > https://spdk.io/doc/memory.html
> > >=20
> > > they just programs DMA directly with physical address of pinned hugep=
ages.
> >=20
> > From the page you linked:
> >=20
> >   IOMMU Support
> >=20
> >   ...
> >=20
> >   This is a future-proof, hardware-accelerated solution for performing
> >   DMA operations into and out of a user space process and forms the
> >   long-term foundation for SPDK and DPDK's memory management strategy.
> >   We highly recommend that applications are deployed using vfio and the
> >   IOMMU enabled, which is fully supported today.
> >=20
> > Yes, SPDK supports running without IOMMU, but they recommend running
> > with the IOMMU.
> >=20
> > >=20
> > > >=20
> > > > I think it's effectively the same problem as ublk zero-copy. We wan=
t to
> > > > give the ublk server access to just the I/O buffers that it current=
ly
> > > > needs, but doing so would be expensive :(.
> > > >=20
> > > > I think Linux has strategies for avoiding the expense like
> > > > iommu.strict=3D0 and swiotlb. The drawback is that in our case user=
space
> > > > and/or the hardware device controller by userspace would still have
> > > > access to the memory pages after I/O has completed. This reduces me=
mory
> > > > isolation :(.
> > > >=20
> > > > DPDK/SPDK and QEMU use long-lived Linux VFIO DMA mappings.
> > >=20
> > > Per the above SPDK links, the nvme-pci doesn't use vfio dma mapping.
> >=20
> > When using VFIO (recommended by the docs), SPDK uses long-lived DMA
> > mappings. Here are places in the SPDK/DPDK source code where VFIO DMA
> > mapping is used:
> > https://github.com/spdk/spdk/blob/master/lib/env_dpdk/memory.c#L1371
> > https://github.com/spdk/dpdk/blob/e89c0845a60831864becc261cff48dd9321e7=
e79/lib/eal/linux/eal_vfio.c#L2164
>=20
> I meant spdk nvme implementation.

I did too. The NVMe PCI driver will use the PCI driver APIs and the EAL
(operating system abstraction) will deal with IOMMU APIs (VFIO)
transparently.

>=20
> >=20
> > >=20
> > > >=20
> > > > What I'm trying to get at is that either memory isolation is compro=
mised
> > > > or performance is reduced. It's hard to have good performance toget=
her
> > > > with memory isolation.
> > > >=20
> > > > I think ublk should follow the VFIO philosophy of being a safe
> > > > kernel/userspace interface. If userspace is malicious or buggy, the
> > > > kernel's and other process' memory should not be corrupted.
> > >=20
> > > It is tradeoff between performance and isolation, that is why I menti=
on
> > > that directing programming hardware in userspace can be done by root
> > > only.
> >=20
> > Yes, there is a trade-off. Over the years the use of unsafe approaches
> > has been discouraged and replaced (/dev/kmem, uio -> VFIO, etc). As
> > secure boot, integrity architecture, and stuff like that becomes more
> > widely used, it's harder to include features that break memory isolation
> > in software in mainstream distros. There can be an option to sacrifice
> > memory isolation for performance and some users may be willing to accept
> > the trade-off. I think it should be an option feature though.
> >=20
> > I did want to point out that the statement that "direct programming
> > hardware in userspace can be done by root only" is false (see VFIO).
>=20
> Unfortunately not see vfio is used when spdk/nvme is operating hardware
> mmio.

I think my responses above answered this, but just to be clear: with
VFIO PCI userspace mmaps the BARs and performs direct accesses to them
(load/store instructions). No VFIO API wrappers are necessary for MMIO
accesses, so the code you posted works fine with VFIO.

>=20
> >=20
> > > >=20
> > > > >=20
> > > > > - small amount of physical memory for using as DMA descriptor can=
 be
> > > > > pre-allocated from userspace, and ask kernel to pin pages, then s=
till
> > > > > return physical address to userspace for programming DMA
> > > >=20
> > > > I think this is possible today. The ublk server owns the I/O buffer=
s. It
> > > > can mlock them and DMA map them via VFIO. ublk doesn't need to know
> > > > anything about this.
> > >=20
> > > It depends on if such VFIO DMA mapping is required for each IO. If it
> > > is required, that won't help one high performance driver.
> >=20
> > It is not necessary to perform a DMA mapping for each IO. ublk's
> > existing model is sufficient:
> > 1. ublk server allocates I/O buffers and VFIO DMA maps them on startup.
> > 2. At runtime the ublk server provides these I/O buffers to the kernel,
> >    no further DMA mapping is required.
> >=20
> > Unfortunately there's still the kernel<->userspace copy that existing
> > ublk applications have, but there's no new overhead related to VFIO.
>=20
> We are working on ublk zero copy for avoiding the copy.

I'm curious if it's possible to come up with a solution that doesn't
break memory isolation. Userspace controls the IOMMU with Linux VFIO, so
if kernel pages are exposed to the device, then userspace will also be
able to access them (e.g. by submitting a request that gets the device
to DMA those pages).

>=20
> >=20
> > > >=20
> > > > > - this way is still zero copy
> > > >=20
> > > > True zero-copy would be when an application does O_DIRECT I/O and t=
he
> > > > hardware device DMAs to/from the application's memory pages. ublk
> > > > doesn't do that today and when combined with VFIO it doesn't get any
> > > > easier. I don't think it's possible because you cannot allow usersp=
ace
> > > > to control a hardware device and grant DMA access to pages that
> > > > userspace isn't allowed to access. A malicious userspace will progr=
am
> > > > the device to access those pages :).
> > >=20
> > > But that should be what SPDK nvme/pci is doing per the above links, :=
-)
> >=20
> > Sure, it's possible to break memory isolation. Breaking memory isolation
> > isn't specific to ublk servers that access hardware. The same unsafe
> > zero-copy approach would probably also work for regular ublk servers.
> > This is basically bringing back /dev/kmem :).
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > 5) notification from hardware: interrupt or polling
> > > > > - SPDK applies userspace polling, this way is doable, but
> > > > > eat CPU, so it is only one choice
> > > > >=20
> > > > > - io_uring command has been proved as very efficient, if io_uring
> > > > > command is applied(similar way with UBLK for forwarding blk io
> > > > > command from kernel to userspace) to uio/vfio for delivering inte=
rrupt,
> > > > > which should be efficient too, given batching processes are done =
after
> > > > > the io_uring command is completed
> > > >=20
> > > > I wonder how much difference there is between the new io_uring comm=
and
> > > > for receiving VFIO irqs that you are suggesting compared to the exi=
sting
> > > > io_uring approach IORING_OP_READ eventfd.
> > >=20
> > > eventfd needs extra read/write on the event fd, so more syscalls are
> > > required.
> >=20
> > No extra syscall is required because IORING_OP_READ is used to read the
> > eventfd, but maybe you were referring to bypassing the
> > file->f_op->read() code path?
>=20
> OK, missed that, it is usually done in the following way:
>=20
> 	io_uring_prep_poll_add(sqe, evfd, POLLIN)
> 	sqe->flags |=3D IOSQE_IO_LINK;
> 	...
>     sqe =3D io_uring_get_sqe(&ring);
>     io_uring_prep_readv(sqe, evfd, &vec, 1, 0);
>     sqe->flags |=3D IOSQE_IO_LINK;
>=20
> When I get time, will compare the two and see which one performs better.

That would be really interesting.

Stefan

--/tN0SRkonO6+O07N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPqi/cACgkQnKSrs4Gr
c8iDYgf/ceuTHp0TrcBFXQooF40qy1nCIJQ/dqcnqdBLZCYwKm+LxQhCzDNsToR2
Ezu/27Y5bG12MpLw5snBzMyxoLsDrNwGlMQnWzh9hVe7ZKZSLY39ajAOVPguI7Zs
Bs4Cm4FI23WpBpnV8QsAgJt/gbmFqZlVcLJSC7tkfs90qqre9Ajv3EDFveQRpO9T
lQJG1LKMN9U+ubLigeWhvIrJ2JUWi40LYphkD0qKUilbs+d84Ih0iXJZqCXw87UK
cEDQPU8vNyvsJcjCXt55QBWQotDnAIztuYB7pwX1HSUVsfm05VlCDwT41yjlVFto
Y0wzMo6ywh2QSfvZylaMw2EnOWid/Q==
=ByLj
-----END PGP SIGNATURE-----

--/tN0SRkonO6+O07N--

