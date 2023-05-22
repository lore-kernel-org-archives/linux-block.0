Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF71C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 02:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjEVC34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 22:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjEVC3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 22:29:51 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC15BB
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684722590; x=1716258590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NKEhjZuuLe6k8t3xGtRBRlj8jkxrGXGpF1w/zhtB0VI=;
  b=SToFPFq3/4b3qosnkK18VnAzl1pdjpaADlROfAUWOVwKTc1DF1xERsj1
   WUqo8qRGzSYEryQ3+rGr77mTLcJj5portdXeOqyYSj3i6g2KHq/WdztL6
   yMk7G5RfJvsBvr87P5WdMmCCEQ0DSn2dqaJvmx0ufBdapYVPxVO83G4aK
   m86gJgLLwVrxK/Smveifv+ngsSas5YWCaCFoU82XbODGjY47eh63Kby1I
   RhkwJbpMb6/HJzol2/MINkDr2bc024ju9KCb4/JgoaLCuq/5Ol2ys2QHB
   1kTETJI4w9xMDLMZoie7+KONXphk9C/5XrXMVR2HZPqKM+Tm950W4p06n
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,183,1681142400"; 
   d="scan'208";a="335773719"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2023 10:29:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfCIPu/djERIr3lNQQGBJw752kNlyNXFA+8NadpYBSg+U+4ahI0TNcc5U8pUFOAOpslUXnptdIDOOK2j+dxxORWnixv0hQBt/zK6yi49sBPvox3GolV5TWX8D3bJTQ6nviZ7vXRpIOdjqrSRi4HkHGXTS5zVDQqW//YyTx2XYLV5OwTMPvzXM1AprTCUFlhHxUekTsjHAtDXQ2f8XslYmyPCaA+V/DrTYaKSdCtiURG9/wkQ7uByC2sxp4KlScf3P3jZCgSHQTubuej7NNiPoDKUYIzksAywKG9X66WqTml7H/EGM8ftNHKy0wn5dp3VKzfmRFCmkr3NtZza7qDwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab82tNVKtxgR4/xZKz0m4Q7PQSIefa1uJK6tXpNCQdo=;
 b=hvRQ3G23KQCg3Lg6RjZY3M114eXHcYHxSgUBKaphE9nSswqWqEJXTmdraLVuuE/c3vrLcC/wG1O8tLLAg3Atl76r2nrB2/uKg5u4eNn0GXQlQsv5+KHiHEUMcnMkUwTTqVAJW9w+QJ25IlsCLiNoHiI2VhJWcp+RUUHQUm/VnnIDeWB7CEvZbnLEX6Pcs/81ipyXL3nioPDW7Puoz5ftdDrnJgSHIjVyW8Q2ekvvEKb7CbnUN78HNj7fgHpOWxoaMO3Aiu5jI6GAabWdWci6+EDUGsOcoLtDOkOfPqnLsez/XXg3fVPPdni1RRY169sBmB1NV5Hj18KlxO8EBb8ygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab82tNVKtxgR4/xZKz0m4Q7PQSIefa1uJK6tXpNCQdo=;
 b=ft2PWxjV9jcTYTiLwQWOlDi31XLpmduH/kJYNBhfsKoMPEo8XoZep5Gr7gQtlFA1nNnErlPGYIFKJ/b6DvWhuFS2CqLVyiKa8XTrPoy4s9zJqYVh8esdq1vCOp1ZJDCh1GNWWoJtXxRi1k7jrzAN06SK/agdQygEh1DduGO1550=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB9004.namprd04.prod.outlook.com (2603:10b6:806:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 02:29:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:29:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>
CC:     Alyssa Ross <hi@alyssa.is>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] loop/009: add test for loop partition uvents
Thread-Topic: [PATCH blktests] loop/009: add test for loop partition uvents
Thread-Index: AQHZYyGblhmMwse/rUqzYHkJFKxu768eHzuAgEfFDQA=
Date:   Mon, 22 May 2023 02:29:47 +0000
Message-ID: <u5eipqt4ge7lmlzgcadheycyoobx3pitc3ay3mg7an3wngqtu7@oq3lp2xovh7x>
References: <21c2861f-9b7d-636e-74e1-27bd7bbb1a4f@nvidia.com>
 <20230330160247.16030-1-hi@alyssa.is>
 <20230406103003.u5j7m6xqflcli7y2@shinhome>
In-Reply-To: <20230406103003.u5j7m6xqflcli7y2@shinhome>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB9004:EE_
x-ms-office365-filtering-correlation-id: a1d6f4fc-a74a-4582-4132-08db5a6c6947
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0jizR1Cjdu9g72eidEnb/TpNjsVd6131LtTGNOOBCrU/+tT10shHx4INZTXgCPkmFPk1koxwjHcB5XaOuPL3KsIkGL+PS5kfcTe5GqkgDrh3DGvcBQ3/wCcJYsQmgU8Q+q5Y3uh/kzJoYk8NTc6QybldwFSmSWs4UDfSRWPPpH9MbRiaH132bTLZoaac/YE4tcahrlHmCMIP+mgML6Rooo9pi3FIy+s1Gd/5AdElv5FTYtms2EKztzDZ3LF5O6/HEqGV25nU2Y5DSC7OJncKF9FnPPQ9fwAuRkEeCYOAbGca2oh3DtEGtaLwokNWWX6gsj2AwKA8FnYzGFu/Mha6pBoCvlAGvRjJjjsLlZJPupF6PoOPm3RbI6BSRczux7IPxWtLSWRG94KAqFr5iu+iRQi0TffWUhqX6aa83cUJdfvxaKvN79JF4xCyCaM3UQ81UTFq7f5YQX3ZeeRKUi0nxOfVx3AhVa7BqJi+mGoq/qsEklhT7Ntcb9B2iAzi4QI9th6uQXBQHiItsf9cfVKdLvKJuLPBZrlY8lSYGsNt2/1wtiYOojLKHKkZED/Pgs5l7ZQdespqaWRXKJQwc8P7ElmU0CDCy1mlRD96BQEbmJluKmIhzqTzu1wLU/7XkQT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(86362001)(83380400001)(33716001)(122000001)(186003)(26005)(6512007)(6506007)(9686003)(6486002)(71200400001)(2906002)(82960400001)(8676002)(8936002)(38070700005)(44832011)(5660300002)(54906003)(478600001)(41300700001)(91956017)(38100700002)(316002)(4326008)(6916009)(66946007)(66556008)(76116006)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WVck/T5d9TuTLLcxVZslTC7hJdrlcJyfPMVbxDxRXy9AkaZBbLnlVNMuOiXF?=
 =?us-ascii?Q?wIBmvSMrz+v72z7Tcmytm2TOJZQfbRK7uCFgiH0WAd6cWx9hk5R6bUcYOZ4C?=
 =?us-ascii?Q?ePUvNuK/bkmA1xryMLnXTd3/KJ13n55Q6uMd5r7vnso5E7f27uro5fJMpug5?=
 =?us-ascii?Q?3/ibfWCzwSyYuyB5WBehlIyJXbeTzLgU5KBTjG0fheWb++j5jadkXgKEz9rn?=
 =?us-ascii?Q?En5sYmK5ZoO8gOVck2LKdZHvQrCe3s/6D0wDKqKVgXT2ndpjDEhDFyTy3m4+?=
 =?us-ascii?Q?oJ3fwBGIUXbiYyaktTV6smVyWgC9ftc/CtKJOazFmsstelXtGqznnmTpFUyq?=
 =?us-ascii?Q?/oyRCufHhNfNGwwjiAUKe0xGW2mhfjR8Ie1R3xIKdl9AzRksSzhnXyw1ctJP?=
 =?us-ascii?Q?532/sSay2Q7BIruEaMFeG8ErgThLX0DpC5Sn3cAYKY6oMDDIn8qX9sxJqmhh?=
 =?us-ascii?Q?W2YGlHjmOPJnmLVugfYQcfcXiOId8tU5Le/6912jCwVm252hOhG9AKHsq9Kh?=
 =?us-ascii?Q?kjX6NAztE04CUNh7JCvrzSnYobwhbVNPnM3LP15Dn/wEToTvkkdiKb2JDGaS?=
 =?us-ascii?Q?1D4QIMqhMNx5vGvuvR9F2/UBN6wU4diSTuwL1ZhohHAo52Q4IVSAGAgXvkAB?=
 =?us-ascii?Q?uX5Hp0W5UDMWkwBimArAr81eToplXJpcCojIw14iVgyntEnLOAxXUqtQMSpQ?=
 =?us-ascii?Q?Ns/ZfAkBSCILl1tLFrq8nRDmcP9t9+Evs2qqGX93fpb4D6ps11dLrkr14EQn?=
 =?us-ascii?Q?Bu9yVnfu6KIEwDNYT5yS9LEP5I/skYZTh7RSKBDF0whmXnDSfwnLaCb8+Eer?=
 =?us-ascii?Q?D357Gl5beNZBEnZ4WsFgci6mAl/CEOrJUADTrLhal5R1ErBb3tvxk1hS5CBC?=
 =?us-ascii?Q?wsxShUq1n3oK7FuBjsfNfmc/WpEy7uEG8ZZFkR9EFc7zh2TbJ8tnKTN09/kP?=
 =?us-ascii?Q?keCvwGFnOMxxFxxbEzqGUlxBfQjshYcj3OZSPz9ATzkP91Svx/vgz5Tv9coS?=
 =?us-ascii?Q?6ErOlNve12Zy0QfIPgJ2NQYa3j3tv0+50FF+e+WKSUqSNfXHSzrFCsb4lAEi?=
 =?us-ascii?Q?E/Hc+yNcDtHQ1JKEfYO59Asrw0XzqMzQMRZqOq3qhoacEujRVF8uond4v3Yu?=
 =?us-ascii?Q?/Cke/iGujB/+Iomy7koeSlSrJvN2TqK6DtYhIDOfpRW+0Qyf7DwtJ6c1p/ur?=
 =?us-ascii?Q?T4ub6J4rNrpmxBRPSCM3GcbwVSUSMEbrXcu3KcyiDP4ZOSVxgL/ZOu5xaZHz?=
 =?us-ascii?Q?zHNQXgh3XvXapCbspEYtInx7Zpue6p9LIdIaUdP2xDg3xLKAbZVJ5oqoPpnq?=
 =?us-ascii?Q?apBcDHFu0+2fjp7lrPsl2Vjwns8cheH/yBy8gHUbg6E2DFuLNn8RKUMGwZgn?=
 =?us-ascii?Q?W8gB7ihrErf/w8obWfYYe6ZiJ4v2BYAx7P2VsA6kRLovdI1U5hgsLSv56oEf?=
 =?us-ascii?Q?Nj1satsSyj1b+6xdzCAQKRKOT49yZZNiQX/XTY8x0jsrezIe14yfAJLyCCBG?=
 =?us-ascii?Q?PKfhknfsGP9a1yaXLw1h5lbc/+4pmCJX5r5FWAO6ul1rIeRoiZxe60A9e0Uo?=
 =?us-ascii?Q?jMI+f/b/8o8fnw+kEXIYpQ7U7zzWksJz/nOudNdXcPCSYZRG796MYrlO/f0c?=
 =?us-ascii?Q?qiQkN34AtY+L5vkwu5nFBzI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6CDE7AF0EDA8E74EAFB3E000B0154F31@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e14ALs/69TnKzURqF8onxPudzmZl5//YJ6V1aPENyCPYJOqxOuiRv2aCb0OOtZMwwWY7+HfIS6Ubxs1A6EIywkK9f9fv4ecl9Rt+XSk90sp9CLPrVuP8Wmp96fhyYJHEdYK3HRfwL3smWEZNgRwLjuxZ+xb2R+/nM/FsaN9sk1TzkVByFy32M4dgZDW7qpvNWeTWZKXQGcJmw47xmv5JAhArLn/sJ70KeesrbiSrqsi4GkbtOCK8heSCezXI8INppXRtYp88mLa7JqkqdblLCjjCy/3SbZZzIZxbb05GnEPM6x7HNbbQN5kxLeRQ2SBNW9cUTnEJRSVivmllwugZvBiOknTcCJq7rJcGh6bs+hRzsz0RwtZN4mnEnZuol1dYDY3AWfFjoJd424EFd+JttehJ0R3mPIlCHkaBPdjXIEt7oyl8L0Pl+2FMOVLH474XEWM4TjlX2nQSDt15MA9PavK7xRJ+jD/0QBtAuaYZKXJXb/3HDSA+WE7l7FQiHjvNKIiODHLLG8pWciyRYBm10t+bXgVrM+BsopUir9O87DsxRrXGwTkuen81H/Za/WquzZ5wWSWHyxoeqRyhvOZG20fn+hudY6S7oCraDZmVOIT/3AkzL/iU8mh7OpwMrR+nGYDaxyWeJmqH3Igw94boosLHBJ7MLxBHANVqOhOOegcNllVOQS13RKJedqzDV+KOkTpmSobIthqpJS1C54NCkIlLZWYfdW+bcB5xLwMKWlBC+xulWGluTKWUTxPNah1Bke3Ermg82YGvJNbhbN2uFtzGRqiKxciSi0pUof8d8FdBEvBQWP7uVVJaWCniGV03JzBRUOPjd/excXxZd7SRfJQIsEweSYk38qMDImD06ZL6enDsi/YrDMkMnnjkyhR8Py/K1Hvuk7NRbSHN+b9DfCLxqoLg+Dg+78LsNorMiL0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d6f4fc-a74a-4582-4132-08db5a6c6947
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 02:29:47.1857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FL3mp7D3HQhkTaoum+mMtB8GM4oSpAmCVg02P0GsxzryyuONQFFDsNYKrquLBJgZ1rudH6CPezYwxeZXLU0ShfP0XhZhMQ8bjYMet8zKr/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB9004
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 06, 2023 / 19:30, Shin'ichiro Kawasaki wrote:
[...]
> > +	# The default udev behavior is to watch loop devices, which means tha=
t
> > +	# udevd will explicitly prompt the kernel to rescan the partitions wi=
th
> > +	# ioctl(BLKRRPART).  We want to make sure we're getting uevents from
> > +	# ioctl(LOOP_CONFIGURE), so disable this udev behavior for our device=
 to
> > +	# avoid false positives.
> > +	echo "ACTION!=3D\"remove\", KERNEL=3D=3D\"${dev#/dev/}\", OPTIONS+=3D=
\"nowatch\"" \
> > +		>/run/udev/rules.d/99-blktests-$$.rules
>=20
> On Fedora Server 37, the line above prints a failure message because the
> directory /run/udev/rules.d/ does not exist. To avoid it, I needed the ch=
ange
> below. I suggest to apply this change.
>=20
> diff --git a/tests/loop/009 b/tests/loop/009
> index dfa9de3..2b7a042 100755
> --- a/tests/loop/009
> +++ b/tests/loop/009
> @@ -36,6 +36,7 @@ EOF
>         # ioctl(BLKRRPART).  We want to make sure we're getting uevents f=
rom
>         # ioctl(LOOP_CONFIGURE), so disable this udev behavior for our de=
vice to
>         # avoid false positives.
> +       [[ ! -d /run/udev/rules.d ]] && mkdir -p /run/udev/rules.d
>         echo "ACTION!=3D\"remove\", KERNEL=3D=3D\"${dev#/dev/}\", OPTIONS=
+=3D\"nowatch\"" \
>                 >/run/udev/rules.d/99-blktests-$$.rules
>         udevadm control -R
>

I've applied the patch with the edit above. Thanks!=
