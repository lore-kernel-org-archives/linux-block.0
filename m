Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA03C00140
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 00:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiHSAg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 20:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiHSAg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 20:36:28 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F32D743E
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 17:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660869386; x=1692405386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=StIdsCQU7+XIxZ5LHCIfO0ZIY7U7bb8dePwo1S10sRk=;
  b=gJgvPa/B21lKyhM4nO/D0lx80ixa4UqxsNklhlOtSGu/Mch53oKro4E2
   UtTzAHbTcSWT4vu6DqJ3I/25jG0P3vFSTk069yC+/SEmqq6hNfXZy6CBI
   Y0Nc1GLBnEnafa39Y0TmGBqTTeWIbOQmjuQUUIQJcSfhlLNZ49M1En555
   5AlbqObP/rElBCHetpK7Lae5nv2VH80IiY/SO/Hk7EAkq9xmiDWBKNYKt
   YzAsMyugypkDM2dbUVBtRnCUQQOZn7IXcaYPzdGL5dcSm5/bCGuxxfg+Q
   JwQbzG3DxnY4AMSkjrmYh4rtFEEWMrNEFUIb5zrp3CROiPQ/dPS6cOt3y
   g==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="207564418"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 08:36:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDPa7Ohl9FpuycW15vOvQGL/as3AdmdqHqlPASkrUnE+cTilTI4UDggi0vqEfXoJ/AXkUEJGMDru3xBNAvhb27zG4+f97SezWfuM7PzJkOzGFE5d2LhpJ7cu9W256ATXN3P2tUtqcIpVU9HJGwB2pPOuDKSdnC2R9Lx+TpvJOzwQxVm6CeJMGYnRrjzJqDjJA8Ho2e23jQiYTdRiG+l1xps9UlR5yR2JS/IO3CRPGGukqb5AbfTL/VyHTIRW6UZRvwljjwUbtqgKnSMnHTfx6DcyFei2qv12Uitu3d7qXWjN2bGjpvn9D3ys0bb8mpUDWMamanOD3mcqw3bm4FXGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7aQwsYQIJdWigNWeAM7+2VtzHlUOzr9IAgi0Ak9AA4=;
 b=oUVsHBM2tU91yH41Iie6g5EjyMxbQ6jJbq0Nyo9/o0i+r2qe338CVup7y+XEuA5rApb7wSCqI2uji7MKN2JCPTzYilokO15Mt8691/SOpE0Iib8KjE+6yikz2uimOP0iwovC35CVL6zjaLYkq3I5AmZa9THD5bn/X+eShk1xpwpz48YGtWis/zl7BSTUbEimFxuijlFtRTRDKdnl4xE6NdixXBTrOzZbxwD6Dj41oZOgsckYYTWmulsz/5o08sOOjpOocHLp9zKlZx1T4ij8izR7TWICViG1H4vBpR+j0h9Bg4Kqe5OnZIoUIiG0jcqweBvCcwm9DcAon6n9qtvmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7aQwsYQIJdWigNWeAM7+2VtzHlUOzr9IAgi0Ak9AA4=;
 b=nfMexZgmFHaN8eX9//6eqFANqmtvcZwOLU1oMyTzxS9sG2+1ki762KKABNzk1CS2owXr4cQHJjlImXpQSKGPyderPBe/AveChbdnDO6bWgl6738UEb1UytfhwDPIVEzaHUZppMnh+KMsieTMGPSKpzMOqpDe468xvNno6NVraqw=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by SJ0PR04MB8275.namprd04.prod.outlook.com (2603:10b6:a03:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 00:35:42 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::55c6:d630:64fd:5896]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::55c6:d630:64fd:5896%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 00:35:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v2 3/6] common/rc: ensure modules are loadable in
 _have_modules()
Thread-Topic: [PATCH blktests v2 3/6] common/rc: ensure modules are loadable
 in _have_modules()
Thread-Index: AQHYsqGNqsOI5WVJEUmFGYS1u6B0sq21FquAgABLSoA=
Date:   Fri, 19 Aug 2022 00:35:42 +0000
Message-ID: <20220819003541.yizggnuwzgd5xhbq@shindev>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-4-shinichiro.kawasaki@wdc.com>
 <2ff71856-f2ec-523c-6053-9dbbc693a78a@acm.org>
In-Reply-To: <2ff71856-f2ec-523c-6053-9dbbc693a78a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34e30d35-0227-4bbe-075f-08da817abf98
x-ms-traffictypediagnostic: SJ0PR04MB8275:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMjFFgLyj4VJb4iI/xrb79JUHWLZ2IgXIxAyuLDm/nB76wW6XEIepaw2uXk//vvecIBUhDSCFkFKp5EfiMVUrBGZ9gj8hBnJdPtrweP83a6Ro/UY0hZFwdve579lmEXhUxsCs10yFdK9S8rM6oJjbCnlexd5RtpItTzuPlD5b0hRMqcbM7MiZ+y9v4ST3wsfIMsf+D2Cz2DqanNmD8n9ntR2YEQMQPX6aE2J8aY0zvaTse2tEfMINHuPC5rYZPUQUlygGiQ2w4ebROhsTgvCdzPQf5pqLUVDkm4qo3MtjA4a8ZPWNQxRoncWqy9HvKBOggr/Gio0MQdMZ/8lmSqZdFZ50dXigQqGtV0uueNCsyLTApBnPd/Rj8EoW0TXsPNRqGAY0mJwcd9Strpd50oTFiahQC9uUH1pvMPmA1EbPlwz0RnbIOzrQ4NKXs8a5/37XvtTH9Y5lb5BlgEttSXM3cJ1mlug98UKp9c5Sa2egOhBK/Sq7NIL0Ll5Jt/1O24CA0aFIFcWV1x7YCVTEL3s8OPciuoyop1vrjOEVT9wkRjwTgGim5qkf3jhckr93gOyjcJtkyy2iiu6DGZLJ4Vq5UVWF2G3iXtjKjq55j3aKb/Stsx47arICogMiep0xM1GYaUO2SXnMvTXltMiP5umJP6XvQr78PiDmA1aMJI0/MgWH+weel1kzQkBD9RqOa9rOL8TngTiOboHoQpqFCQ154WGh91GLjHMGT9EAq04A5UQ+nN9E6V009hsC88WZpC/lOmTPIDreyMJ71CwPCpZbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(6506007)(38100700002)(33716001)(53546011)(41300700001)(186003)(1076003)(122000001)(2906002)(44832011)(54906003)(38070700005)(4744005)(6916009)(5660300002)(66946007)(91956017)(4326008)(8676002)(64756008)(66476007)(6512007)(82960400001)(66556008)(76116006)(86362001)(26005)(8936002)(9686003)(316002)(71200400001)(66446008)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+MoBt2Es95TsZaMmgZTErkg8eherOqRVXBa2H34Jkc0Z2SitQqOd6P/6KVR1?=
 =?us-ascii?Q?OojfMNktxeFen0FN0xvoIDDKm1eD0syPxObQXEDE8ORTQIG1Zpg+jbLeEwpw?=
 =?us-ascii?Q?ufAPcke1u/Q7Kxzg9PgSz2nO5fZQZxBhGHoObk77xQhmp1l1+1Do9wcU9eO+?=
 =?us-ascii?Q?rF9gUJBbTWTyT6Nube1yUiA6TXoxl+mhPxz5bSqzC3AC7w2s2I5v9/NJvSVx?=
 =?us-ascii?Q?jLiL8v3Ho5o4O1nXTO+uq3x6py8y7NBK0AHKF5gsLPcalDWuTWuzI5uz4Jsn?=
 =?us-ascii?Q?w6ArJWXnCpqXcFEoFrvKud57LYxFqZm+Ka3Do3mbC/pYfaRA7B7PUjs//ZoI?=
 =?us-ascii?Q?2HJPDnrVK3LCwPHCQpArcGMgdjaysYjJbSMPIQQuvhhZDGtvj2HzIGu8BXPL?=
 =?us-ascii?Q?D3A9K03u1Wr/xyPUo2EApb/bXjWGgCXRUM06MsaxQnCxcxXyjozhYMSn6j/S?=
 =?us-ascii?Q?pxA7vswNNQ5c+cmKf7sZEvTJSXFZlSOzwNvym5/KwAn26QJr87hyROMvnPUM?=
 =?us-ascii?Q?CPWQ9EMns7OT72/wu/tthqNHHsM2AUfacM4UV16EWtQNfgD0iLyJkiEXRI/i?=
 =?us-ascii?Q?d/ba8DdFFknQz1JB2Xl9t7yVNQQeHlQnPolPVmdfIM4ryT3YcBcr1OSQU8bN?=
 =?us-ascii?Q?8Z2ws+4MuEZc21mvOEg6D6fJiONJM/bR5gQdv9+fSST0rkqZflrK+bLOOIpB?=
 =?us-ascii?Q?e7u4Kqe4OIaKj9MTQrCmhLhaP2nA7Pw0pYXwNgXMTgGBxtDkFfP/ixAB1HNS?=
 =?us-ascii?Q?0gxPC0oQNkcdKHUYas6XwtsQ3jVwMztfJeA+AG4FPpRbztC1+c1nKF7CjlGs?=
 =?us-ascii?Q?hW4gGuPTjRsfokM5JeO7bd+kzJrCK73f9/2qBTpfy9+eyB5ADphsmLV+lVBb?=
 =?us-ascii?Q?27LXkdGjm4hHW7dG6TjOgrHCR5clQkbzqEUvIiTqOiSI1pkXmj1/oJXq9wc6?=
 =?us-ascii?Q?/f0OWV7cI/bVgH3WPHofSAYZn5IsgA4jS6RaheT9MAfDtR5C0MY0mSkeuDtc?=
 =?us-ascii?Q?cNiKkN5iWoqM5X78TFvte9AQfiXHqJ24srTKBw9G2W1Q5Nr2FHs7oiZGO/Lt?=
 =?us-ascii?Q?LlVrJKxNpi/raVpR+GBtYL4EToXs6gsbNJyy14F6rhO/nP+NUJs/7SXYqezq?=
 =?us-ascii?Q?UAEpISokLdH6f6AFSRemc4IbqWfgX/35KkjbtEtOQ8MnMJoYh8XMEnfJogGx?=
 =?us-ascii?Q?S/hd9/IzMcBPr923oCz939rEQ4C0ixwosq+7YDiM59N+6aKd1HYzfg8cHDPZ?=
 =?us-ascii?Q?pNhEPyYXzXESusM68/day1TF9aJsVM6RGCAx6qIjTqtkkkyRqKHXaa7DJjqD?=
 =?us-ascii?Q?i7qfu5joKw0mGVkhBRPUCohCFqx8n85SdN0cwqzVQEbDEC3QXUZnffuE5Huf?=
 =?us-ascii?Q?vsEp2YALYLol0rsRmI+oJ+RB6/dgFiHI1hdnd4xgH7R//h140HMYj1H4t7wx?=
 =?us-ascii?Q?xSSM4/uyH9NitgQ/8SevWsw9H3fdrNMoXk1WvYeBOD454hFU1YqGPoPbNfje?=
 =?us-ascii?Q?mG+Mjo1WJFTevAUOo0rqB9705jF3D6V+5duam4KWaQ3rFRHERF52Xw7a82NZ?=
 =?us-ascii?Q?3tTtYU0h6KYXHVwDgiZSXAKbIh5xsE8pGM6wYSJKwt4IraCoA/QZXd4JA+GK?=
 =?us-ascii?Q?2zgjvIPRQMuF7SrsFcTjaMI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AACF6D7E64747544A25B0CE672908236@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tHus78lR2VTFVjRWoyDAciEWnMu1ljqlfBO6sxDNJYTPzl+cptBDecNCje5B2za3O9oAUPnZB3VlCCGp38nAnAyvSFN6vLibEiNIYL52SEXoncTcv7QwMo3kz4OmeAc/0iaM21aLwF8Kcsg6IapRjF0XBjroM4tNN5SPu9FMlSlufDr2BrHcs/skEblW2+AQbad0w7kCJrtzHzg7TbgkNiTuVvfssfCQ/SdEtvsFWEMYMPZ7aJ6jau27lu24jCqVzcG7NVI/Oh6AB2y82dCiRaxKba+gWn6NKKTfHnCtlHJvdG+ldbrhhssYYHc66v7+sjL6fEh3GkG0jmNjxaZCtNBO1C4NDpuXittzlGJqTpNtZGQfi6d4edP7IsYKWU6qlmkr3tz3IF56PYKIagc33VPT/0NNu3Vjxl0plDJnRJ1HJcbnG9oBVTAqYmms42bxi7WakNY/rx7EmXdU5hkzTssuYmlFxxUkMfmvSxidisxq00EClta6MSWtiDQ2XhwlRihlOe2L3CLvgtxYW44Nc8Nz4zjQtox8s9l9bT+bVxUxML03Mh78kaG9PxIH8nA7mlz08lXOfnHouJees1pHWpIhnFu4nPpMDlWXxUhSdO7hYlxOcKp8ZPrW7VY5RpEeZs1z07nHAfpGYU/M+8w/5wKEjBmThY/vvzbGOub5pjWa7auoqghhCaWYnan5SktvnYmLvzOWAkCI9JzkNtQZuzA23BWwBVqOQ3Y2HkS07jznda0SJVSteViBTXpWzK7JrIaYf56LZJ0I1o6g9dzc2Uf+ixDw2GwwhGTPiJgdiatzuwHSX80Ro1yM/MiXMfF0kACWMYqfmjDVUGBP+F1p6Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e30d35-0227-4bbe-075f-08da817abf98
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 00:35:42.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mM/vq1V7DGyGpUpgorAott/mcjBngdRwS2wJCL9EPzv+UIAqIry7NZIH76HHIg7Tqw5jyzPsj4Sn/hrdPaxykAEJAi9sd6RomyQNHYV7xJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8275
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 18, 2022 / 13:06, Bart Van Assche wrote:
> On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
> > +	count=3D$(find "$libpath" -name "$ko_underscore" -or \
> > +		     -name "$ko_hyphen" | wc -l)
>=20
> Do all Linux find executables support -or? It's probably safer to use -o
> instead of -or.

Thanks. I agree that -o is safer. Will use -o.

--=20
Shin'ichiro Kawasaki=
