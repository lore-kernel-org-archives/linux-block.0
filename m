Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA52C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88153218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 03:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bUmv3ymH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AhvhVYj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAXDUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:20:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5440 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfAXDUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 22:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548300019; x=1579836019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wQVIxc0p8rTGHUEVRSKPvZ4VHqFuByp1NDeIHDkbLDw=;
  b=bUmv3ymHiPyYmduw50qoxws2bbAF+tPwvXPnype+h3f7B3qX3bII9Ltr
   psrxfwWEGFLubj7zdMOIfbvs+wiZ6G/RCA3QJn/X4xLm5WyRQxx2znq7q
   3K39A+Esj1qPCsFZW2i3NEv/G/rsvWGPfvNqVA9Iqj1Q7Pgoeq+kmTA+F
   FIeClMuMmyNllokaZqNEEEJwxKV8qH13dY7Gjtkc9kMfotECKUzshHUIj
   wfjcS/27bGkWFdR/BU6GEdtgWEbADOLpOOu/kaKcroDI2yBCEA6eeK3qF
   ob8tmWZ/GMTx0pNczAtXqqhvydzr3UgEBj7X0/7S+8jPfBUTcC1DqEIcL
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,514,1539619200"; 
   d="scan'208";a="204663280"
Received: from mail-sn1nam01lp2055.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.55])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2019 11:20:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWgb9wt+8FXAZekZwjM/cK2mOfX9haa1NVJOWlq8k0Y=;
 b=AhvhVYj2IaZuelPKeWcyU/hos9nP0+lUGRkkNjhMEGDxSUsHNmHfdlus4C7D37u1dk8BndenggE4qOs1tU/OrhXv6rA2SfbWXB1r554uRhXYWTG5U51BX9koADqrDOH0ykljtw6zE2TXd8snOs6L77KAeq+ryVq77b9kBOXGCVQ=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4295.namprd04.prod.outlook.com (20.176.251.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 03:20:15 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 03:20:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-wbt: Declare local functions static
Thread-Topic: [PATCH] blk-wbt: Declare local functions static
Thread-Index: AQHUs067TJNLkCRbHkOXlM853GN4LKW9wHtW
Date:   Thu, 24 Jan 2019 03:20:15 +0000
Message-ID: <BYAPR04MB45020134EE0069B0058CDB1E869A0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190123190557.118894-1-bvanassche@acm.org>
In-Reply-To: <20190123190557.118894-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [129.253.54.74]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4295;6:Bg4ft6whx9Nx1tZPY4nCjGng3O8arHhtWRUcAb2Vpjy+iPIP5B3ILaLE2gH5l4EBakfCP3qZOwdREO/R4MkwMgHTnHeKrxR/+1eSerf7c3gnhJ0eUK9foH4PmRb0GHIBKtKB4O8XYJrAzmnLjJHMthzL1e9BSXYdh8fxJrXUY4cw+vbKpqntQQ52RoDLFWUHKtDdicjTj373d8YVjNcntAvXX4LrkRW5inSFHrxXI0Ft42auFmcEQvvr6CuhmUMXxmsZy1TiUW36m4LgloN3hUklAZBtJ4ZQLIVKN/o2um1CGVMIZ5iOocsHTrtEIkZ04w6A+BDL3SgZSyLzS+OPkmdBtoiylthixfE0ZPMZuu1IvGbaS0F9qRuiO8mdzO/9+7F7tjhHWmOqZq4peSFtOnjfuVOXGtTIL/iuQH7/Waw8Sttw8iuaJeDCBBKkNWjq2mYFXANHe4EZ7M4K1rXJOw==;5:Rz08I6HnE9v5MNeHOCzZUxFOamMOsNWRheAq6W82mpYFS2ttzNlGu/PDJAkM7h4eoIi0lgPCwce1c2xNZ6c9OQXL/jwnr3Uxx/A/TyZUGZydkWxcV0bU3nbTkbKhv7zHkE9KusVS6cTUU4Fd2p/qPTaHI/BJ0OIwqaslcCGzanbE4wXNAPva6au9JpO9noW8IFqTZvkQTIDtEeOxkZ9obA==;7:QOruaj0US67AVVyaMMRrfhPYYnU9B6HMkYffJZ3WJvWvAVt2A3eSBfj7azbRCTX5vRVbBDyuf5CQp8GhgqMGrWoinJF5oTcCEeYI1Lx4/x2v5FhnffO/yziFX+4fHZFnTMYwyFFu+BjnR2dYj2I74g==
x-ms-office365-filtering-correlation-id: 73395e0d-165a-424e-a6d9-08d681aadc12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4295;
x-ms-traffictypediagnostic: BYAPR04MB4295:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB42956CCAA9C240C737F555E1869A0@BYAPR04MB4295.namprd04.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(68736007)(53936002)(6436002)(86362001)(9686003)(97736004)(55016002)(305945005)(186003)(81166006)(81156014)(229853002)(8936002)(74316002)(8676002)(71200400001)(7736002)(71190400001)(99286004)(26005)(6116002)(54906003)(3846002)(14454004)(14444005)(256004)(102836004)(72206003)(53546011)(25786009)(486006)(6506007)(478600001)(2906002)(110136005)(76176011)(106356001)(11346002)(446003)(476003)(66066001)(7696005)(105586002)(6246003)(33656002)(4326008)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4295;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LVNVInJK6Q8Ec2e2EjSER1cwp5fWtzq+xQ1Z9yNxRIlgYZyEB1B9R44EdoV3qLUCgjZJ++HhH02TDEfUENF1WPT2J7J6A4rMqVLbHIA494j+0BPGh3wCjWc2rKRfKkx6qFPisB83X2acbMIn6/O3D3pKKFLtfVsMRTmmCPGTIFwOlQiJvtPpiGAQsT2qhWvmgO0GV6nqEiqYpPYLyzNXPxI4l4WubxM5fmGz0pfinD0wJlKNOVV80rt6FxR1dkwa2Jbm1y2RYYgftDG7fG6g8EPL1dyABi/KqKpfINdRs31YO7CQK15S05Wa+qqGS70LhHzMU/jc50S1tstq9B9mBBQTSeBjnOxACwQLid8pHi81Gi/ugCGItu+U2+mpU2HK1DFwiV6mHs/dzlvnWemsI1jUS7l4NKAbnMhfykH5gLk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73395e0d-165a-424e-a6d9-08d681aadc12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 03:20:15.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4295
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Bart Van Assche <bvanassche@acm.org>
Sent: Wednesday, January 23, 2019 11:05 AM
To: Jens Axboe
Cc: linux-block@vger.kernel.org; Christoph Hellwig; Bart Van Assche
Subject: [PATCH] blk-wbt: Declare local functions static
=A0=20
=20
This patch avoids that sparse reports the following warnings:

=A0 CHECK=A0=A0 block/blk-wbt.c
block/blk-wbt.c:600:6: warning: symbol 'wbt_issue' was not declared. Should=
 it be static?
block/blk-wbt.c:620:6: warning: symbol 'wbt_requeue' was not declared. Shou=
ld it be static?
=A0 CC=A0=A0=A0=A0=A0 block/blk-wbt.o
block/blk-wbt.c:600:6: warning: no previous prototype for wbt_issue [-Wmiss=
ing-prototypes]
=A0void wbt_issue(struct rq_qos *rqos, struct request *rq)
=A0=A0=A0=A0=A0 ^~~~~~~~~
block/blk-wbt.c:620:6: warning: no previous prototype for wbt_requeue [-Wmi=
ssing-prototypes]
=A0void wbt_requeue(struct rq_qos *rqos, struct request *rq)
=A0=A0=A0=A0=A0 ^~~~~~~~~~~

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
=A0block/blk-wbt.c | 4 ++--
=A01 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index f0c56649775f..fd166fbb0f65 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -597,7 +597,7 @@ static void wbt_track(struct rq_qos *rqos, struct reque=
st *rq, struct bio *bio)
=A0=A0=A0=A0=A0=A0=A0=A0 rq->wbt_flags |=3D bio_to_wbt_flags(rwb, bio);
=A0}
=A0
-void wbt_issue(struct rq_qos *rqos, struct request *rq)
+static void wbt_issue(struct rq_qos *rqos, struct request *rq)
=A0{
=A0=A0=A0=A0=A0=A0=A0=A0 struct rq_wb *rwb =3D RQWB(rqos);
=A0
@@ -617,7 +617,7 @@ void wbt_issue(struct rq_qos *rqos, struct request *rq)
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0}
=A0
-void wbt_requeue(struct rq_qos *rqos, struct request *rq)
+static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
=A0{
=A0=A0=A0=A0=A0=A0=A0=A0 struct rq_wb *rwb =3D RQWB(rqos);
=A0=A0=A0=A0=A0=A0=A0=A0 if (!rwb_enabled(rwb))
--=20
2.20.1.321.g9e740568ce-goog

    =
