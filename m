Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFAEC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 22:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7B4206B8
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 22:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZYFpoitP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C83bBD6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFDWOC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:14:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31306 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDWOC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 18:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559686441; x=1591222441;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qWjUUAVaUsRUHJSNMBVzVtWaXO62pls4kMkZlVYHijI=;
  b=ZYFpoitPUCxXLt/GU0J2ETggV3ShQR6hQMaY3oJePU8Jmxn7eYc7KqzL
   QxJy9XU0pw/FWc0z7fcseOIyGYov4xdPAMt0NRtq4jfhMJgayxuwgblkM
   /5HfNJM3xRn39i78VztjhAuIfJUqDx4igIlp629DA5kKNs+vCwWmf2tiY
   4PLnIvScfctd3vshdoPg+PAk0JKAd19UDKRU4pxB/EhaM/9418CoEQKFf
   IoalKQQsKsfuFov4ko4eg4EEb0jXXj2VJaLz+XvwN5iNnkaNwthxvQjHt
   3+z0dFWeWzkO60I1Um4ZSBQ396OJMIKQisEnCP2nDoHcvzX20S2RdlTco
   g==;
X-IronPort-AV: E=Sophos;i="5.60,550,1549900800"; 
   d="scan'208";a="111079032"
Received: from mail-bn3nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.58])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2019 06:14:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5edGAi/lfau/Ey9erjV8MGjxQ4QjTHKlGctF6x53do=;
 b=C83bBD6mkTCkg9Av7uZFMBxrHA/d3dDm3PHElXUNoLznxnWPhxoZDJEWUX2GQL7mFIWqT2vf5AhhlI72RKJxaFcYQoDbhctu8f/dhmfmxNkgWVNpCfIMqFvUzLUBJCxsfzYi7t80hy4C+G6Rlt1OWsqW7Gz0cMoI5htvr2Yg7Us=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB5258.namprd04.prod.outlook.com (20.178.25.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 22:13:57 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::749c:e0fc:238:5c6d]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::749c:e0fc:238:5c6d%4]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 22:13:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 2/2] zbd/007: Add zone mapping test for
 logical devices
Thread-Topic: [PATCH blktests v2 2/2] zbd/007: Add zone mapping test for
 logical devices
Thread-Index: AQHVF1R2/ItucHf4ik2yybemy7xgNA==
Date:   Tue, 4 Jun 2019 22:13:57 +0000
Message-ID: <DM6PR04MB57543AF8E11E706E0A457D1386150@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
 <20190531015913.5560-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:f446:fe8c:7ab2:8d71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cefd02c0-3063-40f5-664f-08d6e939f07b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB5258;
x-ms-traffictypediagnostic: DM6PR04MB5258:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB5258B8B2B655C8346CF9CD6186150@DM6PR04MB5258.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(66556008)(102836004)(25786009)(33656002)(81156014)(6436002)(52536014)(6506007)(8676002)(53546011)(66446008)(76116006)(55016002)(53936002)(186003)(8936002)(5660300002)(229853002)(9686003)(68736007)(64756008)(6246003)(66476007)(14444005)(71200400001)(71190400001)(2501003)(4326008)(316002)(91956017)(6116002)(66946007)(73956011)(256004)(2906002)(446003)(81166006)(99286004)(7696005)(76176011)(46003)(476003)(305945005)(486006)(74316002)(86362001)(14454004)(7736002)(72206003)(110136005)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5258;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nqpxg3yuO9L0fkYFzVG2vkI35sq0WFTfTYQ0OWD4MFOR/5gKp3KnUmCS6CQRUmttMVroGUXilaFj1n7/s0/cJ3IdMO2QrcyQIKGCwHsutd2F9AC4ZJdzymE1CvIq1HUzp2HC8VAavIGwqQwmPwm6Qij/gtDJg6UQsjlJ18YCUA26XrTIlW+GviwwVf1HabJn+JhWizhSK1OeDeqv8iaBzki5azDUVN034SVrCoMEyxXB8lhuZkMeQtKR4aBHwF5PQBymulFvRVo12+4QOScLAQCy1KBRQ9ufhVAFZ8+xcyDb88+PK/xSchgUlQdjFF8YzxlMezaqyhn2C+PC0qSFioWCdJXvj4S5labEqNwFVzpB4CZ/IYsmbyrOB92z2AFcInSIZxEAQaUSDSCKdfEY7YrF6l3Bd7lo5W1yNypMj7g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefd02c0-3063-40f5-664f-08d6e939f07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 22:13:57.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5258
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 5/30/19 6:59 PM, Shin'ichiro Kawasaki wrote:=0A=
> Add the test case to check zones sector mapping of logical devices. This=
=0A=
> test case requires that such a logical device be specified in TEST_DEVS=
=0A=
> in config. The test is skipped for devices that are identified as not=0A=
> logically created.=0A=
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
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> ---=0A=
>  tests/zbd/007     | 110 ++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  tests/zbd/007.out |   2 +=0A=
>  2 files changed, 112 insertions(+)=0A=
>  create mode 100755 tests/zbd/007=0A=
>  create mode 100644 tests/zbd/007.out=0A=
>=0A=
> diff --git a/tests/zbd/007 b/tests/zbd/007=0A=
> new file mode 100755=0A=
> index 0000000..b4dcbd8=0A=
> --- /dev/null=0A=
> +++ b/tests/zbd/007=0A=
> @@ -0,0 +1,110 @@=0A=
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
> +DESCRIPTION=3D"zone mapping between logical and container devices"=0A=
> +CAN_BE_ZONED=3D1=0A=
> +QUICK=3D1=0A=
> +=0A=
> +requires() {=0A=
> +	_have_program dmsetup=0A=
> +}=0A=
> +=0A=
> +device_requires() {=0A=
> +	_test_dev_is_logical=0A=
> +}=0A=
> +=0A=
> +# Select test target zones. Pick up the first sequential required zones.=
 If=0A=
> +# available, add one or two more sequential required zones. One is at th=
e last=0A=
> +# end of TEST_DEV. The other is in middle between the first and the last=
 zones.=0A=
> +select_zones() {=0A=
> +	local -i zone_idx=0A=
> +	local -a zones=0A=
> +=0A=
> +	zone_idx=3D$(_find_first_sequential_zone) || return $?=0A=
> +	zones=3D( "${zone_idx}" )=0A=
> +	if zone_idx=3D$(_find_last_sequential_zone); then=0A=
> +		zones+=3D( "${zone_idx}" )=0A=
> +		if zone_idx=3D$(_find_sequential_zone_in_middle \=0A=
> +				      "${zones[0]}" "${zones[1]}"); then=0A=
> +			zones+=3D( "${zone_idx}" )=0A=
> +		fi=0A=
> +	fi=0A=
> +	echo "${zones[@]}"=0A=
> +}=0A=
> +=0A=
> +test_device() {=0A=
> +	local -i bs=0A=
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
> +	# Get test target zones=0A=
> +	_get_blkzone_report "${TEST_DEV}" || return $?=0A=
> +	read -r -a test_z < <(select_zones)=0A=
> +	for ((i =3D 0; i < ${#test_z[@]}; i++)); do=0A=
> +		test_z_start+=3D("${ZONE_STARTS[test_z[i]]}")=0A=
> +	done=0A=
> +	echo "${test_z[*]}" >> "$FULL"=0A=
> +	echo "${test_z_start[*]}" >> "$FULL"=0A=
> +	_put_blkzone_report=0A=
> +	if ((!${#test_z[@]})); then=0A=
> +		echo "Test target zones not available on ${TEST_DEV}"=0A=
> +		return 1=0A=
> +	fi=0A=
> +=0A=
> +	# Reset and move write pointers of the container device=0A=
> +	for ((i=3D0; i < ${#test_z[@]}; i++)); do=0A=
> +		local -a arr=0A=
> +=0A=
> +		read -r -a arr < <(_get_dev_container_and_sector \=0A=
> +					   "${test_z_start[i]}")=0A=
> +		container_dev=3D"${arr[0]}"=0A=
> +		container_start=3D"${arr[1]}"=0A=
> +=0A=
> +		echo "${container_dev}" "${container_start}" >> "$FULL"=0A=
> +=0A=
> +		if ! blkzone reset -o "${container_start}" -c 1 \=0A=
> +		     "${container_dev}"; then=0A=
> +			echo "Reset zone failed"=0A=
> +			return 1=0A=
> +		fi=0A=
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
=0A=
=0A=
