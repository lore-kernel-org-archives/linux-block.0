Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF29ECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 06:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiIAGeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 02:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiIAGeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 02:34:03 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9DFB276A
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 23:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662014042; x=1693550042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jHtsSLa5mKg2KWi4VcKBHWnngvXN3apba0+hVIE45V4=;
  b=r4Ceh/qvSvelfm03pPtfDrZ57mKK+gpqlHBW1n5C14E3OjsGdOJBrkgt
   +GD73D5ZMYX9pz+j6DvZbCTTjsCajrS+Ssjl0rHs6FGX6q1MGjJ7oBrrR
   inXF9NGT0crRbS9Yj+HNt5OQP/n/U3PPVPf/CsGuoEe5qRxhQVb7+M3gh
   6jOLuky1X7yfUQc2dWbh5Nk0L/ymFDvSVzYwhGyHhVm4uue1V4yh3Wa34
   QkeGsStVuAv1CUJ+ls1+A6RVT+hwKckeCxUgmb9p53gxZVDphbZseqw8o
   NTGrttQLkJBW5Y37Ch31vNctXIIVA7lKE9YGpQFjsMN9MWbXm4yqAx8c/
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="322310391"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 14:34:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7zmAZLqPUZ9OkzAfj/Ab0xOqzz+GQMTtSakCs1JMr42TIPWdRJIPMXgqTalrXW4+UFgtDwviMlpEzZWVA8mESZVpyLr/eOUW3x+TRwKhEGTagpZMTBruCch3pPsUKl0MgmlTib1y61dkv176Wkg8U7P4rM3wHmUT2k0U+DhPNnoTC82HJAhc2saoUfK/7na4kLz0S5/rIatPyMltXvvtmlUxI70YMTAB0zpLhqNnRMh5mQc4gzdzb7SjhgzB7c9gji8ldtLpUf1OwgQYVtCjK6jpi6NtUbcKPHPmZyCDt3s8ZmrSuOpGbiaGL8lfFpm63RRmKqSTtngQCWkbR2y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHtsSLa5mKg2KWi4VcKBHWnngvXN3apba0+hVIE45V4=;
 b=bT2vxU6IpDgWL2PEDkMeizyrV8GaSHYdQTwsHx+05Xs545/C3v/N4//7/1HLPR1TiV7z0sHky7/Rfff8sRRdDZJPvHbGccp7P4a3suZi4na6treK9jMUlXpbrH+Xsjc6vDZqs00S4A6sLc9kK8YLu3bjWkJbJKKXRWau+URVxD5QUJAfKo5HTgHhYgl1dx6jGTNou/FF1qqorrV2p7TtgMVqkjbCkFj5guuYsY9cxzOZLFmc5Jvl9H/qyCoDCE6aQMq1+xtwuX9S9e2CdeIAjpDF63bjqCIs8QatJ4VT/loP+xs7DEE6rneP3a613uf84IQAF5e/rl7BQBbfv60cDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHtsSLa5mKg2KWi4VcKBHWnngvXN3apba0+hVIE45V4=;
 b=InKio1zhWemVTSk+lfeJrITkd5RoAkyxZCRJoSgong9SMNrHHKkEj75TWBQ8lBajI6eIFYUKUYDj1v7uPwcdFRPAfMD6L9nJKRBKaH2MOh41D+GSFkHkK97gFuY+lYzFN9vzNgA6ByY/wHlepkwWRfguXTF7dB+WA6JIqRPx/KM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CY4PR04MB0872.namprd04.prod.outlook.com (2603:10b6:910:54::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.24; Thu, 1 Sep 2022 06:33:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 06:33:57 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Topic: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Index: AQHYvPphkzvOf05a+EaJL4zCIKy3WK3JAmqAgAABXQCAARvgAA==
Date:   Thu, 1 Sep 2022 06:33:56 +0000
Message-ID: <20220901063354.pov2z65qtow6isce@shindev>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
 <dc677c86-284c-21c2-ff42-ce40a1797613@grimberg.me>
 <89aedf1d-ae08-adef-db29-17e5bf85d054@grimberg.me>
In-Reply-To: <89aedf1d-ae08-adef-db29-17e5bf85d054@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d19a90-d523-496f-084e-08da8be3f2a0
x-ms-traffictypediagnostic: CY4PR04MB0872:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2TOsIJwuYE1EdEyqGuTjEbeVoBBWgv960ijS1u+WZhbk6BBo65cLJwaCPKuGo3mQEcOSY1T253CbuV2pD1t2n/+erlMyCHlOzoSO7XAH2FFI416q3ADUcVikgYOWZjvOeQGZx3T/ue8z7UyGvFV1jFZVRp6cLO49FF/k1A+l9+ob+aVoiSIdyPF2iEUv59PPUKGEJ09vw2li1DfZZLOd39Qz5iVcM8OfO+dvP7VTT01mlVljS1xFB3pffS3bIH/k0/IejLDh727tUoXFQgESTtMXURKEtWh+3kqFotsqJ8Kr80FT1NoShHU03KTmFPX/aUHNesVcvQyIJpdA9Kit473I828Bnf8nk2uKVlL4O+y1IZTbYpEBOfU1lAAQS7VPYw42dQIL6OUC7VWvTuzMqtWXZeXFfaWb8T4QNE3pEgdAuIFejUCxwzc6Y9rTQ4xD6Bvkw9is+Md403AkWFJ+0xDFefriviFBLPMYGIe2J8lDxIo7YWD93LTmHTugrypRxFAy/SUwKP6eBe2UYsKTzDXT7V503SX+5UucN4ZKVZYsQdwOg49wYOlKOn/XfAOFTBxwokBVESfopsK+p5U9zhqNvHNVemcGB7pgRmsDlf4oc5qQV0YHxxxe33QOVeHEB5lKqbfR7Vy34Rf5LDPIsKfi/GxNZo6vZJXsnRSUsK4g8qT2Wy8ONUy2fWswnF0cD09t00//zBVqMbZ+oKr0j/TEmv0tC4YqWTpCugDE/MSE36Mjeyn3MoJEZ8yRvSH4rxKz+WbqJe5V9z9a0jtZm7T3EkcV7jPUGpGHxjmQ9YfAGeItZ/HWJBx0esRKQpVf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(186003)(82960400001)(966005)(6512007)(83380400001)(53546011)(9686003)(41300700001)(26005)(6506007)(1076003)(64756008)(66556008)(66946007)(71200400001)(86362001)(66446008)(5660300002)(91956017)(66476007)(6916009)(478600001)(2906002)(76116006)(8936002)(6486002)(54906003)(38070700005)(316002)(44832011)(33716001)(122000001)(4326008)(8676002)(38100700002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JUOtwuz+f3/JKd4Oq5fzPq8xa44L3WQjFeZZIHmytG2uj9zH6NNHYi9Stn?=
 =?iso-8859-1?Q?mUpysrjpID+Qbi2qaQ8bv96JKWn2JJ6QOEMpsTWIeT4p63ABIhbkin9mE7?=
 =?iso-8859-1?Q?YKfGv6s8WZUN4uhQ6HwbFbagC6jBUm1IQyAi/jkBRbXJRDK5tiXB37gs7s?=
 =?iso-8859-1?Q?8c/w2wYMHrta+8qEHBSK8ZZEY7ENfuVvwfOwAS6lqqEqss0RA/SLveUHx0?=
 =?iso-8859-1?Q?hyZmarBYhlm9sVO+IhHa8a696fw+0MD48bVW8HWku4913loCbQb94ZWRSO?=
 =?iso-8859-1?Q?E3Hg97DPFH75/9QzcJTXXwowNOc60Wz6i/8Zy7ke7Jvg8PdRT2uTty8lGK?=
 =?iso-8859-1?Q?fX3K+csRSqlt8HFhjPNryP/WdQgL/NYzJ4ac2aV1Mlap3lx1JeIRP2VQHh?=
 =?iso-8859-1?Q?33xOkWOr7w4LIk6mtaJBe8OonY45/nOiTTlFM9H+gzL02+ug48r3h9C+Eb?=
 =?iso-8859-1?Q?8VgrW/C9DIzPyJ2pETfxi9jk6Gghz7MP/qafpNBX/P0SZNLJgKZU9Mk3mN?=
 =?iso-8859-1?Q?0j79FQg8lBWNM5M5+4UXNwqMC4vEhIznugviaOJ52VxHCUzVBojIuixIMS?=
 =?iso-8859-1?Q?7e/g2Bz46y0o5g3vCqeRXGND8sr6EJTxHb1MZoJpaZ9OlWSmb943mgr0Kq?=
 =?iso-8859-1?Q?V4IiEhhtRI1/k3q9MhkV5KjKhH9WjPJOwUh9ggsaTuj/TKlhX/KzDKqN9r?=
 =?iso-8859-1?Q?/oh95RhLA8rSyvInN9vBoe+uLOq2Nk2J1wxP3+UI8nzQDQzr1Uo78ZWMF5?=
 =?iso-8859-1?Q?tFOzwMS97rkOuKpyvz22CJ8hJV7yQyyPTbLkJOiBiL008OhjjvtuUbqnNP?=
 =?iso-8859-1?Q?Wpomi8v7xt15FsCkh1YiaE/DoC4pH1KIknu/cDoPSXBjYSwG6+xUWVN98w?=
 =?iso-8859-1?Q?amWsYVaiQ7fACJwQEPonU40v3T8Io72wi3IP+sUVfmU7W6qDZyquT2cnEj?=
 =?iso-8859-1?Q?nni9lQyhBZ1qo33wPGsYM3hSCG7yBFXZiHlt4uiubz4wq0eOs9uDU6fD6k?=
 =?iso-8859-1?Q?Smvl0r/yl+hoTbLazQaQBAa8FlmmE1EEMUYe5xJaVD0uvrsvSeJSsBOXOp?=
 =?iso-8859-1?Q?dUFhjYd6G7BhSi9el2HoHmn7mJkBZ4tVtI9bPeVsonOdjTo6imgrNSSDWQ?=
 =?iso-8859-1?Q?GGynIAFqCzpvGDUQ8pdLk6nN4CRD+2KPbPXsmI8aPYDwUvLv+gO5ANAq2R?=
 =?iso-8859-1?Q?Z864JsgZHsVssBA4FXPCMhSVTe4N4jCZ6kcI4wMc+kKj4pbwjVJlEhsScU?=
 =?iso-8859-1?Q?3EkSCu5nzZyuiFWVtmhuCJglkKhhXAXtgnKCzag7435V7w6ysm+sAZpQLV?=
 =?iso-8859-1?Q?dhU68KWuIK2KfgwH+xL2p8RGe9HKJ/FuVuG2ak2FTZPsmduWio7C1tMtdj?=
 =?iso-8859-1?Q?PaMIbhCRqaM+ua8xXBmc/F7QteimH2sg2cQ1Ysnn2usHABDRhdPgmq59V1?=
 =?iso-8859-1?Q?lfNBg5uafLXH2t8aqQYbQH1UvvE3e2BAh4mkLfSk58owZl8eKMxcbQB487?=
 =?iso-8859-1?Q?qYaeHUHF1hvmkVVUCZkgH+cqbG5nJs3PH8QEAmpV5y6UThxmEF2rIyy6mL?=
 =?iso-8859-1?Q?piFvNPMtKf4/Z/Vvl5+Whk6VpnOXbF2BR5MKo047JhzqIzvrNgJF9Bt7KS?=
 =?iso-8859-1?Q?O/4kLseIKU3JL+gmyEfeTx5XVKtqATP1u0t1mlQHnO6i1oXeOxmvs55/lj?=
 =?iso-8859-1?Q?FR5Eh0LSxe4Uu5qaJSo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5C35E104C8887740B1352EC93E17030D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d19a90-d523-496f-084e-08da8be3f2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 06:33:57.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOnMtcTb3piAQz/vEmPdevLFjp6nMUzW+lzVvHP3Ui3YTXkSGYbfvl56iVEH5nOSPxgMyR06Ptn6gR9XPRd1iPS5Mr1UDqRD4hSF3kXeMm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0872
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 31, 2022 / 16:37, Sagi Grimberg wrote:
>=20
>=20
> On 8/31/22 16:32, Sagi Grimberg wrote:
> >=20
> > > Test cases nvme/043, 044 and 045 use DH group which relies on dh_gene=
ric
> > > module. When the module is built as a loadable module, the test cases
> > > fail since the module is not loaded at test case runs.
> > >=20
> > > To avoid the failures, load the dh_generic module at the preparation
> > > step of the test cases. Also unload it at test end for clean up.
> > >=20
> > > Reported-by: Sagi Grimberg <sagi@grimberg.me>
> > > Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations
> > > for authenticated connections")
> > > Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
> > > Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
> > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Link: https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e53=
4d2a82bdf@grimberg.me/
> > >=20
> > > ---
> > > =A0 tests/nvme/043 | 4 ++++
> > > =A0 tests/nvme/044 | 4 ++++
> > > =A0 tests/nvme/045 | 4 ++++
> > > =A0 3 files changed, 12 insertions(+)
> > >=20
> > > diff --git a/tests/nvme/043 b/tests/nvme/043
> > > index 381ae75..dbe9d3f 100755
> > > --- a/tests/nvme/043
> > > +++ b/tests/nvme/043
> > > @@ -40,6 +40,8 @@ test() {
> > > =A0=A0=A0=A0=A0 _setup_nvmet
> > > +=A0=A0=A0 modprobe -q dh_generic
> > > +
> > > =A0=A0=A0=A0=A0 truncate -s 512M "${file_path}"
> > > =A0=A0=A0=A0=A0 _create_nvmet_subsystem "${subsys_name}" "${file_path=
}"
> > > @@ -88,5 +90,7 @@ test() {
> > > =A0=A0=A0=A0=A0 rm "${file_path}"
> > > +=A0=A0=A0 modprobe -qr dh_generic
> >=20
> > You should not do this, dh_generic might have been
> > loaded unrelated to this test, you shouldn't just
> > blindly unload it.
>=20
> btw, even failing with a reasonable error message is fine rather
> than loading dh_generic, the problem is that now it will fail the test
> in a way that. requires to open the code in order to understand what
> happened.
>=20
> Perhaps the original commit is better...

Thanks for the comments. This discussion made me rethink the commit 06a0ba8=
66d90
("common/rc: avoid module load in _have_driver()"). It avoided module load =
in
_have_driver() to fix an issue, but this approach may not be the best.

Fortunately, I've come across another approach for the issue. It will load
modules in _have_driver(), but unload them after each test case if the modu=
les
were not loaded before the test case start. I'll post another series for th=
is
idea. With this approach, your original commit to add _have_driver() calls
should work.

--=20
Shin'ichiro Kawasaki=
