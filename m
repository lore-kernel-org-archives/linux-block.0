Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284DFC2BA2B
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 15:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27CB20719
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 15:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bXi9rURQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bQ9xwjT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgDGP3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:29:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49093 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgDGP3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 11:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586273362; x=1617809362;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Xaz4bRnYsNgh833MDa/RdDTPi07kvTvcvVM/xECqnvY=;
  b=bXi9rURQYi9fdJpUrcMAO3S3y1SmKpykVJn9d0zfW9xJMjXHjg3zsmOp
   3Sya5/JpE6YB4vd4Bdm4diQzYebWPXdzie8HqXHtcUVBPFksaH4G3Fswy
   x4BVrOkUNqf+50/DEe0cLmQdOeIZU1qmE97N6DLdLXPSj5wLOm9vCQoGX
   RQKN7id2RwsOprGFUMrseJQwORmo3jlc0gr5EjmHWvaomrXc9Viw+ZhnT
   hgKcjc/MDkMMQEx8iyCrGdwoMUZI/XmqzlXOLi1LS/mZvzmCWG1YcypUa
   mfG0YIBvjIHpmr67tBoDNe0XKsrFZYZZXIdxXm9KX6xsslwFcBue6tVf4
   A==;
IronPort-SDR: yGAtI7gEXo6/5y0He0r7dm7u8iNKYo9T4Gcn49r5C7exOzO+Rw8+SwDbUKbsbQYLEIS0jLnPJI
 3wan+BKkfPCGpKTWgEf5v0HPuj2rKDMvAhUhHD4h6VcBvWxE+TF3C10ggehmx/lG2hZU7ZTLNR
 4sMNnUs6AWhgAxNo+Cm5qGQfPCpLjylZKQ7N+tURk0LiO0SIHsOlLcp9jJkCBhBt9mBN5Hs/51
 s6YIwiN38jMsADRJWYpFRyMBfbM5djzrhvroj5U5u1kOa5Yo0yNSg1VW6sO7hIo1uFRkjVQ1nT
 NKI=
X-IronPort-AV: E=Sophos;i="5.72,355,1580745600"; 
   d="scan'208";a="135102640"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2020 23:29:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JagRJH+XhvRSDCb/vgyM8aAnh95M+sqLGmXK5SkPkX8D6XHSwPixSt+P5BoeLu+4eZEdMG3OL24xqPeP7PzT+1Gc24JQpzzuye2lAHSgmd3CfywUkPhoDF0nkZ/PGVM2Tr8kVBOG3spitf753uxjaPzrTSC5rSphkEB4/AvU11RAvCEoDMBxRoslQgtp9NgcH3wUaChH0cVl2B+O1SqdQ2Z+fLqZSTh0pna2zYfFFpceEcDCiy8NIUloNg5PBZOcE4Se5KDxPts/Kq1cqnqgWIaYh2ArxTbWjie/pmHI+lUIsmrrFkXJNZb78uGO1wiqKHl/f207zTZczUhKhV3qCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vVaQw0mDKzzYYcnc2DhJrHPQ20TVsU6udIqYlVp7do=;
 b=N5u6kqJNV7qid3GHVgXgztEu13cOU92tqSttq7zxPI5HQCtPLRQcuyJIpHBmZ+0dG9lxCHTY4V89hwlE/vcd99nlvGg0Vlii6JjFeRe7dleOPxmvUA8jq753kERMQc+xlqHgxt1KL5z23Dod7HPQ3Al2cV/ghL+6oRV+/R60EM85ZNrT4Hb/nWMKUWlUFOy7pxe/5NIlSYp8Bv/WBIcdiYlxNeIAC5W9ODCWvKTosTU/8uDvNLIqAt/kcqxgbxkyv4WFkhhPaxi/xtDbvWNfNCHUB4bIptGUajcvA1MrYVQ4838R+oByFto1iJIs0zqpdjtL3TJInht5koC1zRRhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vVaQw0mDKzzYYcnc2DhJrHPQ20TVsU6udIqYlVp7do=;
 b=bQ9xwjT34FXqOMHPx7ZKMU25rcvagVw0y4+gjhd+EpKvZolx3poYDBCPN5b6MEgGOHrgTDqNmFzuH9cdcISXIz/HEYHIP50fXSK7dtRTLpU1LmCT3VGt2mN2IcSxBd6FCFI9UHzFrKwmhGeRwVsNTSfnku+jVrhHLo0vf5Jzj50=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4341.namprd04.prod.outlook.com (2603:10b6:a02:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 15:29:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 15:29:19 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Weiping Zhang <zhangweiping@didiglobal.com>,
        "osandov@osandov.com" <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Thread-Topic: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Thread-Index: AQHWDOc5x5zQf7eZvUOWxJVMAwNxBA==
Date:   Tue, 7 Apr 2020 15:29:19 +0000
Message-ID: <BYAPR04MB49657AC1B762EA5450AA178986C30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200407141621.GA29060@192.168.3.9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1b3fcfc-9ef4-472e-3ac1-08d7db087110
x-ms-traffictypediagnostic: BYAPR04MB4341:
x-microsoft-antispam-prvs: <BYAPR04MB434175C191DFE8900DFD0E1F86C30@BYAPR04MB4341.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(6506007)(66946007)(76116006)(86362001)(8936002)(5660300002)(26005)(2906002)(8676002)(66476007)(7696005)(498600001)(110136005)(66446008)(64756008)(81166006)(81156014)(66556008)(15650500001)(53546011)(9686003)(55016002)(186003)(52536014)(33656002)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aIpDxAB5m62MhThs79r778G/QhnkDGOLD9XaDAJXVTAggbEk8mcSSBVFkl4LAO5qQXs9+y0DlC98Md7XoFRI+HdsQE16W6oveWIjRh/RV7XfiAjuVjxp70TlvGDgh/b2bH4C9PoQeSMW3CpjSj5RhCchloyEwbqymJlBDjaCXyjmQQyQCbeCBFaM3BTlG6c4uZag6khtgm1X3Jzo2JGqmq9aP3c5QujzzvGenQqCj+ds/SBgu8YQuoI7u/tTcdh8t0MAzO3cb0SYUJ20lWqBVxh0mJ3afOtxWcqkj8MLloFF8/rFwVg5M8I2QZq8ETxX2DHfZgqcEzKRXvOd1D6+2SIzIKzf6oXuJ1RKY+NG/3SuXcJOk1oJhUwar6SB7yffWbdEDFt8OSwopt/GiqqxuWWjTKCYfutrlLLmT++U5DvPexQpSpFThlE/EwTKlKAK
x-ms-exchange-antispam-messagedata: JRfksG3a45Owx4NGNmu4lmwg6Vwt6YgWXXW8QNtsEVbDSpZT17mlM28QDb/rx8Mjt/nxWJvn55R8ZGi1Fh6hijToEQPgBRjUl9ofqoXgRKJiFdrNPvwSCs1+1F5VVRrSjRSSmEJywWDUksHKCFOJog==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b3fcfc-9ef4-472e-3ac1-08d7db087110
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 15:29:19.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GV6A5RKxnMkOmEzexzLOPcH8OcsRmRrbRHTpc3JYjVXj2666ATaNrByYpWIR2grwF2K/FEwCYQAcYtzv1m/FSWoZ3NdpKBfidNSauF2CeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4341
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/07/2020 07:17 AM, Weiping Zhang wrote:=0A=
> Modify nvme module parameter write_queues to change hardware=0A=
> queue count, then reset nvme controller to reinitialize nvme=0A=
> with different queue count.=0A=
>=0A=
> Attention, this test case may trigger a kernel panic.=0A=
>=0A=
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>=0A=
> ---=0A=
>   tests/nvme/033     | 87 ++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>   tests/nvme/033.out |  2 ++=0A=
>   2 files changed, 89 insertions(+)=0A=
>   create mode 100755 tests/nvme/033=0A=
>   create mode 100644 tests/nvme/033.out=0A=
>=0A=
> diff --git a/tests/nvme/033 b/tests/nvme/033=0A=
> new file mode 100755=0A=
> index 0000000..e3b9211=0A=
> --- /dev/null=0A=
> +++ b/tests/nvme/033=0A=
> @@ -0,0 +1,87 @@=0A=
> +#!/bin/bash=0A=
> +# SPDX-License-Identifier: GPL-3.0+=0A=
> +# Copyright (C) 2020 Weiping Zhang <zwp10758@gmail.com>=0A=
> +#=0A=
> +# Test nvme update hardware queue count larger than system cpu count=0A=
> +#=0A=
> +=0A=
> +. tests/nvme/rc=0A=
> +=0A=
> +DESCRIPTION=3D"test nvme update hardware queue count larger than system =
cpu count"=0A=
> +QUICK=3D1=0A=
> +=0A=
> +requires() {=0A=
> +	_have_program dd=0A=
> +}=0A=
> +=0A=
> +device_requires() {=0A=
> +	_test_dev_is_nvme=0A=
> +}=0A=
> +=0A=
> +test_device() {=0A=
> +	echo "Running ${TEST_NAME}"=0A=
> +=0A=
> +	local old_write_queues=0A=
> +	local cur_hw_io_queues=0A=
> +	local file=0A=
> +	local sys_dev=3D$TEST_DEV_SYSFS/device=0A=
> +=0A=
> +	# backup old module parameter: write_queues=0A=
> +	file=3D/sys/module/nvme/parameters/write_queues=0A=
> +	if [[ ! -e "$file" ]]; then=0A=
> +		echo "$file does not exist"=0A=
> +		return 1=0A=
> +	fi=0A=
can we skip the test ? I think Omar added a feature to skip the test.=0A=
> +	old_write_queues=3D"$(cat $file)"=0A=
> +=0A=
> +	# get current hardware queue count=0A=
> +	file=3D"$sys_dev/queue_count"=0A=
> +	if [[ ! -e "$file" ]]; then=0A=
> +		echo "$file does not exist"=0A=
> +		return 1=0A=
> +	fi=0A=
Same here.=0A=
> +	cur_hw_io_queues=3D"$(cat "$file")"=0A=
> +	# minus admin queue=0A=
> +	cur_hw_io_queues=3D$((cur_hw_io_queues - 1))=0A=
> +=0A=
> +	# set write queues count to increase more hardware queues=0A=
> +	file=3D/sys/module/nvme/parameters/write_queues=0A=
> +	echo "$cur_hw_io_queues" > "$file"=0A=
> +=0A=
Shouldn't we check if new queue count is set here by reading=0A=
write_queues ?=0A=
> +	# reset controller, make it effective=0A=
> +	file=3D"$sys_dev/reset_controller"=0A=
> +	if [[ ! -e "$file" ]]; then=0A=
> +		echo "$file does not exist"=0A=
> +		return 1=0A=
> +	fi=0A=
I think we need to add a helper to verify all the files and skip the =0A=
test required file doesn't exists. Also, please use different variables=0A=
representing different files.=0A=
> +	echo 1 > "$file"=0A=
> +=0A=
> +	# wait nvme reinitialized=0A=
> +	for ((m =3D 0; m < 10; m++)); do=0A=
> +		if [[ -b "${TEST_DEV}" ]]; then=0A=
> +			break=0A=
> +		fi=0A=
> +		sleep 0.5=0A=
> +	done=0A=
> +	if (( m > 9 )); then=0A=
> +		echo "nvme still not reinitialized after 5 seconds!"=0A=
> +		return 1=0A=
> +	fi=0A=
> +=0A=
> +	# read data from device (may kernel panic)=0A=
> +	dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D4096 count=3D1 status=3Dnone=
=0A=
> +=0A=
This should not lead to the kernel panic. Do you have a patch to fix=0A=
the panic ? If not can you please provide information so that we can=0A=
fix the panic and make test a test which will not result in panic ?=0A=
=0A=
> +	# If all work well restore hardware queue to default=0A=
> +	file=3D/sys/module/nvme/parameters/write_queues=0A=
> +	echo "$old_write_queues" > "$file"=0A=
> +=0A=
> +	# reset controller=0A=
> +	file=3D"$sys_dev/reset_controller"=0A=
> +	echo 1 > "$file"=0A=
> +=0A=
> +	# read data from device (may kernel panic)=0A=
> +	dd if=3D"${TEST_DEV}" of=3D/dev/null bs=3D4096 count=3D1 iflag=3Ddirect=
 status=3Dnone=0A=
> +	dd if=3D/dev/zero of=3D"${TEST_DEV}" bs=3D4096 count=3D1 oflag=3Ddirect=
 status=3Dnone=0A=
Just a write a helper for dd command instead of hard-coding it.=0A=
> +=0A=
> +	echo "Test complete"=0A=
> +}=0A=
> diff --git a/tests/nvme/033.out b/tests/nvme/033.out=0A=
> new file mode 100644=0A=
> index 0000000..9648c73=0A=
> --- /dev/null=0A=
> +++ b/tests/nvme/033.out=0A=
> @@ -0,0 +1,2 @@=0A=
> +Running nvme/033=0A=
> +Test complete=0A=
>=0A=
=0A=
