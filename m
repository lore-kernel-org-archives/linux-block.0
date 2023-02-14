Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72815C05027
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 04:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBNEro (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 23:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBNErn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 23:47:43 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CEDE382
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 20:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676350061; x=1707886061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sc142Jy+ziYe78cjwUYErAIuc/8pTQXPHMQPiJZynuE=;
  b=adTSup7zllerkOGkRoTWjiV3khz6WdpSjSZukErerEBcsDFrga1mgrG8
   4GZ/O8MqTDM5OjQ3CxNOkFkDXIe//IygWBHmGRTnU7wsrFRrV4Lx4S05n
   hfoCkWop+F8qi/qFwCqoZmlXaIsBfIeHlkg/FaAEjij86++UE37pLR3f5
   2uZ7jzBV5LilfMkAdpYWZmRoWc6heiZ3q//7PlVoPzZAyWcyVIw/46Fmd
   ldQKnQaF+x70UiMJY9qQYGX0+NVIwlAMzCflx3M4hARk3jEgRrdCTagci
   DzjiEMNpSrKwNqyymfLlNFv01PUz00utXBJW9ZojZiMZCMBqNJXaxOQ13
   w==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="221538215"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:47:40 +0800
IronPort-SDR: jHicpvt2P5L50NoemyUvRuRK1JLPmEAuYlaCyB68iZxB1lX27ESDukphzazNratN8xTlgEYxXF
 hAPf6EzUhIOMCuFdBR9CkLJAomWVSeY1RyohkwPGlh4Ofu/IENhcrmSqvfk+su2/3orj91uVyN
 aRZwylY21ms5d/hP8SXlPA7g+DMo9y+B9GYWsXl2N1vibHWCth5n6dQzABmpnyI4G4qQKqaJlc
 92zse5mjwvaLyh5+qWGxmOALjRauh3cjpRdcsajh/4yktSNMTCm8tmjtdoxi7K6tKgfaprEQdP
 3DM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 20:04:49 -0800
IronPort-SDR: L+0XHXPaT5SyGkILI6YYB40V670zJfw9Ev0VFlMEzskZ8Gy1ftLf800VwWeRfC3srqKfEtkSKl
 dbn1AuRMRZUwa2X7P+PswPHlQokW4jYZb5UUMOclxGWVwuTsnb8xgY4h+xi+oeASk/dqrLdNKG
 BO+MXb8Qkn1aa6WzpNurwvL6OaVNSYmIXpsU/2CAt0WSy2fO+KIqzpNWof0vaga+rZXWHzPeQg
 OJ/87fdvrtDlEyvxA9lHGwu4huPPN97svlG2M2O9jEmwKsIKiJvP3AOWhKmYBfUjqr+M+taUmg
 kTw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Feb 2023 20:47:40 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Kanchan Joshi <joshi.k@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] nvme: add test for unprivileged passthrough
Date:   Tue, 14 Feb 2023 13:47:37 +0900
Message-Id: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Per suggestion by Kanchan, add a new test case to test unprivileged passthrough
of NVME character devices. The first patch adds a feature to run commands with
normal user privilege. The second patch adds the test case using the feature.

Changes from v2:
* Added the first patch to add normal user privilege support to blktests
* Adjusted the test case to the functions for normal user privilege support

Kanchan Joshi (1):
  nvme/046: add test for unprivileged passthrough

Shin'ichiro Kawasaki (1):
  check, common/rc: support normal user privilege

 Documentation/running-tests.md | 10 +++++++
 check                          |  1 +
 common/rc                      | 13 +++++++++
 tests/nvme/046                 | 50 ++++++++++++++++++++++++++++++++++
 tests/nvme/046.out             |  2 ++
 5 files changed, 76 insertions(+)
 create mode 100644 tests/nvme/046
 create mode 100644 tests/nvme/046.out

-- 
2.38.1

