Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD5BC77B7A
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 04:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjEZE6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 00:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjEZE6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 00:58:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276C183
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077126; x=1716613126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKtGWlSuxI8HIrrsVoZWoKYq9tElwtCzY8UQvSZ/iSc=;
  b=Fuc4JC2kI7nnIyo0yIhd+9Mef0lc/i3Mm6FkbaB9foAWsWtQh1J+ZsLU
   g77Ai+yvTUfYn8ZSyuN0GnoaAxRLruxhBnueJX56Ktmbw3g859jRGxuKe
   Ht8wmvIzRInq1/sCoDfQvnsfjQC4NAId9gSJxPaO81DhFGFEZTt955XdU
   NqlE11hryuI232hSXRoL/lVnCfQlCBfP+wAVJ7SVa4+9hnsdheENBk0nU
   iwZmALNN9FKnJaWMRXrcj+S08ol3cWnw6XgSS2H+zQm2mRcZGwPpBY5eh
   DcwiJPudGqiIlndItYkHKNBhPrK8hQFZP4X3EZiXRel9yU/RMcap/DzsT
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231616519"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:46 +0800
IronPort-SDR: JAwFzq0X61sHQ2A9eH6Acn83+nmplU4m78P10n7rdCKd/XUsC6MkJ6BY3N9xSNV0/pfiy1O5MO
 YNH60FUtvtPbtXFu7TMiEKQtD4djVOdw4EU4on5kU56kASlmr/btbB4hutp1flmx+qQ2IMNr8e
 D4jvbS8/x73C4abFOP/pqFzkmks/HYfK1U/+2kmVBqr7zZ/vQ4sh0fajdTUYJu/eBdO/F4aa71
 mFb8pYDUEDPe8oyjQHYk8O22pr40NZ6JggR4oloTI9WsYSfKaU6ELis01SxaiauW+aXdGNEEUZ
 s9o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:03 -0700
IronPort-SDR: tEwFH3on0LDF0UbeTZ1YEde3lVMA0l34fAG8I10tuKv7VO0ruFeIp+PFA7Cm3NL2Sz+aUcSl7e
 7ZIq+M5g4YWB/gnTsJjVvfS4zJr6ADc/67ADB6Pp5/lHvDp8+zK4TfwDRSDQDOQCafF2Vk5grA
 SNuUj3fkLgI9NGsJGPwioyH2zQf18jBdUazrZpCye84moLUj7X6ue7tZW7FQu44mdo3jo+/8z6
 w9qLIjB73GSdaDat5inTGfnLIcfGyx473Bd0fjwOHCN+YhuRBIGZpKzjUTOAPy2psQ12sH7vEY
 2pw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:45 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] block/011: skip when mounted block devices are affected
Date:   Fri, 26 May 2023 13:58:42 +0900
Message-Id: <20230526045843.168739-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
References: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case disables PCI device of the test target block device. When
the PCI device has other block devices mounted, those block devices are
disabled also. If the mounted device is the system disk, the test screws
up the system. To avoid such dangerous operation, check if the target
PCI device has mounted block devices. In that case, skip the test.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/011 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/block/011 b/tests/block/011
index 4f331b4..0699936 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -10,12 +10,29 @@ DESCRIPTION="disable PCI device while doing I/O"
 TIMED=1
 CAN_BE_ZONED=1
 
+pci_dev_mounted() {
+	local d dev p pdev
+
+	pdev="$(_get_pci_dev_from_blkdev)"
+	for d in /sys/block/*; do
+		dev=${d##*/}
+		p=$(_get_pci_from_dev_sysfs "$d")
+		[[ $p != "$pdev" ]] && continue
+		grep -qe "/dev/$dev" /proc/mounts && return 0
+	done
+	return 1
+}
+
 requires() {
 	_have_fio && _have_program setpci
 }
 
 device_requires() {
 	_require_test_dev_is_pci
+	if pci_dev_mounted; then
+		SKIP_REASONS+=("mounted block device exists on test target PCI device")
+		return 1
+	fi
 }
 
 test_device() {
-- 
2.40.1

