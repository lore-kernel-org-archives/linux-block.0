Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717D7C07548
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B50206E7
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgICV06 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:26:58 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42264 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICV06 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:26:58 -0400
Received: by mail-wr1-f51.google.com with SMTP id c18so4676916wrm.9
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 14:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5f/WhCUB3SYptcds9DMSFGf+leIG0AOF4/byaQGTcA=;
        b=Kn5I/m9/Agu9H9AkrZNVZyhkuULWQKAyDsJbBphbzN8rDqt6N+H6Ihg2RQkyzaSNvz
         yPO9wvoKgitAu+X3JCJCbj2xZBeNb1hWF8K2Jn1UxhnRyl5Qv4gmbzuEw5a0fTO0hC+e
         HVMrgUd8AxRG9hJbAdVM+szJBYc6lY63dPNoEdHSKdt35uY9uLnT9Mpqee/5UqFBTrja
         FJp9sKFFqof4yiPz0ED4LSNhCFQIVUbROSU+VWoddPVGEs7grfFrrhxvnkU3lUVmF9yn
         p+9k9b645DfSoOD9wWcTJArK05uXvFW0s56hYbr3R3+iDXjJEcU2c35g9qaOmv0ApP0u
         fDYQ==
X-Gm-Message-State: AOAM531Q2waizS1WW3u7I0QkTtW6gDbhdzrHXDD5WjGTRaguVwNIwR6n
        I2k2iWgTkugDRdi0sHilEPjFnxbNJT79Aw==
X-Google-Smtp-Source: ABdhPJzv4njTtIGWuTyfBWaEa0Cwkmm69k1pCPYv1md415sNYtbKw5ENQbF5xTdJ9lGw+R8wVojZ5w==
X-Received: by 2002:adf:f843:: with SMTP id d3mr4782216wrq.226.1599168416288;
        Thu, 03 Sep 2020 14:26:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:26:55 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 5/7] nvme: support nvme-tcp when runinng tests
Date:   Thu,  3 Sep 2020 14:26:32 -0700
Message-Id: <20200903212634.503227-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

run with: nvme_trtype=tcp ./check nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index fbd5b66c25d5..2b267f1d6ae6 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1

