Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDCFC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBBD6197F
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhCSWzM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCSWyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 18:54:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC53C061760;
        Fri, 19 Mar 2021 15:54:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c4so4649681qkg.3;
        Fri, 19 Mar 2021 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SABJNqEe2HTdb1AVdo1Gt/ohe6JCde9WaW5fPa98XwA=;
        b=Wvo+uuqDcgtg9VaGpmq8Qv+shNwtdkeGHMlO/k6R8QcJmh1vS4JcWK6yA+EIn3oeQN
         TD0crPBAz4AdltViCX36ekKWjBl40vnfWHuOC3dUjdeKzvi7j+zNbAAX/+KX4So+1uG/
         iK3mRS9m27P9aHxve92o/gMlP1oC1dV+zWHLUTzWzg+9rocKrmrZQD1gkCdCzk3RhwKl
         yRmSulO9VhzXtgdpVuYpSWFdjSCICOV2tg1rPAoF7wLNJpnVBLe1RtSvVkVE5lA7NwLp
         i6xRmtaNW2LbqnKC2J0YMg/jqqp2KBicIhBv0//dU9IAhh7AkWCVkdGgsrHAn+6NSDyU
         1thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SABJNqEe2HTdb1AVdo1Gt/ohe6JCde9WaW5fPa98XwA=;
        b=KH3kKsNWvgfT3diH/jRnMnrb9ILwuor330AQmEmZ/kWcxjfTYqLu9iIl1JwH80nsJb
         Vn1i11rC0o69Pc2R/ZSP2YWatthOCC0ThkjLmDi8JlkKMaps2i+mrrXpgyD9M+9k84N3
         GQ883ZPq/TShwqaWD8P28BVGYGBdQi1u7b7xs6IloBJXqccH16AjnNTwp5aFEZcZelUX
         80AH1ZUODLKRqeNKiSieLIjtJqxqOg+E1pJ3uGkEF3UXNLho4pWrdEJjnHhOm7CWg9XX
         KIYA9QLE0KMS9ymxs6dwduD1tbSQ3rgurSRUTSmqm+9Pj4+RnucEdC4cB9MUMfIvr1LT
         l3Ug==
X-Gm-Message-State: AOAM5338sLGJLTXei6oYDps7UtDh2M4lGlBjjnNZpeEPkfLlNK8SUWWz
        NiDqAzn0ozwbNlJP06AEAdQ=
X-Google-Smtp-Source: ABdhPJzuNghuDe0oGQW/ObrT/OYFaBsnaKJTTQoor7x8AKd7qTUQ6l5zZh2aAgcEZEir7qKSJGwo8w==
X-Received: by 2002:a37:bb02:: with SMTP id l2mr878051qkf.391.1616194484412;
        Fri, 19 Mar 2021 15:54:44 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id z5sm4840804qtc.42.2021.03.19.15.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 15:54:43 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V4] blk-mq: Sentence reconstruct for better readability
Date:   Sat, 20 Mar 2021 04:22:22 +0530
Message-Id: <20210319225222.14271-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sentence reconstruction for better readability.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Changes from V3:
  Adjust the subject text as per actual change made.
  Copied Jens's text verbatim for the sake of clarity.
  Thanks Randy,Tom for the suggestions.

 block/blk-mq-tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..e5bfecf2940d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 }

 /**
- * blk_mq_tagset_wait_completed_request - wait until all completed req's
- * complete funtion is run
+ * blk_mq_tagset_wait_completed_request - Wait until all scheduled request
+ * completions have finished.
  * @tagset:	Tag set to drain completed request
  *
  * Note: This function has to be run after all IO queues are shutdown
--
2.26.2

