Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4227C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245359AbiFAGsu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiFAGst (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:48:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFE88FFBE
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QVPuNgTa2ZGrVy2RToahyPDiQjKK8qsqdpzHQJJR/0g=; b=DSDaIt2UNAAST69Gx11cacL4ka
        f4UyynBhTjHDakZybdZoUxv3i+YZEg+dPA3vMMgJwpQX7FwG3H2ZUiL0SYGtqtYcGk+Zxx3/JGyYV
        D1VPQ5gBPWuJyR9HcT5bg4FTAHbNHePAeN4+9v0nStHTseiC3VAtDHhDzQ9sUoM35ecaUpDE3Xm7P
        AYfaX2Cseo6gKLATvtACvs1qK9fd6GFtooK1wbBpf8YYJKxdAPMuVkLKmkjdmFtqlt6G97aZUcSAW
        i6e7y8WjIAIPuAk3sbyEtCapXU7KABb+k+AoICTB/LPL6LubAiNN8NZ3bi2J5JXvP9R0qC0dnpiNX
        WSwg2MFw==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwI9v-00EEUZ-Ne; Wed, 01 Jun 2022 06:48:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 3/7] common: fix _have_module_param_value to work with built-in drivers
Date:   Wed,  1 Jun 2022 08:48:33 +0200
Message-Id: <20220601064837.3473709-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601064837.3473709-1-hch@lst.de>
References: <20220601064837.3473709-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't bother to call modprobe directly and just check the /sys/module/
directory.  Also switch to using descriptive variable names for the
parameters.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index 2d0fd88..c4df814 100644
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
+	if ! _have_driver "$modname"; then
+		return 1;
+	fi
 
-	if ! _have_module_param "$1" "$2"; then
+	if ! _have_module_param "$modname" "$param"; then
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

