Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60F4C433E8
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766B561990
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhC3Hij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhC3HiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C181C0613D9
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bx7so17007634edb.12
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQDJlaw0FtQm0N9dNhdmtBw67bwGouq09B/Vh9aj0v4=;
        b=YtO1yU2QWrgOKeHVQIGxgJMu+QPyA3NIaEFfwToAZIMmmMNuxmQIvnn3qK3YezoQ3b
         xAMmEFW2flzQW+r5cDMcWlpAi96i4ZXVq/hLQBV8AXt9mWzpkVRfhnHT6YKnz0cxSzoS
         P1jwu57JsoV8shpDNEQFOdsnnd65A/KdPCS1kRfZOE6odAtkkTJDxZQIEFIZzQn/Yla5
         j4cunMW2L85b6WuXtr43VkhVLV2gxmGV8hARWweEcGM817oDnidYDldNJWm5U/7TW1fU
         wfN4WVbzuV4twq9TavIJUh2D/pjMc0HMpky9cLjGZeccCabOz90fQGmhmOYQ79AzUvhZ
         xeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQDJlaw0FtQm0N9dNhdmtBw67bwGouq09B/Vh9aj0v4=;
        b=BY4Maui/GKZthf5dkzp/36FCR8ifEb4vmfavtEn5PlnkKt88TcIk1+QjXc8zSGluLm
         tsqkEWG2bSv5CqppAib69tCUzty6p2TKvrYkQUfU92256kYx536OjIQjwwmuAOCXr6gT
         C0zytHn4jwaOiW7tLkgCTbz3JlNTCoHihuWdMRR92gH/0Y9FYtuUlGtgwNeSS6Irv9tj
         oN+yZZms0h/7CeQEdtwaOvE6uhGGlOxIiGokB58nJiMzFL/jIHvVhs16uPSepFx0OtdG
         8gn2jO0DoDrWHsc8qV9l34RNwXl9zSd9bGt2TgvL/cej8yosFNGSE6ZrTyEZ5F07R6Ua
         Ld/g==
X-Gm-Message-State: AOAM532KuQbtBmRKKj73Cx69LSElYu2Dq5PitK9NFWgSlhvX/DS1bd6f
        POqXMVZOafY9OkrvJg8rjnZsUBjAM2lnfA==
X-Google-Smtp-Source: ABdhPJzyyQ4e8DODgZmqXTqg5PYpfc7F+L18ziFa1+QtAawYHa4+74NAGE3+F1XFO8kUYCjiRLIjDg==
X-Received: by 2002:a05:6402:4386:: with SMTP id o6mr33873943edc.307.1617089881752;
        Tue, 30 Mar 2021 00:38:01 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:01 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 07/24] docs: Add RTRS/RNBD to the index of fault-injection
Date:   Tue, 30 Mar 2021 09:37:35 +0200
Message-Id: <20210330073752.1465613-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Add new documents for RTRS and RNBD to the index file.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/fault-injection/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/fault-injection/index.rst b/Documentation/fault-injection/index.rst
index 8408a8a91b34..669d146af874 100644
--- a/Documentation/fault-injection/index.rst
+++ b/Documentation/fault-injection/index.rst
@@ -11,6 +11,8 @@ fault-injection
     notifier-error-inject
     nvme-fault-injection
     provoke-crashes
+    rnbd-fault-injection
+    rtrs-fault-injection
 
 .. only::  subproject and html
 
-- 
2.25.1

