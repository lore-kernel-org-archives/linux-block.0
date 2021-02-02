Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE16C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B5764ED7
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBBLvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 06:51:41 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9019 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhBBLvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 06:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612266690; x=1643802690;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=R/bFUOkhpdLBICr2zGtL0R5U8D1KsRO8mvrKSoJDityHG+qa5virfrIn
   QBc+sVYw97MriiWAYPyJraALGlKBwTIt6SgjFsD2EUd3mCEwDtvnCBMaP
   hDLrXEaEb2SxKrWvcoPD/yB2V1V5sTF7PQLYW2HHTP9ktZJQfcOr97Zbi
   LHEDdoUQKLavsjpvtYIzNs7lxP3mFqXe2SUZyASTtmmIJ0ustDpUxm3OQ
   3J4gMGMuXjM47d5hE8uQzc9ouYuxZUaMKceS1WMK40rj1PogK8Pztljmp
   +WZzEbQzcg4rWuMCRDcJJqikOTEaNSSAe38r2PGlVY5lzizXwNndhTmtr
   w==;
IronPort-SDR: ThhyXarfHJcYH18IgMBw1b00JagXPaugji/Q/ZsedvFzEBJcTHfKlKja4p+nLEaglbn9z6ev1N
 TSuFfEPtFu5vesZ1CDIthLiT9iGC2vHbp+YGtDa/y3gDGwaO/dqYgrBeCfkDFB21rM93Mbe3fl
 5nrn3/sCJY7hBuJUQL3MUcwPA08iUbsYcrPNJXB0jwAw+Yk/+dnlnlHDOswtgyZL+Ze7gVRMLn
 tpOo17HKWTRHl6Ptsj0rH9iak/aR117xSmpeld5wB9UdsbTEPY7fGcMZUuW16FitfVx5nGo7Z6
 iIc=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158914323"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:50:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlKsMshIFRh98pOI08jcsmVI1Yk7gvSPHIVK2t5sLMjLbwAcEFpYuJ6f/MYWcYgbRpumVVBm/6STS4Yn35AqibHjK5nzePzPJiwCP1MXV28o3Yt5VGH/fVkDTvWFzxXdTIOAv7ps7rqARBxz4k4hHyk9Ww7ca6keXV8jxXNxNAXjWfRDpYmnYVLheAboavJAR8g4DaedxUj46s3FHjy0CFPI2KCqb7ljH1RuNLNyp2GvwU2nSD3OK8eT8H9dBbpPNuJI60R4OE80flYgi+x4uIF/YD3BBnkfS7lPwWI5gvkGtQz3qI8K8Nwz/I5qPsY63OCEutsDQaPCrcK77R/SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jm1MkwJCpRYSZumQY0byFEVqE9BWsPFnm67PzqgWdSmSTesuL3TdIvetdmGsTW+c9fJQ+tQHUn1UM5ne3WEMAoO8suEpP4kjcdVydNwx/c7992IwkfKgs9LHeUE7yPaNakGgUpqIaZtIUaPs8VoHK0yXkxnZqCpfm4lV/UePHVa0NQiBPAIZv4qNdePOPRuYM+r2PJr+62WM2tB+gX1AsC+0ofh39Jp0TbX0jd8IBsth+GsbHoFGqU8b0AHltZmMjHwav4VjYEp8La1UihhbF1tyH16VoL5jOSgvcLxU9wGCU1PG6MVy6IxB6GgyRej/ErI9fSyN6VnuFqd4rxuziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NPEvmlyk0+7VlLwcH0ZfNICt5VaD3Fq288tHW1rvfOhppEGFhSBibM5j/uVgJ5ZcsP57VcP+BDZiprhH+zmhgnzp77VZCMppC10cbZBGD546H2YIN6aKwHd9jU7IoBtzp7zuot+0vZ6ALT4tDT3GtXd80T1GncpgPTuTPsekJ5E=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7593.namprd04.prod.outlook.com
 (2603:10b6:806:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Tue, 2 Feb
 2021 11:50:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 11:50:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 09/20] loop: remove extra variable in lo_fallocate()
Thread-Topic: [RFC PATCH 09/20] loop: remove extra variable in lo_fallocate()
Thread-Index: AQHW+SXSjCU/ZF8tKEeP6elPwdtURw==
Date:   Tue, 2 Feb 2021 11:50:21 +0000
Message-ID: <SN4PR0401MB3598BA7F4FE6E6D7C59EC47D9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
 <20210202053552.4844-10-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0085a8a1-d728-49bd-3f75-08d8c770b81a
x-ms-traffictypediagnostic: SA2PR04MB7593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB7593B8FFB2B6AB2692749D949BB59@SA2PR04MB7593.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJN9G3UaF8xY8rr2Z+2BZthcpv/14EtU2lzsUPzM50EA9EvmYZ4V0EzWdvGHwx1cWO+RUZIUrQgJ3tHqu7sKG5Ml9RM7JQJ5b8QFa2vQ7DWHSTc8/ZZaDByykstEY8CyDeEinTKoOf8xC8zBGWpnpQ2uur+Kk40KWUOLERq0ZRybAotuobmd1VuQHXCBOOEPq12juq16gfctumi4Jbq/WFdLhqoN6AMQI/MCv9xyVow8uGdiIK7hrIHvighEt0ieihw6eoderzCESAxFFSooA5DzOOryFbzNKhF8zpS6BeHrqp1KbryyuSlDRl3W6iUbfpBVATi1O3RI8sC+C4GgpSgh4Xbxm/8hlMDjzXkyzAFmxkecMY0YxeWjBwglYR9QPoZBQx7dBCHj3VmKnm1wxfdptl5JvTZ8WlB0SIyXbqnfT5wC+o4D3PbNTz6fuDfYvcydLpzbGPV77CaFWhBMirm8Ei7qi0CVwT3DbtLrMiR9Qmibist/sylmfdnX/0W7dmFde3nBdIHlWRpYVxVSAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(76116006)(55016002)(71200400001)(6506007)(4270600006)(316002)(7696005)(478600001)(5660300002)(86362001)(110136005)(186003)(8676002)(91956017)(9686003)(4326008)(33656002)(2906002)(52536014)(558084003)(66946007)(8936002)(19618925003)(64756008)(66556008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R2S+4c+SRqF6mzmZG3StyGX+8D4GyFQkwwXe/QnoEau5rj8ukwBf8DbJHvHh?=
 =?us-ascii?Q?N5vgK3mbAeGLdNT97I5aKvPoq+CVHuzzqM5odI39LWaleS6Tv6ac8noBs+sB?=
 =?us-ascii?Q?jzjBM85ZHt887OjDRzwYK1uj0g/gy5p0AYk/bkniIouGAU1Hytp2A/XBde2b?=
 =?us-ascii?Q?BaRtDcS++bkUzQltrfkEz2enmBAvDma8FdewhSJsC9i42HyRs2x6pT9rKHq+?=
 =?us-ascii?Q?Sglwe1yXJkS2eX0yWB02FjAWuZQPIuvEf5l9pQzXTjoAkVYHFIFzUo+8H25P?=
 =?us-ascii?Q?Vlvyg3NJOhofpikPQQz9NSXSLAT6TRfWMD3xYH9Nz0AWwFGKAt2X4UL6aOXu?=
 =?us-ascii?Q?t4jm6tJfsS7KJyCvyE1PlEsutoWLpJ8SIhT6aFZG7v6BVZJFkIGPOMpgcokD?=
 =?us-ascii?Q?m3lex3iMyhjTJ66jNkrTmVuykN6THGSdbaKhx70SsRa4UYR4UiIdOvSm84fA?=
 =?us-ascii?Q?WL6mnUTAx68xpDCd6YtCnbyLEgr7LOiKZBmhSexIQ16snzCbbu4h0x6pWlUe?=
 =?us-ascii?Q?dpSSytth/g66z5m2qgXknu6yr5EGfFo7XDNr6hPcg3tM5I1E8x5vWP0FYQV5?=
 =?us-ascii?Q?u+wLJtCANZ3W5OKYL4Cjd5pk234UOytuEbcH7XBmhzcaIMwaUhkcbTRWpZjz?=
 =?us-ascii?Q?L810tZROppuY/T16jmlSUTc2G5ojJO5zZRBvhwMen4HtX8VpwOJHiedgz2P8?=
 =?us-ascii?Q?dLDTKrfYs8lOQv2ekhY+j8LoKsVo1heFIvvTPm8i3erWc3ltGFkIuSjbAbJx?=
 =?us-ascii?Q?h0ysY+vfTfbx32jFTJly67WIh3urWlNjRgqt1fwitJg28Hm3lsz4tfKFM49c?=
 =?us-ascii?Q?F5GQ3oB+OBeF8Le5NcfGltJsmIZppjflI0H+IrQnarpb6DZoPCT3nMBAlMhV?=
 =?us-ascii?Q?hp4XHcVtZ3y0A9DQHbGBDIHcUchX5B2O98y5/h4XpXkOPkGPlbZj8tjp++t/?=
 =?us-ascii?Q?R1kMCd01kMsXrOdn7VJbWvkcYtyws6zlr1NTx8VbiJpoS6LJtKX93rrReJkT?=
 =?us-ascii?Q?r53oKIlcGKMkUnSPYszATBolFILx2qQNCiQGeeyqrkH6tBm9LiD1CaOho78o?=
 =?us-ascii?Q?Sdx6cV7Fbq17+bXhgSfuQSQtnNjHYoVx0z+eCQzoKBdURvkZMExYhl51u6YA?=
 =?us-ascii?Q?THDAnxDCQHDqP3maANdNyCoQhTABdfhHhg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0085a8a1-d728-49bd-3f75-08d8c770b81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:50:21.0558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZUHt2gVVLEjroLMYwxYUh39amyoLpGTGjY0Ijj8QbKIPWc5fPUMeOt99rXt/Ix7h8fL/R67FjbH9zOw4aDeKRfTjBO0TRd8zVtcMZVwp48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
