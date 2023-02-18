Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B2C61DA3
	for <linux-block@archiver.kernel.org>; Tue, 21 Feb 2023 20:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjBUUje (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 15:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjBUUj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 15:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC472A6FE
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 12:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677011918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsVhipl7HiXZ+rR+d2Lq0yHfqaGD5Ts7UtlenDF32ko=;
        b=Dd8EDoL6m9muwuxTAh54uqifRobxDDs2GqUCJYjpj5FjxcPQA+oMbWjHvdEsWbn7iKzY6y
        HjV74Ysl4dm8AnHfKZa5WqxioQ7R2ppOtc+Akx0xlPM6nBVmRtr7A9nVcAc4+prnxq4QtN
        mp0uTrYmEM3YxhGqMaQ1mo0x86hVyiY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-hwAbsek9P8OE5dqsCNCLMA-1; Tue, 21 Feb 2023 15:38:34 -0500
X-MC-Unique: hwAbsek9P8OE5dqsCNCLMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEAF1101A521;
        Tue, 21 Feb 2023 20:38:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25B4F2166B26;
        Tue, 21 Feb 2023 20:38:32 +0000 (UTC)
Date:   Sat, 18 Feb 2023 13:38:08 -0500
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
Message-ID: <Y/EbEGV2Ege51RQZ@fedora>
References: <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
 <Y++t3kYTSNo9Sbb5@fedora>
 <Y/C1CVFceZ+X0ECa@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y3XLmua0veItpbxk"
Content-Disposition: inline
In-Reply-To: <Y/C1CVFceZ+X0ECa@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--y3XLmua0veItpbxk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrote:
> On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajnoczi wrote:
> > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wrote:
> > > >=20
> > > > Ming Lei <ming.lei@redhat.com> writes:
> > > >=20
> > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
> > > > >>=20
> > > > >> Hi Ming,
> > > > >>=20
> > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > >>=20
> > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrot=
e:
> > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi w=
rote:
> > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoc=
zi wrote:
> > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wr=
ote:
> > > > >> >> > > > > > Hello,
> > > > >> >> > > > > >=20
> > > > >> >> > > > > > So far UBLK is only used for implementing virtual b=
lock device from
> > > > >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > >> >> > > > >=20
> > > > >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> > > > >> >> > > >=20
> > > > >> >> > > > Thanks for the thoughts, :-)
> > > > >> >> > > >=20
> > > > >> >> > > > >=20
> > > > >> >> > > > > >=20
> > > > >> >> > > > > > It could be useful for UBLK to cover real storage h=
ardware too:
> > > > >> >> > > > > >=20
> > > > >> >> > > > > > - for fast prototype or performance evaluation
> > > > >> >> > > > > >=20
> > > > >> >> > > > > > - some network storages are attached to host, such =
as iscsi and nvme-tcp,
> > > > >> >> > > > > > the current UBLK interface doesn't support such dev=
ices, since it needs
> > > > >> >> > > > > > all LUNs/Namespaces to share host resources(such as=
 tag)
> > > > >> >> > > > >=20
> > > > >> >> > > > > Can you explain this in more detail? It seems like an=
 iSCSI or
> > > > >> >> > > > > NVMe-over-TCP initiator could be implemented as a ubl=
k server today.
> > > > >> >> > > > > What am I missing?
> > > > >> >> > > >=20
> > > > >> >> > > > The current ublk can't do that yet, because the interfa=
ce doesn't
> > > > >> >> > > > support multiple ublk disks sharing single host, which =
is exactly
> > > > >> >> > > > the case of scsi and nvme.
> > > > >> >> > >=20
> > > > >> >> > > Can you give an example that shows exactly where a proble=
m is hit?
> > > > >> >> > >=20
> > > > >> >> > > I took a quick look at the ublk source code and didn't sp=
ot a place
> > > > >> >> > > where it prevents a single ublk server process from handl=
ing multiple
> > > > >> >> > > devices.
> > > > >> >> > >=20
> > > > >> >> > > Regarding "host resources(such as tag)", can the ublk ser=
ver deal with
> > > > >> >> > > that in userspace? The Linux block layer doesn't have the=
 concept of a
> > > > >> >> > > "host", that would come in at the SCSI/NVMe level that's =
implemented in
> > > > >> >> > > userspace.
> > > > >> >> > >=20
> > > > >> >> > > I don't understand yet...
> > > > >> >> >=20
> > > > >> >> > blk_mq_tag_set is embedded into driver host structure, and =
referred by queue
> > > > >> >> > via q->tag_set, both scsi and nvme allocates tag in host/qu=
eue wide,
> > > > >> >> > that said all LUNs/NSs share host/queue tags, current every=
 ublk
> > > > >> >> > device is independent, and can't shard tags.
> > > > >> >>=20
> > > > >> >> Does this actually prevent ublk servers with multiple ublk de=
vices or is
> > > > >> >> it just sub-optimal?
> > > > >> >
> > > > >> > It is former, ublk can't support multiple devices which share =
single host
> > > > >> > because duplicated tag can be seen in host side, then io is fa=
iled.
> > > > >> >
> > > > >>=20
> > > > >> I have trouble following this discussion. Why can we not handle =
multiple
> > > > >> block devices in a single ublk user space process?
> > > > >>=20
> > > > >> From this conversation it seems that the limiting factor is allo=
cation
> > > > >> of the tag set of the virtual device in the kernel? But as far a=
s I can
> > > > >> tell, the tag sets are allocated per virtual block device in
> > > > >> `ublk_ctrl_add_dev()`?
> > > > >>=20
> > > > >> It seems to me that a single ublk user space process shuld be ab=
le to
> > > > >> connect to multiple storage devices (for instance nvme-of) and t=
hen
> > > > >> create a ublk device for each namespace, all from a single ublk =
process.
> > > > >>=20
> > > > >> Could you elaborate on why this is not possible?
> > > > >
> > > > > If the multiple storages devices are independent, the current ubl=
k can
> > > > > handle them just fine.
> > > > >
> > > > > But if these storage devices(such as luns in iscsi, or NSs in nvm=
e-tcp)
> > > > > share single host, and use host-wide tagset, the current interfac=
e can't
> > > > > work as expected, because tags is shared among all these devices.=
 The
> > > > > current ublk interface needs to be extended for covering this cas=
e.
> > > >=20
> > > > Thanks for clarifying, that is very helpful.
> > > >=20
> > > > Follow up question: What would the implications be if one tried to
> > > > expose (through ublk) each nvme namespace of an nvme-of controller =
with
> > > > an independent tag set?
> > >=20
> > > https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.dk/T/#m5=
7158db9f0108e529d8d62d1d56652c52e9e3e67
> > >=20
> > > > What are the benefits of sharing a tagset across
> > > > all namespaces of a controller?
> > >=20
> > > The userspace implementation can be simplified a lot since generic
> > > shared tag allocation isn't needed, meantime with good performance
> > > (shared tags allocation in SMP is one hard problem)
> >=20
> > In NVMe, tags are per Submission Queue. AFAIK there's no such thing as
> > shared tags across multiple SQs in NVMe. So userspace doesn't need an
>=20
> In reality the max supported nr_queues of nvme is often much less than
> nr_cpu_ids, for example, lots of nvme-pci devices just support at most
> 32 queues, I remembered that Azure nvme supports less(just 8 queues).
> That is because queue isn't free in both software and hardware, which
> implementation is often tradeoff between performance and cost.

I didn't say that the ublk server should have nr_cpu_ids threads. I
thought the idea was the ublk server creates as many threads as it needs
(e.g. max 8 if the Azure NVMe device only has 8 queues).

Do you expect ublk servers to have nr_cpu_ids threads in all/most cases?

> Not mention, most of scsi devices are SQ in which tag allocations from
> all CPUs are against single shared tagset.
>=20
> So there is still per-queue tag allocations from different CPUs which aims
> at same queue.
>
> What we discussed are supposed to be generic solution, not something just
> for ideal 1:1 mapping device, which isn't dominant in reality.

The same trivial tag allocation can be used for SCSI: instead of a
private tag namespace (e.g. 0x0-0xffff), give each queue a private
subset of the tag namespace (e.g. queue 0 has 0x0-0x7f, queue 1 has
0x80-0xff, etc).

The issue is not whether the tag namespace is shared across queues, but
the threading model of the ublk server. If the threading model requires
queues to be shared, then it becomes more complex and slow.

It's not clear to me why you think ublk servers should choose threading
models that require queues to be shared? They don't have to. Unlike the
kernel, they can choose the number of threads.

>=20
> > SMP tag allocator in the first place:
> > - Each ublk server thread has a separate io_uring context.
> > - Each ublk server thread has its own NVMe Submission Queue.
> > - Therefore it's trivial and cheap to allocate NVMe CIDs in userspace
> >   because there are no SMP concerns.
>=20
> It isn't even trivial for 1:1 mapping, when any ublk server crashes
> global tag will be leaked, and other ublk servers can't use the
> leaked tag any more.

I'm not sure what you're describing here, a multi-process ublk server?
Are you saying userspace must not do tag allocation itself because it
won't be able to recover?

Stefan

--y3XLmua0veItpbxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPxGw8ACgkQnKSrs4Gr
c8ieTQf/SahyRHgX1OoP9HcjyBSmNqRUx6JZS8/azMaaGn3wF8sfKy+jWm7mt+gi
D7DQBND11hMHoOmtlntVh4vdQ6MZ/nyQw2zm9vCS5VSURzR8GgAt2pZePuP5SAYh
+Cvw/291jT0n/enekvjmRSvqdJUGO7Jcyhq4wLJ8Rs0tY30GIbvhJmNNmC6reScr
I8SkQpxX3TKARxuVUh0RljV66vcqGR7PHvAsfbYToYfrfzvZ3lgYOSZjg0z7e6KH
4OlxEPgzS0UeQTxVKlEFNHamBBiOF/psulXMEZ+PXeHPSCFqhBKWukhAq+p1ZFYL
vjKXsGv275bBsf3GNmGqeqpuUiUmlA==
=BA5F
-----END PGP SIGNATURE-----

--y3XLmua0veItpbxk--

