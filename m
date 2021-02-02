Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656DC433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0F764E9A
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhBBFip (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:45 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61659 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhBBFin (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244323; x=1643780323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EdSLA1bpRX99HWzdwxlVGl5OPKodEri8svg7+742Pqc=;
  b=hOaFH1U89xpMHJ30ZWJQrNHluLkt0Yg0ukumwmpZRD4UJh+qIX+cbFBs
   S1WpwDX6aj2R68jbAHFpaoka9eluwUqYiTS+OhzUJy+Ug3CO1lMwXQOMa
   r3o0ZF+FdTz3SntLZ4CRDWK5HG8Elt1Un2pn/upDVnu1S+b+o7mc3E1mn
   r9aa5FBoQYqne2aFta+8hmzS59GbJxfh0+Tu94gwr6lyCD8OOU3MA2t3P
   83cDlKqEZ2G4aN+canzih8f/7+nSjVNciOAy7XwdFS+Ey70zEblUBFGzU
   +sNzaJBiG30lMEd7z1JlIqSR6heAdpBE/vt7H3fSSLVm8j6CZMVdRC/N9
   A==;
IronPort-SDR: 94RSs+sAjwJw3/weNuvI8n5uWOZNNIFk/Jod3Sbk68c58KaAmlQJa1P49zVLxqbuXuPAFvLmAG
 RX0EpbcC6tFBQ2eA20psyppnuDz3ikCt/+WVLxsu3NrFyQ1gqZV6zg0WGCfAgYOM/HVU6N2m1+
 dCeey19fM+CpEpUPe5Jc81/2t9anvVsspiKclAmRw0tGC6UrZfaJonhpHkcUN013yedmfgogAf
 lDp4v2EWN1lusL9hmi2JwUPLD2tHTLgg+igzN8HIuXoCS+LvoDQNcnEfFj6xZwsAN4yqGfSZx4
 7ps=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885251"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:37:37 +0800
IronPort-SDR: mehnlaBIjNK3pAZChDJK3+C+PsxOEdWexZlbaFcn4SqkmrYCOxWo5t5SKxUzRGP9jibUtbHGNm
 E1t8RVJmZe6685Ady8Rr9Yg58ULh2FpZd+86SqstikspP8OspAdWwljK/JJOXlbdWp7kA+7qz/
 im8bnxyaknHKmZqdW7ASOhC00L2EqdWrzG3bgUyXmmxXpPMHVRWute/C/1qBP6Ayx7cQh8oSEN
 DSaGUQo0L3UWiIeY/6UyQFGGVnWyN0w3Crl0WfLhjIyjJxTCRhJOjWqSCPMz99JfrIfXAty90W
 U29J5S9kpUtc/tOqvru7JAbI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:19:47 -0800
IronPort-SDR: 4pg1ogMUobThUMrFRUuuaYEHKs34e2ADjWSNlALGgWIqesWvtLHvKfUWIIp95kKoOsFqg134ST
 wBuWQlHYOwMit9EQdJKdEHVaGZE7A4WTazQykuPN1V4xsGQd2x3bLHwuGbumJhW3WNcLZpDzmZ
 raRPQJGEU9vuUkt6/7fWiY/BmUTnNMGllLjGhYBnSOlbuiEYA0k/H4rPPgLQWYTa3X8ph+eNk3
 qIgHrMyUr9lzvKTEPxIaC2Wkqf40rq6FRT4ifaHdmijz9ra/m7FwFq6rzr8LEmjG1PhqH+NhIk
 4Tc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:37:38 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 13/20] loop: remove memset in info64 to compat
Date:   Mon,  1 Feb 2021 21:35:45 -0800
Message-Id: <20210202053552.4844-14-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Initialize the local variable info to zero at the time of declataion.
this also remove the need for the memset().

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc074ad00eaf..667a3945bf39 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1759,9 +1759,8 @@ static noinline int
 loop_info64_to_compat(const struct loop_info64 *info64,
 		      struct compat_loop_info __user *arg)
 {
-	struct compat_loop_info info;
+	struct compat_loop_info info = { };
 
-	memset(&info, 0, sizeof(info));
 	info.lo_number = info64->lo_number;
 	info.lo_device = info64->lo_device;
 	info.lo_inode = info64->lo_inode;
-- 
2.22.1

