Return-Path: <SRS0=DoUd=BU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B6C433E0
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 12:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A3420729
	for <linux-block@archiver.kernel.org>; Mon, 10 Aug 2020 12:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="JXjmPpxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgHJMA4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHJMA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 08:00:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764AC061756
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2020 05:00:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i92so8817314pje.0
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2020 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=J5NMSWLZnk+MsiWSWRywCSAdMKXFevy9G71hx6FYlmU=;
        b=JXjmPpxSzA+gVk/JHPgluZHOVUYN7iwvYtV7P5MQ6kGnwpLbdiN1vh8sHh60eKo4y8
         IaUgel1hBWnI6LxxXqNd9oXw3E0p6GoD+rQOktcY90SU7vnJB9CTGkrCz8FACHrH7y7D
         HBmU+fif+gpbIVXPtZLhh6shMFWUCy7anLXZIEppJhpEYg1nTPH1U3sHrhGcJV1MZyfV
         /A8Xn/Pgv0cKOaLfroHbn3/zfC2rRkQs6WM61VPZ0HwM12wNHWlKjnplTDLxYHm3KGHm
         lqLLIhASAOr/8ZHr/B6mVvNLZxmG4/1eevbC3HoZs2jtDO86ggNSr7cDpSCrEGQUO5S2
         pHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J5NMSWLZnk+MsiWSWRywCSAdMKXFevy9G71hx6FYlmU=;
        b=VV76zgXqAkrNeZGQXdMCnLu3SuWz1Gq3ZoE/qRJcIYSC7j+jYjEFDu0Qigu4ARHggW
         hZHL2eSGgWIazDgBcKRYPYpl3k0toJrtAJNaYjRQupBwm72sHQDcHfmuzRvqpUA6I9BI
         xIev6jXItl2D0CKwza8JdNA/pDD8MSGse8+XPVhrzzOmZy8nQume3KbXoMjXVuSvgs/E
         CQWQMVggl5bXE2mniXPsDiO6GQzf3UB0RvP4j7Nc5rMjgflKsQgoemMOdg5UUXY0KzX3
         TyevA85RgeTfg23ycQdmgzl2YNHTgd+m+jfpY8iIcftQYjQIOznrsNKzHBXGHBzJmrXo
         2Ldg==
X-Gm-Message-State: AOAM532rrQAv75xX9QPYrq50vphnS8loG//fixnzsq0ZdfIQglJe0Rr2
        skZmBTblL8Knty3/joAYv6EtGA==
X-Google-Smtp-Source: ABdhPJwq5sbrPHVl71G13+on8Palt8gY94TlYincrSVzLbZ0IroPCkjWv9neUvHk/9Vlas+e8Add9A==
X-Received: by 2002:a17:902:bc46:: with SMTP id t6mr22965741plz.273.1597060855161;
        Mon, 10 Aug 2020 05:00:55 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id o134sm22222637pfg.200.2020.08.10.05.00.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Aug 2020 05:00:54 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH] nbd: restore default timeout when setting it to zero
Date:   Mon, 10 Aug 2020 08:00:44 -0400
Message-Id: <20200810120044.2152-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we configured io timeout of nbd0 to 100s. Later after we
finished using it, we configured nbd0 again and set the io
timeout to 0. We expect it would timeout after 30 seconds
and keep retry. But in fact we could not change the timeout
when we set it to 0. the timeout is still the original 100s.

So change the timeout to default 30s when we set it to zero.
It also behaves same as commit 2da22da57348 ("nbd: fix zero
cmd timeout handling v2").

It becomes more important if we were reconfigure a nbd device
and the io timeout it set to zero. Because it could take 30s
to detect the new socket and thus io could be completed more
quickly compared to 100s.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ce7e9f223b20..bc9dc1f847e1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
 	nbd->tag_set.timeout = timeout * HZ;
 	if (timeout)
 		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
+	else
+		blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
 }
 
 /* Must be called with config_lock held */
-- 
2.11.0

