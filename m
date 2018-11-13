Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E96C43610
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA57216FD
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xeGLuow6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA57216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeKNBlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:19 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51858 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbeKNBlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:19 -0500
Received: by mail-it1-f193.google.com with SMTP id m34-v6so18845052iti.1
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m48q1bxkjgPE3pO6xckxzVFKbD3tRifqvuBgJLgXytM=;
        b=xeGLuow61BSMWLlrgS6GSbTkSpHNLcHr3ZTAWmyt3mALZ7KY9xjayykcH7xd0fYDrp
         giuq8uurVOlCBddmqvz+v8HCodulC3gS2m5F10dabjvP4Z8uupOrZnty2bsU5/WW6LYz
         4k0tMHlKZrXhcvP94D738KAf1fLDYtQpUlaf3BrWhNc8ZnXeLJm0o3d1FBiydlmDqvXl
         MgdJkn3MonAR4OUcSD27TMzCunAM3DpLcK0XA3rqgMX6NwVmVxvcXBa/ngc0f+fYI5Yy
         E7tLuXJnfmtQ0BxAkuI5NbG56cWKtbNv5WZRa5KGy8E6Z3nyhVIzO4N81B8i9SlLwDAi
         kvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m48q1bxkjgPE3pO6xckxzVFKbD3tRifqvuBgJLgXytM=;
        b=eBGspW5l8ZoRlKEf5npgWi4LYBGlV4nDyRZ549RlfcCkA6cZ8HDH11910yK/NRGWPV
         Typfn0pdcmEvhA0XOpfiDGcQw7BhOD5QfJM/Ce/rX+VIVFOUT12ruMWAOUJjhvmBl7Js
         wVVgwAa7BbyHupvsG1BqDZ6vznaNQUDDOLH4yAidi9XoKU5QO8bJ2y/zecaG9beIH72O
         Pzz2GEQDRFyoaGQKJe45KtvJ2VH/B06qjIP2NeK5nrQsabylts4jlfr99GJa7Dl42t+z
         oqTUACIL293RRTLn07gqG+WXegazaFfKG0cbXP9DG0uWe1A+etgEtW9rYZmXN1AFvcV7
         Q/Qw==
X-Gm-Message-State: AGRZ1gIXgREhNDttItPiBpuU5DFW/36rmsSHoD5m87WYNcwd4jMYYY55
        Xd/hx6WL/dq+DH0sDUzLnxqjT1ypxug=
X-Google-Smtp-Source: AJdET5c0BkqyEoxImifEWogTCd4ia5yjhkEK+sKF8WeJyRxyBa/RWg7GjDbxspZvAS0Vz/K6nxfqyg==
X-Received: by 2002:a24:7596:: with SMTP id y144mr858628itc.68.1542123760095;
        Tue, 13 Nov 2018 07:42:40 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org
Subject: [PATCH 01/11] nvme: don't disable local ints for polled queue
Date:   Tue, 13 Nov 2018 08:42:23 -0700
Message-Id: <20181113154233.15256-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A polled queued doesn't trigger interrupts, so it's always safe
to grab the queue lock without disabling interrupts.

Cc: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6aa86dfcb32c..bb22ae567208 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1067,9 +1067,18 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock_irq(&nvmeq->cq_lock);
+	/*
+	 * Polled queue doesn't have an IRQ, no need to disable ints
+	 */
+	if (!nvmeq->polled)
+		local_irq_disable();
+
+	spin_lock(&nvmeq->cq_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irq(&nvmeq->cq_lock);
+	spin_unlock(&nvmeq->cq_lock);
+
+	if (!nvmeq->polled)
+		local_irq_enable();
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
-- 
2.17.1

