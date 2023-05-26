Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0601BC7EE23
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 04:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjEZE6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 00:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEZE6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 00:58:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0301183
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 21:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685077125; x=1716613125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dw+3ft0rCDmodyiA8tBIGwgNNkITfIvh+8gj5H6vxL0=;
  b=jhUIeNEMuQOTiw8AdEv8E2kcR2GXK06iqzmkc/Tf3gmUlGu7MlxS2HEC
   pUxUcd4rBTvMypYVgEpx1j90tileqlOJbeWON4FmrcjFu8boAvUEmxvuN
   KK48FMYilRATTNGBR7rvZ+jS018PBDgnrK72XKbZU6s9VIRYQZ2eFwS9o
   DFoDRBDHB/x6MDfljDw7Tek1trZKUOTz8BUrdkeJdriQDURS4Iwpt2mHd
   4kfNTdN7Olau1DEJ2m2FtwCGNEvfYvfpstBtvfZ9+jrAMnRBRhHfJjZBW
   usK96EY8kcsVw3B/yYqEz/9SKQCP1ZHRkEh460eEiT/Wzz3XX6Qkvxzsb
   w==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="231616515"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 12:58:45 +0800
IronPort-SDR: gftLNHJtRIoqdEXkwwACG5Hb30ryD2k1xPKhJ3l6Tuvg3d/RmkdZh3IqAj8STwoure0mfVg5eg
 lmYvMEz2zlc3UrCyfDzx7fBh7Th1WZrMKyIvNj24I2sPVaN53/01Bl7z3tX76uPGvS6BaVHxiI
 9qe/mJXBwutal6RF8H/B/teH0epHNcllq5E63r9I0Wjmlg4HUnPXnYCBO/DNsGPTs4/sgJVxZG
 QrInhZMoA89s+vbUAzsItWLsahftaypVIRxoe29JnfyKFItjzykcgbZcvFvsLvZI0xQftLVM2T
 /LI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2023 21:08:02 -0700
IronPort-SDR: sCsLGdU81bSulGE46siMQbYwICT92ilrxqWluoKYjBkv0bbeUmjb44FFNexCKHVdHOKtncbl0V
 pVMgCPvokU/RMIqQ+Vp+v3AjfyLVX0wUBMkEbggLCAW+K3sJkuLgOyBlZYSSanTwcU8qY3Vc6J
 HlmrCeNsHZdEHLmC0uL1C+DhoxlbZ2xuE1kQLoq6bmD4Gzw76D/cPjacQRlrBlHJURZpmYOdDx
 tRgd/9pJu88wKw0ICc1ikrQEW7JazH/dnqd86tkZXT9aVNyJm6oFIwD+lulmL5AzaQa61G0e8Y
 /VQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 May 2023 21:58:44 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] improve block/011
Date:   Fri, 26 May 2023 13:58:40 +0900
Message-Id: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As of today, three failure symptoms are observed with block/011 [1]. This series
addresses two of them. The first two patches address the disappearing system
disk (Symptom C in [1]). The third patch addresses the zero capacity NVME
devices. (Symptom B in [1]).

[1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/

Shin'ichiro Kawasaki (3):
  common/rc: introduce _get_pci_from_dev_sysfs
  block/011: skip when mounted block devices are affected
  block/011: recover test target NVME device capacity

 common/rc       |  8 ++++++--
 tests/block/011 | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.40.1

