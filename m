Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB1C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiGVKii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiGVKih (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 06:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5104CBA266
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658486314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7mF/hiZ45HX3O2OhffWBtT/nSlS6y0VascD3mEndGLE=;
        b=F8fvjXCtA7iFgSf042Duzf7a6pJIVTixY7FDinEO/o+KcZajK/dOYZMGiObjKYk4wZELBm
        2wPcNciriNfKYmswa4AaJyEY3FJyzxb11Lg0egi+RUrX3jNIEtVngU3cQOrLndCtp2Zh41
        cNZnxvYhRxu/9i3U5Gda4fJmQZ4PAnc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-tJ38ClodM6-e6CNs8ZORzw-1; Fri, 22 Jul 2022 06:38:24 -0400
X-MC-Unique: tJ38ClodM6-e6CNs8ZORzw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21FA8185A7A4;
        Fri, 22 Jul 2022 10:38:24 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96488492C3B;
        Fri, 22 Jul 2022 10:38:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/2] ublk_drv: make sure that correct flags(features) returned to userspace
Date:   Fri, 22 Jul 2022 18:38:15 +0800
Message-Id: <20220722103817.631258-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

The 1st patch cleans ublk_add_dev a bit, meantime fix one potential
free un-allocated buffer issue.

The 2nd one makes sure that driver supported flags returned to
userspace, this way is important for maintaining compatibility.

V4:
- move UBLK_F_ALL out of uapi header, and change order of clearing
dev_info.flags as suggested by Chrisotph

V3:
- cleanup ublk_ctrl_add_dev by Christoph

V2:
- avoid double free device in case that char dev is failed to add


Christoph Hellwig (1):
  ublk_drv: fix error handling of ublk_add_dev

Ming Lei (1):
  ublk_drv: make sure that correct flags(features) returned to userspace

 drivers/block/ublk_drv.c      | 115 ++++++++++++++++++----------------
 include/uapi/linux/ublk_cmd.h |   7 ++-
 2 files changed, 65 insertions(+), 57 deletions(-)

-- 
2.31.1

