Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7169BC76191
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC7A2171F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 20:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="xQKVpC/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfGOULa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:11:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33003 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfGOULa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 16:11:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so8836713plo.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=MB4gVXqWNYaKJnrlVX20etvhbnggMPAbdHNsnWIPeXs=;
        b=xQKVpC/gFkHj9XGqYbFT9QwlUw9vLWV/I4yEjny8GRIwQY4j4Cwv+TKgRgyZ71pHBe
         +Q2Qor1COxoZyyDuXq4xTORWGxFS69X32EehQoWuETojAYG2SmNQ0T5xKo+kHbZLmEwH
         iYkC3xUB8W9EEE9GjbpxQeyLP7o82fm4ewTW5B1lt+t8z9fTPxBz4dLOztClI2LDQXJs
         M8SBSxSOQNZaxtEO9nKKHih66xOKyWCDXkNj7grcGMaUlmacW+8/JPr1Q8tnEFeC1sXx
         AN1DvvqFbc57FzsgzHXKfUilI3LdTMrorN5dpVv+D9ABXUGUf27Uw5SMkEid3DVf6mAx
         hVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=MB4gVXqWNYaKJnrlVX20etvhbnggMPAbdHNsnWIPeXs=;
        b=rzPr4EALmL80D03umdgPj75aM6FXN+S9h3ZRguURHO16INu2Kjoe1t774g923z93C8
         khFYXwVnupy+kvVQrXn4MVD4TwrZIyf5jS0sGINtjBgDHM4xWTb+h4EUuY3YffTN9Gzx
         Mp6CmJaE87ofjQPuqfa2t++XZq9mc0QBk/PEvs2bd7N4ZXDQLwi0hqAoi5Txii4dmF0q
         KHsgDoO1eAqrB3IO3EUJwu5PFBnSOcCnuoaG/9WtjDW10G0JljlXMHHV8AF1qFFqK9vD
         dh7Q4swYpHHfJiomSW+0nTj6A91ERaWrxM1cfNK5SK9usJxlWRyw3exBRL/+8gNctStB
         bFwQ==
X-Gm-Message-State: APjAAAW6tHl/Qm6oBZq3cNDICa0UXR9XBzU9B7YhoHMKwwWJts5KXhVr
        /lBgondhw2r8YczYqHfdQHZCZjB8AE4=
X-Google-Smtp-Source: APXvYqxhVQMunxrDtxDEzFdb/upPWtMDsgL1O0zWrOChUH/xczkCKXzjvwUvgPJnaHdqlrUFb4lsBA==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr29155243plt.247.1563221489457;
        Mon, 15 Jul 2019 13:11:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4caf])
        by smtp.gmail.com with ESMTPSA id h12sm23119181pje.12.2019.07.15.13.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:11:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 2/4] rq-qos: fix missed wake-ups in rq_qos_throttle
Date:   Mon, 15 Jul 2019 16:11:17 -0400
Message-Id: <20190715201120.72749-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190715201120.72749-1-josef@toxicpanda.com>
References: <20190715201120.72749-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We saw a hang in production with WBT where there was only one waiter in
the throttle path and no outstanding IO.  This is because of the
has_sleepers optimization that is used to make sure we don't steal an
inflight counter for new submitters when there are people already on the
list.

We can race with our check to see if the waitqueue has any waiters (this
is done locklessly) and the time we actually add ourselves to the
waitqueue.  If this happens we'll go to sleep and never be woken up
because nobody is doing IO to wake us up.

Fix this by checking if the waitqueue has a single sleeper on the list
after we add ourselves, that way we have an uptodate view of the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-rq-qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 659ccb8b693f..67a0a4c07060 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -244,6 +244,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		return;
 
 	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
+	has_sleeper = !wq_has_single_sleeper(&rqw->wait);
 	do {
 		if (data.got_token)
 			break;
-- 
2.17.1

