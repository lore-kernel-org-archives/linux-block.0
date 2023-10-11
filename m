Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FEFCD6E5D
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 12:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjJKMQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjJKMQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 08:16:18 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8D1995
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697026544; x=1728562544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8jQkd+LahzbFnfQ26/TnzKZ57WU4Kr/FsCIK5vL6DYo=;
  b=r1DP9dlt2KkdyHU5lJuuU5YYIY93HoQf2PJvm9ZRbZKHj1EiaqwRNeu4
   +DemjI5tHig0Y3Ju0AM/Htiri9O2jigaK/SNvO+mKDC4ece/q755cnWM4
   j8vWnOjE6tyU1uVFh720vwRBZqTWJsbFjuYizGGrNMdDpGxfUp8p+CUbI
   4nhsBmbzn38RaLQlTIj4NfRAeogCV0L9yZoNUs5Meef/fOYJ3QLgZCFJN
   Hc8bPhXmzREThFT1nAU8mKK/Bfq/DtUazxlc/uBrqhZmfADINiOyIiqmE
   pL7tM/fLJrjZ09NOhfatCekPf0XigirQ/EdVDlOJ79haiNf4S0gfJU6Jl
   w==;
X-CSE-ConnectionGUID: i1EoEtqGQe2qx+QQFzDa6g==
X-CSE-MsgGUID: 3ojxi0APQ9Kz/LhbDC8gPQ==
X-IronPort-AV: E=Sophos;i="6.03,214,1694707200"; 
   d="scan'208";a="351639043"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2023 20:15:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btX4MGRW8yktt9TRJNV110QuSpWCIklBQ+ItD43hXwRummsjlYZMfocdgrdbnP/M+WFcH54edGzX1wL6F9eHfxWbKYpdjK7zrBw/Mn+q5JKRc4K4NR4/FAjHfdBXjizAcFsk0g5TmKkqtkCLrqv+rXnkkoO+DKgUBbwVSvIyq7YY+3N5Kv7UqWu7LFldDNbfBPdp0RD2cmHCuMldNz4GhcrqiglCVTDxqZ5dngWW7K4AxBUOapIBfVyE0FSVlVbMTVyim0aheiPCllFYlGoOnpOQbt+2LqYpXJW1VSPB7Vnp76/ncf0iJ9Ydz03oSKaJUOjw3y+HdK2pqsqi89cq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31U0sAs6rVWxSBbSWIDyUeIXvgW91DfgFw+IVO7HibM=;
 b=aYpbukM4kQ4H3F+pwvoN8LwDem5iOowp2qyJT782PdfgwkB+TkVMOlBCa8c7RsCQh4LrOe88f+siKyeefwhsJrdw8tUzonRc91B3sRHrTXYETrRSUK27kSZ0nIh6jI23dswTsTPEzx+K5tJkA/GP6l4qhLb+F+AI+J5qPJJFs18l+iBfsPOoLoa/DLc2I1/D41RD5Oolryz6Qj47P+hhV72nvmo2RdF9JLHHnBihkdvXYFKTxMXvqZBkjw7MaRoAQrEeChoxwehHm5DR+jQ4LuAE0Bjs3a7eSUljiMCKLfGhg3P3sr9UW+/J2WOJG/7PJ3qK+qLGAyVX9ezrOg9+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31U0sAs6rVWxSBbSWIDyUeIXvgW91DfgFw+IVO7HibM=;
 b=RAFF+PNZwS/HeHCKQXmIdewxsIGAVpO+ttKVX9ujKv5QNzvAK/LhROU/29YKyLf+MZ0rBhpKj0KJcnGOM2rHCNzQflIbo6r7iZ06uNkNdoTz1LRZQPETelao7YiEecFCmbt6GrOyPKPsTtWaDfduGslXiNZkBQMOHFZlY6OJsJQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB8868.namprd04.prod.outlook.com (2603:10b6:930:c2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 12:15:40 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6886.016; Wed, 11 Oct 2023
 12:15:40 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests V2] check: define TMPDIR earlier in _run_group
Thread-Topic: [PATCH blktests V2] check: define TMPDIR earlier in _run_group
Thread-Index: AQHZ/BQuNTeNE6FHfkew+kse8OVtW7BEOU2AgABHwwA=
Date:   Wed, 11 Oct 2023 12:15:39 +0000
Message-ID: <jx7js2zxcxvpdrzsf7dkca4ruiqr7luowytnxtbygbtefj2qwq@jcasd2evlpvp>
References: <20231011072530.1659810-1-yi.zhang@redhat.com>
 <32utqb6baqrfphxoqczb66htxatocmq36yuwmkzib43g7jvjol@3uo7bvraemyl>
In-Reply-To: <32utqb6baqrfphxoqczb66htxatocmq36yuwmkzib43g7jvjol@3uo7bvraemyl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB8868:EE_
x-ms-office365-filtering-correlation-id: ca65778f-ba1f-4c30-13a3-08dbca53c8ca
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +IVtFDzUNN+HC6P71NvF+j9tT8g4ICgbsw5avqN5Q/rERGaOoRIgw+x82TkHpcfB5SSEYiIf23Tm5G8ZfKustcDQ/x7w+nW6WMgka1WbkyzD9LABD/HjXz0A+AJkK54aRgfKXJW6nmiLqVEGyPuRaFOSE1iZCxHBikMLVopmlyM5khr/g9339o6bgifZ/nxO6+hM8QzshVMsvq88weckZUgWmfehDnejPUcEZ14muWNd2/Oq+f/qb7cSJYml6gVGP996nPdopuHSg795Efc6eEtpRxpiw+71/MEHMmxkYqqrfka2+oS7gp+H5YnPXLdiPm160DFZLQo4HXkotNX+Bw/Yonjz9HgN8rT0DG3okngIHpgPL3CynybBLT7ebJ54vyx5ikc18duC1d+s6TOHZ2H5FrIlNPoZcSwsZV9S/lleJvuyo8KV6UQxDwAb2MM6JXgHVideIvqQplzv8pwFrstRVLTzhSBlWDkIwITNpaHeuGm5dBSlS8KU5KdvM8j8pzDNAjTDh8N0fNXuEbxHmWGwJp2JVqaCA01/5gC0xxR29qR7XfyYR9sZuUUpYHGKvuj2e+upV5/xJNJA+IuT8YCYl+DbjfRE47sgCcRurL46uU8jXPajGDf/D+as5N0KFo0TA2+MCBTc6U1fU4XvmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(9686003)(82960400001)(38100700002)(38070700005)(86362001)(122000001)(44832011)(2906002)(6486002)(6506007)(71200400001)(4326008)(478600001)(8676002)(8936002)(26005)(6916009)(66476007)(316002)(41300700001)(33716001)(66556008)(64756008)(76116006)(91956017)(66446008)(54906003)(66946007)(5660300002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/IDB/SEQYnZldC/FZ8wWz4TIuoa3wl70PYLrPCSFWx7Xv4xasmPRgx8xvoup?=
 =?us-ascii?Q?3w5jKr8GohK/PcT8OPWkkRyGMFOQeFS6I66kwsKG45Jj7RllWAKVU9NdwH5R?=
 =?us-ascii?Q?DyU6Em7l8nWrAb/5puFh7GTV3NuGZZTOziz+UNPF1Tjyt4HC4YrntWUhbIfF?=
 =?us-ascii?Q?0lH3t4h0n1OLMUUrUy/UYfy+7OAWJf86BQFfgvo1Lf3E7c+C5fUMuxebQwZv?=
 =?us-ascii?Q?uWkDVHRPC8jj1pLWaaQ+AWVQZlxo5YDOSopQpCW82MuFmPlqs1O2ycZ1bxd9?=
 =?us-ascii?Q?7ThN8tCfqWsDe0CEh7vKQTu2wLdylsEP20srbNMDTNOSpvcaa1U2e1XcS0pT?=
 =?us-ascii?Q?wiFMLsv3ef7u3giEKJZGa5WNRNoGGYIKn7eaktHsyZiC5rAevahV17XbV+So?=
 =?us-ascii?Q?sOtlx4zLQXdgJ+9k6ZlivlY46WSORel6Zl01+6vmGU3Nla1R1UNLpZWrvcOO?=
 =?us-ascii?Q?UzuaFvy5h5j2+Y232NKYddzpw6DkmDPmwPb+W9u406DtyQ0fxJKypMRYXJ+X?=
 =?us-ascii?Q?q5CoANIKvWJ1LbpCBzgaVQgvg4bBTuf/6JzeaLvPsFd4gIRnYjlMBlbLpkwi?=
 =?us-ascii?Q?aPpquEphuFUvpR86Y7i+xnL8Kcq4IyQdFsSkx3BXjw/ieWwYl5eeXHflAHh2?=
 =?us-ascii?Q?5Bpr5CoLMoYwYhAX9AsuRLpCH9ZlSOBLLNHoThQSeNNWTpeDDbLveHgrZhu5?=
 =?us-ascii?Q?c4/97Gj0BWWQVYtbtGiqsxnK6ESs8LUgY7BKFnFXSr1fDeuf8IYMxpqEGta2?=
 =?us-ascii?Q?PG196zAQIRdIvPBChv1Tr19bNNdrqGCj4M1XhqowrwtpCGtRd576bd3UvT77?=
 =?us-ascii?Q?BxbhKWOIJDkZQmA3hNmulLL7cqCOKWBKO7yHwuRt4qMVQQGYNFQBcjo9pYi+?=
 =?us-ascii?Q?dyo3srVUDRStYmPCE6MBc4bsTAH/1emTEPRgdVnDZoHVzayXVUA5/bOgBInF?=
 =?us-ascii?Q?8CF+4pjCTlXlJBTMbylMVWUxx2cOfU0xC5Sn9z7NBfk42l6rBC/5k6/qs4az?=
 =?us-ascii?Q?56x8xP95uHl0dM6Oe8s68hwBAIUgmddIgpZ6vx0HuYbTIelzxDYXBwIW4k4g?=
 =?us-ascii?Q?7+5abTdEW8dtCCMVzY4dWLglp7mhuQseFSJTFtJpiY7r4l4Za03L+ccti9uf?=
 =?us-ascii?Q?zDT1AcMdssUMH3dP3lmiuCJ+MQ4v6nnyjU+j1FJVxnHvipQY6/1rLM3KBLQL?=
 =?us-ascii?Q?a+Sjx3vRsGRQqzUOc/bg036WaqKHCFKFEYjX1gjhotBTs9RIsDZxh/SCLSGL?=
 =?us-ascii?Q?q38zlX0LTXY1eyMfktF0gxWY0o4QjFvGb8iTCak323d3dGhud4C5KbBvJroC?=
 =?us-ascii?Q?mE6wAWM+A6QL1Lc+TGj3HjgWeZF4Ab35PPwVCXngVVSDLfUYWA2rLY5luyKu?=
 =?us-ascii?Q?FW4YxbYiwts4HnE7+4Q4zCuPQmQE3Tzdmq2KNYqZT+Q75idBzNyUWHSAKPiQ?=
 =?us-ascii?Q?J/CvfYz05e9USLD9f7g59ondw6SYRsrmsDfmfoXd143tTZGCi+IXzjClRTlY?=
 =?us-ascii?Q?JEq1FrHXcdQwYfx2brUr1iznfdPekzvZuhzVP7kMy8Ay9LyRQnl05lcIbeqL?=
 =?us-ascii?Q?X1Cs0tuDUb9P5RbuAGd6CYEDjIJUBbSONXXw3ER1e/5lcAqs3j/dTI/PJKqn?=
 =?us-ascii?Q?O4G2mChqFM90T35ooq3VpEk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AE56E255ED03D4D93B439AD345BCC5E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u1VVcASbR+h7Gt6PxMOBCvRCbvxX9D4bnbbA0EjqgzkeNIhx3Kk+IE04YpHn3VAWMOrkaRSrmkvo7A4anQmMcvJPMnAMym1js1MWJF3zQ2a98q1Z8NoO7WdlZOrnf3lIfMDBiUh/VAGktV+xj68XEYbBQplTuMeBt79gd8On/5Chwecx3GOBo6aUI4hFp0gE/REucthcxNy1y1DgHQUyzf5oV5klW/CnW9P1wRUNA8lIWrKzOiEDMpi81304p5tsV8G+4zSSQ4q1yq//zQ+V0yRPy4mQLlHFAax41Pn46vQD6dgwrp1px3kwVfBp8OkEDCgVPSvR0fNOuXy9CfgsVYB65mf4WobTe9ruwgSIQiZcnqW0lPIw/tthhjWdake592lnLpnyGUu8PxVWiBBJ6ajTremWdKEky9SiNtIBGUvLcH6Yll9qju54K/ZTjO+eYe6oTYtsvlqva5Vck147jZSSrS9oxMr5f/RO8pR11FQ2DJuqLXBHZYZ0MY818nkvbu7tw9ojlxAiUw7016wxsE0c99jcXhVsw25dqVI7pXGNJvw5u36SBPLsAG4A/VpdCWsSY2BG/a3DUOP5z5niCqfE9o5krPLcRlec8zJqqAKPh+49HJg5kmYPvKZNZBJkpLzomfu7wYkMdNOL/cBNIwy1UlZeS9V0SpW8MdjBHeKRCFu1XXiunTaQllUOymj0Dm5cwzG2Fo+0hPzPHC3ABWZeL0bpeW6eV5FLAv6rAiPrd0QheLwlQjGxfTpkKuohCcryU+kWvnEHfrMogmhuBtIhEpGyaqT6OIATn/qoJKDbF601PWQKzy5DCV62Y+9GMjZNgIzyc8bX4VpDU18MLw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca65778f-ba1f-4c30-13a3-08dbca53c8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 12:15:40.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeXMvgrGJsLqQd323aHra22a24O3HJKzNjdxx5ieOTwQ6FBYN42MWsmjE9qQY5thhvfwHfnFRvmma47XIDVciR7bV3wJTS90QTEnzaDcSjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8868
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yi, thank you for catching this bug. The nvme image files are now created
at unexpected place, which is bad.

On Oct 11, 2023 / 09:58, Daniel Wagner wrote:
> On Wed, Oct 11, 2023 at 03:25:30PM +0800, Yi Zhang wrote:
>  @@ -559,6 +556,10 @@ _run_group() {
> >  	local tests=3D("$@")
> >  	local group=3D"${tests["0"]%/*}"
> > =20
> > +	if ! TMPDIR=3D"$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME/=
/\//.}.XXX")"; then
> > +		return
> > +	fi
> > +
> >  	# shellcheck disable=3DSC1090
> >  	. "tests/${group}/rc"
>=20
> Sorry, I didn't catch this earlier. TMPDIR is newly created for every
> single test run and gets removed afterwards, see the _cleanup function.
>=20
> I think we should keep this behavior. So the question is if we could
> make the $def_file_path evaluation just lazy. So something like:
>=20
> modified   tests/nvme/rc
> @@ -18,12 +18,15 @@ def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>  def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>  export def_subsysnqn=3D"blktests-subsystem-1"
>  export def_subsys_uuid=3D"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> -export def_file_path=3D"${TMPDIR}/img"
>  nvme_trtype=3D${nvme_trtype:-"loop"}
>  nvme_img_size=3D${nvme_img_size:-"1G"}
>  nvme_num_iter=3D${nvme_num_iter:-"1000"}
>=20
>  _nvme_requires() {
> +	# lazy evaluation because TMPDIR is per test run and not
> +	# per test group
> +	def_file_path=3D"${TMPDIR}/img"
> +

_nvme_requires() is called from _run_test() via requires(). This is before
_call_test() which prepares TMPDIR. I think _setup_nvmet() could be the goo=
d
place to set def_file_path. All nvme test cases call it in test(), except
nvme/039.

>  	_have_program nvme
>  	_require_nvme_test_img_size 4m
>  	case ${nvme_trtype} in=
