Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB3C04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2603521721
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gFW8U7V8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IIpwRTko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfE1QyT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 12:54:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15636 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfE1QyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 12:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559062458; x=1590598458;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7zExC1zIGXB1Wue3/D6xhKxcvfIFoNAzE8MqFMvFtmw=;
  b=gFW8U7V8nh430fQlmu8khQUloN/C4tDdmER8XQWkGpB4imDY/DPp9Smn
   9h8p7jwWEQUAprgxfgSjtvfpWMnCKmmlEP/wSuMJXfx9caiteAVkHHZGL
   QBWp8yw5OcGVCg1MA6bZ+rumvcuVwZ1GmBQ6T/lQr+UN/SkXzbsLw1uOH
   i3F/72dmLog6gD1IDs4mrwjadlJImMpIugyc5W+sQeoY7+7i5rHt5zvp6
   ciZCXFQ+CZy52GS5IPo4rtpkepdsA8rWVG4GoAfbq0Cnu5mGVMJheJ/z0
   s5W2rbuIlHSx3kyjRYN3De3HmK/yjjpKjABphdnr183mjufkcax8gKuau
   A==;
X-IronPort-AV: E=Sophos;i="5.60,523,1549900800"; 
   d="scan'208";a="110489429"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2019 00:54:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4rtWmnXz5cj21aHjfQMgEyzaPS/Y5GT/XL7+8elIr4=;
 b=IIpwRTko+AO4PSY9RQFlU6E8aO5Nv8y/sxSm9m4xUYK5iJsH1Q5BPxJ7RLyJJquZwyiwa8ZkmXOej6zAXmc2dk9OEu1Ue2JDUtRj0p806pdziFRJHnNX01SuBrvrJduwXQ8/VtjXEw+ppNynKm9QJk5dr0cdVNM0YpC5/zL/c64=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4199.namprd04.prod.outlook.com (20.176.250.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Tue, 28 May 2019 16:54:11 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 16:54:11 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests] zbd/007: Test zone mapping of logical devices
Thread-Topic: [PATCH blktests] zbd/007: Test zone mapping of logical devices
Thread-Index: AQHVCTAddiLDt+dc7kK1cI1IQhUl0A==
Date:   Tue, 28 May 2019 16:54:10 +0000
Message-ID: <BYAPR04MB5749C4B1DB13793A307BDA0C861E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190513020341.2254-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b46a55f-07b0-4dee-a68f-08d6e38d1b79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4199;
x-ms-traffictypediagnostic: BYAPR04MB4199:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4199BBF53221ACA03A765EB2861E0@BYAPR04MB4199.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(136003)(51914003)(189003)(199004)(14444005)(256004)(86362001)(52536014)(66066001)(76116006)(229853002)(7736002)(305945005)(5660300002)(14454004)(3846002)(316002)(478600001)(81156014)(81166006)(6116002)(102836004)(8676002)(72206003)(6436002)(68736007)(74316002)(33656002)(8936002)(446003)(2906002)(55016002)(25786009)(99286004)(2501003)(66946007)(66476007)(6246003)(66556008)(54906003)(76176011)(64756008)(66446008)(73956011)(53546011)(6506007)(7696005)(4326008)(53936002)(71190400001)(110136005)(71200400001)(186003)(9686003)(486006)(476003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4199;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3rbnZFeDbGX96aHcSpuXL0pgGXrQY6XJ54YP83PENaRgBlF/KcueeqTPnzINALR4gpIRjcrDF/mg2NeycHODpjmFflcIT2VTWd1jYv+0W7sYkk7Df1GgIzkW6sgscoeJt8q+48x46tGwirrjWnQaUfgFE9gpp+wfxyrC1BGtnqfJYwVibotzRuYHZRCOHQAofW7AMiSfjZBRtFuVFCpiUP42j6YO3X62XKem+Do6wILvtdesVqX6s0toYAOd+Uyts7gKkEDfp7Fcm/7vzePJNVqSKz0Y03PaUeFHqB7kn4O4pJkkGuboxhQd3+4mph5p00onSaZ27hr0jLZbJdddFFjPPPE+FcC0r9kQOPJu+WyQM99ePRwW0spa9ptlDIHjqX1Mxdazw1QBnZnE4bkF0JMqK+f1CoXQOjsnw5+vBOU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b46a55f-07b0-4dee-a68f-08d6e38d1b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 16:54:10.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4199
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Shinichiro,=0A=
=0A=
Thanks for the test, please see my in-line comments.=0A=
=0A=
=0A=
On 05/12/2019 07:03 PM, Shin'ichiro Kawasaki wrote:=0A=
> Check that zones sector mapping is correct for zoned block devices that=
=0A=
> are not an entire full device (null_block device or physical device).=0A=
> These logical devices are for now partition devices or device-mapper=0A=
> devices (dm-linear or dm-flakey). This test case requires that such a=0A=
> logical device be specified in TEST_DEVS in config. The test is skipped=
=0A=
> for devices that are identified as not logically created.=0A=
>=0A=
> To test that the zone mapping is correct, select a few sequential write=
=0A=
> required zones of the logical device and move the write pointers of=0A=
> these zones through the container device of the logical device, using=0A=
> the physical sector mapping of the zones. The write pointers position of=
=0A=
> the selected zones is then checked through a zone report of the logical=
=0A=
> device using the logical sector mapping of the zones. The test reports a=
=0A=
> success if the position of the zone write pointers relative to the zone=
=0A=
> start sector must be identical for both the logical and physical=0A=
> locations of the zones.=0A=
>=0A=
> To implement this test case, introduce several helper functions.=0A=
> _find_last_sequential_zone() and _find_sequential_zone_in_middle()=0A=
> help target zones selection. _test_dev_is_logical() checks the target=0A=
> device type. If false is returned, the test case is skipped.=0A=
> _get_dev_container_and_sector() helps to get the container device and=0A=
> sector mappings. At this moment, these helper functions support=0A=
> partition devices and dm-linear/flakey devices as the logical devices.=0A=
> _test_dev_has_dm_map() helps to check that the dm target is linear or=0A=
> flakey.=0A=
>=0A=
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> ---=0A=
>   tests/zbd/007     |  95 +++++++++++++++++++++++++++++++++=0A=
>   tests/zbd/007.out |   2 +=0A=
>   tests/zbd/rc      | 132 ++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>   3 files changed, 229 insertions(+)=0A=
>   create mode 100755 tests/zbd/007=0A=
>   create mode 100644 tests/zbd/007.out=0A=
>=0A=
> diff --git a/tests/zbd/007 b/tests/zbd/007=0A=
> new file mode 100755=0A=
> index 0000000..e4723d7=0A=
> --- /dev/null=0A=
> +++ b/tests/zbd/007=0A=
> @@ -0,0 +1,95 @@=0A=
> +#!/bin/bash=0A=
> +# SPDX-License-Identifier: GPL-3.0+=0A=
> +# Copyright (C) 2019 Western Digital Corporation or its affiliates.=0A=
> +#=0A=
> +# Test zones are mapped correctly between a logical device and its conta=
iner=0A=
> +# device. Move write pointers of sequential write required zones on the=
=0A=
> +# container devices, and confirm same write pointer positions of zones o=
n the=0A=
> +# logical devices.=0A=
> +=0A=
> +. tests/zbd/rc=0A=
> +=0A=
> +DESCRIPTION=3D"zone mapping"=0A=
Can this be more explanatory ?=0A=
> +CAN_BE_ZONED=3D1=0A=
Do we need QUICK=3D1 ?=0A=
> +=0A=
> +requires() {=0A=
> +	_have_program dmsetup=0A=
> +}=0A=
> +=0A=
> +device_requires() {=0A=
> +	_test_dev_is_logical=0A=
> +}=0A=
> +=0A=
> +test_device() {=0A=
> +	local -i bs=0A=
> +	local -i zone_idx=0A=
> +	local -a test_z # test target zones=0A=
> +	local -a test_z_start=0A=
> +=0A=
> +	echo "Running ${TEST_NAME}"=0A=
> +=0A=
> +	# Get physical block size to meet zoned block device I/O requirement=0A=
> +	_get_sysfs_variable "${TEST_DEV}" || return $?=0A=
> +	bs=3D${SYSFS_VARS[SV_PHYS_BLK_SIZE]}=0A=
> +	_put_sysfs_variable=0A=
> +=0A=
> +	# Select test target zones. Pick up the first sequential required zones=
.=0A=
> +	# If available, add one or two more sequential required zones. One is a=
t=0A=
> +	# the last end of TEST_DEV. The other is in middle between the first=0A=
> +	# and the last zones.=0A=
> +	_get_blkzone_report "${TEST_DEV}" || return $?=0A=
> +	zone_idx=3D$(_find_first_sequential_zone) || return $?=0A=
> +	test_z=3D( "${zone_idx}" )=0A=
> +	if zone_idx=3D$(_find_last_sequential_zone); then=0A=
> +		test_z+=3D( "${zone_idx}" )=0A=
> +		if zone_idx=3D$(_find_sequential_zone_in_middle \=0A=
> +				      "${test_z[0]}" "${test_z[1]}"); then=0A=
> +			test_z+=3D( "${zone_idx}" )=0A=
> +		fi=0A=
> +	fi=0A=
> +=0A=
> +	for ((i =3D 0; i < ${#test_z[@]}; i++)); do=0A=
> +		test_z_start+=3D("${ZONE_STARTS[test_z[i]]}")=0A=
> +	done=0A=
> +	echo "${test_z[*]}" >> "$FULL"=0A=
> +	echo "${test_z_start[*]}" >> "$FULL"=0A=
> +=0A=
> +	_put_blkzone_report=0A=
I think above code of building an array should be move to the same file =0A=
in a helper function. It is just making entire test look bigger than=0A=
it is.=0A=
> +=0A=
> +	# Reset and move write pointers of the container device=0A=
> +	for ((i=3D0; i < ${#test_z[@]}; i++)); do=0A=
> +		local -a arr=0A=
nit:- add a new line after declaration.=0A=
> +		read -r -a arr < <(_get_dev_container_and_sector \=0A=
> +					   "${test_z_start[i]}")=0A=
> +		container_dev=3D"${arr[0]}"=0A=
> +		container_start=3D"${arr[1]}"=0A=
> +=0A=
> +		echo "${container_dev}" "${container_start}" >> "$FULL"=0A=
> +=0A=
> +		blkzone reset -o "${container_start}" -c 1 "${container_dev}"=0A=
do we need to check the return value here ?=0A=
> +=0A=
> +		if ! dd if=3D/dev/zero of=3D"${container_dev}" bs=3D"${bs}" \=0A=
> +		     count=3D$((4096 * (i + 1) / bs)) oflag=3Ddirect \=0A=
> +		     seek=3D$((container_start * 512 / bs)) \=0A=
> +		     >> "$FULL" 2>&1 ; then=0A=
> +			echo "dd failed"=0A=
> +		fi=0A=
> +=0A=
> +		# Wait for partition table re-read event settles=0A=
> +		udevadm settle=0A=
> +	done=0A=
> +=0A=
> +	# Check write pointer positions on the logical device=0A=
> +	_get_blkzone_report "${TEST_DEV}" || return $?=0A=
> +	for ((i=3D0; i < ${#test_z[@]}; i++)); do=0A=
> +		if ((ZONE_WPTRS[test_z[i]] !=3D 8 * (i + 1))); then=0A=
> +			echo "Unexpected write pointer position"=0A=
> +			echo -n "zone=3D${i}, wp=3D${ZONE_WPTRS[i]}, "=0A=
> +			echo "dev=3D${TEST_DEV}"=0A=
> +		fi=0A=
> +		echo "${ZONE_WPTRS[${test_z[i]}]}" >> "$FULL"=0A=
> +	done=0A=
> +	_put_blkzone_report=0A=
> +=0A=
> +	echo "Test complete"=0A=
> +}=0A=
> diff --git a/tests/zbd/007.out b/tests/zbd/007.out=0A=
> new file mode 100644=0A=
> index 0000000..28a1395=0A=
> --- /dev/null=0A=
> +++ b/tests/zbd/007.out=0A=
> @@ -0,0 +1,2 @@=0A=
> +Running zbd/007=0A=
> +Test complete=0A=
> diff --git a/tests/zbd/rc b/tests/zbd/rc=0A=
> index 5f04c84..1168c4e 100644=0A=
For rc related code changes can you please send a separate preparation =0A=
patche ? It will be great if we can isolate the actual test from the=0A=
rc changes.=0A=
> --- a/tests/zbd/rc=0A=
> +++ b/tests/zbd/rc=0A=
> @@ -193,6 +193,42 @@ _find_first_sequential_zone() {=0A=
>   	return 1=0A=
>   }=0A=
>=0A=
> +_find_last_sequential_zone() {=0A=
> +	for ((idx =3D REPORTED_COUNT - 1; idx > 0; idx--)); do=0A=
> +		if ((ZONE_TYPES[idx] =3D=3D ZONE_TYPE_SEQ_WRITE_REQUIRED)); then=0A=
> +			echo "${idx}"=0A=
> +			return 0=0A=
> +		fi=0A=
> +	done=0A=
> +=0A=
> +	echo "-1"=0A=
> +	return 1=0A=
> +}=0A=
> +=0A=
> +# Try to find a sequential required zone between given two zone indices=
=0A=
> +_find_sequential_zone_in_middle() {=0A=
> +	local -i s=3D${1}=0A=
> +	local -i e=3D${2}=0A=
> +	local -i idx=3D$(((s + e) / 2))=0A=
> +	local -i i=3D1=0A=
> +=0A=
> +	while ((idx !=3D s)) && ((idx !=3D e)); do=0A=
> +		if ((ZONE_TYPES[idx] =3D=3D ZONE_TYPE_SEQ_WRITE_REQUIRED)); then=0A=
> +			echo "${idx}"=0A=
> +			return 0=0A=
> +		fi=0A=
> +		if ((i%2 =3D=3D 0)); then=0A=
> +			: $((idx +=3D i))=0A=
> +		else=0A=
> +			: $((idx -=3D i))=0A=
> +		fi=0A=
> +		: $((i++))=0A=
> +	done=0A=
> +=0A=
> +	echo "-1"=0A=
> +	return 1=0A=
> +}=0A=
> +=0A=
>   # Search zones and find two contiguous sequential required zones.=0A=
>   # Return index of the first zone of the found two zones.=0A=
>   # Call _get_blkzone_report() beforehand.=0A=
> @@ -210,3 +246,99 @@ _find_two_contiguous_seq_zones() {=0A=
>   	echo "Contiguous sequential write required zones not found"=0A=
>   	return 1=0A=
>   }=0A=
> +=0A=
> +_test_dev_is_dm() {=0A=
> +	if [[ ! -r "${TEST_DEV_SYSFS}/dm/name" ]]; then=0A=
> +		SKIP_REASON=3D"$TEST_DEV is not device-mapper"=0A=
> +		return 1=0A=
> +	fi=0A=
> +	return 0=0A=
> +}=0A=
> +=0A=
> +_test_dev_is_logical() {=0A=
> +	if ! _test_dev_is_partition && ! _test_dev_is_dm; then=0A=
> +		SKIP_REASON=3D"$TEST_DEV is not a logical device"=0A=
> +		return 1=0A=
> +	fi=0A=
> +	return 0=0A=
> +}=0A=
> +=0A=
> +_test_dev_has_dm_map() {=0A=
> +	local target_type=3D${1}=0A=
> +	local dm_name=0A=
nit:- new line after declaration.=0A=
> +	dm_name=3D$(cat "${TEST_DEV_SYSFS}/dm/name")=0A=
> +	if ! dmsetup status "${dm_name}" | grep -qe "${target_type}"; then=0A=
> +		SKIP_REASON=3D"$TEST_DEV does not have ${target_type} map"=0A=
> +		return 1=0A=
> +	fi=0A=
> +	if dmsetup status "${dm_name}" | grep -v "${target_type}"; then=0A=
> +		SKIP_REASON=3D"$TEST_DEV has map other than ${target_type}"=0A=
> +		return 1=0A=
> +	fi=0A=
> +	return 0=0A=
> +}=0A=
> +=0A=
> +# Get device file path from the device ID "major:minor".=0A=
> +_get_dev_path_by_id() {=0A=
> +	for d in /sys/block/*; do=0A=
> +		if [[ ! -r "${d}/dev" ]]; then=0A=
> +			continue=0A=
> +		fi=0A=
> +		dev_id=3D$(cat "${d}/dev")=0A=
> +		if [[ "${1}" =3D=3D "${dev_id}" ]]; then=0A=
> +			echo "/dev/${d##*/}"=0A=
> +			return 0=0A=
> +		fi=0A=
> +	done=0A=
> +	return 1=0A=
> +}=0A=
> +=0A=
> +# Given sector of TEST_DEV, return the device which contain the sector a=
nd=0A=
> +# corresponding sector of the container device.=0A=
> +_get_dev_container_and_sector() {=0A=
> +	local -i sector=3D${1}=0A=
> +	local cont_dev=0A=
> +	local -i offset=0A=
> +	local -a tbl_line=0A=
> +=0A=
> +	if _test_dev_is_partition; then=0A=
> +		offset=3D$(cat "${TEST_DEV_PART_SYSFS}/start")=0A=
> +		cont_dev=3D$(_get_dev_path_by_id "$(cat "${TEST_DEV_SYSFS}/dev")")=0A=
> +		echo "${cont_dev}" "$((offset + sector))"=0A=
> +		return 0=0A=
> +	fi=0A=
> +=0A=
> +	if ! _test_dev_is_dm; then=0A=
> +		echo "${TEST_DEV} is not a logical device"=0A=
> +		return 1=0A=
> +	fi=0A=
> +	if ! _test_dev_has_dm_map linear &&=0A=
> +			! _test_dev_has_dm_map flakey; then=0A=
> +		echo -n "dm mapping test other than linear/flakey is"=0A=
> +		echo "not implemented"=0A=
> +		return 1=0A=
> +	fi=0A=
> +=0A=
> +	# Parse dm table lines for dm-linear or dm-flakey target=0A=
> +	while read -r -a tbl_line; do=0A=
> +		local -i map_start=3D${tbl_line[0]}=0A=
> +		local -i map_end=3D$((tbl_line[0] + tbl_line[1]))=0A=
> +		if ((sector < map_start)) || (((map_end) <=3D sector)); then=0A=
> +			continue=0A=
> +		fi=0A=
> +=0A=
> +		offset=3D${tbl_line[4]}=0A=
> +		if ! cont_dev=3D$(_get_dev_path_by_id "${tbl_line[3]}"); then=0A=
> +			echo -n "Cannot access to container device: "=0A=
> +			echo "${tbl_line[3]}"=0A=
> +			return 1=0A=
> +		fi=0A=
> +=0A=
> +		echo "${cont_dev}" "$((offset + sector - map_start))"=0A=
> +		return 0=0A=
> +=0A=
> +	done < <(dmsetup table "$(cat "${TEST_DEV_SYSFS}/dm/name")")=0A=
> +=0A=
> +	echo -n "Cannot find container device of ${TEST_DEV}"=0A=
> +	return 1=0A=
> +}=0A=
>=0A=
=0A=
