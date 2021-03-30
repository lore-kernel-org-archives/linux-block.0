Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB0C433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE4C619C0
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhC3X47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:56:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29639 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhC3X4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617148606; x=1648684606;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Nmy5qOYOwLisITNwc0XM34a5fXvuNPGdV34vPxh9aR8=;
  b=I4BJgU6LSiO1ZsO9aCO0UoYUpaIrjGWp8voRDaIVCyDkBXCZQBMMV1Ik
   mMMB3XaAy/cjoy5u9SWF1m39ns++7YfsfgHDA048Fz/Hx0ihrmdQQmvIZ
   wYW5EL9HtUnmCNKfK7bkKT+UphbI6bzqHdnWjuFvilP5NiYgl8cdfdiiY
   IwCMu9I9Kqol9e8s+4vfQ4Cmpd7YYLQd+ak9fmcm243KV3TsIt1n/7+P9
   FUUA11Hwl5/SJ8Q9ZPSXRqVG5CGlSCMtjifHTKq2Zy5qR1vXhUgGiywj0
   gHu/9Y6WB7xMqKPsvAYLpIKs1dyw8dD9tQE9v0wThYXszd2bMz1dViwb9
   Q==;
IronPort-SDR: maCmA0q7DwAzLGl4WfTQNyXtLiVN26rjYakyWwajWz05c5YYj3qMlssKbGMBSw+2uEeiuxubsq
 p/DUMiMMg7CBgQ2t/5s0xgxkeDjf9yg9iQL1uk99VPFVt6j51/S3KKOFuB35uxQoUjTTbw51qJ
 w/WDH23T9OKFHyHlty9A1825YchM4rB6nLWiBfWU56BRSqmESO5wvhCuVLzD+JyTjvs0ejGG/i
 gjr+F/JSuU1SGgmpVDRw+Ofb6JNHb90SfFi3PN3f0WmnYOfwwL5LwgTmRk2HN3j62BJqNrS6x7
 0Ac=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="167868820"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:56:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6tW4F2PFMXMxJrBnf3pYMvBVETm+aCxums1q1KO8R9OkWlQxbkIUsY6L9cPSiMLo1OfyagMoDMzjerGfn+iEJzry+f3N8cOcThzg8HSoi1SPA6Oar5ju1Hr8Tx7A/LBOmu8tKjys73KjGmWTp291k2ZTy0ydvodeaEGJV5iHKl2f2ZyTbL7FFDvqCc3zy+9UdorDkAnturMsEYTbeRtBXvsZkeVz6u54vCret7Q341zxwez4M1GwElwto0AGBhyljKo2Xf/ibAAIJUNeTRY5nFPf2zf5sJBaxSNP9Zd2R8bAvq2lHl8WCK8KQ7Z8NxSFP96jsjZqD1xzSSdVvJVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmy5qOYOwLisITNwc0XM34a5fXvuNPGdV34vPxh9aR8=;
 b=KrjalYlRJuS4ri0LI4SN0QfOVoowXK8OCRoBANbk72BbliQtFb3l+WUN9QEHGrH3GJoDQS/OFUjPQ+2JSk2kZrHOT/zPBMcc06JpgngBdn+NTB/yW5lb05LjOYxDRg1NNm+mRmc95Ob8XvRkiOKyQndv+ad9dnWKaQ79RAn95hJ8I3dznCR71wpV2zg7H3wJqR0TsayQIA+V/hfAOXdepLBkyYhU/0lPzLOQYrSd0SDbyL/DJwG8QRd4RTbx1VwqBG9qO2tkIhrYyHAzQwawXyhw72D/1MyUVu8EZqbn2z1hATII1g72fk04o6PeQ824kbCnzgsNW+Iw+MtoZ6/44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmy5qOYOwLisITNwc0XM34a5fXvuNPGdV34vPxh9aR8=;
 b=ca8YckJ+XMzmmWij5R0kKO0fTw9rG6doZDaJiZYuf7hATvu7dIt9hmp33OyN3akxAW7Z2vs9DynmWPYuAd0DFyt4TRi380ORgFJVlnLnVrD6Bti+wygwql+qI167gImznioqc5B8wcr4gmFE93PJ32PCnuRJb+w40lW1QgknW48=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6424.namprd04.prod.outlook.com (2603:10b6:a03:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 23:56:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:56:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Subject: Re: [PATCHv2 for-next 12/24] block/rnbd: Kill destroy_device_cb
Thread-Topic: [PATCHv2 for-next 12/24] block/rnbd: Kill destroy_device_cb
Thread-Index: AQHXJTfWvI5F4guvqU2BVRe/M3uQnA==
Date:   Tue, 30 Mar 2021 23:56:43 +0000
Message-ID: <BYAPR04MB4965EF24D9AA1756D9012899867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-13-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97f7c847-85d5-411a-7318-08d8f3d778a3
x-ms-traffictypediagnostic: BY5PR04MB6424:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB642417B24C64238D3D0C53A1867D9@BY5PR04MB6424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+1scJFcSKCckynNQ72z9H6MayYRH+i7xFxqMd3PTvSFIDODJgXZzYb2k6beXcG7V5bOdthHCesL8MXDYBy4E3NzUUlT314OSEj6z+emDJpuEINe6F6I8zoHGAyVvbkErtkgUffDACvnBy+PtsqrqyPSnvsxsRzXXCKQcFsI4S7lx74V+2OO1szQnWJn6zdhXMy5vkd8KfDUamFSvPE1TSPKwuuSVpuexguDJ9YHw2yA1kaGD2ASqC0eWlfUlvo1LPb9gWalcxUy3OT6GmmsYeAbHnSOv9uUPn5hSZnMOpCnKMjKp/GsbsbTBBvqQLjnI6rDSLDQ7z5DvicHkSjQZshykvr/zpt4uQHrIdwv1k/BUHYppLleUkakRrc8wnSpXjLZ8ZFGrWhWkwXGX21aGsYWGSlB6fJioIL4hkJ1jrSupu93/Y6UI9Vxw6iVnRCDwRI8/XjXXMsSq5f2cDE/YnQEWjevcz/dmDOmvY1FIIGZM3C5fgAfTtZGugldTNxITGQeH4ZZz+TAFCiisjYHakESPD0hbFoaGhvkcYGv7WrwJLIeE6wZ/er0AlGSl3TLCWN3Y5Bdv794lk82E7HdFL7yPrQMAhjAWEMxe7tVOrsnBlrgjogkY+Zd8PMUSu6gCFARg3m8HnnTX6QBkk450ojVi8FxB6gNMOG/8d2UkHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(478600001)(2906002)(5660300002)(110136005)(7696005)(38100700001)(7416002)(66446008)(4744005)(6506007)(71200400001)(186003)(9686003)(8936002)(54906003)(55016002)(76116006)(66556008)(33656002)(26005)(66476007)(64756008)(8676002)(316002)(86362001)(66946007)(4326008)(52536014)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f5qPC+r2/Lm4YwLkofwcKVXOuFtmtl1dv1rfwlqexw/lniP6i3MzC+MpKqkp?=
 =?us-ascii?Q?xGgtzIawv3O6DcJJFfq5O8Nu51lJDAVDL7k3QFwpSpz9kVyUojNo+yD3uNf/?=
 =?us-ascii?Q?joOGMlOKSnXYMuyeLp90AcRxPObYGEaDuxXsUqvwPQ+g3eW5l3SBOsbuytpn?=
 =?us-ascii?Q?hoWkkiqBKHrnC36vgCp6ogahheXArhvppsqg/o/oSmLihPX4SC1uDSvqDEz8?=
 =?us-ascii?Q?A5ZF645azaXjcpCZDS1iG7lh61AhR8lrhqUVj3ISBcG4agC+iM9w54M6dsto?=
 =?us-ascii?Q?PzsHbq6xqqx72Vx0XNyxL2GouyQZZ49/hgsnsfzSH1wXTM0JEpOkwUrKku3a?=
 =?us-ascii?Q?u06bl5tMY8FqGjpj2FmFye2mxZIi77j+6kxGBq+EFJ2nPW+7ovCpL2s0k9F3?=
 =?us-ascii?Q?ou79KByAUT8Aw5H16Q862R/JGHnEBuZ6lVH9GF7jeoxLJV51kjP+TMhXmvQl?=
 =?us-ascii?Q?E/MwZ5mneMjEm8GP5L4M27pSyVp86Wa5pwArTiBao9o/jeiKyTqb7bnoGN3P?=
 =?us-ascii?Q?Sh6jGiNWHeR0qWVOFXzmY9kCiMkNaAlsHZl9G/EzXRe/wrxKpWsZ7tOooMYl?=
 =?us-ascii?Q?NKcuheiULkS6PPMfeDw8JCV2YjWjd5PFBLtvqlfrQ2wYNpxAhMI2KLJo6ccW?=
 =?us-ascii?Q?vo6JkIcChtY2+w8rbzHJS3fTycEb5D+HDkLOqu0aQfz/7DHIHBeJlZpjhms/?=
 =?us-ascii?Q?aBnFY8mQ33rqveQpZ6JTs1F6sZW03NwUowpZ6+Ii2I6QN9ki2Xai0v6DvPSA?=
 =?us-ascii?Q?ShjIVMA+iS3fcK443qtY85EHQReUf7xwy3bmLB+QmVZfPaFlJ0O2Qj7h5QxT?=
 =?us-ascii?Q?nlDaf5KBbxaGuuyqF8Yelhs9UVFgaxuJEpRAmEcWA7lQyrUK6c2vZncyO0x+?=
 =?us-ascii?Q?or/Yem4+wRfOIy6lDPH+F51005sa7ayCy23kYhLxytbB+U1pAHhdDClQj8rR?=
 =?us-ascii?Q?U01cAwIIxcLNPvndL1DZ0Y6ZiXj5bW7NgbTLyRyjSu2ntjbUM/iLQ8DNG32y?=
 =?us-ascii?Q?SRIzCvqEOdJXD1b01/VmGhPOtFzupKxW7fnZPQ5ES4A1/xA78c9M/v1mGuLN?=
 =?us-ascii?Q?amBcdGVwZLgdRLyePXCdgOc5f00aGZsVsP//sK7qojHbpUSbXHQLlnezCXz6?=
 =?us-ascii?Q?T1N8ep3+AJl8beYeN8r7GcT10juyLkJUihHiVNhmDbqAItP+Db20W35C5G2O?=
 =?us-ascii?Q?Jt3Qy/WE3dhgyPB3TXHN6YqR34AoqTib7FyLrHeh9v/UJOQiXxoXRjiYXDSu?=
 =?us-ascii?Q?S21qQS34PTPa7ILNGPkT7jJjjSCFiApabomK0ecQyucrs5cgivfVHCXJDK0q?=
 =?us-ascii?Q?y7ljCVzy8cJb3rDJmD6QAy1lvpRwWnpt47qMaRAKoBMqKA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f7c847-85d5-411a-7318-08d8f3d778a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:56:43.7083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjnutLxTiUZNuaiA9iMs2JQncL6PthH95OtQnGDWHujfUDpu76K/oo636tjONH8l/yqRsqPJFv/AnkzXwoy0D3evR4qAEdCGqrq5RRWUi6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6424
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/21 00:39, Gioh Kim wrote:=0A=
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>=0A=
>=0A=
> We can use destroy_device directly since destroy_device_cb is just the=0A=
> wrapper of destroy_device.=0A=
>=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>=0A=
> Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
