Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4D9C77B7C
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 07:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjEJHCV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 May 2023 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjEJHCQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 May 2023 03:02:16 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB6D6188
        for <linux-block@vger.kernel.org>; Wed, 10 May 2023 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1683702133; i=@fujitsu.com;
        bh=4+FYQPdXScK7j28fVEcE22Za30BCLtxMt1hs5/z3K8c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=OFwtreaFOW+BUSTrOTzfNZ3jAVKlI84liM+XlZxxqT9CmnH75th5gigYq93iHTSbG
         1FVfQkr4/TMk6mqNTt9mmbo4az/Zs+5KsnRsLcALDLzh6rlpLNQPJQB4cLUL4sqf4X
         AfvcMdep5ggw0wqxKVpXI1yKinGAuN++Zy14ajzj1YopaK7/mAE+1NFwWXs4vBbH+x
         nhkmcBP6VcfTIZRltrSR0S98ppLZF4vbZ/+PaWvEU6cYC8ru/btmbRua/GOxEkgsD7
         g1Cr/SG45cSQPBMgPdakYVPRk+cPLoSABWmrKb9N6S203XamjhgnrtYvYEpzxWtRgu
         LvaAutfXsGRww==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRWlGSWpSXmKPExsViZ8ORpFvqGJ1
  i8KGN0WLvLW2LfbM8HZg8Pm+S82g/0M0UwBTFmpmXlF+RwJpxYGMTU8EsnoqLV1+wNjBu5upi
  5OIQEtjIKLHh5DHWLkZOIGclo8Te7ZogNpuAmsTO6S9Zuhg5OEQEbCW+fyoHMZkFVCQW3nUDM
  YUFfCQmLQRrZBFQldjcN4URxOYVsJB48XU2WFxCQF5i/8GzzBBxQYmTM5+wgNjMQPHmrbOZIW
  rUJK6e28Q8gZFnFpKyWUjKFjAyrWI0K04tKkst0jW00EsqykzPKMlNzMzRS6zSTdRLLdUtTy0
  u0TXUSywv1kstLtYrrsxNzknRy0st2cQIDKWUYsb0HYwNu/7qHWKU5GBSEuW1F4lOEeJLyk+p
  zEgszogvKs1JLT7EKMPBoSTBq2UPlBMsSk1PrUjLzAGGNUxagoNHSYS3SAMozVtckJhbnJkOk
  TrFqMuxtuHAXmYhlrz8vFQpcd7pDkBFAiBFGaV5cCNgMXaJUVZKmJeRgYFBiKcgtSg3swRV/h
  WjOAejkjAvE8gUnsy8ErhNr4COYAI6wv9yOMgRJYkIKakGpusZh902bfxzISXw2BSDs0qC+5L
  NW6flqHYfTHyfwzpv7alZn4O+rLScEnZsw4yICSGSOzf19uc93TD1auTENeob/SfFa8zyrzbm
  f9FjuLj1gMX/e3tC4yPFni9c5jo9REm85Gb0ik3Lv/HkXGd6F9vL7qskt4zNrShQa8ekUr6l6
  3/cdH2cFs5z8g3/cjb+S0uvFP7cbL1tdm7jKQs9Q1Mba+5Tia0Sys6SjKfVb7Iev5aUw5e87s
  kCE4lWtud/HqQtfaLY2/MhY891qcW+qbnqNxb3WB/yTfq7dKnr0UU7uTWS1KTXyaTsL63/7vE
  vSuhI1MFDy4o+6m+OkFW5f9zP5xD73iqrOE6JldmOtUosxRmJhlrMRcWJAC59wiIsAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1683702132!42241!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25397 invoked from network); 10 May 2023 07:02:13 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 May 2023 07:02:13 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 7F9531B7;
        Wed, 10 May 2023 08:02:12 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.54])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 86C9F7B;
        Wed, 10 May 2023 08:02:11 +0100 (BST)
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc:     Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH blktests] common: Replace _have_module() with _have_driver()
Date:   Wed, 10 May 2023 15:02:07 +0800
Message-Id: <20230510070207.1501-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvmeof-mp and srp test groups can be executed with built-in
scsi_dh_alua, scsi_dh_emc and scsi_dh_rdac drivers.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/nvmeof-mp/rc | 7 ++++---
 tests/srp/rc       | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 4f4d518..0771497 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -26,6 +26,10 @@ group_requires() {
 
 	_have_configfs || return
 
+	_have_driver scsi_dh_alua
+	_have_driver scsi_dh_emc
+	_have_driver scsi_dh_rdac
+
 	_have_module dm_multipath
 	_have_module dm_queue_length
 	_have_module dm_service_time
@@ -36,9 +40,6 @@ group_requires() {
 	_have_module nvme-rdma
 	_have_module nvmet-rdma
 	_have_module rdma_rxe
-	_have_module scsi_dh_alua
-	_have_module scsi_dh_emc
-	_have_module scsi_dh_rdac
 
 	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma fio; do
 		_have_program "$p" || return
diff --git a/tests/srp/rc b/tests/srp/rc
index fb3a113..252fd0c 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -37,6 +37,9 @@ group_requires() {
 	fi
 	_have_driver sd_mod
 	_have_driver sg
+	_have_driver scsi_dh_alua
+	_have_driver scsi_dh_emc
+	_have_driver scsi_dh_rdac
 
 	_have_module dm_multipath
 	_have_module dm_queue_length
@@ -50,9 +53,6 @@ group_requires() {
 	_have_module rdma_cm
 	_have_module rdma_rxe
 	_have_module scsi_debug
-	_have_module scsi_dh_alua
-	_have_module scsi_dh_emc
-	_have_module scsi_dh_rdac
 	_have_module target_core_iblock
 	_have_module target_core_mod
 
-- 
2.34.1

