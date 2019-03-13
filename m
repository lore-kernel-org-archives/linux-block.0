Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0404AC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 07:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DA52171F
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 07:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfCMHFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:05:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfCMHFZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 03:05:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2878C067856;
        Wed, 13 Mar 2019 07:05:24 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.70.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9065F61992;
        Wed, 13 Mar 2019 07:05:23 +0000 (UTC)
From:   Xiao Liang <xiliang@redhat.com>
To:     linux-block@vger.kernel.org, osandov@fb.com
Cc:     xiliang@redhat.com
Subject: [PATCH blktests] Fix checking multiple modules error in _have_modules()
Date:   Wed, 13 Mar 2019 15:05:11 +0800
Message-Id: <20190313070511.8283-1-xiliang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 13 Mar 2019 07:05:24 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 0c354a2..71e27c3 100644
--- a/common/rc
+++ b/common/rc
@@ -33,7 +33,7 @@ _have_modules() {
 	local module
 
 	for module in "$@"; do
-		if ! modprobe -n -q "$1"; then
+		if ! modprobe -n -q "$module"; then
 			missing+=("$module")
 		fi
 	done
-- 
2.17.2

