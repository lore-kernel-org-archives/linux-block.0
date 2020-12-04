Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD4C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F11922517
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgLDDat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:30:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31601 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgLDDas (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 22:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607052646; x=1638588646;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QMVL63KajtTT+OcntJ6gap/luHFsCY8lWDpUGzLFrd4=;
  b=pIJb7SHTSZdcMW/l5lOz7nQuDmz9UR+ELkrrDd2Zr+/vHB1ge+621oFs
   l4TPOtDosVqAsAQE0P5lVpEYZkrgfzw6Xt5YfnJxAC1X3dgI0F9NGSX3P
   wmcCpS00OdGYR/SJHgXqh9ATQY5Lk0wLV4PUFcGhUSZgDAVk8w4Lbzuok
   SEd6QxwAV6/x5iqk+6IHpCNiDZgQmkBy3AyyYbRWngY4QqgGqiWA5to2V
   ZVRPMv2cXsNaNr6xOor/MidjUeDk1UDfc/LGHQ9d3NSyTN0NKYsvcCh1j
   48cFiXu8XuEQ5UpqQiMIgynHbG8rACSXEClw46gdC1R2fKSk/jhS9P2KH
   g==;
IronPort-SDR: I6Jukq+1errObreMqEPUMxdvbET6Xu88OTV5eyEsSwKOcKRyZCIw8VBLM9dTHZEe2SCjRml3V6
 rSTG2g1UHJvbhsoqA0weYSWW5yxtaICG2qKZHa77PECYq56lBkxKq0EsgWz0PWVWjeIdt3Cu4H
 bo9vdtYkicovsQ9z5J8YDAAMkQo3PUsxG+QmGh4S0IqbEPlBV6hHsffoblQnNpUTbvVMtIg1bh
 OX1fJR/muRqETj64SgLuBCnrWDNE/2m8xUMSS6+K3XsQa040vCcmClLjPW+IS7QwDbMZnw6eWQ
 Qh8=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="158871882"
Received: from mail-cys01nam02lp2059.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.59])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:29:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqt6dH+wzgJfKz7wjXUg6cyQcabKX5gxKSFMe10UCzxAz2I3RUbginfGVMU/7fzDjRTC5sr3Imb5gn6vr3+NGUpQKDoWD1uXvdarddjOeN1YH1riCHAan5ZVFFlURzjy4iJfAk8AZQKh8U9yQVknn2zMc6gHDoLRYLuZ0uOu1Tc1fG0aVFYVgubs/UsAa/VnYZ5gEyRbo+GyPrCgjgZAkGl0vTjROixdAZrgUhDUraZB3Hqt+xHylKC3oeOSI9wL917II7wLe6X9h6u/qKqntUAE/Ubq471lNHcaf1wkdzkWmM9KMs0YMpIQtwAMUkm53oTFhK4qL+mslyQRxEh3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RH0BTfjyzQarHrmBMCUjLwuZpU0PgwZoF7P0cYs63s=;
 b=FyUWaiHnOxB2Vr0ixU1GF8glLK/z0s64nKXu/sEzxi4VReXeCsAXNBFcBVuj+byIafkLVoPHc7lydDxMBAm0oQINcz1AtQlDNMSU/omNBlVztU/IhBQqxMa8ysYVXnmjyb+rK3c82FYyaE157s+zwC9xHmpjwfZMFSpGhRkYgwaaa572aTeftNp5BalB9J+UDGB/MfVu92QpiZI8jxNqNM+H6Jmlw/INrjGRGbUhMu0Q5u3KXynz0CTRCz9MAyQPfPyqUYAF2q4spOoi0xN7OaiiAEcXje5zP88WY+hF6QLWTqz2MtBzwkhleUmYsV/ekIpeFrPJZmaBkFJjGfiYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RH0BTfjyzQarHrmBMCUjLwuZpU0PgwZoF7P0cYs63s=;
 b=jpIKuTc3roeZgwcQiYtpqCiicSJHLFutf0rG5Mhh4PTmQJcsrciAQv1X6pl4vtBNqEbd8M6+BLgiIm8nW2fH1djtoKN8pNgjpMHJQ6Dp2b8fKEHILUVbN4kM9hctLhDloj+i69OPf8lAcFfogENjIm9XtBbyGXHQvaeCXVPKoJY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7123.namprd04.prod.outlook.com (2603:10b6:a03:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 03:29:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:29:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v2 1/2] common/rc: Check both max_active_zones
 and max_open_zones
Thread-Topic: [PATCH blktests v2 1/2] common/rc: Check both max_active_zones
 and max_open_zones
Thread-Index: AQHWyecihO8CsVZ26kuc1RuSVOlffg==
Date:   Fri, 4 Dec 2020 03:29:40 +0000
Message-ID: <BYAPR04MB4965F0313FEF0D11F03E05F186F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201204024235.273924-1-shinichiro.kawasaki@wdc.com>
 <20201204024235.273924-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 560e05ee-75b7-476e-e74a-08d89804d5b9
x-ms-traffictypediagnostic: BY5PR04MB7123:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB71230B9ACFB5499D715590E986F10@BY5PR04MB7123.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWOf0s0lkTDs4zK9TKRb+RvJZ+p5p88PxQ4FxaO+Gouj6V+70+c6oLSbN3q8IdtvEQ8ole8IyL1ib7JUv9+C+h3SZBGdrYO3TISbuinhFWiReOaa9gWEC1ImoEA8pTYK5XQx2RJAjnKOnhNcwWaZ9mR9//LMLir2lNjGLB/ZoY7OlH+BhlkpCbIpOVMo587WUyN7RQMaKdBCBBe1G9KrgNb2UAa2YiTr0pCrBVltTB0GBp2NPV1JRrLRLSBWbLgNljaPpfVpch3C3lCOYPqgphEcf303hma6qgvunwTkjYpnGX6dB93Tz7JuBp9qLtGYpeAm6vuTX1fNRkBO9S82CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(6506007)(33656002)(86362001)(53546011)(71200400001)(26005)(7696005)(2906002)(55016002)(8936002)(83380400001)(9686003)(5660300002)(8676002)(76116006)(52536014)(186003)(66946007)(64756008)(66556008)(478600001)(66446008)(66476007)(4326008)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7KZVHyASEJlbb1IB2MmFbcf2n7HYD3bniszvWl5iFURi+/z3/11U4xB1apkp?=
 =?us-ascii?Q?3o5jROXAsqd3DqdDclmLU+4739vSH9hs3clbdF5b6DuTOjad9h7CQdt0d8iS?=
 =?us-ascii?Q?9lO5b20UYmUPE34pdVbAdP4Y+OrjLZQG0DJBu0jPGuMeXU7wz/k0bZElbk6w?=
 =?us-ascii?Q?LDmZAiaaB3FyCuHRkIcJEH0BOy5xUU6osXcYfFZDIPhHJcoOomtIMgtRuZ+r?=
 =?us-ascii?Q?K3u1JLVxWQ+608YqdlIZj9Ce0ZVtrs0cplf7AbiKyHpEJ96hG4+FtF89Rtyg?=
 =?us-ascii?Q?g66o4tIP9i/bLIkzt1Hn3MB2ttRHE2tmxSjheFQO+FJq9WbYevADqHoo4HTd?=
 =?us-ascii?Q?38yHxLIwUGrLTjCbtXNABSa6OR+Ak/MwpblBur1hxkhubdnZMU9fC58FpMfr?=
 =?us-ascii?Q?SjejOWkbw53ymS/CbvjCD5zKiTf1gC4/DiaqQITOQRoZMMTBq6zFeDg7rYG9?=
 =?us-ascii?Q?pwde6NjYjk1cf3qDTP40pO0Ygf8yztC+QAzoBKLwnsoHQjkUYTxc8nxZmrAe?=
 =?us-ascii?Q?Q60eZJ3Uimu5lfIvzvYrRZsF1EpcW8H6+UPYl1hKH+9EkdspVbmze5I2uVFE?=
 =?us-ascii?Q?wsFCnw0wTWEr/I9ChNiukCvoEIKLDKtrPbPgUDMu4fHwQUFkEzaGmeQGtgIB?=
 =?us-ascii?Q?uDRkFVCpT1sdSC3nTESln/KLe2uizZ3MGZArElGgEJETyFP8hxGxoOM7PQB/?=
 =?us-ascii?Q?I0mS+nuH1AZoK7ZDQ5XSwaTlKKFi5hNTygCHoYglU2PIDACYqQC5paat9U5T?=
 =?us-ascii?Q?KJgMyvCYFmcCVEgv6rX3y7sgYVM1EtqJv6nUfbvtVNW/xR+jxb0lUuVT67J4?=
 =?us-ascii?Q?jMlS37vl2q24lRQCLOFyp0JUYTduYhLWhRVObupqASPH+Y/HH2IFOUA/KdGw?=
 =?us-ascii?Q?PQkMmIHiZkZUNiVBu+pC0IwbQvIbcUyT5GzSeifmdlKmHwpv/L7LVvGKt+x0?=
 =?us-ascii?Q?soWYZSCFCuAxb6ImcpiHmHPIRD9WSCaSmvbui9BQ5FMZirEWlxhyjT+pKtoa?=
 =?us-ascii?Q?2Eoz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560e05ee-75b7-476e-e74a-08d89804d5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:29:40.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Uo6HSLh08ofrUB2nDkuj9qjDzE1zMOB6wJfSJlZ7/Mb9OFbXNTAzVZBTTkx8qYWfZkzYSh9UNwPO2n5p5t+GHxSIgykCxqNDsWmp9cPV4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7123
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/20 18:42, Shin'ichiro Kawasaki wrote:=0A=
> Linux kernel 5.9 introduced new sysfs attributes max_active_zones and=0A=
> max_open_zones for zoned block devices. Max_open_zones is the limit of=0A=
> number of zones in open status. Max_active_zones is the limit of number=
=0A=
> of zones in open or closed status. Currently, the helper function=0A=
> _test_dev_max_active_zones() checks only max_active_zones, but it is not=
=0A=
> enough. When the device has max_open_zones, check for max_active_zones=0A=
> can not avoid the errors for write operations.=0A=
>=0A=
> To avoid the error, improve the function _test_dev_max_active_zones() to=
=0A=
> check the limits both. Rename it to _test_dev_max_open_active_zones().=0A=
> When one of the limits is available for the test target device, return=0A=
> it. If both limits are available, return smaller limit.=0A=
>=0A=
> Also modify block/004 and zbd/003 to call the renamed helper function=0A=
> and update comment description.=0A=
>=0A=
> Fixes: e6981bb2d9ce ("common/rc: Add _test_dev_max_active_zones() helper =
function")=0A=
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  common/rc       | 19 ++++++++++++++++---=0A=
>  tests/block/004 |  2 +-=0A=
>  tests/zbd/003   |  6 +++---=0A=
>  3 files changed, 20 insertions(+), 7 deletions(-)=0A=
>=0A=
> diff --git a/common/rc b/common/rc=0A=
> index d396fb5..a837542 100644=0A=
> --- a/common/rc=0A=
> +++ b/common/rc=0A=
> @@ -280,11 +280,24 @@ _test_dev_is_partition() {=0A=
>  	[[ -n ${TEST_DEV_PART_SYSFS} ]]=0A=
>  }=0A=
>  =0A=
> -_test_dev_max_active_zones() {=0A=
> +# Return max open zones or max active zones of the test target device.=
=0A=
> +# If the device has both, return smaller value.=0A=
> +_test_dev_max_open_active_zones() {=0A=
> +	local -i moz=3D0=0A=
> +	local -i maz=3D0=0A=
> +=0A=
> +	if [[ -r "${TEST_DEV_SYSFS}/queue/max_open_zones" ]]; then=0A=
> +		moz=3D$(_test_dev_queue_get max_open_zones)=0A=
> +	fi=0A=
> +=0A=
>  	if [[ -r "${TEST_DEV_SYSFS}/queue/max_active_zones" ]]; then=0A=
> -		_test_dev_queue_get max_active_zones=0A=
> +		maz=3D$(_test_dev_queue_get max_active_zones)=0A=
> +	fi=0A=
> +=0A=
> +	if ((!moz)) || ((maz && maz < moz)); then=0A=
> +		echo "${maz}"=0A=
>  	else=0A=
> -		echo 0=0A=
> +		echo "${moz}"=0A=
>  	fi=0A=
>  }=0A=
>  =0A=
> diff --git a/tests/block/004 b/tests/block/004=0A=
> index 6eff6ce..a7cec95 100755=0A=
> --- a/tests/block/004=0A=
> +++ b/tests/block/004=0A=
> @@ -26,7 +26,7 @@ test_device() {=0A=
>  	if _test_dev_is_zoned; then=0A=
>  		_test_dev_queue_set scheduler deadline=0A=
>  		opts+=3D("--direct=3D1" "--zonemode=3Dzbd")=0A=
> -		opts+=3D("--max_open_zones=3D$(_test_dev_max_active_zones)")=0A=
> +		opts+=3D("--max_open_zones=3D$(_test_dev_max_open_active_zones)")=0A=
>  	fi=0A=
>  =0A=
>  	FIO_PERF_FIELDS=3D("write iops")=0A=
> diff --git a/tests/zbd/003 b/tests/zbd/003=0A=
> index 1e92e81..7f4fa2c 100755=0A=
> --- a/tests/zbd/003=0A=
> +++ b/tests/zbd/003=0A=
> @@ -30,10 +30,10 @@ test_device() {=0A=
>  =0A=
>  	echo "Running ${TEST_NAME}"=0A=
>  =0A=
> -	# When the test device has max_active_zone limit, reset all zones. This=
=0A=
> -	# ensures the write operations in this test case do not open zones=0A=
> +	# When the test device has max_open/active_zones limit, reset all zones=
.=0A=
> +	# This ensures the write operations in this test case do not open zones=
=0A=
>  	# beyond the limit.=0A=
> -	(($(_test_dev_max_active_zones))) && blkzone reset "${TEST_DEV}"=0A=
> +	(($(_test_dev_max_open_active_zones))) && blkzone reset "${TEST_DEV}"=
=0A=
>  =0A=
>  	# Get physical block size as dd block size to meet zoned block device=
=0A=
>  	# requirement=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
