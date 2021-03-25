Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27541C433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BA961A27
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 15:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCYPa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhCYP3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:29:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF7C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ce10so3596044ejb.6
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=f0OsGRux8ILwNqGm4WPm3RTAsZuGzjI7JniW+XLdPo1ddIA0F5nMZlosC72dE7qfQW
         dqwCuqJhBreRpQ51L1CpShYNDN2GVQT1CsBnwG1BWWBwWxZ+4MCtRC0VgJzmoGEzZepJ
         i4ZIHIkDc07KLb0j9IMAE7I3BeikOrMHVkOjb+aJmYw1pcopWOgoI0xEwNEpc+tZU0b0
         o24azRMJKbhlxfyiIy8VEoqL4crB4RKfXNsFKI/zneLqzOYFKP16llvTBRpqF/hEQ/LP
         RTD/IFfrqNULqgUsA3bqlRqmB7DzQlZYhDIAt24GrX5kYUM1Zl4oEjRwVP/8CHjvCD3u
         9I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=ZSMlLo+cOM8cqTGX0R/suL3UF3Ae7T/s5M+vfRTfyjsZIwZGRFKsQG04L4IPD9lOZm
         EdJvQSXC+aHw6QSTtqeep25VcH+CzW+W2lGW3LSGzUQndzHnwmHlApE89zFjawSIsWRw
         3Kczli6uB5uiJMkJRnbvoR+J6ylTBl8Ub3yCosjZQWZQlyhXRqRqz0nzJgcbAXQVr9S/
         TjmJoD9Y4DVVxCh+b3Zc7xC1tm9PI5Qq5Rf20/W37B0XLNNlcLUcW9/3ChGralPDXWmS
         CJBNapVtqAdN3XVUxjBsKUBS0YvqDApJJ6DXzM2n6YfJ5kcikd/9iHrT8fGrPnxPJwp+
         puOA==
X-Gm-Message-State: AOAM533bh/lvY1uXxSbA7/n9oIwwot0UoFi1/f4I/kbsRp6n06Qs3e7+
        1CuoUsGiSmdt02iLL5bbt35d5AAXpB+VrA==
X-Google-Smtp-Source: ABdhPJyM3VvpK/0UbSBgJUlJTRxZJssgLZwXEGu7tNowizoaWFpo/G3tFk2E1ZvhEI+VDETgVjblOQ==
X-Received: by 2002:a17:906:ad85:: with SMTP id la5mr9997912ejb.37.1616686192061;
        Thu, 25 Mar 2021 08:29:52 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:51 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 02/24] Documentation/sysfs-block-rnbd: Add descriptions for remap_device and resize
Date:   Thu, 25 Mar 2021 16:28:49 +0100
Message-Id: <20210325152911.1213627-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Two sysfs entries, remap_device and resize, are missing.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block-rnbd | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-rnbd b/Documentation/ABI/testing/sysfs-block-rnbd
index 14a6fe9422b3..ec716e1c31a8 100644
--- a/Documentation/ABI/testing/sysfs-block-rnbd
+++ b/Documentation/ABI/testing/sysfs-block-rnbd
@@ -44,3 +44,15 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	Contains the device access mode: ro, rw or migration.
+
+What:		/sys/block/rnbd<N>/rnbd/resize
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write the number of sectors to change the size of the disk.
+
+What:		/sys/block/rnbd<N>/rnbd/remap_device
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Remap the disconnected device if the session is not destroyed yet.
-- 
2.25.1

