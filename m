Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FC9C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE3820831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+uluio6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE3820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeKSU6N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:58:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeKSU6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:58:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id b13so31409103wrx.6
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 02:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oBc3JwPq73FtDGvqk3t8T7Oot3rzsOXj87W1YQabmq0=;
        b=U+uluio6KwtbMMoH3Jp0DEoAQtuhcEmvMYrNiM5KHAwwCapWC33wQhLaMnZr9S/I/0
         Z6sK2Z1/uUcwEavzu8hwJhNC29Gt2B+bLxPWg0ogiXB9yWoJOlUzzK8ssUxgRpXHV3EU
         XnLEDqKsSc9kSrVv/zIWFoLbWLaZfx4laO4js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oBc3JwPq73FtDGvqk3t8T7Oot3rzsOXj87W1YQabmq0=;
        b=UiSDbp3DagvaYi3JyOm2EGWPF93tDJpwHgsZE/Yax2uhvf0USYyS8eZBTzoW8HNubx
         obHBZIbjXpBDIPhMWyqhdWY0UKctwgfUkYtq9j4Wst6TWDG1VjZlfQowagYlbcvm39K8
         sQykyqy3J90eUGSF+koeUS8V19hwxMMRSH32GFPzjOcSo99TDgBNiYLc7FDzxxN/Aea5
         5CTCiFNvZ2hk6EJvtcQOjKiMpw5FDSHdKBks51TSnJ5nXglSo6YmgAgsUe1ELy7eSis2
         GLCcIqS53OsBgJTLha62hgMqlCRdsnBvzfAijY7m/Sn1YpJyvGjKKfjN5g1l1r15eKyg
         pnyQ==
X-Gm-Message-State: AGRZ1gIkRfz0uxplbYpg0IVe83YSA69y74ZyAabDhz/Om8OnCmdVTMwi
        mFO2oef/qWLsBTDeuSgLWc/ITg==
X-Google-Smtp-Source: AJdET5etp8BezkBcu9ThAO0d/Z0yFM4/7bg5m+zKB/fG+37fSeJxpTsIAFoYhNzjTlWgIzYfHEJTRQ==
X-Received: by 2002:a5d:4708:: with SMTP id y8-v6mr17551672wrq.16.1542623698837;
        Mon, 19 Nov 2018 02:34:58 -0800 (PST)
Received: from localhost.localdomain ([37.162.18.180])
        by smtp.gmail.com with ESMTPSA id e9sm14973298wro.16.2018.11.19.02.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:34:58 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 08/10] block, throttle: allow sharing cgroup statistic files
Date:   Mon, 19 Nov 2018 11:34:22 +0100
Message-Id: <20181119103424.3853-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181119103424.3853-1-paolo.valente@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

Some of the cgroup files defined in the throttle policy have the same
meaning as those defined in the proportional share policy.

This commit uses the new file sharing interface in cgroup to share
these files.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/blk-throttle.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6bfdaac53b6f..95825448c031 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1491,22 +1491,30 @@ static struct cftype throtl_legacy_files[] = {
 		.write = tg_set_conf_uint,
 	},
 	{
-		.name = "throttle.io_service_bytes",
+		.name = "io_service_bytes",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_bytes,
 	},
 	{
-		.name = "throttle.io_service_bytes_recursive",
+		.name = "io_service_bytes_recursive",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_bytes_recursive,
 	},
 	{
-		.name = "throttle.io_serviced",
+		.name = "io_serviced",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_ios,
 	},
 	{
-		.name = "throttle.io_serviced_recursive",
+		.name = "io_serviced_recursive",
+		.owner_name = "throttle",
+		.flags = CFTYPE_SHARES_FILE,
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show_cft = blkg_print_stat_ios_recursive,
 	},
-- 
2.16.1

