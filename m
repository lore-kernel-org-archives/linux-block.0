Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D359C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4D7207DD
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 18:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Pv+tiKW4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YAfPY5R5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgFRS4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:56:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26752 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFRS4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 14:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592506568; x=1624042568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Pv+tiKW4q7ccbi3EOr/Zvl/R6245/sKUTN70Wfi6UW8bWpi7gHIDPraD
   a6GSKvB5tFcToSH+qDKnpEkGgAnUEtCJu2u4UtKqpf6he7esAzY81vwKG
   uhSPJ5NNIuXlAvfSsN6yWX1DEFznogA2jLPGqnoMeeGxw2KeGuCEDggOF
   vK0N67NAwbirr40KBEBEHt5dhAzN4QMrQbFpJzdj9KDHpG9mUtnQpQjII
   P4bsdVfhLj/MG/F2tWdtquEZkXmOA23BT6PgG2lMGfgA1waHjY2sBZT8E
   iVj22Oh8GciR55+RRYouU5f+j3JizFSG3frkGgABA2MR8kGzhTTLGTp8O
   Q==;
IronPort-SDR: EZ3Y188CGWklXOdqyOB4JIrpHdA2jUs4wyKHiKBIR8gmgb+Uw4UJ9lB57dH3ayqhW8EomOxh8o
 OCS+v/8pHfIS6ARdJ2CSHYOOwFX3b+hkq6BjN/VC/dVG/ee0uKnKI/nX2DF6QD/BB8e5LZmWzn
 GNmwWRGNGKTefnoyup/750UUTCjumGiK0qJ3XyPxYnvLWUb/i30Fp6zMfp2zJQv7Cx2XQ9os2s
 +BjP3rKVFB7VvegWjO+uqxHR6PvjUIq0n3JUvNdMUyn0BlVklzKoMgkpbxvr5Be6S1HBRYEM4B
 HIw=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; 
   d="scan'208";a="141729825"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 02:56:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epErgLKPzyB6J6Db9gD52jZMuoIqdKJT4nToO8eQkaTzKbk2NX4lcYAfscPoQDRDmNe6sTixahnMHMjCDJia1Rv1bFp+7s6DzndaL+86sDgrN6z/TbhqPDAzjajrRBPn1jw885rEauxTlGYay3mYTI5qJD4Y+1akGhRlYTWd8gLlw+tOQDIofTG7Iltdftvk/NUARPC05JDgwEN712dV5Mr5pBM/U9SN/Y4JjaJn/MobBb3gdeI4KaA6KZwdcP2TLP4kO3Sl+DX9sn+HlUvBOuzBmHYrk9b/7lfoXlJORaXGuaCDLNsCFgsbBgCHgBcgCiwBInd5XdUAjzRI416A1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BVdj9SPDGQT5/9bgble39+aWgvXvi2LGV2W41rW2CznwQB5oRfdW4dcI8W4TEe+Cm/DbBMdJ3Wgc7KrX6Tz91LLvYJIe3g54Vg3HhXI1jFYbb79yef5XKtkNyilnSsJqLyWSx9t4MjcJL1olf83mhVqGGTKlflfNCK9m9bUty08ymN/HNNtx/LzGsjLQ1f/MTSgUx5I3db92N+a5pjAZsFvqhTCvNba6QhgDpj/I1Yy7jGG7hyQTdTZZmY2R1u3c09wQhMeMy8DR7G2cgs/qZKeNKVeuQXZkt7i1xW/iB42+v6ycBX2be7QaAJL42JzxxJjIEvmraOqleb6pGUPDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YAfPY5R5CNR4rhGokLuCN2FoXBFk4ISbdzXP+FNr7oMPIvwDKMN76c3PxfwBt5ZvkfyK01G0pX8ICEBI2+XuZ7ThyLld8zBsM32gjtiai69EQK5wEOLfQ6UJ7gvMjQlrxAhtwj/tcUheOSW97dzUYnq15GbasJd+gSR/4F85QYg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5248.namprd04.prod.outlook.com
 (2603:10b6:805:fc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 18:56:04 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 18:56:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv2 2/5] null_blk: introduce zone capacity for zoned device
Thread-Topic: [PATCHv2 2/5] null_blk: introduce zone capacity for zoned device
Thread-Index: AQHWRYBXnvz1lAnFS0+TL4B5y9ZGJw==
Date:   Thu, 18 Jun 2020 18:56:04 +0000
Message-ID: <SN4PR0401MB35988765B207BD9F7C8D792E9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2cae3b0-5b17-4a64-2e2f-08d813b940b8
x-ms-traffictypediagnostic: SN6PR04MB5248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB52486C74763702BA44D1068A9B9B0@SN6PR04MB5248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4vJBxumdBKGHX4mPxFC+3kMaFYhe8X0p3XUpAjFgowNwrN7qRyGEhnpCV11eYSS2ah9DGozt14M0so0Yv2Gh4Tbl8teXuDWDEd2V4EEtO/WlKyb+akDT+9LV3jdUcRDBHy4/iaqzpRX/IcH6EmpCAW8EESwwGNF+2MY92z2XIHrz06k3gz4ghV1ljY4k4tbrdrTHD/BS0FAMDot+0lCUiE7b2iqwld8+1AT4g24pwWyfsbcJ1QJ1pqFv46LlcmuYcof6/DLyIV/P9fTXrhLqTZh8k9GD0a8uT35wO6Fp3ym7yR5nEALqxijLQBYLExtWH1DUbrZODLdWG9JU7eSiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(186003)(26005)(8676002)(316002)(6506007)(4270600006)(54906003)(478600001)(2906002)(558084003)(52536014)(71200400001)(33656002)(7696005)(5660300002)(66446008)(4326008)(110136005)(66946007)(91956017)(76116006)(66476007)(66556008)(64756008)(9686003)(55016002)(8936002)(86362001)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jFhDHO7tTNhg+v/4Bm5A3+GWSeGLlY3XcVUwIb1urn31tXHlMoI3+2MfmQQ47UCgpbnKRqksMLixZIUEaZdRvXI8u1fkTR1M5Mlglq8RtBP7rJ+KA120LEqB0tlDDh8TnQ6kH/6nETMYfhkc3+0XdQVVtEKlyPzG7KP9qwQ9IvboSXrjkKUu0IkxTPt+kGveB1q2Gz8+ckOHsTruB5Nfz9KU3k616f7gXbIdgSWsAzFQxU4fOMN988dbkk8NaJaGMFaNJHsE5sDugs49bGT0Y918JSZbJ1Xp8qZVDuztHYbErAaWKB92bUVbUKt+vOR0TPmohbzQxIxEojegJMlZxVlb/vPM4pUkA5VA5xxYOTpPVMfPRuql/XZPe3QImdTgnMZm9w1KtUFj0mrL0lsHhiQXzj9du14/ts4uBfAZpl5R6QCfvzOCwUe84T4vBq87sRkys2MijaNaxIeiRm1p+GiyBaZ6BbW6i65s0ljhlGCZcn1/1R3Dq+aGkUnMUjsN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cae3b0-5b17-4a64-2e2f-08d813b940b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 18:56:04.7195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWBLw7zKd+FUfsQ4HSHt03BMI78bzepkKd0ELG7Ms7883Q7AtdsGIRxZwZ6YSbUCLWYrsc86SrTMdUVKsWjWLgixQmPsRihmk8H+yhtLl54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5248
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
