Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41ABC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 08:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6372075E
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 08:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfCVIMl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbfCVIMl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 04:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC636C04FFF0;
        Fri, 22 Mar 2019 08:12:41 +0000 (UTC)
Received: from dhcp-12-135.nay.redhat.com (dhcp-12-135.nay.redhat.com [10.66.12.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 876FA19C59;
        Fri, 22 Mar 2019 08:12:40 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests] check: add zoned sysfs node checking in _test_dev_is_zoned
Date:   Fri, 22 Mar 2019 16:12:28 +0800
Message-Id: <20190322081228.21898-1-yi.zhang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 22 Mar 2019 08:12:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some kernel may not have zoned sysfs node, e.g. RHEL7, checking if
it exists first in _test_dev_is_zoned.

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index f0ca382..459104d 100755
--- a/check
+++ b/check
@@ -405,7 +405,7 @@ _call_test() {
 }
 
 _test_dev_is_zoned() {
-	if grep -qe "none" "${TEST_DEV_SYSFS}/queue/zoned" ; then
+	if [[ ! -f "${TEST_DEV_SYSFS}/queue/zoned" ]] || grep -qe "none" "${TEST_DEV_SYSFS}/queue/zoned" ; then
 		SKIP_REASON="${TEST_DEV} is not a zoned block device"
 		return 1
 	fi
-- 
2.17.1

