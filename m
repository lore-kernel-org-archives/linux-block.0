Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D65C28D13
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 00:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiHWANd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiHWAMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 20:12:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEDD5755F
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661213517; x=1692749517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jTZXUzzS2AomIcHu5Uz4hCAu6Gt+l0cufOy8BrFzpk8=;
  b=bdpEmhpM4ev2F6jAItAv+1anWY4DZpMSOlW+Z5zXsZZo5UYdRP7dzyW/
   wUrolzkydwU8qAqIC1XKa+mAdMjUp6ATpUGg+FEq9nuCnZx2M3tdfSFBr
   KpJe20w5n+5qEsRHEzW5sm3ZZ5yEY7XI/xxkrbxCMgAjjPncomiUX0AW7
   q1Sm47/4tAPrv9TjCcgeXQu9bnCzzCmG+8KrKH5BogbfxTodfTxZAYJeA
   ehWP6hYMLP9te9my3TP/+aVVvyveLHYCiemolQtiZ8UJfTwy62DSrVbP+
   1Dr88VNA0kufRPVixSVYb9n42jDr4FO6BTLnk96+wLokoG2MK1CekvsQG
   A==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="313645295"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2022 08:11:56 +0800
IronPort-SDR: IjkvYGWUEIoQd1U+TxbXAxg3Br+5yPT7zq95FnhWUeo6dtCMVQ+JMxYQf0RJ5KKXUxuGiqaN7U
 /ICHLi7FflDPvynlJbe7dyXmXXIGSGiFjG6YWNiZIskXpaoEo8iLN2kl1bVSaeyhtl8R72vwOA
 d/8ql92Uy52HMFazWP5qVaunbvP2nJ9Jd2MAt3Yrry+mJfMSobtImoVHx0aK2S/cqcZ9tet+mL
 B6eDV4hDWydfeo0e+d0W9kK6DeJxhkLnqUNQQKOXou+89h76IdmEzZ/2Lx2liRN0Ol9g5omRtE
 WFNRaufMLTEloZoYYEEAYDpz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 16:32:36 -0700
IronPort-SDR: ++/SEFyC9olSlb2UA5TRuuivaCd7UXuWgiCb5fdmU53yqdef0NSBUnBKhah0x0Eg8pTEUBe2/g
 fXJDzkjH9VtTFfijKjnSzCSF3hZTQGhmqFhOoXlZdMiBoi6+EAOdd81uGu1Z6j8iphu2giglj6
 f+kB6ejHNpAFYsvyOIhk0gy+QrEwqrO68JzA5aR52TE2ghIQmv+qWLjo4vSPIfVNKPKn+dIEJ+
 YpbEsXSdwDKhrvxkXDh/iXN1LV7JWsXZ1m3RriwnyH72BxYgJ4qiMA6ZHFVsncSKr5R6ersPvx
 jGw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2022 17:11:56 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 1/6] common/rc: avoid module load in _have_driver()
Date:   Tue, 23 Aug 2022 09:11:48 +0900
Message-Id: <20220823001154.114624-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
References: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 common/rc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 01df6fa..5b34c60 100644
--- a/common/rc
+++ b/common/rc
@@ -30,9 +30,10 @@ _have_root() {
 
 _have_driver()
 {
-	local modname="${1/-/_}"
+	local modname="${1//-/_}"
 
-	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; then
+	if [ ! -d "/sys/module/${modname}" ] &&
+		   ! modprobe -qn "${modname}"; then
 		SKIP_REASONS+=("driver ${modname} is not available")
 		return 1
 	fi
-- 
2.37.1

