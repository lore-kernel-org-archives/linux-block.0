Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66628C4167D
	for <linux-block@archiver.kernel.org>; Sat, 26 Nov 2022 02:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKZCz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Nov 2022 21:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiKZCzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 21:55:55 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069FB3FBAB
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 18:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669431354; x=1700967354;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=obceX2f5Sxu+pjiy8oau3D0HOka5C88c3XoxKn+7UWA=;
  b=YJTxla+K108Xk/OTiIJLk97vvFcHC/HnQiE2kor5OAxycRD+UfUxY93A
   qwTIX/RPC62EJH11AV0+uSgxM9SsEi//r534KeTLSZnWqByepnJcn2M0U
   1aJiB4jbUCjdG4bM1tZiKQ9hPpHsmlgbQHi55zdGLPB3JLn1Z662++F8M
   5sXQyIe9p0u5EX6oLKccKFTYrsopEz8a9TpUmToxFXrWX+IeRJ0VdSmzL
   aEhDUfxSBLcf8S1SxnG5JLn8g6GVHRjjwad9sf20W73aHhEbsu+tWRWmg
   Tw+XMSPdT/XpKToTArz4mZ1mUkB1riJjRtdZnZ1LsUOaA9jJP6c2BdMi6
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,194,1665417600"; 
   d="scan'208";a="222364191"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2022 10:55:54 +0800
IronPort-SDR: 4lGZznaWmxiqGVEzdWrq2CQvZSWDYR+LySfYeufkCgpoeSBiT+OD9hfBLg+AyJg9uJZfYn4ZBJ
 wZKzkjjyxuPYTCJSzDEONyOnrfEsyt5RkRXgds53TuS2vPU2h2x1wwcV0fY6VI7eUCYmI3cB8l
 iZBlXgajEDT08dig1BvkBL0tBk8bt2/7UuFKbXKe+WJSzCuOVbpl6lkLJXuLfNG3H9dkVX8xIE
 fWS6wqHyIclKZTwSXSlxVavPM9C8T2N8gbjNMzCZZtezenJXfbOCKtCA19wJG8wY9EhFyl9tzb
 mD0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 18:14:38 -0800
IronPort-SDR: 7V+QTA3B6INJajQ2jNZmGgmSETbDmzIIHqRpAaSNQ7TGvUjgU2UzSTb5fA6u423vk3hxNhD59t
 rPLdp8AET1hZZPLq3FmuhJyNaSIxJnycakD9QnoXZ9f53G/auiXXiA2OEKaYH2b4VD+AxdFiqi
 LhMvcuWjeh6gPwk4HAJdPK9N08GMQJQP8Xr32FDvo1JnwxD7Ug0YJpZ+lp6j2gAb09NByMHL3R
 PQaKbGfQ8PfFl49WHKbtI/y+G/Y6U5SvF5CCw6EkRmbbs92QAee5qjXeuIdHZSNx77jTbkVWZG
 Cdo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2022 18:55:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NJxF561xHz1RvTr
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 18:55:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1669431353; x=1672023354; bh=obceX2f5Sxu+pjiy8o
        au3D0HOka5C88c3XoxKn+7UWA=; b=UeYzopL+P7qj/3zyo8WTveFgVPvevcAS8b
        jxqlNg57ra9OaipQrSzT0p84avWgg+L0flK+QtohCzJ2bY/lvoTt+FX0XQzi1x/U
        rSKYD3mxKzb39FjXT6p0Z0JNgdZPqvyF1aaxvItK6ruPKsW0JXLUB/Vh8dmntj1p
        dPtqc0bgZQZV9QS0DMnQVwihLIC1gTvBnDMa0BiTMT+cPOwa0bkzFuhT/MgefIqv
        cpLQF1ggw7DvY5KwFgwoBG99w7vo5elwEXlYEjaB7Ws3nwblb8t5QWDcPdefvp43
        cX+qdsZ1JqvMvuQKvoLNNFT5JTsPd+ljgluNYvVB6PQG3sNSfWrw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n1vYJwLmq5T4 for <linux-block@vger.kernel.org>;
        Fri, 25 Nov 2022 18:55:53 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NJxF50m3dz1RvTp;
        Fri, 25 Nov 2022 18:55:52 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: mq-deadline: Rename deadline_is_seq_writes()
Date:   Sat, 26 Nov 2022 11:55:49 +0900
Message-Id: <20221126025550.967914-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename deadline_is_seq_writes() to deadline_is_seq_write() (remove the
"s" plural) to more correctly reflect the fact that this function tests
a single request, not multiple requests.

Fixes: 015d02f4853 ("block: mq-deadline: Do not break sequential write st=
reams to zoned HDDs")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/mq-deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6672f1bce379..f10c2a0d18d4 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -294,7 +294,7 @@ static inline int deadline_check_fifo(struct dd_per_p=
rio *per_prio,
 /*
  * Check if rq has a sequential request preceding it.
  */
-static bool deadline_is_seq_writes(struct deadline_data *dd, struct requ=
est *rq)
+static bool deadline_is_seq_write(struct deadline_data *dd, struct reque=
st *rq)
 {
 	struct request *prev =3D deadline_earlier_request(rq);
=20
@@ -353,7 +353,7 @@ deadline_fifo_request(struct deadline_data *dd, struc=
t dd_per_prio *per_prio,
 	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
 		if (blk_req_can_dispatch_to_zone(rq) &&
 		    (blk_queue_nonrot(rq->q) ||
-		     !deadline_is_seq_writes(dd, rq)))
+		     !deadline_is_seq_write(dd, rq)))
 			goto out;
 	}
 	rq =3D NULL;
--=20
2.38.1

