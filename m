Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6252AC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 14:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiG0OQq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiG0OQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 10:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F1631146
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658931399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8bW+JTQQqJypxTClRe0zvQqzYdzCLj0J7oD6GHAyyTs=;
        b=iAQ1uilUnbnGJdZiHJS3IMzMrnYbPU36dUqJ1sJkkAirja5+gNE0Ozt5TDVJrIpa8EoWyd
        qebHfWOEjs/0GMlmM5zu0YGZuTmR6fs5/z03dLKDNp0f36gmsd7lgLnWCcGghJGv3KFCen
        jsqFgmT8B9n42i+YoR1oU9jyxuuQMjw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-H7HWP-W8PK67zqYQj_jt7g-1; Wed, 27 Jul 2022 10:16:37 -0400
X-MC-Unique: H7HWP-W8PK67zqYQj_jt7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14D6F280EE27;
        Wed, 27 Jul 2022 14:16:37 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 225CC40C1288;
        Wed, 27 Jul 2022 14:16:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/5] ublk_drv: add generic mechanism to get/set parameters
Date:   Wed, 27 Jul 2022 22:16:23 +0800
Message-Id: <20220727141628.985429-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st two patches fixes ublk device leak or hang issue in case of some
failure path, such as failed to start device.

The 3rd patch adds two control commands for setting/getting device
parameters in generic way, and easy to extend to add new parameter
type.

The 4th patch adds two parameter type: basic and discard, and basic
parameter covers basic block queue setting or someone which can't
be grouped to other types, basic parameter has to be set; discard
parameter is optional.

The 5th patch cleans uapi of ublksrv_ctrl_dev_info, and userspace has
to be updated for this driver change.

Verified by all targets in the following branch:

https://github.com/ming1/ubdsrv/tree/parameter

Also all device data including parameters is exported as json in
above tree.

V2:
- re-organize patches
- limit parameter max length
- take Christoph's approach to replace bitfields with flags, and use
char type to define block size shift
- add two fixes, which is triggered when testing set/get parameter
  commands
- cleanup uapi header


Ming Lei (5):
  ublk_drv: avoid to leak ublk device in case that add_disk fails
  ublk_drv: cancel device even though disk isn't up
  ublk_drv: add SET_PARAM/GET_PARAM control command
  ublk_drv: add two parameter types
  ublk_drv: cleanup ublksrv_ctrl_dev_info

 drivers/block/ublk_drv.c      | 338 ++++++++++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h |  57 +++++-
 2 files changed, 356 insertions(+), 39 deletions(-)

-- 
2.31.1

