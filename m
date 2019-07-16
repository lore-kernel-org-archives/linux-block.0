Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02435C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE44420659
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 20:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="E0TsVung"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbfGPUTi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:19:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36077 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPUTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 16:19:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so21006784qtc.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=MB4gVXqWNYaKJnrlVX20etvhbnggMPAbdHNsnWIPeXs=;
        b=E0TsVungQ0CRAB8CPusKzkgnknOYKTXIDOYzfPHQXdujxSJjUiCBTmQrMRVdGc5Eei
         cklNvU3oWTctho8seddoap//2XJC7ukV1tKaw3fGfd1PZZJ4eQRuT34UBcD5EOnM2YMA
         tBNsVumhOIEhFoTGm0WmERWdpAeQb4VwvIYfPzWJEMi4xSzs+Utha4IsoLYvNOjziKCC
         TiK2K41IYoc729YHqEZsfjJr7OaPZ56UgKTzzoJiJvSbeXyKCvIy9pz5SP/aJC0juYJA
         6onZVWyvS1sFAUl6nmGtveO2nyZVZE+HumuHK335UcJ3jIJ4S0c1IUX6ksyaEFxJip5C
         nWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=MB4gVXqWNYaKJnrlVX20etvhbnggMPAbdHNsnWIPeXs=;
        b=HM3rPcRqJZQuRf+FGJWoSaQY25TG4cOjJTxNSfZN2zm3DxPiPQTfDT6P84XJyQKjtH
         6DyrpmHCpB8V5JNkY8MeEJnyQAGYgotEZjutguuSW9xefITT++YSt/qI+3m2wdDNwhES
         L70hWXxBGrct59HzmnK0cjH0oKRb5dRIuLFGAu2UQGvtY84/E1yuS5fB1ohM6+lyxaG1
         lgjvY7vSAjWaAyQfvywDgO2vkQxJKzBRvCSlvQ46g9xQi8VRZsDXWLLLExZAjTnMYJS5
         1AYZeGpUYDFbB/Q/d0S4iZs22Y7sTz7439I+D7KCFKEhLcrblJe87YlUbB/FKZC3ZHSP
         8llA==
X-Gm-Message-State: APjAAAWQolazDRrg1JJtJQm7qfnsWE0K+TwRzmJx5n/UUkhL7jkJ6XwN
        u+u4T3oJ0/Y/0AQ4+qDGdx8=
X-Google-Smtp-Source: APXvYqzJJtrhLlNXUoj6dGJO4DPR80pYH7IJTLsI4yzx7sjdGMgUa65FO3qLauCNZ0onWm787lf+Xw==
X-Received: by 2002:a0c:9214:: with SMTP id a20mr26002629qva.195.1563308377340;
        Tue, 16 Jul 2019 13:19:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d7f3])
        by smtp.gmail.com with ESMTPSA id m5sm9285237qkb.117.2019.07.16.13.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:19:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        peterz@infradead.org, oleg@redhat.com
Subject: [PATCH 2/5] rq-qos: fix missed wake-ups in rq_qos_throttle
Date:   Tue, 16 Jul 2019 16:19:26 -0400
Message-Id: <20190716201929.79142-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190716201929.79142-1-josef@toxicpanda.com>
References: <20190716201929.79142-1-josef@toxicpanda.com>
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

