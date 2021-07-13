Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B0FC07E95
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B3861249
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 10:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhGMKPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:15:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23428 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhGMKPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jul 2021 06:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626171160; x=1657707160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fnTl48V1hvMqE+1LOwj78jm6oI3Af0znRjjZmVVHepY=;
  b=DJMpLViEYYM4aJpg6QwBGfqL6q62ZqFbRwFq8EjL+8ojvdcUaSlqIqGm
   7ftW7lNis85eMQAIKfPzZMr3wc+c5Ieeq/DwpBA4UvaJFTQ1Pmyj3R/e0
   eX5q/hhW5Tk8EdCk4VzdMB+9crM5pcPEx6QGyJGjF03P1Al2TJ6bj4APC
   htJlV09D1Dx+2FJudV+c00NnGWEaiAeGgSO1Bvcext9ErixM8X/BWHje2
   30u3kCE80b4gHSuS7kK36rgR76f2jPaMQjjoqF0bTACSb8VjTHkE4xqKO
   Yu16P045+1j7XN5cN18DGuNAbNekCAicx3lS7h0dC0xZnoqaw0wDixxPd
   g==;
IronPort-SDR: NX8OEHI6OSNaN26QWJHblfGO7YO3NJvFI8LbyhZh2EDQ3Egu6Nz5HmclWxUBpROugez4rFpFjP
 /V+gt0/CbEHuX0wcrWNMXhk69rbvODRvuQbK6JTNJ5S0dQkddjk/ezmIq1rL9meVTzwzKjAO+7
 Ko02g0LguC3LhAuTJzL5hKe5Gne+8AG9Dh5ZX9+p1Xs6DAqXalpEWhASW87FXxIFrpRRwhWDn7
 upTzaYV03mJXOrr0XOeoRGPleTawsQGJv3lgsZa4Kwgaw3v/dSSJ3XFY0SEHHWp6rGMvzIX8JQ
 GR4=
X-IronPort-AV: E=Sophos;i="5.84,236,1620662400"; 
   d="scan'208";a="173685549"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2021 18:12:40 +0800
IronPort-SDR: zGrCHdyO8JJt9XlItZlx64lVceygKqtSREmOXyHOT79oFjBi2E+D9MCZgVPpSuoePprmS37iY1
 TOZWW5eUBP5Y0qeSoq53bPyoC3/5ESQFR8zi4KgHkGLFojMqQCMUN2r0blF/nQXa0LpNj7bsMt
 Eb2JrSjtCxPTGNbOzV2vp0am3z4wY0+7+RUzP551ptMNTQhofA+hO6h+bZFU88NtQcCRVtPHaj
 eCJ9YOz8hiv1eB/fuEKWyYxxUmxbtd3Y3KoaX0M9r0ryXIlN0mjFB4YszIlVV0jb14vFyXk5s2
 LDEQEVVjO/q6e2bBnHvuffJy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 02:49:24 -0700
IronPort-SDR: EXrKp1QfzJle8/Wxl2mYG2kmFg0Gba3Aql9OmrPITu6H1TrQRyBxhYAEfuHX6qrNcXy77kW6hT
 dPuoTQV8aELzb86sdIvzaHdAy9Et0UHEWxHSFKFbtpLebDWB3Nv8+Me9SayuVbZcIk/74y/ndN
 CEp1NZkZHxT231AzEY19toUUUwa54WlrdeEwG9tNbM7ofkaFVw9xjkROjVkXCe4wvUXTUlgV/4
 lqYHeFJGeykgrwBZOrue4MuOkNc/ml5wvHtoSDw5B2UEGRYNST2SfqUaayODuwN/JgXSOTEnLY
 Jrw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2021 03:12:40 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] zbd: Support dm-crypt
Date:   Tue, 13 Jul 2021 19:12:37 +0900
Message-Id: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 added zoned block device support to dm-crypt. With this zoned
dm-crypt device, zbd group test cases pass except zbd/007. This series makes
required changes to allow the test case zbd/007 pass with zoned dm-cyrpt
devices. The first patch adds dm-crypt support to the helper function
_get_dev_container_and_sector(). The second patch wipes out broken data on the
dm-crypt devices which was left after the test case run.

Shin'ichiro Kawasaki (2):
  zbd/rc: Support dm-crypt
  zbd/007: Reset test target zones at test end

 tests/zbd/007 |  7 +++++++
 tests/zbd/rc  | 20 ++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.31.1

