Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D4BC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 21:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12E361103
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 21:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhHRVxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:53:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4227 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhHRVxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 17:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629323548; x=1660859548;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HXKDnF3WGTwnx5thxivJuPo04m3aPqTcVeJSXSvFESs=;
  b=ADqNPxo/PB1it4qWkRJ4S5SkOp3VtYD1KCGG0qOO9IO09nKsAqsyhYK+
   T6TQ4qUZqkhZZHWQDDi7aRaBPI/vy7ryY6mChBdJv7zmN//qbVKKlt8Ij
   HuNPmXqxaaBCwrsHUHBCi341vwPXg/nD60E1QmJIS1EJ5OVAVA+Gd45ML
   649TMAtejOGNyNBA07EdJJ8XiAYZ5vvFL6DZPyFeUSOj2h2mHGkLYYD8H
   A5NoDTtPcRzfwXdNql1yLsyPaLHLuE5frTkPqGW/p4qG7hUmR0TH0CAe3
   103y2CYOMijcSiwysjMWcTECw2rzwAtfUIKFaLuNgbq3FB+fd9mrhCuOz
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,332,1620662400"; 
   d="scan'208";a="176853583"
Received: from mail-dm3nam07lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2021 05:52:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6iru+DXLTa+7vN/6KCcd0VG6ECS3nHJmJtTSY7f4/9ZmlENeR+Ayn29blo8yGCsRz5uueaNsrMFTONQ6WclEsmSRBtEvQrXUcLzGycJkhxgoFwso98RssYYqYCL163Jp+lk4QYMZ4FR0Ph8JFhcjhKPa5mzWv01q3/+1KII891VyPaAmP3trZyxCipif2pnPmtAStLAmM7fSC+SlPSupt7QD8tynAC4jHtotPJn8cfx6xXwD59YZW0qAR8rNykiSGnnDk4AlIV1pXIOnPXjRQGYxLnFTUEH08cbp285kpIj1jmswWSRMwPs9PKNjHcgWcMoody4MHuxEevR1efThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXKDnF3WGTwnx5thxivJuPo04m3aPqTcVeJSXSvFESs=;
 b=FXxVSkukjsF3zvRhEhMobFgUVpiUAGxnpTtKLLHV9qO5D6T9/TArGSuHy9asoR1EEnO/H4FAsE3G3kdJ9ELY4T76VqsC+5T9pEC8RlMJPmM/wdf+mfwIHI+3lOlNf1efBvJp2XgpqLl8P66Dx8kMB6eSTr33ASpRqMauBsbXXFhrzfabKZV/rqCsm3yZwtHOjYqlWPW0QtcLx4qSddGC5wQwVmNn9hJHBZrXKDipVwUmgKQhVzz9vfCE1FxvhKxWTmAjThfxBjcTA/3yyCN54ZYGzJ1IycFqnWS8ZWAVmh3DEl0r8YFgSDS59MlIroudzrh7yP7PkVc1XeMxYngg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXKDnF3WGTwnx5thxivJuPo04m3aPqTcVeJSXSvFESs=;
 b=JTPLuxBYe2EGarh3YMLjVlztHZuvTR+m+QfqAtdupZlC4KMMTrlhm55GdJ2JDmyAbM+tK6VQFIKxqYtUkSJ2usiuG67db98AdLQ6iJBc9csm8XUEONg/6K19OK16XKwTeSbDRtXz0qhVJAcYmTP9TrtSwprSjmZkQ8hUF4BUZKE=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4009.namprd04.prod.outlook.com (2603:10b6:5:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 21:52:26 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 21:52:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4 0/6] IO priority fixes and improvements
Thread-Topic: [PATCH v4 0/6] IO priority fixes and improvements
Thread-Index: AQHXjmIw1CLSs99bxUeB3ntO4vk/cw==
Date:   Wed, 18 Aug 2021 21:52:26 +0000
Message-ID: <DM6PR04MB7081CEBD8C72CBEC12EA0002E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
 <e998936b-5452-1048-80f2-4161bb77b3de@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53d39642-75b3-4863-32b4-08d9629277df
x-ms-traffictypediagnostic: DM6PR04MB4009:
x-microsoft-antispam-prvs: <DM6PR04MB40091606AA5606E6E2E02707E7FF9@DM6PR04MB4009.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZU0UZre3xhg1NVqK5NXbq24yNHhJde0gFTnfF/D/tt+X8zul3NEVQ6BQz9e3mPg2Pxndgyoq9Yqo/sk1iqBPoxCvftvCnKya/QeeTXcJysq3HxS49IFjCicZAB627ALzdctFAOdFiXayA6l4wUcvt3TFr7fL76v8b2A0YOjz7PQPhG35dqwZBCHnJkFYkK6X/c12cq72tyJEOb8OX0S9QAtIHFeKd9ZPP4nmTS82qOZXlW+T6vZKFZF+mWSDPg90PJh7XNyHPAzufXSkPgQtHF8Eb78zgOOPNtyTkH8WXrCtLqbb4OHHNKF0tSOfrUqNBrN3LhpsBOUuvJqk/rnyRzHYy/hB2wtMQ4VQpfm5B0Dqi6s7LNWsfBW22P51QFYjBvJc1SufrYHR2SkcArcs4mWInNrtf0W6HIKw9RKScUDvtxfRSWkhD1PcFc3/oA8WVvmWC1aYutJrJ9poGEH5S9nTGiQO4vJKGzi5GwGhe9fMIgbnLRr6uDL3yhmeeWZbOqSfvzLHENhzwn8NTFxLp6qN94igkgbjyNBXop36MboDa3VCYshyxJvIz699lIAfNcFrJ4AqyqHUwKZ7uQjzrv9EMjgBt7w9tynD6Kfzs47Vc3QwHtqjzCLlVkICVg+SXk09oD7CLCB3D2NE4CFC+3LfM2sOPqTqsA2cdX+ZgabOwlm3uaX/c7cnIkSsPtOloEA6SsXzXFnph9bEvZCuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(9686003)(91956017)(8936002)(76116006)(71200400001)(122000001)(38070700005)(64756008)(52536014)(6506007)(110136005)(7696005)(2906002)(38100700002)(86362001)(66446008)(55016002)(8676002)(66946007)(66476007)(186003)(478600001)(66556008)(83380400001)(316002)(5660300002)(33656002)(53546011)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WqIVuDrC2T6u0SddDhZIOYw3BXGmuNuH6lo/uNbwNiTZhalWoUHOlIiZbm4Y?=
 =?us-ascii?Q?CBtaEF8V2S4WtMv33rgDoNqArIhI7ecole/pyHD118ONOv0J69xzhCblPDrL?=
 =?us-ascii?Q?onwtEi+B5GPo7Dj1J4DvVeuL8w4yw+EOjqPDciwijoxa1FWzaYUtJ6vHYBJQ?=
 =?us-ascii?Q?JeTEScJ2eZVztxeyVyamnHpvR+rJOKI6TPMpHq6LR1Xkyo09QXmYbuYv171B?=
 =?us-ascii?Q?h5mMA8O7Zq3SdCiSlHcmsEJfJsnmaTlLTjKyMI2M3+df1b/svK7X20si3wU5?=
 =?us-ascii?Q?D/A2CpWxUHkahXSVU4NKy+SdI+Hi6ruVDp+o4pylfcol9opf0FfQWf9srfCS?=
 =?us-ascii?Q?3iZdaDIp6DCFZ1WJukuUU99zgBP7ao6HrkrvsH2KiA59GRzohXXcOr52HDtG?=
 =?us-ascii?Q?n2Xv7DdsAUkcO8C5kGcL96Cn0NR+84CtrF8ioiEp+yAYmhk+K+bCeQQUdrmm?=
 =?us-ascii?Q?ruJrFDgk7LjQewzYZoIbxCgpJfH2U0/Noau4kshUVLcDRuqpI0baMiTovhLQ?=
 =?us-ascii?Q?MI/997YlOEqbFaHExl+gqYfCe1aD5zYuFYEEiiA92JcYgvSchZSUk/2XwRRh?=
 =?us-ascii?Q?P280jmI0YtO0/I6FeGX3sSg6SM/dV3G9wQWidnkAiByigUm6YLw4oT1eAH3S?=
 =?us-ascii?Q?FxOCkHiZ+0afEuzGZf2/Xb07et1KwJUltfInIhoJBpVHeg7e3gbU4kZA/ZxK?=
 =?us-ascii?Q?zCwWAZ46eS0sexOxKlqR21LuKE3kJ07aZtdbcnISXey9kosjVVI+pW3FYzBh?=
 =?us-ascii?Q?Mq44yA2gxLZTDdoSRW5ssXceOfBJxfpW1vfnhoXF3m5FrXTRTvTVjZNlAgK4?=
 =?us-ascii?Q?X9j+6BGSZwFugmaTd5Nfn/hh+2/3Sl2Zu82ROvRQiCQcaQTDo0Jru3PRWjp+?=
 =?us-ascii?Q?LWfBTtxVwT5xExL/LQdYc7JEt0cm8NWdAo71vDlW1efbuUl16L7fHrVLD8bq?=
 =?us-ascii?Q?LTArRrlZbXqoG4BTYLkaG0MnrerotsSk1m5Xp2iWC/MnQVCjANJYDb4fYZix?=
 =?us-ascii?Q?JEx81h97NGMkP7WLVgpdDiiQlBO7OMvCYYN1LNp8yquxQTViaDBGQT8ALu8Z?=
 =?us-ascii?Q?5WlWSbiuB3toE/OSzWcqvooN9/dplx44fKSgybIp0o0SdN9g1cp8WngpkpJG?=
 =?us-ascii?Q?7DFgtlyHsVkfxRfIiRsQNjdEuuRPYDv4/6xGcM6fGuaibMapPPv+n6fEjOAu?=
 =?us-ascii?Q?/rqaeoqx5kM5JTKKzWUBxJPeFJ7dxeWJjQR4nKRV4iotDmF95I6kVvj8rLer?=
 =?us-ascii?Q?3js/uuuXbV4GDjBdUHEEZP2R0SsAM3IN3yWIQtzTwxJ0jV8ISMB+Qqo6NLM3?=
 =?us-ascii?Q?Zby3WRZmsVI+0/NjzUnp70JqaHvXpnfaTEYp0aynjBDeFV5GjCa9ovNhhQgJ?=
 =?us-ascii?Q?BzdYrGna8vSVeUHeB4GJHwkUijAWSbfRPxOK1bGgRoYl196v2g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d39642-75b3-4863-32b4-08d9629277df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 21:52:26.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcaXIqtR3xvCtprITUkGzN4t49T+3Tgh3Eh1wRA2/+2RO0gID25J5h2RyX/0hveUJl5uxo8lkmlWZbTo2rCT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4009
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/18 22:24, Jens Axboe wrote:=0A=
> On 8/10/21 9:36 PM, Damien Le Moal wrote:=0A=
>> This series fixes problems with IO priority values handling and cleans=
=0A=
>> up several macro names and code for clarity.=0A=
> =0A=
> Applied for 5.15 - note that I dropped the lightnvm change from 6/6,=0A=
> as it isn't strictly needed and lightnvm is deleted from the 5.15=0A=
> drivers branch anyway.=0A=
=0A=
OK. Thanks !=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
