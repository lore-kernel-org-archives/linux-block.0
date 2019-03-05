Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7486EC43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 01:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105F8206B6
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 01:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kJNn0reR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SwAyexJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCEBrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:47:25 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20827 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfCEBrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 20:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551750444; x=1583286444;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=57UbU0Grf2jgv29M9pKAOBg3rJ/J6J26lPGBRJwzlFA=;
  b=kJNn0reRqpr6P046i48SajE7XJK7k40vaWhr9No5lZZSGRJbCaP7Gk7N
   rAL/nOGvgZY9IQmqiWqpDw0KUSrDCQAqhiKruazF8g0PGc6VnGznyAJGa
   LYglXeA/ai5deOOECOTwmstlnsm4HF/s+CTHk+bM6XocRqC4FdAwg8Q2c
   1dWs8xZEXroGdUP3F0a4HhUO9SJe7CacXjdVEmZELgcQB3Mcv7b64eJki
   MsFvX8DjaDnKZwRRF5Dz2wjTf4ohdn+h+603i0w4ZJDx/DHll/3IrwtMv
   v7VrKJBBdCUPkILdg67VHYYVMhopvS4mSThi+AmphJ5h0pjGU2+s78pzu
   g==;
X-IronPort-AV: E=Sophos;i="5.58,442,1544457600"; 
   d="scan'208";a="102701487"
Received: from mail-by2nam01lp2053.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.53])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2019 09:47:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/xpR0/QvFqKxHPLIkpjQuSu6JTwWTSjwzaRQJWG2RY=;
 b=SwAyexJaief8rbgXjx5pTWhKugGztP8yVWBAfo8GWWOwKlAVHn/Dh1Wq8sYMv4GHuMTAALxc8HB9A3y530Vqj7hfzK4MMAgDUoXGifNUK9S+0vben0gwMmLXCUM56gLyf37+TqgYNH1bxkOf4E2sfZHx6+p4oaCo+Rv0/JSAuVM=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2011.namprd04.prod.outlook.com (10.166.191.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 01:47:22 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::8589:671:2c8:5f7a]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::8589:671:2c8:5f7a%11]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 01:47:22 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 3/5] check: Add TEST_DEV_PART_SYSFS variable
Thread-Topic: [PATCH blktests 3/5] check: Add TEST_DEV_PART_SYSFS variable
Thread-Index: AQHUyPQZtPd5l2Fznk21mIrYjym3fw==
Date:   Tue, 5 Mar 2019 01:47:22 +0000
Message-ID: <CY1PR04MB22688C319A12E8D396683889ED720@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
 <20190220081231.15366-4-shinichiro.kawasaki@wdc.com>
 <20190304223436.GC5450@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b7dbcc5-58de-4db4-af99-08d6a10c82d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2011;
x-ms-traffictypediagnostic: CY1PR04MB2011:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;CY1PR04MB2011;23:2OtopfsAb5njdpX1pLH63mwaJWnJXQSiiJPdSCKCt?=
 =?us-ascii?Q?C1OAyEVsK2NYMYCGeVFYETV9tpGqTpWht8IF6uV9552FFV7HhM+r2xJKaoBM?=
 =?us-ascii?Q?0b2W/41642orqa4ioOdWb8hOHhAIqRh4/j5FrEtaa1KvhBOlnwB34zPXrkRb?=
 =?us-ascii?Q?iG6f2D53WaWiF1tzf/luo3lHBE4k/0EHqBkkOgZp4TTTXBxEU1NLVfBiu4F/?=
 =?us-ascii?Q?/wqcDbfZddbBzg2ehkTIL51tqkrlq8zvGRPwKiCNJawWqJsrpYsgYF2Vhp7a?=
 =?us-ascii?Q?KoI4wu7dUVmzmaSRH/a4Wzy3PaOxn7A7V8daFZk347nWAz8lPKZB+Ef7HXmi?=
 =?us-ascii?Q?1oYnD5hiqNGDVjd6EP8Np5U2o3ZT8ifLG2qPEZxnJ96VN53z6HacKLw7A5oj?=
 =?us-ascii?Q?uvRbYGZBnF0O+j4rLgi35qprtwkIb3YOneWKQ8Qj25Y44IWG08fnlBtLs0e6?=
 =?us-ascii?Q?mfp4xiF56DTQ4n5kFZKJqFltBz7t3QD8W0lSwFa9vyhDiKWRwFRqr+kfelFs?=
 =?us-ascii?Q?KAe/fkLwTM0XAWhTnaI7l+XXU+W7fWf76hBDyThpIt4B1/Wn6e2DEyzxz5mB?=
 =?us-ascii?Q?YlAHDpH2WLWhZ/gz08CgLY5UFgEgFzFSDrqPCMenavdrQQ651mdAELXevUV9?=
 =?us-ascii?Q?ev0eqODgiSzGyjmAjVLB6caVwBMVBGbBGtBNTyoGSwYTwZRng0WSfsZlt5Uj?=
 =?us-ascii?Q?brn/z1rccaUGXMeJFqjhW3DVbEzMZ0V2EENiGqQCts2OtlH3mICW+D/yfO08?=
 =?us-ascii?Q?kOMrWbIlFfOvRqsrmew0WnbF8eggmrsZaL7cjc5fnh35MOZlQvN//nKYt8Bj?=
 =?us-ascii?Q?uZClGLhsHCjtP/fcLY8TGPXHTtAzGjV0gqDnX/nY6kS73zIEr1YWOJbI10IQ?=
 =?us-ascii?Q?uJ+qrhkg+PF4Ft3yCXFJgQYh5Hm55T3oi8zsCkFVes9GS67Ju9uIzfLR2urt?=
 =?us-ascii?Q?Q3In6eFfF95YFVO6EVh85MqRgqXxa9Q8CW2sGQNHBWLXxxJwevMh+APworEQ?=
 =?us-ascii?Q?NzL6HeIlKDmF64SO9ppiaF40HP93uEjQd1tT/BR57HMX20vRYMk2XB7Fncc8?=
 =?us-ascii?Q?pYKNgAStk7QJ1ZrTWWWyADHi9ShlqmMthIkUsrXnIndybJpjDHzBA1SnG8hR?=
 =?us-ascii?Q?5bVMe6VlqiS77Dtbe13HHeJw/sKzspqfNtoogYn+GkWH6+GOh8mSapO5Jl5d?=
 =?us-ascii?Q?1LHqYLTC5XymarBDFWsl88vYKbF36ALi/FydXi6WcMzWGa9Ro7vb8LvVbipV?=
 =?us-ascii?Q?AuMK/lKWiXwgYit/Z4=3D?=
x-microsoft-antispam-prvs: <CY1PR04MB2011B81EB5B181C67FDCA489ED720@CY1PR04MB2011.namprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(376002)(136003)(189003)(199004)(7736002)(44832011)(6916009)(305945005)(9686003)(97736004)(8936002)(74316002)(6436002)(71200400001)(71190400001)(478600001)(55016002)(14454004)(99286004)(66066001)(8676002)(53936002)(7696005)(81156014)(81166006)(229853002)(2906002)(53546011)(102836004)(76176011)(6246003)(5660300002)(52536013)(68736007)(86362001)(6506007)(106356001)(316002)(105586002)(54906003)(26005)(4326008)(33656002)(14444005)(256004)(186003)(25786009)(486006)(446003)(3846002)(476003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2011;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gP6X2bVaGgDNsXHFwN3rS1SsNzX/Izg7HngnxFF/f1Xv86RubPBQW41acK4kpGQyl1VrkoKw3S0oUeTO2rut3qEMtm78Eb9xonYLGIi8kKGeT4PDTSC683VHBoTWJk0G/YSComWxsYnKMN2vdekHXSuAxp4J3CQaPwQBdZgB6mVJjeD9HuwZUvoVeL1cxzddkvoE79NVCum1VoX8MQgGwDpN6jl0rAdTc3it+YxALSg5qFE7EoS1MVOptzOyBAtnH96EQD5j7DkhtRVPjFnWo4CM5wG0cc9DHChDGyiNon34NXa8XDqFfnSVR7PrObvdjtS9fBAGtYpSEuyXSn+KnxVG1cxZzjDfQfHxjmIf1YyFn3IqiqzRRYlOlRbqtk24/HsTm4FIq8J/KMYufYr+oBCcMFUOnqMmMvvCjI/MGsc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7dbcc5-58de-4db4-af99-08d6a10c82d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 01:47:22.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2011
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/19 7:34 AM, Omar Sandoval wrote:=0A=
> On Wed, Feb 20, 2019 at 05:12:29PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> When partition devices are specified in TEST_DEV, TEST_DEV_SYSFS=0A=
>> variable points to the sysfs paths of holder devices of the partition=0A=
>> devices (e.g., /sys/block/sda). This sysfs path is different from the=0A=
>> sysfs path of the partition devices (e.g., /sys/block/sda/sda1). For=0A=
>> example, size parameters exist in both the holder device sysfs and=0A=
>> the partition device sysfs with different values.=0A=
>>=0A=
>> To allow test cases to access sysfs path of the partition devices,=0A=
>> add TEST_DEV_PART_SYSFS variable. TEST_DEV_SYSFS is set as is to refer=
=0A=
>> the sysfs path of the holder devices. If the TEST_DEV is not a partition=
=0A=
>> device, an empty string is set to the TEST_DEV_PART_SYSFS variable.=0A=
>>=0A=
>> Change _find_sysfs_dir() function to return the holder device sysfs as=
=0A=
>> well as the partition device sysfs. The function obtains the canonical=
=0A=
>> sysfs path, and if the device is a partition device, the function cut th=
e=0A=
>> last device name in the canonical sysfs path to obtain the holder device=
=0A=
>> sysfs path.=0A=
> =0A=
> This makes sense. A couple of small tweaks below.=0A=
> =0A=
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> ---=0A=
>>   check | 51 ++++++++++++++++++++++++++++++++++-----------------=0A=
>>   new   | 16 ++++++++++++++--=0A=
>>   2 files changed, 48 insertions(+), 19 deletions(-)=0A=
>>=0A=
>> diff --git a/check b/check=0A=
>> index f41ecba..e45b34f 100755=0A=
>> --- a/check=0A=
>> +++ b/check=0A=
>> @@ -442,13 +442,19 @@ _run_test() {=0A=
>>   				_warning "$TEST_NAME: fallback_device call failure"=0A=
>>   				return 0=0A=
>>   			fi=0A=
>> -			if ! sysfs_dir=3D"$(_find_sysfs_dir "$test_dev")"; then=0A=
>> +=0A=
>> +			local dirs=0A=
>> +			local sysfs_dir=0A=
>> +			local part_sysfs_dir=0A=
>> +			if ! dirs=3D$(_find_sysfs_dir "$test_dev") ; then=0A=
>>   				_warning "$TEST_NAME: could not find sysfs directory for ${test_de=
v}"=0A=
>>   				cleanup_fallback_device=0A=
>>   				return 0=0A=
>>   			fi=0A=
>> +			read -r sysfs_dir part_sysfs_dir < <(echo "${dirs}")=0A=
> =0A=
> Let's rename _find_sysfs_dir to find_sysfs_dirs and make it set=0A=
> TEST_DEV_SYSFS_DIRS["$test_dev"] and=0A=
> TEST_DEV_PART_SYSFS_DIRS["$test_dev"] itself instead of returning the=0A=
> string.=0A=
=0A=
OK. Will revise the patch.=0A=
=0A=
> =0A=
>>   			TEST_DEVS=3D( "${test_dev}" )=0A=
>>   			TEST_DEV_SYSFS_DIRS["$test_dev"]=3D"$sysfs_dir"=0A=
>> +			TEST_DEV_PART_SYSFS_DIRS["$test_dev"]=3D"$part_sysfs_dir"=0A=
>>   			FALLBACK_DEVICE=3D1=0A=
>>   		fi=0A=
>>   =0A=
>> @@ -464,6 +470,7 @@ _run_test() {=0A=
>>   		local ret=3D0=0A=
>>   		for TEST_DEV in "${TEST_DEVS[@]}"; do=0A=
>>   			TEST_DEV_SYSFS=3D"${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"=0A=
>> +			TEST_DEV_PART_SYSFS=3D"${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"=0A=
>>   			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then=0A=
>>   				SKIP_REASON=3D"${TEST_DEV} is a zoned block device"=0A=
>>   				_output_notrun "$TEST_NAME =3D> $(basename "$TEST_DEV")"=0A=
>> @@ -483,6 +490,7 @@ _run_test() {=0A=
>>   		if (( FALLBACK_DEVICE )); then=0A=
>>   			cleanup_fallback_device=0A=
>>   			unset TEST_DEV_SYSFS_DIRS["${TEST_DEVS[0]}"]=0A=
>> +			unset TEST_DEV_PART_SYSFS_DIRS["${TEST_DEVS[0]}"]=0A=
>>   			TEST_DEVS=3D()=0A=
>>   		fi=0A=
>>   =0A=
>> @@ -507,6 +515,8 @@ _run_group() {=0A=
>>   		for i in "${!TEST_DEVS[@]}"; do=0A=
>>   			TEST_DEV=3D"${TEST_DEVS[$i]}"=0A=
>>   			TEST_DEV_SYSFS=3D"${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"=0A=
>> +			# shellcheck disable=3DSC2034=0A=
>> +			TEST_DEV_PART_SYSFS=3D"${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"=0A=
>>   			if ! group_device_requires; then=0A=
>>   				_output_notrun "${group}/*** =3D> $(basename "$TEST_DEV")"=0A=
>>   				unset TEST_DEVS["$i"]=0A=
>> @@ -529,28 +539,31 @@ _run_group() {=0A=
>>   =0A=
>>   _find_sysfs_dir() {=0A=
>>   	local test_dev=3D"$1"=0A=
>> +	local sysfs_path=0A=
>>   	local major=3D$((0x$(stat -L -c '%t' "$test_dev")))=0A=
>>   	local minor=3D$((0x$(stat -L -c '%T' "$test_dev")))=0A=
>> -	local dev=3D"$major:$minor"=0A=
>> +	local sysdev_path=3D"/sys/dev/block/${major}:${minor}"=0A=
>>   =0A=
>> -	local block_dir part_dir=0A=
>> -	for block_dir in /sys/block/*; do=0A=
>> -		if [[ $(cat "${block_dir}/dev") =3D "$dev" ]]; then=0A=
>> -			echo "$block_dir"=0A=
>> -			return=0A=
>> -		fi=0A=
>> -		for part_dir in "$block_dir"/*; do=0A=
>> -			if [[ -r ${part_dir}/dev && $(cat "${part_dir}/dev") =3D "$dev" ]]; =
then=0A=
>> -				echo "$block_dir"=0A=
>> -				return=0A=
>> -			fi=0A=
>> -		done=0A=
>> -	done=0A=
>> +	# Get the canonical sysfs path=0A=
>> +	if ! sysfs_path=3D/sys/dev/block/$(readlink "${sysdev_path}"); then=0A=
> =0A=
> sysfs_path=3D"$(realpath "/sys/dev/block/${major}:${minor}")" is a bit=0A=
> shorter, does that still work?=0A=
=0A=
Yes, the suggested code works well. Will revise the patch.=0A=
=0A=
I will resend this patch and the following two patches as a new series.=0A=
Thank you for the review!=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
