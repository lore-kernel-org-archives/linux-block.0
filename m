Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C13C47258
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0504B20705
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 14:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RgbKZmFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEDOCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDOCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:02:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117BC061A10
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 07:02:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so10746657wrt.0
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=RgbKZmFqtSSkJM6d+r5UTD3fUFXVDRnzQp23TIXzDrRGHn5MpNGi72hvI3l3ubk9pe
         FkVK54x9z/STdAe3z3T2RGXOK1JThD/mhEipCgwbbxX3xuyqDMg9qTbenKhqEkavm0Hz
         VOUTt3Ui/eDvBcnYlmUbAA97xMmIDY0U+Fh2bVom6M+z7pld8bCI5DiPNB7LWx1d1O35
         jwOH1fF9gaeiQMyVcJ1nWVkoAUHZS7wz/ioPvBbOv18aVUPRdK7ymn2VwgkXYNwrhnI9
         u2BdUhEB8cwuuqiLdsR5IOIEcW/XFoH3zhXHWijX5IZYugEMFc18JHAPKbZYktY4XAb+
         qWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=W1TIRvDgGj8YE1H5n+mq4S4+iq/0FlXhFVoCucyj0sGub/0mzXSZCzEgo8thVQdpUd
         FV7ApWW77o04ZCX8N6cfgI4oTk1ndndDXBLA3vupHI1GpfuJUAq2PJj++DQAYXkAdSaq
         2PdSM/fcP8AOwzgLLXdIOxCj/vuOLgMGg+gaIoK1J+imOsrYPG8bZR/3p9HgJPoqGLJN
         v7frK75K95v8UgE8ebZwTOv5HRYWAqIxJl+JPK3gczFY326zl6Nf7kknGraTlm0ef9CO
         kbpiAwri9sciok/PZyIBg+ViTbxjMcJZ37PK1JrZgv8x4blfgQnPZuDt0iOEQFj2Ojk7
         /LfA==
X-Gm-Message-State: AGi0PuZ8fygrjJ82mkNlY8UPGFCE19JeobG1Ta20+qzxhDGEam9bNaAw
        H2X/ngBT/Fm01wl/yjENipV/XDmKYYGl3Vo=
X-Google-Smtp-Source: APiQypLy9fsA3AOlD+aQ20szdOWFOF/kGVFQDk3EbxnFYMWKjeA+eqFf8HoQV1dGqKGEP3dmF9UdKw==
X-Received: by 2002:adf:bb84:: with SMTP id q4mr18473359wrg.141.1588600927121;
        Mon, 04 May 2020 07:02:07 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:06 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v14 01/25] sysfs: export sysfs_remove_file_self()
Date:   Mon,  4 May 2020 16:00:51 +0200
Message-Id: <20200504140115.15533-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 26bbf960e2a2..d81f9f974a35 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -492,6 +492,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
 {
-- 
2.20.1

