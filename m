Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48637C35641
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B816206EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 09:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PalKGPfh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Xl/TrXAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgBUJST (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:18:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19105 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgBUJST (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 04:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582276698; x=1613812698;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PalKGPfhmgkll1cMtKdps/RccQTBApJYEBEHyXoyRH2iXQbjqi/EYMNH
   BVzIGU5v8UYo633xqnUpwW9nl2oRubuUu8OY3OpbfnrrJdpmkb4qxg7Og
   J7/jINu/zzRfbWcxgRcd0i3jQakIrYH/jm3irgA+Y43w4zLgIhZdr7hF5
   czl6SWDx3bP+zsC3HT+GGc/k886htIevWeHWiXtzy9YShdEjNWdxbTjcn
   k9hToFqxHo4QncDMGDSjnt9HNj3C93/NhB2VuqqrKWXp0bLaRVJmtxVpU
   F6muCcvIeZu3lObZAo+Td51u+RaUiayk5CoYsHAIHY5E3pYDQkTCGFVDX
   w==;
IronPort-SDR: r/bevjhdVE377G/7ES/cfCAjJZG091G91delkP4Bx2cvUCcVgxtICC+r+vSpvWV0MpH8yjbJln
 x15P+jv2vzhKf1zrtEbJ60CWOKC0696fTGEpBUEJG9v1Pj32ywhzPLfMgWlStv2+HpgvOm23E3
 JLzlSpb/4LOQlH8ydtl4FGu0BP0nut5NszrFJK1WmRnJwuZnytuW954S707tjjY762SBI3C7Vk
 s5TwhW+j5GyDrSz52Iu5WCe+704Jd/dq8VYvaCx0KfiLbg7PhD3jEu5Id/Cfsnen9+xzirvn1F
 9zE=
X-IronPort-AV: E=Sophos;i="5.70,467,1574092800"; 
   d="scan'208";a="238490706"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2020 17:18:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHpJdhQ8QSLfRgONjC5gFnvXhCvM6ePSMiP00TL/ssFNTHJ/CTF1w+mg1ksOQRn+1rLfOg8Oqoyw+CsUQsjGWqI3xa1fruGnja9i45wVSlWSPafPUjKMA8zEECi4S0huOFlObLM0QkMM5p0xULgd8PDuQP2BXACVeToG/IT8P+ya+4imqlI9L9MfPJqkRCLAb1CDi9nxOi2pWQCzXbK2dvrwzQlYiAeJ2M2mV+/s6KlRDMMsq5bHoGg/S+nch9NjtXFyNUnHOHNLiaGQt6rSpNWodsLgonnkJ4rM8AaBKpdL4OEeBobvOD4yXtEt6jrfi0tyetfoyq0GyOaoFSRqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WdhlBQ3IIvoUTgGF5HKK2Szeua6wph/98PI4m/yAx1WNMCylSgfuR6eYvLe7ALpSKETdshJ1Yizai7fq6lGQD/rwEhbTgv6Dg0533NFfeLwBrdqf4D4hUkcROF2s3oy80di6MjpuI/8NLidDnbWEu6PbZxilhYQ6WPS6fS1Ic90927FqSuqwV1csNTO6fa5OsdBLQGjTFrd8UauyCFzKYtCIO4oicRbF3SK41zeP+ptzr3tar1IdWSK2FJazVOPdsQ8ddGZdAWyacPVI2Zqf2JsO3LNa+Qv4qwhVXI0gRSXLRtFSw6fcrT2KRqA3Sa+9n1mLjoJ+cGXig/O/I6vl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Xl/TrXAD9e/ZkCCPTU/l5BcujON0qdId662PPK++jHVwvAVgHqzlbWxZb9Pbxc/dgX+hpYYgLt6jnI5/KVQmwLiw5T1Wmq5fFd0sapdsQuUca1VqNrL4ddlhmRZ1ZSf5i431vkJzzN2KRk1V8CXMnbEebXOCZ49sU46TY9vTHhw=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (10.167.109.143) by
 DM5PR0401MB3639.namprd04.prod.outlook.com (10.167.106.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Fri, 21 Feb 2020 09:18:16 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::2481:ca52:b929:3077]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::2481:ca52:b929:3077%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 09:18:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
Thread-Topic: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
Thread-Index: AQHV6Fdz/n/o0KhD/keZdXA0ApnGyA==
Date:   Fri, 21 Feb 2020 09:18:16 +0000
Message-ID: <DM5PR0401MB35910A38F11C6A0C215D325C9B120@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.193.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbd356f5-ced4-4dc8-a2d7-08d7b6aefc22
x-ms-traffictypediagnostic: DM5PR0401MB3639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR0401MB3639CD0791397832DEE483889B120@DM5PR0401MB3639.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(91956017)(81156014)(81166006)(478600001)(4326008)(8936002)(33656002)(4270600006)(66476007)(86362001)(76116006)(66446008)(66946007)(66556008)(64756008)(186003)(7696005)(2906002)(19618925003)(6506007)(5660300002)(71200400001)(9686003)(55016002)(54906003)(110136005)(558084003)(52536014)(316002)(26005)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0401MB3639;H:DM5PR0401MB3591.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stEVcEyj96CTatrlPwpVtJuds1t9le+ON7fWKXpe9kWnnO+xXMr60rGu1pftW4/TlcbTc1Px6aNaGqJPy+nMPDB/IRFQHPNNscLv9cIWMBxMEX0vMDD59/Z/CItBvV1CVvI9wB3/pmlxbitdUgBF3l7Q1+1se5w+uIHGu9VfekfwxEPJ8xWymcjLnzOoRa4U1ebhD7gg5sySz/gYqPPNqpAJEk//KFLmcXevxORjJOwqbJw3TA4boI+TFGEDwLBHlD+P2OYnhjJr5ijBDLY+sYM6HEXLfphCs+AiaW9KXm7UgD3rY3ZIZMO+TRsNXQEW86c2f/qmzZFx76ilp4xjMZWdNplfoI1ChfWI6Bu3gwxdni7PFLEckLW6nt/0Qikbcv72UeYjkIz2P/2+SZciwTZOlQTLA0VXifC3B3YdFDPYzgyJ7c+GSCUwGvBb9RL3
x-ms-exchange-antispam-messagedata: Ipy8vch/rrMz+I7PJl/TbeEKegosRXK0R6M+MkmAmzD3xxrPC+hpqHIj1F700bXas1uJ3mqha3w75SfKJa60Z2QHwPPMqH9I/Hx7DdPj4M1utfd1pGticZa9YAfYJhZ0FR7bbddjjABMOD0ZhW+TVQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd356f5-ced4-4dc8-a2d7-08d7b6aefc22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 09:18:16.6048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+NVRxgZQbF5/R+CfhmR1TjZQ50YrzEdoiqfDGjRA6HkLJOBi+u6DeFdkaGxEK4R8HCVdKrltLwnixsXZGWxNEyJP6Bwyxlc7T3D/g97awY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3639
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
