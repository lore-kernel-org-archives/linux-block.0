Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2EEC43461
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F5D613BC
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbhDFHHa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhDFHHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF7C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h10so15176340edt.13
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=ADWipWJZQisqEZZVWrg6KcEkCEK5XnhrPQQYTUVfnuG5I2aOB1W9MYHAKSPpZ6oCRs
         YrzJXsjF1yL4t9V7b2o+19qMZ0rqnv6xPYKpHl+27OflQIbb9dl5ZdBmVHOhQTOSH5SV
         ozGV9KsZsZ69SHldylIi4MU12hAAX6wryhS1YNN6Petn252VlNXSRKGliHV5lSBXwcIm
         hm624emLCn8AtzOKcWEoIrhwnRwnQeIr8Ljwjb/55YYAlg8IwYP/HuSqi4gNjL9TJRm3
         AqgeZPoqRFNJ0xsrI5GTaco7VB2A8xOBcG3rwQWUngNa7tKom6vG+jC1pUSjR2oK9rpw
         aSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=gYOd8ti/oAfD+Cq/JvZfL5VOXVONlGi21rpsQwxm7K3hUrD/Uio/hGC9kAj3oe+4Mn
         l4Oy4lPk9jQtUGKlUWhURy8eSEJ4a4wIaQaQzz79NNot6vM46BCwAgwE4eZ390FEXbgI
         X3nKjjy+Ednj/9wmfMrcCX8dfBcs3dlxV/2fS5k4XfxuKYJtd8qy2mvTBasMnys0YsQq
         P7p66EqkE0uFUofvLnJZnhK1V3OdiwLAdUJvz0akWgs/J+wGqYeoIUv2OZZ9stdEcfFA
         mmokJ39Y7dM27fadfrR/obthMinIQwKQNW8HT5iFUaQ54IkfdGt5SZNSZJ6ckP7q0NpC
         xABA==
X-Gm-Message-State: AOAM532eCpHZ6of+fJ2tM7vDnfcpzLPR1ZJjmmJoeaHPqA24ThxhS+U2
        MOhlGkc3I6zSdEG4gdEu9LfzSs0NkpqkHg==
X-Google-Smtp-Source: ABdhPJz/QBDNCrM0uhn81hWJ3H+PG8z0+hubLapnTJPcFn7NX4PZyyc/EzfXZI/8H3tYupsySBRLkg==
X-Received: by 2002:a05:6402:27ce:: with SMTP id c14mr7266551ede.263.1617692841406;
        Tue, 06 Apr 2021 00:07:21 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:21 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv3 for-next 02/19] Documentation/sysfs-block-rnbd: Add descriptions for remap_device and resize
Date:   Tue,  6 Apr 2021 09:06:59 +0200
Message-Id: <20210406070716.168541-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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

