Return-Path: <SRS0=2XXV=ZD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66BDC43331
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7371214E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Nov 2019 21:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R+a2j4Ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKKVSt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:18:49 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34080 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKKVSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 16:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573507129; x=1605043129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WtFanAFu2KxS5V1JTqK1eDJAaNFF/2jpPkowwu5X/pE=;
  b=R+a2j4Ea05e4c2p+ST+nmj5rnD6JU5yf9GkUCTQkMRfu4MWNTcAld9Q/
   1JvdGAazfwEDczfiVpTc0JZaxUY48RUI5crHsYbB5yUsIG7Omqt5E2FWB
   q8f4jexJANtCFs5SpY83rll1P1xmXIaLfS576SwTD8fg2dkRXqA36OOtP
   gdDdW2MrAZSR03MvNA1PDcgk3jw4VeCX19uyI74xp1iU1oZ4CwJx+FkCu
   Z/jHawvx5eUTeAXl6Y4gSzeI03rssgDjPCtkUMg3LMllmulhzAGsa6A9K
   fSJRxAGiyJlUl8UgUmwPDxyCxG8fVipV9PEPbtAYzmhLyZEcyuzN8K4k4
   w==;
IronPort-SDR: 11HFNrLR1Ju3f+vPQuADfM4TBcuMfiNCK3m5VEQzR58uHyxqKVU0KZTGNxxrFVxfh3T4uSo/T8
 U8URwKS39/XLIxWu09R0qWZa3txduU+TGv3Xjhy2ulkiU38BgfHdyMdp+jTCt2OF5lQJX5SlEo
 PPJ1w1UzU7dQ6rAr9NtOGqN2kniU0tC8XT6qrrk+baDSs+/Ol/VoR3SBPgQ+RGRGB6Q9JHSFzQ
 /mIcmB+CPWfYhw4XT/Is6PJz1BXIb5YlfiLRfjhRQjjIq3TLFlomuREU4UQlibJlPW/zHsMSJt
 L08=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="124300385"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 05:18:49 +0800
IronPort-SDR: DgCI3KLPNN3mlrCYyR0ScRUsGJcWIT9NKItGR/MuQn+a/bGW8pud/JGdih1dYr3DkNVA4DGIzV
 Ky6cy1eGfigDbeiat+YQGS+66CJXjwYsb9ebW5hLybyJ6GikxSYQnrbz/52QlySGKhr4zQmSO0
 rZFFyCd2nH791g/sPeqIoozvaxRqKAvuddnD8M7zK8RdmKnwf5SW4CgibccTxThZe6znVkx+lj
 65KAqksfIzONEcY3aq5c+DHStmbyW1vE/igeyeH74aT35R5YVHiAdBZ7i2U3a3mJspt9UCWpbz
 CRgr6XLlV7Q+QLPtY7vf/A9i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 13:13:51 -0800
IronPort-SDR: by6hSWLi/y14UUt7Pz5LaffJz9naXNbsFTO83vzxyVhsU0Vl0CuXN9gHsOtmP/xsKMkC3qsVBB
 ztS7W8dV+BfsjCoGs1GabHIOOyahGyl1kzbfpdG9E8p8UeK9SB2d1S2DoRVY2E+z2EkSEfYvlT
 A8jZO1eWUx/ZStMQhlseMgzvaBVaykUANEbklddUfROejhcKqN7hiYFQfAIYRG40Cdj14BnSU2
 dF0/XctyP51LbxhU5qeoRbvfcafmRrJ6ULgUVvXtwH2XbbmT5V843nN8rOn+jfVp3nEHUrl+VY
 2fk=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Nov 2019 13:18:48 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/2] block: allow zone_mgmt_ops to bail out on SIGKILL
Date:   Mon, 11 Nov 2019 13:18:42 -0800
Message-Id: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This is a small patch-series which allows zone-mgmt ops to handle
SIGKILL. This patch series formatted on the top of following patch:-
https://marc.info/?l=linux-block&m=157321402002207&w=2.

* Changes from V1:-

1. Export blk_should abort() to avoid code duplication.
2. Reuse blk_should_abort() and return -EINTR when zone-mgmt
   ops is interrupted when last submit_bio_wait() is successful.

In case you want me to add original patch posted by Tetsuo Honda,
I'll be happy to respin this series so we can have everything
in one patch-series.

Regards,
Chaitanya

In case someone is interested :-
Without this patch :-

# blkzone reset -o 0 -c 1000 /dev/nullb0 
^C^C^C^C^C^C^C^C^C^C^C^C^C^C^C

[  174.115065] null_blk: null_zone_mgmt 163 zoneid 993
[  174.125071] null_blk: null_zone_mgmt 163 zoneid 994
[  174.135076] null_blk: null_zone_mgmt 163 zoneid 995
[  174.145082] null_blk: null_zone_mgmt 163 zoneid 996
[  174.155087] null_blk: null_zone_mgmt 163 zoneid 997
[  174.165091] null_blk: null_zone_mgmt 163 zoneid 998
[  174.175096] null_blk: null_zone_mgmt 163 zoneid 999

With this patch :-
# blkzone reset -o 0 -c 1000 /dev/nullb0
^C

[  211.889379] null_blk: null_zone_mgmt 163 zoneid 191
[  211.899420] null_blk: null_zone_mgmt 163 zoneid 192
[  211.909424] null_blk: null_zone_mgmt 163 zoneid 193

Chaitanya Kulkarni (2):
  block: export blk_should_abort()
  block: allow zone_mgmt_ops to bail out on SIGKILL

 block/blk-lib.c   | 3 ++-
 block/blk-zoned.c | 5 ++++-
 block/blk.h       | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.22.1

