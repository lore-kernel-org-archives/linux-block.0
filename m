Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7EDC74A44
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 04:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCNELN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 00:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCNELL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 00:11:11 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C48FBC9
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 21:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678767070; x=1710303070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Vxyv6e16ecuPVMwsufa+DWGPM1Q5EShSS7rRYrh8yI=;
  b=n4sNaKSQpkXzQSD6U6lPqS1K73WLSPh7me1RQNuPlD7BDxQs8beVx6+T
   Xu10GinVn8R6GwZv2PgJrkOqKdoHqwPpGNdHbPWsXEsqXBnwviu1AM0/m
   Uz2axt3HXHb6xBz8YHEyMZQh4HcBOnXhNY9u2TWW8f8+w9Cr56M4VMGW5
   iNGQuJ+gaQGWv/77YRDFQqLL24c1XBz3JjXb+cvL+fUmZD3cl01GfvwaC
   khPWQuaNKzt0qbLM5ys/Vqnkr6LDDHoY+XaKngRPkRJnnBtQEhecJ28lo
   KinSHH/lQIBgOiiFZvSCM9vsvnpBtnlyT6qooPaYo//Sfk857/5tYLk3R
   w==;
X-IronPort-AV: E=Sophos;i="5.98,258,1673884800"; 
   d="scan'208";a="225349842"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 12:11:09 +0800
IronPort-SDR: IwQ+T+QWj0AolmeeZPxqzfKsFheqRBu/6YN63EYZ6Vy0i0lpMrnCMDYDCJ17fKh9sPfj+49qkN
 kOHkA8UbOGrLlPR1i1zFCsd8zAcZyO+cu+t0nrwxOJT5w1hS46z9XQcwoRWHmooWmkVOqFSvoK
 UmfQoM6PLuTeenMnubWaROXg7n467j6/OQHj58dK4eHOdCjN0yncbG266tkQzr5WQTDJCsS3Dv
 Oq3QkAXZZrjmDVqA1HNeEIPQkdqtmeIxb0UaDub/Nd0WFQNTTxSDFcMvLVVH/QXoUphaffUL+d
 4Us=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 20:27:38 -0700
IronPort-SDR: sXxgeeI36We15CIIVZ9c/KUsAmPUL9gF8qT9movtp+L+ZFvzzgSnhQNyOOAjp8QWRrwMrCVPQu
 wXOV6NAxJgDYEeiYBoGkUaEBQdzxCHaM+V+kEDb0W5cv3HVevczj7DclgjdMc/u6KszCJIa5dJ
 DF2rfmlr7Nvwy/pc43eyarzH1CB96seYA2wmI8ifo0JlhmI9QqdpcWHENKisHk4MUcQRUWjAt+
 62rgCJ1VUAl1VtVNjkhgz0rdZY4bxyAXBZ04gsJl8v2A/X5Jftw4ZaW9jSAOQ86MFFtYYnc8wn
 QiU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 21:11:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbKp54qVCz1RtVt
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 21:11:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1678767069;
         x=1681359070; bh=3Vxyv6e16ecuPVMwsufa+DWGPM1Q5EShSS7rRYrh8yI=; b=
        mS7m3FPMhVheGmcu0v7ADgicmznoxVS5N9P43yN4kU5Jvoyn66mGmsh6Y7HxgEUF
        tYFfVIr+ZCoSAtlnvunm5vTskZtwsv98hdvRPhMZaAVCFh/Ta2JGV7VfpZz/mxTA
        amYeZzezAvUZQwg30wDQ7VJVOICQZY56pH/39N16ZmgWx7R29akqpW2EhSzWx8z4
        95sf2gZ1b4NaIMuncF36V5qkast+uixcxXYLi1sf/JFrAVRtTDLEb32mx8ROafg3
        C0R0Jd5ycMMlOayLCi6e4B+PnKvY9LDdw9PEhFuMkmCXI2LXR968TaDpPntjHzyS
        meP1r6SxVY9/SUvdv8saJQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h5NRfWT8Y9EQ for <linux-block@vger.kernel.org>;
        Mon, 13 Mar 2023 21:11:09 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbKp44Qv2z1RtVm;
        Mon, 13 Mar 2023 21:11:08 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 0/2] null_blk fix and cleanup
Date:   Tue, 14 Mar 2023 13:11:04 +0900
Message-Id: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 1 is the rewritten fix from Akinobu to correct handling of fake
timeouts. The second patch is a small cleanup of the null_queue_rq()
function without any functional change.

Damien Le Moal (2):
  block: null_blk: Fix handling of fake timeout request
  block: null_blk: cleanup null_queue_rq()

 drivers/block/null_blk/main.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

--=20
2.39.2

