Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81823C38A02
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 02:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJaCdI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaCdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 22:33:06 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F71A45D
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183585; x=1698719585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQOC0Pfd3xQkIpsrM2jqz2PO66oztnRmZbo1BOuXWN0=;
  b=qvEaUubHqaEGWTLB8submH7b5SC7/I7cNunIlAS3TVKjny97rJrt0NLd
   INSjHyWcK7ATnaxGjL54ZyGUUWOwHYA5GE/OL+SpxDbd/FK57per5I0rV
   gnsyGVVOwVMoLzrVEsXXeQ6dkcHztN+gm8VIYyZPXICtVirV29rgaCb3l
   bFS2fcwuDgYWe9FW5fEayUD+G/o9WfFmkj+bnbYkwOxlyVWJc8V8S8NX3
   yYkyqbSqg6VuAvt2gJ2Xfgm9MxnqBT9GVV1ByyAoJ2EXmdlSoX0NmMiev
   Jz5qQfTVq426xi5gByypT7N/4Au+m+BKVyFhtRzSjGeIM7mHORriIQ85S
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="327200813"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:33:05 +0800
IronPort-SDR: ge3ICr+yuMuWSYQJVizDu0Agqg19hLTx20oTbFv2vSYZB2AmNyoyazi1931BzmG6Z+FDVUlzdX
 sV9enh1z1feJgwsK6OYuHiFi17U3ukzDUhL2AXZowPfPE3TTVX0+ZahgtqfTJ0+6aMG6yFGVPl
 Mt+qGMdolLwUeJPbSCfUB7DGt5q9vrqBLiIGdRT6ZwRKwWOJAhoivf/i1d6HFYwhqurM6ARkC+
 xTyjOe815MJFdlT2oklAm7cAIFJI4rXNyYEFTcpHfGEA7cjigJ0XFY++KqTVWfx1gSjvx4EWMD
 QAJI+7YjPj8DWnzIBYcs/IoQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:52:21 -0700
IronPort-SDR: o0b1bshAo1ojvcaaY2cXEUQLQW4U3HNrFd0/XiGgMMnY5ebVHVzTYruFeQIkxFk5DIVGUirY6N
 gmrHenU2wc+RIgdEDK+ibYeRwUACmqT1TUdJVoe4/yJEl2zV4Il9gEJMcnsZn4Yn0ROgriwWxO
 8p32Oo9NpwS/cTv5WIZ9K76lvag4gdMo52hPnqE10fJ1fv35rLgPlwOzinrMzXDWlyk9T+kXb/
 7PDtXyi7OkYZuYqM5mxNz1MxY0iJgeQ3kP5PKYINIGT4TmbNNCxVTPd8QlU7hDMQCvuFTDApO0
 Rco=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:27:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqr3bJ1z1RwtC
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:27:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183224; x=1669775225; bh=nQOC0Pfd3xQkIpsrM2
        jqz2PO66oztnRmZbo1BOuXWN0=; b=lMFRxtgFdhAVjKuRBdggU+49SqLUb10GeD
        nAFhStOWn6RKqqt1NZAu2Cr4RfwBai04hr4Kbws+W/ObcsgdpCvbc6MwdWfnjppE
        a/1MP0JZhZVTGRXUJPUO++qbZOTVBAy4Eq52Dg7N2R5z/HVdDhcuAxT5D9E947Dj
        aP/yVLrzU1BEfderUbf+rMlnr1ISMwUaBY/6JuIMGPinQIlYxs8TVS6O0r5UEBPC
        HboRTvcR6Hw+7xtdl7RHbmEddZX9J+ZYNhXvduHWt4xrfbNmakJisOD1JROttzUU
        cNDdVX8F8Fjn70giP6RuHQLoHG5DJL5mdv7UWOFn88tWd7GyjnsQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uZ6_WxJHgO4K for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 19:27:04 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqq21Gfz1Rwt8;
        Sun, 30 Oct 2022 19:27:03 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 7/7] ata: libata: Enable fua support by default
Date:   Mon, 31 Oct 2022 11:26:42 +0900
Message-Id: <20221031022642.352794-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the default value of the fua module parameter to 1 to enable fua
support by default for all devices supporting it.

FUA support can be disabled for individual drives using the
force=3D[ID]nofua libata module argument.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 29042665c550..9e9ce1905992 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -127,9 +127,9 @@ int atapi_passthru16 =3D 1;
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
=20
-int libata_fua =3D 0;
+int libata_fua =3D 1;
 module_param_named(fua, libata_fua, int, 0444);
-MODULE_PARM_DESC(fua, "FUA support (0=3Doff [default], 1=3Don)");
+MODULE_PARM_DESC(fua, "FUA support (0=3Doff, 1=3Don [default])");
=20
 static int ata_ignore_hpa;
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
--=20
2.38.1

