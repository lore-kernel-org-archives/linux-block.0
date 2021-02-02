Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB07C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A85564F53
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhBBL76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:59:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14354 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhBBL74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 06:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612267196; x=1643803196;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=R52HdyIxp2s2pBnJYBTg01R3yZuMH6CdtZwfRscQabpurvR7b1xPtnNa
   XUJ+/9N3DhIhvl0JQJR4t1KMzZxsbzRgcgG9iXLWBdFzVOyZmuUXTFbQO
   66JN7XHwPWRuWE1+6Bwb7NmjLxVrW1MIUTFNdNgKiNhHorWm0qHJ/y7Xr
   z5SmkZwqLjbXbXubksh0RkHECxkp3gpBDWUUV0jt86E3oll4jc8U1BIxU
   RUexQBf5AbeGbp8bD8eEKM173GEhXKDSiqsPiQZFMmIfli+AYnQIUlq1W
   2qlTK1i1Bgu3HalAyMpW2oEZAqkLFCv9euLzkAfjYktrghH7mn/9LkfNV
   Q==;
IronPort-SDR: OdUskIXpiERaWANzEEmBL9+9Jyb0zjV5WjSMfGy1CrSZVIhX1SL9y4TBTyu0mVuGuhv+/mQL3I
 Gvt/xdwq9FgRfBxJwO7Os1fJjHFzF7u1ZwEC5vrujrHLQ1PJpZmyU7+0dnX0p24vnG0ZKXf0vf
 wH0BF17ynOQXGBjoxFagyDq+XU2oOIuek1kiJ3X4J1WNa1XbU/Wk9+NDGjzDJCCG4ScobIshP7
 2vLE2MlC2yG44THKkZKYKuX4JAncHwOkop2EFved80YYhsofUeC3d6SnlbVqkbZbsbBUhmS03L
 gHw=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158914040"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:58:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk+Mz1cCGvvrCfLKiXmScCxavsPQ5ZRMciQSxucwq7qQzlKSdCwBXf2BszuXSvhbCwS/s32iWP3w0bQQ+EG67IYB664tWyfQumlmqC9dszk9zGQwhvFxNSz4DC3ANGLyZAEUAjVY1shcDevJN0mxki6ZntUohjfseV47lZMQh+Gp/aShELesORn2EUX5RpN5fJZE2ucyMFY8GewDy0r9pvq5p56xQK9GKX4Y2/90QU84QulmJDzGBmSBkp/dlHJoYLMEN7tB9C7uqJMeo/FbAjZMR3hjXY/HXqp+/pJ+tKp/PZNAUjqwiBev/OyGZrF0Hu+mhqdbTtpHaWIm45Fd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=npJqlRZsfUdyeAWRJ/jUcmOunpF9Ar3kNyWdK+mLzMjeLB3bnLGtbyW9qtFF9meTzYIwGdH2G8Dw1Dfmgrpjiwwu76WDhxChMplS0wCrNAh5o5V/MXe3mQHRCDnx1ZoditbZIvMe4grPXgmr1YCEn8zpMvPLGn5Y07KmnmQOzla+X8pwYcvGMoP8S7KjECQ7VuDb9A908SAN1JHiH9tJnpbwri4soRcdeTC3Bo9RlMutlH2ABWdzXtHIxrLHD+M2Gkl1Drec2Ut0ztz37YBD5zTYlTrNc98bbt/Ieokf1YLWLqR4apHIxz5FIoWZo2Bs5GaTmSsAL1GEazCkrGYcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zU7ZiBIfA76L2hRTeH9CNAZMkbUvLSu43ucfC0WBa/zN2IvAlixHSOhBxqP8YQ2FsdPO6Xx7mIxFXyxw5XB72uF58BUlBakWiqTnMwa8fi1PtEG2UFffhnzcvLp07TWeusy+7NZBU6gvtso1b8Zn77EvdvcnOaOMtBv8JxPSF/4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4864.namprd04.prod.outlook.com
 (2603:10b6:805:9b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 11:58:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:58:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 15/20] loop: remove memset in loop_info64_from_old()
Thread-Topic: [RFC PATCH 15/20] loop: remove memset in loop_info64_from_old()
Thread-Index: AQHW+SYC183beriNMUGSY6dnrDu4PQ==
Date:   Tue, 2 Feb 2021 11:58:48 +0000
Message-ID: <SN4PR0401MB359895BD2B622B838D87BC219BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-16-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e6fd394-d936-44ff-54b7-08d8c771e6ec
x-ms-traffictypediagnostic: SN6PR04MB4864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB486470637B8AA16A7624CDC99BB59@SN6PR04MB4864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vbnc0qRSCQ5OotdiZqAWAlKg/w8DQngNV9CpFmRzleXQ20NHAm2ig0RGWlCVqB8HLnoCQvzefAfi1fdeknaKynr0QqGm+VFq1OzXtVWB4XnP4d2rASW0ZhDwO/4YVRbYfRzOiLsgjg5Fy/hSl0EeakBNw4it4gv8BS9WLU3qTV3MFUNM4jptETWc/9uwkn41YuONriQmgu5+FJOtskzpjxewSioTZeRrby58z7kt36VxjdnFjCzLcdN70FWeOLASFlzyVchZbXf5sSRicG160eE43vPmEfO/kselT0Jl5Y8Z4GL1zlbws3X931VhWsyj0zHtOaxnsn1deJynezNPSa91Yhxt1dlKbzWZE99olxhLsmrPNPg27Orpx1Ykmfs9ABkTKCJt0fhyQgyF9yikDrOx0CDHT2pdw5qcGWbWjP0ZS3pDuNk1wrj0no5p+6mmU+c+RxEsjWdxQZaUF9Pm1IDrSpatQHj78NwG0xXTFC4PpUr07AVTHnF6PSPcbkbvkkeKvu5ORbi8Kbgkyp6OZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(4326008)(86362001)(33656002)(478600001)(55016002)(8676002)(9686003)(186003)(4270600006)(7696005)(6506007)(66446008)(66476007)(64756008)(91956017)(316002)(66946007)(71200400001)(558084003)(110136005)(52536014)(66556008)(19618925003)(5660300002)(76116006)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2LekYF8oiq1/MOc8XfFRpgG1cH1Dfd0VQqbY+DpZKzLpGlZMythB7sT6VxuN?=
 =?us-ascii?Q?V4trpA+k4nX+iDk+pzyf9NHU4zUtBd4XL0ScQabkIZ/jmlZdNdNhvq4cKyZL?=
 =?us-ascii?Q?e0TMrEkFbDLzeevLVD9JnRjhbeuB9VRLOQdej2gSOiDActxXWrzp37za9/pt?=
 =?us-ascii?Q?dFgHb5vPtSod8vOQZChZfFUQig9CSksP7jEATk/SrlHyLWXa6q8PBwhsocmu?=
 =?us-ascii?Q?PbuFyTfdxciKNDvuA/1jNj+B9mtmd6Zii7c5jYZz1CUxdxY/6DPL5FGV8+1y?=
 =?us-ascii?Q?CVDhXbMsEFt4KiZ6P2YQS0XJcCHDGz4G2D/WYaweu/xaTciDyNuBwjiWT5sn?=
 =?us-ascii?Q?KEj8Lub+dazeFN/OseR3t4H9fT3C4LWM9iQOdI0DLkiRda7DarZ3l9LocH9Q?=
 =?us-ascii?Q?EfAc14rAj2DKEDDU0rIdoF2TbITA/WH5LzVxTmyhaebA3HJjGebmBuxn7EsY?=
 =?us-ascii?Q?6zIxLx9WhdH5wR2HH3n2fgLfiGMVwRj4v3aNzkB0XqabtvIW/b9BP37mi85e?=
 =?us-ascii?Q?8qcv+pO34USNAWfIeHetNuytIK9ox1aNBuYX+6gX4J9Uo3qKdJPJXjevmdVR?=
 =?us-ascii?Q?PvVr0uf/u8+5e/uNHDsqdjYNqWjQ/hDj2am+iro/OWfeC81r1pkT7CXq/mpG?=
 =?us-ascii?Q?pt1h24n+3eYfpc6jZrQu31VPHEYU9sT1HTDIrFsPTT0GhzXPLj7oYzMnfgcc?=
 =?us-ascii?Q?XYCqbGJMkg8qXvvQPJsmjrz9DC38+BTd+P9sJ4H4ly4JQGqyAHMZICGFzHpQ?=
 =?us-ascii?Q?K2oPvt9KuuXGyXLtgZyYdEqbm0fnOy0VSHUTEOiMOAD3dkUoHECpVSLgth+S?=
 =?us-ascii?Q?Y/PBGkqIWyND03Ok9jGlLjCjk4zLgyKDkEfsH2PxYC+7DsKAIEIP6GVvnnAr?=
 =?us-ascii?Q?/9tdh7NUsPzKbod1mClisYlyV1Gh0aBNfiVG8M3D+4/xPj79Xv+BqaG/hhD9?=
 =?us-ascii?Q?kRKnXAd6rN2W37MQRDralhPyoYl1FGxa20uiZgI/CUosiVsdvecVHwfhHTYe?=
 =?us-ascii?Q?KD6aRPyyLnmERr1xfejrU8ojqCx6NZ4WiAvhqo+fUYCLBSKEdrDlPAlkWgWa?=
 =?us-ascii?Q?3o+u2jcnKXWNccRu3Y4qoBesyF9c+WFBMF4DGgW478EmHn9JB6YVKZIVY24a?=
 =?us-ascii?Q?55ameqEs0zWh8seFTQmvqQtjqkZOopr2uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6fd394-d936-44ff-54b7-08d8c771e6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:58:48.9526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crnzlkEc25WKo7yuRa0QzFucKfHq0l2QQJisRAPudNDDd4ghh4eciTqDMjzFosTMSpUiUnMEUMgOPOCFzbBvox82jWkox/b8WFGkHHaadtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4864
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
