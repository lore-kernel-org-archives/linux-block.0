Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12679C433EF
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiE3NIZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiE3NIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CE270908
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nxUj3N4YSuHgSZVRYMRdOH9qH55vosyimsHwk1o0a+M=; b=dBo7O+wSaMhK8v3mv5BNdnhpZI
        NyEDtNN8CPvedN+eo4adI5tAEh66Kw+xlWOdc+Ywz/7+PqswOnNpLUtmasKyG5OkYbKlcAwHNsqqX
        z/2TgiuXTu41baUu+9j+sOKoIrWFThtmRb4KDHiGl+4Ic7u2ks6Fwh0UYumLq5tPL17UbnBGk9ofY
        UE4QgeUrwoucHsOcI7r5wuD2XGwpWplR+5iASgzxlnaEe2lOQI7xjqwiIWcJOx3qpQFCybYH9o9aF
        NJfH2jdfRp0bm5ParOrP0CyLvYdLewG5OJXKABebrfJOgYHNsGG0BpBZE3nPIZD7BHdSpSBuTU5PB
        KCrIvH3w==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8A-006bnP-U2; Mon, 30 May 2022 13:08:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 3/9] common: fix _have_module_param_value to work with built-in drivers
Date:   Mon, 30 May 2022 15:08:05 +0200
Message-Id: <20220530130811.3006554-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't bother to call modprobe directly and just check the /sys/module/
directory.  Also switch to using descriptive variable names for the
paramters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index a93b227..ffd15b6 100644
--- a/common/rc
+++ b/common/rc
@@ -74,17 +74,22 @@ _have_module_param() {
 }
 
 _have_module_param_value() {
+	local modname="${1/-/_}"
+	local param="$2"
+	local expected_value="$3"
 	local value
 
-	modprobe "$1"
+	if ! have_driver $modname; then
+		return 1;
+	fi
 
-	if ! _have_module_param "$1" "$2"; then
+	if ! _have_module_param $modname $param; then
 		return 1
 	fi
 
-	value=$(cat "/sys/module/$1/parameters/$2")
-	if [[ "${value}" != "$3" ]]; then
-		SKIP_REASON="$1 module parameter $2 must be set to $3"
+	value=$(cat "/sys/module/$modname/parameters/$param")
+	if [[ "${value}" != "$expected_value" ]]; then
+		SKIP_REASON="$modname module parameter $param must be set to $expected_value"
 		return 1
 	fi
 
-- 
2.30.2

