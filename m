Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44968C00140
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiHXRch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 13:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiHXRcc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 13:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7197E00F
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661362349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SxvzmbfXBys/uUI/1Xzbbd4NhELb1JncuSp2gy3f7o=;
        b=TbQmE22VgbBJBdfv4hRlF+eYX6aPE0dV+JDBTC0dM3adXN2Elpw7eKs2ty/67xrPhei0pe
        ApHQW+cKN+mh4C8E8ekjhk8K0TDqhfmscnUOYQyb/o1qTbR4VfSi5HCQey9LMpfsrFgds1
        9MwJ/8wEp/CORQka+xwIyStay/KsFr4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-4ATjl8YdPNSzaGtmbrR8pQ-1; Wed, 24 Aug 2022 13:32:28 -0400
X-MC-Unique: 4ATjl8YdPNSzaGtmbrR8pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB66E18812C0;
        Wed, 24 Aug 2022 17:32:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40BFB40CF8EF;
        Wed, 24 Aug 2022 17:32:26 +0000 (UTC)
Date:   Wed, 24 Aug 2022 13:32:25 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Kim Suwan <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        acourbot@chromium.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Message-ID: <YwZgqf5kMqKHwcxR@fedora>
References: <20220823145005.26356-1-suwan.kim027@gmail.com>
 <YwU/EVxT0a6q2BfD@fedora>
 <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wZ49M233+TjXIU1/"
Content-Disposition: inline
In-Reply-To: <CAFNWusaXc3H78kx1wxUDLht3PuV0A_VxvdmmY-yMJNefvih-1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--wZ49M233+TjXIU1/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 10:16:10PM +0900, Kim Suwan wrote:
> Hi Stefan,
>=20
> On Wed, Aug 24, 2022 at 5:56 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Tue, Aug 23, 2022 at 11:50:05PM +0900, Suwan Kim wrote:
> > > @@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_b=
lk_vq *vq,
> > >                       virtblk_unmap_data(req, vbr);
> > >                       virtblk_cleanup_cmd(req);
> > >                       rq_list_add(requeue_list, req);
> > > +             } else {
> > > +                     blk_mq_start_request(req);
> > >               }
> >
> > The device may see new requests as soon as virtblk_add_req() is called
> > above. Therefore the device may complete the request before
> > blk_mq_start_request() is called.
> >
> > rq->io_start_time_ns =3D ktime_get_ns() will be after the request was
> > actually submitted.
> >
> > I think blk_mq_start_request() needs to be called before
> > virtblk_add_req().
> >
>=20
> But if blk_mq_start_request() is called before virtblk_add_req()
> and virtblk_add_req() fails, it can trigger WARN_ON_ONCE() at
> virtio_queue_rq().
>=20
> With regard to the race condition between virtblk_add_req() and
> completion, I think that the race condition can not happen because
> virtblk_add_req() holds vq lock with irq saving and completion side
> (virtblk_done, virtblk_poll) need to acquire the vq lock also.
> Moreover, virtblk_done() is irq context so I think it can not be
> executed until virtblk_add_req() releases the lock.

I agree there is no race condition regarding the ordering of
blk_mq_start_request() and request completion. The spinlock prevents
that and I wasn't concerned about that part.

The issue is that the timestamp will be garbage. If we capture the
timestamp during/after the request is executing, then the collected
statistics will be wrong.

Can you look for another solution that doesn't break the timestamp?

FWIW I see that the rq->state state machine allows returning to the idle
state once the request has been started: __blk_mq_requeue_request().

Stefan

--wZ49M233+TjXIU1/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMGYKkACgkQnKSrs4Gr
c8hF+gf6AhXhzLB6TCjRg/U/ved3Yj0e/lR75NkPlvmJiGu3ncW3AU01UY5hFNoO
9S2+RbCGhGSNji8n8Rqu4OxDAZaRgYJ1USCDhZs4HF+lNU/IHTUYoge29pcqyCoW
PI6bWLpY0luidnMqxKlcLsAExsl7u+vlxUOBGxlgvgKEP1V3HHCs8/spBiMEJRUJ
Kp1xxPWP439HxTZm1BSDFwXx+aWakWDEXzF8qPBu9hvyhDtVjCaedWXDjKQPqxHh
xvmd+n9qLMkOQyp8s8z1CUP/hbH2p7fXQB6F5YI0G2HMfrSfWbN2MrmeRB4g/ZD3
Frb0ABhrgQnbuVDLB/nsaM/ewyYzjQ==
=S6B9
-----END PGP SIGNATURE-----

--wZ49M233+TjXIU1/--

