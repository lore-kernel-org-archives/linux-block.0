Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1357BECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 02:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiIACa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiIACaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 22:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112CE18B10
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 19:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661999417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6FHky1gOeg/VwwhhU2denoH/8SmPUpp8v5IfP1kRR2M=;
        b=fx0uJDPG3HLGwUqEZvK1XeLDZWTg7gZiTvPoUnw/dJcmSQd/GyF7znVwnvzsQ9SjlPLJb7
        Gzoql6H3yxTd6VloQpFbXy508KZ8fJNvbJX7q5aVBEXWqI7EPGeZsgr0E6TVC9ce/9Jiar
        JDhM3erp1ER5AOZvEkUGMIHG7+t31tI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-2AcsLcRmMXK91L0yvBni_w-1; Wed, 31 Aug 2022 22:30:14 -0400
X-MC-Unique: 2AcsLcRmMXK91L0yvBni_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6247380450B;
        Thu,  1 Sep 2022 02:30:13 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FFD41121314;
        Thu,  1 Sep 2022 02:30:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH V2 1/1] Docs: ublk: add ublk document
Date:   Thu,  1 Sep 2022 10:30:08 +0800
Message-Id: <20220901023008.669893-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add documentation for ublk subsystem. It was supposed to be documented when
merging the driver, but missing at that time.

Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- integrate all kinds of cleanup from Bagas Sanjaya
    - add 'why useful' paragraph from Stefan
    - replace ublksrv with ublksrv for representing generic ublk
      userspace for convenience of reference, as suggested by Stefan
    - add entry to block/index.rst for removing ktest waring
    - add MAINTAINER entry
    - add more references, such as zero copy and nbdublk
    - thanks review/suggestion from Bagas Sanjaya, Richard W.M. Jones, Stefan Hajnoczi
    and ZiyangZhang

 Documentation/block/index.rst |   1 +
 Documentation/block/ublk.rst  | 245 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                   |   1 +
 3 files changed, 247 insertions(+)
 create mode 100644 Documentation/block/ublk.rst

diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 68f115f2b1c6..c4c73db748a8 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -23,3 +23,4 @@ Block
    stat
    switching-sched
    writeback_cache_control
+   ublk
diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
new file mode 100644
index 000000000000..c3ab9888f7d5
--- /dev/null
+++ b/Documentation/block/ublk.rst
@@ -0,0 +1,245 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+Userspace block device driver (ublk driver)
+===========================================
+
+Overview
+========
+
+ublk is a generic framework for implementing block device logic from userspace.
+It is very helpful to move virtual block drivers into userspace, such as loop,
+nbd and similar virtual block drivers. It can help to implement new virtual
+block device, such as ublk-qcow2, and there was several attempts of
+implementing qcow2 driver in kernel.
+
+Userspace block devices are attractive because:
+- They can be written many programming languages.
+- They can use libraries that are not available in the kernel.
+- They can be debugged with tools familiar to application developers.
+- Crashes do not kernel panic the machine.
+- Bugs are likely to have a lower security impact than bugs in kernel
+  code.
+- They can be installed and updated independently of the kernel.
+- They can be used to simulate block device easily with user specified
+  parameters/setting for test/debug purpose
+
+ublk block device(``/dev/ublkb*``) is added by ublk driver. Any IO request
+on the device will be forwarded to ublk userspace program. For convenience of
+reference, in this document, ``ublk server`` represents generic ublk userspace
+program. ``ublksrv`` [#userspace]_ is one ublk server implementation, and it
+provides ``libublksrv`` [#userspace_lib]_ library for developing specific
+user block device conveniently, meantime generic type block device is included,
+such as loop and null. Richard W.M. Jones wrote userspace nbd device
+``nbdublk`` [#userspace_nbdublk]_  based on ``libublksrv`` [#userspace_lib]_.
+
+After the IO is handled by userspace, the result is committed back to the
+driver, thus completing the request cycle. This way, any specific IO handling
+logic is totally done by userspace, such as loop's IO handling, NBD's IO
+communication, or qcow2's IO mapping.
+
+``/dev/ublkb*`` is driven by blk-mq request-based driver. Each request is
+assigned by one queue wide unique tag. ublk server assigns unique tag to each
+IO too, which is 1:1 mapped with IO of ``/dev/ublkb*``.
+
+Both the IO request forward and IO handling result committing are done via
+``io_uring`` passthrough command; that is why ublk is also one io_uring based
+block driver. It has been observed that using io_uring passthrough command can
+give better IOPS than block IO; which is why ublk is one of high performance
+implementation of userspace block device: not only IO request communication is
+done by io_uring, but also the preferred IO handling in ublk server is io_uring
+based approach too.
+
+ublk provides control interface to set/get ublk block device parameters.
+The interface is extendable and kabi compatible: basically any ublk request
+queue's parameter or ublk generic feature parameters can be set/get via this
+extendable interface. Thus ublk is generic userspace block device framework.
+For example, it is easy to setup one ublk device with specified block
+parameters from userspace.
+
+Using ublk
+==========
+
+ublk requires userspace ublk server to handle real block device logic. For
+example of ``ublksrv`` [#userspace]_, user can use ublk device in the
+following way:
+
+Below is example of using ublk as loop device.
+
+- add ublk device::
+
+     ublk add -t loop -f ublk-loop.img
+
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
+
+See usage details in README of ``ublksrv`` [#userspace_readme]_.
+
+Design
+======
+
+Control plane
+-------------
+
+ublk driver provides global misc device node (``/dev/ublk-control``) for
+managing and controlling ublk devices with help of several control commands:
+
+- ``UBLK_CMD_ADD_DEV``
+
+  Add one ublk char device (``/dev/ublkc*``) which is talked with ublk server
+  WRT IO command communication. Basic device info is sent together with this
+  command. It sets UAPI structure of ``ublksrv_ctrl_dev_info``,
+  such as ``nr_hw_queues``, ``queue_depth``, and max IO request buffer size,
+  for which the info is negotiated with ublk driver and sent back to ublk server.
+  After this command is completed, the basic device info is immutable.
+
+- ``UBLK_CMD_SET_PARAMS`` / ``UBLK_CMD_GET_PARAMS``
+
+  Set or get ublk device's parameters, which can be either generic feature
+  related, or request queue limit related, but can't be IO logic specific,
+  because ublk driver does not handle any IO logic. This command has to be
+  sent before sending ``UBLK_CMD_START_DEV``.
+
+- ``UBLK_CMD_START_DEV``
+
+  After ublk server prepares userspace resources (such as creating per-queue
+  pthread & io_uring for handling ublk IO), this command is sent to ublk
+  driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
+  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
+
+- ``UBLK_CMD_STOP_DEV``
+
+  Halt IO on ``/dev/ublkb*`` and remove the device. When this command returns,
+  ublk server will release resources (such as destroying per-queue pthread &
+  io_uring).
+
+- ``UBLK_CMD_DEL_DEV``
+
+  Remove ``/dev/ublkc*``. When this command returns, the allocated ublk device
+  number can be reused.
+
+- ``UBLK_CMD_GET_QUEUE_AFFINITY``
+
+  When ``/dev/ublkc`` is added, ublk driver creates block layer tagset, so
+  that each
+  queue's affinity info is available. ublk server sends
+  ``UBLK_CMD_GET_QUEUE_AFFINITY``
+  to retrieve queue affinity info. It can setup the per-queue context
+  efficiently, such as bind affine CPUs with IO pthread and try to allocate
+  buffers in IO thread context.
+
+- ``UBLK_CMD_GET_DEV_INFO``
+
+  For retrieving device info via ``ublksrv_ctrl_dev_info``. It is ublk server's
+  responsibility to save IO target specific info in userspace.
+
+Data plane
+----------
+
+ublk server needs to create per-queue IO pthread & io_uring for handling IO
+commands via io_uring passthrough. The per-queue IO pthread
+focuses on IO handling and shouldn't handle any control & management
+tasks.
+
+ublk server's IO is assigned by a unique tag, which is 1:1 mapping with IO
+request of ``/dev/ublkb*``.
+
+UAPI structure of ``ublksrv_io_desc`` is defined for describing each IO from
+ublk driver. A fixed mmaped area (array) on ``/dev/ublkc*`` is provided for
+exporting IO info to ublk server; such as IO offset, length, OP/flags and
+buffer address. Each ``ublksrv_io_desc`` instance can be indexed via queue id
+and IO tag directly.
+
+The following IO commands are communicated via io_uring passthrough command,
+and each command is only for forwarding ublk IO and committing IO result
+with specified IO tag in the command data:
+
+- ``UBLK_IO_FETCH_REQ``
+
+  Sent from ublk server IO pthread for fetching future incoming IO requests
+  destined to ``/dev/ublkb*``. This command is sent only once from ublk server IO
+  pthread for ublk driver to setup IO forward environment.
+
+- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
+
+  When an IO request is destined to ``/dev/ublkb*``, ublk driver stores
+  the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
+  previous received IO command of this IO tag (either UBLK_IO_FETCH_REQ or
+  UBLK_IO_COMMIT_AND_FETCH_REQ) is completed, so ublk server gets the IO
+  notification via io_uring.
+
+  After ublk server handles the IO, its result is committed back to ublk
+  driver by sending ``UBLK_IO_COMMIT_AND_FETCH_REQ`` back. Once ublkdrv
+  received this command, it parses the result and complete the request to
+  ``/dev/ublkb*``. In the meantime setup environment for fetching future
+  requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ``
+  is reused for both fetching request and committing back IO result.
+
+- ``UBLK_IO_NEED_GET_DATA``
+
+  ublk server pre-allocates IO buffer for each IO by default. Any new projects
+  should use this buffer to communicate with ublk driver. However, existing
+  projects may break or not able to consume the new buffer interface; that's
+  why this command is added for backwards compatibility so that existing
+  projects can still consume existing buffers.
+
+- data copy between ublk server IO buffer and ublk block IO request
+
+  ublk driver needs to copy the block IO request pages into ublk server buffer
+  (pages) first for WRITE before notifying ublk server of the coming IO, so
+  that ublk server can handle WRITE request.
+
+  When ublk server handles READ request and sends ``UBLK_IO_COMMIT_AND_FETCH_REQ``
+  to ublk server, ublkdrv needs to copy read ublk server buffer (pages) to the IO
+  request pages.
+
+Future development
+==================
+
+Container-aware ublk deivice
+----------------------------
+
+ublk driver doesn't handle any IO logic. Its function is well defined
+for now, and very limited userspace interfaces are needed, which is also
+well defined too. It is possible to make ublk devices container-aware block
+devices in future as Stefan Hajnoczi suggested [#stefan]_, by removing
+ADMIN privilege.
+
+Zero copy
+---------
+
+Zero copy is a generic requirement for nbd, fuse or similar drivers, one
+problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to userspace
+can't be remapped any more in kernel with existing mm interfaces. This can
+occurs when destining direct IO to ``/dev/ublkb*``. Also he reported that
+big requests (>= 256 KB IO) may benefit a lot from zero copy.
+
+
+References
+==========
+
+.. [#userspace] https://github.com/ming1/ubdsrv
+
+.. [#userspace_lib] https://github.com/ming1/ubdsrv/tree/master/lib
+
+.. [#userspace_nbdublk] https://gitlab.com/rwmjones/libnbd/-/tree/nbdublk
+
+.. [#userspace_readme] https://github.com/ming1/ubdsrv/blob/master/README
+
+.. [#stefan] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
+
+.. [#xiaoguang] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
diff --git a/MAINTAINERS b/MAINTAINERS
index f512b430c7cb..08a5c465a160 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20760,6 +20760,7 @@ UBLK USERSPACE BLOCK DRIVER
 M:	Ming Lei <ming.lei@redhat.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
+F:	Documentation/block/index.rst
 F:	drivers/block/ublk_drv.c
 F:	include/uapi/linux/ublk_cmd.h
 
-- 
2.31.1

