Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DDC77B73
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 05:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjEaFgg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 01:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjEaFgf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 01:36:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757BF129
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 22:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685511394; x=1717047394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bqOosqBhiNOHyePj2r4emxG/sXfa9vFkVyWp2C56rCM=;
  b=gknj1ELeqBWiYFLLJUAwd9lXh33zjBwsI9mLaETqn8HPGxXu61Yf/X3h
   3IWzdyrYhtTKTCI787htpdLKPGiWv2wMtb0WfKVOgUlH/MdUmXV4BBtXT
   OVD+SCNs4djcAhBkn8plH/4XwMDvQnx6LGNXxRej11opQHV6s6vu5nyzW
   PP9fXUBzeRjoQG0Zv/Xb+ev2gADbbyiqOBxZNPi7j1mfuj0kS8qIc0n30
   lsLjTGTWD8WD6XTXmSFApbSELNIY0sR4lOyi7gs5gYQ3dUJRDvYUM0BOo
   CfcUslahcrb+6iqC0d3umI/eiGO4AWj/b/VKFzyZqo+ksILmnNMM+PTFN
   g==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681142400"; 
   d="scan'208";a="231961942"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 13:36:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGh5/QlYExovfNl2MFhqQID5lIuSnysVGItdtM3gtYbILwkpPJf/9LAjFQPO6DI9Bmtp1WUwNmHEM1Zic0ALPr3dMoZ0Uns5syGWtGiOJhNBk0HK/0qOFRNM2EWHHP6BlUfaFAwVUKGBVmWZwQXJYlqp3ExLRbGdwY+MjDAaUq2UKtaLwEmkuzeDbaxp3kY0+yDbqt/4teMdLLo8gbWkvlRq4I4cXWSsw4Dszq87DsdYC/K2Y+wuPH4vDl+wHGOVH6X0l24ccKrA6XiUygDmW09UUP9p5xelljVDKSTZ/T9JXba14beB8DhFeK06EL4DrMibhBfjvtym4XngjE16Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnCgWc8SiVOfyu0GPJzHRZ4I6nQnXmeZPwGxqjo9pUI=;
 b=ToD1f2hZZc3Sy1G39MVxR7ZhzS1JUu88VxbxXbxQqSAHZV7N2WaO/NVvMa7JkgUhHiOBF/lyRMCCVrGvJ3NZIZSG+py1uNh72tcTIeofapSiPWdZe9Asx93UqYWIGovP0Hp50ducNu4mYBGv8raCgdSj0nlN1dLyF2ih2NPt1z4Juqk+5dsIp2Nlry8vQZLI6kpY4lA3gHUbsnBh4qzQX7XGQ+ywoy+gSPM2sM5T5QQshTCKw38wf3lTHLeM8SSRNqSNymDPA8v1UxX8+LoR4Cd7R14lmNppOXkG00cPcc7vgSmVmay8va3XtsUDdCTYvEE6TX8FJP0Koy9A9WLcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnCgWc8SiVOfyu0GPJzHRZ4I6nQnXmeZPwGxqjo9pUI=;
 b=XluZ2xspZQE+jEef3iT6W7apw1de/j9GRcu+MaJvQopGFqZYLbjsj6XMPfxubEUZS/kTSpUDQLBr7aTFiAP4iXLgJHDn1M8eVTqOcQYNaR55HvAHHPMOfU+JcNRdZf6sLZdfJ29CU0RTZXR7OE705QRxsXzYSXGPJjpgoEGjTTQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7711.namprd04.prod.outlook.com (2603:10b6:a03:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 05:36:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:36:30 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Topic: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Index: AQHZk1w9J1fvV9jcWESv88AeU5E84q9z3PqA
Date:   Wed, 31 May 2023 05:36:30 +0000
Message-ID: <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7711:EE_
x-ms-office365-filtering-correlation-id: b66b6dd5-dcae-47fa-9173-08db6198fca1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTPzdK7+iXvA/FL87HIydKJiTTVt1QJbFadgod1pASS1lR5dw8HERxIDk/oJ4Tu1spKWn94q4vV0vDNg8QpIACKUJGy3oYvSQwoHEf4EZVB0cFnlYDTijieg8OJnfslQAsX6SVO6siBW2uqNa9uhY3T1A1gri3KI8Rged5WavQPNhWxADyOXcBHxPwairm1NA90pDrmkYzymC4STPEwIVcUISFzIW1M8RKSQwF/O78QWgfNrQisXXva7SsM95cBZSjjJU4A+6JSK+2DlHESSVEaGWv+mIyN8DkPEXwWMJCvmJFXH0q2uc2UVKdz7bd93ZTb7T+B+lpaYiykqX6poJdrAPbqUXhFVOQ5aWIJJMfOXqxNjkahRxG4RStvKgjjXF6FciQ1RK9/jwdaHPoV6TTsoZT909nSXxWK/Md7+QH36SDJzLwnm6spNRE6zM8JVM9D6tg8jDM24bj35omqfooMlgE9I80SIfKDO140Arz3czeTE/9bf/jiG/a48E84vpB0aqSg8F+ENiEq0hvoDmO5aVJIHn8w55YQRVQ5bMtgI0uWTob8OfEJjD3eA2UyiHvSQIXQ8hXd2iqdT2LaDZNs+BrhvJV4Q/2AUqs2MiLtUwjcr6pIl1gI+OsmtHobx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(26005)(9686003)(6512007)(6506007)(186003)(41300700001)(38100700002)(6486002)(83380400001)(478600001)(71200400001)(54906003)(122000001)(64756008)(76116006)(66446008)(66476007)(82960400001)(66556008)(66946007)(6916009)(4326008)(91956017)(316002)(8936002)(8676002)(44832011)(5660300002)(33716001)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ib3UuRMuj++DMLDsdNMzBgM+741cFRhxAxBoKv8C5ay2nb+Clk+mds0IuZCN?=
 =?us-ascii?Q?gcKWO84CjyI7XZa34Cf+3Xxnt8zXXdhjqQGSW9o+WylaYZJJXnE38N1Pqy9K?=
 =?us-ascii?Q?oFr0xyOobMUbgcCWzYuXmZhLnki1YEb+t728m5pn0vVDqT8QfJ5HZF1dzGgs?=
 =?us-ascii?Q?SmCXJLzcCwtcLuqpcQdiXpAfp+LGC5cpEmWNmUzvqHShnouGgt3OTo5crrcS?=
 =?us-ascii?Q?RDwe1tpiO9ogiaax9OKPO9+tClNbnub5FcWwcMHpTD06vY1+zw/YAYwmJinQ?=
 =?us-ascii?Q?qBTNsm7k0zlmHsK0Oz3ofxnrg2z4k2dn94BE9CBxo+mIKtM4b04p1QVfUVDf?=
 =?us-ascii?Q?ExYfbdkSf01eWQqvQT4tl9GGI8/pVRnnctAbzzpneQhD8OU5UDtw6XaSO0yT?=
 =?us-ascii?Q?5cavdlYaxYi8UjzFkQrc/nEzqJTJJTvdQAE5S4smO2vnFqTg3t8W/omvcStM?=
 =?us-ascii?Q?MRiohpYrEdkrmFCVV2CCFdJWiXSeJ1ZWYLpyYscxiPYjimRylEk1SJO/tP0t?=
 =?us-ascii?Q?RUNg7g8XrtX/AOcda3MhdU1kb0yhX304KLbwCjBAVnQ3jWR1y1CTfE23FBpw?=
 =?us-ascii?Q?BzFjMQb6a92HQVZ5H5beY0WP4fx31AmgaBLPscoIcyxeH3ulOwjnW7N4f6kB?=
 =?us-ascii?Q?tmYNkY3ff/LIo92kD2xlGI0kHBrQ2XtDeinkkRqMMK+lcADo8E7ZJXuEu/3q?=
 =?us-ascii?Q?uI6r5YP86d8D7nRrImhqhXP+dbFMQ/IwtidK+xVX5pw+rUU4WuDmDt/9s05s?=
 =?us-ascii?Q?2Hp6IOEwJxj9iHktPA5drHP+R7rfataAAzFhk5kM12M4lzRgx34hY7qSjZgp?=
 =?us-ascii?Q?BZYDZBnUGa9EKC7/j0iyIDE/xr4mCD1riZ5IoRJ05nBPXRYqsIm3sxuQxuJk?=
 =?us-ascii?Q?xfqN2Z+lsEW9xqhd5LSfKZZ9BDM6izhv13S+d8GlhU0Ho+RYwQcWi/hetQzZ?=
 =?us-ascii?Q?OqE2BomOvAcegU3rGqXMaSg7QpqsQwOU737+7nMlCbdWpCOD1ULl+VL5b2Gm?=
 =?us-ascii?Q?/XI6zHjT/G7yYoRNFTyQA8wgi0ovm8NF3p8cYh8sKQjI8CW/GnqZ+zl6yFEH?=
 =?us-ascii?Q?om1fU6ovvDr7SeNbcOOSOhyXRQDWBreAXQ10c8S3zbEmSqetdrbSktJlSxO+?=
 =?us-ascii?Q?xrRq/j/mHPZcvDX0lhcH9XGZSfT7tN+spjBJTXFwW3QBg6K/qhqcIkRfepcW?=
 =?us-ascii?Q?axbP0wDfJ1BRhS+Le7aH66rWmWoj4dVy9lZEXgDvg6wGe0ESgMD/azH6EXra?=
 =?us-ascii?Q?JBYxgtiGcmVzuRMXh0L+B7H64go7Mz77dYsRBXrJ+yyw97IsBsuNFgZZk0y0?=
 =?us-ascii?Q?MqltZM4rlq/mykWCl05Jp13h5hHZs33UyiD5V1PG7fONVZlEzCdBDUpG58sP?=
 =?us-ascii?Q?mGLJpiN6dCEt7RB/irRvewmI5s5MpGYixFu2foRuARiW0C73edF91tIAgFD0?=
 =?us-ascii?Q?EP6M1s7w8K9BluxfSdgTgsV7whmFr18W3YB7p/o+mXPKS4qo+05Wp5E8PXjx?=
 =?us-ascii?Q?6K0eckdbTKVhajn3N+oJD0X/9N5PXxFTvEcmtMEd1hEjmKiNr+kNatuGn6sS?=
 =?us-ascii?Q?OiLHLx8Ui3bFGJejaNNPtqmJqZcQgatRl1449bgsFkgk7fQfxi+VVQmPwaAC?=
 =?us-ascii?Q?ja6eUymSN2nHT2yIob2FhEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDD35FC68E843A49930CF2C1837CC492@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cWP0yU8F8De5gxWv/KY04P/my94lbEhesNrcK0UGb0CJQn6bgwnWplx/M+yvH+9eA8Cv7/Zu3EFMkw0VeX7hZjQZAeI86xjbDaES/uvl+QOUCBZA2qBkQ1F2wr0ZrPGpIZ85dfTY4XC7mBXuZiiVt7zC7KIXz0HPi4BABIb5AVuK5zFDFUzBIxa9/CiNSVcHy8MQ06pqWMVyxzAFaJIBKzTOK2MnQb8sy0vXWIkVhlGV/gBj+F9H63yc9cicpK0YUYNxmnNWyfxzZNWFbhWZnq5dhLsQUS4kWB4beZr+WsTKMcf/YTxZm/lrvbwRVatWv2ocWdJmxSCS2urWdJPE7RKmDfy0uDAMUO3tMvz6U0Dtym/yMGf3C4PdEVIEoBtEgumjmo1hC6ftORIm8togFdzCgLIRd9tfYXWJqjsMxqcl40tsnzu/dzxJ7u6aBvnpyoF9U65VlBe4E2+kz9BWCExPm2ngwMYgK+whS/VPYah9Kc946sJHQeEv3CyioQMnR4Bx+V1Hpd9y21C5aXageRbUtlJYtd9aaZZA35f8LHuMuglE57MhrXAWMrGgs0RYfrmjX7UXw1Laa0Xh5oQdkM8GI0jR7EAnoOcPvkVUvfSys0gE3JbEZjMZdoSkjYRj6BOuJx6eIEc0FkB7QhZLaLzrmpvMx+Or2kSL/Ika1Hc4wE7iJcA7QMKeubBXsHuhpEKmtNktqMb7u6ASl6LjJzFDRZH3r64qVTmhhP3FVJoYLXtb2f9BlPPnZ5LaI9oGTLui2ZEwXjSMlgGvxwHk3K37tQIQGzUOdoc4Hz96JlsZjBJfErP4NuhAcXbvQQTfP+rsyeqqpnB/u+anUUOgrWKnpz5qRN8s/2gn6pgXqxo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66b6dd5-dcae-47fa-9173-08db6198fca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 05:36:30.4145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/0ok/JH0/qnFeKbB4EJV8VKWEal9Lq5lJcxBdDICErmLoaxbTlaIlM7iSf8VjrBEO892lARs3K6FGTTskCisuc62EpqKcVTbhUe387rOCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7711
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

CC+: linux-nvme

On May 31, 2023 / 09:07, Yang Xu wrote:
> Since commit 328943e3 ("Update tests for discovery log page changes"),
> blktests also include the discovery subsystem itself. But it
> will lead these cases fails on older nvme-cli system.

Thanks for this report. What is the nvme-cli version with the issue?

>=20
> To avoid this, like nvme/002, use _check_genctr to check instead of
> comparing many discovery Log Entry output.
>=20
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

The change looks fine to me, but I'd wait for comments by nvme developers.

> ---
>  tests/nvme/016     | 4 +++-
>  tests/nvme/016.out | 7 -------
>  tests/nvme/017     | 5 ++++-
>  tests/nvme/017.out | 7 -------
>  4 files changed, 7 insertions(+), 16 deletions(-)
>=20
> diff --git a/tests/nvme/016 b/tests/nvme/016
> index c0c31a5..f617cf1 100755
> --- a/tests/nvme/016
> +++ b/tests/nvme/016
> @@ -24,6 +24,7 @@ test() {
>  	_setup_nvmet
> =20
>  	loop_dev=3D"$(losetup -f)"
> +	local genctr=3D1
> =20
>  	_create_nvmet_subsystem "${subsys_nqn}" "${loop_dev}"
> =20
> @@ -34,7 +35,8 @@ test() {
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
>  	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
> =20
> -	_nvme_discover loop | _filter_discovery
> +	genctr=3D$(_check_genctr "${genctr}" "adding a subsystem to a port")
> +
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
>  	_remove_nvmet_port "${port}"
> =20
> diff --git a/tests/nvme/016.out b/tests/nvme/016.out
> index ee631a4..fd244d5 100644
> --- a/tests/nvme/016.out
> +++ b/tests/nvme/016.out
> @@ -1,9 +1,2 @@
>  Running nvme/016
> -Discovery Log Number of Records 2, Generation counter X
> -=3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  nqn.2014-08.org.nvmexpress.discovery
> -=3D=3D=3D=3D=3DDiscovery Log Entry 1=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-1
>  Test complete
> diff --git a/tests/nvme/017 b/tests/nvme/017
> index e167450..3dbb7c1 100755
> --- a/tests/nvme/017
> +++ b/tests/nvme/017
> @@ -27,6 +27,8 @@ test() {
> =20
>  	truncate -s "${nvme_img_size}" "${file_path}"
> =20
> +	local genctr=3D1
> +
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> =20
> @@ -37,7 +39,8 @@ test() {
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
>  	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> =20
> -	_nvme_discover loop | _filter_discovery
> +	genctr=3D$(_check_genctr "${genctr}" "adding a subsystem to a port")
> +
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
>  	_remove_nvmet_port "${port}"
> =20
> diff --git a/tests/nvme/017.out b/tests/nvme/017.out
> index 12787f7..6ce9a80 100644
> --- a/tests/nvme/017.out
> +++ b/tests/nvme/017.out
> @@ -1,9 +1,2 @@
>  Running nvme/017
> -Discovery Log Number of Records 2, Generation counter X
> -=3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  nqn.2014-08.org.nvmexpress.discovery
> -=3D=3D=3D=3D=3DDiscovery Log Entry 1=3D=3D=3D=3D=3D=3D
> -trtype:  loop
> -subnqn:  blktests-subsystem-1
>  Test complete
> --=20
> 2.39.1
> =
