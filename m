Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE497C0650F
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 23:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914472070D
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfHEXZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:25:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHEXZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 19:25:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so40415047pfq.0
        for <linux-block@vger.kernel.org>; Mon, 05 Aug 2019 16:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvFUBf4wBfd2sLnVnccckZVTV0U+FEVxEHBCis6K9cQ=;
        b=ZUL5Bm61z66V4lQtgCERBHC1p13vEgP3VpgcDCjjNnEGp8/2ph6eEuj/dbyD4UtadY
         thTFZ8or6UQTfdak/RTrhb1FwNAJeEY/Ku3WLDjY9y8Y8eC6N6yEHlqjmMQE3w4DSD+R
         vuE/96mBUA5f/ug61fVGrVWdWRI4NHjZHqaPY6spz8xSSWh5Iy/x+Z9gk5jzTSRYFBIi
         YxOQiQGr2GNIHm87pRVPJZDnTm8VcXgy5w/a6NP8t3Zn37986eyhsN/cEe26XY/nmYC/
         abocvfDOo5A3ozBB9U7hRvYeu73ljGN+Qp+p5caf1xVC15RDjiQOKrqUFr14sSu8rmTj
         JDIA==
X-Gm-Message-State: APjAAAW013o2/yuM+Q077sKfxzcRWvtts5GMvaTLSE7RMo4qx6Po0PUe
        JgqdNomp9nA/wDuRv7szJyU=
X-Google-Smtp-Source: APXvYqwGkUgEUOqRdT+nfBrgKxHiM3pKwUb1mqcrFTkUNRf0YMSSq7RGMLtVjz+MFbQpuc7NqFCZAA==
X-Received: by 2002:a17:90b:d8a:: with SMTP id bg10mr189248pjb.92.1565047519042;
        Mon, 05 Aug 2019 16:25:19 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a5sm17905209pjv.21.2019.08.05.16.25.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 16:25:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests] Make the NVMe tests more reliable
Date:   Mon,  5 Aug 2019 16:25:12 -0700
Message-Id: <20190805232512.50992-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When running blktests with kernel debugging enabled it can happen that
_find_nvme_loop_dev() returns before the NVMe block device has appeared
in sysfs. This patch avoids that the NVMe tests fail as follows:

+cat: /sys/block/nvme1n1/uuid: No such file or directory
+cat: /sys/block/nvme1n1/wwid: No such file or directory

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/nvme/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 348b4a3c2cbc..05dfc5915a13 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -169,8 +169,16 @@ _find_nvme_loop_dev() {
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
 		if [[ "$transport" == "loop" ]]; then
 			echo "$dev"
+			for ((i=0;i<10;i++)); do
+				[ -e /sys/block/$dev/uuid ] &&
+					[ -e /sys/block/$dev/wwid ] &&
+					return 0
+				sleep .1
+			done
+			return 1
 		fi
 	done
+	return 1
 }
 
 _filter_discovery() {
-- 
2.22.0.770.g0f2c4a37fd-goog

