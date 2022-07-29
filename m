Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A5C00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 07:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiG2HaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiG2HaL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D73F264A
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659079809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1F5r+eGikZzGLMBDfl3sb82FaGI83USRovPI3oRpJ4M=;
        b=FyPM9jT9lrLKejJVizsNkZGr2j3uoiGwtv9dQvicFa6G/a4rm3dvw4NXQTccNFIDYaXBIN
        gSrDqXx24gYgigeExOQOhHOHDjtwfsZLe/LzRiE1Z8abcE5AVlk3djPWXLnTG7ui9szlkJ
        2r2c+t9k+jAOKFWHgU63vqQNM8HnzRw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-MWcsBPDkNV6JAUvr2Yd2iQ-1; Fri, 29 Jul 2022 03:30:05 -0400
X-MC-Unique: MWcsBPDkNV6JAUvr2Yd2iQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F206185A7BA;
        Fri, 29 Jul 2022 07:30:05 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CBE2492C3B;
        Fri, 29 Jul 2022 07:30:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/5] ublk_drv: add generic mechanism to get/set parameters
Date:   Fri, 29 Jul 2022 15:29:49 +0800
Message-Id: <20220729072954.1070514-1-ming.lei@redhat.com>
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

The 4th patch adds two parameter type: basic and discard, and basic
parameter covers basic block queue setting or someone which can't
be grouped to other types, basic parameter has to be set; discard
parameter is optional.

The 5th patch cleans UAPI of ublksrv_ctrl_dev_info, and userspace has
to be updated for this driver change, so please consider this patchset
for v5.20.

Verified by all targets in the following branch:

https://github.com/ming1/ubdsrv/tree/parameter

Also all device data including parameters is exported as json in
above tree.


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


Ming Lei (5):
  ublk_drv: cancel device even though disk isn't up
  ublk_drv: fix ublk device leak in case that add_disk fails
  ublk_drv: add SET_PARAM/GET_PARAM control command
  ublk_drv: add two parameter types
  ublk_drv: cleanup ublksrv_ctrl_dev_info

 drivers/block/ublk_drv.c      | 333 ++++++++++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h |  57 +++++-
 2 files changed, 352 insertions(+), 38 deletions(-)

-- 
2.31.1

