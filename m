Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BAAC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9CD206B8
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 22:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UzHZV1Uo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F0kF7rsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFDWMq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:12:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15542 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDWMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jun 2019 18:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559686365; x=1591222365;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BlDzo4KGSm9vT7kJBJO+lct9IGpkTt9bZXzKCF/elag=;
  b=UzHZV1UokbTcjR67X++BZYRTXHvt3tY8NvyHOLlF7U/XMpX61kZ8oH/c
   nzZUagWw4gD6I5OL6kv61wvXNKdq+fppUJt3uDA+ozYW65QInrWEnZc1S
   0mClzLSJGhebmq7DL6QejHDFgxJtElMA7XMwZpeTHEhGVMrXgcJcGB+ul
   HQez1xONBSTKTfMiFMP7K/GN+M4bM1ds6U+WcN2wWm5a9TcltYK29oZO5
   jcLGFK7T7kglOlxo0KUfqkTUaJ/crE5SNwy8rZh3yi79Sj3lHJd+4k8Rd
   oIaJ09+W+QQrtzuT4wj8NJ25kNhIXRHpfVSXlpFNQDgmdR3YUCnxaRwJM
   g==;
X-IronPort-AV: E=Sophos;i="5.60,550,1549900800"; 
   d="scan'208";a="216091733"
Received: from mail-dm3nam03lp2056.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.56])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2019 06:12:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIc/JldhmPhw9mOSzdbYTn3MjbQUWZN/pn6a97Egk6M=;
 b=F0kF7rsZyMjn1qy2k1ySx5md1PihfBBexDUbSvMIFU1t6ZirwgP1ZvJ5tsiIS97MRcfpkonDmJF3gvqFTq2vep7QDdVTDng0ZJNvziQYi+g0yJ+wqFbcVmc9u2z78oWMf8xRx05NLmQ+SM7LQ8Msba4yGoox0f02eN+mdgqD4oU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5781.namprd04.prod.outlook.com (20.179.58.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 4 Jun 2019 22:12:43 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.023; Tue, 4 Jun 2019
 22:12:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for
 zone mapping test
Thread-Topic: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for
 zone mapping test
Thread-Index: AQHVF1R1LrUXzCLh3UCof19djoJckg==
Date:   Tue, 4 Jun 2019 22:12:43 +0000
Message-ID: <BYAPR04MB574920AE60FA0AEC27FEF40486150@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
 <20190531015913.5560-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:f446:fe8c:7ab2:8d71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92f33a64-7026-49fc-4751-08d6e939c435
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5781;
x-ms-traffictypediagnostic: BYAPR04MB5781:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5781E61F2C503FE130796DBD86150@BYAPR04MB5781.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(2906002)(33656002)(14454004)(46003)(478600001)(72206003)(2501003)(68736007)(52536014)(446003)(6116002)(186003)(66556008)(6246003)(476003)(7736002)(64756008)(8676002)(486006)(76116006)(66476007)(66446008)(81166006)(81156014)(73956011)(74316002)(305945005)(66946007)(4326008)(25786009)(6436002)(7696005)(76176011)(5660300002)(229853002)(256004)(71190400001)(99286004)(71200400001)(9686003)(53546011)(55016002)(6506007)(53936002)(316002)(54906003)(102836004)(14444005)(8936002)(86362001)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5781;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9AiZBgdrytjT6dXdCuJ6Wfx+lAFuzUhMpo/c1rzhhZTDBE2nY4hiLk+valgz8tJjJ92H1/8T3y6DZFV2UL4okO2Ca3HijCOleksVMNxOZ3dPMJ2KAAZcDQ3Mb/vPgjaaPdpu4LETg5mjZQig5rcG7Aj+NT7mdql8raIttoDPI2f1dyAG4mL1XYSZSzi2alqEAMSYK3H59fSWqxD8ZadrD1vRZK7DQLpspmNsE4kqKrvnPvsjpdPAyAQ/lyrORUKNbVSdRXyHbUf/1dZwKDJPHFP9BeQvKHPXEcprgeMNIb5Q9gHj5eBzBtrT4VpPN+vnmFEJWi9xYTqicftaU0wNCeIIP8kyIBKMqs6Jlcwj2OMdF40DzId+vHjYSXmjCS+r/PnmfjgvhQu+rnw9yZjl5VLs94Sqq1V6+4cDidr8kHw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f33a64-7026-49fc-4751-08d6e939c435
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 22:12:43.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5781
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Overall it looks good to me, couple of nits, can be ignored for now.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 5/30/19 6:59 PM, Shin'ichiro Kawasaki wrote:=0A=
> As a preparation for the zone mapping test case, add several helper=0A=
> functions. _find_last_sequential_zone() and=0A=
> _find_sequential_zone_in_middle() help to select test target zones.=0A=
> _test_dev_is_logical() checks TEST_DEV is the valid test target.=0A=
> _test_dev_has_dm_map() helps to check that the dm target is linear or=0A=
> flakey. _get_dev_container_and_sector() helps to get the container device=
=0A=
> and sector mappings.=0A=
> ---=0A=
>  tests/zbd/rc | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  1 file changed, 133 insertions(+)=0A=
>=0A=
> diff --git a/tests/zbd/rc b/tests/zbd/rc=0A=
> index 5f04c84..792b83d 100644=0A=
> --- a/tests/zbd/rc=0A=
> +++ b/tests/zbd/rc=0A=
> @@ -193,6 +193,42 @@ _find_first_sequential_zone() {=0A=
>  	return 1=0A=
>  }=0A=
>  =0A=
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
nit:- do we need to validate the s and e before we use ?=0A=
> +	local -i idx=3D$(((s + e) / 2))=0A=
> +	local -i i=3D1=0A=
> +=0A=
nit:- Is there a reason for while ? we can also get away with for loop=0A=
right ?=0A=
> +	while ((idx !=3D s && idx !=3D e)); do=0A=
> +		if ((ZONE_TYPES[idx] =3D=3D ZONE_TYPE_SEQ_WRITE_REQUIRED)); then=0A=
> +			echo "${idx}"=0A=
> +			return 0=0A=
> +		fi=0A=
> +		if ((i%2 =3D=3D 0)); then=0A=
> +			$((idx +=3D i))=0A=
> +		else=0A=
> +			$((idx -=3D i))=0A=
> +		fi=0A=
> +		$((i++))=0A=
> +	done=0A=
> +=0A=
> +	echo "-1"=0A=
> +	return 1=0A=
> +}=0A=
> +=0A=
>  # Search zones and find two contiguous sequential required zones.=0A=
>  # Return index of the first zone of the found two zones.=0A=
>  # Call _get_blkzone_report() beforehand.=0A=
> @@ -210,3 +246,100 @@ _find_two_contiguous_seq_zones() {=0A=
>  	echo "Contiguous sequential write required zones not found"=0A=
>  	return 1=0A=
>  }=0A=
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
> +=0A=
> +	dm_name=3D$(<"${TEST_DEV_SYSFS}/dm/name")=0A=
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
> +		if [[ "${1}" =3D=3D "$(<"${d}/dev")" ]]; then=0A=
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
> +		offset=3D$(<"${TEST_DEV_PART_SYSFS}/start")=0A=
> +		cont_dev=3D$(_get_dev_path_by_id "$(<"${TEST_DEV_SYSFS}/dev")")=0A=
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
> +=0A=
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
> +	done < <(dmsetup table "$(<"${TEST_DEV_SYSFS}/dm/name")")=0A=
> +=0A=
> +	echo -n "Cannot find container device of ${TEST_DEV}"=0A=
> +	return 1=0A=
> +}=0A=
=0A=
=0A=
