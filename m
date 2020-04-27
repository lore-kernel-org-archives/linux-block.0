Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D718C54FCB
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491042063A
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="bAHQyR+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgD0OLK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgD0OLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:11:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107CC09B050
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so20718829wrb.8
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=bAHQyR+2H/NT4ao1Xoqb0ve9bvBgahVQhsQG5LSWK1DAXQYhtdVnqI3RX0dPBtsDNm
         ZwAMhxkrV0oTCnGPizYLnCjimAuEtU4QPhMFy5lquTKUod1H7i16YRRtvGboI3VM9VPT
         aj7JTeBhw3oHjb3e/3dmRv98h2YU8Mlqex6FfUGMFRCOLoKxtWyFvVtKV7xVzO+HyDlj
         /n/ngBxN++bGUpzLQtCdn96ktXsHDdXtGMx8gc30dsbAfrtG4jzYvpV/TykcyviJ1MGO
         tqsRhtWTDwmiREzQalYaF3t6mH/OVb9yqw3WMOWzPafa3iiSspasH2wfqIKJg3imzAYA
         QNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=T1y56GoW2HWAJUEIxXPicr4xzLy1TOJONFMsghu6IrUPndyR5lTtR0op6WIu9Nv82M
         yHcEDrLa2WSrZ5nR2dtmWBARpPCYlFgeYwDynxOIQ8/E4wEFFMRoDYOyom/Ur2ihQHs1
         nPNfnVq2Dj47gvkiPokb2dLhub+I41M1eGDWtrdcibtD4XWpv0SdQa9k3ULbGTTOjVQ8
         C4d/8PQNZdZQkfZ6LMiVPv4h00ML7JI/DEbqdO5Ijg1GTGYmLz6yqVwQhdT+TcdzBhnY
         mKaS3x4tMBIIfoK2svJsNXk82zks+6g5MacxfDrSSCwvNXs9xn5yvef8/tfRaONZYOCq
         UoFw==
X-Gm-Message-State: AGi0PubaQasy9bwixaHtJK45dsbaasv+rglj8oBoBaEmzf6JBNblPh38
        S57pEJ74/gaEp+kMg/Klclq8yKclItjMlno=
X-Google-Smtp-Source: APiQypIdxbPq0Ip/4hH9CimyOIVNg8ufwRVZbjlJSM8QoQPnqNM+moQJCpFRUWi9Z4DN1ONvw4LiLg==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr27551882wrl.304.1587996668573;
        Mon, 27 Apr 2020 07:11:08 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:07 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v13 01/25] sysfs: export sysfs_remove_file_self()
Date:   Mon, 27 Apr 2020 16:09:56 +0200
Message-Id: <20200427141020.655-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
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

