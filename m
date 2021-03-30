Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6CC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757F8617ED
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhC3XvW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:51:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47544 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhC3XvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617148284; x=1648684284;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WrS6+GDCJRRKVQpwT6py+9htFhrM6EIVFMpSM27Qr10=;
  b=rd2SWpR9y0fzfxWdf5lscylbLZ5bjSiinrC/zjN/h/EVnyGm2mggl+Os
   NJkT7At9bWZgiv7NIsANBq+UpUmRBRmmT/k5Djhw04clGPmejdVVg72Vi
   5c/XHEFDkr/u+7ptDWHgOsmGGRHt76HMNTgtl0pfTfkYK5Yo7WaRsoXAs
   SxVn9VuKRAaodI8l4GnDSI+tV1P3HnuuPCYQe+E/ndWKTkuG+IJxuk6Ii
   2b1FZJxCON93FksvqnpLXSJn85yV3wM+fDt1sYHxmKMnodaorrJR2W7C7
   DR33+dsZaxXVcerVxA7YwgXbEo6n1UuySnKoUu97sKRYRMg9TKlaqLgnG
   w==;
IronPort-SDR: ea6mFQnSUs70mw+CRFqcuzQ7F4sT8uOYopT4qKXVoK8AU5JSg7qKnUdfbAo76edmKJsMNhxZZz
 iY9dRQixMt5BnvahR6MCdqR3IFiDp7pD4f9b22rb6MgRS9y6UqmquW5eaj9z7n7/L5BJl8Tc0y
 1vCpe/tds/M5dWH2+MVmzk26bE9agux3rtTqkD39qMpN0AEU+/YyVxn46u+iKoJT7RqPmeiX29
 UVH6ujK3e58iot109yUp9eCO5gsWDRudxRIK+k/F5ZcJeXJO0+F1vV6HUngJVf2PHYbgAbfC82
 jj8=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="267820393"
Received: from mail-bn8nam08lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:50:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMEH7CrcnPGhTEdIOFQmiGLDXCjLpmFqzJIYLZ/vuuYnB+KBdR5gJANIWwRdSWAbywU/siDOsIInHQXkIz3InFOOTA0+Vf3p0s3raUicraWS7YnW0/VCqOK4BunZ2J0tbC1JrJdjQORQYusAt9AgsoEd5YPqP2J92qzoni5AnsMrv0/IjMspxGZRhbc8MgwwnK9uN+9+xXWRZMQE7TS+hfTPXOoOdXBUJiyEHTsY/ALvTmloIf4/svpZDdw5fcdkbsfjg9u0fJRw2TALgd+mnQERVnQDlxgNRYQjg9NxRmXioQzuXEyGtZCqmdOSGlvdoR37cBF5wT9FGn5S2IjC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrS6+GDCJRRKVQpwT6py+9htFhrM6EIVFMpSM27Qr10=;
 b=C2/FkL+YoZbbQ6P5AUx39XlT98/fgC2D3vXnh56WrebIq6vyvimG4aLRkjGMrrC/D7CDl4CfH2Y8N2qo0FiTNDzhetlIbODbTy+4f93Q1sx2k9PXnDwWMMBewkdzubv6/UWZlZ3klfMxhWB14rAPkepumtrruy2zjn1ETrsS2Ud9Gy7Rt/Cg8s02xookSXF5nsvapucVTzwfuG/8gXZmDtDpG96j0gGUqPiTAMoF7+uiMsq9HkpPzVwN9f3ONuVKGQqYE1V3q7Cb7oqKV4edXyxJZ4XJvDhr5Z66sw9YTxtJjvmWKLww41Y4Z6aOXZL934EgmeV9vg+SD08fLSkHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrS6+GDCJRRKVQpwT6py+9htFhrM6EIVFMpSM27Qr10=;
 b=IhP35zdZIPBWns0huhoyv1tpjHlwy0xL6Y5ePOuTuznxvy181+DgLuAUv8kfg0Jaj6zPz/aKgSPw651kJPG4cYtQF6scPAty0ZlySWgyndS81Txk+NvxGqABA7WT/7rt+5TIwQ8UN/1xQFIT7YsYTC1vZwo7MGUKLrcHATDBW7Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB5029.namprd04.prod.outlook.com (52.135.234.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Tue, 30 Mar 2021 23:51:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:51:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 09/24] block/rnbd-clt: Remove some arguments
 from rnbd_client_setup_device
Thread-Topic: [PATCHv2 for-next 09/24] block/rnbd-clt: Remove some arguments
 from rnbd_client_setup_device
Thread-Index: AQHXJTfSpLqXIJJnM0WnslnyTsi84g==
Date:   Tue, 30 Mar 2021 23:51:01 +0000
Message-ID: <BYAPR04MB49655C64163C186370DA3C44867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-10-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff309772-c1ea-405c-5068-08d8f3d6accc
x-ms-traffictypediagnostic: BYAPR04MB5029:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB502967C94859BA1D619D8014867D9@BYAPR04MB5029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHPjQ2Nj+7Ob35TpRJZPFNLiz8Ye0wJbsCo6j+ur+UR0V313RvhkLOLQRDxlgSMe5CmoveZ64ypj9RfDsyMmowJ9h/2wIsHZPlN3CBiTwRAYiDw8ZCIPSi+NRjrlbih2xYiGRDqRAyYndJwVhvqch7+qMNP69EqXi07OkgAdH8D2/SzkxBgA4+3Vl2qk1aYCRSJw/FaVfjmj3SOlB1F7PQmhXZTlFHwmdZ0NVJF1iaVgz3/uFm9KIe/PCZ5+05+UCyI/WPBHdlx43Om9GPi9lFPwbinrcnkBONoJSR6Fdi9v9sOpWFCANIdUPQ8ACYCYpTe42eP0FonU6WnsXFIEWSsvfV1rh8z3B96AfdlI6W85R97k6A52xP/tQbcUxxiJD7Zr99+28kt8ZZJOUCruSIxMwCKA95JoOdhSDnJC0KTUoGPUDMZ/ehMrifnh4YCgmE7/uYIAbRxf8BShkbQRloAgTJzOrlCQRJG3gdzvbX6hggseTUQGR1XeCBhxkTRRyVchX0tVvvNsHE+jqchNZzmzWcbFyOHnxGKrYtbzYHvwojoHeBPx6SADkuIbO2+QDBZNOKE7hsQWxrl8gp8Oo/AmMmvlQ/RhWyI7+kYd9jWnECJZBz0kxH21/88pfn2bBcIX/4wBXJ9QxUwkbou+4BSFQc3dtDA+laZz1sIeKp0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39850400004)(136003)(316002)(55016002)(64756008)(71200400001)(8676002)(54906003)(9686003)(110136005)(478600001)(91956017)(7416002)(76116006)(4744005)(86362001)(8936002)(38100700001)(66556008)(26005)(5660300002)(6506007)(53546011)(33656002)(7696005)(52536014)(186003)(2906002)(4326008)(66446008)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yjeAq3FZ2+HPF5IcxsYJbbaWDYsL3WcVEVhLTEJGQOa1Ga+wR8Fcid065kX/?=
 =?us-ascii?Q?TmtmpHyLmoh9FrcJ2EW5+XyFLBpdPsqYCt9KuWZ4Rc4aNzNqhFHFxrbGGjiX?=
 =?us-ascii?Q?p0bovscalbku/V/vv6Cj8B8vYUnejJtXLZfSnTGH21DdInMgZaE7SQBT2knl?=
 =?us-ascii?Q?xqe1QNTXbk6FZTjQz6ytyr2m8BAlke70+lHal+C5CmLZfIqNISZO0heA6W0l?=
 =?us-ascii?Q?b+hsbbFbhqiI3l+9ksFPI3izVVWUojbng13tHnGVOuhtNgTJOHHG8WY3HVEp?=
 =?us-ascii?Q?olSIS0pMtoE79uuRamjeAo2Si2yK4IvRJ4BmhY5A172hmMI3fpziPCwGFFrT?=
 =?us-ascii?Q?lelLhh+A9ke3FVOoxAcEvMcIWe6AkBF3xCCFkva3ki+i5ROFLLAdlU/k6Kbz?=
 =?us-ascii?Q?eOuG/WH/nzG+pXrww/4FSZC3aLXUxvwxh5Gf0InB+AJsgcTgHMhkNVI/ocwI?=
 =?us-ascii?Q?hYpbOr/HEgwnaHq9bd7MfJHggo0vDs/L6/HxuFcPAteq1cwUBH2tGUwQ6ECo?=
 =?us-ascii?Q?jhkaYDSkHMezcBUOvLvLjlL6mEugEwgIJUODgiL9FY2TPdmxHil8F4q/gcPY?=
 =?us-ascii?Q?hL4kkqZfeh+pgn58DoXppgByk+Mrmv7/VgH3K5OJU/psiqmb3nuijdKmq0Fz?=
 =?us-ascii?Q?RPDK3vz91WqlapOahMYWeEpLS8NA9G4WUgGPnQZDQ1115d+ob9TafzVgosx6?=
 =?us-ascii?Q?HAIXwcO7weXU6TAB42DGZi1wxs7EygkVnQh6v1V25SEivJkmtaa9z7wNiEU4?=
 =?us-ascii?Q?AhgECL3p8+iLszAKWUfJs7q0Veqq1z/kjDV7oIwonVD4ZD6SP7sRi8ZzBbHc?=
 =?us-ascii?Q?KtaMhhtqJgVRc5PVZm5erz1LwgAlkVi1X2VpEY8aj3YXllyGYX7AGewfTUCU?=
 =?us-ascii?Q?aG9aN5Uj5r8FCJMFHql0L4iOEHlh7OXB7NW/V43ELy5qt9lPYC906+2Wk6sW?=
 =?us-ascii?Q?LLoL2NmyjuO+241jpoJBsaIXFk3YN2N45Fnlh1CaUqrErsQceznVUjAJZJAJ?=
 =?us-ascii?Q?hhbnOBdUxH4z0OA3fYKMiI16VWGEGtUJLU+cjejqdhFJeLqawvBz5pv7Cm9V?=
 =?us-ascii?Q?yU02gVU8EIrR9U+h4bZ1LfMx+erKquarGbVAlVKdO4on8lwQP2B0dcB0KgpD?=
 =?us-ascii?Q?DRKbQgH2EGUjlTJirEtVlXPz3FX1b8adSdRqgFVeXHTfWbW0IdKuCxq/xgM7?=
 =?us-ascii?Q?Ru9tXmnlo1F3M7WEpfSyYuw7U0ZrPbN0HwguXVO25JJefHdrxij83k6CmUIZ?=
 =?us-ascii?Q?5m0J2T+1+Kb+znaYMv9R8LRFXyaJsc+3u/GOi3FS1x43FwIOTU+orAjQwiw1?=
 =?us-ascii?Q?oM/hovxbIUp5i2RXl9tmeRi7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff309772-c1ea-405c-5068-08d8f3d6accc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:51:01.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VPeDwjSfO2xgidMz2KLNL/aL9JXifnlAScU2reONXMzBUzzPe8TxYd8vkPK2L4i65a27IvMmctIN3U79E39zpjDa8WW6iCuWRJtZwTEFHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5029
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/21 00:39, Gioh Kim wrote:=0A=
> From: Guoqing Jiang <guoqing.jiang@gmx.com>=0A=
>=0A=
> Remove them since both sess and idx can be dereferenced from dev. And=0A=
> sess is not used in the function.=0A=
>=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>=0A=
> Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
