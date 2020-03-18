Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84FC5ACD6
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 07:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93D12076A
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 07:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQkzr6jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCRHgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:36:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28195 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgCRHgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 03:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584517006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WAPOGGlV1CfE+30iG77NqWqBllm908ay9U5EecTtSA=;
        b=PQkzr6jIdUF5MS/aI3D3a6QQmXShBDfFJTG84kZYbUeUtZytUL09kJRqx7wKakE1rngofz
        ldIc5nifcUdP6Cv9KArvze5n7cMc5cDV1THz6DVUEtkWRsGWVGYVuPURuxa294WML0IXul
        AuvOgU/2Re7COGv3lN174XV81ThNHGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-i10ju6jHPzCLmoSKnsfaqQ-1; Wed, 18 Mar 2020 03:36:42 -0400
X-MC-Unique: i10ju6jHPzCLmoSKnsfaqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82977800D54;
        Wed, 18 Mar 2020 07:36:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A255B19C58;
        Wed, 18 Mar 2020 07:36:34 +0000 (UTC)
Date:   Wed, 18 Mar 2020 15:36:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Feng Li <lifeng1519@gmail.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
Message-ID: <20200318073630.GA18460@ming.t460p>
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p>
 <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
 <20200313023156.GB27275@ming.t460p>
 <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
 <CACVXFVPJcO41a-dinfEhLKnJ6P=6sMXyg7SZcXPtqHcyqRPUUA@mail.gmail.com>
 <CAEK8JBCKH8-tiUj1W6CB_wAx2xF4osDLXG3GNzuAySrgsqp=yQ@mail.gmail.com>
 <20200317102643.GA8721@ming.t460p>
 <CAEK8JBChFOkNTi99CVwXbQZ+9R4OB79SeOy=s0rbNnZnQT+DFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEK8JBChFOkNTi99CVwXbQZ+9R4OB79SeOy=s0rbNnZnQT+DFA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 18, 2020 at 02:29:17PM +0800, Feng Li wrote:
> Hi Ming,
> What I need is that always get contiguous pages in one bvec.
> Maybe currently it's hard to satisfy this requirement.
> About huge pages, I know the userspace processes could use huge pages
> that kernel reserved.
> Could bio/block layer support use huge pages?

Yes, you will see all pages in one huge page are stored in one single
bvec.

>=20
> Thanks again for your help.
>=20
> Ming Lei <ming.lei@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:27=E5=86=99=E9=81=93=EF=BC=9A
>=20
> >
> > On Tue, Mar 17, 2020 at 04:19:44PM +0800, Feng Li wrote:
> > > Thanks.
> > > Sometimes when I observe multipage bvec on 5.3.7-301.fc31.x86_64.
> > > This log is from Qemu virtio-blk.
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
> > >       0: size: 229376 addr: 0x7fff6a7c8000
> > >       1: size: 32768 addr: 0x7fff64c00000
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 2
> > >       0: size: 229376 addr: 0x7fff6a7c8000
> > >       1: size: 32768 addr: 0x7fff64c00000
> >
> > Then it is working.
> >
> > >
> > > I also tested on 5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64.
> > > And observe 64 iovcnt.
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D size: 262144, iovcnt: 64
> > >       0: size: 4096 addr: 0x7fffb5ece000
> > >       1: size: 4096 addr: 0x7fffb5ecd000
> > > ...
> > >       63: size: 4096 addr: 0x7fff8baec000
> > >
> > > So I think this is a common issue of the upstream kernel, from 5.3 =
to 5.6.
> >
> > As I mentioned before, it is because the pages aren't contiguous
> > physically.
> >
> > If you enable hugepage, you will see lot of pages in one single bvec.
> >
> > >
> > > BTW, I have used your script on 5.3.7-301.fc31.x86_64, it works wel=
l.
> > > However, when updating to kernel 5.6.0-0.rc6.git0.1.vanilla.knurd.1=
.fc31.x86_64.
> > > It complains:
> > >
> > > root@192.168.19.239 16:57:23 ~ $ ./bvec_avg_pages.py
> > > In file included from /virtual/main.c:2:
> > > In file included from
> > > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/i=
nclude/uapi/linux/ptrace.h:142:
> > > In file included from
> > > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/a=
rch/x86/include/asm/ptrace.h:5:
> > > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/a=
rch/x86/include/asm/segment.h:266:2:
> > > error: expected '(' after 'asm'
> > >         alternative_io ("lsl %[seg],%[p]",
> >
> > It can be workaround by commenting the following line in
> > /lib/modules/5.6.0-0.rc6.git0.1.vanilla.knurd.1.fc31.x86_64/build/inc=
lude/generated/autoconf.h:
> >
> > #define CONFIG_CC_HAS_ASM_INLINE 1
> >
> >
> > Thanks,
> > Ming
> >
>=20

--=20
Ming

