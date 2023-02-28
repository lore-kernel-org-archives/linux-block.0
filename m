Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17D4C64EC7
	for <linux-block@archiver.kernel.org>; Tue, 28 Feb 2023 04:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjB1EHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1EHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 23:07:11 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565BA1E9E5
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 20:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677557230; x=1709093230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WQEC+233zIr+aFgpVz/h4cMqHYVw1rh/Yx6mgRrDNFA=;
  b=akIIV9NUuEa7nKg6TwkHUysJmcMQGrk7qRIG5K7Npf1buWNRJmcrTlAB
   f8vO3lo42j5KzFjC/vpYfPgXHOGACIrG1wOxnBVOwoHtc5YTgOMfW8eLI
   vMGOAbJ8eSjnahiJx7+tsvtms6qPFUAKdiryjhzmIRT8g1EZyFEYLcZxs
   jwRjBlNfRCthL3ZP6DD/2H14K2PnfbhHKgrY1ys6n7qGR2V8vPJbeTuh+
   a2Vw9T6BSrhWK/hf+hBJ+kt4173QTBy7LbNKCGZ8GrYfcFR+r4lvQMpfd
   IDuJbiR3oPMtBUYrTMNgw3jcfi/FXN9zsE+a4ZSCzww4VixhyYHc6pHhL
   A==;
X-IronPort-AV: E=Sophos;i="5.98,220,1673884800"; 
   d="scan'208";a="224387734"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 12:07:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RheobVsHCHkPfJmYi75PjcIsWSz7XBLIQd7RqTpjtX7zGa6O78Hxwv/pQqKiZVDKhHA+ZPcd6ymYWcgp4RC5qF81NKICXo9Pm1u/UFLuIv9S7MsVjbafbP9BLV4+Hno+ZFjGGrD1OkL9fpRWW0j0IrI9XqJkvUzn95D0Edm4629Ae4MlG1jgqmpvqhMhYkw+A6T6EfuopGLgNA8IK8YlcZoUQsfbYv5A5SnpxQddojmz/jCxlZuIL7+L9Y7Jh84xjbGDc6SY7k2kcdsKRq5oTbzfgwo7tfCO57+P2rTr78E3e+MdB9fNaXcF6f4mBSwkE4hfgTSo87pYM/swo8lHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUNlERgB+TtqgSJdszzawH+ice8RdlvxroXN4/0tnbs=;
 b=T0AJrSVfS/+eOlWAi+wwrN0u4de6Pm4oWwpffe7w+cvCl6GXcaBkcA+5adQpop9aMiInPYATrgD7O5o+Cy+z8oBRFkUuc8umPVgkQdwGAnaA1v0fNKWCHmCl1Gqu5hz9NQgbv+v13KpoS8vrCqM6AU3UrRAPwwBshis+TiKrp5HQgdzDl+Gpgp2MOwuw9dHfXeCMfXDTQWDTWwNj6eNJKxLDyLesU+pAdeTs9sNeUvglgTpu0NCQaj6U6tqASzVUGmyy/K4+G8CX66p1EBPc6HvwswaHrZ2Wi8l5TEh+wP5WqaTO8MjuVWsLoHmPzOeRFH7Zlbl2C/skcVNpkGxZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUNlERgB+TtqgSJdszzawH+ice8RdlvxroXN4/0tnbs=;
 b=GpmQFfSN48Ec0qbwXk/WU6BeE0lfSqTjJB4qhsyIf//5UKqufDy8jOSA05IQ6lgZxK8+KsO5bC2IDE/sTBR4g19CGVmzrKveM+8LI2U2aaN/g+VWVijO3+Sejpw4XUul4KCQ+ETQejaOHH5N5ILXaHVeO2mfQNNELOC0plgpqhA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0208.namprd04.prod.outlook.com (2603:10b6:300:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24; Tue, 28 Feb 2023 04:07:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%7]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 04:07:04 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests v2 0/2] nvme: add test for unprivileged
 passthrough
Thread-Topic: [PATCH blktests v2 0/2] nvme: add test for unprivileged
 passthrough
Thread-Index: AQHZQC95ye+eMiEgFUKCkwYKThw3f67iYrKAgABY7QCAADCbAIAA56CA
Date:   Tue, 28 Feb 2023 04:07:04 +0000
Message-ID: <20230228040703.5zqrhf3d7s3choss@shindev>
References: <CGME20230214044749epcas5p4ac6bf441e046e3642b1633fd9cf7a72b@epcas5p4.samsung.com>
 <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
 <20230227060547.GA25049@green5> <20230227112404.gzvugrzc7drqhomz@shindev>
 <20230227141802.GA27506@green5>
In-Reply-To: <20230227141802.GA27506@green5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MWHPR04MB0208:EE_
x-ms-office365-filtering-correlation-id: 20e043bf-bf07-417e-4dd7-08db19414019
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1Fs7wuPDWzuiHbtzjTOoKHj0RFYX/R2Ubz+SyDKz9H9Sql3Nfr+Cp+XMt6aU/r/gdq3kv0xf5k8daBcnEhNTyLKMhCI+z/hg6TIQBZQIVITHgLtoxNvG4+d8SMDZuQziTNGEFPa7nqmqhqaqGn5sq6N/988QqGYujwuTLaE5RMyvE+STZbL0jVeLN3Lx57SF6FIpt5emQIg5PT0YdTNdS4mWW5OVWGwtqiJ0lASe3mXeqD9R5tjvAssQAD3akzhe47AC7W8/9ngjGB36eqxzlOPHinZcVvKGNCei0wFNLdZ/v4QqNF5vPMaBDnC4ERnoSB0NGac8zMVniUrkc6xUHKHauRFm3p4WcYNc+mPfZOkt9AAfJEOJhpLf3JidLV5M9i1dvF5nwqFMOL7Ymq+ivOC4df75zcTGTnab+Mn8OlmYnR7kbec1vItBdjarnB2pUqgNYmyA7XnTtdLahGzIdd4x8ZIc+3h6TmyrILIPnikD+znmmTf0b2alCJwQYHhDqV0AyiM5WwXeaEn77/11teSlzgtPgW5k77qg5HWQCguWEnJelNisSP7c3RE3U0kQPDypeO4vgnrsT0bS9RA5hakWNt+M6m1g0L8c9chUmignKlyKKIdg9ojS6ak9n53xK+9ee8YONvPW967w6ZZ4Ah5A9PNHv4hxjLBK1CScvkQ/oWQbrjW6YKmxbANdm/BYH5MregaRyGOlLEXHFNQBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(5660300002)(41300700001)(44832011)(66476007)(316002)(83380400001)(71200400001)(33716001)(8936002)(66446008)(8676002)(4326008)(64756008)(91956017)(66946007)(6916009)(76116006)(66556008)(38070700005)(38100700002)(82960400001)(478600001)(186003)(1076003)(86362001)(6506007)(26005)(6512007)(54906003)(9686003)(6486002)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YPTFgP+l72hd6GRbRTmo8LUxmY1MHm+ltt7YR2nq5yzwrPVShy5s6H0wer6T?=
 =?us-ascii?Q?+ZKnPzwEnu5n9DWIO+5EaX0y0b8BXmi9AIa7zQKB7/DlljGzIHHKeDRWQIrn?=
 =?us-ascii?Q?gOOFWPtn8F5GlrRNGlTheZrwzcKaNl1tQ9/KrW1DfFb8Q2FeH98ZPhuY0uW0?=
 =?us-ascii?Q?7C4Ea38ruZmAaiGIRhujKrC13QC3M6YEXM2bUBH3dGrNRBMeyGQL2BrswDYz?=
 =?us-ascii?Q?M1hV/sAbSPVfm3kjg3owY3FLlRvqS38qH9b3gebL71O73XBHCcXuOw5xavwM?=
 =?us-ascii?Q?xMTsHhe2O0nytOoPRQ9RlwDSEB2jxfrEhY5zuSR3upHl49UnfBWj4ancpQV4?=
 =?us-ascii?Q?aWCLXJgArBDR7gUej4dBFjq7B/Puecl5dqPXbbjTCUK219JOoSAKCx9QCro+?=
 =?us-ascii?Q?t/8VWZGisC2DZjIKQQa14soxIGryFGkhQl+L5YBBqbPrx4rztp3YwcO59Nh4?=
 =?us-ascii?Q?lLk7W83mSarEK2bmXkOAaJBY3c2yD74EPpKDhQ8eUpwoWP9H2pQa2EAhtVIM?=
 =?us-ascii?Q?lmGqCTD03F8YNkJoWL4c2L3+v0a9muxB+cDCjLr6BEJ2OdKUauyIaZkFV2AW?=
 =?us-ascii?Q?q4Z3jov8L6IfjJXADj5cW2VV2ymQrcG2KAG06goIIZMscZRSXkEOzaHoUQ6r?=
 =?us-ascii?Q?3Ac1Md4XJ6Pi1uDLo6JPM7L2fpeZOsCGhlbyx1C+wkiIGHpqUP7FmL9+aIUT?=
 =?us-ascii?Q?2aDBIiSDAOEoAbZJM+tpL+EtH+oMcf9SNoTHy+Z50+s4K/xAnp170FfKH8Tv?=
 =?us-ascii?Q?4Eq9rQh9LLG5avHrO1iVhJSYWJ7Xr4pTIz05GDQlemway/gPkym8i0Xi2T+0?=
 =?us-ascii?Q?ySY3qMOcqRea6rjVGKU4C2DIrMjDpEs+tcAX9+cfh94YY9V8Nuru8FRkl9S1?=
 =?us-ascii?Q?jT/2DVkBSyopOOCDPwtX4Bd0H64sXDPkEQWE8uaWfk0kcX0B5eN94S0R4pxD?=
 =?us-ascii?Q?uu1KFoVVD2XKwvoyvLEdt6rRz++RleAgS4Xs+62AzQHXnzai73aniXQvaRzk?=
 =?us-ascii?Q?tC9q9wmOD8qGql9Ccr2bHrHxn/zYpNQzlv/ymIhjgqzmZly6gnAM/v5iy8Q4?=
 =?us-ascii?Q?iG3x5TLDuOhr+CctH4QhWY52HIudvsvZXigWyEaEDIE0BZJ6iJDVbOEoZhXK?=
 =?us-ascii?Q?dFzBV5WRG7nszjhZeWLQslV+51v7Itx0W8LWVEJ01v1H0rebdkFJZVSHcUvq?=
 =?us-ascii?Q?PKVqOToy7EXbMwcWIvK3569EHR8CiwCYePHOkXigy7kw1bfE4c217Zcw+7hG?=
 =?us-ascii?Q?0tNOm+WW/FDBUzdPo2kLS8qKMIfY0Thz8t7qjgjBJWrBkICfoMSv55b0lpiE?=
 =?us-ascii?Q?1iNOKQFLLKziSoOZjzF3n18/fHc1S9TSy+in5NDIoKITmeuvzo7wh4OsMbMf?=
 =?us-ascii?Q?h5LHoQvYLDaLrLqio8voa3fvg5CfyS6z/ahrM1Dug8N/QyBDgm/qc9fD7tLo?=
 =?us-ascii?Q?UTdF1mGVVSwDcS2BqLMoh+0hf2MpB7XP/cVeKmGoZ6Wv1fLMK5O+k+AkV0t3?=
 =?us-ascii?Q?AX2AfFrge3z9jBGN6pRJOLVjM7PH1XqmzuPcAq2Pi6z/wI7oOqoWvPHh214+?=
 =?us-ascii?Q?GS6phFc9zZ/vXFoKReOhC1iFQM8ya/3xewkAsPTdWpC/d0ICfPYh+x25wvMM?=
 =?us-ascii?Q?7V7P0inhDUHDom/0b3B0hKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D5C52D8581B04F4DB72ACB1BA76B7614@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hl9rODylBqikhGLzgs58ueuyjnspi/EH2YTvgcAQMOPtwHhzeiPxHKSGD02IZK1pRGp883ZJI8+f4w81EooEr9KEdCZXUhSDBE+NB0XT6lbEwwCxCk0O2Ka5gcz02DKt+Glk94B/0CVSbaH7ZFQw3IEjpcLtAE42uRoHedNO13xo8104vzrULFcYbOEWlKFPY1fdopIK7fEJwgdkXWEdwrPmlFuTobATXuNlMhRPOIJ69uChzoP0ds7GG1LKJfZ2b2XxOqUn9jGAtoDY1QSMfKHHyGA9tc92F7D5f1VDThQXS+TGsRZ7Vdm2gV0ibDl55wJ6TRBNPHqlBzMMryblJ3sO3SbHS4Il29rL5jDreZbfVXGCgauG0/+Usoyz590zfLh7ZQLLCbLUfJAIJl9bj8104OV47vdJBsN2p48ZBRtVFxr6OY9aTP8al0s8g4/tfLdipRuzFs7WAM5fyJmkNk785viv/pvngYlDP/UdIIavuDpmeVDVzHJfuPjlJT6NyxdPbc7Gx7wOTcyD2qoko3VmQjVVhrBNa8yRRG19GMldnrAYu0O+i/qWOSpfbLen5AfA8i7GKA34yQ4N8tO5XIMeaOgpnhvggS4NIn6qevowHpmOZJ+yC5Oil9U/Ykz4V2xT0LVzkF9Lhthpy2Nebnw53xuH+lfBwAYKNqQbiVKUPmrUiCzcXoXC1OEnUDa1dqm4/k0f4RTkwWARIlh1kdeCvw2ofRfdQegBsOyC5AjlLlw52PCE5MYne9sbnuLU3AVcvbgc4Mr3H1djNNuovXjb+t85yDDG6pTGx/QalWYtXSjb5t4AM6KKjfs7CdJr30h6S/NJw5/+DPrl1sWffG7hNGIrJFZ4qdJCPgvpnLEIhU4w+5FIjwBPdwhHP/MB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e043bf-bf07-417e-4dd7-08db19414019
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 04:07:04.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5acCGeVxjg+4P9mZfvOhAmWTKH9UzocCteyZRFDdAH7V7Mqkr9QD6P3S2bA8fx2nhMD0dPrhT3XFdHUxOjch8NeL6joGNZTSF8gg+kszFho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0208
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 27, 2023 / 19:48, Kanchan Joshi wrote:
> On Mon, Feb 27, 2023 at 11:24:04AM +0000, Shinichiro Kawasaki wrote:
> > On Feb 27, 2023 / 11:35, Kanchan Joshi wrote:
> > > On Tue, Feb 14, 2023 at 01:47:37PM +0900, Shin'ichiro Kawasaki wrote:
> > > > Per suggestion by Kanchan, add a new test case to test unprivileged=
 passthrough
> > > > of NVME character devices. The first patch adds a feature to run co=
mmands with
> > > > normal user privilege. The second patch adds the test case using th=
e feature.
> > > >
> > > > Changes from v2:
> > > > * Added the first patch to add normal user privilege support to blk=
tests
> > > > * Adjusted the test case to the functions for normal user privilege=
 support
> > >=20
> > > Thanks, this looks way better. And works fine in my setup.
> > > If required,
> > > Tested-by: Kanchan Joshi <joshi.k@samsung.com>
> >=20
> > Thanks for the confirmation. Sounds good.
> >=20
> > I found two more minor points to improve:
> >=20
> > 1) tests/nvme/046 does not have executable mode bit. I will add it when=
 I apply
> >   the patch.
> >=20
> > 2) I ran the test case with kernel version v6.1 and it failed. Does the=
 test
> >   case require kernel version 6.2 or higher? If that is the case, one m=
ore line
> >   change will be required as follows. If you are ok with the change, I =
can fold
> >   this change in when I apply the patches.
>=20
> Yes, unprivileged passthrough exists from 6.2. Changes looks good.
> Thanks.

All right, I've applied the patches. Thanks!

--=20
Shin'ichiro Kawasaki=
