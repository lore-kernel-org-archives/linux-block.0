Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC4C11F66
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7CC61289
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhGMKPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:15:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23428 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhGMKPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jul 2021 06:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626171163; x=1657707163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypADBrW7wc3lsrMDgBijmF8Vc6XUNOz7b32iCAQOfg8=;
  b=DNfhJIMdDIHMXYzB5ipdD1jITYEW9ECk2OX4deFAWihJpQD1ZXsZwrvM
   jt7lBoFbwO5Z+ZvlaNEOj0/NCXX5UlEPwCb8s2oRT6mlCxksUewU8kI5W
   NpAGr11YG8VYPz8H//n77RNSbOVP5uPTvrI0cnJOUXmgZZzGvwvndjz9m
   +OKuroAtpK1mSHOW6aIkYdNejS8VkVwS5ndK2og2EVl7q8DA3eK66Ay8U
   dQnwLRa+GRKigMwmM15q13VH6SkIQ+CJGrGD8sNTV659Y1p1wkRgWwTLv
   Fzvg8Bk8T6hMDEOLzZoY/wxxLe9qrF8WD5jSHOiIGFvU4eNuEFTn4d+/Q
   Q==;
IronPort-SDR: TrnO95G8GxGdGR+doF8SZAuiKmUUJkW7hRiv9JyBE5r9xl3XIQux1k16JBqB9OVup6kXW5ORn7
 lgxX9RenH9pAE7XSoXQagGQcV9OP0Safh5WNKHMr6Hqu3f8hpB/a1PpiM4E+aTVohqANllid4n
 ZM6RTUCk4Y7uzLhjB1U+Yx/Hq015xKhSy3ngBHZcJIsUWJoO26DGwhMyX3K3rqYkD7zf4AEr6x
 NXfrmgSgYvQo8dihOXHzb90J82L4LeJDMg22N0qoG+m5953faEMoJ4TwQv1RqFWVpPLo01WjsE
 bY8=
X-IronPort-AV: E=Sophos;i="5.84,236,1620662400"; 
   d="scan'208";a="173685554"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2021 18:12:43 +0800
IronPort-SDR: J56XBGiNRRJ5webe8FEeo2/gUHEDRCEdULFhznAlkwD3S7C/R2CmX1FSaLUY6X4+FcVEwIFXm2
 riBOw1u3yKD/hqIvYZ5qgSWUiCTz2kvIqc9xtvqw1sB82QcszECbE2/VT98R5NShu961vIKbLJ
 a7vRnbRO1NFNy/HCHtOMNMCBzg0QqPWDwavVZyQtmWugzoIWY4sIU/BRK64xo/+CivDeLqA1XT
 WpdX83ubjEyTih0h/sXofctsf99o4brULah20PatboD7tyO37TW07ZE5YVli07+jWnYyuav0uX
 ZVtkuvwAGiZA3VXPS2F/qySK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 02:49:26 -0700
IronPort-SDR: lGBpPVlV1v+dgpvGenLJbN2XRggaiFrZrgQL+UuFQ64jgSmzdLop+o5e0KnGmuLnoUsIZQmjgF
 Evv/km8VimaBX+/ms2QY4bfS7nAoxRA222Mh7y5DGufnCMG5avGlP0YifV2sgoKdv6bGi/lJcL
 e1azstqUtcqr8xJ1jKvThHa5J+IBKd6eKyq4jFPDePt+F+wgdGxTzngFBKJtWkg3DLOw2J9k0i
 C/z1T7624qw0pffXY1nKb9EBlMhFAr4CDy82dGt7jEftWLiFnvBY7eRwAONge6vqKim/xa653a
 3YI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2021 03:12:43 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] zbd/007: Reset test target zones at test end
Date:   Tue, 13 Jul 2021 19:12:39 +0900
Message-Id: <20210713101239.269789-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
References: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case zbd/007 checks write pointer mapping between a logical
device and its container device. To do so, it moves write pointers of
the container device by writing data to the container device. When the
logical device is a dm-crypt device, this test case works as expected,
but the data written to the container device is not encrypted, then it
leaves broken data on the logical, dm-crypt device. This results in I/O
errors in the following operations to the dm-crypt device.

To avoid the I/O errors, reset the test target zones of the logical
device at the test case end to wipe out the broken data.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/007 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/zbd/007 b/tests/zbd/007
index 9d7ca67..2179647 100755
--- a/tests/zbd/007
+++ b/tests/zbd/007
@@ -109,5 +109,12 @@ test_device() {
 	done
 	_put_blkzone_report
 
+	# When the logical devices is dm-crypt, the write pointer moves on
+	# its container device break data contents on the logical device. Reset
+	# zones of the logical device to wipe out the broken data.
+	for ((i=0; i < ${#test_z[@]}; i++)); do
+		blkzone reset -o "${test_z_start[i]}" -c 1 "${TEST_DEV}"
+	done
+
 	echo "Test complete"
 }
-- 
2.31.1

