Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C37AC636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 20:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBOUEO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBOUEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 15:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6D3A842
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 12:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676491404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIBCA+8mfuLa81n9tHgiwJiRgOIcqSdBpkKVXq8g+uI=;
        b=ITS0YnPhSpN4BkXNLa0a52vSaW2fQZwMNtCZbcHHsmlIB5ohCsJ5LtC7SYQXzuUFLOzvqW
        ox0PPdqr+Lrso/EPvy4gOKt9VfDe90Xv5hER3QwqF6jdcUpgq+LZsCbg3X5mbVUgaQd7s5
        bhdeXWiUGvsguksTXZOeTk/LmchebGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-JVzQ4KQpPGW284qI3EJTFA-1; Wed, 15 Feb 2023 15:03:20 -0500
X-MC-Unique: JVzQ4KQpPGW284qI3EJTFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A411585CBE9;
        Wed, 15 Feb 2023 20:03:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11FF6C15BA0;
        Wed, 15 Feb 2023 20:03:18 +0000 (UTC)
Date:   Wed, 15 Feb 2023 10:27:07 -0500
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
Message-ID: <Y+z5yzrOhq2nbV/A@fedora>
References: <Y+EWCwqSisu3l0Sz@T590>
 <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2a9Z9GGpeoOchf+y"
Content-Disposition: inline
In-Reply-To: <Y+wsj2QqX+HMUJTI@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--2a9Z9GGpeoOchf+y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 08:51:27AM +0800, Ming Lei wrote:
> On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> > On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> > > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > So far UBLK is only used for implementing virtual block devic=
e from
> > > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > > >=20
> > > > > > I won't be at LSF/MM so here are my thoughts:
> > > > >=20
> > > > > Thanks for the thoughts, :-)
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > It could be useful for UBLK to cover real storage hardware to=
o:
> > > > > > >=20
> > > > > > > - for fast prototype or performance evaluation
> > > > > > >=20
> > > > > > > - some network storages are attached to host, such as iscsi a=
nd nvme-tcp,
> > > > > > > the current UBLK interface doesn't support such devices, sinc=
e it needs
> > > > > > > all LUNs/Namespaces to share host resources(such as tag)
> > > > > >=20
> > > > > > Can you explain this in more detail? It seems like an iSCSI or
> > > > > > NVMe-over-TCP initiator could be implemented as a ublk server t=
oday.
> > > > > > What am I missing?
> > > > >=20
> > > > > The current ublk can't do that yet, because the interface doesn't
> > > > > support multiple ublk disks sharing single host, which is exactly
> > > > > the case of scsi and nvme.
> > > >=20
> > > > Can you give an example that shows exactly where a problem is hit?
> > > >=20
> > > > I took a quick look at the ublk source code and didn't spot a place
> > > > where it prevents a single ublk server process from handling multip=
le
> > > > devices.
> > > >=20
> > > > Regarding "host resources(such as tag)", can the ublk server deal w=
ith
> > > > that in userspace? The Linux block layer doesn't have the concept o=
f a
> > > > "host", that would come in at the SCSI/NVMe level that's implemente=
d in
> > > > userspace.
> > > >=20
> > > > I don't understand yet...
> > >=20
> > > blk_mq_tag_set is embedded into driver host structure, and referred b=
y queue
> > > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> > > that said all LUNs/NSs share host/queue tags, current every ublk
> > > device is independent, and can't shard tags.
> >=20
> > Does this actually prevent ublk servers with multiple ublk devices or is
> > it just sub-optimal?
>=20
> It is former, ublk can't support multiple devices which share single host
> because duplicated tag can be seen in host side, then io is failed.

The kernel sees two independent block devices so there is no issue
within the kernel.

Userspace can do its own hw tag allocation if there are shared storage
controller resources (e.g. NVMe CIDs) to avoid duplicating tags.

Have I missed something?

>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > - SPDK has supported user space driver for real hardware
> > > > > >=20
> > > > > > I think this could already be implemented today. There will be =
extra
> > > > > > memory copies because SPDK won't have access to the application=
's memory
> > > > > > pages.
> > > > >=20
> > > > > Here I proposed zero copy, and current SPDK nvme-pci implementati=
on haven't
> > > > > such extra copy per my understanding.
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > So propose to extend UBLK for supporting real hardware device:
> > > > > > >=20
> > > > > > > 1) extend UBLK ABI interface to support disks attached to hos=
t, such
> > > > > > > as SCSI Luns/NVME Namespaces
> > > > > > >=20
> > > > > > > 2) the followings are related with operating hardware from us=
erspace,
> > > > > > > so userspace driver has to be trusted, and root is required, =
and
> > > > > > > can't support unprivileged UBLK device
> > > > > >=20
> > > > > > Linux VFIO provides a safe userspace API for userspace device d=
rivers.
> > > > > > That means memory and interrupts are isolated. Neither userspac=
e nor the
> > > > > > hardware device can access memory or interrupts that the usersp=
ace
> > > > > > process is not allowed to access.
> > > > > >=20
> > > > > > I think there are still limitations like all memory pages expos=
ed to the
> > > > > > device need to be pinned. So effectively you might still need p=
rivileges
> > > > > > to get the mlock resource limits.
> > > > > >=20
> > > > > > But overall I think what you're saying about root and unprivile=
ged ublk
> > > > > > devices is not true. Hardware support should be developed with =
the goal
> > > > > > of supporting unprivileged userspace ublk servers.
> > > > > >=20
> > > > > > Those unprivileged userspace ublk servers cannot claim any PCI =
device
> > > > > > they want. The user/admin will need to give them permission to =
open a
> > > > > > network card, SCSI HBA, etc.
> > > > >=20
> > > > > It depends on implementation, please see
> > > > >=20
> > > > > 	https://spdk.io/doc/userspace.html
> > > > >=20
> > > > > 	```
> > > > > 	The SPDK NVMe Driver, for instance, maps the BAR for the NVMe de=
vice and
> > > > > 	then follows along with the NVMe Specification to initialize the=
 device,
> > > > > 	create queue pairs, and ultimately send I/O.
> > > > > 	```
> > > > >=20
> > > > > The above way needs userspace to operating hardware by the mapped=
 BAR,
> > > > > which can't be allowed for unprivileged user.
> > > >=20
> > > > From https://spdk.io/doc/system_configuration.html:
> > > >=20
> > > >   Running SPDK as non-privileged user
> > > >=20
> > > >   One of the benefits of using the VFIO Linux kernel driver is the
> > > >   ability to perform DMA operations with peripheral devices as
> > > >   unprivileged user. The permissions to access particular devices s=
till
> > > >   need to be granted by the system administrator, but only on a one=
-time
> > > >   basis. Note that this functionality is supported with DPDK starti=
ng
> > > >   from version 18.11.
> > > >=20
> > > > This is what I had described in my previous reply.
> > >=20
> > > My reference on spdk were mostly from spdk/nvme doc.
> > > Just take quick look at spdk code, looks both vfio and direct
> > > programming hardware are supported:
> > >=20
> > > 1) lib/nvme/nvme_vfio_user.c
> > > const struct spdk_nvme_transport_ops vfio_ops {
> > > 	.qpair_submit_request =3D nvme_pcie_qpair_submit_request,
> >=20
> > Ignore this, it's the userspace vfio-user UNIX domain socket protocol
> > support. It's not kernel VFIO and is unrelated to what we're discussing.
> > More info on vfio-user: https://spdk.io/news/2021/05/04/vfio-user/
>=20
> Not sure, why does .qpair_submit_request point to
> nvme_pcie_qpair_submit_request?

The lib/nvme/nvme_vfio_user.c code is for when SPDK connects to a
vfio-user NVMe PCI device. The vfio-user protocol support is not handled
by the regular DPDK/SPDK PCI driver APIs, so the lib/nvme/nvme_pcie.c
doesn't work with vfio-user devices.

However, a lot of the code can be shared with the regular NVMe PCI
driver and that's why .qpair_submit_request points to
nvme_pcie_qpair_submit_request instead of a special version for
vfio-user.

If the vfio-user protocol becomes more widely used for other devices
besides NVMe PCI, then I guess the DPDK/SPDK developers will figure out
a way to move the vfio-user code into the core PCI driver API so that a
single lib/nvme/nvme_pcie.c file works with all PCI APIs (kernel VFIO,
vfio-user, etc). The code was probably structured like this because it's
hard to make those changes and they wanted to get vfio-user NVMe PCI
working quickly.

>=20
> >=20
> > >=20
> > >=20
> > > 2) lib/nvme/nvme_pcie.c
> > > const struct spdk_nvme_transport_ops pcie_ops =3D {
> > > 	.qpair_submit_request =3D nvme_pcie_qpair_submit_request
> > > 		nvme_pcie_qpair_submit_tracker
> > > 			nvme_pcie_qpair_submit_tracker
> > > 				nvme_pcie_qpair_ring_sq_doorbell
> > >=20
> > > but vfio dma isn't used in nvme_pcie_qpair_submit_request, and simply
> > > write/read mmaped mmio.
> >=20
> > I have only a small amount of SPDK code experienced, so this might be
>=20
> Me too.
>=20
> > wrong, but I think the NVMe PCI driver code does not need to directly
> > call VFIO APIs. That is handled by DPDK/SPDK's EAL operating system
> > abstractions and device driver APIs.
> >=20
> > DMA memory is mapped permanently so the device driver doesn't need to
> > perform individual map/unmap operations in the data path. NVMe PCI
> > request submission builds the NVMe command structures containing device
> > addresses (i.e. IOVAs when IOMMU is enabled).
>=20
> If IOMMU isn't used, it is physical address of memory.
>=20
> Then I guess you may understand why I said this way can't be done by
> un-privileged user, cause driver is writing memory physical address to
> device register directly.
>=20
> But other driver can follow this approach if the way is accepted.

Okay, I understand now that you were thinking of non-IOMMU use cases.

Stefan

--2a9Z9GGpeoOchf+y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPs+csACgkQnKSrs4Gr
c8i5XAgAj95aaeyxyDni5BdxGLhNdFby7NGqSBE6hLk3SxUcjmdHpLrDccp7ybUF
oy9WhUZ4hWdHkrZEIKDzV1+nJeDvYmpZNR0/SWx6+Jeq+Pv7Hj6wXJmL/EWH7wPS
BqOQ8QBjYS3FiKfjGVqhHhyC2fUsP3qcXSKQM1HEb02RvXLTRvJHUV1+JelkqzeY
rJDZMG39/nEYNF0IplBo5Q6HGiEm1cP3am1FqobWMxnumPMxoJeBuxjktoVArK26
K58hnXhsjMMCuKhdUVTRyFOBlyo7J3+WIbWVjeME3ygR5px4ZgK/m9UNO2DeJH9j
IjOGHxc+0MuposxaE5O3IRRMu0T5MA==
=IQmH
-----END PGP SIGNATURE-----

--2a9Z9GGpeoOchf+y--

