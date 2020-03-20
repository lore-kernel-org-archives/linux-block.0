Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D731C4332B
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D2920754
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="RURARdoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCTMRE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:17:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39052 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCTMRE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 08:17:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id a9so2997833wmj.4
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PE0xCP/YldjBqal9u3IvK3D+Ap2jsQmYbSPkKDPiuBs=;
        b=RURARdoHLWJhlcqA4PGUxmKsA1WnU1gjp4I5mVWAGQAbeCKachmWlTMSoW41HuGbBd
         iCAwWLW8PiQ0/DJa0mkuFubKgea+OGLg276aHzExdPgoGGkcCeApfhePSIxwa/DzHwXM
         2Iongtg4zecxgge+IaukJbm2vv/abTGBUXVFFoWogf3BQ0w8O4K4pk17meGbLINVFYRF
         ArWiFBKYbAWIfPxOYDUja9ZiSgiWw3D59QzOwq1UahQES0V3HedzOU8F+JhWtrVKGZQe
         9YkaZLHinV+JhHCYP2QwCCODJqSwk62RVmFS6PXRy89zcElurEyCfyp7Wm8652yrda6+
         7HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PE0xCP/YldjBqal9u3IvK3D+Ap2jsQmYbSPkKDPiuBs=;
        b=gxABE4CqLv+oLq/RVCYnqcBcOHCYJEnrFn1lslgCzO9oWAFSBgQ8GDaC/iZVWdVGwc
         FnFfCLUBXyLdC2Vpi/TWHKiTcJRb7jFYTbAGsoMJdG52dg11TZw2l8E8RDj5S+Fkx+pL
         8t2GoXA2YuWy2X5kIgJGRKsOG2pl4xFkbdoubKlst707t+laMqgfjOHcFWqKD216NMpe
         oeu/01LP7XeKC9vv8nvK7d2Tqgvha9xYPkLxs6JX+AakTJU/I+4A2gxfQrcuGJKUfAKz
         OVmC9q7wyT5vZai+tvaJwRgA3XMOpH7Ckozc1L0/bwubyL50w7KJtgv72JvGgdLTIjAH
         AyaA==
X-Gm-Message-State: ANhLgQ0l+Nzt/xVtKrD05HyRjZCiohIN+ZjY+P4c/Mqdw+VNvJGkdcRd
        dwVe6T3cnwl7Dde2E8wJ/35vmBtBUug=
X-Google-Smtp-Source: ADFU+vsKq9UcpprQpxnQcostRJ5qfoz+PKsDqa7VgD+MsrC/897xeeLqDSPaJNF8e5wXEbkbP2KqQw==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr9703226wmf.135.1584706622112;
        Fri, 20 Mar 2020 05:17:02 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:01 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 01/26] sysfs: export sysfs_remove_file_self()
Date:   Fri, 20 Mar 2020 13:16:32 +0100
Message-Id: <20200320121657.1165-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
index 130fc6fbcc03..1ff4672d7746 100644
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
2.17.1

