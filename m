Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28573ECAAD5
	for <linux-block@archiver.kernel.org>; Sun, 28 Aug 2022 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiH1Mky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Aug 2022 08:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1Mkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Aug 2022 08:40:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED0326DD;
        Sun, 28 Aug 2022 05:40:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o4so5587794pjp.4;
        Sun, 28 Aug 2022 05:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BPZMgA0LrMCcA4OrJPEFekkXiXPpmd6RqxbacAZL3DU=;
        b=MWHb2QkgvH7VGdao32pdQX2/0o9If7PZsbR6GIK9/1bOGSx7BPCJ9xYjp/h18oR9Y2
         3HumRRDFJMrL7cdJ120GTK6NJvLmNH6a6lFlm6tDQGNfcbAkNYQDRtHi7Zg44HlUbbgP
         XBY8Ty8qR9j2R2blkGU1/p21ixdtu1Ufclm5JWzzU9BAfYn7N1n2LSJ72lHAOd0Agjg8
         ftGJ+wCdjE3KBox7TmePFTPMSFma3AD1vTUV1GKbhUH0oJw+/Gcx/OrfKUuKBy6gzxeE
         OnHcJ5Ee+dpaD23TFiGQqE0tRTWLSibiqFRxIlzHdMNNitR95C4HrxnP3WuDm3tF53Pb
         1vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BPZMgA0LrMCcA4OrJPEFekkXiXPpmd6RqxbacAZL3DU=;
        b=Su+55cIRGwbhqvbPTQXDdsH3HLYqe72RYBjnmogrcSFMMoVDAPpWsJPWH0MENX+Cbd
         lLp1TuRs+jRY6/ONLUhveTEhxAtnow4hZz1n8nP4SdHKOtL6tCZpB+lAg5ClSa36NSxq
         8nldpIqidWAAa22W1XX3I4xhIqZB6qJbDpHSpByk4tDPOAngUckhlS0iu9bcYOvroh4m
         TLZTGDENv2PK0CYkd1Ob38pkvpQYe68TeAy6vV8K3JUtlvCm+0VWyoZGNzoyAQuJtUGq
         DZta9btnmWNjc4GLmGja8fx3K3rirPX3zhI+l8KQANuZzGSsRyX7TbHLGmdysC4xTcRH
         UzrQ==
X-Gm-Message-State: ACgBeo29/suGBPSFSbPZdhZy++r6Hulke7PeoSWm9H+kPMxC+CsYV+cO
        ZODZBuHwRNJBXzY6GwUTKeY=
X-Google-Smtp-Source: AA6agR6+pNWbwRWF/wfhq6I29qVwWprNz9YHKvFu4ho/MlbUXyocN2ejen88jA3ogd4F2vQQBINoSQ==
X-Received: by 2002:a17:90b:4b11:b0:1fb:248f:5ed with SMTP id lx17-20020a17090b4b1100b001fb248f05edmr13819404pjb.150.1661690450564;
        Sun, 28 Aug 2022 05:40:50 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-74.three.co.id. [180.214.233.74])
        by smtp.gmail.com with ESMTPSA id k27-20020a635a5b000000b0042aca53b4cesm3290504pgm.70.2022.08.28.05.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 05:40:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B2774103D69; Sun, 28 Aug 2022 19:40:46 +0700 (WIB)
Date:   Sun, 28 Aug 2022 19:40:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH] Docs: ublk: add ublk document
Message-ID: <YwtiTr3E4b9c+Vcl@debian.me>
References: <20220828045003.537131-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qjc12vM6o6PRReo3"
Content-Disposition: inline
In-Reply-To: <20220828045003.537131-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Qjc12vM6o6PRReo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 28, 2022 at 12:50:03PM +0800, Ming Lei wrote:
> ublk document is missed when merging ublk driver, so add it now.
>=20

Better say "Add documentation for ublk subsystem. It was supposed to be
documented when merging the driver, but missing at that time."

> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> new file mode 100644
> index 000000000000..9e8f7ba518a3
> --- /dev/null
> +++ b/Documentation/block/ublk.rst
> @@ -0,0 +1,203 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Userspace block device driver(ublk driver)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ublk is one generic framework for implementing block device logic from
> +userspace. It is very helpful to move virtual block drivers into userspa=
ce,
> +such as loop, nbd and similar block drivers. It can help to implement new
> +virtual block device, such as ublk-qcow2, and there was several attempts
> +of implementing qcow2 driver in kernel.
> +
> +ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO reque=
st
> +submitted to ublk device will be forwarded to ublk's userspace part(
> +ublksrv [1]), and after the IO is handled by ublksrv, the result is
> +committed back to ublk driver, then ublk IO request can be completed. Wi=
th
> +this way, any specific IO handling logic is totally done inside ublksrv,
> +and ublk driver doe _not_ handle any device specific IO logic, such as
> +loop's IO handling, NBD's IO communication, or qcow2's IO mapping, ...
> +
> +/dev/ublkbN is driven by blk-mq request based driver, each request is
> +assigned by one queue wide unique tag. ublksrv assigns unique tag to each
> +IO too, which is 1:1 mapped with IO of /dev/ublkb*.
> +
> +Both the IO request forward and IO handling result committing are done v=
ia
> +io_uring passthrough command, that is why ublk is also one io_uring based
> +block driver. It has been observed that io_uring passthrough command can=
 get
> +better IOPS than block IO. So ublk is one high performance implementation
> +of userspace block device. Not only IO request communication is done by
> +io_uring, but also the preferred IO handling in ublksrv is io_uring based
> +approach too.
> +
> +ublk provides control interface to set/get ublk block device parameters,=
 and
> +the interface is extendable and kabi compatible, so basically any ublk r=
equest
> +queue's parameter or ublk generic feature parameters can be set/get via =
this
> +extendable interface. So ublk is generic userspace block device framewor=
k, such
> +as, it is easy to setup one ublk device with specified block parameters =
=66rom
> +userspace.
> +
> +How to use ublk
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +After building ublksrv[1], ublk block device(``/dev/ublkb*``) can be add=
ed
> +and deleted by the utility, then existed block IO applications can talk =
with
> +it.
> +
> +See usage details in README[2] of ublksrv, for example of ublk-loop:
> +
> +- add ublk device:
> +  ublk add -t loop -f ublk-loop.img
> +
> +- use it:
> +  mkfs.xfs /dev/ublkb0
> +  mount /dev/ublkb0 /mnt
> +  ....                     # all IOs are handled by io_uring!!!
> +  umount /mnt
> +
> +- get ublk dev info:
> +  ublk list
> +
> +- delete ublk device
> +  ublk del -a
> +  ublk del -n $ublk_dev_id
> +
> +Design
> +=3D=3D=3D=3D=3D=3D
> +
> +Control plane
> +-------------
> +
> +ublk driver provides global misc device node(``/dev/ublk-control``) for
> +managing and controlling ublk devices with help of several control comma=
nds:
> +
> +- UBLK_CMD_ADD_DEV
> +  Add one ublk char device(``/dev/ublkc*``) which is talked with ublksrv=
 wrt.
> +  IO command communication. Basic device info is sent together with this
> +  command, see UAPI structure of ublksrv_ctrl_dev_info, such as nr_hw_qu=
eues,
> +  queue_depth, and max IO request buffer size, which info is negotiated =
with
> +  ublk driver and sent back to ublksrv. After this command is completed,=
 the
> +  basic device info can't be changed any more.
> +
> +- UBLK_CMD_SET_PARAMS / UBLK_CMD_GET_PARAMS
> +  Set or get ublk device's parameters, which can be generic feature rela=
ted,
> +  or request queue limit related, but can't be IO logic specific, cause =
ublk
> +  driver does not handle any IO logic. This command has to be sent before
> +  sending UBLK_CMD_START_DEV.
> +
> +- UBLK_CMD_START_DEV
> +  After ublksrv prepares userspace resource such as, creating per-queue
> +  pthread & io_ruing for handling ublk IO, this command is set for ublk
> +  driver to allocate & expose /dev/ublkb*. Parameters set via
> +  UBLK_CMD_SET_PARAMS are applied for creating /dev/ublkb*.
> +
> +- UBLK_CMD_STOP_DEV
> +  Quiesce IO on /dev/ublkb* and delete the disk. After this command retu=
rns,
> +  ublksrv can release resource, such as destroy per-queue pthread & io_u=
ring
> +  for handling io command.
> +
> +- UBLK_CMD_DEL_DEV
> +  Delete /dev/ublkc*. After this command returns, the allocated ublk dev=
ice
> +  number can be reused.
> +
> +- UBLK_CMD_GET_QUEUE_AFFINITY
> +  After /dev/ublkc is added, ublk driver creates block layer tagset, so =
each
> +  queue's affinity info is available, ublksrv sends UBLK_CMD_GET_QUEUE_A=
FFINITY
> +  to retrieve queue affinity info, so ublksrv can setup the per-queue co=
ntext
> +  efficiently, such as bind affine CPUs with IO pthread, and try to allo=
cate
> +  buffers in IO thread context.
> +
> +- UBLK_CMD_GET_DEV_INFO
> +  For retrieve device info of ublksrv_ctrl_dev_info. And it is ublksrv's
> +  responsibility to save IO target specific info in userspace.
> +
> +Data plane
> +----------
> +
> +ublksrv needs to create per-queue IO pthread & io_uring for handling IO
> +command (io_uring passthrough command), and the per-queue IO pthread
> +focuses on IO handling and shouldn't handle any control & management
> +task.
> +
> +ublksrv's IO is assigned by one unique tag, which is 1:1 mapping with IO
> +request of /dev/ublkb*.
> +
> +UAPI structure of ublksrv_io_desc is defined for describing each IO from
> +ublk driver. One fixed mmaped area(array) on /dev/ublkc* is provided for
> +exporting IO info to ublksrv, such as IO offset, length, OP/flags and
> +buffer address. Each ublksrv_io_desc instance can be indexed via queue id
> +and IO tag directly.
> +
> +Following IO commands are communicated via io_uring passthrough command,
> +and each command is only for forwarding ublk IO and committing IO result
> +with specified IO tag in the command data:
> +
> +- UBLK_IO_FETCH_REQ
> +  Sent from ublksrv IO pthread for fetching future coming IO request
> +  issued to /dev/ublkb*. This command is just sent once from ublksrv IO
> +  pthread for ublk driver to setup IO forward environment.
> +
> +- UBLK_IO_COMMIT_AND_FETCH_REQ
> +  After one IO request is issued to /dev/ublkb*, ublk driver stores this
> +  IO's ublksrv_io_desc to the specified mapped area, then the previous
> +  received IO command of this IO tag, either UBLK_IO_FETCH_REQ or
> +  UBLK_IO_COMMIT_AND_FETCH_REQ, is completed, so ulksrv gets the IO
> +  notification via io_uring.
> +
> +  After ublksrv handles this IO, this IO's result is committed back to u=
blk
> +  driver by sending UBLK_IO_COMMIT_AND_FETCH_REQ back. Once ublkdrv rece=
ived
> +  this command, it parses the IO result and complete the IO request to
> +  /dev/ublkb*. Meantime setup environment for fetching future IO request
> +  with this IO tag. So UBLK_IO_COMMIT_AND_FETCH_REQ is reused for both
> +  fetching request and committing back IO result.
> +
> +- UBLK_IO_NEED_GET_DATA
> +  ublksrv pre-allocates IO buffer for each IO at default, any new project
> +  should use this IO buffer to communicate with ublk driver. But existed
> +  project may not work or be changed to in this way, so add this command
> +  to provide chance for userspace to use its existed buffer for handling
> +  IO.
> +
> +- data copy between ublkserv IO buffer and ublk block IO request
> +  ublk driver needs to copy ublk block IO request pages into ublksrv buf=
fer
> +  (pages) first for WRITE before notifying ublksrv of the coming IO, so
> +  ublksrv can hanldle WRITE request.
> +
> +  After ublksrv handles READ request and sends UBLK_IO_COMMIT_AND_FETCH_=
REQ
> +  to ublksrv, ublkdrv needs to copy read ublksrv buffer(pages) to the ub=
lk
> +  IO request pages.
> +
> +Future development
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Container-ware ublk deivice
> +---------------------------
> +
> +ublk driver doesn't handle any IO logic, and its function is well defined
> +so far, and very limited userspace interfaces are needed, and each one is
> +well defined too, then it is very likely to make ublk device one
> +container-ware block device in future, as Stefan Hajnoczi suggested[3], =
by
> +removing ADMIN privilege.
> +
> +Zero copy
> +---------
> +
> +Wrt. zero copy support, it is one generic requirement for nbd, fuse or
> +similar drivers, one problem Xiaoguang mentioned is that pages mapped to
> +userspace can't be remapped any more in kernel with existed mm interface=
s,
> +and it can be involved when submitting direct IO to /dev/ublkb*. Also
> +Xiaoguang reported that big request may benefit from zero copy a lot,
> +such as >=3D 256KB IO.
> +

At what thread on lore the problem is mentioned?

> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +[1] https://github.com/ming1/ubdsrv
> +
> +[2] https://github.com/ming1/ubdsrv/blob/master/README
> +
> +[3] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.loc=
aldomain/

The documentation can be improved:

  - Its slug should be added to table of contents (index.rst)
  - Use footnote syntax for external references
  - The wordings are weird, almost to the point that I can't comprehend
    it (barely understand the meaning).

Here's the improv:

---- >8 ----

diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 68f115f2b1c6bf..c4c73db748a81f 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -23,3 +23,4 @@ Block
    stat
    switching-sched
    writeback_cache_control
+   ublk
diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 9e8f7ba518a3bb..7262c8b198074b 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -14,56 +14,63 @@ virtual block device, such as ublk-qcow2, and there was=
 several attempts
 of implementing qcow2 driver in kernel.
=20
 ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO request
-submitted to ublk device will be forwarded to ublk's userspace part(
-ublksrv [1]), and after the IO is handled by ublksrv, the result is
-committed back to ublk driver, then ublk IO request can be completed. With
-this way, any specific IO handling logic is totally done inside ublksrv,
-and ublk driver doe _not_ handle any device specific IO logic, such as
-loop's IO handling, NBD's IO communication, or qcow2's IO mapping, ...
+on the device will be forwarded to the userspace program ``ublksrv``
+[#userspace]_.
+After the IO is handled by userspace, the result is committed back to the
+driver, thus completing the request cycle. This way, any specific IO handl=
ing
+logic is totally done by userspace, such as
+loop's IO handling, NBD's IO communication, or qcow2's IO mapping.
=20
-/dev/ublkbN is driven by blk-mq request based driver, each request is
+``/dev/ublkbN`` is driven by blk-mq request-based driver. Each request is
 assigned by one queue wide unique tag. ublksrv assigns unique tag to each
-IO too, which is 1:1 mapped with IO of /dev/ublkb*.
+IO too, which is 1:1 mapped with IO of ``/dev/ublkb*``.
=20
 Both the IO request forward and IO handling result committing are done via
-io_uring passthrough command, that is why ublk is also one io_uring based
-block driver. It has been observed that io_uring passthrough command can g=
et
-better IOPS than block IO. So ublk is one high performance implementation
-of userspace block device. Not only IO request communication is done by
-io_uring, but also the preferred IO handling in ublksrv is io_uring based
-approach too.
+``io_uring`` passthrough command; that is why ublk is also one io_uring ba=
sed
+block driver. It has been observed that using io_uring passthrough command=
 can
+give better IOPS than block IO; which is why ublk is one of high performan=
ce
+implementation of userspace block device: not only IO request communicatio=
n is
+done by io_uring, but also the preferred IO handling in ublksrv is io_uring
+based approach too.
=20
-ublk provides control interface to set/get ublk block device parameters, a=
nd
-the interface is extendable and kabi compatible, so basically any ublk req=
uest
+ublk provides control interface to set/get ublk block device parameters.
+The interface is extendable and kabi compatible: basically any ublk request
 queue's parameter or ublk generic feature parameters can be set/get via th=
is
-extendable interface. So ublk is generic userspace block device framework,=
 such
-as, it is easy to setup one ublk device with specified block parameters fr=
om
-userspace.
+extendable interface. Thus ublk is generic userspace block device framewor=
k.
+For example, it is easy to setup one ublk device with specified block
+parameters from userspace.
=20
-How to use ublk
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Using ublk
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-After building ublksrv[1], ublk block device(``/dev/ublkb*``) can be added
-and deleted by the utility, then existed block IO applications can talk wi=
th
-it.
+ublk requires ublksrv [#userspace]_ to be installed. The userspace program=
 manages ublk
+block devices (``/dev/ublkb*``), while block IO applications can talk with
+them.
=20
-See usage details in README[2] of ublksrv, for example of ublk-loop:
+See usage details in README of ublksrv [#userspace_readme]_.
=20
-- add ublk device:
-  ublk add -t loop -f ublk-loop.img
+Below is example of using ublk as loop device.
=20
-- use it:
-  mkfs.xfs /dev/ublkb0
-  mount /dev/ublkb0 /mnt
-  ....                     # all IOs are handled by io_uring!!!
-  umount /mnt
+- add ublk device::
=20
-- get ublk dev info:
-  ublk list
+     ublk add -t loop -f ublk-loop.img
=20
-- delete ublk device
-  ublk del -a
-  ublk del -n $ublk_dev_id
+- format with xfs, then use it::
+
+     mkfs.xfs /dev/ublkb0
+     mount /dev/ublkb0 /mnt
+     # do anything. all IOs are handled by io_uring
+     ...
+     umount /mnt
+
+- get ublk dev info::
+
+     ublk list
+
+- delete ublk device::
+
+     ublk del -a
+     ublk del -n $ublk_dev_id
=20
 Design
 =3D=3D=3D=3D=3D=3D
@@ -74,130 +81,143 @@ Control plane
 ublk driver provides global misc device node(``/dev/ublk-control``) for
 managing and controlling ublk devices with help of several control command=
s:
=20
-- UBLK_CMD_ADD_DEV
-  Add one ublk char device(``/dev/ublkc*``) which is talked with ublksrv w=
rt.
-  IO command communication. Basic device info is sent together with this
-  command, see UAPI structure of ublksrv_ctrl_dev_info, such as nr_hw_queu=
es,
-  queue_depth, and max IO request buffer size, which info is negotiated wi=
th
-  ublk driver and sent back to ublksrv. After this command is completed, t=
he
-  basic device info can't be changed any more.
+- ``UBLK_CMD_ADD_DEV``
=20
-- UBLK_CMD_SET_PARAMS / UBLK_CMD_GET_PARAMS
-  Set or get ublk device's parameters, which can be generic feature relate=
d,
-  or request queue limit related, but can't be IO logic specific, cause ub=
lk
-  driver does not handle any IO logic. This command has to be sent before
-  sending UBLK_CMD_START_DEV.
+  Add one ublk char device(``/dev/ublkc*``) which is talked with ublksrv
+  WRT IO command communication. Basic device info is sent together with th=
is
+  command. It sets UAPI structure of ``ublksrv_ctrl_dev_info``,
+  such as ``nr_hw_queues``, ``queue_depth``, and max IO request buffer siz=
e,
+  for which the info is negotiated with ublk driver and sent back to ublks=
rv.
+  After this command is completed, the basic device info is immutable.
=20
-- UBLK_CMD_START_DEV
-  After ublksrv prepares userspace resource such as, creating per-queue
-  pthread & io_ruing for handling ublk IO, this command is set for ublk
-  driver to allocate & expose /dev/ublkb*. Parameters set via
-  UBLK_CMD_SET_PARAMS are applied for creating /dev/ublkb*.
+- ``UBLK_CMD_SET_PARAMS`` / ``UBLK_CMD_GET_PARAMS``
=20
-- UBLK_CMD_STOP_DEV
-  Quiesce IO on /dev/ublkb* and delete the disk. After this command return=
s,
-  ublksrv can release resource, such as destroy per-queue pthread & io_uri=
ng
-  for handling io command.
+  Set or get ublk device's parameters, which can be either generic feature
+  related, or request queue limit related, but can't be IO logic specific,
+  because ublk driver does not handle any IO logic. This command has to be
+  sent before sending ``UBLK_CMD_START_DEV``.
=20
-- UBLK_CMD_DEL_DEV
-  Delete /dev/ublkc*. After this command returns, the allocated ublk device
+- ``UBLK_CMD_START_DEV``
+
+  After ublksrv prepares userspace resources (such as creating per-queue
+  pthread & io_uring for handling ublk IO), this command is set for ublk
+  driver to allocate & expose ``/dev/ublkb*``. Parameters set via
+  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
+
+- ``UBLK_CMD_STOP_DEV``
+
+  Halt IO on ``/dev/ublkb*`` and remove the device. When this command retu=
rns,
+  ublksrv will release resources (such as destroying per-queue pthread &
+  io_uring).
+
+- ``UBLK_CMD_DEL_DEV``
+
+  Remove ``/dev/ublkc*``. When this command returns, the allocated ublk de=
vice
   number can be reused.
=20
-- UBLK_CMD_GET_QUEUE_AFFINITY
-  After /dev/ublkc is added, ublk driver creates block layer tagset, so ea=
ch
-  queue's affinity info is available, ublksrv sends UBLK_CMD_GET_QUEUE_AFF=
INITY
-  to retrieve queue affinity info, so ublksrv can setup the per-queue cont=
ext
-  efficiently, such as bind affine CPUs with IO pthread, and try to alloca=
te
+- ``UBLK_CMD_GET_QUEUE_AFFINITY``
+
+  When ``/dev/ublkc`` is added, ublk driver creates block layer tagset, so
+  that each
+  queue's affinity info is available. ublksrv sends
+  ``UBLK_CMD_GET_QUEUE_AFFINITY``
+  to retrieve queue affinity info. It can setup the per-queue context
+  efficiently, such as bind affine CPUs with IO pthread and try to allocate
   buffers in IO thread context.
=20
-- UBLK_CMD_GET_DEV_INFO
-  For retrieve device info of ublksrv_ctrl_dev_info. And it is ublksrv's
+- ``UBLK_CMD_GET_DEV_INFO``
+
+  For retrieving device info via ``ublksrv_ctrl_dev_info``. It is ublksrv's
   responsibility to save IO target specific info in userspace.
=20
 Data plane
 ----------
=20
 ublksrv needs to create per-queue IO pthread & io_uring for handling IO
-command (io_uring passthrough command), and the per-queue IO pthread
+commands via io_uring passthrough. The per-queue IO pthread
 focuses on IO handling and shouldn't handle any control & management
-task.
+tasks.
=20
-ublksrv's IO is assigned by one unique tag, which is 1:1 mapping with IO
-request of /dev/ublkb*.
+ublksrv's IO is assigned by a unique tag, which is 1:1 mapping with IO
+request of ``/dev/ublkb*``.
=20
-UAPI structure of ublksrv_io_desc is defined for describing each IO from
-ublk driver. One fixed mmaped area(array) on /dev/ublkc* is provided for
-exporting IO info to ublksrv, such as IO offset, length, OP/flags and
-buffer address. Each ublksrv_io_desc instance can be indexed via queue id
+UAPI structure of ``ublksrv_io_desc`` is defined for describing each IO fr=
om
+ublk driver. A fixed mmaped area (array) on ``/dev/ublkc*`` is provided for
+exporting IO info to ublksrv; such as IO offset, length, OP/flags and
+buffer address. Each ``ublksrv_io_desc`` instance can be indexed via queue=
 id
 and IO tag directly.
=20
-Following IO commands are communicated via io_uring passthrough command,
+The following IO commands are communicated via io_uring passthrough comman=
d,
 and each command is only for forwarding ublk IO and committing IO result
 with specified IO tag in the command data:
=20
-- UBLK_IO_FETCH_REQ
-  Sent from ublksrv IO pthread for fetching future coming IO request
-  issued to /dev/ublkb*. This command is just sent once from ublksrv IO
+- ``UBLK_IO_FETCH_REQ``
+
+  Sent from ublksrv IO pthread for fetching future incoming IO requests
+  destined to ``/dev/ublkb*``. This command is sent only once from ublksrv=
 IO
   pthread for ublk driver to setup IO forward environment.
=20
-- UBLK_IO_COMMIT_AND_FETCH_REQ
-  After one IO request is issued to /dev/ublkb*, ublk driver stores this
-  IO's ublksrv_io_desc to the specified mapped area, then the previous
-  received IO command of this IO tag, either UBLK_IO_FETCH_REQ or
-  UBLK_IO_COMMIT_AND_FETCH_REQ, is completed, so ulksrv gets the IO
+- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
+
+  When an IO request is destined to ``/dev/ublkb*``, ublk driver stores
+  the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
+  previous received IO command of this IO tag (either UBLK_IO_FETCH_REQ or
+  UBLK_IO_COMMIT_AND_FETCH_REQ) is completed, so ublksrv gets the IO
   notification via io_uring.
=20
-  After ublksrv handles this IO, this IO's result is committed back to ublk
-  driver by sending UBLK_IO_COMMIT_AND_FETCH_REQ back. Once ublkdrv receiv=
ed
-  this command, it parses the IO result and complete the IO request to
-  /dev/ublkb*. Meantime setup environment for fetching future IO request
-  with this IO tag. So UBLK_IO_COMMIT_AND_FETCH_REQ is reused for both
-  fetching request and committing back IO result.
+  After ublksrv handles the IO, its result is committed back to ublk
+  driver by sending ``UBLK_IO_COMMIT_AND_FETCH_REQ`` back. Once ublkdrv
+  received this command, it parses the result and complete the request to
+  ``/dev/ublkb*``. In the meantime setup environment for fetching future
+  requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ``
+  is reused for both fetching request and committing back IO result.
=20
-- UBLK_IO_NEED_GET_DATA
-  ublksrv pre-allocates IO buffer for each IO at default, any new project
-  should use this IO buffer to communicate with ublk driver. But existed
-  project may not work or be changed to in this way, so add this command
-  to provide chance for userspace to use its existed buffer for handling
-  IO.
+- ``UBLK_IO_NEED_GET_DATA``
+
+  ublksrv pre-allocates IO buffer for each IO by default. Any new projects
+  should use this buffer to communicate with ublk driver. However,
+  existing
+  projects may break or not able to consume the new buffer interface; that=
's
+  why this command is added for backwards compatibility so that existing
+  projects can still consume existing buffers.
=20
 - data copy between ublkserv IO buffer and ublk block IO request
-  ublk driver needs to copy ublk block IO request pages into ublksrv buffer
-  (pages) first for WRITE before notifying ublksrv of the coming IO, so
-  ublksrv can hanldle WRITE request.
=20
-  After ublksrv handles READ request and sends UBLK_IO_COMMIT_AND_FETCH_REQ
-  to ublksrv, ublkdrv needs to copy read ublksrv buffer(pages) to the ublk
-  IO request pages.
+  ublk driver needs to copy the block IO request pages into ublksrv buffer
+  (pages) first for WRITE before notifying ublksrv of the coming IO, so
+  that ublksrv can hanldle WRITE request.
+
+  When ublksrv handles READ request and sends ``UBLK_IO_COMMIT_AND_FETCH_R=
EQ``
+  to ublksrv, ublkdrv needs to copy read ublksrv buffer (pages) to the IO
+  request pages.
=20
 Future development
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Container-ware ublk deivice
----------------------------
+Container-aware ublk deivice
+----------------------------
=20
-ublk driver doesn't handle any IO logic, and its function is well defined
-so far, and very limited userspace interfaces are needed, and each one is
-well defined too, then it is very likely to make ublk device one
-container-ware block device in future, as Stefan Hajnoczi suggested[3], by
-removing ADMIN privilege.
+ublk driver doesn't handle any IO logic. Its function is well defined
+for now, and very limited userspace interfaces are needed, which is also
+well defined too. It is possible to make ublk devices container-aware block
+devices in future as Stefan Hajnoczi suggested [#stefan]_, by removing
+ADMIN privilege.
=20
 Zero copy
 ---------
=20
-Wrt. zero copy support, it is one generic requirement for nbd, fuse or
-similar drivers, one problem Xiaoguang mentioned is that pages mapped to
-userspace can't be remapped any more in kernel with existed mm interfaces,
-and it can be involved when submitting direct IO to /dev/ublkb*. Also
-Xiaoguang reported that big request may benefit from zero copy a lot,
-such as >=3D 256KB IO.
+Wrt. zero copy support, which is a generic requirement for nbd, fuse or
+similar drivers, a problem Xiaoguang mentioned is that pages mapped to
+userspace can't be remapped any more in kernel with existing mm interfaces.
+This can occurs when destining direct IO to ``/dev/ublkb*``. Also
+he reported that big requests (>=3D 256 KB IO) may benefit a lot from zero=
 copy.
=20
=20
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-[1] https://github.com/ming1/ubdsrv
+.. [#userspace] https://github.com/ming1/ubdsrv
=20
-[2] https://github.com/ming1/ubdsrv/blob/master/README
+.. [#userspace_readme] https://github.com/ming1/ubdsrv/blob/master/README
=20
-[3] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.local=
domain/
+.. [#stefan] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha=
-x1.localdomain/

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Qjc12vM6o6PRReo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYwtiSQAKCRD2uYlJVVFO
o46kAP0Uldysk3+CV6w+u2nC4gy7Ec68LcPbhMm+ujWHwXg5hQD/csJXoInsVG0e
hBCX+k3LGmnpV8GNwmskdkUbuOvNtws=
=JkFu
-----END PGP SIGNATURE-----

--Qjc12vM6o6PRReo3--
