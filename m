Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DC7C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F452086A
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKp2I6yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F452086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKSU6A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:58:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33376 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeKSU6A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:58:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id 79so2404334wmo.0
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ixCco3tkgOz6XOnATIyg3v7JG+fMVyFH/i6hN9+7LbE=;
        b=kKp2I6yh/orVyEouSJpVWokRdAT9xO+g+kCnqgaaTzcRgXwvj2mzpvsQeI/fL870j/
         FWJpkmfYHVEX994JHS9HKt3nipa3xeLHvXCMO6b7u5kQXIhAGjuRJ+Y8HyG2lb5f+Ag9
         5/O6i7rXVsv45I3wffJr69woHSqCdtIyD3Cxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ixCco3tkgOz6XOnATIyg3v7JG+fMVyFH/i6hN9+7LbE=;
        b=YItD4pChOaXNVIAEvlQEvq3QnR825QYG8rvxepPtD1RG/Y9tI/HLWhbTqSfL5iaBq/
         HsUo6AwxnVMLuWqfqOwhMeaSDDlIMM/Ahuqx77XkH724xxzkG5kC0BRpnEUoWtQ94HdE
         X3n/UUTrX+8b93tbpngnChPVl0qn4k3OR1r3J7mVNxOmSorepiy4mLVAbEa4RKQDJoOD
         kklLexFF7AyWfXTvQo5yj1Y0r6MFDe4eYsdnE5g9rZsLi0ODqEr353jiX7sotClwPNlY
         ZT5CTm6WkRlYyyOTEujn1N4zXSZvHfjUZNuJpUQHfcGFqOC68ykMoCDleZaUJhLxGXo0
         /IHg==
X-Gm-Message-State: AA+aEWZ/ybcLu4+OvfZi6fEXzBf6qiAlswYTL3DOnCyg2KYclO27V0ob
        oeMDJ6I65rTo0z6jjQkFBxKuCg==
X-Google-Smtp-Source: AFSGD/XQN0bxurfeBwqVhi42PyrkCx7YpUAfDxlfoSPjxaAmOF+536pj4Jx/EI2aSgzxGuXsLZUQ4w==
X-Received: by 2002:a1c:2b45:: with SMTP id r66-v6mr6662149wmr.128.1542623686156;
        Mon, 19 Nov 2018 02:34:46 -0800 (PST)
Received: from localhost.localdomain ([37.162.18.180])
        by smtp.gmail.com with ESMTPSA id e9sm14973298wro.16.2018.11.19.02.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:34:45 -0800 (PST)
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
Subject: [PATCH V2 04/10] cgroup: add owner name to cftypes
Date:   Mon, 19 Nov 2018 11:34:18 +0100
Message-Id: <20181119103424.3853-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181119103424.3853-1-paolo.valente@linaro.org>
References: <20181119103424.3853-1-paolo.valente@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

The piece of information "who created a certain cftype" is not stored
anywhere, thus a cftype is not able to know who is its owner.

This commit addresses this problem by adding a new field in the cftype
structure that enables the name of its owner to be explicitly set.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 include/linux/cgroup-defs.h |  2 ++
 include/linux/cgroup.h      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index d659763c7221..6e31f478c6e1 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -36,6 +36,7 @@ struct seq_file;
 #define MAX_CGROUP_TYPE_NAMELEN 32
 #define MAX_CGROUP_ROOT_NAMELEN 64
 #define MAX_CFTYPE_NAME		64
+#define MAX_OWNER_NAME		64
 
 /* define the enumeration of all cgroup subsystems */
 #define SUBSYS(_x) _x ## _cgrp_id,
@@ -505,6 +506,7 @@ struct cftype {
 	 * end of cftype array.
 	 */
 	char name[MAX_CFTYPE_NAME];
+	char owner_name[MAX_OWNER_NAME];
 	unsigned long private;
 
 	/*
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 9d12757a65b0..267153bd898a 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -291,6 +291,19 @@ void css_task_iter_end(struct css_task_iter *it);
 			;						\
 		else
 
+/**
+ * list_for_each_cft - walk circular list of cftypes linked together
+ * @cft: cftype from where to start
+ * @n: cftype used as a temporary storage
+ *
+ * A cftype pointed by a file may be part of a circular list of cftypes, this
+ * macro walks the circular list starting from any given cftype. Unlike the
+ * "list_for_each_entry" macro, the first element is included in the iteration.
+ */
+#define list_for_each_cft(cft, n)					\
+	for (n = NULL; cft != n; n = (n == NULL) ? cft : n,		\
+	     cft = list_next_entry(cft, share_node))
+
 /*
  * Inline functions.
  */
-- 
2.16.1

