Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADACC352A1
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 12:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLGMeO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLGMeN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 07:34:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4044EC2F
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670416398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=59dUMrcoQMuDHps0c4EAkaxdyoUMGNG20palr9yZyq8=;
        b=JAIyZ5c8Qmc3kfJ65+Ix1n8JWPkpp/Yorx4f1Pw4hzJXhhgT8KHi0dm/Y+vef2uXsgYlA3
        qhpx17LG8wxb9/cS1utaMg9jKrzp/vgZl7pIQUbytbCIen6FHAG6ai/JtfilZ6ilFgJ/ei
        1h+WGFe6aK75W1iBvuLG+sQ10hJhh3k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-gtXTfKzXNb2A_KfsLSCZxg-1; Wed, 07 Dec 2022 07:33:14 -0500
X-MC-Unique: gtXTfKzXNb2A_KfsLSCZxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 777881C0897B;
        Wed,  7 Dec 2022 12:33:14 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94AC41415100;
        Wed,  7 Dec 2022 12:33:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/6] ublk_drv: add mechanism for supporting unprivileged ublk device
Date:   Wed,  7 Dec 2022 20:32:59 +0800
Message-Id: <20221207123305.937678-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

V3:
	- don't warn on invalid user input for setting devt parameter, as
	  suggested by Ziyang, patch 4/6
	- fix one memory corruption issue, patch 6/6

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

