Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D638AC4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 03:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKXDGD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKXDGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 22:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84844B7396
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 19:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669259107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a7cUa6aB01P+z7A59NDxewUb//vfN7daC5caR/sN9+M=;
        b=bySintVqvC6GEGjUs8esQ4uu4yW+6S8uM6Qye88xziiePQOQ+VODXUhYkgYDtb5De9sCQ2
        jJqbdflfguFTR8RFQtFaEE19NcH0M+2hw7axmvKS+XfQf2fs4Wkgx1GP7g2cIzzbdKiD3Y
        HPLaZhoofzo4W9qMzYClPXAUkA/RNtA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-fjTExEkwOeOP8u3fA8fr6g-1; Wed, 23 Nov 2022 22:05:03 -0500
X-MC-Unique: fjTExEkwOeOP8u3fA8fr6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B1FA85A588;
        Thu, 24 Nov 2022 03:05:03 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 620B31121319;
        Thu, 24 Nov 2022 03:05:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Dan Carpenter <error27@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/6] ublk_drv: add mechanism for supporting unprivileged ublk device
Date:   Thu, 24 Nov 2022 11:04:48 +0800
Message-Id: <20221124030454.476152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Stefan Hajnoczi suggested un-privileged ublk device[1] for container
use case.

So far only administrator can create/control ublk device which is too
strict and increase system administrator burden, and this patchset
implements un-privileged ublk device:

- any user can create ublk device, which can only be controlled &
  accessed by the owner of the device or administrator

For using such mechanism, system administrator needs to deploy two
simple udev rules[2] after running 'make install' in ublksrv.

Userspace(ublksrv):

	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk
    
'ublk add -t $TYPE --un_privileged' is for creating one un-privileged
ublk device if the user is un-privileged.


[1] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
[2] https://github.com/ming1/ubdsrv/blob/unprivileged-ublk/README.rst#un-privileged-mode

V2:
	- fix "ublk_ctrl_uring_cmd_permission() error: uninitialized symbol 'mask'", reported
	by  Dan Carpenter' test robot
	- address Ziyang's comment on dealing with nr_privileged_daemon

Ming Lei (6):
  ublk_drv: remove nr_aborted_queues from ublk_device
  ublk_drv: don't probe partitions if the ubq daemon isn't trusted
  ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
  ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT
  ublk_drv: add module parameter of ublks_max for limiting max allowed
    ublk dev
  ublk_drv: add mechanism for supporting unprivileged ublk device

 Documentation/block/ublk.rst  |  18 +-
 drivers/block/ublk_drv.c      | 336 ++++++++++++++++++++++++----------
 include/uapi/linux/ublk_cmd.h |  49 ++++-
 3 files changed, 296 insertions(+), 107 deletions(-)

-- 
2.31.1

