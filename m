Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE687C678D4
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 08:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCCIna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Mar 2023 03:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCCIna (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 03:43:30 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90A16ACD
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 00:43:28 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id l1so1453768wry.12
        for <linux-block@vger.kernel.org>; Fri, 03 Mar 2023 00:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zopUhSZR4nkgoF37Z7IJFVZw6US6XTQc82K6HvaCLE=;
        b=ft7FRXZGSEkbFIiaIpsrT5WXp4eQ0Jhpp86QVODt4BIKZunSP9xak0fwEQx3mpxUKn
         Pwanx8ER+uPm5eqsmypNebiL+JxI2orQI9PPVq8WUNmzLnykj9MolHzCkx5N/1lWL+pi
         J84sKn+pbaqdbtgxUSP6BGKg5N+gp5u1Zo6OM9yirUL/YaValjwhaiuRfWbUsKMr8LBJ
         7RrlMxqjIk7DhZ+owh9rttNNd8rqlmQzeHE7WzI1a13/eReTGCbHJ/3mJJUrGwUYoqYQ
         BB4nSYXeyGxeVa2iYD/6LYXqRe9d1T1DBz/aV9iPr9/EQ6NzAf01e2pyebdwYu50Poyn
         7SXA==
X-Gm-Message-State: AO0yUKXMRwqHB2/ByRiRcKma5SKZnvhW24j2EY6vPePWDATTen97dL9c
        zEgKBZE94lpr1Iw3z/TPNhSjVDNKWB4=
X-Google-Smtp-Source: AK7set/zp5p2gfC1nzcIyStzta1ZCdmnN8WTjLmEeJySo1EzFLj/PD5hMxA8WX0oIr+eI9IMLlCcsQ==
X-Received: by 2002:adf:f80a:0:b0:2c7:1210:fe61 with SMTP id s10-20020adff80a000000b002c71210fe61mr708106wrp.3.1677833006285;
        Fri, 03 Mar 2023 00:43:26 -0800 (PST)
Received: from localhost.localdomain (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d4e91000000b002c559626a50sm1587399wru.13.2023.03.03.00.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 00:43:25 -0800 (PST)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] docs: sysfs-block: document hidden sysfs entry
Date:   Fri,  3 Mar 2023 10:43:23 +0200
Message-Id: <20230303084323.228098-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

/sys/block/<disk>/hidden is undocumented. Document it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 Documentation/ABI/stable/sysfs-block | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index ac1e519272aa..282de3680367 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -705,6 +705,15 @@ Description:
 		zoned will report "none".
 
 
+What:		/sys/block/<disk>/hidden
+Date:		March 2023
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] the block device is hidden. it doesn’t produce events, and
+		can’t be opened from userspace or using blkdev_get*.
+		Used for the underlying components of multipath devices.
+
+
 What:		/sys/block/<disk>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
-- 
2.34.1

