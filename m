Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF49C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 01:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9069B2600A
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 01:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MzD++9bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEaB7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 21:59:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19074 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaB7Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 21:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559267956; x=1590803956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=caXR27Perknm5d3QFDsnYvbVhC1Cr/FM6uFGdBvEOfw=;
  b=MzD++9bQit/rNqR5C/rRY6qDlwX23/rdywboBFIdUuNc091l3yUv9Asw
   HK9U8h9KfvzUxEzcUsrnX3kWBOxf84kjIiiLnzPA3STWR7eN4dF1BxoYJ
   A6WOP3qduQ6GwyOi4SI4aWlfCps/9vvwtz+eu8HoBMR/KOFdtdYsXYQqb
   kfnwwKq6IkSLKbqSFJxWNu/fSDg7mmmS/URYj5ea9eoUwuWWejHbQrZiV
   K20AsUKnpHsnIOgyf4x7qL2zV+6mXqQHI2RotsiZkcvnXAX0VLUkB0m8b
   ztBr4azZ1CLiU/9HZnqd7ZvHMzLTZIL5dwVRW9qZuPetDNF/Dm1Em/pGv
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,533,1549900800"; 
   d="scan'208";a="111145549"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2019 09:59:15 +0800
IronPort-SDR: 0zfszn0l/8gDvYLAshReLG9yg85KHyrCkNklS9LrNch6GqEfnZZRzXGXid+MVlLtOLc5d4WY3j
 3H6BdkvKaqu1z29yB/FgKqO7MMzr285ULV5kEQU9hsOdlQqplPDspSi8IXSqytkVMiIBl0Dy6F
 5ur6ETxLwxU0n6jv5B1CCLKdvHsFvMjrSTdziAqEw3yFkXFpD/5BpfoAQz96lzLexA2ug8prQ2
 ZJXjAV8vFjYzimvJvDMAnxqoKXq0G/+BqRClc7bPymtpC00P3OQpdoTTalUh4jeX0phlJlyQCU
 eYX5mrXXjePHGmeVYQ5p49iN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 May 2019 18:36:44 -0700
IronPort-SDR: snFo6R99hi6WOibX3frCkzHFLwq9/vBY/okHt9pRQ4mM7PXdBZsG0ZLOe0LW9jDyWjB0dk5RhT
 Ku9eUjXszCR1OZsSsfdn08ZOKmMmo/IfISybSqtmogFMKDvoj0uCC3oVVPessGIqnKiTA0+l18
 +4m5peDKJlK2FfM3zdfNnolPxnnEvET176zHwrS49ku6IfXiIvote5+yqRfh69ObK7lKJcQMrB
 LP5FTZK76Kq0asw9hojU7EZWML8rtjFhvC8m/GYdJMCIYapRbI6ZvxA9zyDUeEuVIrm9cJfJ6R
 DhU=
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 May 2019 18:59:14 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v2 0/2] Test zone mapping of logical devices
Date:   Fri, 31 May 2019 10:59:11 +0900
Message-Id: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a test case to zbd group to check that zones sector mapping correctness for
zoned block devices that are not an entire full device (null_block device or
physical device). These logical devices are for now partition devices or
device-mapper devices (dm-linear or dm-flakey).

Changes from v1:
* Reflected Chaitanya's review comments on the list
* Separated helper functions in zbd/rc into a preparation patch

Shin'ichiro Kawasaki (2):
  zbd/rc: Introduce helper functions for zone mapping test
  zbd/007: Add zone mapping test for logical devices

 tests/zbd/007     | 110 ++++++++++++++++++++++++++++++++++++++
 tests/zbd/007.out |   2 +
 tests/zbd/rc      | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100755 tests/zbd/007
 create mode 100644 tests/zbd/007.out

-- 
2.21.0

