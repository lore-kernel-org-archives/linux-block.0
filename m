Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F33C43461
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D3F610E8
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 12:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350872AbhDNMYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350873AbhDNMYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FE1C06138C
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:22 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r9so31107756ejj.3
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiTwN52XJKi66N76pNHN0fIgFTasQJk4pE4Qk8xQaVQ=;
        b=Pdc0LDZhwdWKbZAZBAMgIU76sGR3+rI4soKF4hoj1+6iHZ9AVkGY1unlLnJztaqjHD
         lwrEnCYZvIqNMORksKSSHsz7I08Nfyxi5ArzGbuLt25pJoP92lMJQSe0ABWowZphZFWB
         c4NExjDH8tfE0raBhF/KUifqWFDNo98pq5dJdEs/Wo0YejI72SDUfDn1nYPdoE7M+lWR
         lf8/mvG5EsGPrSrb0T/WJmoMUOpTTAs42LE3UEkuvXzNGR6CWuDPeDAkzEtMftsA5O/C
         YWZ5ejP/nEiMbke1utlzF36ZEcocwOGe9ij34pAC8zapTkGmLNn9wbFUlRveR7juIt+a
         jI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiTwN52XJKi66N76pNHN0fIgFTasQJk4pE4Qk8xQaVQ=;
        b=DgrZEQPb1DEWjRVgYa0UeNJ7kaVmEBpHbkAqFf7T1vW4rRc8iQjF+kYcd4873bYvCi
         BklPwfh2W5sYM20t2UxzGYnawxw3lz6AG+ulL3LcjProU44JbMPsfKWDqiENIlqw2F5S
         rjO6DzLKHv9nBr8sDd0U2b9s7Zme3taL23htP204B8pQlMIZzdzEMUr1ZFgNurSNeZ+5
         mFxYCVyLNn3v+H26oSl2YqsZtl7R0BShoOysPlIbi0nR4e5DXVfRksnhh+pegCYWdBxV
         hKkuGp7Zq7tnwounzy5RFoQ2S4O9csH6t1gCRWWqcRAZEr4vDvGi+ZoeLmuTCETLPFmQ
         tfqw==
X-Gm-Message-State: AOAM5310lnCBLufuUWZn2sNRP9mI82lnj7H8en8NyDW+pzpCXoYHnzCa
        CwICKy1LkpLe49IvkeoZqTRxDMnYJnD+Rc6j
X-Google-Smtp-Source: ABdhPJwDz0SClXwRKgPU72BkYi2RH/4O6CH6cgFAWz26liOPSUHobcPc2neYdOumYP3jzq1LDERphQ==
X-Received: by 2002:a17:906:46d6:: with SMTP id k22mr15632305ejs.243.1618403061201;
        Wed, 14 Apr 2021 05:24:21 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv4 for-next 14/19] Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
Date:   Wed, 14 Apr 2021 14:23:57 +0200
Message-Id: <20210414122402.203388-15-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

describe how to set nr_poll_queues and enable the polling

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block-rnbd        |  6 ++++++
 Documentation/ABI/testing/sysfs-class-rnbd-client | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-rnbd b/Documentation/ABI/testing/sysfs-block-rnbd
index ec716e1c31a8..80b420b5d6b8 100644
--- a/Documentation/ABI/testing/sysfs-block-rnbd
+++ b/Documentation/ABI/testing/sysfs-block-rnbd
@@ -56,3 +56,9 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	Remap the disconnected device if the session is not destroyed yet.
+
+What:		/sys/block/rnbd<N>/rnbd/nr_poll_queues
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Contains the number of poll-mode queues
diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
index 2aa05b3e348e..0b5997ab3365 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-client
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -85,6 +85,19 @@ Description:	Expected format is the following::
 
 		By default "rw" is used.
 
+		nr_poll_queues
+		  specifies the number of poll-mode queues. If the IO has HIPRI flag,
+		  the block-layer will send the IO via the poll-mode queue.
+		  For fast network and device the polling is faster than interrupt-base
+		  IO handling because it saves time for context switching, switching to
+		  another process, handling the interrupt and switching back to the
+		  issuing process.
+
+		  Set -1 if you want to set it as the number of CPUs
+		  By default rnbd client creates only irq-mode queues.
+
+		  NOTICE: MUST make a unique session for a device using the poll-mode queues.
+
 		Exit Codes:
 
 		If the device is already mapped it will fail with EEXIST. If the input
-- 
2.25.1

