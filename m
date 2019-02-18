Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF60C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971192177E
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WAdSasFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfBRSxr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:53:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25291 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfBRSxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 13:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550516026; x=1582052026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zzsda46lRSnbKt94qmViPYuk0vCPyGG0MOM2+wPXt4o=;
  b=WAdSasFik4JQ1SfKbYRA3rotr6z5gMY8Mb/fJGl+s9Avnxx49Y3hicHl
   tYmJe9ilzSsSeRg/eAJHo8gE2895elY1GkouZcl3oozBRQkkdUNgQvhND
   ThVNys/aAjhJ+jjkjngYTXhLjNur67Cp5bKKLwnL47Bz/9xz+FSBuCAFC
   JgJPb/I4R07otp+VU/04pgTV/pu1AschIZIroRk0ctrVtLFS75MYhFXnE
   HN3Rpz85ZYqDpSj8ONvo2QLyoNpqeTsZRgAvpxbJTBaXIrNeTpbfYWnBy
   GyHBnnotkyWxnKtojxPHbxUWsxaPRgu6tn4M+2hSkTYqwfd3ZZn5ECNCw
   g==;
X-IronPort-AV: E=Sophos;i="5.58,385,1544457600"; 
   d="scan'208";a="103321456"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2019 02:53:46 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Feb 2019 10:32:11 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2019 10:53:46 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH BLKTESTS 2/3] nvme/016: fix output format
Date:   Mon, 18 Feb 2019 10:53:41 -0800
Message-Id: <1550516022-16374-3-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550516022-16374-1-git-send-email-chaitanya.kulkarni@wdc.com>
References: <1550516022-16374-1-git-send-email-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/016     |  5 ++++-
 tests/nvme/016.out | 11 -----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/tests/nvme/016 b/tests/nvme/016
index 966d5dc..bb48c37 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -34,7 +34,10 @@ test() {
 	port="$(_create_nvmet_port "loop")"
 	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
 
-	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	nvme discover -t loop | grep -q "${subsys_nqn}"
+	if [ $? -ne 0 ]; then
+		echo "nvme discover command failed"
+	fi
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/016.out b/tests/nvme/016.out
index 59bd293..fd244d5 100644
--- a/tests/nvme/016.out
+++ b/tests/nvme/016.out
@@ -1,13 +1,2 @@
 Running nvme/016
-
-Discovery Log Number of Records 1, Generation counter 1
-=====Discovery Log Entry 0======
-trtype:  loop
-adrfam:  pci
-subtype: nvme subsystem
-treq:    not specified
-portid:  X
-trsvcid: 
-subnqn:  blktests-subsystem-1
-traddr:  
 Test complete
-- 
1.8.3.1

