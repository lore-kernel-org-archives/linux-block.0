Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D97C04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 09:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiG3J2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiG3J2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 05:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F1D4402FB
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659173315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2/HlTS7IiXS5qbMbUt74a23+IT3fBj0wHRMbNZBo9FE=;
        b=L/Jn+ZvXO34tsVSSwCoOhpqkEYEh2Z6vi0Bit6z2cPg+t558LcddzQFSn89uAPRZiDkdRt
        ITgNpj9WAKYsKZTwf8EhmsUKPwry3pUwCMsWtM7e19bFPI2Tuk9Px3fWeYrlUEZb8orEEn
        Icq+ItL6eP+Q/ag1x4XDi7a1tx8mC8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-Xv9jB-g2OciNaynyT6P6yQ-1; Sat, 30 Jul 2022 05:28:31 -0400
X-MC-Unique: Xv9jB-g2OciNaynyT6P6yQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70BCA8032F1;
        Sat, 30 Jul 2022 09:28:31 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81694492C3B;
        Sat, 30 Jul 2022 09:28:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/4] ublk_drv: add generic mechanism to get/set parameters
Date:   Sat, 30 Jul 2022 17:27:46 +0800
Message-Id: <20220730092750.1118167-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

The 1st two patches fixes ublk device leak or hang issue in case of some
failure path, such as, failing to start device.

The 3rd patch adds two control commands for setting/getting device
parameters in generic way, and easy to extend to add new parameter
type.

The 4th patch cleans UAPI of ublksrv_ctrl_dev_info, and userspace needs
to be updated for this driver change, so please consider this patchset
for v5.20.

Verified by all targets in the following branch, and pass all built-in
tests.

https://github.com/ming1/ubdsrv/tree/parameter_out

Also all device data including parameters is exported as json in
above tree.

V4:
- take Christoph's suggestion to put all parameters into one single
  structure.
- move reserved fields of ublksrv_ctrl_dev_info into end

V3:
- drop device reference after add_disk fails, as suggested by Christoph, 1/5
- simplify the 3rd patch: replace xarray with plain array, remove
  function table and avoid indirect call, then reduce boiler plate for
  addressing Christoph's comment

V2:
- re-organize patches
- limit parameter max length
- take Christoph's approach to replace bitfields with flags, and use
char type to define block size shift
- add two fixes, which is triggered when testing set/get parameter
  commands
- cleanup uapi header


Ming Lei (4):
  ublk_drv: cancel device even though disk isn't up
  ublk_drv: fix ublk device leak in case that add_disk fails
  ublk_drv: add SET_PARAMS/GET_PARAMS control command
  ublk_drv: cleanup ublksrv_ctrl_dev_info

 drivers/block/ublk_drv.c      | 242 +++++++++++++++++++++++++++++-----
 include/uapi/linux/ublk_cmd.h |  62 ++++++++-
 2 files changed, 264 insertions(+), 40 deletions(-)

-- 
2.31.1

