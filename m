Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AACC47084
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 13:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182FF61420
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 13:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhEYNWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 09:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232285AbhEYNWg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 09:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621948866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNt+DjVfGGIxrVvGjGmM2V8MGzWk+ZVdoTSHQp30M6w=;
        b=Llq6nAkrJQ3nYldz/rdojmyhG5Byz4Wm/evoEIxu32+pe23S+dLuVTGQDpd7jMji+P0ju+
        Sv5KTdND+vCB7rTBB9HiwPc0vvLRZUe6LN51BfIldClqYBsQQXMD6AZ+dxWnBP1ArAyy7t
        o9MUqhRisV8CKzd4Ik+BKQ9AH/4KX+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-c7s7ocZ1NLmyw36_7g7jGg-1; Tue, 25 May 2021 09:21:02 -0400
X-MC-Unique: c7s7ocZ1NLmyw36_7g7jGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11D28107ACCD;
        Tue, 25 May 2021 13:21:01 +0000 (UTC)
Received: from localhost (ovpn-115-80.ams2.redhat.com [10.36.115.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C1205D6AC;
        Tue, 25 May 2021 13:20:49 +0000 (UTC)
Date:   Tue, 25 May 2021 14:20:49 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        slp@redhat.com, sgarzare@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YKz5sQPPNdccztHh@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <20210524145928.GA3873@lst.de>
 <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com>
 <YKypgi2qcYVTgYdv@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GTdFGyW7Xz8tnV5A"
Content-Disposition: inline
In-Reply-To: <YKypgi2qcYVTgYdv@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--GTdFGyW7Xz8tnV5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 03:38:42PM +0800, Ming Lei wrote:
> On Tue, May 25, 2021 at 09:22:48AM +0200, Paolo Bonzini wrote:
> > On 24/05/21 16:59, Christoph Hellwig wrote:
> > > On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> > > > Possible drawbacks of this approach:
> > > >=20
> > > > - Hardware virtio_blk implementations may find virtqueue_disable_cb=
()
> > > >    expensive since it requires DMA. If such devices become popular =
then
> > > >    the virtio_blk driver could use a similar approach to NVMe when
> > > >    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> > > >=20
> > > > - If a blk_poll() thread is descheduled it not only hurts polling
> > > >    performance but also delays completion of non-REQ_HIPRI requests=
 on
> > > >    that virtqueue since vq notifications are disabled.
> > >=20
> > > Yes, I think this is a dangerous configuration.  What argument exists
> > > again just using dedicated poll queues?
> >=20
> > There isn't an equivalent of the admin queue in virtio-blk, which would
> > allow the guest to configure the desired number of poll queues.  The nu=
mber
> > of queues is fixed.
>=20
> Dedicated vqs can be used for poll only, and I understand VM needn't to k=
now
> if the vq is polled or driven by IRQ in VM.
>=20
> I tried that in v5.4, but not see obvious IOPS boost, so give up.
>=20
> https://github.com/ming1/linux/commits/my_v5.4-virtio-irq-poll

Hey, that's cool. I see a lot of similarity between our patches :).

Stefan

--GTdFGyW7Xz8tnV5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCs+bEACgkQnKSrs4Gr
c8gpvwf9Gsszvx3thnjSlUHG86t1HZE4scSNI6lprmUa91+ClXSNycaUbWeVwhFb
RtBBVcKmNyhhn/GKBlczjmVd5BepVijB8cQflfk2gVVol4c/4IfckdlAuhn4SM2F
FAcyRrUqV17bUzOMCWpnN50nSHaGFBGxnJncMb04WdaM23J+Mi8PfD/ixcRkJCQq
ZDAR51KF4iHXK5eSC4dPnQ3MI40NZRBnyxT+09k8c522XdAT55GUbQeAxAtvA5Mm
5jr5DfO1SRrCZyKstnEVZTu6cN+2Y7sunsJ/9sR+VNKTAMpCuX29EyDOxTZBB8fd
SVNiZeqFPX42bPVbwvacmEC35OHJ7w==
=wyc4
-----END PGP SIGNATURE-----

--GTdFGyW7Xz8tnV5A--

