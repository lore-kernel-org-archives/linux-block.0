Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA5C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ACB2184D
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BpD7+A8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfC2OBW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:01:22 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:52360 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbfC2OBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:01:22 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 407A020EF0;
        Fri, 29 Mar 2019 17:01:19 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id rgKlzJY0yI-1I34egO4;
        Fri, 29 Mar 2019 17:01:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1553868079; bh=W7/RS3vHJEbXBp2niGN4WUhiiMnPTF+LmOZwA1GB9ps=;
        h=Message-ID:Date:To:From:Subject;
        b=BpD7+A8Pudi56qbvTXEpBI2C8bQ5UyGyEieWMZ5HiKFd3laF5DdeqPS6z/Od+zPVt
         TVxtYZUdTN74vqrBpxRz5ouCEq0jVS+JDuI8smKTTE++H4W7SLUhkmjMhJOMBXtgAM
         tgfUPuOoqKkF42lciXz8TYeJChOsvEOJnJZXPY+8=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:cccc:f1a4:6b5a:61d8])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Bnb6ODpKCW-1IsiVsO7;
        Fri, 29 Mar 2019 17:01:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 17:01:18 +0300
Message-ID: <155386807826.3190.16175453392005064129.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace BFQ_GROUP_IOSCHED_ENABLED with CONFIG_BFQ_GROUP_IOSCHED.
Code under these ifdefs never worked, something might be broken.

Fixes: 0471559c2fbd ("block, bfq: add/remove entity weights correctly")
Fixes: 73d58118498b ("block, bfq: consider also ioprio classes in symmetry detection")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/bfq-iosched.c |    2 +-
 block/bfq-wf2q.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4c592496a16a..fac188dd78fa 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -674,7 +674,7 @@ static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
 	 * at least two nodes.
 	 */
 	return !(varied_queue_weights || multiple_classes_busy
-#ifdef BFQ_GROUP_IOSCHED_ENABLED
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	       || bfqd->num_groups_with_pending_reqs > 0
 #endif
 		);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 63311d1ff1ed..a11bef75483d 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1012,7 +1012,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		entity->on_st = true;
 	}
 
-#ifdef BFQ_GROUP_IOSCHED_ENABLED
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
 		struct bfq_group *bfqg =
 			container_of(entity, struct bfq_group, entity);

