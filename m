Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C19C77B73
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 09:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjEAJPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 05:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEAJPu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 05:15:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E31B9
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682932548; x=1714468548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xEhiqomDVOwQThJ3xYyjfumY6ChIj5P0SN85hzy+QN0=;
  b=baBm+4rOLSSJulJxqAiHT79Dzf1ihvHARMT4aWwIJ1dQ6haLOh5z12FX
   beQed36Xzs8io+8ndTn18NIv++GOtWsx2C744gbgc/kAzWOIbS+cPJXXG
   AzUDQQNUhrj1AqZA2j5HJw/qavTVIoffwPkL+4yEqsERtaKk0pGjBNwfG
   e6sIo53+uL53dUYZJNNmYw/k9Cy/UIxgWb8YJJmTK4tAgpqj4XaQFaJJ9
   7i+TcW55Ty16E9gjxI2DQwY4D4HchbRz75dxlhj+EGQnYC7G9AAUdVnXJ
   Uh1RZdQi1AFADAtHKxhN1i+0qIMdp5dl9Hx8hOegEOBIqr+yJx8xwPUlp
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="334057497"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2023 17:15:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ/Thb3IpaiABptYjYJ+QT2apYEh4UkHwvkJY5lPtXKGccmfnxEa5FFQ8JmUVDI8r3dvZfbCjLxkL+1W/qZD4LoIxgH2MzdEBWeGG2HuTqo/GECZW/G398PSMOlyiEr/9DW4loz0w/3yvpG/1MEhFUVlxsmaPUUY7MRi5f0yNtAUSolQ1xtterQS+wHS6mWBcD1V4jFgp8ZufMJLKLFZPVc4xGVyPxmmbJDFt637cdJorkau6bYgmS4Fy/ZZ4JH5m+LnR+R0LwKx5myNnOeDajUV/tkP3CJAj4STxq8sBE2zCKSS1/mmKzbH0wt7ElZEWpWJ5OLWOv5S6EiTZohcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLhyH39F7rkHNe2UD9COxhhWdO7Wyu9PqXwXVdaZcG0=;
 b=hqCOC9kp5+Qc7lobUqotGZjVBYvKZ43mbqLXS4VQ/mflxG6QbYWraVY8L38UYICMxv4ytLyqpGzYBfcbQN6bG369lhLtR20ETSSTMlXSo4+XIF5SsSePfc0nHwd5UoWoJrVgHC3+kVwiAK0NJtfRmUOemcifwB98tljdOEBxCvx3k3cWvDAE3bSj0x69g14BkrskdG3GQ8lhyL5Uq5O09SHrCMGnrZU1tKSquTeJ17E5QkbIsbxxngpBtxvCZPCLFeWlrogi1US+nHCQ62DwO4Y3IzDy+iaxgHRaRMqouJBKt6EIBRbvnLTJtj7hrffUG+P1Fz4/4ePkmw7gxC7yLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLhyH39F7rkHNe2UD9COxhhWdO7Wyu9PqXwXVdaZcG0=;
 b=ndoP2fYNJFju17paozZJbnD26ccf7b9FCJSvGrv+HUxCzT6bbbWJEiyvrTezZ5L+oUfpyzikVTHXNestlMZ9dQpn36/EoW53YHKuDBkJZdLHnHQcMACGihWuvQdpFQy4+9bZROK43uP9XwLqI7ltJNannAWMJD0pb2pgx5KVrAg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6365.namprd04.prod.outlook.com (2603:10b6:208:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 09:15:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 09:15:45 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/2] tests: Add ublk tests
Thread-Topic: [PATCH blktests 2/2] tests: Add ublk tests
Thread-Index: AQHZePPITbTVav1gIk2XYqrPw1Sqea9FKRuA
Date:   Mon, 1 May 2023 09:15:44 +0000
Message-ID: <txwfssn3y2e3nbly7bsexecinrkewthspifosb2ciovfezrhug@je5tuwymtv3a>
References: <20230427103242.31361-1-ZiyangZhang@linux.alibaba.com>
 <20230427103242.31361-3-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230427103242.31361-3-ZiyangZhang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6365:EE_
x-ms-office365-filtering-correlation-id: cff1e109-4709-4e0c-2dc7-08db4a24a4d3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUw86RbV9EchgP6/FJCXmi4JDPUHd+yt05DoBmIk9o5anuT9cIqco2Fqy/Bia1Usf11ljp9qOKSlwr0bcGhT8Dh9VPrYU9hlamBLpOJ1kuExKXcK9SLHHEU5WQlQaHX9Zd7HWdbZap2MbMopLzzKB5SQ1nLZ7FgGa2rPb0azDQycAmgSTgUqoFsFX6dkx7BNgQ1x4UT3aBHr/sSu9GH6UfPAbCJI+nZFveH9ESUtEYG0FEl87nAzKHgTgCZ4HKRinwKsPRl9X8Os0WvYP9oQPpR8IJBeFi7+1/Bmgn4jlFy6yC9lwFXFmHKOcIe2ZGIRJRuWxQRqVm4J811h+9/BsdgADE8frZY0VXo3chi/M1HzeI0ITV9rOyjEI1LEDXMav/6B0XGlCjhDyz+P7m/R5Oq2P1+VRj0BdmTvUMKkzJfZXim3YHaae4gFemwdqtX4odn1C/q37NsUjmClmY9xT04Nz3Mr+WDFhtMmbobC5VDm5v6uVZZndC+0WCT7Ez4kdRh4wF9j2NnOdGDGcGpZ8UTIWb+Oao5oOR3EuKhXdIA6MbpQZIJ2hxxfQ3C58L6DNPOM+E6+qFOkciHX8SgwQzYPxg3oxv/pOCeuH5AqMit4ePg95t9eU0ACVCJ++FI6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(86362001)(82960400001)(38070700005)(38100700002)(122000001)(44832011)(8676002)(5660300002)(66946007)(66476007)(66556008)(4326008)(91956017)(76116006)(8936002)(66446008)(316002)(6916009)(41300700001)(64756008)(2906002)(83380400001)(71200400001)(6486002)(54906003)(478600001)(9686003)(6512007)(6506007)(26005)(186003)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BCSyq4ihF/n3dDBfixS3zpAVvBNKDsgRrxuX5MDMQTW9Qd2x+tVrvMO6wpfv?=
 =?us-ascii?Q?IOe68TmXMtI9uVpqvoWp+WDpxsZOP9U8wc/9JOwv12pWXSKIOB0kEQqqxYtT?=
 =?us-ascii?Q?bcdrm4ajd9DxI6xqWlPJ78vXDwaFG6IpPzfgUNgYT6aCoxu2QbjhFuk6o9FE?=
 =?us-ascii?Q?ZjwSgRSSOALLPs85rzg6Crfv+C5azqtDNTVw6mgFA8Xg67ERGdHlSIUMe36U?=
 =?us-ascii?Q?UsfFMw5jpP8u1kyHtUXDFabKlbtV5ADrQ2PiNrl7FBex1FZYETVMvGK8Cx2s?=
 =?us-ascii?Q?bZ9jjiaBY300nWDXL0O2mjSiKFMp8ZSwwnaZ+c6h83cE4ph8vejvLEtE4zVU?=
 =?us-ascii?Q?bwi2c30lGmta86W2IB/q83zR8bCZY6BypxK9LMeYCG/9n6Clj1RKsdxWhpdk?=
 =?us-ascii?Q?0P1XZa6l/ORY7zJNk9wdmnyt/yJ6IIxh53E5HKl/Yz7jCK64/OqvCOpokQcz?=
 =?us-ascii?Q?5VvJYenjCMvRwigmi2TTCSL9SCUGb+CQnJ1KYWW104Jxf7jzap1rQip8Vatt?=
 =?us-ascii?Q?rHqJCe2W7HwSXfRoGdSWTKFraGnc/zDIREt4qIVjy78srOxkHQy5wgwMeZu0?=
 =?us-ascii?Q?cBKTRHDZA79ue5+Z60SrUq/u7/1jrWKWeDHj39rKacyRJunznpMSD8GZ3DiI?=
 =?us-ascii?Q?ZUwbvJ8Oru6Xi9gsuSRpV2abViPPr+Bf4NPoJuL8l/ST3Y50h4vcoJ2gllja?=
 =?us-ascii?Q?xIgaiiXx+ibyxMWnrE2ipsts495dyp3wbnfzejLa5t/jwM07GrM4/1D+jdsT?=
 =?us-ascii?Q?bF1a0w4tsjsTB6CQRt6+Mfe+Gv0v36Bxx6+jLk5MmOMv23ALyuqIV02JWVb0?=
 =?us-ascii?Q?AfmO2ux5P1ZiU/Nb7JZ47zJYxAPwsgoIR+hCCCRFWGN1BaPjMmMNbAzeLcS1?=
 =?us-ascii?Q?iGOvmmZzyEEkxLqfoGXq8UwJenVboxUU90tfyLt+oBvWTgY7h/Xt9Tjavhvh?=
 =?us-ascii?Q?hmt63xOlqBCjt8IIv2T1Ku0osQ5SiliistvLRag+1wzK45mAWi+9V/fSPGad?=
 =?us-ascii?Q?XpK30It/m5Nv9mHPfQBmVi6J3tPljvGyRB0EQNsb1Ue9PwWnYrIGpMmk7B6j?=
 =?us-ascii?Q?x+2soBRaFkvzyjpWfk2CWoJfAeG0hmKoYQd676zdyqijeVuFW63qCxsv/C7r?=
 =?us-ascii?Q?n1ouYiU3Gyw77U/W0NTyYoPwEbESVoibK5L4ZueJOZJp8jHHQNEnqKF4osjn?=
 =?us-ascii?Q?MLvyPcVMtNmRfy4gx8BoiqQ/7XeQA9GRxzLJC+talgqlDkyww6QigXMSMrue?=
 =?us-ascii?Q?KUcUVbOMHUDtx7c++NWCqKUEGrnvCcLej5iVgTYBIpJsQGdnz5fzKnCJ1wv8?=
 =?us-ascii?Q?4vy6nCXPaAtF8JPXMNL2syOmuzNlHj8zSjE3mjKAJLyYykvGJUaI/ULFaMKa?=
 =?us-ascii?Q?7M6TR32e4+cYZbpeHmT4z2pKgVPxYwbnkLjL4N/ETA2pIhRIB8CXWNQKgE4j?=
 =?us-ascii?Q?XDqp8VB5DXe3g9mMaWi0MEOYzl135jzzxcvUt7E2FaAux0p/+fScjBzW2TUb?=
 =?us-ascii?Q?oCSbxO2WXnbX8Lcu6dOJ8vi6OzrCyY4WpdI3meJWE726Q0MQrB8NeWyr8LWV?=
 =?us-ascii?Q?J26KnzNEwRLPrjMRxQtz2IbJNQdqg4F9StJneIgoj7xzIlDW0+0eXL2K3oFr?=
 =?us-ascii?Q?RzGjLawSCfwtH46HSpIUTjQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F897A1A6199694DA8FC6F97DD3C7F23@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iQmqFaGdYl0XQMqLBknFeAl/xp/jU0RqQ7trHkufhTRX1fQa8t2hs5tNE9QkXXzngrUH9Y+o6JzWvFpkhHqE0Pglt2CpP7zN7sCNrhQzisEWLHCI36p0KUPJyJGaFBqDbb12R2bw69GBG1s0hcGDjO0R8X9NJs2pUHqoZHpc/pe1uP27CRE376mR/93GM0jdeHBDkNd1Atm09pIvPoi8lixwPeUoCEni0Cmv25+RquOr5g7LxrDknWKz3cExxFBw8VzE832PHPF53C6BU8YcJYoHPnygPtweywC0QAYkKreHLA5+CZPb8ygEvIomLgOTIV8f5tFEWxcxf4soxjHYZnEnorGOpOhZuRKnhZfj3j1TeR8qHQFH4f2cP9wEEkvkZHsX69XM+85Lp4mYFolahpbh446UiIWRPAlbmw7rgvrKWs1Om41hARHDp6o7EaBogxzlxGyBazERnqAMIOYiKZTagcfiwV2u6uDbqIunJuPcHTUFP/2WpiObe4PaNgcxNFsjoW5mlxcnpdblsk+VsVPhzZd/LavhW/lkmC38C8cNuy8GA15h0pRpk085c70Z4MI8r2EkmM+VN7vguw47Js9R9I08hqE4UH0M3oEHK0RwaHWhNhvtf2kjxtUyyTFNH6ALNtrciU0oEGfoFrfUN7VILZ6znkPu7sOhfAhihqf+XqsIMZNzxbltW81mpcRJwNaStSACFTjqAcWSlM1SHjbVQuzOa9g/XL/2w5NB0KYwXk+iQ9cIlkT0Javt4t8hs3mRkXS80pKyXidZ50mVc3DR3Dkp3lesgfrGLsdMwHp70A1IjWURsAiUDVqKo0Qh7KBgiMzOh/tjWov4dFJRg+O9xNmUoAYfcmDwJfyjs5Q=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff1e109-4709-4e0c-2dc7-08db4a24a4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 09:15:44.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZF5avkvUEmklU5h8d7EXtbpRvAH30OrSh0EIZaQCUSj1/EsS6ARe+vMhwUMh9O0y7VDQpoQWS1T17eZveT2Q90MiBDB68Mn7MWJV6lmNHJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6365
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 27, 2023 / 18:32, Ziyang Zhang wrote:
> It is very important to test ublk crash handling since the userspace
> part is not reliable. Especially we should test removing device, killing
> ublk daemons and user recovery feature.

Hello Ziyang, thanks for the patches. I think it is valuable to add the ubl=
k
test group and the five test cases. Please find my comments in line. Also, =
I
saw some trailing spaces to remove.

I tried the two patches on the kernel v6.3, and observed ublk/004 and ublk/=
005
fail. Do I need some fixes on kernel side to make them pass?

>=20
> Add five new test for ublk to cover these cases.

nit: s/test/tests/

>=20
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> ---
>  tests/ublk/001     | 39 +++++++++++++++++++++++++++
>  tests/ublk/001.out |  2 ++
>  tests/ublk/002     | 53 +++++++++++++++++++++++++++++++++++++
>  tests/ublk/002.out |  2 ++
>  tests/ublk/003     | 43 ++++++++++++++++++++++++++++++
>  tests/ublk/003.out |  2 ++
>  tests/ublk/004     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/ublk/004.out |  2 ++
>  tests/ublk/005     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ublk/005.out |  2 ++
>  10 files changed, 274 insertions(+)
>  create mode 100644 tests/ublk/001

For historical reason, we add executable mode to the test script files. Ple=
ase
add the file mode 755 to tests/ublk/001. Same for 002-005.

>  create mode 100644 tests/ublk/001.out
>  create mode 100644 tests/ublk/002
>  create mode 100644 tests/ublk/002.out
>  create mode 100644 tests/ublk/003
>  create mode 100644 tests/ublk/003.out
>  create mode 100644 tests/ublk/004
>  create mode 100644 tests/ublk/004.out
>  create mode 100644 tests/ublk/005
>  create mode 100644 tests/ublk/005.out
>=20
> diff --git a/tests/ublk/001 b/tests/ublk/001
> new file mode 100644
> index 0000000..fe158ba
> --- /dev/null
> +++ b/tests/ublk/001
> @@ -0,0 +1,39 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk by deleting ublk device while running fio
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"test ublk deletion"
> +QUICK=3D1
> +
> +requires() {
> +	_have_ublk
> +}

I suggest to add group_requires() in tests/ublk/rc file, and call _have_ubl=
k
in it. With this, the five test cases do not repeat the same requires().

> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
 /dev/null 2>&1 &
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/001.out b/tests/ublk/001.out
> new file mode 100644
> index 0000000..0d070b3
> --- /dev/null
> +++ b/tests/ublk/001.out
> @@ -0,0 +1,2 @@
> +Running ublk/001
> +Test complete
> diff --git a/tests/ublk/002 b/tests/ublk/002
> new file mode 100644
> index 0000000..25cad13
> --- /dev/null
> +++ b/tests/ublk/002
> @@ -0,0 +1,53 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk by killing ublk daemon while running fio
> +# Delete the device after it is dead
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"test ublk crash(1)"

This description and that of ublk/003 are not so informative. Could you try=
 to
enrich them? Maybe "test ublk crash with delete after dead confirmation" an=
d
"test ublk crash with delete just after daemon kill".

> +QUICK=3D1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
 /dev/null 2>&1 &
> +
> +        pid=3D`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        sleep 2
> +        secs=3D0
> +        while [ $secs -lt 10 ]; do
> +                state=3D`${ublk_prog} list -n 0 | grep "state" | awk '{p=
rint $11}'`
> +                [ "$state" =3D=3D "DEAD" ] && break
> +		sleep 1
> +		let secs++
> +        done
> +        [ "$state" !=3D "DEAD" ] && echo "device isn't dead after killin=
g queue daemon"
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/002.out b/tests/ublk/002.out
> new file mode 100644
> index 0000000..93039b7
> --- /dev/null
> +++ b/tests/ublk/002.out
> @@ -0,0 +1,2 @@
> +Running ublk/002
> +Test complete
> diff --git a/tests/ublk/003 b/tests/ublk/003
> new file mode 100644
> index 0000000..34bce74
> --- /dev/null
> +++ b/tests/ublk/003
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk by killing ublk daemon while running fio
> +# Delete the device immediately
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"test ublk crash(2)"
> +QUICK=3D1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
 /dev/null 2>&1 &
> +
> +        pid=3D`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/003.out b/tests/ublk/003.out
> new file mode 100644
> index 0000000..90a3bfa
> --- /dev/null
> +++ b/tests/ublk/003.out
> @@ -0,0 +1,2 @@
> +Running ublk/003
> +Test complete
> diff --git a/tests/ublk/004 b/tests/ublk/004
> new file mode 100644
> index 0000000..c5d0694
> --- /dev/null
> +++ b/tests/ublk/004
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk user recovery by run fio with dev recovery:
> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
> +# (3)delete dev
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"test ublk recovery(1)"

Same comment as DESCRIPTIONS for crash(1) and crash(2). The descriptions ca=
n be
"test ublk recovery with one time daemon kill" and "test ublk recovery with
two times daemon kill", or something like that.

> +QUICK=3D1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 -r 1 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
 /dev/null 2>&1 &
> +        pid=3D`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        sleep 2
> +        secs=3D0
> +        while [ $secs -lt 10 ]; do
> +                state=3D`${ublk_prog} list -n 0 | grep "state" | awk '{p=
rint $11}'`
> +                [ "$state" =3D=3D "QUIESCED" ] && break
> +		sleep 1
> +		let secs++
> +        done
> +        [ "$state" !=3D "QUIESCED" ] && echo "device isn't quiesced afte=
r killing queue daemon"
> +=20
> +        secs=3D0
> +        while [ $secs -lt 10 ]; do
> +                ${ublk_prog} recover -t null -n 0 >> "$FULL"
> +                [ $? -eq 0 ] && break=20
> +                sleep 1
> +                let secs++
> +        done
> +        state=3D`${ublk_prog} list -n 0 | grep "state" | awk '{print $11=
}'`
> +        [ "$state" =3D=3D "QUIESCED" ] && echo "failed to recover dev"
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/004.out b/tests/ublk/004.out
> new file mode 100644
> index 0000000..a92cd50
> --- /dev/null
> +++ b/tests/ublk/004.out
> @@ -0,0 +1,2 @@
> +Running ublk/004
> +Test complete
> diff --git a/tests/ublk/005 b/tests/ublk/005
> new file mode 100644
> index 0000000..23c0555
> --- /dev/null
> +++ b/tests/ublk/005
> @@ -0,0 +1,66 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Ziyang Zhang
> +#
> +# Test ublk user recovery by run fio with dev recovery:
> +# (1)kill all ubq_deamon, (2)recover with new ubq_daemon,
> +# (3)kill all ubq_deamon, (4)delete dev
> +
> +. tests/block/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"test ublk recovery(2)"
> +QUICK=3D1
> +
> +requires() {
> +	_have_ublk
> +}
> +
> +test() {
> +	local ublk_prog=3D"src/miniublk"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_ublk; then
> +		return 1
> +	fi
> +
> +	${ublk_prog} add -t null -n 0 -r 1 > "$FULL"
> +	udevadm settle
> +	if ! ${ublk_prog} list -n 0 >> "$FULL"; then
> +		echo "fail to list dev"
> +	fi
> +
> +	_run_fio_rand_io --filename=3D/dev/ublkb0 --time_based --runtime=3D30 >=
 /dev/null 2>&1 &
> +        pid=3D`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        sleep 2
> +        secs=3D0
> +        while [ $secs -lt 10 ]; do
> +                state=3D`${ublk_prog} list -n 0 | grep "state" | awk '{p=
rint $11}'`
> +                [ "$state" =3D=3D "QUIESCED" ] && break
> +		sleep 1
> +		let secs++
> +        done
> +        [ "$state" !=3D "QUIESCED" ] && echo "device isn't quiesced afte=
r killing queue daemon"
> +
> +        secs=3D0
> +        while [ $secs -lt 10 ]; do
> +                ${ublk_prog} recover -t null -n 0 >> "$FULL"
> +                [ $? -eq 0 ] && break=20
> +                sleep 1
> +                let secs++
> +        done
> +        state=3D`${ublk_prog} list -n 0 | grep "state" | awk '{print $11=
}'`
> +        [ "$state" =3D=3D "QUIESCED" ] && echo "failed to recover dev"
> +
> +        pid=3D`${ublk_prog} list -n 0 | grep "pid" | awk '{print $7}'`
> +        kill -9 $pid
> +
> +        ${ublk_prog} del -n 0 >> "$FULL"
> +
> +	_exit_ublk
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/ublk/005.out b/tests/ublk/005.out
> new file mode 100644
> index 0000000..20d7b38
> --- /dev/null
> +++ b/tests/ublk/005.out
> @@ -0,0 +1,2 @@
> +Running ublk/005
> +Test complete
> --=20
> 2.31.1
> =
