Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D74C636D6
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 16:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBQQkv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 11:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBQQks (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 11:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48F6B30E
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676652010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdgfsebKSANqNEg9SXrivj4ZcfjNYG5TQTq+e1WuVLg=;
        b=gZnAqPMVQCaXg/SSqvClnRVyX0vjS7WwmLbU8XtA2yuWxbT27dJapNT71dnhbzqP4IAuJT
        C4LaK+9sIMe5ZB3aXVE8PseeyjjARJ2lMMthl2osrkaUKnybBMlTYiSTosmEgFHPDF4X2i
        +HOS5haBWyRGKJSD4jTWL+5bOr2L+X0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-wxAyyaOGMri6TsQ3yTFLQg-1; Fri, 17 Feb 2023 11:40:03 -0500
X-MC-Unique: wxAyyaOGMri6TsQ3yTFLQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E4DA3C0F1AC;
        Fri, 17 Feb 2023 16:40:02 +0000 (UTC)
Received: from localhost (unknown [10.39.193.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB0BA40398A2;
        Fri, 17 Feb 2023 16:40:00 +0000 (UTC)
Date:   Fri, 17 Feb 2023 11:39:58 -0500
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
Message-ID: <Y++t3kYTSNo9Sbb5@fedora>
References: <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
 <Y+7kfZnWsmnA0V84@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mUOVSiS7JjAiRXi0"
Content-Disposition: inline
In-Reply-To: <Y+7kfZnWsmnA0V84@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--mUOVSiS7JjAiRXi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei wrote:
> On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wrote:
> >=20
> > Ming Lei <ming.lei@redhat.com> writes:
> >=20
> > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
> > >>=20
> > >> Hi Ming,
> > >>=20
> > >> Ming Lei <ming.lei@redhat.com> writes:
> > >>=20
> > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi w=
rote:
> > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > >> >> > > > > > Hello,
> > >> >> > > > > >=20
> > >> >> > > > > > So far UBLK is only used for implementing virtual block=
 device from
> > >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > >> >> > > > >=20
> > >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> > >> >> > > >=20
> > >> >> > > > Thanks for the thoughts, :-)
> > >> >> > > >=20
> > >> >> > > > >=20
> > >> >> > > > > >=20
> > >> >> > > > > > It could be useful for UBLK to cover real storage hardw=
are too:
> > >> >> > > > > >=20
> > >> >> > > > > > - for fast prototype or performance evaluation
> > >> >> > > > > >=20
> > >> >> > > > > > - some network storages are attached to host, such as i=
scsi and nvme-tcp,
> > >> >> > > > > > the current UBLK interface doesn't support such devices=
, since it needs
> > >> >> > > > > > all LUNs/Namespaces to share host resources(such as tag)
> > >> >> > > > >=20
> > >> >> > > > > Can you explain this in more detail? It seems like an iSC=
SI or
> > >> >> > > > > NVMe-over-TCP initiator could be implemented as a ublk se=
rver today.
> > >> >> > > > > What am I missing?
> > >> >> > > >=20
> > >> >> > > > The current ublk can't do that yet, because the interface d=
oesn't
> > >> >> > > > support multiple ublk disks sharing single host, which is e=
xactly
> > >> >> > > > the case of scsi and nvme.
> > >> >> > >=20
> > >> >> > > Can you give an example that shows exactly where a problem is=
 hit?
> > >> >> > >=20
> > >> >> > > I took a quick look at the ublk source code and didn't spot a=
 place
> > >> >> > > where it prevents a single ublk server process from handling =
multiple
> > >> >> > > devices.
> > >> >> > >=20
> > >> >> > > Regarding "host resources(such as tag)", can the ublk server =
deal with
> > >> >> > > that in userspace? The Linux block layer doesn't have the con=
cept of a
> > >> >> > > "host", that would come in at the SCSI/NVMe level that's impl=
emented in
> > >> >> > > userspace.
> > >> >> > >=20
> > >> >> > > I don't understand yet...
> > >> >> >=20
> > >> >> > blk_mq_tag_set is embedded into driver host structure, and refe=
rred by queue
> > >> >> > via q->tag_set, both scsi and nvme allocates tag in host/queue =
wide,
> > >> >> > that said all LUNs/NSs share host/queue tags, current every ublk
> > >> >> > device is independent, and can't shard tags.
> > >> >>=20
> > >> >> Does this actually prevent ublk servers with multiple ublk device=
s or is
> > >> >> it just sub-optimal?
> > >> >
> > >> > It is former, ublk can't support multiple devices which share sing=
le host
> > >> > because duplicated tag can be seen in host side, then io is failed.
> > >> >
> > >>=20
> > >> I have trouble following this discussion. Why can we not handle mult=
iple
> > >> block devices in a single ublk user space process?
> > >>=20
> > >> From this conversation it seems that the limiting factor is allocati=
on
> > >> of the tag set of the virtual device in the kernel? But as far as I =
can
> > >> tell, the tag sets are allocated per virtual block device in
> > >> `ublk_ctrl_add_dev()`?
> > >>=20
> > >> It seems to me that a single ublk user space process shuld be able to
> > >> connect to multiple storage devices (for instance nvme-of) and then
> > >> create a ublk device for each namespace, all from a single ublk proc=
ess.
> > >>=20
> > >> Could you elaborate on why this is not possible?
> > >
> > > If the multiple storages devices are independent, the current ublk can
> > > handle them just fine.
> > >
> > > But if these storage devices(such as luns in iscsi, or NSs in nvme-tc=
p)
> > > share single host, and use host-wide tagset, the current interface ca=
n't
> > > work as expected, because tags is shared among all these devices. The
> > > current ublk interface needs to be extended for covering this case.
> >=20
> > Thanks for clarifying, that is very helpful.
> >=20
> > Follow up question: What would the implications be if one tried to
> > expose (through ublk) each nvme namespace of an nvme-of controller with
> > an independent tag set?
>=20
> https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.dk/T/#m57158=
db9f0108e529d8d62d1d56652c52e9e3e67
>=20
> > What are the benefits of sharing a tagset across
> > all namespaces of a controller?
>=20
> The userspace implementation can be simplified a lot since generic
> shared tag allocation isn't needed, meantime with good performance
> (shared tags allocation in SMP is one hard problem)

In NVMe, tags are per Submission Queue. AFAIK there's no such thing as
shared tags across multiple SQs in NVMe. So userspace doesn't need an
SMP tag allocator in the first place:
- Each ublk server thread has a separate io_uring context.
- Each ublk server thread has its own NVMe Submission Queue.
- Therefore it's trivial and cheap to allocate NVMe CIDs in userspace
  because there are no SMP concerns.

The issue isn't tag allocation, it's the fact that the kernel block
layer submits requests to userspace that don't fit into the NVMe
Submission Queue because multiple devices that appear independent from
the kernel perspective are sharing a single NVMe Submission Queue.
Userspace needs a basic I/O scheduler to ensure fairness across devices.
Round-robin for example. There are no SMP concerns here either.

So I don't buy the argument that userspace would have to duplicate the
tag allocation code from Linux because that solves a different problem
that the ublk server doesn't have.

If the kernel is aware of tag sharing, then userspace doesn't have to do
(trivial) tag allocation or I/O scheduling. It can simply stuff ublk io
commands into NVMe queues without thinking, which wastes fewer CPU
cycles and is a little simpler.

> The extension shouldn't be very hard, follows some raw ideas:

It is definitely nice for the ublk server to tell the kernel about
shared resources so the Linux block layer has the best information. I
think it's a good idea to add support for that. I just disagree with
some of the statements you've made about why and especially the claim
that ublk doesn't support multiple device servers today.

>=20
> 1) interface change
>=20
> - add new feature flag of UBLK_F_SHARED_HOST, multiple ublk
>   devices(ublkcXnY) are attached to the ublk host(ublkhX)
>=20
> - dev_info.dev_id: in case of UBLK_F_SHARED_HOST, the top 16bit stores
>   host id(X), and the bottom 16bit stores device id(Y)
>=20
> - add two control commands: UBLK_CMD_ADD_HOST, UBLK_CMD_DEL_HOST
>=20
>   Still sent to /dev/ublk-control
>=20
>   ADD_HOST command will allocate one host device(char) with specified host
>   id or allocated host id, tag_set is allocated as host resource. The
>   host device(ublkhX) will become parent of all ublkcXn*
>=20
>   Before sending DEL_HOST, all devices attached to this host have to
>   be stopped & removed first, otherwise DEL_HOST won't succeed.
>=20
> - keep other interfaces not changed
>   in case of UBLK_F_SHARED_HOST, userspace has to set correct
>   dev_info.dev_id.host_id, so ublk driver can associate device with
>   specified host
>=20
> 2) implementation
> - host device(ublkhX) becomes parent of all ublk char devices of
>   ublkcXn*
>=20
> - except for tagset, other per-host resource abstraction? Looks not
>   necessary, anything is available in userspace
>=20
> - host-wide error handling, maybe all devices attached to this host
>   need to be recovered, so it should be done in userspace=20
>=20
> - per-host admin queue, looks not necessary, given host related
>   management/control tasks are done in userspace directly
>=20
> - others?
>=20
>=20
> Thanks,
> Ming
>=20

--mUOVSiS7JjAiRXi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPvrd4ACgkQnKSrs4Gr
c8gCzgf9GO342MSfQmrMbA48bpn2TRPiTkTbd6EEJpnaN6d3rrV8JnxbYvLaj14K
ThPmoBCiaAMccPvYLSO1Whqm14Y0FoC7usooQPTRMHvhGr0Y+krPCAY8SrtUVJwQ
aQu4kOG1m3r7LkQcMUmVNc66YSRVJQrxTXDwGLI8azlpvyPVoNG3JVux3I4DSkh6
JugZBa42IKk68PRR5oGH7QU22wltMgqMc67nt6Z9JOUiVqSB39u+T6cgFMCikgMY
3N4Z+QauOXOS52dh/UC3FjmQLI8n2Zt/jAp32hAXh9Ty8UJjSZLFaE2othgq5BH8
Jf0cmsl8UmvQbt9cinVOvV0hG0IL9Q==
=bC1Y
-----END PGP SIGNATURE-----

--mUOVSiS7JjAiRXi0--

