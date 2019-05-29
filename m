Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B753C04AB3
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 08:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F354020B1F
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 08:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pye4M2rv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XpUYU7n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfE2Itn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 04:49:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64278 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2Itn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 04:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559119782; x=1590655782;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zN6QxwVrzWWmHYtC2Mq4gzD8t835E7Mfcf6MVotvbYA=;
  b=pye4M2rv88bWrBBf9qOZy7HtGX0vycd1f8nOZ4MsmW1cs4o16mDNG4iE
   OCutAy8LzgDVIoaSM/1V8Un4qbuaBi6IcolWNj0D1d7WrfBOFwP5QXYo3
   fcji+xjYhUYl146Udw5Y3ihCMG7Pac2HZR20x6rp05ykHLm9ot82lkuTC
   fXkguDGf8V4Z/Sd1LAIUcoBh0FOCwqAFS3G1ZuPllSWJr9+pEFu0bDKGL
   86zbnwFl7tsTYBLgw9zvwmliErz/mXhtxDScSx7urS+XB4XvfRshDGFvJ
   2o2Wlp+FJMqJ1tOBN1h8Ke9UsvZ9DgQ/Y75EXGThG+tQG2c2+72tbIqxS
   g==;
X-IronPort-AV: E=Sophos;i="5.60,526,1549900800"; 
   d="scan'208";a="109290751"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2019 16:49:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCx319kaeANS+LH6yGaBmKGRRJtPoY9C8D8mnM2ijVE=;
 b=XpUYU7n0THAPXB0JWEBCeVg37c4kWiuV8oNWN4H8Mmxi1XzB5ukIOZOpj53VtUlzoYdd3O7eETQeuCm4L9z3V7ckVfMXTXVWXydGWu0BaTYkuM+6or9uj//KIDXDjh7VGibVPQjbmcVu8yNbk7s4nDMZcbrMsFpxPMuf8NVz2fw=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2154.namprd04.prod.outlook.com (10.174.128.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:49:38 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::dc9c:c09c:cd48:6be]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::dc9c:c09c:cd48:6be%5]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:49:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests] zbd/007: Test zone mapping of logical devices
Thread-Topic: [PATCH blktests] zbd/007: Test zone mapping of logical devices
Thread-Index: AQHVCTAddfkaQ8/eHkO7xfr84tutEA==
Date:   Wed, 29 May 2019 08:49:38 +0000
Message-ID: <CY1PR04MB2268EC4B629F89F9CFB74919ED1F0@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190513020341.2254-1-shinichiro.kawasaki@wdc.com>
 <BYAPR04MB5749C4B1DB13793A307BDA0C861E0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5b532d7-6a88-4808-fd56-08d6e4129524
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY1PR04MB2154;
x-ms-traffictypediagnostic: CY1PR04MB2154:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB21541955518344A85443713BED1F0@CY1PR04MB2154.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(51914003)(199004)(189003)(316002)(81166006)(91956017)(44832011)(74316002)(64756008)(66476007)(2906002)(66946007)(73956011)(68736007)(99286004)(76116006)(8676002)(446003)(2501003)(81156014)(486006)(256004)(476003)(66446008)(6116002)(305945005)(186003)(86362001)(478600001)(71190400001)(110136005)(7736002)(3846002)(26005)(54906003)(71200400001)(66556008)(14444005)(8936002)(66066001)(55016002)(9686003)(53936002)(25786009)(6246003)(6436002)(4326008)(229853002)(102836004)(5660300002)(7696005)(53546011)(6506007)(76176011)(33656002)(52536014)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2154;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S9Yq72bQnsSlG9KW0xSFO/hIedaQCD0jEDb3Qd3p3zE2KOy+h7z3BACQ1TTTFeAnRb7UaEUNq4lgJANDmifn0fGLw5MfFTMXbACnrOdfjq39ytALqE/fYZiQyOm0dV4b7DvZsIZQ/JjkROtgzsbkD4yID1nkPElWZJsmvFZpMXmApzgL/JfginxNDG9K5gaLYZg8hF7ZxhzCmi1jj/M496foqOdSAkovYST4PQ0GswrPIypWh6THtPCklIipj5GnWhrmcwE5xrSVyMzrJeIpRxXaZ1ad7OlXw7xtGgtOCrcB/LR7k5ZxmB0t7Ge3FxMcEXXcroLqOTslLO/28GY+rwuV+zx8dalujxI2v8fb0mC+SlSRz6shohOXtFmQzcPJbzGHsv+auJnJny7X4J6WBWSm8aBOEo1FtjZpjSRzRzU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b532d7-6a88-4808-fd56-08d6e4129524
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:49:38.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2154
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya, thank you for the review comments.=0A=
=0A=
On 5/29/19 1:54 AM, Chaitanya Kulkarni wrote:=0A=
> Hi Shinichiro,=0A=
> =0A=
> Thanks for the test, please see my in-line comments.=0A=
> =0A=
> =0A=
> On 05/12/2019 07:03 PM, Shin'ichiro Kawasaki wrote:=0A=
>> Check that zones sector mapping is correct for zoned block devices that=
=0A=
>> are not an entire full device (null_block device or physical device).=0A=
>> These logical devices are for now partition devices or device-mapper=0A=
>> devices (dm-linear or dm-flakey). This test case requires that such a=0A=
>> logical device be specified in TEST_DEVS in config. The test is skipped=
=0A=
>> for devices that are identified as not logically created.=0A=
>>=0A=
>> To test that the zone mapping is correct, select a few sequential write=
=0A=
>> required zones of the logical device and move the write pointers of=0A=
>> these zones through the container device of the logical device, using=0A=
>> the physical sector mapping of the zones. The write pointers position of=
=0A=
>> the selected zones is then checked through a zone report of the logical=
=0A=
>> device using the logical sector mapping of the zones. The test reports a=
=0A=
>> success if the position of the zone write pointers relative to the zone=
=0A=
>> start sector must be identical for both the logical and physical=0A=
>> locations of the zones.=0A=
>>=0A=
>> To implement this test case, introduce several helper functions.=0A=
>> _find_last_sequential_zone() and _find_sequential_zone_in_middle()=0A=
>> help target zones selection. _test_dev_is_logical() checks the target=0A=
>> device type. If false is returned, the test case is skipped.=0A=
>> _get_dev_container_and_sector() helps to get the container device and=0A=
>> sector mappings. At this moment, these helper functions support=0A=
>> partition devices and dm-linear/flakey devices as the logical devices.=
=0A=
>> _test_dev_has_dm_map() helps to check that the dm target is linear or=0A=
>> flakey.=0A=
>>=0A=
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> ---=0A=
>>    tests/zbd/007     |  95 +++++++++++++++++++++++++++++++++=0A=
>>    tests/zbd/007.out |   2 +=0A=
>>    tests/zbd/rc      | 132 +++++++++++++++++++++++++++++++++++++++++++++=
+=0A=
>>    3 files changed, 229 insertions(+)=0A=
>>    create mode 100755 tests/zbd/007=0A=
>>    create mode 100644 tests/zbd/007.out=0A=
>>=0A=
>> diff --git a/tests/zbd/007 b/tests/zbd/007=0A=
>> new file mode 100755=0A=
>> index 0000000..e4723d7=0A=
>> --- /dev/null=0A=
>> +++ b/tests/zbd/007=0A=
>> @@ -0,0 +1,95 @@=0A=
>> +#!/bin/bash=0A=
>> +# SPDX-License-Identifier: GPL-3.0+=0A=
>> +# Copyright (C) 2019 Western Digital Corporation or its affiliates.=0A=
>> +#=0A=
>> +# Test zones are mapped correctly between a logical device and its cont=
ainer=0A=
>> +# device. Move write pointers of sequential write required zones on the=
=0A=
>> +# container devices, and confirm same write pointer positions of zones =
on the=0A=
>> +# logical devices.=0A=
>> +=0A=
>> +. tests/zbd/rc=0A=
>> +=0A=
>> +DESCRIPTION=3D"zone mapping"=0A=
> Can this be more explanatory ?=0A=
=0A=
Yes, will add more words for clarification.=0A=
=0A=
>> +CAN_BE_ZONED=3D1=0A=
> Do we need QUICK=3D1 ?=0A=
=0A=
Indeed. It takes less than 10 seconds.=0A=
=0A=
>> +=0A=
>> +requires() {=0A=
>> +	_have_program dmsetup=0A=
>> +}=0A=
>> +=0A=
>> +device_requires() {=0A=
>> +	_test_dev_is_logical=0A=
>> +}=0A=
>> +=0A=
>> +test_device() {=0A=
>> +	local -i bs=0A=
>> +	local -i zone_idx=0A=
>> +	local -a test_z # test target zones=0A=
>> +	local -a test_z_start=0A=
>> +=0A=
>> +	echo "Running ${TEST_NAME}"=0A=
>> +=0A=
>> +	# Get physical block size to meet zoned block device I/O requirement=
=0A=
>> +	_get_sysfs_variable "${TEST_DEV}" || return $?=0A=
>> +	bs=3D${SYSFS_VARS[SV_PHYS_BLK_SIZE]}=0A=
>> +	_put_sysfs_variable=0A=
>> +=0A=
>> +	# Select test target zones. Pick up the first sequential required zone=
s.=0A=
>> +	# If available, add one or two more sequential required zones. One is =
at=0A=
>> +	# the last end of TEST_DEV. The other is in middle between the first=
=0A=
>> +	# and the last zones.=0A=
>> +	_get_blkzone_report "${TEST_DEV}" || return $?=0A=
>> +	zone_idx=3D$(_find_first_sequential_zone) || return $?=0A=
>> +	test_z=3D( "${zone_idx}" )=0A=
>> +	if zone_idx=3D$(_find_last_sequential_zone); then=0A=
>> +		test_z+=3D( "${zone_idx}" )=0A=
>> +		if zone_idx=3D$(_find_sequential_zone_in_middle \=0A=
>> +				      "${test_z[0]}" "${test_z[1]}"); then=0A=
>> +			test_z+=3D( "${zone_idx}" )=0A=
>> +		fi=0A=
>> +	fi=0A=
>> +=0A=
>> +	for ((i =3D 0; i < ${#test_z[@]}; i++)); do=0A=
>> +		test_z_start+=3D("${ZONE_STARTS[test_z[i]]}")=0A=
>> +	done=0A=
>> +	echo "${test_z[*]}" >> "$FULL"=0A=
>> +	echo "${test_z_start[*]}" >> "$FULL"=0A=
>> +=0A=
>> +	_put_blkzone_report=0A=
> I think above code of building an array should be move to the same file=
=0A=
> in a helper function. It is just making entire test look bigger than=0A=
> it is.=0A=
=0A=
OK. I will separate out test_z array building code into a function.=0A=
=0A=
>> +=0A=
>> +	# Reset and move write pointers of the container device=0A=
>> +	for ((i=3D0; i < ${#test_z[@]}; i++)); do=0A=
>> +		local -a arr=0A=
> nit:- add a new line after declaration.=0A=
>> +		read -r -a arr < <(_get_dev_container_and_sector \=0A=
>> +					   "${test_z_start[i]}")=0A=
>> +		container_dev=3D"${arr[0]}"=0A=
>> +		container_start=3D"${arr[1]}"=0A=
>> +=0A=
>> +		echo "${container_dev}" "${container_start}" >> "$FULL"=0A=
>> +=0A=
>> +		blkzone reset -o "${container_start}" -c 1 "${container_dev}"=0A=
> do we need to check the return value here ?=0A=
=0A=
Yes, will add the check.=0A=
=0A=
>> +=0A=
>> +		if ! dd if=3D/dev/zero of=3D"${container_dev}" bs=3D"${bs}" \=0A=
>> +		     count=3D$((4096 * (i + 1) / bs)) oflag=3Ddirect \=0A=
>> +		     seek=3D$((container_start * 512 / bs)) \=0A=
>> +		     >> "$FULL" 2>&1 ; then=0A=
>> +			echo "dd failed"=0A=
>> +		fi=0A=
>> +=0A=
>> +		# Wait for partition table re-read event settles=0A=
>> +		udevadm settle=0A=
>> +	done=0A=
>> +=0A=
>> +	# Check write pointer positions on the logical device=0A=
>> +	_get_blkzone_report "${TEST_DEV}" || return $?=0A=
>> +	for ((i=3D0; i < ${#test_z[@]}; i++)); do=0A=
>> +		if ((ZONE_WPTRS[test_z[i]] !=3D 8 * (i + 1))); then=0A=
>> +			echo "Unexpected write pointer position"=0A=
>> +			echo -n "zone=3D${i}, wp=3D${ZONE_WPTRS[i]}, "=0A=
>> +			echo "dev=3D${TEST_DEV}"=0A=
>> +		fi=0A=
>> +		echo "${ZONE_WPTRS[${test_z[i]}]}" >> "$FULL"=0A=
>> +	done=0A=
>> +	_put_blkzone_report=0A=
>> +=0A=
>> +	echo "Test complete"=0A=
>> +}=0A=
>> diff --git a/tests/zbd/007.out b/tests/zbd/007.out=0A=
>> new file mode 100644=0A=
>> index 0000000..28a1395=0A=
>> --- /dev/null=0A=
>> +++ b/tests/zbd/007.out=0A=
>> @@ -0,0 +1,2 @@=0A=
>> +Running zbd/007=0A=
>> +Test complete=0A=
>> diff --git a/tests/zbd/rc b/tests/zbd/rc=0A=
>> index 5f04c84..1168c4e 100644=0A=
> For rc related code changes can you please send a separate preparation=0A=
> patche ? It will be great if we can isolate the actual test from the=0A=
> rc changes.=0A=
=0A=
OK. Will separate out zbd/rc part. I will post v2 as a series with two patc=
hes.=0A=
=0A=
>> --- a/tests/zbd/rc=0A=
>> +++ b/tests/zbd/rc=0A=
>> @@ -193,6 +193,42 @@ _find_first_sequential_zone() {=0A=
>>    	return 1=0A=
>>    }=0A=
>>=0A=
>> +_find_last_sequential_zone() {=0A=
>> +	for ((idx =3D REPORTED_COUNT - 1; idx > 0; idx--)); do=0A=
>> +		if ((ZONE_TYPES[idx] =3D=3D ZONE_TYPE_SEQ_WRITE_REQUIRED)); then=0A=
>> +			echo "${idx}"=0A=
>> +			return 0=0A=
>> +		fi=0A=
>> +	done=0A=
>> +=0A=
>> +	echo "-1"=0A=
>> +	return 1=0A=
>> +}=0A=
>> +=0A=
>> +# Try to find a sequential required zone between given two zone indices=
=0A=
>> +_find_sequential_zone_in_middle() {=0A=
>> +	local -i s=3D${1}=0A=
>> +	local -i e=3D${2}=0A=
>> +	local -i idx=3D$(((s + e) / 2))=0A=
>> +	local -i i=3D1=0A=
>> +=0A=
>> +	while ((idx !=3D s)) && ((idx !=3D e)); do=0A=
>> +		if ((ZONE_TYPES[idx] =3D=3D ZONE_TYPE_SEQ_WRITE_REQUIRED)); then=0A=
>> +			echo "${idx}"=0A=
>> +			return 0=0A=
>> +		fi=0A=
>> +		if ((i%2 =3D=3D 0)); then=0A=
>> +			: $((idx +=3D i))=0A=
>> +		else=0A=
>> +			: $((idx -=3D i))=0A=
>> +		fi=0A=
>> +		: $((i++))=0A=
>> +	done=0A=
>> +=0A=
>> +	echo "-1"=0A=
>> +	return 1=0A=
>> +}=0A=
>> +=0A=
>>    # Search zones and find two contiguous sequential required zones.=0A=
>>    # Return index of the first zone of the found two zones.=0A=
>>    # Call _get_blkzone_report() beforehand.=0A=
>> @@ -210,3 +246,99 @@ _find_two_contiguous_seq_zones() {=0A=
>>    	echo "Contiguous sequential write required zones not found"=0A=
>>    	return 1=0A=
>>    }=0A=
>> +=0A=
>> +_test_dev_is_dm() {=0A=
>> +	if [[ ! -r "${TEST_DEV_SYSFS}/dm/name" ]]; then=0A=
>> +		SKIP_REASON=3D"$TEST_DEV is not device-mapper"=0A=
>> +		return 1=0A=
>> +	fi=0A=
>> +	return 0=0A=
>> +}=0A=
>> +=0A=
>> +_test_dev_is_logical() {=0A=
>> +	if ! _test_dev_is_partition && ! _test_dev_is_dm; then=0A=
>> +		SKIP_REASON=3D"$TEST_DEV is not a logical device"=0A=
>> +		return 1=0A=
>> +	fi=0A=
>> +	return 0=0A=
>> +}=0A=
>> +=0A=
>> +_test_dev_has_dm_map() {=0A=
>> +	local target_type=3D${1}=0A=
>> +	local dm_name=0A=
> nit:- new line after declaration.=0A=
=0A=
Will reflect your nit comments also in the v2 patch.=0A=
=0A=
Thanks!=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
