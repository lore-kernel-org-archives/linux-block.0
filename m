Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7ECC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 02:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiBNC57 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Feb 2022 21:57:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiBNC56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Feb 2022 21:57:58 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 18:57:51 PST
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3D50B12
        for <linux-block@vger.kernel.org>; Sun, 13 Feb 2022 18:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644807471; x=1676343471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yKP5rTVA6EcgYwWOC0RaVV9EELjCZerj834I6TrmREo=;
  b=LhSIy6uyRNc3xqv6BYtKppIDjzSUS4zG1Q17iQan9V6DsvDcgF7nz06x
   m8V3mBQQpDniTGAe61FbICkpWW9UaG9WBRN6RijcZVPlMLYvFFWn/2o2O
   URKigKP3RSEv4gRpG7zUmCMJBKPaQF843idO4I7wECvTZJNsVBUANvj0i
   h7RWVyqDAXgzcXyKENDVS7PANwdk4ATNXSmuotsdQESt7aFuiHGWkqjVS
   nG6Vw22+/HClbWcGV3uU9kGmm/eZvDCM+rpAOAjHEezArk/YgMXn2FPBp
   J8LskPJYw2LXKBUX83mwBurcb2ytpiZFhVTrHCcay3GxCZehanFGrNk+Q
   w==;
X-IronPort-AV: E=Sophos;i="5.88,366,1635177600"; 
   d="scan'208";a="191759045"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2022 10:56:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUt16SHrcjEDKEKcwRQmd7uOPcScimIo1RvsEFvj2yxeEdbzIN1GdhEMdPiq0cKQm5zC4nWxRXUziTK5JVDIfqV34/i5DwXu5gFKiJ+jYwe8UbSc6veDgiyfTeAmcrB1kET7xjnvAb+Yw9463Zdvo1ofxHeFNCY64XoSD+KPp2bFDkoz7Q+8MDwat+YUbeKNTe1uRA+JWgio0yesnLoy6oV1tW+WkDeeI6WJ9mfKDry4rSgJ/LyEevFGT8Eg1hhN31+wB8hlt1mibWctAoevFSMFQ7RBAhcPw/7+9BHcsvFvzNJ6kHcAALL8dSApkLiqWYf1i0sbc4zvdUeawf8RjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dx1ISqUiCJXEkfdJNHUIeic8N8AMXA+lKhTD3cuXH4=;
 b=oLq7KVDDE3nQP8EFATAJAS3eiC0Lm3Z27yi0xdOSZTBue0OMnOMX/VEsCSddD0Yda0TDagjuTifffzxjdcRQ5QmqpOrlVS1sIGhmOYaWlNkoVSNBYYWLTqzKa8AEUqq4n0VZ36s6a1Dfunevf98WMJyWnZc5P1c7DG5N4AwC+nJQYF/y1S9yhggiHVc8ct4kXlXaJgJUbQSfidRPZ5x/84KVDiik7ESAYfzGQUtxj006xbgbekjPeVrz7t4uDqel1UQaOCGD74Fr4tcpFIypzeNC4AxUhi/H5PuA4PTgCQE6Dyjzffn6zzVkN8E0lkZ65bJ14Y4LcvJJ8nuna9Favw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dx1ISqUiCJXEkfdJNHUIeic8N8AMXA+lKhTD3cuXH4=;
 b=kGzeKy/Sr5DFJOjU5dphADV8AU4Vx/GHbesrTZATTgF86MmcRoTI/JRkX5NnUQf2a4HMTChSiZ1n4dowHSHxJHH3t7XXhtLH/wbli4lfA/SWBZckqkw2F9pwrDkdMmQBaTvB9elW4BKdAvW9dA+OsWQo+P2wv9xIP5uWexUD7cw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7470.namprd04.prod.outlook.com (2603:10b6:a03:2a1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Mon, 14 Feb 2022 02:56:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17%5]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 02:56:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/008: check CPU offline failure due to many
 IRQs
Thread-Topic: [PATCH blktests] block/008: check CPU offline failure due to
 many IRQs
Thread-Index: AQHYFCvM5nj7x3hlnUS+WUVexJHJ+KySdKiA
Date:   Mon, 14 Feb 2022 02:56:46 +0000
Message-ID: <20220214025645.if6ng3m5nrtybqz3@shindev>
References: <20220128094512.24508-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220128094512.24508-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae8d624d-0be8-4eb4-cb26-08d9ef65a383
x-ms-traffictypediagnostic: SJ0PR04MB7470:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB7470CD7737560D9CF38EEBDAED339@SJ0PR04MB7470.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnQV9Qp3Kh8utFyFGArGyxV4QF6SWwrDLfpz7T65ZulvABIFgOX2HG11z5QsCYU7wYwWXsjq9gZXFrhd336ioGisk79LJtnaaH/YIvAuXzdisPudkq9wRdUGea/nG1cwtP5bP5zu89WRR0SQb3+Z3NIJQ5yOzA3lKCGXuczTGNtm3ZM4sNGp3axXuIVIL1firNg1Nv3CyCTIJkDqjdflxUG5DIBRN0xb05+Cw2+6azKVZbVoAxeB/2gJ7ZWINoNX5oouv9qll0dDSlTWko+0SM0TpMM4RU1xi9Z9AigkyC589GJCKyUww9NkhAvJWq1xuB0BcNggElKTVArMRixZbNBnCwarHePT5WhYv2pGLysLTaiepEtAbejJ/0s9dX++B67Kq7BPYaawxQzzbppdhnUPaJz5k9JvrCejEWro+ySpEJNuqKuFTI9+RSD8B/CgoVFwN6QwkWHANtLhb2zjH33ugtY8isyqDpy8qfI9hr9zh7+WYY7/zaPYXWMUNx+vcQaGTEljVIB+CmXtxU5ffoNjUGfSNoyFsfkku1DAZax4vGKLN1ReWVFqaS20PyjCtFFRDGdFFclztpWCoikbwv9fQYLqaByp/T55FExP9PhW9SVYAn1FYZKzj1r/mejx2zz3fJj9GuOBCSYAYB7p7Lduv8tzTyEgK4RcfLnHI0VXP8P38tUroKf7IgHz9BvdPyO/QIP8/MvqX64NHCW9Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(2906002)(8936002)(110136005)(66476007)(508600001)(76116006)(66946007)(66556008)(66446008)(4326008)(8676002)(86362001)(64756008)(5660300002)(91956017)(82960400001)(122000001)(44832011)(316002)(6486002)(38070700005)(4744005)(33716001)(54906003)(1076003)(83380400001)(186003)(26005)(6506007)(71200400001)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZyIPEiC86gJC+ZREp+DQfi7XOb4M1rg8p99/1SnvF9Q5hjhiGP7WHFyReI7?=
 =?us-ascii?Q?nV/14+M0sVTeILv0fACnJgXRDvI4FqiuZgrCnrEscSylmXHgf+5vSBrA1RYw?=
 =?us-ascii?Q?K5DpfTwYoI86e7LfQdlE19IwhjnePySS9Uq/08/v3+ldt6Y8RaFoOyDaoXfA?=
 =?us-ascii?Q?jQq4f3XiFXgfKyZaQKC2CPnEtkB7TFyJV+jSZKhAmaszNbRsp75460AZr8w6?=
 =?us-ascii?Q?lcsL8JIGEfPZDlI18GucgSk18EQnpdzpbvRvHShNUVQsN/k2n1GXMFSdq1CH?=
 =?us-ascii?Q?A+L2qTY3uIrDxUb12RRXV9Vke68QRch4Up7gmUGMnXAV0Xcw026KlYKsYNLS?=
 =?us-ascii?Q?wDhNWP69lFosPHwGzW9wkUjqH1QEBRAXRJ1LJS7EVReITcX5EonBVweqnsMY?=
 =?us-ascii?Q?KtBGlvKC3lKP9kqVinV9b6loa0kynldq5l2NzVX0zVegr91EDOf8VeyhH5g3?=
 =?us-ascii?Q?4dol6ZX2s06T39rGYuZ4RY3Uhl+NRhkfPj/xwn7a/Imwz5qTlgPto1a/vt9B?=
 =?us-ascii?Q?A7KG/MVRG5pAojV6FmRuvKvynp4ecSCWlqZIZwz6u79oYZkYwcNccZ0qfr7u?=
 =?us-ascii?Q?9qnYkXvDcCnCTEX1ajng4YmZEba+2efm1ozqTnBvdAEP2WYygXvc2ffB6PWS?=
 =?us-ascii?Q?Jemxhls6K37OoBZ9nYo1ACv+6ulk2xerfcpFltScgkU6kuLGhEVhjWHvO6zg?=
 =?us-ascii?Q?dlkOYVEs9+GUk4FxWvXu/vDzmAVSDrdvo2toFaEOiHeo+uasTFSu/4zsoBLO?=
 =?us-ascii?Q?GXVR/Zwxf+2H11fFLJdZh+oP7KJyag4RPtnuYAEi4sDiW19T4dDWIdKSnYHu?=
 =?us-ascii?Q?9bQKI56hoVmn3JOnjIUjXctc7pOZgXpV/JobqodN9Yn4MaelrPGsOUyRFn3Q?=
 =?us-ascii?Q?x0XMwZ7e6obzSvlQ9aWSakvCe6/Hd0W/VM0n5Qx1Ee8e57msTfG13Kuhbm3n?=
 =?us-ascii?Q?DjNxQiThgqDjgYhFNjTPEgXv1gEIrnd8/25ah0CCXRbKldTvz4APievwleH0?=
 =?us-ascii?Q?howb5UJKn1rcCj4CPctKKG+b+7tnubs7lsIPhvOyvcr3TB8iO9+IRd/idYfh?=
 =?us-ascii?Q?T+M4MYsg4RPfUWTdiE+1+iO0XhFj+p+DdhTb8EYXuo2XoZGX652af6Sb6wLH?=
 =?us-ascii?Q?Gee96YvWduiOyyXukoFAwksvP/yn38irmyHAVuQIPT5mHF5MDFsi1KXhq38T?=
 =?us-ascii?Q?0aCiJ7OMB2+Wt52IguAJvbv1OWdVAjsu0gR6V/9+LzEgTxMY/nkBPHzqeHwb?=
 =?us-ascii?Q?or1s6p0G54CZeOtyIv0UxEa7FQILF6+sIliTuQVghHKkuASfUczKHTWNWeWH?=
 =?us-ascii?Q?RqOUiezdZLsAeHP8uDUjbJRb4egLl6vhLYF6r5OIx/KJ9ahckp7TUoNckgeZ?=
 =?us-ascii?Q?ldRX0wyTeg90n+bwn3C+3C8vRhi1346BEIxP4xh0P+MyFvgl3JbCkEAnx0sB?=
 =?us-ascii?Q?EzCxIPXxnAZ8fiMmj1JxnSwdvc0bewh5vm8wXnQy3/QxHAo07WkiOZjSVQYu?=
 =?us-ascii?Q?+QlnAu0DytVo4WET6rOOd/Lh/zoESI/sS6XzvSaFGYBSoUYQL3zlAVG6GmvQ?=
 =?us-ascii?Q?rE4irGyOkYTWJ4//nINBBMUFfwUWfuh6+I3KBN177m2e0C9XYKsjS5dHlGX9?=
 =?us-ascii?Q?FwxMapsZDMUtSiIEtDhHSFvY+zc5qnLsCnGEegBuFYaQUS6O0u/gF0i75POv?=
 =?us-ascii?Q?6sg3lf0t+3EJZIbMaINDWHPZVqc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <045D157C57323347BAC51940089EF610@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8d624d-0be8-4eb4-cb26-08d9ef65a383
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 02:56:46.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIrFtk2nQQ3/AjAvlQ5Yj8lAAtJNnXPxU9H/e2aWyQ0mFnxJIGBEm7MXI6KS3t6Q0xpY18/bQzZ3PDoq8ruh2QKzdgovdOyWPXaO9MsIBfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7470
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jan 28, 2022 / 18:45, Shin'ichiro Kawasaki wrote:
> When systems have more IRQs than a single CPU can handle, the test case
> block/008 fails with kernel message such as,
>=20
>    "CPU 31 has 111 vectors, 90 available. Cannot disable CPU"
>=20
> The failure cause is that the test case offlined too many CPUs and the
> left online CPU can not hold all of the required IRQ vectors. To avoid
> this failure, check error message of CPU offline. If CPU offline failure
> cause is IRQ vector resource shortage, do not handle it as a failure.
> Also keep the actual number of CPUs which can be offlined without the
> failure and use this number for the test.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

This is a gentle reminder. Reviews by blktests experts will be appreciated.
Thanks in advance.

--=20
Best Regards,
Shin'ichiro Kawasaki=
