Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FFC04AB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 07:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CB720645
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 07:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I+05OApd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a5/uO7Cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfFFHwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:52:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2666 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFHwi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 03:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559807556; x=1591343556;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tKjlwx1VwcUybL0HKXwS4rIgUQP3Ipd+RTQJIAnxdwk=;
  b=I+05OApd8oe1xsdw6wkRttlmRyPUIjIB1dS4WfisO1NgzLD5OAhylap4
   XabIpS81M1bfZjHVSSEYAYBQwCsrgYrm6+1CJT7zx1OU7JpQbJKAVDLaA
   L54EhM31q0GOtBe0mIMtcpqZvncQc1aQ2IzRXmBsJt+NtCDAS3IRBW+ck
   yXht/mSIEKsSNxhF+5b+zR7JPerJ8qDYpyMTFIIzEoDFsgoiqiVo1pN2s
   gswPaRH3L4KYX3g003g0sDE/aS8tWn9qUne4FZYYy59WVvYw6v8bn4Da9
   0YCgmSCCdm9n8Uyymxp7gvg0JWyvZfuIWhXUUdZfY2fjH4OL96RooF+r3
   g==;
X-IronPort-AV: E=Sophos;i="5.63,558,1557158400"; 
   d="scan'208";a="111207517"
Received: from mail-dm3nam05lp2056.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.56])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2019 15:52:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o56TwV1t2M9hmqSTSI8wk6zbUD+PUm2IrNbN+sdaqWA=;
 b=a5/uO7Ccc3bui4TdxCjfAlGul7yBoQnvtFaSLka5t6Qp9cbXkRZckjkY13cmOGo42JATXRZwmqZeeYris+wGT2rQxtsaR4TTzyIQbx7u2wxosQtvsYKVZK3eXe636kXFPNMS/Ze/LvmMZL7K7/pBSCYjn7Bcr18QWiG5OO6Qnjw=
Received: from BN3PR04MB2257.namprd04.prod.outlook.com (10.166.73.148) by
 BN3PR04MB2259.namprd04.prod.outlook.com (10.167.5.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 07:52:34 +0000
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::45c:b93e:9f81:3339]) by BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::45c:b93e:9f81:3339%7]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 07:52:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for
 zone mapping test
Thread-Topic: [PATCH blktests v2 1/2] zbd/rc: Introduce helper functions for
 zone mapping test
Thread-Index: AQHVF1R1TD40R7jYzkKGd94NFNsZTw==
Date:   Thu, 6 Jun 2019 07:52:33 +0000
Message-ID: <BN3PR04MB225798870D553576B7C3C76FED170@BN3PR04MB2257.namprd04.prod.outlook.com>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
 <20190531015913.5560-2-shinichiro.kawasaki@wdc.com>
 <BYAPR04MB574920AE60FA0AEC27FEF40486150@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee4ed24d-fd22-4b52-5cef-08d6ea53ef69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN3PR04MB2259;
x-ms-traffictypediagnostic: BN3PR04MB2259:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR04MB2259CAC32533693A91F0A224ED170@BN3PR04MB2259.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(53936002)(81156014)(478600001)(81166006)(476003)(68736007)(71200400001)(71190400001)(14454004)(316002)(66446008)(73956011)(64756008)(6436002)(256004)(305945005)(7736002)(4326008)(7696005)(446003)(8676002)(66066001)(6506007)(44832011)(53546011)(229853002)(74316002)(2906002)(25786009)(33656002)(14444005)(76176011)(6246003)(5660300002)(8936002)(26005)(486006)(91956017)(66946007)(66556008)(52536014)(6116002)(54906003)(66476007)(3846002)(102836004)(9686003)(55016002)(110136005)(76116006)(99286004)(186003)(86362001)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR04MB2259;H:BN3PR04MB2257.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yGMUq+ix/T3jhKOTlP/NfRVKBKklQYEADx8IdR2L+o5tjBRrfk76HZCxoSjjk9SNBCyziSdSevpR7xbozUwr0qB6nRT+W9OIvjzIszaYYA+12ZfO31Htk9SjTi6H5H87BKjsGg3jFIjRqpQ8dG8Xmc7jtAU8vPNgedWpCinYCgkrVaHPvV9jKZ40lcsSbZGt7aWx64YZ9/xMipZruI4a5/oJ3qgI5euBePw56QUKWOsIqD1sNBJh33paXriLLnXFudwDdFtvuT/273rTG7Ny/fmsnTMcTYQbKK96mSXELbwF6MTzd5X0Q9Gmqtjl8LLXp+8ZPFIEto8XNyXkED9RpLnqSmnQI0lXsf/kh0MHYY7We1tQPBZx2IkMlHLMGgeVQ1HDRfDjgrpa4KcIIFMLAcx5LMyk2WxZZXk/uKgouJI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4ed24d-fd22-4b52-5cef-08d6ea53ef69
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 07:52:33.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2259
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/5/19 7:12 AM, Chaitanya Kulkarni wrote:=0A=
> Overall it looks good to me, couple of nits, can be ignored for now.=0A=
> =0A=
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> =0A=
> On 5/30/19 6:59 PM, Shin'ichiro Kawasaki wrote:=0A=
>> As a preparation for the zone mapping test case, add several helper=0A=
>> functions. _find_last_sequential_zone() and=0A=
>> _find_sequential_zone_in_middle() help to select test target zones.=0A=
>> _test_dev_is_logical() checks TEST_DEV is the valid test target.=0A=
>> _test_dev_has_dm_map() helps to check that the dm target is linear or=0A=
>> flakey. _get_dev_container_and_sector() helps to get the container devic=
e=0A=
>> and sector mappings.=0A=
>> ---=0A=
>>   tests/zbd/rc | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   1 file changed, 133 insertions(+)=0A=
>>=0A=
>> diff --git a/tests/zbd/rc b/tests/zbd/rc=0A=
>> index 5f04c84..792b83d 100644=0A=
>> --- a/tests/zbd/rc=0A=
>> +++ b/tests/zbd/rc=0A=
>> @@ -193,6 +193,42 @@ _find_first_sequential_zone() {=0A=
>>   	return 1=0A=
>>   }=0A=
>>   =0A=
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
> nit:- do we need to validate the s and e before we use ?=0A=
=0A=
Yes. Will add the checks in the v3 patch. Thanks.=0A=
=0A=
>> +	local -i idx=3D$(((s + e) / 2))=0A=
>> +	local -i i=3D1=0A=
>> +=0A=
> nit:- Is there a reason for while ? we can also get away with for loop=0A=
> right ?=0A=
=0A=
My understanding is that ZBC and ZAC allow to place conventional zones betw=
een =0A=
the sequential required zones 's' and 'e'. The loop is required to check zo=
ne =0A=
types to find out a sequential required zone, not a conventional zone in ca=
se =0A=
such devices get available in the future.=0A=
=0A=
>> +	while ((idx !=3D s && idx !=3D e)); do=0A=
>> +		if ((ZONE_TYPES[idx] =3D=3D ZONE_TYPE_SEQ_WRITE_REQUIRED)); then=0A=
>> +			echo "${idx}"=0A=
>> +			return 0=0A=
>> +		fi=0A=
>> +		if ((i%2 =3D=3D 0)); then=0A=
>> +			$((idx +=3D i))=0A=
>> +		else=0A=
>> +			$((idx -=3D i))=0A=
>> +		fi=0A=
>> +		$((i++))=0A=
>> +	done=0A=
>> +=0A=
>> +	echo "-1"=0A=
>> +	return 1=0A=
>> +}=0A=
>> +=0A=
>>   # Search zones and find two contiguous sequential required zones.=0A=
>>   # Return index of the first zone of the found two zones.=0A=
>>   # Call _get_blkzone_report() beforehand.=0A=
>> @@ -210,3 +246,100 @@ _find_two_contiguous_seq_zones() {=0A=
>>   	echo "Contiguous sequential write required zones not found"=0A=
>>   	return 1=0A=
>>   }=0A=
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
>> +=0A=
>> +	dm_name=3D$(<"${TEST_DEV_SYSFS}/dm/name")=0A=
>> +	if ! dmsetup status "${dm_name}" | grep -qe "${target_type}"; then=0A=
>> +		SKIP_REASON=3D"$TEST_DEV does not have ${target_type} map"=0A=
>> +		return 1=0A=
>> +	fi=0A=
>> +	if dmsetup status "${dm_name}" | grep -v "${target_type}"; then=0A=
>> +		SKIP_REASON=3D"$TEST_DEV has map other than ${target_type}"=0A=
>> +		return 1=0A=
>> +	fi=0A=
>> +	return 0=0A=
>> +}=0A=
>> +=0A=
>> +# Get device file path from the device ID "major:minor".=0A=
>> +_get_dev_path_by_id() {=0A=
>> +	for d in /sys/block/*; do=0A=
>> +		if [[ ! -r "${d}/dev" ]]; then=0A=
>> +			continue=0A=
>> +		fi=0A=
>> +		if [[ "${1}" =3D=3D "$(<"${d}/dev")" ]]; then=0A=
>> +			echo "/dev/${d##*/}"=0A=
>> +			return 0=0A=
>> +		fi=0A=
>> +	done=0A=
>> +	return 1=0A=
>> +}=0A=
>> +=0A=
>> +# Given sector of TEST_DEV, return the device which contain the sector =
and=0A=
>> +# corresponding sector of the container device.=0A=
>> +_get_dev_container_and_sector() {=0A=
>> +	local -i sector=3D${1}=0A=
>> +	local cont_dev=0A=
>> +	local -i offset=0A=
>> +	local -a tbl_line=0A=
>> +=0A=
>> +	if _test_dev_is_partition; then=0A=
>> +		offset=3D$(<"${TEST_DEV_PART_SYSFS}/start")=0A=
>> +		cont_dev=3D$(_get_dev_path_by_id "$(<"${TEST_DEV_SYSFS}/dev")")=0A=
>> +		echo "${cont_dev}" "$((offset + sector))"=0A=
>> +		return 0=0A=
>> +	fi=0A=
>> +=0A=
>> +	if ! _test_dev_is_dm; then=0A=
>> +		echo "${TEST_DEV} is not a logical device"=0A=
>> +		return 1=0A=
>> +	fi=0A=
>> +	if ! _test_dev_has_dm_map linear &&=0A=
>> +			! _test_dev_has_dm_map flakey; then=0A=
>> +		echo -n "dm mapping test other than linear/flakey is"=0A=
>> +		echo "not implemented"=0A=
>> +		return 1=0A=
>> +	fi=0A=
>> +=0A=
>> +	# Parse dm table lines for dm-linear or dm-flakey target=0A=
>> +	while read -r -a tbl_line; do=0A=
>> +		local -i map_start=3D${tbl_line[0]}=0A=
>> +		local -i map_end=3D$((tbl_line[0] + tbl_line[1]))=0A=
>> +=0A=
>> +		if ((sector < map_start)) || (((map_end) <=3D sector)); then=0A=
>> +			continue=0A=
>> +		fi=0A=
>> +=0A=
>> +		offset=3D${tbl_line[4]}=0A=
>> +		if ! cont_dev=3D$(_get_dev_path_by_id "${tbl_line[3]}"); then=0A=
>> +			echo -n "Cannot access to container device: "=0A=
>> +			echo "${tbl_line[3]}"=0A=
>> +			return 1=0A=
>> +		fi=0A=
>> +=0A=
>> +		echo "${cont_dev}" "$((offset + sector - map_start))"=0A=
>> +		return 0=0A=
>> +=0A=
>> +	done < <(dmsetup table "$(<"${TEST_DEV_SYSFS}/dm/name")")=0A=
>> +=0A=
>> +	echo -n "Cannot find container device of ${TEST_DEV}"=0A=
>> +	return 1=0A=
>> +}=0A=
> =0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
