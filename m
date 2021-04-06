Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F50C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EEC613BD
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbhDFHHl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244159AbhDFHHj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A7C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hq27so20160106ejc.9
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsqeH5MSM4WbTb4VKhs81+DKBsJLqPP/9bH4vGe5fWs=;
        b=FEfmwQUXBosAQZDv4iPqtBJQ9H+nanJx8NHptNglQNyUYRFXiXUhx0jXHKDcQdJa3a
         zlpYM1a02NTJa8wYEwc5djYFvY3PrIr1bGxbpKNynHiFGicIBsRcVfkII+8UEGrQCYCV
         +R9tFrIAnWHAe3pzNO4oGZ+taZNFW/x4Je34Q/TsOW6REc0WLdUZGkK58jHo4bAblw79
         A72qwuqPdz/Ge7dLThxgThZ0epp/7dzyZWhh+4cLbHV5zUbDwJP7CagtVvmouRJMqJqQ
         VKsYi4zW7KUz3waH2ovUvZ+QbxZfR2WbwyReKvQnofYw/ThWx5Prx54Iam8yFUsPftS/
         cAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsqeH5MSM4WbTb4VKhs81+DKBsJLqPP/9bH4vGe5fWs=;
        b=EXo6fycdoFOrwmR4zN3W37/GhjLQebwf3PlIU13pRWcn9s66IstHdg9Uaifg29E4vu
         lf9xMKb65GdlO4QD55tGQq9Fb0tQ65IbfnLKzH99pGL+EAQhtmwnOxq2uwJS9B4exDK3
         bnsfqRfvzjcrauJRxEfhrWNaDo0fZKfRiDTrTcv0dak2ETQXF+FkORet9pGBsH3XtgdK
         uapC12etxQtafaI4WNQNVJUHAqEJPBpTslW5ptKAaPzTkh9ELyI1o1XI7V8nYo56xeZj
         jRF9E+OHaNjfnEU3IPr8U3iJKlQswBvf2kzWO3TLQ+RQXXxCm7rx1OsfH340vcYeITVu
         SEQw==
X-Gm-Message-State: AOAM5319VvTdUxxjwn8D44M95I34nMvdpZNQZD2UXjvOfHXsBZ8cnrJO
        Xr63tWuU2gMEVErZkSegnUTcbQl2HT0YUOrw
X-Google-Smtp-Source: ABdhPJwskWgEDrPtSjvJKOluxt9Xrw5sCnUjjCo+bXft88vaUchkEVSbKfQcj8aSVJuu08B983zKxg==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr32293574ejt.410.1617692850455;
        Tue, 06 Apr 2021 00:07:30 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:30 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv3 for-next 14/19] Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
Date:   Tue,  6 Apr 2021 09:07:11 +0200
Message-Id: <20210406070716.168541-15-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

describe how to set nr_poll_queues and enable the polling

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
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

