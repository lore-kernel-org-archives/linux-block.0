Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7E2ECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 12:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiIAMIt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiIAMIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 08:08:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA29EA30B
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 05:08:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x23so16888740pll.7
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=as9vF0Li77PwK27UuB15yePFLbkIPRAAeqJEczTI4ok=;
        b=GtuGtksie4fGpdrHP346Ea5oO0gxvkgZu5TXu8pD9jkRfj40237B7P7e4I55OX4lOv
         EYjQNqVVUokweZGVrfnRHissiZj2Kd3/OIw8WuvG3fVo5YPfnrHFZQ1SUfKadrYN0dwI
         nyxDyVU6iJTOw+bad1nUYYEzTJprweCuPI/ZYY6/oFOP3tQ3RUAXBJS/DjTfLVweCOiz
         Iv5YFnUAWO39HFXMFjBhtdYL2FzzyzzFXCTlWychR7vqnAlZa5Z3G8HNS3opw8JGi/4H
         RRq3+w67Yr7j6EopbnSNm2ZqnfztZcvct//5DYiwn8gH1iHcXAIB9x5Oda8bNNRp6kkU
         f32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=as9vF0Li77PwK27UuB15yePFLbkIPRAAeqJEczTI4ok=;
        b=hYAUTN1F1su7LKeeEVDJbTURz0YM2L48sYdHXe3w4rUo8S1fLMdJpaPkGRczZHkuC+
         MuAzt+VkUh5CB3XZAoKqkqG7Igh5G+jdqdf8oc1A4+K/qUe6yUOtcZSjFj0fVRrkZ7Lm
         J2U3WuwZvV/M5/v6wIMw8kzDtWejs0xNBl4XYcgY1CX5VV6q8wl2YYUpw7mZ0ox6OY/4
         G22f0B4eo5ik+S/B85/NvKUJXxL+fiCPxGClkaJ9pPbBIkAhk/rtohG3ISc2Iapp/uC8
         +PxOWUICx2zugY8CK5vmn72ZNab5PBJ0XPfrD8DVqz2X2u9WHQqEKXRxLSN0YzgTgdGy
         9AsQ==
X-Gm-Message-State: ACgBeo09K/0Wopoq4ic85IdjwOzIupQKhR1oUK/x59StbdrIdHQRe7WU
        lg+L2gn9nhMZkgmvfOnnzI9Y+48XUh0=
X-Google-Smtp-Source: AA6agR6MIGgVuXmDgu/rFaU8UiMjkvdStA3ipYu31MsMmKef7E6aAGRPcaMeWxYrHHAYMhJItmzxJA==
X-Received: by 2002:a17:90b:4ad0:b0:1fe:1898:da1f with SMTP id mh16-20020a17090b4ad000b001fe1898da1fmr8201116pjb.197.1662034112576;
        Thu, 01 Sep 2022 05:08:32 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-66.three.co.id. [223.255.225.66])
        by smtp.gmail.com with ESMTPSA id o1-20020a635a01000000b0042fe1914e26sm4593678pgb.37.2022.09.01.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:08:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DE3E41039D6; Thu,  1 Sep 2022 19:08:27 +0700 (WIB)
Date:   Thu, 1 Sep 2022 19:08:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/1] Docs: ublk: add ublk document
Message-ID: <YxCgu2eNnwtlHvlv@debian.me>
References: <20220901023008.669893-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PQJyOQxHqxQMcA53"
Content-Disposition: inline
In-Reply-To: <20220901023008.669893-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--PQJyOQxHqxQMcA53
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 10:30:08AM +0800, Ming Lei wrote:
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> new file mode 100644
> index 000000000000..c3ab9888f7d5
> --- /dev/null
> +++ b/Documentation/block/ublk.rst
> @@ -0,0 +1,245 @@
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
> +It is very helpful to move virtual block drivers into userspace, such as=
 loop,
> +nbd and similar virtual block drivers. It can help to implement new virt=
ual
> +block device, such as ublk-qcow2, and there was several attempts of
> +implementing qcow2 driver in kernel.
> +
> +Userspace block devices are attractive because:
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

Doing htmldocs build, I see two new warnings:

Documentation/block/ublk.rst:22: WARNING: Unexpected indentation.
Documentation/block/ublk.rst:23: WARNING: Block quote ends without a blank =
line; unexpected unindent.

I have applied the fixup:

---- >8 ----

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index c3ab9888f7d5d4..bf2ac1591328be 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -14,6 +14,7 @@ block device, such as ublk-qcow2, and there was several a=
ttempts of
 implementing qcow2 driver in kernel.
=20
 Userspace block devices are attractive because:
+
 - They can be written many programming languages.
 - They can use libraries that are not available in the kernel.
 - They can be debugged with tools familiar to application developers.

> +ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO reque=
st
> +on the device will be forwarded to ublk userspace program. For convenien=
ce of
> +reference, in this document, ``ublk server`` represents generic ublk use=
rspace
> +program. ``ublksrv`` [#userspace]_ is one ublk server implementation, an=
d it
> +provides ``libublksrv`` [#userspace_lib]_ library for developing specific
> +user block device conveniently, meantime generic type block device is in=
cluded,
> +such as loop and null. Richard W.M. Jones wrote userspace nbd device
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
this
> +extendable interface. Thus ublk is generic userspace block device framew=
ork.
> +For example, it is easy to setup one ublk device with specified block
> +parameters from userspace.
> +
> +Using ublk
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ublk requires userspace ublk server to handle real block device logic. F=
or
> +example of ``ublksrv`` [#userspace]_, user can use ublk device in the
> +following way:
> +
> +Below is example of using ublk as loop device.
> +
> +- add ublk device::
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
> +- get ublk dev info::
> +
> +     ublk list
> +
> +- delete ublk device::
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
> +  Add one ublk char device (``/dev/ublkc*``) which is talked with ublk s=
erver
> +  WRT IO command communication. Basic device info is sent together with =
this
> +  command. It sets UAPI structure of ``ublksrv_ctrl_dev_info``,
> +  such as ``nr_hw_queues``, ``queue_depth``, and max IO request buffer s=
ize,
> +  for which the info is negotiated with ublk driver and sent back to ubl=
k server.
> +  After this command is completed, the basic device info is immutable.
> +
> +- ``UBLK_CMD_SET_PARAMS`` / ``UBLK_CMD_GET_PARAMS``
> +
> +  Set or get ublk device's parameters, which can be either generic featu=
re
> +  related, or request queue limit related, but can't be IO logic specifi=
c,
> +  because ublk driver does not handle any IO logic. This command has to =
be
> +  sent before sending ``UBLK_CMD_START_DEV``.
> +
> +- ``UBLK_CMD_START_DEV``
> +
> +  After ublk server prepares userspace resources (such as creating per-q=
ueue
> +  pthread & io_uring for handling ublk IO), this command is sent to ublk
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
> +  When ``/dev/ublkc`` is added, ublk driver creates block layer tagset, =
so
> +  that each
> +  queue's affinity info is available. ublk server sends
> +  ``UBLK_CMD_GET_QUEUE_AFFINITY``
> +  to retrieve queue affinity info. It can setup the per-queue context
> +  efficiently, such as bind affine CPUs with IO pthread and try to alloc=
ate
> +  buffers in IO thread context.
> +
> +- ``UBLK_CMD_GET_DEV_INFO``
> +
> +  For retrieving device info via ``ublksrv_ctrl_dev_info``. It is ublk s=
erver's
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
> +ublk server's IO is assigned by a unique tag, which is 1:1 mapping with =
IO
> +request of ``/dev/ublkb*``.
> +
> +UAPI structure of ``ublksrv_io_desc`` is defined for describing each IO =
=66rom
> +ublk driver. A fixed mmaped area (array) on ``/dev/ublkc*`` is provided =
for
> +exporting IO info to ublk server; such as IO offset, length, OP/flags and
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
> +  Sent from ublk server IO pthread for fetching future incoming IO reque=
sts
> +  destined to ``/dev/ublkb*``. This command is sent only once from ublk =
server IO
> +  pthread for ublk driver to setup IO forward environment.
> +
> +- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
> +
> +  When an IO request is destined to ``/dev/ublkb*``, ublk driver stores
> +  the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
> +  previous received IO command of this IO tag (either UBLK_IO_FETCH_REQ =
or
> +  UBLK_IO_COMMIT_AND_FETCH_REQ) is completed, so ublk server gets the IO
> +  notification via io_uring.
> +
> +  After ublk server handles the IO, its result is committed back to ublk
> +  driver by sending ``UBLK_IO_COMMIT_AND_FETCH_REQ`` back. Once ublkdrv
> +  received this command, it parses the result and complete the request to
> +  ``/dev/ublkb*``. In the meantime setup environment for fetching future
> +  requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ=
``
> +  is reused for both fetching request and committing back IO result.
> +
> +- ``UBLK_IO_NEED_GET_DATA``
> +
> +  ublk server pre-allocates IO buffer for each IO by default. Any new pr=
ojects
> +  should use this buffer to communicate with ublk driver. However, exist=
ing
> +  projects may break or not able to consume the new buffer interface; th=
at's
> +  why this command is added for backwards compatibility so that existing
> +  projects can still consume existing buffers.
> +
> +- data copy between ublk server IO buffer and ublk block IO request
> +
> +  ublk driver needs to copy the block IO request pages into ublk server =
buffer
> +  (pages) first for WRITE before notifying ublk server of the coming IO,=
 so
> +  that ublk server can handle WRITE request.
> +
> +  When ublk server handles READ request and sends ``UBLK_IO_COMMIT_AND_F=
ETCH_REQ``
> +  to ublk server, ublkdrv needs to copy read ublk server buffer (pages) =
to the IO
> +  request pages.
> +
> +Future development
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Container-aware ublk deivice
> +----------------------------
> +
> +ublk driver doesn't handle any IO logic. Its function is well defined
> +for now, and very limited userspace interfaces are needed, which is also
> +well defined too. It is possible to make ublk devices container-aware bl=
ock
> +devices in future as Stefan Hajnoczi suggested [#stefan]_, by removing
> +ADMIN privilege.
> +
> +Zero copy
> +---------
> +
> +Zero copy is a generic requirement for nbd, fuse or similar drivers, one
> +problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to usersp=
ace
> +can't be remapped any more in kernel with existing mm interfaces. This c=
an
> +occurs when destining direct IO to ``/dev/ublkb*``. Also he reported that
> +big requests (>=3D 256 KB IO) may benefit a lot from zero copy.
> +
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. [#userspace] https://github.com/ming1/ubdsrv
> +
> +.. [#userspace_lib] https://github.com/ming1/ubdsrv/tree/master/lib
> +
> +.. [#userspace_nbdublk] https://gitlab.com/rwmjones/libnbd/-/tree/nbdublk
> +
> +.. [#userspace_readme] https://github.com/ming1/ubdsrv/blob/master/README
> +
> +.. [#stefan] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefan=
ha-x1.localdomain/
> +
> +.. [#xiaoguang] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@ste=
fanha-x1.localdomain/

Also, the grammar can be improved, like:

---- >8 ----

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index bf2ac1591328be..81a6c81f997409 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -8,10 +8,10 @@ Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
 ublk is a generic framework for implementing block device logic from users=
pace.
-It is very helpful to move virtual block drivers into userspace, such as l=
oop,
-nbd and similar virtual block drivers. It can help to implement new virtual
-block device, such as ublk-qcow2, and there was several attempts of
-implementing qcow2 driver in kernel.
+The motivation behind it is moving virtual block drivers into userspace,
+such as loop, nbd and similar can be very helpful. It can help to implement
+new virtual block device such as ublk-qcow2 (there was several attempts of
+implementing qcow2 driver in kernel).
=20
 Userspace block devices are attractive because:
=20
@@ -26,12 +26,12 @@ Userspace block devices are attractive because:
   parameters/setting for test/debug purpose
=20
 ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO request
-on the device will be forwarded to ublk userspace program. For convenience=
 of
-reference, in this document, ``ublk server`` represents generic ublk users=
pace
-program. ``ublksrv`` [#userspace]_ is one ublk server implementation, and =
it
+on the device will be forwarded to ublk userspace program. For convenience,
+in this document, ``ublk server`` refers to generic ublk userspace
+program. ``ublksrv`` [#userspace]_ is one of such implementation. It
 provides ``libublksrv`` [#userspace_lib]_ library for developing specific
-user block device conveniently, meantime generic type block device is incl=
uded,
-such as loop and null. Richard W.M. Jones wrote userspace nbd device
+user block device conveniently, while also generic type block device is
+included, such as loop and null. Richard W.M. Jones wrote userspace nbd de=
vice
 ``nbdublk`` [#userspace_nbdublk]_  based on ``libublksrv`` [#userspace_lib=
]_.
=20
 After the IO is handled by userspace, the result is committed back to the
@@ -53,21 +53,19 @@ based approach too.
=20
 ublk provides control interface to set/get ublk block device parameters.
 The interface is extendable and kabi compatible: basically any ublk request
-queue's parameter or ublk generic feature parameters can be set/get via th=
is
-extendable interface. Thus ublk is generic userspace block device framewor=
k.
-For example, it is easy to setup one ublk device with specified block
+queue's parameter or ublk generic feature parameters can be set/get via the
+interface. Thus, ublk is generic userspace block device framework.
+For example, it is easy to setup a ublk device with specified block
 parameters from userspace.
=20
 Using ublk
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-ublk requires userspace ublk server to handle real block device logic. For
-example of ``ublksrv`` [#userspace]_, user can use ublk device in the
-following way:
+ublk requires userspace ublk server to handle real block device logic.
=20
-Below is example of using ublk as loop device.
+Below is example of using ``ublksrv`` to provide ublk-based loop device.
=20
-- add ublk device::
+- add a device::
=20
      ublk add -t loop -f ublk-loop.img
=20
@@ -79,11 +77,11 @@ Below is example of using ublk as loop device.
      ...
      umount /mnt
=20
-- get ublk dev info::
+- list the devices with their info::
=20
      ublk list
=20
-- delete ublk device::
+- delete the device::
=20
      ublk del -a
      ublk del -n $ublk_dev_id
@@ -101,24 +99,24 @@ managing and controlling ublk devices with help of sev=
eral control commands:
=20
 - ``UBLK_CMD_ADD_DEV``
=20
-  Add one ublk char device (``/dev/ublkc*``) which is talked with ublk ser=
ver
+  Add a ublk char device (``/dev/ublkc*``) which is talked with ublk server
   WRT IO command communication. Basic device info is sent together with th=
is
   command. It sets UAPI structure of ``ublksrv_ctrl_dev_info``,
   such as ``nr_hw_queues``, ``queue_depth``, and max IO request buffer siz=
e,
-  for which the info is negotiated with ublk driver and sent back to ublk =
server.
-  After this command is completed, the basic device info is immutable.
+  for which the info is negotiated with the driver and sent back to the se=
rver.
+  When this command is completed, the basic device info is immutable.
=20
 - ``UBLK_CMD_SET_PARAMS`` / ``UBLK_CMD_GET_PARAMS``
=20
-  Set or get ublk device's parameters, which can be either generic feature
+  Set or get parameters of the device, which can be either generic feature
   related, or request queue limit related, but can't be IO logic specific,
-  because ublk driver does not handle any IO logic. This command has to be
+  because the driver does not handle any IO logic. This command has to be
   sent before sending ``UBLK_CMD_START_DEV``.
=20
 - ``UBLK_CMD_START_DEV``
=20
-  After ublk server prepares userspace resources (such as creating per-que=
ue
-  pthread & io_uring for handling ublk IO), this command is sent to ublk
+  After the server prepares userspace resources (such as creating per-queue
+  pthread & io_uring for handling ublk IO), this command is sent to the
   driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
   ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
=20
@@ -135,17 +133,15 @@ managing and controlling ublk devices with help of se=
veral control commands:
=20
 - ``UBLK_CMD_GET_QUEUE_AFFINITY``
=20
-  When ``/dev/ublkc`` is added, ublk driver creates block layer tagset, so
-  that each
-  queue's affinity info is available. ublk server sends
-  ``UBLK_CMD_GET_QUEUE_AFFINITY``
-  to retrieve queue affinity info. It can setup the per-queue context
-  efficiently, such as bind affine CPUs with IO pthread and try to allocate
-  buffers in IO thread context.
+  When ``/dev/ublkc`` is added, the driver creates block layer tagset, so
+  that each queue's affinity info is available. The server sends
+  ``UBLK_CMD_GET_QUEUE_AFFINITY`` to retrieve queue affinity info. It can
+  set up the per-queue context efficiently, such as bind affine CPUs with =
IO
+  pthread and try to allocate buffers in IO thread context.
=20
 - ``UBLK_CMD_GET_DEV_INFO``
=20
-  For retrieving device info via ``ublksrv_ctrl_dev_info``. It is ublk ser=
ver's
+  For retrieving device info via ``ublksrv_ctrl_dev_info``. It is the serv=
er's
   responsibility to save IO target specific info in userspace.
=20
 Data plane
@@ -156,12 +152,12 @@ commands via io_uring passthrough. The per-queue IO p=
thread
 focuses on IO handling and shouldn't handle any control & management
 tasks.
=20
-ublk server's IO is assigned by a unique tag, which is 1:1 mapping with IO
+The's IO is assigned by a unique tag, which is 1:1 mapping with IO
 request of ``/dev/ublkb*``.
=20
 UAPI structure of ``ublksrv_io_desc`` is defined for describing each IO fr=
om
 ublk driver. A fixed mmaped area (array) on ``/dev/ublkc*`` is provided for
-exporting IO info to ublk server; such as IO offset, length, OP/flags and
+exporting IO info to the server; such as IO offset, length, OP/flags and
 buffer address. Each ``ublksrv_io_desc`` instance can be indexed via queue=
 id
 and IO tag directly.
=20
@@ -171,19 +167,19 @@ with specified IO tag in the command data:
=20
 - ``UBLK_IO_FETCH_REQ``
=20
-  Sent from ublk server IO pthread for fetching future incoming IO requests
-  destined to ``/dev/ublkb*``. This command is sent only once from ublk se=
rver IO
-  pthread for ublk driver to setup IO forward environment.
+  Sent from the server IO pthread for fetching future incoming IO requests
+  destined to ``/dev/ublkb*``. This command is sent only once from the ser=
ver
+  IO pthread for ublk driver to setup IO forward environment.
=20
 - ``UBLK_IO_COMMIT_AND_FETCH_REQ``
=20
-  When an IO request is destined to ``/dev/ublkb*``, ublk driver stores
+  When an IO request is destined to ``/dev/ublkb*``, the driver stores
   the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
-  previous received IO command of this IO tag (either UBLK_IO_FETCH_REQ or
-  UBLK_IO_COMMIT_AND_FETCH_REQ) is completed, so ublk server gets the IO
-  notification via io_uring.
+  previous received IO command of this IO tag (either ``UBLK_IO_FETCH_REQ``
+  or ``UBLK_IO_COMMIT_AND_FETCH_REQ)`` is completed, so the server gets
+  the IO notification via io_uring.
=20
-  After ublk server handles the IO, its result is committed back to ublk
+  After the server handles the IO, its result is committed back to the
   driver by sending ``UBLK_IO_COMMIT_AND_FETCH_REQ`` back. Once ublkdrv
   received this command, it parses the result and complete the request to
   ``/dev/ublkb*``. In the meantime setup environment for fetching future
@@ -192,7 +188,7 @@ with specified IO tag in the command data:
=20
 - ``UBLK_IO_NEED_GET_DATA``
=20
-  ublk server pre-allocates IO buffer for each IO by default. Any new proj=
ects
+  The server pre-allocates IO buffer for each IO by default. Any new proje=
cts
   should use this buffer to communicate with ublk driver. However, existing
   projects may break or not able to consume the new buffer interface; that=
's
   why this command is added for backwards compatibility so that existing
@@ -200,13 +196,13 @@ with specified IO tag in the command data:
=20
 - data copy between ublk server IO buffer and ublk block IO request
=20
-  ublk driver needs to copy the block IO request pages into ublk server bu=
ffer
-  (pages) first for WRITE before notifying ublk server of the coming IO, so
-  that ublk server can handle WRITE request.
+  The driver needs to copy the block IO request pages into the server buff=
er
+  (pages) first for WRITE before notifying the server of the coming IO, so
+  that the server can handle WRITE request.
=20
-  When ublk server handles READ request and sends ``UBLK_IO_COMMIT_AND_FET=
CH_REQ``
-  to ublk server, ublkdrv needs to copy read ublk server buffer (pages) to=
 the IO
-  request pages.
+  When the server handles READ request and sends
+  ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
+  the server buffer (pages) read to the IO request pages.
=20
 Future development
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -215,7 +211,7 @@ Container-aware ublk deivice
 ----------------------------
=20
 ublk driver doesn't handle any IO logic. Its function is well defined
-for now, and very limited userspace interfaces are needed, which is also
+for now and very limited userspace interfaces are needed, which is also
 well defined too. It is possible to make ublk devices container-aware block
 devices in future as Stefan Hajnoczi suggested [#stefan]_, by removing
 ADMIN privilege.
@@ -223,7 +219,7 @@ ADMIN privilege.
 Zero copy
 ---------
=20
-Zero copy is a generic requirement for nbd, fuse or similar drivers, one
+Zero copy is a generic requirement for nbd, fuse or similar drivers. A
 problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to userspace
 can't be remapped any more in kernel with existing mm interfaces. This can
 occurs when destining direct IO to ``/dev/ublkb*``. Also he reported that

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--PQJyOQxHqxQMcA53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxCgtAAKCRD2uYlJVVFO
o9BxAQDW+YM2I+8MqmFb0QDeZbJbggrOYuqmWRxuCwlZtKdvVgD/QkDbu4Chb6/t
/vGFUB9T6hAdfa3gFRDptyK99/sJTgQ=
=kozG
-----END PGP SIGNATURE-----

--PQJyOQxHqxQMcA53--
