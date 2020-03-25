Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E0C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 04:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D532070A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 04:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vc34o7qb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zi6m8RzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgCYEba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 00:31:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64337 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYEba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 00:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585110691; x=1616646691;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JU077TxlsEZ6p2AuTMF8uQYwC+QY6Xp9POwbcBTU0hY=;
  b=Vc34o7qbRqldqHyHmF1n+2+ZXzL9Dg8RqKUlz2gJ5DOKvs8Wo03XapVb
   O28WeVmmliize5PiopVLNI92oL/KF1a5wv6OPKRHQK5EUjegffk6HKQBR
   agNlTZfvMGFnNYJgSvz3gHXycisxbjDspJnJUpx/soCQcRoIHAZv1nFGg
   ydUo0w3Tr9yMhRYfk8dwFAWa9s70XtmBqTP0YpkqrHuCc+LxJIzIeDYB4
   ESzD5P7XN5ZoY16miMgOku3ijowB0Q1ManMwYXorXC0+tlnlepPBPP/7c
   dUi80lD+zw0OmdWmV7aKOudOjUC0lt3ztSM76wUevUh/+V56R9lyCd1zT
   Q==;
IronPort-SDR: Vi6RGr9AM+FhzQtAel/bkpzaoD2QNZyNLO5mR34An6wHtAF9TQq/7UOulKv1YG5cBSI4V/LJCQ
 Pb7VXrmRY1c03KGLDwiPoQio0PooE9TdWjhN+1u/doEhJ80rUe25BLCoaDw9/OxgHb1mPKbRkL
 BRi9N1VsGjvbF6dnJG6/KI9z5jCEYnmvRgHcX6S0dzbnRAUH0AJZb5keYE5dn5py2p7KgsuuB+
 lunRmeDChkaVCAqNLd0ko7/R0rdoJF2bqGwj25I6oYDv7JaxjWrGWhls/WWlVwK5UMqVQl6kNk
 jTg=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="134878396"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 12:31:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHNrw5aCLr7J1dBO2Gc7EayeDczQuflUieAyoLlgothqzg3jHqQimhvkRVM2EvfeQmapBFRaG98/0t+BAsisCaFzrHW9D78rmjItzerh3cL7WckjcHvtS/3dnlPLobszEWGCoY6CTXj0e1UNnDiKIlTM147KWa37pMbtO6B/YKUlGoDMGEYYJ5Z2GUMnwwqoSV2DvFwundGy0XT5nE7jrh/P5Ukplw1PSxAEFJ27EPLzV934XjbkZvhagNhg4x4jkn0g12JqioMea1+H9tV1LkZ+0KRoEvu83N9ZUy81OT2zpzl+HGD6BDJpHeCu2rGkogPWNccXmRq0QrWBSHK/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOwtzufthv+ms+lJaTM1v95GtJPEgX1PIGlHM0gQ4gA=;
 b=avTohotGFAe9evW1TIZ0LTeCQ9S0HTc1o1Set/WZfMouqXQU31N800U+CAWx4Sh5zIYKYUFKmlJixdMu2eeuAyYTsYGarr+UWfbUK2rYM0KrzWcw5ioCdQd9EF7w9PaeZ82T9IozsLOPf5N6ET4PkJl41VtQ1Na0mTNEinPbcygCH6aQBBs5qBjjSQFmQVcFPALfVZKvZ//RWhw/LRUJ5gc1ZS3RnuDXGCguVXSSv3A3wpERUIcguOi3IRlcgMqdIFWrUCFQ/WKQTJ0szQxHQTtSoNHDghzaFNaitG4F54ojuLsO9sOQbC9EFdjX7VnKT4nM+hwFio/VDD0C85qGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOwtzufthv+ms+lJaTM1v95GtJPEgX1PIGlHM0gQ4gA=;
 b=zi6m8RzVENKayw4IGoNwQUfDTCId6ZqyLrktFIuIzDlHr/wYU3ihr3BxyUh6O5uh0CUhMEfRyPDdY6y1FTETdYfTPltCD9TgxyDgYqSzYEa5q/fjlPuvKyKupvrm3RuAKYx8RMVUzcq1M5O0ve8avVOPsqxDf0ABo5GOw7isr5Y=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4837.namprd04.prod.outlook.com (2603:10b6:a03:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Wed, 25 Mar
 2020 04:31:28 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 04:31:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V3 1/3] block: add a zone condition debug helper
Thread-Topic: [PATCH V3 1/3] block: add a zone condition debug helper
Thread-Index: AQHWAlSDX61q9Qt9oUaGMFIm/s6SXQ==
Date:   Wed, 25 Mar 2020 04:31:28 +0000
Message-ID: <BYAPR04MB49659AFBB6519B9E9ABC51E186CE0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <20200325021629.15103-2-chaitanya.kulkarni@wdc.com>
 <CO2PR04MB2343C3B9DF774E6A6F052EC0E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d056e98b-5ade-4312-75ab-08d7d07562b1
x-ms-traffictypediagnostic: BYAPR04MB4837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB483776BBFF1186FF57EE77A686CE0@BYAPR04MB4837.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(7696005)(9686003)(110136005)(52536014)(4326008)(33656002)(53546011)(6506007)(2906002)(5660300002)(55016002)(66446008)(81156014)(8936002)(64756008)(66946007)(81166006)(186003)(66476007)(8676002)(71200400001)(66556008)(86362001)(26005)(478600001)(76116006)(316002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4837;H:BYAPR04MB4965.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2kt4M6wX30OZ3jfLHuZMqk/fDFpFoX+YgOLa4VYX9qJdaX3Y8z9RZaS1wYdSXG4lgZ4NC9U4xAgtYNHFlJb+SBiMH2HdRfdXV8FzVah3auUYWyCT34Kq2LDihN7XF7Hu2ibqvmtz3mZq5Hxnfdw6u6jBpubaZk30uTcOSIGTOzoT0KpR9CtZqJGFHe+YFDVVNKZumlmdbIoeBMiUhnP7dtmcCCWdgBv0QWigBHaXwKWeruRvK7w0MK19CgeTYzrayFNugiicNQgcOa76E3RVRjAkiY13dcHsGhnH6IHXWHSCk3CteUcobZnj87xaEUjQwYHhZ1EtTKpxb5/E433mmIaeNKdxxZ5LForfw/bDFraVdTSmn69k96uOwMPykenfhiHPxxbRBDXI+ZGivNk375Xg+UNbXhrtVQPw7PxY8lG/hvHpagzQF42AdmKLsCScaPBwg0UadVeP1sB2RYfjFkTyQDEqW9Eg/oJFaYMRWN9LQ6IASxa+tehIyxjJuFl
x-ms-exchange-antispam-messagedata: 74uka00tNR4wV+h+TmETpfuoxYzNstsuWU7NGkTzInXiDwWI6+Ogb0jfzbBdHPeQN6NzdaNZ+eyds9Z8XMu3QtwOGJD+eDC4fMe5LMzVazmdbnympgn6lRj6HZ+Aqm2WQbFgfG0GB+mwCOSG1zEvYw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d056e98b-5ade-4312-75ab-08d7d07562b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 04:31:28.0383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LCTzRSxAllouJaXdxEwyVSTBoErlnewXWHjyIKfmxACpyuDCbXpjCuFIf+2hEw3vLFxwuIS/dJiP6+GtXqpywhXCBWLH9xWR0FsPpKl6SMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4837
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/24/2020 08:27 PM, Damien Le Moal wrote:=0A=
>>   {=0A=
>> >diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>> >index 53a1325efbc3..0070f26b9579 100644=0A=
>> >--- a/include/linux/blkdev.h=0A=
>> >+++ b/include/linux/blkdev.h=0A=
>> >@@ -887,6 +887,9 @@ extern void blk_execute_rq_nowait(struct request_qu=
eue *, struct gendisk *,=0A=
>> >  /* Helper to convert REQ_OP_XXX to its string format XXX */=0A=
>> >  extern const char *blk_op_str(unsigned int op);=0A=
>> >=0A=
>> >+/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */=0A=
>> >+extern const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);=0A=
>> >+=0A=
> I do not think that the extern is needed here. And I think that this decl=
aration=0A=
> should go under #ifdef CONFIG_BLK_DEV_ZONED since its code is compiled on=
ly if=0A=
> that config option is enabled.=0A=
>=0A=
=0A=
Are you suggesting like following ?=0A=
=0A=
+#ifdef CONFIG_BLK_DEV_ZONED=0A=
+/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */=0A=
+const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);=0A=
+#endif /* CONFIG_BLK_DEV_ZONED */=0A=
+=0A=
=0A=
