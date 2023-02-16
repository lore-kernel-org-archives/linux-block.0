Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E9AC636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 15:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBPP3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 10:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBPP3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 10:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DFE5BA5
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 07:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676561316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXIwCtu6Fo8ccc2eOj+CzQz5QQSw1MtSy/nH/hm+46g=;
        b=FVxKrCM0Rbqs96k3Vs054OBOLMDc8Ac/YfnOOo1poElA8Gsd25MQP7tQef31LPdQDsdv8w
        RsPj5XL2AYC6YqtDf+eFSuXmim3xhQkObpO5aJW2puVbQv8cU7kro5S/Aihh2Ayn4SENJS
        rqaBTGLT7RVsMebFIK0isa7ejIcjo7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-D6MZzhj4OuaUk2o32SdhKA-1; Thu, 16 Feb 2023 10:28:27 -0500
X-MC-Unique: D6MZzhj4OuaUk2o32SdhKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB0068028B0;
        Thu, 16 Feb 2023 15:28:26 +0000 (UTC)
Received: from localhost (unknown [10.39.192.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C4B640B40C9;
        Thu, 16 Feb 2023 15:28:25 +0000 (UTC)
Date:   Thu, 16 Feb 2023 10:28:23 -0500
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
Message-ID: <Y+5Ll3agvKFnvJGv@fedora>
References: <Y+EWCwqSisu3l0Sz@T590>
 <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <Y+z5yzrOhq2nbV/A@fedora>
 <Y+19AM8zuU9+abQS@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bDa5/zkJ/US6Nk98"
Content-Disposition: inline
In-Reply-To: <Y+19AM8zuU9+abQS@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--bDa5/zkJ/US6Nk98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 08:46:56AM +0800, Ming Lei wrote:
> On Wed, Feb 15, 2023 at 10:27:07AM -0500, Stefan Hajnoczi wrote:
> > On Wed, Feb 15, 2023 at 08:51:27AM +0800, Ming Lei wrote:
> > > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> > > > On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> > > > > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> > > > > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> > > > > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wro=
te:
> > > > > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> > > > > > > > > Hello,
> > > > > > > > >=20
> > > > > > > > > So far UBLK is only used for implementing virtual block d=
evice from
> > > > > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> > > > > > > >=20
> > > > > > > > I won't be at LSF/MM so here are my thoughts:
> > > > > > >=20
> > > > > > > Thanks for the thoughts, :-)
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > It could be useful for UBLK to cover real storage hardwar=
e too:
> > > > > > > > >=20
> > > > > > > > > - for fast prototype or performance evaluation
> > > > > > > > >=20
> > > > > > > > > - some network storages are attached to host, such as isc=
si and nvme-tcp,
> > > > > > > > > the current UBLK interface doesn't support such devices, =
since it needs
> > > > > > > > > all LUNs/Namespaces to share host resources(such as tag)
> > > > > > > >=20
> > > > > > > > Can you explain this in more detail? It seems like an iSCSI=
 or
> > > > > > > > NVMe-over-TCP initiator could be implemented as a ublk serv=
er today.
> > > > > > > > What am I missing?
> > > > > > >=20
> > > > > > > The current ublk can't do that yet, because the interface doe=
sn't
> > > > > > > support multiple ublk disks sharing single host, which is exa=
ctly
> > > > > > > the case of scsi and nvme.
> > > > > >=20
> > > > > > Can you give an example that shows exactly where a problem is h=
it?
> > > > > >=20
> > > > > > I took a quick look at the ublk source code and didn't spot a p=
lace
> > > > > > where it prevents a single ublk server process from handling mu=
ltiple
> > > > > > devices.
> > > > > >=20
> > > > > > Regarding "host resources(such as tag)", can the ublk server de=
al with
> > > > > > that in userspace? The Linux block layer doesn't have the conce=
pt of a
> > > > > > "host", that would come in at the SCSI/NVMe level that's implem=
ented in
> > > > > > userspace.
> > > > > >=20
> > > > > > I don't understand yet...
> > > > >=20
> > > > > blk_mq_tag_set is embedded into driver host structure, and referr=
ed by queue
> > > > > via q->tag_set, both scsi and nvme allocates tag in host/queue wi=
de,
> > > > > that said all LUNs/NSs share host/queue tags, current every ublk
> > > > > device is independent, and can't shard tags.
> > > >=20
> > > > Does this actually prevent ublk servers with multiple ublk devices =
or is
> > > > it just sub-optimal?
> > >=20
> > > It is former, ublk can't support multiple devices which share single =
host
> > > because duplicated tag can be seen in host side, then io is failed.
> >=20
> > The kernel sees two independent block devices so there is no issue
> > within the kernel.
>=20
> This way either wastes memory, or performance is bad since we can't
> make a perfect queue depth for each ublk device.
>=20
> >=20
> > Userspace can do its own hw tag allocation if there are shared storage
> > controller resources (e.g. NVMe CIDs) to avoid duplicating tags.
> >=20
> > Have I missed something?
>=20
> Please look at lib/sbitmap.c and block/blk-mq-tag.c and see how many
> hard issues fixed/reported in the past, and how much optimization done
> in this area.
>=20
> In theory hw tag allocation can be done in userspace, but just hard to
> do efficiently:
>=20
> 1) it has been proved as one hard task for sharing data efficiently in
> SMP, so don't reinvent wheel in userspace, and this work could take
> much more efforts than extending current ublk interface, and just
> fruitless
>=20
> 2) two times tag allocation slows down io path much
>=20
> 2) even worse for userspace allocation, cause task can be killed and
> no cleanup is done, so tag leak can be caused easily

So then it is not "the former" after all?

Stefan

--bDa5/zkJ/US6Nk98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPuS5cACgkQnKSrs4Gr
c8g+vQf+J6+Gwx2OQkKMGv2MdBB0ukRabXmHo5Lco1OMGsiu1Q7UxYNMtDZkUVmX
Ct/HEBIsZch0OZ6CP0TXJyzNSbmUwSUHYNxqbelthkmN3lS+OkrAWJna3+lYKO7a
72adcXKnqdfQCA5NgCia06dj4aZ3YetRHvoDjqGY4TNvi3c79RfPl6yWMbnf8Oqi
PBkeeCZ1YuBlPrGU/oF7Vbl1BWjckLBvo5ow6ZSO+eDM1bOnyUTlhvQYtumktm3c
aL/xYgoCHBMz927xw+tmSiJfRCiJfbvyHJNUJiy02uYvLbHma9Jlefin5I/Jciq8
wvgKbs+7nkW8fkBnm/+ImUsXp0mffQ==
=9Epo
-----END PGP SIGNATURE-----

--bDa5/zkJ/US6Nk98--

