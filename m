Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65BC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 04:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F1C2184C
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 04:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WiO7ozyG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XoXe+hQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAXEyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:54:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6954 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAXEyy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 23:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548305693; x=1579841693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/4WydujFATMvPPAzf1nsOa/9oYLrAC+ovjeiBwJzy0=;
  b=WiO7ozyGdg3Bt8uJjqAUE+FpPrGmTaSciVk8T/YEGfIv5grgncec5Jqp
   AuQ224J3LW/JkXtg6mnmiQOPxvR9J3eKdLRkJmY1q032qr0wJee8jVeP5
   cdfPJL03iCC2SohoRQyAawnojKTRTFQMBLm4Tz3yGT9I+B+ZMwVVgfMG9
   pqx4vErZ0qVxnQeKoD/lNsPMjqfuoeyowtNWPSpk01WIO3e9lRCe1BQrm
   /kZvz/s+YbdSL2k6ARViopeC3TOfgheDdVne/nGqiCJ48pwKrk0fYyY/R
   tD4YHs8gzzJOP7juUFNb5ojHoZEMTmoMAR/IYnzP8d5ID7sS45cu99SP/
   A==;
X-IronPort-AV: E=Sophos;i="5.56,514,1539619200"; 
   d="scan'208";a="204671461"
Received: from mail-dm3nam03lp2059.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.59])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2019 12:54:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzT3FSLA4c2Xo+7y1M816Qk2Icrt4fTPBkSmS9WZ9xk=;
 b=XoXe+hQuag9xnYaN8I+TiOzmIDzvirXj0KSRbP09WPg1NscNOJP++wkYI5Wd24MUhOhbIXibp4yBaNO73CcVyn9R/yeD0CEELDfGljbCAci6OQi9O72/vMB/dPDImxnoppjFqnilMgTbyi2zUiwMhHhekaEiYdFKICXR208u3fE=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB3816.namprd04.prod.outlook.com (52.135.214.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Thu, 24 Jan 2019 04:54:50 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 04:54:50 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
CC:     "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Mark expected switch fall-throughs
Thread-Topic: [PATCH] block: Mark expected switch fall-throughs
Thread-Index: AQHUsuoFjWyyp8Xb9EOkuBzalsBaFKW9242U
Date:   Thu, 24 Jan 2019 04:54:50 +0000
Message-ID: <BYAPR04MB45022D08A83F69712FEC0D95869A0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190123064501.GA26147@embeddedor>
In-Reply-To: <20190123064501.GA26147@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [129.253.54.74]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB3816;6:yiFIGGMliv3rZ6dZOgsvSLe6enj3+UjUXfdm1Dn4XTb6EEhzHB5OIgHA6ARw8iigtlbD7mzZwKqlprTYYAz9QtZjcdWN9KeTdoY3epEAmhzLxI8oH4axAyA9vhbgmgkVbt9zW4IY8roAStxPeFXb1+NslFRaG3luXXJdLsd6NNFp2X9FlIebuj6Rn7eWsdJqSWjmVVCowCwuakM55dpbiswMCmXZxwF3dW3H7tfJAclssCki6gyapDS96t6O+cZYyTogNe4KhaI0/jb9GPj+HGdxFxzamJRdPmAcr10Jl1lRN30QKgj5LL6h/QbAPxGA39Uucu2uh2hXc400HygfbaoDp8ffxw2jrTLSereJd2giPsFFOOhI03guPo2EsapF5gKJLBppYQ+j9YK6yy/YC58lETtj+b304SnpRHdL1sSi6uVjry+URlFUyrLTgwZsLBlMQbJWHbuMJ/1ziN2VLQ==;5:PyruSWH7X04FIXofW5pbwwABsnrtwWuVWOlCcuNatHvXE1hBxTsjy8gjWLQxeOFOe9vkgEqiA6yXtkLc7XdzsOvLcIDB5R6C53u/XA7/u/b2XT9hxwtmjtafed412RZiosKjSPKXWmRdf/azMJM2i8467rj22OryAIiuOVuuuAP9O+vZ2pXPuuUCRHTzHyMLax15vtwYTCGi4aAFTgcvmA==;7:CVsLbrqwxbDJUfFE7WLyViv9KXvSNrAnwtxo0N7jvX/NNjH3wJTrKhJr2F8C2OniFziMm4kqWkoeKHKmZ3v/rp0U1fRDu5ZggS8vuoYgnwTPztVSnAqg/g/tBp6Qbi1MGtBxtPkVM5JhE3CXdBkgOg==
x-ms-office365-filtering-correlation-id: 91e782f4-b17c-4786-5b34-08d681b8126b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB3816;
x-ms-traffictypediagnostic: BYAPR04MB3816:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB381626957067252AE2A33CA1869A0@BYAPR04MB3816.namprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(8676002)(3846002)(71190400001)(71200400001)(25786009)(229853002)(106356001)(68736007)(105586002)(102836004)(33656002)(66066001)(2906002)(5024004)(256004)(6436002)(14444005)(6116002)(14454004)(72206003)(4326008)(6246003)(478600001)(316002)(55016002)(110136005)(26005)(53936002)(486006)(305945005)(7736002)(7696005)(9686003)(99286004)(8936002)(76176011)(6506007)(74316002)(186003)(53546011)(86362001)(11346002)(81166006)(81156014)(476003)(54906003)(97736004)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3816;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: og33TqZEl9ZDxmyL7s5nJc8yZiN1hrZ8KFgNEuPaEGRel9RJ+YjQM0vyFF1AqzCArRmpDKbUCCbEpuKpuBBRZtKKMQ420KxnCqi3JIXAiF3VjPc1zMpLfKgGPCoM4ZeadCrkpXP7lkWO2BLsQBq1ZUXt3jEys7QFPuuPSlmJhQCEot9B0zph2MqHOD7QBIRlxJrCh3+dZJCVt33fZluCZvqjo+0/qqbMrpV8MpDhD7QjxzMexEh+34asvb9SPW8fhVyXLeCO9+06jZC+BO8rcJg12foOwiv4KtyJSihFP2qLCWJA6j8U2+t04u2MjNcvYtzkTCmt2sePEkmB2MY54ILnJh/2T6qUJBJCIhZ0eT+Gk4LAT+YybbKBpALzqf/KayDg0Wg43oMwBF0bobZbujDOmxXQDDQ7NwPyCfugsuQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e782f4-b17c-4786-5b34-08d681b8126b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 04:54:50.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3816
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>




From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Gustavo A. R. Silva <gustavo@embeddedor.com>
Sent: Tuesday, January 22, 2019 10:45 PM
To: Philipp Reisner; Lars Ellenberg; Jens Axboe; Joshua Morris; Philip Kell=
eher
Cc: drbd-dev@lists.linbit.com; linux-block@vger.kernel.org; linux-kernel@vg=
er.kernel.org; Gustavo A. R. Silva
Subject: [PATCH] block: Mark expected switch fall-throughs
=A0=20
=20
In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_int.h:1774:6: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_receiver.c:3093:6: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_receiver.c:3120:6: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]
drivers/block/drbd/drbd_req.c:856:6: warning: this statement may fall throu=
gh [-Wimplicit-fallthrough=3D]

Warning level 3 was used: -Wimplicit-fallthrough=3D3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
=A0drivers/block/drbd/drbd_int.h=A0=A0=A0=A0=A0 | 2 +-
=A0drivers/block/drbd/drbd_receiver.c | 4 ++--
=A0drivers/block/drbd/drbd_req.c=A0=A0=A0=A0=A0 | 2 +-
=A0drivers/block/rsxx/core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
=A04 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 000a2f4c0e92..f070f7200fc0 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1778,7 +1778,7 @@ static inline void __drbd_chk_io_error_(struct drbd_d=
evice *device,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 _drbd_set_state(_NS(device, disk, D_INCONSISTENT), CS=
_HARD, NULL);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* NOTE fall through for DRBD_M=
ETA_IO_ERROR or DRBD_FORCE_DETACH */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* fall through - for DRBD_META=
_IO_ERROR or DRBD_FORCE_DETACH */
=A0=A0=A0=A0=A0=A0=A0=A0 case EP_DETACH:
=A0=A0=A0=A0=A0=A0=A0=A0 case EP_CALL_HELPER:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Remember whether we saw=
 a READ or WRITE error.
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_r=
eceiver.c
index c7ad88d91a09..74350663443f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3094,7 +3094,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_devic=
e *peer_device) __must_hold
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv=
 =3D=A0 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Else fall through to one of =
the other strategies... */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Else fall through - to one o=
f the other strategies... */
=A0=A0=A0=A0=A0=A0=A0=A0 case ASB_DISCARD_OLDER_PRI:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (self =3D=3D 0 && peer =
=3D=3D 1) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv=
 =3D 1;
@@ -3119,7 +3119,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_devic=
e *peer_device) __must_hold
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (after_sb_0p =3D=3D ASB=
_DISCARD_ZERO_CHG)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else: fall through */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else, fall through */
=A0=A0=A0=A0=A0=A0=A0=A0 case ASB_DISCARD_LEAST_CHG:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=A0=A0=A0=A0=A0 (ch_self=
 < ch_peer)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv=
 =3D -1;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 643a04af213b..3809c7e6be8c 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -866,7 +866,7 @@ int __req_mod(struct drbd_request *req, enum drbd_req_e=
vent what,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } =
/* else: FIXME can this happen? */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 br=
eak;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else, fall through to BARRIE=
R_ACKED */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* else, fall through - to BARR=
IER_ACKED */
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 case BARRIER_ACKED:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* barrier ack for READ re=
quests does not make sense */
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 0cf4509d575c..898d522e8338 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -439,6 +439,7 @@ static void card_state_change(struct rsxx_cardinfo *car=
d,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Fall through so the D=
MA devices can be attached and
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the user can attempt =
to pull off their data.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* fall through */
=A0=A0=A0=A0=A0=A0=A0=A0 case CARD_STATE_GOOD:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st =3D rsxx_get_card_size8=
(card, &card->size8);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st)
--=20
2.20.1

    =
