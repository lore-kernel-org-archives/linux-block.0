Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A82C04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 08:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiG0Iw5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiG0Iwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 04:52:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE845F7F
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 01:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658911974; x=1690447974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jE1UUO61ZO/O5Zl3qaKzai51tWR1Wq2s6F5R7t0tbAc=;
  b=o+j074DENN7YqoTG7OYphYrghBV4jn/ptmmVNE8tpePuz983h2dBxX/t
   eqZmR6/CL8ryad7eEBV6GII5MvCV8nvjFNo6v6quDXLDgjEgH/enjt3tQ
   01hf/xMbUgnDL5TypI4okM2jRbXv6FXZc03x/nhEjLPs6Mto8w3PgvKCN
   +m8Uh4DSjdGN0P2XmaMiDcOWD/xyh0I0o2dDNwTUIJo8CDMa1WLgAshtq
   QygPQkyercOg6dDnAxdMCEAf0CW9QGsMvLPsoNAglJfEHtPDal3HEjbqf
   IAV7DGPP/+NINGcJpzzPrdwHgi3+Atnn+HnF90bNygdUizMa98/UhbT7V
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="205584974"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 16:52:53 +0800
IronPort-SDR: h+evnnAQTaQogwWSRo2aKl9vSj9ZFLzGxgrXAI6guSrt+haOUDwGxZWZ4O/EuM378ydaKj9Ehd
 KzVCrt8In64FsP18G7Ux41VFyrmyELjt6HlQpIDRo6O60d8fn6EpKn85jpO18JTCELnqlP3JKn
 vAQOa3uIl8hCjv1lq+fBpB2xTjCCVKmtNc8pOmZllKwaUsv1XrRr42bM85ao2Tw6HKCnPRCFmV
 VZ0itMEcBensHCte1biJdClavipBdq36QM3oaHrwOxxspACGEWEc4pgy1HshJeukNNm5hxOaVd
 rncRD8xfYo66HBUmtqonzhxQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 01:14:06 -0700
IronPort-SDR: a7TixAOU2A0pDnmX05byJ3t34g/gAafskW341Xc3VMtCCcxhmtVnH0KpJngaLfs1BZridxeAa2
 8H66wOyYYPyFeOVZXd4pHOTDwpTNM0GrjvqJ8E9jkt6vCjq2oLuKBN3cleaO0tLySQfXkzVXjd
 an09m5fWOEAhCixnA9HALjHJsKzNPEI4ZHPZkm4hu3w757fwOpk2HkjzROKKp2t/oCJcZ8YB4T
 grozRWKJVKM7cqD2nM/DyZxBMmpUI6BUszwJp5U7hWY9uIK2RKryxH8FbPM8rdoaFmV089jblx
 TPc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jul 2022 01:52:54 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/6] common/rc: avoid module load in _have_driver()
Date:   Wed, 27 Jul 2022 17:52:46 +0900
Message-Id: <20220727085251.1474340-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper function _have_driver() checks availability of the specified
driver, or module, regardless whether it is loadable or not. When the
driver is loadable, it loads the module for checking, but does not
unload it. This makes following test cases fail.

Such failure happens when nvmeof-mp test group is executed after nvme
test group with tcp transport. _have_driver() for tcp transport loads
nvmet and nvmet-tcp modules. nvmeof-mp test group tries to unload the
nvmet module but it fails because of dependency to the nvmet-tcp module.

To avoid the failure, do not load module in _have_driver() using -n
dry run option of the modprobe command. While at it, fix a minor problem
of modname '-' replacement. Currently, only the first '-' in modname is
replaced with '_'. Replace all '-'s.

Fixes: e9645877fbf0 ("common: add a helper if a driver is available")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 01df6fa..8150fee 100644
--- a/common/rc
+++ b/common/rc
@@ -30,9 +30,10 @@ _have_root() {
 
 _have_driver()
 {
-	local modname="${1/-/_}"
+	local modname="${1//-/_}"
 
-	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; then
+	if [[ ! -d "/sys/module/${modname}" ]] &&
+		   ! modprobe -qn "${modname}"; then
 		SKIP_REASONS+=("driver ${modname} is not available")
 		return 1
 	fi
-- 
2.36.1

