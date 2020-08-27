Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF4C433E3
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40487207DF
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="K3zwFSdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgH0TtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:49:18 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54800 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgH0TtR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 15:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZuicSm34YejEE0eYQsfa57VxPlQPE4+0WlherfvxsyY=; b=K3zwFSdpi+sNp9EvmxJGyYRyID
        aRE8er6H0th6u20yWnTfugyhVL3pJE4qLP2eWR4ghFDv+/skpzPExV+pX6G+lfsMrAAKG+W0veK/f
        upGtLxTJhaKT4ejy83VQNezFF0hy2XNWfjH/uNAeDj/WRCQ3otFmCZKMC0WbfwsJftpYygdnGSO8r
        yNFWCMvLyvAPsczuozMnyHYqOrGR6HUwscOjrg7cPQYAhiILdyacflIwqbGvUyXbM9tvYZkef6b2D
        yx2/NnKZB2Q39lxwxjR7pkXm8yKqqmNT+KpLYOKCPGDIq7Bp5m+1ZS39GLy4gmo/FNfBnZgBuOhFB
        FWGkHsLw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNta-0000Cd-Tu; Thu, 27 Aug 2020 13:49:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kBNtZ-0001bt-NS; Thu, 27 Aug 2020 13:49:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 27 Aug 2020 13:49:02 -0600
Message-Id: <20200827194912.6135-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 01/11] common/fio: Remove state file in common helper
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of each individual test removing this file, just do it
in the common helper.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 common/fio     | 1 +
 tests/nvme/010 | 1 -
 tests/nvme/011 | 1 -
 tests/nvme/012 | 1 -
 tests/nvme/013 | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/common/fio b/common/fio
index 8bfad4238dda..94c65c107a14 100644
--- a/common/fio
+++ b/common/fio
@@ -181,6 +181,7 @@ _run_fio_rand_io() {
 _run_fio_verify_io() {
 	_run_fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio --bs=4k \
 		--iodepth=16 --verify=crc32c "$@"
+	rm -f local*verify*state
 }
 
 _fio_perf_report() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 2ed0f4871a30..25c79089e092 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -51,7 +51,6 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -f local*verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/011 b/tests/nvme/011
index 974b33745b99..ad360d095ffc 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -47,7 +47,6 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -f local-write-and-verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/012 b/tests/nvme/012
index 27981e903c58..dc86ee647729 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -61,7 +61,6 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index af5f3730a2fc..0ed52926363a 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -57,7 +57,6 @@ test() {
 	_remove_nvmet_subsystem "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
-- 
2.20.1

