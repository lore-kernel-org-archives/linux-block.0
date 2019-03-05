Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B91C4360F
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 03:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B258213A2
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 03:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfCEDdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:33:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfCEDdc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Mar 2019 22:33:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9617B4E908;
        Tue,  5 Mar 2019 03:33:32 +0000 (UTC)
Received: from dhcp-12-135.nay.redhat.com (dhcp-12-135.nay.redhat.com [10.66.12.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 120415DD63;
        Tue,  5 Mar 2019 03:33:30 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests] Fix the failure case which will exit with 0
Date:   Tue,  5 Mar 2019 11:33:19 +0800
Message-Id: <20190305033319.6825-1-yi.zhang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 05 Mar 2019 03:33:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The return value of a failing test was masked by the zoned test check.
Make sure to return either the original or zoned run failed value.

Fixes: e840e15 ("config: Introduce RUN_ZONED_TESTS variable and
CAN_BE_ZONED flag")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check b/check
index 819d8f3..c65270e 100755
--- a/check
+++ b/check
@@ -431,11 +431,14 @@ _run_test() {
 
 		RESULTS_DIR="$OUTPUT/nodev"
 		_call_test test
+		local ret=$?
 		if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
 			RESULTS_DIR="$OUTPUT/nodev_zoned"
 			RUN_FOR_ZONED=1
 			_call_test test
+			ret=$(( ret || $? ))
 		fi
+		return $ret
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
 			declare -fF fallback_device >/dev/null; then
-- 
2.17.1

