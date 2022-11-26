Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AB6C4321E
	for <linux-block@archiver.kernel.org>; Sat, 26 Nov 2022 02:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKZCzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Nov 2022 21:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKZCzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 21:55:55 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56E3FB97
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 18:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669431354; x=1700967354;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S5BsiIgVEBfz5u1XoMGJSJhU8+/yMze7A43LcucPMNM=;
  b=cGnXPlqvvjfb/R2Vty6ER5IXPB1E/G9FZ9F6yM3/UNHUE0mxEY9zltVH
   SomclltA88GJhLZMfB+CarpEcSOBwPjUMcEmIY92pxM5VHp8m/FKb2S1e
   S1sg4DxjXs5+Vu6+FeMki45U428CsPmZO/0vitFTbZdzxV6eaLFLAgssI
   LxtNF6U87HEF0sVdsBbx/W7XCl6cZbVWYMdDvWmHDUAFA1jjoSzHKFalF
   zHpsmCtdVtyXMvkkJq3YzVAvkyxg+r2c7WtTL3IiXLJdOWMC3Ypowqtx7
   XhHtZME9moFEvlquC0xKWCZdyXsFPPEAM/6e7F+EbTvXwdwmfdTafDPIu
   g==;
X-IronPort-AV: E=Sophos;i="5.96,194,1665417600"; 
   d="scan'208";a="222364190"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2022 10:55:53 +0800
IronPort-SDR: PzJxRbno8Okj5UuqOKeGW6erT4RmMJa+S62b8zBR/+ceX2qatVQnjeInCr6S3uQTP3atDh97aP
 l7wv2dEfNCyChLs5hryUocpgRfRINJzIjY4mHhAokCIw+/nloORa5O83Nk95IQHS7ezOB3sSvw
 Z631YrzTqiX+pSzyqhkNKtAxTOu+4v/WczWi1zrRCFH7MbQ1x99sXIqUcV+WSHr3uYeHnMrm3v
 ZiDXywbfI+6fCgfgfsRLwE/9BljBQX5ZkSzmqQQNHCzx+yeFku/o9itZ1cKCbRnihjThVcWSrv
 vH4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 18:14:38 -0800
IronPort-SDR: WsiNH87zfIDRToS1eyxLSFksxwvSYUQRwoGRyG6LJC5NemUnG/yPlgAF/t2tAxMUoC6kxM/eQh
 CqoPqA/aRx7j+saJIMqAAqiCmF+B2ABb3lSx+9b3PrbtAngHaEzl/uU7kXnT9jWVVbgNUccmU2
 luvOp6YA3eu0qYwrHuaoZQ1rYK2V2U0ZWMydZAgLwN2SX1XhEokEXF4wsTDUJ/H4AaTmwzXYgK
 ETblYMbbI1rdXA9dcPm88eMTzJ1CKHAzayG6l3jtAiWquSiVXMrMs6PwZtSQE0zo6TCF59TPIP
 Mlk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 18:55:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NJxF51JLgz1RvTr
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 18:55:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1669431352;
         x=1672023353; bh=S5BsiIgVEBfz5u1XoMGJSJhU8+/yMze7A43LcucPMNM=; b=
        PcyRUO7/0pYz8Ev9cQsNEe052kPOrgyqBlO6dNVOZBWBXNrbHDt8LgHseHruuhka
        xKO0WcmrDlFQRH9civ/VFCJmHCO7KxVA+q9tmoBoX/Ky1du9BEprTorDMF4aetFJ
        sW15bOo6f5V51WG9PscKhTTXphjPLkp4LDmkR4zL+ZoIvddxw5FtasjgjkEBPW6e
        JKctHIKpR0t76R/D1Kv9kpnphOeo3vDZoyFLCTFvhPzqtnVcbb6M0xVOnNgYe0Ns
        3ktudvC3kkd0qKutpdtDLfS9GWPp7XI3mSwc7QbMnCP6IjGJj/ZPQkh7auO92D+7
        dhrgy2TPXpwjUbOW31Fi6g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mU3zzEJCQcdu for <linux-block@vger.kernel.org>;
        Fri, 25 Nov 2022 18:55:52 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NJxF42XfWz1RvLy;
        Fri, 25 Nov 2022 18:55:52 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 0/2] Minor fixes
Date:   Sat, 26 Nov 2022 11:55:48 +0900
Message-Id: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

A couple of patches to:
(1) fix recent mq-deadline improvement. Feeel free to squash that one
    into commit 015d02f48537 ("block: mq-deadline: Do not break
    sequential write streams to zoned HDDs") in your for-6.2/block
    branch.
(2) Fix REQ_SYNC use for async direct IOs to block device files.

Damien Le Moal (2):
  block: mq-deadline: Rename deadline_is_seq_writes()
  block: fops: Do not set REQ_SYNC for async IOs

 block/fops.c        | 7 ++++++-
 block/mq-deadline.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

--=20
2.38.1

