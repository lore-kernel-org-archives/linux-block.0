Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD7C636CD
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 22:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjA3WVY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjA3WVX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 17:21:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5D39B86
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675117235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fWVhH491yPpXf+szPJHgyS9uxnj8Fdldgu4orhy9P0=;
        b=ahWWlBB1F76T6UhEcXhxWkTeUwAAwZVRO6vOIuNus/eZlITHe2ZxKXIpETgtrzBqpnsy+k
        6R5JKJI9PV0+6bImn3GzYJ+iP7snypN1kd+bjS9qPOvEtCdD0TQun3PJfY6nNUUxjwNwcs
        Ifrxi552N8HbgPJVTVgGDuVJ27xQCKU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-qoh5nZAaPRa1CU1j-9GK8A-1; Mon, 30 Jan 2023 17:20:33 -0500
X-MC-Unique: qoh5nZAaPRa1CU1j-9GK8A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78C741C06918;
        Mon, 30 Jan 2023 22:20:33 +0000 (UTC)
Received: from localhost (unknown [10.39.195.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1303492B05;
        Mon, 30 Jan 2023 22:20:32 +0000 (UTC)
Date:   Mon, 30 Jan 2023 17:20:30 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V4 0/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Message-ID: <Y9hCrrTYnFf+1Z2Y@fedora>
References: <20230106041711.914434-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GCi/UuuoliWJorVU"
Content-Disposition: inline
In-Reply-To: <20230106041711.914434-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--GCi/UuuoliWJorVU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 12:17:05PM +0800, Ming Lei wrote:
> Hello,
>=20
> Stefan Hajnoczi suggested un-privileged ublk device[1] for container
> use case.
>=20
> So far only administrator can create/control ublk device which is too
> strict and increase system administrator burden, and this patchset
> implements un-privileged ublk device:
>=20
> - any user can create ublk device, which can only be controlled &
>   accessed by the owner of the device or administrator
>=20
> For using such mechanism, system administrator needs to deploy two
> simple udev rules[2] after running 'make install' in ublksrv.
>=20
> Userspace(ublksrv):
>=20
> 	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk
>    =20
> 'ublk add -t $TYPE --un_privileged' is for creating one un-privileged
> ublk device if the user is un-privileged.

Hi Ming,
Sorry for the late reply. Is there anything stopping processes with a
different uid/gid from accessing the unprivileged block device
(/dev/ublkbN)?

The scenario I'm thinking about is:
1. Evil user runs "chmod 666 /dev/ublkbN". They are allowed to do this
   because they are the owner of the block device node.
2. Evil user causes another user's process (e.g. suid) to open the block
   device.
3. Evil user's ublksrv either abuses timing (e.g. never responding or
   responding after an artifical delay) to DoS or returns corrupted data
   to exploit bugs in the victim process.

FUSE has exactly the same issue and I think that's why an unprivileged
FUSE mount cannot be accessed by processes with a different uid/gid.

That extra protection is probably necessary for ublk too.

Stefan

>=20
>=20
> [1] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.loca=
ldomain/
> [2] https://github.com/ming1/ubdsrv/blob/unprivileged-ublk/README.rst#un-=
privileged-mode
>=20
> V4:
> 	- only allow to create unprivileged udev for current user, as
> 	  suggested by Jonathan Corbet
> 	- fix misc bug for handling failure
> 	- add detailed document
> 	- update userspace
>=20
> V3:
> 	- don't warn on invalid user input for setting devt parameter, as
> 	  suggested by Ziyang, patch 4/6
> 	- fix one memory corruption issue, patch 6/6
>=20
> V2:
> 	- fix "ublk_ctrl_uring_cmd_permission() error: uninitialized symbol 'mas=
k'", reported
> 	by  Dan Carpenter' test robot
> 	- address Ziyang's comment on dealing with nr_privileged_daemon
>=20
>=20
>=20
> Ming Lei (6):
>   ublk_drv: remove nr_aborted_queues from ublk_device
>   ublk_drv: don't probe partitions if the ubq daemon isn't trusted
>   ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
>   ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT
>   ublk_drv: add module parameter of ublks_max for limiting max allowed
>     ublk dev
>   ublk_drv: add mechanism for supporting unprivileged ublk device
>=20
>  Documentation/block/ublk.rst  |  49 ++++-
>  drivers/block/ublk_drv.c      | 341 ++++++++++++++++++++++++----------
>  include/uapi/linux/ublk_cmd.h |  49 ++++-
>  3 files changed, 332 insertions(+), 107 deletions(-)
>=20
> --=20
> 2.31.1
>=20

--GCi/UuuoliWJorVU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPYQq4ACgkQnKSrs4Gr
c8jSVAgAyCKmn+0SNZSu+vIvt+/3XSkQgv01eibVmgOgLc9B9LOdOKHFPKbGH/Cr
L7UAi3ncyzp6zwzLIRpx5sjcEi2rjaG6bsTgyCHYoYurdsYS0x9Vl51X2QqQPXzT
NS7LGaMiFM3NBl4sijBrmx6mdpQpyUXqSf8KAY1+0DKPbHhATjMXiWiiQySpn3DL
tucxlsshchkaurfk3sPeEOaxxfrnzCHOB99edqoQLmqnLCtdHDHFKK3wlc1B8SlA
Qae1V4cS4pm5NnTSQZHnk1PNObO7HQNVwXW6gIyhUWcDccB0cCs0w9nxdb7w9m5y
d6jvG/gskv7Yg3fmwaEpDYMIHT5H9Q==
=DWFc
-----END PGP SIGNATURE-----

--GCi/UuuoliWJorVU--

