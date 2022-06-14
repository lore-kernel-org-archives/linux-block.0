Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A82C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 07:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiFNHFR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352930AbiFNHFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 03:05:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487CC3A190
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 00:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655190296; x=1686726296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J3dN4zCN1ll0cxDbfXWNmhB0c+9R+iM1jZljALcOOfU=;
  b=K2WQRDD6iImZn1uTAE1aD2wCsW5qarAvou/nG6stMYoeKJXCNi68zyaw
   JssRasE6hxLppESEpr9iVcvRvp8lt8BZIeHV9JFRHv4IVBGpj6sU3Ds4g
   NTfCKcdgbWHkWUap9jmnMoTMJoa5hXXmjMmYTipxUlB6Zn9rQ3LHtIDTr
   O7Pep3gqKoQ4dgfoUKb2/60v371x/FxauJRi2Gf8FRudd8RfM60Pl7t1q
   9Lyh8YMY6/7LRpfMMN712cNXDBnJDvJArU4K7YWsAuty4uq4TUPordsTM
   lTCTmeBUJtaxsGROvxU1HX4NDSTYdFsarfT1SUVPY9F1cGNSbZsdhCRgZ
   A==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="207936252"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 15:04:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6PTG6CICIkcB52WJ/VHqM7b6HGFf+ixJlIVwEAuYYSQLz1Y0yaiizAl7OoSq8/LacU5DrXEI4L2AscMS1nm1HCqXe9Luv4cGjbMmEAYHHAz7sjU+RvCXDIqADB3Rtpdhmyi6fWsQkFPCjODeXR9C7VakzldqdjVJr3xODoP+YPEo/Vexmaz4NNR+wq8/tJZ9eaQJZaAMnfitXM2DK29EF8MdVJdM9T/dTylAPRb7keEelZU9iyRWxG7NshdcE0v9hBF6m6qOxw7lNzArRf1yb1SkAPSpRqXf1WsoSc8wlF3iucmkMsT8CFF4t1p3sSGLrQLZoHEknkWAz7PSfh/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3dN4zCN1ll0cxDbfXWNmhB0c+9R+iM1jZljALcOOfU=;
 b=AcXj7v29V7YaJSnffFXjls8jotIDkveXLCa5YH4CNssNy8xOC2979rUcvIPfkWeM4PJ2DDnxPxqBUD9i7ZTASW+VCrYw1mwX7HrCSISpBAVaiD/Jf48KqoTmaNb0zW6jDd+NQsnC3+tUwbjC8ip2j2fDi8RxgIKQR8R7y+g/OCE8dZ3Cr9Sgz6fbIZz0u5NJMncWua8GvtvxzGw/IpxzhrrPASDD8av02GK563R1JdUU9H7h4UADuMBcb7AJxAGxblfR3wdRz2Sptpsw55ZaAoHmbr97OFfRKqjKj0h6ynZ0aIZjkxvyU/jhgC08yGnN0Z0qVF6yXa01AdlWhQ2w9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3dN4zCN1ll0cxDbfXWNmhB0c+9R+iM1jZljALcOOfU=;
 b=T1u/WPS/L23oYfxPlHWVjwM0QHbcHyX27G5JQQQrrJtBgWDNbdP/x7tViJPoMQe7b3nLEVX50XsZgRFMaUriNKscztRPbCbB36rZS0UpBEAfZXYnRUZn0oDKolz4a+AcgfRjYiib1MtvUxCb7wdNblpujVwQXQVJ/6mX2w/U+Bk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5270.namprd04.prod.outlook.com (2603:10b6:a03:c5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Tue, 14 Jun 2022 07:04:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 07:04:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Thread-Topic: [PATCH] blktests: Ignore errors from wait(1)
Thread-Index: AQHYf70MEAYM8410bECfhVCFN0sjpA==
Date:   Tue, 14 Jun 2022 07:04:54 +0000
Message-ID: <20220614070454.5tcyunt53nqf3y7q@shindev>
References: <20220613151721.18664-1-jack@suse.cz>
In-Reply-To: <20220613151721.18664-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49d84908-fbbf-45ea-70fb-08da4dd42f56
x-ms-traffictypediagnostic: BYAPR04MB5270:EE_
x-microsoft-antispam-prvs: <BYAPR04MB5270ED176EED3E417218252EEDAA9@BYAPR04MB5270.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P65WFCHjbYl5oHpE4o72RTHGXvm1unrr1c1Xt/cj52SchzJ3Ppv01vgCjlOzXUgl5n6CFlqEoIR9YPrZzy5BbVAMpFrPTO/tWKWruqAOcp62e0+7wNJYf7lrR2+aW2DlZ7Ne2oXeY+dxAEtSmKCIuS2noqsHvkqHLABIW7xMhcswg2bPOqR9x3VGR85UuR0mkiQ3jq0AlRVi6Ym5bkK1SbGtExAg7nRXGIYqsNYocvYPJwYxxtBMkGD9oegM9pcDPuZ4/U2jfskCQwWkSDcH4oZ9mq5DxnEeTJhS5SRsHY+CZPi01oo8tTHQaEDKrRqmrk19wriqac33fTLCxUB9k1gn1Rp/EJ+RatHNsh+DbSC2t2Vx4L09kWSumO5mQqbYBc+2eTx3FMvhKVd/4rwAk/poPPBTsB6kR2ei85SnHGNvxu3SuA+CC2Na92BKE2ZDlx1+GAVFdOW5CT+XlFrViqJOrFoIj2r0/WUSFgMA0I+i09e8u2o27/HY5/HYgmAePPKtBGzc20pbdEXfsJciqZyJAFzhcwENp5hD020ojwB01Lvc67vCo8VGzZJ+EPoxONA5iR2kCsm0pTiHY8jdYveASuRsx3dlCkbmH7w8xc6zHwowxvCjx7WGIXQHH7zhF/HwO/dUCJ8jNfd4XHRlSea3vNvd7FmNRvJCbVJ+z0eKvohMVO+jucpJazaKjrgdu+CnAP9j1ujjAmjDAGUYOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(66946007)(76116006)(91956017)(66556008)(64756008)(82960400001)(5660300002)(186003)(8676002)(4326008)(83380400001)(33716001)(6512007)(9686003)(4744005)(8936002)(1076003)(26005)(66446008)(44832011)(66476007)(71200400001)(38070700005)(86362001)(316002)(6506007)(38100700002)(54906003)(508600001)(122000001)(6916009)(2906002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Dvlt9hibgkbY82UMPgW9Zt+x4zlkkMDjBK47hLw8Vwk0Lgn4VDxZC08vJPs?=
 =?us-ascii?Q?Kp2a/FAyF4DLuDPbQZ4/SuHDKOqfFcQ/Tysg0k0YA9WjLb2JzJYX+UuJrmv3?=
 =?us-ascii?Q?cUfrlzkFlycknJAyFbpl0t1uTN3+7dSuEoPRY+6u5cvgkJxceTJJM8KE1YyM?=
 =?us-ascii?Q?bPr+lTEfy9m1DqRLITQxTjwrgOx9Tw21YX1w87xeoyg21y8DE/mwnIay5E57?=
 =?us-ascii?Q?wAYPKFtBevEUP3ej5RykVvZCxofx3RbwGF8IaRF8Qu77xIR2kB6O6zAgGprN?=
 =?us-ascii?Q?STStf5DxtEC8TTwSVShLolAY2IzYW63luo7/rTj37jA41DCj+fanbRNWzq/o?=
 =?us-ascii?Q?q9LXqq+JwIvSg75N2tFufkxysUQhZLYiMAb9niisogGtOaSi+i2LNwLQ9VoW?=
 =?us-ascii?Q?3pRbrj1JiIxV5fA20k8LtG//c9fg+oNMuuwOrpoLqyx245mIFkIGJNxBqxv5?=
 =?us-ascii?Q?YbmcHNut5FPHpZ6gemzDBz4xM/UclIVEOHqlQjFPYPsQFFNuvEaSekoNF+7u?=
 =?us-ascii?Q?TOkrHNoGQhANIbwZUniMeDuEHrDu7KEve9GjvVoNajLmWJbJ1iFSeSDYLWIg?=
 =?us-ascii?Q?g35Rg5oz+5vDDxI2c2vL6YFi4ncy/NjMO4KD6u4wOcRINLtJeLe9opH4jsbR?=
 =?us-ascii?Q?ogCc1w0DKc3jxIH72eMMZ89ffSJGd3lTi7VJhonCWItNjhEsJELZINqtEfvZ?=
 =?us-ascii?Q?/FSiz4qmPSplBBGCAK2MHh1s1PdRPf4xzFelDmoud/+6yy+KhseBYsyIc61h?=
 =?us-ascii?Q?zGsq2mcYgjgOq15svszta5Npmmt9/7OsAB+PwReBopiVQtH7H3QGyvzkaUTY?=
 =?us-ascii?Q?WTrxhgEg6lfk50IXeIxwtLiDsg6w98/VZCdSP7oJwOweq0PAr/keymLNgMy/?=
 =?us-ascii?Q?EaSgzCLbnGxuvFo6sbu4ic4p2eVTNdrhnftUfjK0acWX1EBnKDTgw6yzfZEN?=
 =?us-ascii?Q?zpKwVE4eKd/1IVCWkaV5MQZo/UhnJgt1sJeA9l0fpNGYEeuZIcDWFDgCQqvl?=
 =?us-ascii?Q?xU26L6BP0TKz0BDVix4ln6msElUOUJNIFYzn/4/eUe+5tnLQAvRegVDtxSkb?=
 =?us-ascii?Q?WsVuPEfs66H/UVgUkUBudrt4KuIoZEKa58wSEr8CpFUhd6a4cAbJTeGPz5T3?=
 =?us-ascii?Q?GEsxCnu/SPFCV7RjC6z4kgYvrACWIuhcQ6PvO84fzYtYnbKqGyUemdUBL8Oa?=
 =?us-ascii?Q?ZwtDmpZ160qZ81kgyFnbF9hhoPX/I5XbqDWQlS2e5g7I5lHeGvLXHHbEj+qS?=
 =?us-ascii?Q?offD0Qy0zEDfi24FbjSjEhjDU7OmXUOuSKv48W+IcLDqc/h3Z6iEj5KCNEF4?=
 =?us-ascii?Q?0S0qw6jyDcS2UugZKcdGWzMWO1Yk+EbrRhMtbKyUOXMSdsVkeieGsEWqfdWR?=
 =?us-ascii?Q?5yPgl/ZSKTOjoddn4Z3nfddKww2eMoShSJPITaVAbHneGclGmteaWW+oBGBV?=
 =?us-ascii?Q?9G/o9Lx4fiVlQt1BtmF5PEMDJwmzx2Ab6ITYvGBdCOi6/kZZy5hnrHDvnuQx?=
 =?us-ascii?Q?9M/POGuouQnUBMQMT9a3JFnER56V+wzbqD6NRSCi1YlcbfHWt7KnM7b6gvan?=
 =?us-ascii?Q?xzThhn+20rhnRi5Ag9k1yA6bZ3Yl4xq+7usXBO1MXiuQuq5OzpkBvmXFfkfk?=
 =?us-ascii?Q?AcgzcUAk9AnRyE0ly5TCZ8qx2qGYinjau+Zqhz0MN23emED3W6437T0l9/PU?=
 =?us-ascii?Q?ORlX8vTC1DM4EW167CKcHPwswITWmXr8GmVH8ApmE7G8kQV3z9Nu8oLiAuG2?=
 =?us-ascii?Q?dfLNEuDEj/jayZyMN9XdKhFJgHiuaAKVXS8hRfBG3wm6XQIEVTbO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71CD577848BF3E47AA6B1B8116BEC8B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d84908-fbbf-45ea-70fb-08da4dd42f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 07:04:54.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xklCbDJybvq1Wy4x0AKKJqN/SRmlqzs0JjvWIFYM/YbEwTokSwnxwTB8Ksk34Qmlmg2NVPLSSTQ9BTTY0ViJS3451nG2RLz1Ys+JjexDyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5270
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 13, 2022 / 17:17, Jan Kara wrote:
> Multiple blktests use wait(1) to wait for background tasks. However in
> some cases tasks can exit before wait(1) is called and in that case
> wait(1) complains which breaks expected output. Make sure we ignore
> output from wait(1) to avoid this breakage.

Hi Jan, thanks for the patch.

May I know how to create the wait(1) complaint message? I added sleep comma=
nd
before the waits to ensure the background tasks completed, but was not able=
 to
see message by wait on my test system. I suspect it may depend on bash vers=
ion.

--=20
Shin'ichiro Kawasaki=
