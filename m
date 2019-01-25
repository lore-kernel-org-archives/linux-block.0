Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0422C282C3
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 02:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A075B218D9
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 02:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjfr06az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfAYCBN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:01:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38998 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfAYCBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 21:01:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so9109363qtj.6;
        Thu, 24 Jan 2019 18:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1O/8Vg+n0PBh/F+vviiWtS5D7RdyOVy+Cza9NKH1rfY=;
        b=kjfr06azV1TkJHkh7en4HWE8VGnCBmGB2PaL/j8aqKKq+XZzA4bXoFU93Qx+IN469L
         mepkt08FWwE8aa/eWOPqlbO7JXItGL0KxDqwq0tVD667vufUXpoI7P78qy7YFHzD/5r5
         ZgIqkpO7Ia1PEunXNJ+7CXyFkuA7sBn73VDJUUv7kldqAIUc0IcKUOz4FwmhaDr/+lGj
         j8f/ZX1oTDphVsOzdvV37rtC1dyI/z3bjH0j+L8Uee0WKcQLnbUBmqQ2r4QTgSN2+WLu
         4YXDWDWwz5foX6ZV2+8ddgBnemPVoHDufdJ6bMMx0a2ylpkcsLrsftjo7/8rjzZox6KN
         12gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1O/8Vg+n0PBh/F+vviiWtS5D7RdyOVy+Cza9NKH1rfY=;
        b=BRvT2qs0Trw54wbYdduBwnU5MX0UEdHnkVKlcM/+xcQCT5ebRXodgR9tvegXa4kiPK
         fYBS8VuB5pxU4inlSNI/mN87qSwOEvLqe16vPH76EduNxDi0yYaCMpzwb540+G3ehOxh
         d4YYqgP8jgCZmWyAbZv9aGqrgtllAh6B/ByTQLi67+De0dQdqVXGYZ3qqjdqiEyU53lx
         XNVgs8+9CRzqNWYeg1zQ5l16mi9z9kIYmIpy12IOv07FRuXkc1y9nP5fu8Qi3xTbNFVn
         gNKYPYzjJBGclYpVtN56cbBbDkXKZehaaIeaFnZ9Q57TGoeHHMwNYcGld8NqPTF8xK6M
         /CRA==
X-Gm-Message-State: AJcUukeWTsLaTrA16jaqZbdWpo5EWCQEvBiHRUxSvqj7tr3vsWVrstG4
        bKHyP5fvEGrFuG6GBX1NcrEoRVXtmtU=
X-Google-Smtp-Source: ALg8bN6+jjFt7m0kvYNz+il1sP34g2j5fy18aOMuTCZQ13Q4mmANMz1sccU5eHL19TcWZtmnwnPqYA==
X-Received: by 2002:a0c:eaca:: with SMTP id y10mr8345857qvp.176.1548381671433;
        Thu, 24 Jan 2019 18:01:11 -0800 (PST)
Received: from bebop.suse.de (189.26.179.9.dynamic.adsl.gvt.net.br. [189.26.179.9])
        by smtp.gmail.com with ESMTPSA id p72sm62329292qke.87.2019.01.24.18.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 18:01:10 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH] blk-cgroup: Fix doc related to blkcg_exit_queue
Date:   Fri, 25 Jan 2019 00:01:42 -0200
Message-Id: <20190125020142.921371-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since 4cf6324b17e9, a portion of function blk_cleanup_queue was moved to
a newly created function called blk_exit_queue, including the call of
blkcg_exit_queue. So, adjust the documenation according.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 2bed5725aa03..77f37ef8ef06 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1269,7 +1269,7 @@ void blkcg_drain_queue(struct request_queue *q)
  * blkcg_exit_queue - exit and release blkcg part of request_queue
  * @q: request_queue being released
  *
- * Called from blk_release_queue().  Responsible for exiting blkcg part.
+ * Called from blk_exit_queue().  Responsible for exiting blkcg part.
  */
 void blkcg_exit_queue(struct request_queue *q)
 {
-- 
2.16.4

