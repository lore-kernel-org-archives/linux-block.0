Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E80CDB47E
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 02:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjJLCMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 22:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjJLCME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 22:12:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0139398
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697076719; x=1728612719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=td9WBejDDKjR4Ddy0J5rCXN1ounSZS54zWqmKYVAHHA=;
  b=gPhf75DTrArfrolPySb+pTjmpBi97ob2oyRdI8S9m9GsRhSEw/TRkOAN
   cO8UZiPK6GQlJDeq/m/C2EfJxhWq/Dq9pi6zW/gkark6FPzZLLMwOODog
   HjiSccRTcedWGso+IrQxqBVlSiXbDcpvUSHECWtNuaKdn+VBgZHbWSd8t
   fduU+TA5qFuecSLRWJ7IfVdxV4qIibIfAGnfSnN/HryMigAy064iuq+hO
   pd3ibhu8zFod8gyCp1VzuVAxqykJVEV+m7M7hlTdBNvttH5rAxDCbhV8y
   6gjP0OtyXOb3WKNSCPQQi5n2CGvwPF2f6tKMtAuP9HHYdRQEQNSF+k/wX
   g==;
X-CSE-ConnectionGUID: lXTI4VUPQVK01oNCr1tOqg==
X-CSE-MsgGUID: B4doRqDDR9aBYnnkz8naeA==
X-IronPort-AV: E=Sophos;i="6.03,217,1694707200"; 
   d="scan'208";a="250798257"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 10:11:55 +0800
IronPort-SDR: NhbgxNh6d7d50rX2KQcfRiYInOUqJYJYZ7Hx/RjeaaZGsrgOoHPvaMwaecy1p6JQpE62xNZFdq
 w85kM6yrJ74ln9iS5YBWPBCjFPzuzkJJCKYeLkpj2ZkNQoDEC4wzprugvE+C9Xz16eXis4IDos
 a07r6hd69krwKQtan1MYvffTE1ZZPHWCyFRxBI27IpFUaxKqS1WuGuETav/BTdLSHvatj4wz+0
 IXp99fClf09SEXbcsPQRlGQ80hX0BliisAGd4pM4pGJJUbdN6xU1ONXpKhxk2uTlZEOgWvlPdc
 c+M=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2023 18:24:02 -0700
IronPort-SDR: D+Wiz3jkuL7Uxc4NQmshYdBT8t97UCyQ5YHO0h7HWCREFkkE3LBOZ52SwFSprmimarabc36u+B
 w8LvcmZflDgELOo6OWs2gBqB8eiOdptlsnZGGK8yxDF0u0t0Fc6xyjLbTVgF+M0yl5q3ClYv8n
 4zxJVvKG+/YsJieKWp6dggbD6ql04ShBjOq0twinUQgEaYxi+YOtEc9wgEiiOhhJCAuk8t7S5t
 WQ6Rtou+cez4ZizN6AZsYvN0bTiuC01HXARZFd3PwN7XeVZw0flwL+J3IRKPtCuh+csAEKKPth
 KlQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Oct 2023 19:11:54 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] TMPDIR fixes
Date:   Thu, 12 Oct 2023 11:11:50 +0900
Message-ID: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yi Zhang reported that the reference to TMPDIR in nvme/rc causes an issue
because the reference happens out of test() or test_device() context [1][2].
The first patch addresses this issue. The second patch fixes another TMPDIR
bug found during this work.

[1] https://lore.kernel.org/linux-block/20231011034832.1650797-1-yi.zhang@redhat.com/
[2] https://lore.kernel.org/linux-block/20231011072530.1659810-1-yi.zhang@redhat.com/

Shin'ichiro Kawasaki (2):
  nvme/{rc,017,031}: replace def_file_path with _nvme_def_file_path()
  block/002: fix TMPDIR path

 tests/block/002 |  2 +-
 tests/nvme/017  |  9 +++++----
 tests/nvme/031  |  6 +++---
 tests/nvme/rc   | 17 +++++++++++------
 4 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.41.0

