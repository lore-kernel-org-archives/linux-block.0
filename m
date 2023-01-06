Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EEC3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 04:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjAFESM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 23:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFESK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 23:18:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A363ED
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 20:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672978644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v/Xa9eT3bvZKYjNyOXLMouSiGCc6HxqNFyBbzJ4Dbug=;
        b=BPpvQ/U5G+E8yeMRfuAdE8vmVAcHEhP2D2K09jzRa9t8srq6YIlYCzRKz5G7RqRGVTdkvG
        897ZyxabL4fLzpbDYvHiH7vpdVRT09th+HUwKD6rN4nCNP4BSfP7+p8uyyw97Ev+XauGfF
        1UVqPPkGAA6pD21I2wDkmXkdhsBhHUc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-G7phKxi1O7iNgNPusN6Szw-1; Thu, 05 Jan 2023 23:17:20 -0500
X-MC-Unique: G7phKxi1O7iNgNPusN6Szw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F6B51C05157;
        Fri,  6 Jan 2023 04:17:20 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F5162166B30;
        Fri,  6 Jan 2023 04:17:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/6] ublk_drv: add mechanism for supporting unprivileged ublk device
Date:   Fri,  6 Jan 2023 12:17:05 +0800
Message-Id: <20230106041711.914434-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

V4:
	- only allow to create unprivileged udev for current user, as
	  suggested by Jonathan Corbet
	- fix misc bug for handling failure
	- add detailed document
	- update userspace

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

 Documentation/block/ublk.rst  |  49 ++++-
 drivers/block/ublk_drv.c      | 341 ++++++++++++++++++++++++----------
 include/uapi/linux/ublk_cmd.h |  49 ++++-
 3 files changed, 332 insertions(+), 107 deletions(-)

-- 
2.31.1

