Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E43C6FD1F
	for <linux-block@archiver.kernel.org>; Thu, 16 Mar 2023 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCPOZi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCPOZh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 10:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56333B53CF
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678976692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlU0VIZTxbUnw6ta2XILXCFOUxMiwfJQmlzuOkfTnno=;
        b=Rl3zPq5QNxT5aiFP7R48eGrlOKJ5KjoEL9AC45qKfB2xlBEp4r8j2EMft6IPVFhQ0AM58m
        gx/CPDGAipm6SEoddwt2ZPw/Dre3hGFMSqDUV+I+Y17Q21YCaa9Tg8VDIOk7o+BdEmc3bg
        XivYcESqO40eNw9gDyvYaDWcAIntQqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-YmrcPXGjP9a2UlLzljs92g-1; Thu, 16 Mar 2023 10:24:49 -0400
X-MC-Unique: YmrcPXGjP9a2UlLzljs92g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E6C3185A790;
        Thu, 16 Mar 2023 14:24:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81F0840C6E67;
        Thu, 16 Mar 2023 14:24:47 +0000 (UTC)
Date:   Thu, 16 Mar 2023 10:24:46 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <20230316142446.GC42060@fedora>
References: <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
 <Y++t3kYTSNo9Sbb5@fedora>
 <Y/C1CVFceZ+X0ECa@T590>
 <Y/EbEGV2Ege51RQZ@fedora>
 <Y/aijeTJ2HuITMc1@T590>
 <Y/fKC7/cTM2mpz3H@fedora>
 <ZAAWj8Bs8JujXsbX@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u+2iSFscRkUssHp2"
Content-Disposition: inline
In-Reply-To: <ZAAWj8Bs8JujXsbX@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--u+2iSFscRkUssHp2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 11:22:55AM +0800, Ming Lei wrote:
> On Thu, Feb 23, 2023 at 03:18:19PM -0500, Stefan Hajnoczi wrote:
> > On Thu, Feb 23, 2023 at 07:17:33AM +0800, Ming Lei wrote:
> > > On Sat, Feb 18, 2023 at 01:38:08PM -0500, Stefan Hajnoczi wrote:
> > > > On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrote:
> > > > > On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi wrote:
> > > > > > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> > > > > > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wr=
ote:
> > > > > > > >=20
> > > > > > > > Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > >=20
> > > > > > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindbor=
g wrote:
> > > > > > > > >>=20
> > > > > > > > >> Hi Ming,
> > > > > > > > >>=20
> > > > > > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > > >>=20
> > > > > > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajno=
czi wrote:
> > > > > > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wr=
ote:
> > > > > > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Ha=
jnoczi wrote:
> > > > > > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Le=
i wrote:
> > > > > > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefa=
n Hajnoczi wrote:
> > > > > > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Min=
g Lei wrote:
> > > > > > > > >> >> > > > > > Hello,
> > > > > > > > >> >> > > > > >=20
> > > > > > > > >> >> > > > > > So far UBLK is only used for implementing v=
irtual block device from
> > > > > > > > >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > > > > > >> >> > > > >=20
> > > > > > > > >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> > > > > > > > >> >> > > >=20
> > > > > > > > >> >> > > > Thanks for the thoughts, :-)
> > > > > > > > >> >> > > >=20
> > > > > > > > >> >> > > > >=20
> > > > > > > > >> >> > > > > >=20
> > > > > > > > >> >> > > > > > It could be useful for UBLK to cover real s=
torage hardware too:
> > > > > > > > >> >> > > > > >=20
> > > > > > > > >> >> > > > > > - for fast prototype or performance evaluat=
ion
> > > > > > > > >> >> > > > > >=20
> > > > > > > > >> >> > > > > > - some network storages are attached to hos=
t, such as iscsi and nvme-tcp,
> > > > > > > > >> >> > > > > > the current UBLK interface doesn't support =
such devices, since it needs
> > > > > > > > >> >> > > > > > all LUNs/Namespaces to share host resources=
(such as tag)
> > > > > > > > >> >> > > > >=20
> > > > > > > > >> >> > > > > Can you explain this in more detail? It seems=
 like an iSCSI or
> > > > > > > > >> >> > > > > NVMe-over-TCP initiator could be implemented =
as a ublk server today.
> > > > > > > > >> >> > > > > What am I missing?
> > > > > > > > >> >> > > >=20
> > > > > > > > >> >> > > > The current ublk can't do that yet, because the=
 interface doesn't
> > > > > > > > >> >> > > > support multiple ublk disks sharing single host=
, which is exactly
> > > > > > > > >> >> > > > the case of scsi and nvme.
> > > > > > > > >> >> > >=20
> > > > > > > > >> >> > > Can you give an example that shows exactly where =
a problem is hit?
> > > > > > > > >> >> > >=20
> > > > > > > > >> >> > > I took a quick look at the ublk source code and d=
idn't spot a place
> > > > > > > > >> >> > > where it prevents a single ublk server process fr=
om handling multiple
> > > > > > > > >> >> > > devices.
> > > > > > > > >> >> > >=20
> > > > > > > > >> >> > > Regarding "host resources(such as tag)", can the =
ublk server deal with
> > > > > > > > >> >> > > that in userspace? The Linux block layer doesn't =
have the concept of a
> > > > > > > > >> >> > > "host", that would come in at the SCSI/NVMe level=
 that's implemented in
> > > > > > > > >> >> > > userspace.
> > > > > > > > >> >> > >=20
> > > > > > > > >> >> > > I don't understand yet...
> > > > > > > > >> >> >=20
> > > > > > > > >> >> > blk_mq_tag_set is embedded into driver host structu=
re, and referred by queue
> > > > > > > > >> >> > via q->tag_set, both scsi and nvme allocates tag in=
 host/queue wide,
> > > > > > > > >> >> > that said all LUNs/NSs share host/queue tags, curre=
nt every ublk
> > > > > > > > >> >> > device is independent, and can't shard tags.
> > > > > > > > >> >>=20
> > > > > > > > >> >> Does this actually prevent ublk servers with multiple=
 ublk devices or is
> > > > > > > > >> >> it just sub-optimal?
> > > > > > > > >> >
> > > > > > > > >> > It is former, ublk can't support multiple devices whic=
h share single host
> > > > > > > > >> > because duplicated tag can be seen in host side, then =
io is failed.
> > > > > > > > >> >
> > > > > > > > >>=20
> > > > > > > > >> I have trouble following this discussion. Why can we not=
 handle multiple
> > > > > > > > >> block devices in a single ublk user space process?
> > > > > > > > >>=20
> > > > > > > > >> From this conversation it seems that the limiting factor=
 is allocation
> > > > > > > > >> of the tag set of the virtual device in the kernel? But =
as far as I can
> > > > > > > > >> tell, the tag sets are allocated per virtual block devic=
e in
> > > > > > > > >> `ublk_ctrl_add_dev()`?
> > > > > > > > >>=20
> > > > > > > > >> It seems to me that a single ublk user space process shu=
ld be able to
> > > > > > > > >> connect to multiple storage devices (for instance nvme-o=
f) and then
> > > > > > > > >> create a ublk device for each namespace, all from a sing=
le ublk process.
> > > > > > > > >>=20
> > > > > > > > >> Could you elaborate on why this is not possible?
> > > > > > > > >
> > > > > > > > > If the multiple storages devices are independent, the cur=
rent ublk can
> > > > > > > > > handle them just fine.
> > > > > > > > >
> > > > > > > > > But if these storage devices(such as luns in iscsi, or NS=
s in nvme-tcp)
> > > > > > > > > share single host, and use host-wide tagset, the current =
interface can't
> > > > > > > > > work as expected, because tags is shared among all these =
devices. The
> > > > > > > > > current ublk interface needs to be extended for covering =
this case.
> > > > > > > >=20
> > > > > > > > Thanks for clarifying, that is very helpful.
> > > > > > > >=20
> > > > > > > > Follow up question: What would the implications be if one t=
ried to
> > > > > > > > expose (through ublk) each nvme namespace of an nvme-of con=
troller with
> > > > > > > > an independent tag set?
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.=
dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > > > > > >=20
> > > > > > > > What are the benefits of sharing a tagset across
> > > > > > > > all namespaces of a controller?
> > > > > > >=20
> > > > > > > The userspace implementation can be simplified a lot since ge=
neric
> > > > > > > shared tag allocation isn't needed, meantime with good perfor=
mance
> > > > > > > (shared tags allocation in SMP is one hard problem)
> > > > > >=20
> > > > > > In NVMe, tags are per Submission Queue. AFAIK there's no such t=
hing as
> > > > > > shared tags across multiple SQs in NVMe. So userspace doesn't n=
eed an
> > > > >=20
> > > > > In reality the max supported nr_queues of nvme is often much less=
 than
> > > > > nr_cpu_ids, for example, lots of nvme-pci devices just support at=
 most
> > > > > 32 queues, I remembered that Azure nvme supports less(just 8 queu=
es).
> > > > > That is because queue isn't free in both software and hardware, w=
hich
> > > > > implementation is often tradeoff between performance and cost.
> > > >=20
> > > > I didn't say that the ublk server should have nr_cpu_ids threads. I
> > > > thought the idea was the ublk server creates as many threads as it =
needs
> > > > (e.g. max 8 if the Azure NVMe device only has 8 queues).
> > > >=20
> > > > Do you expect ublk servers to have nr_cpu_ids threads in all/most c=
ases?
> > >=20
> > > No.
> > >=20
> > > In ublksrv project, each pthread maps to one unique hardware queue, s=
o total
> > > number of pthread is equal to nr_hw_queues.
> >=20
> > Good, I think we agree on that part.
> >=20
> > Here is a summary of the ublk server model I've been describing:
> > 1. Each pthread has a separate io_uring context.
> > 2. Each pthread has its own hardware submission queue (NVMe SQ, SCSI
> >    command queue, etc).
> > 3. Each pthread has a distinct subrange of the tag space if the tag
> >    space is shared across hardware submission queues.
> > 4. Each pthread allocates tags from its subrange without coordinating
> >    with other threads. This is cheap and simple.
>=20
> That is also not doable.
>=20
> The tag space can be pretty small, such as, usb-storage queue depth
> is just 1, and usb card reader can support multi lun too.
>=20
> That is just one extreme example, but there can be more low queue depth
> scsi devices(sata : 32, ...), typical nvme/pci queue depth is 1023, but
> there could be some implementation with less.
>=20
> More importantly subrange could waste lots of tags for idle LUNs/NSs, and
> active LUNs/NSs will have to suffer from the small subrange tags. And ava=
ilable
> tags depth represents the max allowed in-flight block IOs, so performance
> is affected a lot by subrange.
>=20
> If you look at block layer tag allocation change history, we never take
> such way.

Hi Ming,
Any thoughts on my last reply? If my mental model is incorrect I'd like
to learn why.

Thanks,
Stefan

--u+2iSFscRkUssHp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQTJq4ACgkQnKSrs4Gr
c8hekAf/c8G79SDctp/xyOnnah8xhlD/bUiXgExZXWU+aBC+x4dftHU6mcNtErKf
7df8voe9BdXDQjVBnjqsPRpMRnxRvf467avxv+TDEXdsCuua0hM4XlBUAnPNTZJC
WyWr20VFDQFarI7I9x2UBht6Xl2tXTS8ayWOqYUEFf81MrcSUkmHb04t1rCke+a6
c3MoXmPQheFVK9Ik+haypqbvGbNMUuC/E0kHFjSx1wODH3bgs+ub46dreJsiB2uq
8O3x2PouOhrd8mGghjl5nkGFWFBz/a1ye33Q6gtIaGYfAMjwa+7Dq6NFAfo4BtH4
XoqTJpF/6mbeU+e31nN3VM6mfPHsFA==
=avAC
-----END PGP SIGNATURE-----

--u+2iSFscRkUssHp2--

