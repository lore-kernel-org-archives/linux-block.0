Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E86C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 02:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DE061263
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 02:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhDZCyw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Apr 2021 22:54:52 -0400
Received: from mail.synology.com ([211.23.38.101]:33070 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231530AbhDZCyv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Apr 2021 22:54:51 -0400
Received: from localhost.localdomain (unknown [10.17.32.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 1233BCE78097;
        Mon, 26 Apr 2021 10:54:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1619405650; bh=wAjRTvLic0pVgluNJL65go6oMZha3oZzIeK8QANysC4=;
        h=From:To:Cc:Subject:Date;
        b=HVU7dhS5eXLjgSVV4uJbEKQS+/OXWKYr+InX1Es01iDgQvIW8RxD9pzU9CqEcJiHf
         C0cwGOZMGdrXplfIP81HQu6i0+Bo5M4GLlXzrI+e8AqhSzLstWIcQvqLX0QXp7IFKi
         yfpmeTx6BNCbHtgf+cL4KaKmdr5iH7aYQZHNlK4U=
From:   taochiu <taochiu@synology.com>
To:     hch@lst.de, chaitanya.kulkarni@wdc.com, kbusch@kernel.org,
        axboe@fb.com, sagi@grimberg.me, james.smart@broadcom.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Tao Chiu <taochiu@synology.com>,
        Cody Wong <codywong@synology.com>,
        Leon Chien <leonchien@synology.com>
Subject: [PATCH v2 2/2] nvme-pci: fix controller reset hang when racing with nvme_timeout
Date:   Mon, 26 Apr 2021 10:53:55 +0800
Message-Id: <20210426025355.3005949-1-taochiu@synology.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tao Chiu <taochiu@synology.com>

reset_work() in nvme-pci may hang forever in the following scenario:
1) A reset caused by a command timeout occurs due to a controller being
   temporarily irresponsive.
2) nvme_reset_work() restarts admin queue at nvme_alloc_admin_tags(). At
   the same time, a user-submitted admin command is queued and waiting
   for completion. Then, reset_work() changes its state to CONNECTING,
   and submits an identify command.
3) However, the controller does still not respond to any command,
   causing a timeout being fired at the user-submitted command.
   Unfortunately, nvme_timeout() does not see the completion on cq, and
   any timeout that takes place under CONNECTING state causes a
   controller shutdown.
4) Normally, the identify command in reset_work() would be canceled with
   SC_HOST_ABORTED by nvme_dev_disable(), then reset_work can tear down
   the controller accordingly. But the controller happens to return
   online and respond the identify command before nvme_dev_disable()
   should have been reaped it off.
5) reset_work() continues to setup_io_queues() as it observes no error
   in init_identify(). However, the admin queue has already been
   quiesced in dev_disable(). Thus, any following commands would be
   blocked forever in blk_execute_rq().

This can be fixed by restricting usercmd commands when controller is not
in a LIVE state in nvme_queue_rq(), as what has been done previously in
fabrics.

```
nvme_reset_work():                     |
    nvme_alloc_admin_tags()            |
                                       | nvme_submit_user_cmd():
    nvme_init_identify():              |     ...
        __nvme_submit_sync_cmd():      |
            ...                        |     ...
---------------------------------------> nvme_timeout():
(Controller starts reponding commands) |     nvme_dev_disable(, true):
    nvme_setup_io_queues():            |
        __nvme_submit_sync_cmd():      |
            (hung in blk_execute_rq    |
             since run_hw_queue sees   |
             queue quiesced)           |

```

Signed-off-by: Tao Chiu <taochiu@synology.com>
Signed-off-by: Cody Wong <codywong@synology.com>
Reviewed-by: Leon Chien <leonchien@synology.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 09d4c5f99fc3..a29b170701fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -933,6 +933,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
+	if (!nvme_check_ready(&dev->ctrl, req, true))
+		return nvme_fail_nonready_command(&dev->ctrl, req);
+
 	ret = nvme_setup_cmd(ns, req);
 	if (ret)
 		return ret;
-- 
2.30.1

