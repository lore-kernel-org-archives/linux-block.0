Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88509C433F4
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8E261883
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhC3Hip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhC3HiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F13C061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so16998460edt.13
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsqeH5MSM4WbTb4VKhs81+DKBsJLqPP/9bH4vGe5fWs=;
        b=DMc/khhH7OoDWL0/7S4ob7huNbmxVOL9Rn+xY21KkTFiWafuieOmN3bFtc1flNLQxd
         JjFrU0Fl32RStbdCVKWCIPO3bPj0/v2QrVEB3KRUsXW0wwvrjL95ag222a2OIP6xoV/n
         q2ZtR9EgjA/6XFhSrUKn1Rl9LTKJqeuqJ79Fd5fve1FZVxlAFJm+Mr7c4GJUROTa76U2
         li4Fwqk3yYtxMbjjiRn03P1TEW7R7S5wRCJlE1oOH8TKznmkfky7AlXK/AEMvqJhQACw
         dj0sbz8J8AmJYFMxeEQdiNRVJPf3LXHNTPFA/kZQRW50xnOKowUUpO6Ao0vh8hqOjQcd
         vReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsqeH5MSM4WbTb4VKhs81+DKBsJLqPP/9bH4vGe5fWs=;
        b=GSXtk3K6wHjP3LNITYsYJVTaHGB0jGIgDQUsmNclubeclNDMcpvz0pztwOtcVRcju+
         I933BZgJwARlYxusRa09wRcQryeJOyVMX18Se/0ohstDeUTVfiOZBJC6g6Y9B0LZw0fE
         iFq3pqMx1EoWZj8Qu5/nf+4sAou8dd8i2Iww5WRb7M14dMXemiXOLo7TaDPwHbl63Ynh
         O+cd4SUqfZ5QCUbniAdGkq4+UuPidE38QG5vdqTL+9H7nzUiYlIW/Ed6SUQBGiF2RvO2
         2dTBwc9+9kSpI2DdxyYdcPfxEbcKZKp76O0UjA8tdxpGIrkrKA4A9ywz2NtslHlNh/q7
         fvuw==
X-Gm-Message-State: AOAM533fnBqxn5HFa4OwiP0SvRCNM7RvT78YrKj42w7Kme3gGvd4ogka
        +j2vP0MFXGygcO/R6eOLRTRSxa3wIWqIzHPT
X-Google-Smtp-Source: ABdhPJyGFpcXeQYZsMyqXNZ1BmY1bb/qSdJgaf0tZTVDQucaAD/Iueem1rfRz/Mdrfur8YbBFBmu5w==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr21692722edj.357.1617089892172;
        Tue, 30 Mar 2021 00:38:12 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:11 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 19/24] Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
Date:   Tue, 30 Mar 2021 09:37:47 +0200
Message-Id: <20210330073752.1465613-20-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
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

