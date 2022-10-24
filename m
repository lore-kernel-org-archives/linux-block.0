Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA5AFA3747
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 16:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiJXQuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiJXQtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 12:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2015A25
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666625448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t/jSO0lqWHSQcHiF6BRMSRgd7XZaU/RYEhuGiGA3W4o=;
        b=dYFGKgACZ4RV49AtiMIbOmhNGbflbNwSseQ9VUzPP2k/rGm4qZ3pY3rMDkn/QGgR+ZtvXv
        T/s7Xi5eCKZRWwUnmsg14oZspdC5ZFG9rLVobQ82eEG5Z62GHKBbxF8hsqbVOMec8/46NA
        /eFu4I76ZIP2Wn+/rpNyLkRTFLHmMCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-BD8qyXrmOD2Ly-xXM2Yriw-1; Mon, 24 Oct 2022 11:30:43 -0400
X-MC-Unique: BD8qyXrmOD2Ly-xXM2Yriw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEA24811E87;
        Mon, 24 Oct 2022 15:30:41 +0000 (UTC)
Received: from localhost (unknown [10.39.194.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28818492CA2;
        Mon, 24 Oct 2022 15:30:40 +0000 (UTC)
Date:   Mon, 24 Oct 2022 11:30:39 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, djeffery@redhat.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [Bug] double ->queue_rq() because of timeout in ->queue_rq()
Message-ID: <Y1avnzv01gevnmXz@fedora>
References: <Y1EQdafQlKNAsutk@T590>
 <Y1GpB6Gpm7GglwO3@fedora>
 <Y1ICvUwglbxkqE+v@T590>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p/CIZd9qse9A1PsE"
Content-Disposition: inline
In-Reply-To: <Y1ICvUwglbxkqE+v@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--p/CIZd9qse9A1PsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 21, 2022 at 10:23:57AM +0800, Ming Lei wrote:
> On Thu, Oct 20, 2022 at 04:01:11PM -0400, Stefan Hajnoczi wrote:
> > On Thu, Oct 20, 2022 at 05:10:13PM +0800, Ming Lei wrote:
> > > Hi,
> > >=20
> > > David Jeffery found one double ->queue_rq() issue, so far it can
> > > be triggered in the following two cases:
> > >=20
> > > 1) scsi driver in guest kernel
> > >=20
> > > - the story could be long vmexit latency or long preempt latency of
> > > vCPU pthread, then IO req is timed out before queuing the request
> > > to hardware but after calling blk_mq_start_request() during ->queue_r=
q(),
> > > then timeout handler handles it by requeue, then double ->queue_rq() =
is
> > > caused, and kernel panic
> > >=20
> > > 2) burst of kernel messages from irq handler=20
> > >=20
> > > For 1), I think it is one reasonable case, given latency from host si=
de
> > > can come anytime in theory because vCPU is emulated by one normal host
> > > pthread which can be preempted anywhere. For 2), I guess kernel messa=
ge is
> > > supposed to be rate limited.
> > >=20
> > > Firstly, is this kind of so long(30sec) random latency when running k=
ernel
> > > code something normal? Or do we need to take care of it? IMO, it looks
> > > reasonable in case of VM, but our VM experts may have better idea abo=
ut this
> > > situation. Also the default 30sec timeout could be reduced via sysfs =
or
> > > drivers.
> >=20
> > 30 seconds is a long latency that does not occur during normal
> > operation, but unfortunately does happen on occasion.
>=20
> Thanks for the confirmation!
>=20
> >=20
> > I think there's an interest in understanding the root cause and solving
> > long latencies (if possible) in the QEMU/KVM communities. We can
> > investigate specific cases on kvm@vger.kernel.org and/or
> > qemu-devel@nongnu.org.
>=20
> The issue was original reported on VMware VM, but maybe David can figure
> out how to trigger it on QEMU/KVM.

A very basic question:

The virtio_blk driver has no q->mq_ops->timeout() callback. Why does the
block layer still enable the timeout mechanism when the driver doesn't
implement ->timeout()?

I saw there was some "idle" hctx logic and I guess the requests are
resubmitted (although it wasn't obvious to me how that happens in the
code)? Maybe that's why the timer is still used if the driver doesn't
care about timeouts...

Stefan

--p/CIZd9qse9A1PsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNWr58ACgkQnKSrs4Gr
c8hlugf/Zm8Eno2AVQxjiXkuaB/DSkHQ20Y/6eP+D5toFYHpxDXd1VEVRNbRuM6S
kZoO6p8BAojnvB3V1nEIXX0zEtzT7Si8rwL5vN2ygFUB8zam0H/pI/JHqFRuXdqc
vJ606Eg3QBpQeNCH6hoN1z0uxth4LJdAAhiHFIGSFtz32vi9b/pAE1NgX6Ah74cP
sg1Y/PXajKux/H4nm0NZnh2I89PX3Lw1pVDccbShlbNIk3+UQvXZRRkLj8YVVk6v
TBxKmOuFMzh7iCjBRR5ruZoI+ULwodiJLYF057O8H1gMO0oGdUthqLU1YAQ8Ej0d
t9QCP3hK5W+1RYwJfEYGBFgr31CEEQ==
=+6cb
-----END PGP SIGNATURE-----

--p/CIZd9qse9A1PsE--

