Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA8C43446
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FC161A28
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhCYPai (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhCYPaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:30:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C24C061760
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u9so3593206ejj.7
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsqeH5MSM4WbTb4VKhs81+DKBsJLqPP/9bH4vGe5fWs=;
        b=BwFNqy2ljo5aG/UcinYyfzPddWzPYSzPnPO0wTs6ZnM0DROsh3lYs2lwgZ73LBPuwA
         cPSVwzZkgWwjNg1p1d6oYTeaFxehPzigfFb/ma/6TTSIN8AQxBHfZWejiDJaxaQHRCmx
         bAE97NM5+qtRXmFyf1aSyCrBt7egUDIcSrjZVRj5WI2OQQ3HBQ0tg4XUfiYa45KJBdq8
         WljkCoieP5YWNwfX4lWt/poIM0ROGIvDYpZ1CqSZI3MI7ltRuyGKzAYpefvbeIDqdDzr
         j5TEP3wAgMZcLFbWtweKHWoBvqicVjNCQJS/LTOsA/512B9SxV6yNXjEpCjVxj0CRb5P
         6diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsqeH5MSM4WbTb4VKhs81+DKBsJLqPP/9bH4vGe5fWs=;
        b=U8RRlci7xR6c6xhJHRVgMRcwoRarJgfN1D+yHn5GTS2yTRnryxfXIWX3bdGrgETwmy
         LQ3QmCncmA57woGJb8Az0prexq3Nmq3l/sIJbAETbAtXfDwWHAy+Jtvhc0LUALs2JAbo
         PZi57dktehMwdAzu2hlUHxJrfU/jWbNTWq0T2KKSASM0UvR/0do4ExH0Ts+aitNEJzse
         ILX+9U2X10OcCSzn0ttpwf1mWC0qa3Z28nkVjQ16/rrgrFpYA9dHbHdXfbLDU5Bm6AF5
         wKEsv+Afr+fSzIivjzETo7lYqex+AqJ0asdqu9ZCAqUa6ZaYk2UZSqC1EicEeBdhVC6G
         p4VQ==
X-Gm-Message-State: AOAM532YZemErgDb5enSAQUaH38vKHHtQG+lMLMZDkvCMb04lq4vfQo1
        1nNVZQflcGZTwSV3CnYrh5roAKq2NRGqiqgZ
X-Google-Smtp-Source: ABdhPJy0MzG/EJkFVeJceVKqlETB7gShlaU/2JLoYpa/dFrGrhNFmCM9EZOCqXAc2iLmgSxlHD7HQw==
X-Received: by 2002:a17:907:78d9:: with SMTP id kv25mr10259637ejc.415.1616686205497;
        Thu, 25 Mar 2021 08:30:05 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:30:05 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-rc 19/24] Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
Date:   Thu, 25 Mar 2021 16:29:06 +0100
Message-Id: <20210325152911.1213627-20-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
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

