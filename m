Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A3C433ED
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 09:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A3761445
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 09:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhD2J2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhD2J2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 05:28:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2CC06138B
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 02:27:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i3so52023497edt.1
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qs63rShlrmxt6xKGWJl7mKqA4GE5PBn00xmYSg5yWvk=;
        b=X89dcG/Lr7nmnE1JFhs7bWqAi8qokbiHir15p5Dt5XBdDx2ixSXHF0QxMIAqylQkmJ
         2LJbP/cJpKK3QHxJxU0G5J20MT3uJtWmGD4XYdAxONU2FDN2HX8BGobmSGUXDo3Kioc8
         XYbfBp9mpdKWM/t8ZchCR9eMJyid48A+fFjXbCEUB/L8Vbi/+xlFbcxGZbaZdivtPaMb
         nZwkby+HWuKdNkLmM5kYufv8MRpLz8082Ea//WEXXFT5+P1Jt4ixErXxxil53Dm4II9T
         nLJ2JcqZsgMP2ewvNkTPcMmINwAU5S8e7Zm77RhYfcRIFZ667d34lp1Vn9M13Jr57FGZ
         sL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qs63rShlrmxt6xKGWJl7mKqA4GE5PBn00xmYSg5yWvk=;
        b=Ry9KvHJSo727Xf8v6GmkzP8mI2+6kssTnWy/XX17fgV4ls1nQ220Xsf3YxFJED628z
         n5CXPAJYIIJM2G/Bpht/OG88Tr7B6Xc/NOku015XDbyi1jrXpqTX/zI0yTvUAKEAT9Qh
         s/KibVZAxrrcDVQ1Jn03b5yN/04w08doZCJkNSEf7UElm1NMn9utB7JzVQ2bujELbTIa
         xkxx/BPWgdq8pL2FNPJGZD/BFZYlNqxxnyjDIcEwE4HmwecyRrvxa5YKy2wNyJgpQJ+y
         kJCbda9aQx6bXAMNUzhiEVhai4lzLsmOLIH8WXuwgIbJGb+f2GW8BGrWEjigZkaQF5TL
         XxOw==
X-Gm-Message-State: AOAM533tkykjYE8uScj4bLNpSy1r+MAsjLKVA099DQ6CxMMOSMy5WF93
        6iYpC/RX2LfpLhcN7mTyKe3cUqUgq1tygw==
X-Google-Smtp-Source: ABdhPJy6aI0R+JFxUxzWD40BVb7FLcOSjkmlKmmDZehfuBMtVWXe5OG7N5z9TzGW3j7mxHAmOyyZIw==
X-Received: by 2002:a05:6402:1255:: with SMTP id l21mr16581980edw.362.1619688471715;
        Thu, 29 Apr 2021 02:27:51 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5ae8b9.dynamic.kabel-deutschland.de. [95.90.232.185])
        by smtp.googlemail.com with ESMTPSA id cn10sm1935219edb.28.2021.04.29.02.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:27:51 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        jgg@nvidia.com, leonro@nvidia.com, Gioh Kim <gi-oh.kim@ionos.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] RDMA/rtrs: fix uninitialized symbol 'cnt'
Date:   Thu, 29 Apr 2021 11:27:41 +0200
Message-Id: <20210429092741.266533-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rtrs_clt_rdma_cq_direct returns an ninitialized value in cnt
if there is no session. This patch makes rtrs_clt_rdma_cq_direct
returns a negative value for block layer not to try again.

Fixes: 2958a995edc94 ("block/rnbd-clt: Support polling mode for IO latency optimization")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b74a872387c4..934a2ff18e7f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2896,7 +2896,8 @@ EXPORT_SYMBOL(rtrs_clt_request);
 
 int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
 {
-	int cnt;
+	/* If no path, return -1 for block layer not to try again */
+	int cnt = -1;
 	struct rtrs_con *con;
 	struct rtrs_clt_sess *sess;
 	struct path_it it;
-- 
2.25.1

