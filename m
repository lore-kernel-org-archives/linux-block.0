Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3862EC28D13
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 00:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiHWANr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiHWANA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 20:13:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53825757B
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661213526; x=1692749526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rT85oT/MXoAQesbzieTU6OjeJzP2KtJtZIMvb45VVa4=;
  b=AOyIFZfEGiHfwpDBUN/R60OtVjuYriPyQLyvgIMdpPS8JFqmxjwfAX6n
   fpiPj4rCl3rL0OAE5jatpDL61T5949Y2EL0+OGSXvCzNMcjMzXu5ctWON
   78gVEaga+83Qd2arNVkDypYwe7BCM43iLFTtcBjDfMgSRxDanXE8OgW+x
   OuCJ3d41WY6x9Bef5AK/TUtE3mwpE3Tcfgg1imYairvTEjVmdtkkbTRGl
   Q7mt4Be69LbVWojjZmkUZIrZLfaUDohTTOqkhDVXe2E+o4qhucbN4BHrd
   zjXtkpjGlFX3XujEJQ2PyzqGjkJAq70g7mUQSM+xkLOyQsNgm6jX7me3P
   w==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="313645302"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2022 08:12:01 +0800
IronPort-SDR: rbrN4lVR/3LEgG+v6A4uy7/CA26P6sbi4HUxVKhNeUsNhF+ZuJE+BiQ8Jl7x3MCckaRHz/AoPe
 pKwf6lvXxekf8V60+OqcC4S9VYkW/WJbh/YfWehEMPfy+fE+QED53HQHasr2ELvHW1Rbz3OLN9
 nNG9WtYyPw2syNYoyRAxn1NLk6QQdFpL2oS8t1dbI0HnZZKn7yqgk+dsVcb0+5kbWrBuowaz8l
 a/l90lYJt0tecXG+DoyoZxamEfpLm2TUikW7EcCny99P6CSiRrRWSoUz3PoFAScoaP5sU9Itku
 UtCr49iq7SSrIp4l0UwnPJn5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 16:32:41 -0700
IronPort-SDR: ewm1CRR0jFgGhyTlsnh1bHFK6XbN39zci7RMS7XCclDut7dfapv6HOdbTq1GD3twD9QP69+ixK
 dNiFwY3/eSpNcuhWp6VmxhFdrd1S3vFw2iweCc1QXau02FQWQeBp0jqGK9oe/w2vqRhjyvj6nf
 PcUTjHPhgklxlIUNo5WuiYqdwFS/2u+ivA9aEQDBih+ZPhmu1ol513phevmNDoX4UI1Fte+qYv
 D1baf52W4SEGD808d5g+w+IC3LJAPYv7G/PmYsPbOncP7VO8f70z2eegaTlhVt7uwDwOCnBFo1
 SJA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2022 17:12:01 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 5/6] srp/rc: allow test with built-in sd_mod and sg drivers
Date:   Tue, 23 Aug 2022 09:11:52 +0900
Message-Id: <20220823001154.114624-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
References: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The srp test group can be executed with built-in sd_mod and sg drivers.
Check the drivers with _have_driver() in place of _have_modules.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/srp/rc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 94ee97c..13dddf2 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -35,6 +35,8 @@ group_requires() {
 		SKIP_REASONS+=("LIO must be unloaded before the SRP tests are run")
 		return
 	fi
+	_have_driver sd_mod
+	_have_driver sg
 	required_modules=(
 		dm_multipath
 		dm_queue_length
@@ -51,9 +53,6 @@ group_requires() {
 		scsi_dh_alua
 		scsi_dh_emc
 		scsi_dh_rdac
-		sd_mod
-		sd_mod
-		sg
 		target_core_iblock
 		target_core_mod
 	)
-- 
2.37.1

