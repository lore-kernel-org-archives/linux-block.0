Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B06FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 11:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbiDSLDZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbiDSLDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 07:03:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE6F1BE91
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366040; x=1681902040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bD6w7lmKpleLVoywFzVLhL/bP5USkB8fXJJIx2/SaKk=;
  b=EqY9KhINKriydn4vxrHsfvyC2g1MtD/GMlot/3Bmi4ntoSeLbb3XRWPr
   dh9CDhXXmLsADzafI7l5MNnHkPjaLtz9ss6dEcbDEg/CmvUXbdahMohvj
   ErDBUy6U0189uvQ9g0X7rL/tki9AHu63kMyuyepP0/t6KwD3Icfw8Amsc
   M0yWf/H7qyimPCyPpQKrJiB8d0jCoRNjKtJvyxXy7rUVnm11DsbN1pZ91
   5Umc3BWL+hdQxwtacl+kuADM+8ihUeuc630BmQ5yrw7AozsFt+3J0sSLR
   EPM3F6WW4Ko9Gx87JbV3F+cfXO8PHjz6Wk9yYEQwGkM0WMUzExqNxq9ry
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="198252943"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:00:40 +0800
IronPort-SDR: Ts+MKn3b4/5jBbBGiZKEbxH67GWbpP0ToF6vi83j5OYO3LfOMb4toDSpC9R4UufUvUXPg7D1BA
 NmmYmq7F0FGJFwaDjh0KY+Hy+r2nOkLtbRxVaBnWpd82ut1lMRgKvIpya3yn5gGKcSBe8UAlwi
 ReF+4PcsrNkctpqZBxhQdlbCkFLU7OD7JA8t3AG0hLAFeVh/5UUE03X7/fBcbXMLH0+1WcbxvS
 AJPQP92d4l6Q9Dzt+/ejK32CbquHOmyHBSqljURs8vaSYxAr91Km9Hv1asgqxPQmO+zi6Alq19
 mlQtV4ZKMnb98DxC/1NDmQr4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 03:31:47 -0700
IronPort-SDR: XP6IZ0zhqQbs6efXSh4De0EascLTRQ2KcZB4PziLC8Ige8JsIJn+Rpgq5m3zmVZY/AG48Wuhoa
 tfXLAbrx+U0PLxwg1NLIYqoLmFcepyT51uUbbhCFxPqQ1hv4NK0ak0l3SUgJZU25waf/byA2eu
 Iert0YJThP9Q+w7lfe105fYnGjwRTrb5ch6qRH8dPDAQnP4qK/5zmrFnseiX2Xq+V9/OHrlbY6
 R1RBlgMJHRAgZYWAvl1rcSMhwI80zp8en3UezShbsXi7JgL2dfL4I/8ARsjuFr7qaCHm9FnMJj
 bIU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Apr 2022 04:00:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KjLST0cDNz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 04:00:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1650366040;
         x=1652958041; bh=bD6w7lmKpleLVoywFzVLhL/bP5USkB8fXJJIx2/SaKk=; b=
        hCIeTnBx2EmIV0DUgmpNAxkgpSzecZNUwbmtVhkZg8OaV0tlLMzTHhcQZT71kDDb
        mP8F+V9+YN34eEZHrTimQehZpxWwpWxwDpGFt+Ejjv/o51lIOCuR4lASo/zt9A+p
        jF9yT8XavBb/khAZJe6guwrcO9dEIJexlLBxWrjnW+TYoNwQ/dwd64qnSe43W/BM
        he0WOKkVnEt9YRtr3Qd1h5L36luEkz0dYe7l/6RmZ7fGSEpfnRVXYc3Q/f9F6IgP
        /wxwyJIhK+9IKrNCBjGZ4B0uhUZBGat3HZ/FL5QAZLf/G6sMDEc55H+uuhI1GzGb
        AoVh4/3e6oWfeOGaMrosiA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TMh1VR1oVMwq for <linux-block@vger.kernel.org>;
        Tue, 19 Apr 2022 04:00:40 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KjLSS0WWHz1Rvlx;
        Tue, 19 Apr 2022 04:00:39 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/4] null_blk cleanup and device naming improvements
Date:   Tue, 19 Apr 2022 20:00:34 +0900
Message-Id: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
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

Damien Le Moal (4):
  block: null_blk: Fix code style issues
  block: null_blk: Cleanup device creation and deletion
  block: null_blk: Cleanup messages
  block: null_blk: Improve device creation with configfs

 drivers/block/null_blk/main.c  | 113 +++++++++++++++++++++++----------
 drivers/block/null_blk/zoned.c |  14 ++--
 2 files changed, 85 insertions(+), 42 deletions(-)

--=20
2.35.1

