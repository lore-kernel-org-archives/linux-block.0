Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24877C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7969206A1
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pcXfEME7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="owMVR9Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGAH0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:26:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14511 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgGAH0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 03:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593588381; x=1625124381;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=joDokeBb6LFsn2QLUINrc+gBSRXFd9dkYOVtgfPM2w0=;
  b=pcXfEME7wD9neDHxDlgccfNJS4x7qsQ2WaRWmHo7d/1hIq1SXvk2NvBe
   4Mn9N+vShjtRwhRuwMFc4H3EU6QS1om6Z60/WH6matLKb0k7zGblYeBfO
   sFj9o5mf4b+pssZ99rVkUMfU1Wr3+pJLmGqIeiPUpeGZGmGnBKwUNQ753
   2tT+lwUqOPyBnP+I20wrmVZPNSWxjIxMt6wh/UCLr9nt31Gmb0vewTcOp
   btuti7zvgmhqoIZrHMJcSHmqLNqWv/X61WAoBYB4eVCY1DPYtfI+fHzJO
   qXrsi3y6aNSTKJh8Gw6oYULl/ojeJTL+7KbWxZLb4VAbQx6yWMyRpDTZ0
   Q==;
IronPort-SDR: 8oXO2prkNdEPdOMoy2gFm/FpKe06UBKRkgZgOoI442100kGH0/YJ7epNpH+wwUexdfDwj19+OA
 yMPxzr+Cl9etqXcy8+x5tAUaC3KGXuK0UJlBd2cFfG7EPhs/OIYcUSmF0bsoHYtTLoNd57Hs79
 acboHGSO0Xr1+U8Ku/Nz2/DdLhArLHrwGkVMlZoJw+q0gRvzcKTFUDA3FpAvstULO615ZuP4WY
 ntz/nn7Ekzq+1+YZeMuHy3pFgsKwmJYWY/4yN0g3J4LzQi9oVg7ncTfONW3Cvh4HuP9trghWxv
 /vw=
X-IronPort-AV: E=Sophos;i="5.75,299,1589212800"; 
   d="scan'208";a="141557709"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 15:26:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9gLZB6MIsMbyztP7jSvnKLfiJw344IPXh3oE0C+daZACVjAuoBFB+ERqnIMgXsZbgNrqwSJyBI9WJWPh7yAcyMlorO8/b91uKn0gJSznwSuTl9770oqa/2kyUIDF66oDA3BYjbG1Tl+k+XmRn2XzX8+psw6O2eD8YaSzB2vv2GaiNeRzk0eojcXD8EWX05PcdrItshHUFzvv9ydB0v9s9RvcQ0E/0ruwPFPKkPnNzhpYvKHqlv9xpjoLoMgSJA7TmwBhtJT9uI4+iRDcYkJU4Nlyd7XJ7JzgB4iL4owu5MfFE5sNmNxAc8DHN5lferiIlUcQoY0kIcZ1GM5GEixcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joDokeBb6LFsn2QLUINrc+gBSRXFd9dkYOVtgfPM2w0=;
 b=dPCNpuuSC58Jr5ZRZ4WfxKLTtSnxjznui+ZE0af2nFUjEooZL49fHrFm7iCsu1da4boYKKbXIa+zxuUVBAnc4BvVXKfX2vypjidjX0mpiwTPQKZO/gf0wgOBw6dLECCiUoBBC22DfwH7y6nE+TIApnNcoGeRva7ev4VzYB3sX86ZWC7sgHZxU99FJv8pyhL2uEdJR38jp4SvhiON+vAOWxJNM65BIaX9bo+OUoSs2xa2EvEVy6cYPLbvE6qFSkdYJ5+NmWvb+J7JZtfxQq7jpQ2p9vlkcgtJlHCtld5HKbBOOmjD7df+8KkQt68im+0nIVtTXy0IYyznXEZ9obUuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joDokeBb6LFsn2QLUINrc+gBSRXFd9dkYOVtgfPM2w0=;
 b=owMVR9JwGkg5Ri+6Ae+UvFeMnNv18/shWC33/a31W4trCIcwGKzKa7pDj7iZHUJzmmR5aJG8dmESOq0S4JbX1KviUTSzDnGYhmLHEAKxLw3TG/IFaxzdbsqR8na+ukuMFIouHSndJEXvtw9GVW/O0pDy1EIF4D95HThxHBqt6YE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4544.namprd04.prod.outlook.com
 (2603:10b6:805:ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 07:26:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 07:26:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Topic: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Index: AQHWT1/da8kKA8zltESfLPmcIsILDg==
Date:   Wed, 1 Jul 2020 07:26:18 +0000
Message-ID: <SN4PR0401MB3598CBDDC91C894992996DA29B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200701042653.26207-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:85ad:d97d:6da7:d614]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2e1e555-f777-4d2d-b65b-08d81d900bdf
x-ms-traffictypediagnostic: SN6PR04MB4544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4544AC892A3459C48D708FAF9B6C0@SN6PR04MB4544.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dj8swCLVAGvTRobjdof98+nxr68KZSfbt0WoOABwCJd1hX/dylxnG9CraFEDyblFSyO7g78W3+n6GDSH/EyBDesHk5tlb8XlUoabO/tcfyNDzbVo1HpAau5qlg2xx2hhEgK0xbvUL3ssbsAzGz2/aO87RcW5qpPiIkj0GodPDQdxyp2/9oFxbYWn4sxhPK+VRocfIgISgrcRixjOF4dMhPQZ5TFyu2ISEAd3xyw3ORGvSj/7EX8WsNAE4eDW/9XttdYbPz/X/G8nnGIoql6pk9sLDEdn/G6XGe8q9nMLqUF1JvTqzeGeM78L0a44s5HqCr+/MDpzFlEWGo7x/BtBIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(33656002)(86362001)(52536014)(9686003)(55016002)(110136005)(5660300002)(66476007)(91956017)(66446008)(66946007)(64756008)(76116006)(8676002)(66556008)(8936002)(71200400001)(186003)(316002)(6506007)(19618925003)(7696005)(4270600006)(4326008)(2906002)(558084003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Cu4GpNWBDObqum98qmEk2aCfdPqxJBSBvtHg5r54h/cXJUf0N4CnbzdI4UQVpDC0wgPNbEm65xcE5/ScRaCIhznkGO6DDlb080OIxNDMY9OK8K1ZoxT058rAZFwwKtC7vBMbvPL62t0AwHnU/ZONJU0qOiBwynYwqaoWIDD12a/zHly4YmGzNWAiYQDCuoIiaeYV7DvaIsRJEU/HErZJrtOkvJWWVdxKDJi5MA7R4KkjjNWRccFD8qUPADTXRGppJ6qN/yDwCTTku0CumA2SFLaGAjhYVCzbaNioxn8XCuqX2nijZbyFY55kXF8YxQZV+/svIXyF47Ul1TjhIrawgzOEfEjWXcdsE3glv1J1PK+rF7SqD0XRQpbl3lcKYbcWBtEg1MDiAJi+heAksqCwvrwH4HDJcqsT3fSG3j5DHt8ncv8LMDycOk7IlRADts5bnWfzjPA+8HN00jyy3ks/DXUNkd3sszRUKjRqGq/1D9ATKeBeX727O0n5yUvUt6GTlZIX9KkdPkv9aT3GCmvSTXLy9YxJzw0bB+52gK/ixTmRXM8ax7/p165zkDL2tdJX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e1e555-f777-4d2d-b65b-08d81d900bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:26:18.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DfuPNmXOmcOSOhkbBn0dTydf7sRg6mSHEWVjGBgJQ3yFgrTSAkM7+jlG/ty07Kx9C87eFF3K/hPfTKnkThOzsK4e/JU9z4/iSNLFiJMuLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4544
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
