Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A03C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B7C214DA
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q64YggOQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eeJcEU26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfA1KHJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:07:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4549 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1KHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 05:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548670029; x=1580206029;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=f/GnGdF70VcpHlHvuuDGE/wfCiUnEWLG5jAkRyTz5XI=;
  b=Q64YggOQfWmd0LzpwXBUjfJfW3rYwAMiAcSJggaKXnB4ovdnw/Wt7hWy
   PTkXJifW9gBBQ0Ow2894TNsYDKf6FwEIP1ykPgnIVhpQrQngxeexilTuq
   ftfq9lJ44/uq3wHyFtq+Khcnst9bvglaAH0tbTt2tvKGmVKL0QWZbWnm4
   ROZhxUc/ezNgD8WpGqGlEeMgaJpaAvSJG8FmR/WRQaXV/YnH+Ksoty9Uk
   XWLHmYnjT+p62OWBAPj5YwHTDF9SWa0DW4VcAWJT/dAakjc2TSo139Naq
   ZI+JLtWbDK5wHI7Sx4qb1hPkbkuIY1P301gxNYWHxTUscwOX+w9e8iPZL
   w==;
X-IronPort-AV: E=Sophos;i="5.56,533,1539619200"; 
   d="scan'208";a="101186012"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 18:07:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z41GEdR+RpbQLDJDd/CGFOFgyGN9qgVr/JvbligsuPw=;
 b=eeJcEU26Ai1AY6on6CBrXZsHomPj9CF6zdWQ57qOXTNbMD5dVOHYMf85CVQg7GtOP4LPYG5ojdrcSpXwq9LNc4fNvklIxRl0XocpOFruqr7AFZb5xtpt6+6YPF1IiR/E/QN2g8dZGS44pHKODVDP7EJSv3bwEUXfLoZLra7nOvI=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2042.namprd04.prod.outlook.com (10.166.191.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Mon, 28 Jan 2019 10:07:05 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 10:07:05 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH blktests v3 01/13] config: Introduce RUN_ZONED_TESTS
 variable and CAN_BE_ZONED flag
Thread-Topic: [PATCH blktests v3 01/13] config: Introduce RUN_ZONED_TESTS
 variable and CAN_BE_ZONED flag
Thread-Index: AQHUrxKB+NUnXfjsskWtdnNQF+jt8g==
Date:   Mon, 28 Jan 2019 10:07:05 +0000
Message-ID: <CY1PR04MB226885534DE073F502C3198DED960@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-2-shinichiro.kawasaki@wdc.com>
 <20190125205943.GA26739@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2042;6:vPvFwW3dCNK5urWYV+UDvO5f5DjWdEjhhrr6p8JTOiJA+kLJ8iP90ktdDT13tlnSOWTRf6+H7Y7H/p1d8GIcYZbeNEXVtlpRaUtFg1LnoVncLmF2x31J21kXsDIckuPSwRPNKzroE9qykik3I8CTRgBeBFIDG5o6crTmUY7gI02N179LAM02K+10k2ZsCLKER9vxHy9/9b4bsrCTbf89woS4MifN7okZlvi8IrB/zeq6A0HzsYOZv0VTOUAfUL0JCvtugUbU2AfCQaULVDHDrpl9GALHQvoBKRrqE9i0rI/k/mKiEQDjDizsqgDH7ljnWxnV6B9gFmnqQSIc5PoTwhl01f4SaONMgQfH6QNyzqECWRRClHP+lymcG6lOwSdFYoH/LSNxQMsPjosd29VCMgCH6DHWEvxD3zSo7BnYRiCRMzyRmjzftauPh8Mq6/olMnoLHE7Z2CgmgRc8v/XoUg==;5:b1XsmJgO1xSJMDZ0BFsA542BN9mOWftXCKUmZauYTrhzWSVDYsLP6yn+78gEu0GmwevyIYXisucgmh6UOJ6uHvzDZ2P6uKtZwUdWobv/Z/t+Hn+Jd0O7B19wiTJUE0lI4v7dRpHUOklp6DfS12B25ArBYfTj3nWFOb5PTbupqqwKUZs7MmP+bQEjZR8HAFj7xt2x1rS6e9Y1fECvgvFypA==;7:0PGqtckEN6WVQrKhboL9SuTtW3gatqWTUHnSTHuWoudehKBV80QYAS6xg4raF817XFuE/CEF2719/wWWnGC//lIeXwaEQfoIZ5rkCGOGTPkQAOOY5DdVtliiERtjODA8HTggTjdHKI/Z1UQlrdANng==
x-ms-office365-filtering-correlation-id: 36123d95-8293-4dcd-be8e-08d685085b05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2042;
x-ms-traffictypediagnostic: CY1PR04MB2042:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB2042BFE513B65F0D8625549AED960@CY1PR04MB2042.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(74316002)(6436002)(66066001)(14444005)(7696005)(71200400001)(71190400001)(53546011)(99286004)(446003)(8936002)(9686003)(44832011)(476003)(486006)(256004)(53936002)(76176011)(14454004)(229853002)(6506007)(81166006)(81156014)(316002)(305945005)(26005)(68736007)(4326008)(54906003)(7736002)(105586002)(186003)(97736004)(106356001)(3846002)(6116002)(102836004)(6246003)(6916009)(86362001)(55016002)(2906002)(8676002)(33656002)(478600001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2042;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zVZZf50oBDHjRTIXsN01zEVBya8Ps4HCq13PM6bI+5zHaDJp4+FRBI4caytwt+G75i6mLd3CUBy9WGHFqcEN/bYjyhKdKhyo4oJTvoIm/arzHfn5Nq3X3UGXw3VTcTDFVG0hGWB+zPQFH5XcsrcznWqrtbvf17b4M1pOltUEM5v+R72oBljiRCQ8jPVm3eVjcS29Xkd09f0ncTsSRivna+Z5eZJaRm8D48zgd1svvQcGXQC502wQDxhe3DiZZp/RgOYqrOhHF25CiWfHk7S9JlMXxBrdEz1MXUuT4gB8MA34+VA/HeKame6ixoelv9SJAhKcLLldSuQ5scpg4JcdaVclTZ6bocZYYO/SORet3H6tRQVv5ydFSsNmmRwuySVczr2JSfu5VK7DsOR2j3Q9LxUUmI8ICRhrBgd4JAcVOEo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36123d95-8293-4dcd-be8e-08d685085b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 10:07:05.2419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2042
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/19 5:59 AM, Omar Sandoval wrote:=0A=
> On Fri, Jan 18, 2019 at 06:44:41PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> To allow running tests using a null_blk device with the zoned mode=0A=
>> disabled (current setup) as well as enabled, introduce the config=0A=
>> the RUN_ZONED_TESTS config variable and the per-test flag CAN_BE_ZONED.=
=0A=
>>=0A=
>> RUN_ZONED_TESTS=3D1 indicates that tests run against null_blk will be=0A=
>> executed twice, first with null_blk as a regular block device=0A=
>> (RUN_FOR_ZONED=3D0) and a second time with null_blk set as a zoned block=
=0A=
>> device (RUN_FOR_ZONED=3D1). This applies only to tests cases that have t=
he=0A=
>> variable CAN_BE_ZONED set to 1, indicating that the test case applies to=
=0A=
>> zoned block devices. If CAN_BE_ZONED is not defined by a test case, the=
=0A=
>> test is executed only with the regular null_blk device.=0A=
>>=0A=
>> _init_null_blk is modified to prepare null_blk as a zoned blocked device=
=0A=
>> if RUN_FOR_ZONED is set and as a regular block device otherwise. To avoi=
d=0A=
>> "modprobe -r null_blk" failures, rmdir calls on all sysfs nullbX=0A=
>> directories is added.=0A=
>>=0A=
>> When a zoned block device is specified in TEST_DEVS, failures of test=0A=
>> cases that do not set CAN_BE_ZONED are avoided by automatically skipping=
=0A=
>> the test. The new helper function _test_dev_is_zoned() is introduced to=
=0A=
>> implement this.=0A=
>>=0A=
>> The use of the RUN_ZONED_TESTS variable requires that the kernel be=0A=
>> compiled with CONFIG_BLK_DEV_ZONED enabled.=0A=
> =0A=
> This is much better, thanks! Some comments below.=0A=
=0A=
Hi Omar, thank you again for your review.=0A=
=0A=
>> +### Zoned Block Device=0A=
>> +=0A=
>> +To run test cases for zoned block devices, set `RUN_ZONED_TESTS` variab=
le.=0A=
>> +When this variable is set and a test case can prepare a virtual devices=
 such=0A=
>> +as null_blk with zoned mode, the test case is executed twice: first wit=
h=0A=
>> +non-zoned mode and second with zoned mode. The use of the RUN_ZONED_TES=
TS=0A=
>> +variable requires that the kernel be compiled with CONFIG_BLK_DEV_ZONED=
=0A=
>> +enabled.=0A=
>> +=0A=
> =0A=
> Minor proofreading:=0A=
=0A=
Thanks. Will apply.=0A=
=0A=
>> @@ -420,6 +437,11 @@ _run_test() {=0A=
>>   		local ret=3D0=0A=
>>   		for TEST_DEV in "${TEST_DEVS[@]}"; do=0A=
>>   			TEST_DEV_SYSFS=3D"${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"=0A=
>> +			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then=0A=
>> +				SKIP_REASON=3D"${TEST_DEV} is a zoned block device"=0A=
>> +				_output_notrun "$TEST_NAME =3D> $(basename "$TEST_DEV")"=0A=
>> +				continue=0A=
>> +			fi=0A=
> =0A=
> We should unset SKIP_REASON here from _test_dev_is_zoned just in case=0A=
> device_requires forgets to set a SKIP_REASON.=0A=
=0A=
OK. Will add unset.=0A=
=0A=
>> diff --git a/common/null_blk b/common/null_blk=0A=
>> index 937ece0..fd035b7 100644=0A=
>> --- a/common/null_blk=0A=
>> +++ b/common/null_blk=0A=
>> @@ -8,8 +8,29 @@ _have_null_blk() {=0A=
>>   	_have_modules null_blk=0A=
>>   }=0A=
>>   =0A=
>> +_null_blk_not_zoned() {=0A=
>> +	if [[ "${ZONED}" !=3D "0" ]]; then=0A=
>> +		# shellcheck disable=3DSC2034=0A=
>> +		SKIP_REASON=3D"null_blk zoned mode not supported"=0A=
>> +		return 1=0A=
>> +	fi=0A=
>> +	return 0=0A=
>> +}=0A=
> =0A=
> Is this still used anywhere in this version?=0A=
=0A=
I left it by mistake. Will remove it.=0A=
=0A=
>>   _init_null_blk() {=0A=
>> -	if ! modprobe -r null_blk || ! modprobe null_blk "$@"; then=0A=
>> +	for d in /sys/kernel/config/nullb/*;=0A=
>> +	do [[ -d "$d" ]] && rmdir "$d";	done=0A=
> =0A=
> I'd prefer to do this without globbing:=0A=
> =0A=
>          if [[ -d /sys/kernel/config/nullb ]]; then=0A=
>                  find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 -t=
ype d -delete=0A=
>          fi=0A=
=0A=
Thanks. Will replace with the suggested code.=0A=
=0A=
>> +	local _zoned=3D""=0A=
>> +	if [[ ${RUN_FOR_ZONED} -ne 0 ]] ; then=0A=
>> +		if ! _have_kernel_option BLK_DEV_ZONED ; then=0A=
>> +			echo -n "ZONED specified for kernel with "=0A=
>> +			echo "CONFIG_BLK_DEV_ZONED disabled"=0A=
>> +			return 1=0A=
>> +		fi=0A=
> =0A=
> Let's avoid _have_kernel_option if we can, since that requires that the=
=0A=
> user enabled CONFIG_IKCONFIG_PROC or installed their config in /boot. We=
=0A=
> can just skip this check and the modprobe below will fail with=0A=
> "null_blk: CONFIG_BLK_DEV_ZONED not enabled" in dmesg.=0A=
=0A=
OK. Will remove the kernel option check.=0A=
=0A=
> While you're here, this variable name doesn't need the leading=0A=
> underscore.=0A=
> =0A=
>> +		_zoned=3D"zoned=3D1"=0A=
>> +	fi=0A=
>> +	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${_zoned}" ; th=
en=0A=
>>   		return 1=0A=
>>   	fi=0A=
=0A=
Will rename it.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
