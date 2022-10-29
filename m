Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46EBC38A02
	for <linux-block@archiver.kernel.org>; Sat, 29 Oct 2022 01:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ2BFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2BFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 21:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F532F38B
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 18:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667005491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YOx+bvl3SaWN21Vdnks6to/uMQsLR3o8fz87rvQKo+w=;
        b=XYzijBW0JR45Fo9Ni6MVx+1qKc00+dVFhayWcDNpQ+QRbvgJGEexety6z4lvo01QEzRMyK
        YdEwOPUjdWmivwjxluU5aYbxZBOo4rTd8wCQ1/ElxFEUIY7A7w4e9CJIK/3gBTJKFxrRuM
        /eL4Yd3iaWZzpqVuDEuJgKwFFe+vmF0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-2P-saDLZNQa2akiYaOPjqg-1; Fri, 28 Oct 2022 21:04:44 -0400
X-MC-Unique: 2P-saDLZNQa2akiYaOPjqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7EAD380670E;
        Sat, 29 Oct 2022 01:04:43 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A8E01121315;
        Sat, 29 Oct 2022 01:04:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] ublk_drv: uring_cmd queueing improvement and cleanup
Date:   Sat, 29 Oct 2022 09:04:28 +0800
Message-Id: <20221029010432.598367-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch returns correct flag of UBLK_F_URING_CMD_COMP_IN_TASK.

The 2nd patch add help message for deciding to build ublk_drv as module
or built-in.

The 3rd patch improves uses of io_uring_cmd_complete_in_task() by only
touching io_uring cmd when it is necessary, so we can minimize sharing
of io_uring cmd between blk-mq io and ubq daemon context.

The 4th patch is one cleanup.

Ming Lei (4):
  ublk: return flag of UBLK_F_URING_CMD_COMP_IN_TASK in case of module
  ublk_drv: comment on ublk_driver entry of Kconfig
  ublk_drv: avoid to touch io_uring cmd in blk_mq io path
  ublk_drv: add ublk_queue_cmd() for cleanup

 drivers/block/Kconfig    |   6 ++
 drivers/block/ublk_drv.c | 115 +++++++++++++++++++++++----------------
 2 files changed, 74 insertions(+), 47 deletions(-)

-- 
2.31.1

