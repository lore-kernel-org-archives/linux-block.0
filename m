Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DABEC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 00:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbiDTBAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 21:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiDTBAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 21:00:06 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F2913CEA
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650416241; x=1681952241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=33nciO+pLAAW19HNxBfC5hfEpTMHr8acGfGzWB5a1GQ=;
  b=d/6TCN+t1mWxIL0ucQfJSpUXmjB/PLVu8AlMk+GymNP6XOkm16H8E/tg
   8qMXJYIN5n54LPEtFnR6yeMj/rL0SrFYagDWSrT33NKxFDrPra6+hdlFu
   vufV5GYThQe2GywsDPQteug8qcGvTdUh6XhwC9S5Sbme7tRst6afBF5Z6
   fd3Vwa7sP7KM1xVPkDaSDm1IuY9tlFf5x4hp+8ZPwntvb4MvDefiN7kTX
   JyQkn+aXviUgK/g8jch4rokXShi0L4DUIXr9Vfj547iz7pvHwnZFhNChp
   AnOJulVD5+981oo4aCBcUcoP24NL/s2ItmEEqD2B76pdOvd9Mqp1TtWC/
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643644800"; 
   d="scan'208";a="198310327"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 08:57:20 +0800
IronPort-SDR: bVfZh1C6T2IOPXxX3EftcqDHe0PuCV80r2FV2jKINoiVefDVui0wUJAu4Z0stpK+RJTwh51Vcj
 gS1rGz3hUdyXeZdedB8UFsVb3bsy27rxh8zSsWZV0DrVgPcTsjM0HrVQYyqtgO0wQPqC/8AzNm
 dNYop7fHoj3Lcle2E4MVFsG/cpZuCZedABkLQgvR15o6mbk5h8FDl6jGrW+r2VvN+22Hqm+Y/x
 V5HoKq0o5xJYowfgEKYMOs9ATetrTFC+2Ry6o7zABh2IsMa4yu3o54vlZMp5qYWkW6faoC9Iau
 TJVvHhrHNMq8H4QQYN3oJuqZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:27:40 -0700
IronPort-SDR: Oe4uFLaxfIpgbvLE/L8Gb4NvS5ERvme0NnPX3y5ybAbXSxu8rzY3ozbXZxWPdkfDOqWbUt64H4
 E1GvTzSFGmTWV3+DZJKvqhHEcBfiNuM2xECaoFtEt/mQU0VJPib/hQZ91kIhK8weSfTucV9ne9
 Uy3q94fDuglfWdh7dfirU34S36jwFO57Z29ZVBwT+hjJ2pf6LrmsovMH1pRwMWRFhB9BY5VDyj
 Hl99yz8Cyx44Z8MCgxlrC5Nh1TKP+GwumMsw3auxOp9avFt+D2qns/52QCaP2KHamqStjnRGWw
 EWg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 17:57:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kjj1s3ZqVz1SVp0
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 17:57:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1650416241;
         x=1653008242; bh=33nciO+pLAAW19HNxBfC5hfEpTMHr8acGfGzWB5a1GQ=; b=
        Yo9S5RjwCBOEBiMx9fJ/qfR7WoWb5XWnWFGRH/UOFtbHLT3fgVEfsRG4yoUG2Q0l
        WydFbtCfy8Ig7sCp7S5/vyby3k1FryMJLoxPQatUdmTrLrFfgQu9JT5XuaT9kssi
        XhT2sbzBXt3nSuqAhIvUhZZw2l2cCxGbvUGtsqOwngrd+t92MkxTPov6aJfpqFQ7
        FAtNFFit1PsIxjgJtPud27WetntHnZ4tEbiUW/dmkvltod4egIc6WnDgVdk5xiD7
        MIpuw7/ig1b/fuU4tnmq/qSDd6bKQrQZ1gLxSGxe399xJT1zZrG+u47efvI9Ceex
        Ujq13apnq4o2sVtksee/Nw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rXC7kG3S41Fz for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 17:57:21 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kjj1r2W2Gz1Rvlx;
        Tue, 19 Apr 2022 17:57:20 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 0/4] null_blk cleanup and device naming improvements
Date:   Wed, 20 Apr 2022 09:57:14 +0900
Message-Id: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The first 3 patches of this series are simple code cleanups.

The last patch changes the device naming scheme for devices created
through configfs: the configfs device directory name is used as the disk
name. This name is also checked against potentially exiting nullb
devices created during modprobe when the nr_device module option is not
0.

This series falls short of pre-populating configfs with directories
corresponding to the devices created during modprobe as this is not
easily feasible. However, the added device name check avoids mistakes by
users about reusing configfs names already used by existing devices.

Changes from v1:
* Modified patch 3 to use the pr_fmt() macro instead of manually adding
  null_blk prefix to messages.
* Fixed patch 4 commit message

Damien Le Moal (4):
  block: null_blk: Fix code style issues
  block: null_blk: Cleanup device creation and deletion
  block: null_blk: Cleanup messages
  block: null_blk: Improve device creation with configfs

 drivers/block/null_blk/main.c  | 91 +++++++++++++++++++++++++---------
 drivers/block/null_blk/zoned.c |  7 ++-
 2 files changed, 73 insertions(+), 25 deletions(-)

--=20
2.35.1

