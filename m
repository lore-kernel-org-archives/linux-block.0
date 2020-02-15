Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643BC35242
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04D32073A
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kHiPXtJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBOBih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:38:37 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15619 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBOBih (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 20:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581730718; x=1613266718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3wcwlsDYokBPz5VBPG3aTzLh2M8vjJRSpWvvi5K6ic=;
  b=kHiPXtJjAxN+M8bfi1+N7YVABTqOxEqy0/kulrmnkAXnNvtA/5wLtC9c
   OY8qtxo97OvWrxawQjzSZm2iZhIltmXpB7UkJLjKqxlTxtkFW3SU3RUsR
   a12eNzQgpy6vzIC1utUTIr2AkPVMkPI1q6tA/fBkLJSHnlK+KYb2AHMxr
   kbZhOiTVgjzKcUM9/LGLR5/X0jsmRTl1A6aQsZi2EYIrhZiaNmHecTEPq
   1e9rQvVuz3l6fppnMAOOiqoapxKQhzXevBXGy/Wr9WrUpbVmH3DwyVfEX
   qUQM8ofUxMqYpHTo4cBbiyNaDdC0D4PiycWhgwwKI1URrgqzCD0KQnRI3
   g==;
IronPort-SDR: iqQtzDraecxtIKrl+nmmmiF81l0gSNb9gnfSCsECzw9laUVWY1eTSUOCvskiuwjBB87kBUFl8W
 BPK4CCxWc+G+eouJrOiK+ZAM1Hen+ylNcNeMnwaxy0cn1G0w1RojJAo6nt+o58G2Tw7NIHmwta
 5dy9cSo6zqJjCXV9gYVp3cv2s9nzTenJmofdp/kplno5pFQoMMjRvPwn09regWjl6XfEDJbNYL
 YkgRHcf/8bBWsG2YQLC8W+A8Rr8cYsBySZaVDL+PQOX8yI8C4OGxBgDBb3pkGXw0a3RC+hqiDy
 l2E=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; 
   d="scan'208";a="130431806"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:38:38 +0800
IronPort-SDR: cQwpCVrcmp7XAQMaMJS3pT1Op4CImx5djBOY/Z8vHmUoguSLWGgQfmIVNaCJfN/P9i9cPMoN0Y
 V3NS+XgvxjyMiToLF2eTae7/g8mb5KEfKmTpk7kjlO2rZ3eSFezTzjvHkHMHnpmudgkq24bYel
 thx42N/f5jZOIvLtpFVzU/NL5wmRRJcBYQnNHu72DYa/qmAknAGeDa/RfJuReLIUMB9S6SLqPv
 WoWSJgEkr4zcM+CZYoULxfJ2XqKQiSyKcieazmeh5rxz6dU0PtDtgDZpBUn9PFqOWvQX8NeNpU
 V2b5jUjWHB8GdoA7LZZiPMQ1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 17:31:21 -0800
IronPort-SDR: ioUc+pR+lGn0rilxm0izv8W1ipguQiGrJp66P2+lZCghs3D3rxw3yHJdW9FjvLKSvrJQfRTJH3
 W/wj6cMOVsOB/AK8bzk/tXR6LUxxdJpFLV2g7C55Y9jX45SCpZs/PY0+5p49RgJjMhDPXnq1j4
 guYAAmWKWb11ScUP7Rl2tLAlZ0rG3lFK0LOxNV7zjbu2nDZQ28Ve4Rnp+GOBICGvVh28azFxnY
 z/pMqP0W9WKVSZjYgryEPeBW6EQeswyJPT0+5rEr0yLdTvzN+p5mLIhtCdvmEifQDf6YYQGiWS
 l5E=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:38:36 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH blktests V2 1/3] nvme: allow target to set cntlid min/max & model
Date:   Fri, 14 Feb 2020 17:38:29 -0800
Message-Id: <20200215013831.6715-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch updates helper function create_nvmet_subsystem() to handle
newly introduced model, cntlid_min and cntlid_max attributes.
Also, this adds SKIP reason when attributes are not found in the
configfs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/rc | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 40f0413..e4b57cb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -121,11 +121,36 @@ _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid=$3
+	local cntlid_min=$4
+	local cntlid_max=$5
+	local model=$6
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
+
+	if [ $# -eq 5 ]; then
+		if [ -f "${cfs_path}"/attr_cntlid_min ]; then
+			echo "${cntlid_min}" > "${cfs_path}"/attr_cntlid_min
+			echo "${cntlid_max}" > "${cfs_path}"/attr_cntlid_max
+		else
+			SKIP_REASON="attr_cntlid_[min|max] not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
+	fi
+	if [ $# -eq 6 ]; then
+		if [ -f "${cfs_path}"/attr_model ]; then
+			echo "${model}" > "${cfs_path}"/attr_model
+		else
+			SKIP_REASON="attr_model not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
+	fi
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+
+	return 0
 }
 
 _remove_nvmet_ns() {
-- 
2.22.1

