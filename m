Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A98DECAAD5
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 09:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiIBJNO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIBJNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 05:13:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CDC2751;
        Fri,  2 Sep 2022 02:13:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fa2so1451869pjb.2;
        Fri, 02 Sep 2022 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xJWNcEKrbqGvMnptnpAIci0nECqFzTViODL9q0VV44Q=;
        b=de5f3mLgL+97J3egfdfHJS7iA5RZGH9aTYHjVMg1VzsCcDcWreww3O4UTOxCi3ICEC
         oX+AUWdZi/75xlhguRhgVpPd9hOzc4a0Zqs9G9eiTeqzVwILiFuxXo6MdBxUM3jH6v2m
         UoNrL7sSnrirYXm1+xvTGDQZOzCl6Sb4+5yVMA7NLh5X5zOKpxuuDjV51bFlukWbWaAG
         1z6ckVzPRJblLIzkWalkX8lnXl4BIIRyV39sIzDDir4/LFYVeJGhJA/CVwmyGU4Lk2yC
         xKAKUHjkza48davNWSDtZjMn3cKocbDFL8MH7cqj6sm65caV+LjtcFbp2Q8odbF0uQwm
         cxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xJWNcEKrbqGvMnptnpAIci0nECqFzTViODL9q0VV44Q=;
        b=CtSTnqr1Zr+fxHCZo60OiXl4VaAgPMRtFvi0E+SDP9S7fEVY9HP67CF1GaYWiBt4Xw
         /c1FbOtqOSrH1k8dG5f2fiN2XjC18JBCnbZfU+4DS+cA+7CEt3dtwBt+JLI9OhBSsqNC
         MqBEPKofSWuh4xw51ZtFgZrJN7Zs4vT4BkPUTHtx6XFYQHZqTa/tSTR27BofdlPCd4Rx
         aSG7NJxhPhBjh2SPN41JkcbpcfVavHyG/6Xj+aL0qSetVszd0brIktIin4F4YJw/DOSv
         30LqwRx8ELh2C0wPUeDrdzyfbZXTaSSPUSz5mvUTXsD0MA8i+tEbFyI384Iam6bVkAwf
         PmeQ==
X-Gm-Message-State: ACgBeo3gVpLOM+YUjkws9b9xwsY713tFuO+8GGajpP06DzeJW7PB1zqY
        z1LTrEZlWwXM+tyW+HJmetI2b0u+qCQ=
X-Google-Smtp-Source: AA6agR5nYpppJx8AToHzfEr6pQVCtDBp4ztN8J1smoh4ayv1j0hkEk39xulMlzOLN0Y0K2VzWflzwQ==
X-Received: by 2002:a17:902:e5c7:b0:174:e71e:30ef with SMTP id u7-20020a170902e5c700b00174e71e30efmr20444272plf.30.1662109990728;
        Fri, 02 Sep 2022 02:13:10 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-53.three.co.id. [116.206.28.53])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e80100b00173164792aasm1099473plg.127.2022.09.02.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:13:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A7423103A73; Fri,  2 Sep 2022 16:13:06 +0700 (WIB)
Date:   Fri, 2 Sep 2022 16:13:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V3 1/1] Docs: ublk: add ublk document
Message-ID: <YxHJIjaS6D+titXR@debian.me>
References: <20220901133022.698343-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wp2iP4E+b5SqykP4"
Content-Disposition: inline
In-Reply-To: <20220901133022.698343-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--wp2iP4E+b5SqykP4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 09:30:22PM +0800, Ming Lei wrote:
> Add documentation for ublk subsystem. It was supposed to be documented wh=
en
> merging the driver, but missing at that time.
>=20

The subject line should be "Documentation: document ublk"

> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Userspace block device driver (ublk driver)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ublk is a generic framework for implementing block device logic from use=
rspace.
> +The motivation behind it is moving virtual block drivers into userspace,
> +such as loop, nbd and similar can be very helpful. It can help to implem=
ent
> +new virtual block device such as ublk-qcow2 (there was several attempts =
of
> +implementing qcow2 driver in kernel).
> +
> +Userspace block devices are attractive because:
> +
> +- They can be written many programming languages.
> +- They can use libraries that are not available in the kernel.
> +- They can be debugged with tools familiar to application developers.
> +- Crashes do not kernel panic the machine.
> +- Bugs are likely to have a lower security impact than bugs in kernel
> +  code.
> +- They can be installed and updated independently of the kernel.
> +- They can be used to simulate block device easily with user specified
> +  parameters/setting for test/debug purpose
> +
> +ublk block device (``/dev/ublkb*``) is added by ublk driver. Any IO requ=
est
> +on the device will be forwarded to ublk userspace program. For convenien=
ce,
> +in this document, ``ublk server`` refers to generic ublk userspace
> +program. ``ublksrv`` [#userspace]_ is one of such implementation. It
> +provides ``libublksrv`` [#userspace_lib]_ library for developing specific
> +user block device conveniently, while also generic type block device is
> +included, such as loop and null. Richard W.M. Jones wrote userspace nbd =
device
> +``nbdublk`` [#userspace_nbdublk]_  based on ``libublksrv`` [#userspace_l=
ib]_.
> +
> +After the IO is handled by userspace, the result is committed back to the
> +driver, thus completing the request cycle. This way, any specific IO han=
dling
> +logic is totally done by userspace, such as loop's IO handling, NBD's IO
> +communication, or qcow2's IO mapping.
> +
> +``/dev/ublkb*`` is driven by blk-mq request-based driver. Each request is
> +assigned by one queue wide unique tag. ublk server assigns unique tag to=
 each
> +IO too, which is 1:1 mapped with IO of ``/dev/ublkb*``.
> +
> +Both the IO request forward and IO handling result committing are done v=
ia
> +``io_uring`` passthrough command; that is why ublk is also one io_uring =
based
> +block driver. It has been observed that using io_uring passthrough comma=
nd can
> +give better IOPS than block IO; which is why ublk is one of high perform=
ance
> +implementation of userspace block device: not only IO request communicat=
ion is
> +done by io_uring, but also the preferred IO handling in ublk server is i=
o_uring
> +based approach too.
> +
> +ublk provides control interface to set/get ublk block device parameters.
> +The interface is extendable and kabi compatible: basically any ublk requ=
est
> +queue's parameter or ublk generic feature parameters can be set/get via =
the
> +interface. Thus, ublk is generic userspace block device framework.
> +For example, it is easy to setup a ublk device with specified block
> +parameters from userspace.
> +
> +Using ublk
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ublk requires userspace ublk server to handle real block device logic.
> +
> +Below is example of using ``ublksrv`` to provide ublk-based loop device.
> +
> +- add a device::
> +
> +     ublk add -t loop -f ublk-loop.img
> +
> +- format with xfs, then use it::
> +
> +     mkfs.xfs /dev/ublkb0
> +     mount /dev/ublkb0 /mnt
> +     # do anything. all IOs are handled by io_uring
> +     ...
> +     umount /mnt
> +
> +- list the devices with their info::
> +
> +     ublk list
> +
> +- delete the device::
> +
> +     ublk del -a
> +     ublk del -n $ublk_dev_id
> +
> +See usage details in README of ``ublksrv`` [#userspace_readme]_.
> +
> +Design
> +=3D=3D=3D=3D=3D=3D
> +
> +Control plane
> +-------------
> +
> +ublk driver provides global misc device node (``/dev/ublk-control``) for
> +managing and controlling ublk devices with help of several control comma=
nds:
> +
> +- ``UBLK_CMD_ADD_DEV``
> +
> +  Add a ublk char device (``/dev/ublkc*``) which is talked with ublk ser=
ver
> +  WRT IO command communication. Basic device info is sent together with =
this
> +  command. It sets UAPI structure of ``ublksrv_ctrl_dev_info``,
> +  such as ``nr_hw_queues``, ``queue_depth``, and max IO request buffer s=
ize,
> +  for which the info is negotiated with the driver and sent back to the =
server.
> +  When this command is completed, the basic device info is immutable.
> +
> +- ``UBLK_CMD_SET_PARAMS`` / ``UBLK_CMD_GET_PARAMS``
> +
> +  Set or get parameters of the device, which can be either generic featu=
re
> +  related, or request queue limit related, but can't be IO logic specifi=
c,
> +  because the driver does not handle any IO logic. This command has to be
> +  sent before sending ``UBLK_CMD_START_DEV``.
> +
> +- ``UBLK_CMD_START_DEV``
> +
> +  After the server prepares userspace resources (such as creating per-qu=
eue
> +  pthread & io_uring for handling ublk IO), this command is sent to the
> +  driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
> +  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
> +
> +- ``UBLK_CMD_STOP_DEV``
> +
> +  Halt IO on ``/dev/ublkb*`` and remove the device. When this command re=
turns,
> +  ublk server will release resources (such as destroying per-queue pthre=
ad &
> +  io_uring).
> +
> +- ``UBLK_CMD_DEL_DEV``
> +
> +  Remove ``/dev/ublkc*``. When this command returns, the allocated ublk =
device
> +  number can be reused.
> +
> +- ``UBLK_CMD_GET_QUEUE_AFFINITY``
> +
> +  When ``/dev/ublkc`` is added, the driver creates block layer tagset, so
> +  that each queue's affinity info is available. The server sends
> +  ``UBLK_CMD_GET_QUEUE_AFFINITY`` to retrieve queue affinity info. It can
> +  set up the per-queue context efficiently, such as bind affine CPUs wit=
h IO
> +  pthread and try to allocate buffers in IO thread context.
> +
> +- ``UBLK_CMD_GET_DEV_INFO``
> +
> +  For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the se=
rver's
> +  responsibility to save IO target specific info in userspace.
> +
> +Data plane
> +----------
> +
> +ublk server needs to create per-queue IO pthread & io_uring for handling=
 IO
> +commands via io_uring passthrough. The per-queue IO pthread
> +focuses on IO handling and shouldn't handle any control & management
> +tasks.
> +
> +The's IO is assigned by a unique tag, which is 1:1 mapping with IO
> +request of ``/dev/ublkb*``.
> +
> +UAPI structure of ``ublksrv_io_desc`` is defined for describing each IO =
=66rom
> +ublk driver. A fixed mmaped area (array) on ``/dev/ublkc*`` is provided =
for
> +exporting IO info to the server; such as IO offset, length, OP/flags and
> +buffer address. Each ``ublksrv_io_desc`` instance can be indexed via que=
ue id
> +and IO tag directly.
> +
> +The following IO commands are communicated via io_uring passthrough comm=
and,
> +and each command is only for forwarding ublk IO and committing IO result
> +with specified IO tag in the command data:
> +
> +- ``UBLK_IO_FETCH_REQ``
> +
> +  Sent from the server IO pthread for fetching future incoming IO reques=
ts
> +  destined to ``/dev/ublkb*``. This command is sent only once from the s=
erver
> +  IO pthread for ublk driver to setup IO forward environment.
> +
> +- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
> +
> +  When an IO request is destined to ``/dev/ublkb*``, the driver stores
> +  the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
> +  previous received IO command of this IO tag (either ``UBLK_IO_FETCH_RE=
Q``
> +  or ``UBLK_IO_COMMIT_AND_FETCH_REQ)`` is completed, so the server gets
> +  the IO notification via io_uring.
> +
> +  After the server handles the IO, its result is committed back to the
> +  driver by sending ``UBLK_IO_COMMIT_AND_FETCH_REQ`` back. Once ublkdrv
> +  received this command, it parses the result and complete the request to
> +  ``/dev/ublkb*``. In the meantime setup environment for fetching future
> +  requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ=
``
> +  is reused for both fetching request and committing back IO result.
> +
> +- ``UBLK_IO_NEED_GET_DATA``
> +
> +  With ``UBLK_F_NEED_GET_DATA`` enabled, the WRITE request will be first=
ly
> +  issued to ublk server without data copy. Then, IO backend of ublk serv=
er
> +  receives the request and it can allocate data buffer and embed its addr
> +  inside this new io command. After the kernel driver gets the command,
> +  data copy is done from request pages to this backend's buffer. Finally,
> +  backend receives the request again with data to be written and it can
> +  truly handle the request.
> +
> +  ``UBLK_IO_NEED_GET_DATA`` adds one additional round-trip and one
> +  io_uring_enter() syscall. Any user thinks that it may lower performance
> +  should not enable UBLK_F_NEED_GET_DATA. ublk server pre-allocates IO
> +  buffer for each IO by default. Any new project should try to use this
> +  buffer to communicate with ublk driver. However, existing project may
> +  break or not able to consume the new buffer interface; that's why this
> +  command is added for backwards compatibility so that existing projects
> +  can still consume existing buffers.
> +
> +- data copy between ublk server IO buffer and ublk block IO request
> +
> +  The driver needs to copy the block IO request pages into the server bu=
ffer
> +  (pages) first for WRITE before notifying the server of the coming IO, =
so
> +  that the server can handle WRITE request.
> +
> +  When the server handles READ request and sends
> +  ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
> +  the server buffer (pages) read to the IO request pages.
> +
> +Future development
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Container-aware ublk deivice
> +----------------------------
> +
> +ublk driver doesn't handle any IO logic. Its function is well defined
> +for now and very limited userspace interfaces are needed, which is also
> +well defined too. It is possible to make ublk devices container-aware bl=
ock
> +devices in future as Stefan Hajnoczi suggested [#stefan]_, by removing
> +ADMIN privilege.
> +
> +Zero copy
> +---------
> +
> +Zero copy is a generic requirement for nbd, fuse or similar drivers. A
> +problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to usersp=
ace
> +can't be remapped any more in kernel with existing mm interfaces. This c=
an
> +occurs when destining direct IO to ``/dev/ublkb*``. Also he reported that
> +big requests (>=3D 256 KB IO) may benefit a lot from zero copy.
> +
> +

I also have minor grammatical fixes:

---- >8 ----

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index a102f4c1ab2eb4..2122d1a4a54196 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -8,9 +8,9 @@ Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
 ublk is a generic framework for implementing block device logic from users=
pace.
-The motivation behind it is moving virtual block drivers into userspace,
+The motivation behind it is that moving virtual block drivers into userspa=
ce,
 such as loop, nbd and similar can be very helpful. It can help to implement
-new virtual block device such as ublk-qcow2 (there was several attempts of
+new virtual block device such as ublk-qcow2 (there are several attempts of
 implementing qcow2 driver in kernel).
=20
 Userspace block devices are attractive because:
@@ -156,13 +156,13 @@ The's IO is assigned by a unique tag, which is 1:1 ma=
pping with IO
 request of ``/dev/ublkb*``.
=20
 UAPI structure of ``ublksrv_io_desc`` is defined for describing each IO fr=
om
-ublk driver. A fixed mmaped area (array) on ``/dev/ublkc*`` is provided for
+the driver. A fixed mmaped area (array) on ``/dev/ublkc*`` is provided for
 exporting IO info to the server; such as IO offset, length, OP/flags and
 buffer address. Each ``ublksrv_io_desc`` instance can be indexed via queue=
 id
 and IO tag directly.
=20
 The following IO commands are communicated via io_uring passthrough comman=
d,
-and each command is only for forwarding ublk IO and committing IO result
+and each command is only for forwarding the IO and committing the result
 with specified IO tag in the command data:
=20
 - ``UBLK_IO_FETCH_REQ``
@@ -233,8 +233,8 @@ Zero copy
 Zero copy is a generic requirement for nbd, fuse or similar drivers. A
 problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to userspace
 can't be remapped any more in kernel with existing mm interfaces. This can
-occurs when destining direct IO to ``/dev/ublkb*``. Also he reported that
-big requests (>=3D 256 KB IO) may benefit a lot from zero copy.
+occurs when destining direct IO to ``/dev/ublkb*``. Also, he reported that
+big requests (IO size >=3D 256 KB) may benefit a lot from zero copy.
=20
=20
 References

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--wp2iP4E+b5SqykP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxHJHgAKCRD2uYlJVVFO
o5lpAQD0RCbHyGJBZEHuCL8Fi8z7WStAKmDAx5KGNnXrpQDYLgEAo00UE2oJQT2h
Asz8XkB0h4zt9lmCb62Nx7N6h5wrNAI=
=65jg
-----END PGP SIGNATURE-----

--wp2iP4E+b5SqykP4--
