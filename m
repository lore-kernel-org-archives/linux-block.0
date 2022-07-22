Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277D8C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 02:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiGVCha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGVCh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 22:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7861BE8B
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 19:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658457443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SSS3Z/fnefrps6pL1Me9RfDwp4en1x23dj/WPod2p3I=;
        b=BGg1/bnUXoUVZ4cTVkzKi1VFF/2X9ly/xmMihm8pAraY/jI/JamZBT45YOPRZHHOrOaYo6
        KOrJlwO2LnNbOiZrLZuc3aH7QNnkucAiIHmeN83srxOZ0r7ZrY/ClttdJ0kGLKwR0CMLpT
        r55ijsrpJXzBf01XET9xZ2VR6PJ2EJ8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-fN042xeIMyGX-OKgGB_vJQ-1; Thu, 21 Jul 2022 22:37:19 -0400
X-MC-Unique: fN042xeIMyGX-OKgGB_vJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 895553802B91;
        Fri, 22 Jul 2022 02:37:19 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA5F9C2811A;
        Fri, 22 Jul 2022 02:37:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk_drv: make sure that correct flags(features) returned to userspace
Date:   Fri, 22 Jul 2022 10:36:36 +0800
Message-Id: <20220722023638.601667-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

The 1st patch cleans ublk_add_dev a bit, meantime fix one potential
mutex_destroy() issue.

The 2nd one makes sure that driver supported flags returned to
userspace, this way is important for maintaining compatibility.


Ming Lei (2):
  ublk_drv: move destroying device out of ublk_add_dev
  ublk_drv: make sure that correct flags(features) returned to userspace

 drivers/block/ublk_drv.c      | 32 ++++++++++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h | 11 +++++++++--
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.31.1

