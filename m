Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35296C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 02:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E84206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 02:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfDZCjr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfDZCjr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 22:39:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 439A9308623E;
        Fri, 26 Apr 2019 02:39:47 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D07C360BE5;
        Fri, 26 Apr 2019 02:39:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] block/028: check if T10 verification fails
Date:   Fri, 26 Apr 2019 10:39:37 +0800
Message-Id: <20190426023937.19584-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 26 Apr 2019 02:39:47 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When T10 verification fails, the error code of BLK_STS_PROTECTION
may not be propagated to user space, see mpage_end_io().

So seems the only reliable way for detecting the failure is to
check dmesg.

Cc: Martin K . Petersen <martin.petersen@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/028 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/block/028 b/tests/block/028
index 7bee691c0515..a0ab9ff208db 100755
--- a/tests/block/028
+++ b/tests/block/028
@@ -38,6 +38,14 @@ test() {
 			test_pi "$dix" "$dif"
 			echo "Test(dix:$dix dif:$dif) complete"
 		done
+		if dmesg | grep -q "guard tag error at sector"; then
+			echo "Fail"
+			break
+		fi
+		if dmesg | grep -q "ref tag error at location"; then
+			echo "Fail"
+			break
+		fi
 	done
 
 	rm -f "$FULL"
-- 
2.9.5

