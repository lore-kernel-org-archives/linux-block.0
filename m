Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCEC32774
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 06:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiHVGZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiHVGZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 02:25:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE1012D20
        for <linux-block@vger.kernel.org>; Sun, 21 Aug 2022 23:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661149537; x=1692685537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=94Y1pqjTC9hF+iRWRZQuS7Fd1jcku5g6wecsJpN3ogM=;
  b=KApufU3plueAemg4aoAfnleSNWlCGkgJQ7oXQmT/F3/lKgOifmAjs/e3
   MBMy6Jj9My6grx73Wcjo80huWZhxyQ1wdoCa4Ln64MZHLM+Iw9C37foxt
   FQBIF5d++CWTZr6fCyZIBkXkNUzL/Kf5n2/F0l4/ByzT1NN8llDaSN4l1
   FmZ8n1TkO33RdIcbAHJ6vXcJ5H8LMBAVbIw051r1m09Vvuwi4ntsK8YHr
   5WU2+UHLrMYrHMJFEXxK50YCOcOPOdUf0ZPsNNYnTkU9VbJ2eOxmB2b+Z
   yT/yh8wYoP92uadQW3nM1P2y+Yfb/DZYZzQwbXDFyjKavq2umikGRUp9Z
   A==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654531200"; 
   d="scan'208";a="313576507"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2022 14:25:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnW3Jpby+0nq1x8FoSA8Q6pu+o2HTiYpLPUT53MIm+G4mz5E7ugprLsTU2xJiiM4EOhMh3MFWqgAdncgeE5FeA07eZ4KadliZSpPOQXE2rzeYtJmoJns6/QktLTNuCLTxHylM+xBBRz/ET8Dx4PD6+suxhzH4D+eeYyrNFwlbt9vdOqyryJ/S0GuwHuZB5hey2+lu14byudAl6qHZPkekz5Yuxf0jfIPjGmw550+BDmyILXDy6GXI6jaPUVTRzZuHifhsBMbun86u0r7yLgsomPU1JPjxjXdyaikK8kNeYgDpkR+dllOD54FW2BZhUL+Lhm9zNw3JjyVPuPWHXaKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94Y1pqjTC9hF+iRWRZQuS7Fd1jcku5g6wecsJpN3ogM=;
 b=hA4l89jA82eIMCbX2wuySmrbotYr5OgRoDqLQtFUJvTBDTl7g4XwMPSxq/ZrymTxNqV/LauKwEgJSR41I79ROtGMgBPSTsfXVjfrpUm/RF3oCGqMWvT+ae6mHhTVAI9MTK9Z3fVhOcCH9gXy216WFpdtH8A/oDeipEsU7Rhk+Cp7A0P9BcPfpKURlXPbmv6TasKQj6YhkHNoD4cQi2Wa/IKbVAL3CMIVPPmcKmrlTsYo/zCiB8iP/z5fqF+zwCUdSZ+4E1ueUneg70okHzwS2YnC39NolQg6NBmHmtuFUMkBRHspWOOe5RlBcu4mDFVvAGAmFjN6M7wcRzD46hOe7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94Y1pqjTC9hF+iRWRZQuS7Fd1jcku5g6wecsJpN3ogM=;
 b=B7Ogafb/l5xACCwwsGoebgU1yjeLmjHsY8F24XIH/RmJigiMQC65m9rd3m1x+YQjTWi2foKjI6p/4R9+CTPY3dKnFNQemuMPN0CBS5MQ537pdZD7ZvPHAUo4sSxH26uTCv/r+Md+Al0yoM+Gbfcx/6ibLhlIRfr0RfVCuC9g1qA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL0PR04MB5105.namprd04.prod.outlook.com (2603:10b6:208:55::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Mon, 22 Aug 2022 06:25:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%6]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 06:25:32 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v3 4/6] common,tests: replace _have_driver() with
 _have_drivers()
Thread-Topic: [PATCH blktests v3 4/6] common,tests: replace _have_driver()
 with _have_drivers()
Thread-Index: AQHYs6+U6JmLkm1njkOeFqHgW8QFra243EoAgAGcTAA=
Date:   Mon, 22 Aug 2022 06:25:32 +0000
Message-ID: <20220822062532.6jqtrpxharorhhzh@shindev>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
 <20220819093920.84992-5-shinichiro.kawasaki@wdc.com>
 <20220821054952.GC25878@lst.de>
In-Reply-To: <20220821054952.GC25878@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a16586cc-318a-4f77-f2eb-08da84071e02
x-ms-traffictypediagnostic: BL0PR04MB5105:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pED2j2y//GVEuxUkMBmhydqg2JRpRQ0mNDmbhgWiS6WZgro6xu1Vlr+Q2MImnrMCQ8DIeNqHA75hkaw43EEwBfpCgmm+BSRHdttUsYUntqXoeYin+GDBJqU/zzhO/JbzMZlvKRRMXt++sVnUAFUbn2bH7KBVqGDiTQPLN4nQ93oe49nZFvtBoxosKvRJQ0Fe4AJemXWLJ2iRPvIFgW2mxcQ8cEdYwCDVuMTybtJgybqtDix8RuUuoFXHBxxDt6AH+jsrooXv0oiD1G4L6gxLOdmVVRUKoNqn40es4RWDhPfHPhPszCnEEq2/18gwDzZHzSNEwrAOHGoCdB0I95YEQugw2shjN8TPimqvTDpbMt9IoTS38etFlYvSkaftHvEKpU6zDeGk2o6vmJuoWBG1jIzJYRya2Tn2hzIwzlmTbIENtZGWsVNKeuBB9NuCxw639N53wbV/+FkhBbZ0K8Cydswc6o3A0/tiCUgTjOqIrF8aTRGM6cpR5/npCHqHpHYjh/rDOZtxXfhyBN1032voyuCJQeFtPhe3XjdUUrJKFkEW7NnCgbB3c2mCRzwm3/EPtsqRpruhQvcsTqIWBg+QBrwaDq6y0wOkfwYkVqtPu2+fpEsR4SqRZheG9kKy3FACA192WrW7BPY0GSfChZwVZbDWMUf7Dz6ikfm0cq1ZiXe8yfwpLrMSWLMhvpR+wK+Dcy+CRiI98eT1hWzmL+PCns0iq5m7ezbRQgTUH+KYK79gIK29JAy9egbnsM23wekD/6AP74n83SbS4LtatKW1aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(366004)(136003)(346002)(396003)(39860400002)(6486002)(478600001)(316002)(6916009)(9686003)(26005)(6506007)(5660300002)(8936002)(71200400001)(4744005)(6512007)(44832011)(1076003)(2906002)(86362001)(186003)(41300700001)(54906003)(82960400001)(38100700002)(38070700005)(33716001)(66446008)(4326008)(64756008)(8676002)(122000001)(76116006)(91956017)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sLrAw0I3JHLTvAgjpIj99EZ7poC9F4rJAAOkMsNDBxmdzD/6ZjKikbcIVNMO?=
 =?us-ascii?Q?oJPOknMdhsll3xP4N9sSU7u9Tfo7opcW15fkJxkAj7rrsw7Jo6DoK2iJcT2j?=
 =?us-ascii?Q?7xqmJzxWe1rhAVTzFiBliGWxZXvtBCXVNxCLozbwWJz7LlUdEyHrZmNCkYBT?=
 =?us-ascii?Q?32MSVWIezZXyHR0i0wcjLoY5jA2hCgtQXniKualY6LipKMZuZtSO11OLILqd?=
 =?us-ascii?Q?ygWI0VfGwLfi/shYyHYjaDpP2gBft2190Mo60YwAxHdcOQarbWCxhZjrl8gc?=
 =?us-ascii?Q?iC6GVopIv1MeJRdK2304Zqk8KcaTRge2Km6nOJjMifXCGCIWISYdxEGDhp69?=
 =?us-ascii?Q?DujQtqFmTdFkHiEEHdfERFVAgmFi3XJH4xZUl5gqqi2gVa3nifu65LVsfcbB?=
 =?us-ascii?Q?ugbgvloZFSre0L3D1CIa2Ico2KcCJ4foB9PsMsIRWhWXf84cvvAJbM3o89ss?=
 =?us-ascii?Q?YGCdwok7+Mi0PTgKKUaNQzb/zvYy0bQhAlochrD/BYva+3PHPcgahmESPRk8?=
 =?us-ascii?Q?xp4gUHMTh3FbN+cWymq1k7S8VJuJZu2xSCqKcvLKCupVbci3CRVjQ8qeI5UV?=
 =?us-ascii?Q?r/uzbQkLq9xDNNDVpQnGdhuYwnGMPoX2pRHwPWWA/ZMPes0qtdVPWRCw91RT?=
 =?us-ascii?Q?IyNXDBZn88Y7Bn+oQcckvGWd9BtpANsNYl1cDXcbQE2q1nNlKc37IYdYzcPd?=
 =?us-ascii?Q?5EOUCtqlknPF+uuliSiq6+8AR1KGKOcihfAoTwWdO0EA842CMEbWEA4HXnlN?=
 =?us-ascii?Q?oF4LXHZk+5baIq3hrFMvXZBxo0/BHXOmCWsvi2i0XvnhXkzszREE4AthP5Tq?=
 =?us-ascii?Q?30AGiWp7a22nnN2w+lfUG1dWsP1KRbuluSNgAd9NNdhOTscQowxq6/IN1Qo6?=
 =?us-ascii?Q?m0Nd7Ily1lKC3r/uA5opasxQbSA9FNIPcy7PJ0eF/n2cZVuMwCawJ67sBqMs?=
 =?us-ascii?Q?IhlUPCEvulcyNg5pt7LA4WHzpJ3xOBoiBcwUDlJdmz/nBwGEhnIfCUzXCA16?=
 =?us-ascii?Q?fH9XulaLwPhRhAittNZJqIfeuL26Ycr3/ykB4YeLtWUyC1S7VOSPjbtTbO9n?=
 =?us-ascii?Q?8HpZyj1muE8YR99jUmiPSCbvbK0Jbtnze05+uN0rBjC5S1f6LQ/wdqzVufCU?=
 =?us-ascii?Q?mX6EQoMAmBB4hJZmrexIYR1i4YHbfe13DrOxywqsLDok4qXQjfwSvTJymX1G?=
 =?us-ascii?Q?kH6hQqR7zx0dLuJDXPOIT50pB/KLOAXjZ465ePBThdyZn6cONGCBIXlMDPjH?=
 =?us-ascii?Q?DMUjy1DuOhee4SZ0tTG+/Ppzy5As8uOKUFy95KKjmWP6v92WRSJv7uEurIY8?=
 =?us-ascii?Q?T5m/eXSz9+BXDgZywjt1zeSZqCmo+cl/udQJ5Kj03NVZQKlJjpXiAt0Gd3UI?=
 =?us-ascii?Q?XdsBNPw0V2STvNBFQvmrV2h37ci2UcDMibaf34F09438lACDsSSIDHRrfSoh?=
 =?us-ascii?Q?RIODel8WHwD6mz2bc1guK5HXkoVM0h8H/9rBgsMYV1ccG2LaSzhlwxmM02HJ?=
 =?us-ascii?Q?LHtneLg+qC47zCmq6Leo9CGeUeEsZh8vk+NEW17l09gVzDWX+/SiGEIL/lLa?=
 =?us-ascii?Q?XbBEGqLxtDbd5xVVEHfwdv3ZrJ2sX+xXyIeTDwbYealfaQsMC5elrJ6HAeVE?=
 =?us-ascii?Q?lsTCOMn2jpOmEclZQq0AuT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D2D815BCB622746951E1510C972C914@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16586cc-318a-4f77-f2eb-08da84071e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 06:25:32.9337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCfby8YJzmXnEsO6yWewAb6gkTjqCMor7GXzo15jiMLcKiPfS93EC2ySEa5WBFyl+beB/AXXFC6zwqodVbxVVP0MW2jCHn6EISqDIpUwTzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5105
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 21, 2022 / 07:49, Christoph Hellwig wrote:
> I always found _have_modules rather strange as multiple lines to check
> for one driver at a time seems more readable.=20

Okay, that will be a bit simpler. I'll drop this patch from the series. Ins=
tead,
will add a patch which will replace _have_modules with _have_module.

--=20
Shin'ichiro Kawasaki=
