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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05AC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F3361924
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 19:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCST5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCST5L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 15:57:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C91C06175F;
        Fri, 19 Mar 2021 12:57:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id 94so7753489qtc.0;
        Fri, 19 Mar 2021 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mq4RLtzbMNYYLSOlP1OIlaJAP6JC9t4vaA4+WzcZxbs=;
        b=o5PmwzfOFbrI+UkXMquda5EBJsCLIhdIa/jPrgB3UdzIZ0MtU6PZxWkerbqiQby1JQ
         +cOxIfvvWOfMXI2DB+r841cGj2NnEgde/O0wepXDeCYYph8mYhKDUzQK3+g20RxrMUfm
         Jm6jk6L4z9bdNC8xuKnIBrg2iTElT1odEDFDFeIyaeKJBw/x1WtT98QYqPnNV6IVPK/b
         79FrdYH76TfhzL63DWcHZnUFqok6lGgsAjn4T7/2OSWHcQOuz5XetDc+LT8HhTArpdMa
         ng7j4Jvk7bYP+nmm6qZ0VJ9SfU7jhxM73oQN9zCtnBBuw64ATHhM4zJMPLWtqq49hysN
         YU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mq4RLtzbMNYYLSOlP1OIlaJAP6JC9t4vaA4+WzcZxbs=;
        b=Hs6ggk8S8awiwGx7Z9Zmxmvz4a57Bo/8VPukCxl9Ip7ftXFwSmOXMPJ4i5Cd/SPR0P
         INS97UV31YcZXaqMO8PRXqeJ337aF+W3oxFyQjltCY/6pVd1tNO07LpqCUKra7l39LSS
         adUx6pXOd2QH6Db6xoAP872C8pU/P07VLiD9AiPAIAbqRDFVsWQ4haDP3Y54pKsaowdx
         of847g1DOrnZ9UYCkQp3o+uVfWzIDsjxhXC2By1SBQoFyaBkbszezeDWz5qPalsbVZKd
         aJvnr//y5eZZUND15uXEn88HhAxt9RlGxDMMOIpO/8NAACtK2YBD0wnIxIKSUCuJqah5
         8stg==
X-Gm-Message-State: AOAM533k1+YQXQjJJXgJ9EKbqlD3Qb5JZ30yKh5PlnrIHSMUQPKbfvzs
        6TLC3+fIoVO1FSoB1dl2pFc=
X-Google-Smtp-Source: ABdhPJzbPOwfzs6bCo5xs9rkVEFoD9tXan5rfabnghVZUDfyensGaL4rk4W9SqOKdkAbWpqI7Y9jrw==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr315700qtn.148.1616183829697;
        Fri, 19 Mar 2021 12:57:09 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id i9sm5311076qko.69.2021.03.19.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:57:09 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] Trivial typo fix and sentence construction for better readability
Date:   Sat, 20 Mar 2021 01:24:51 +0530
Message-Id: <20210319195451.32456-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


 s/funtion/functions/

 Plus the sentence reconstructed for better readability.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Randy's suggestions incorporated.

 block/blk-mq-tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..c2bef283db63 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 }

 /**
- * blk_mq_tagset_wait_completed_request - wait until all completed req's
- * complete funtion is run
+ * blk_mq_tagset_wait_completed_request - wait until all the  req's
+ *  functions completed their run
  * @tagset:	Tag set to drain completed request
  *
  * Note: This function has to be run after all IO queues are shutdown
--
2.26.2

