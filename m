Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE5FCA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CA521872
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 17:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="chlLca+e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y9qgTFXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfJVR7f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:59:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43565 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfJVR7f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 13:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571767174; x=1603303174;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qX1f8Qit04WX9CmSIQ5ql2w5w2DTQAFfUXuoSHXbai0=;
  b=chlLca+e8C3RlkR3739I6hMNUYWX97UFSBqhxZCsWNVnwy7g+h+NB70O
   RLEX8ahKlcwbvg1dvcNIxdN9ZNoP8+E3iiN9DtpFvUWOV/90/lUTswOST
   7YfuARMvguD/fCIcK541dZJQ1ScAPjljWE6pSqA2CEvFhnQZGrYvsg1dF
   L1ONavX7k46pBksrhs9APgVh5TT2tNoiYNLdMyxVbRK+ysad3BZmnHYiL
   gz1VKjX92wBhoSS6Pt2ZOcsg2NpMmImuY6ch6PsZr+mEVPG6tpKjsAanJ
   i+CNElAu7lnV/9DHpsCmnjP/NfbNoZsi+GMHngh1qC8cGhiYVIStAo/e6
   Q==;
IronPort-SDR: 47u/+pgUanEqZLYas5OanGpuX3wo01GuiAfSajALscvCC8uxde58I6m/sSYIOr1MTkX3M+GQQB
 oiK/Olzj8nvpiD6hCITpYMKMe5vHmEsUJWVG4dvY1/L/zrDfzw0X6OmDZy2aKpkqIo63XfpDEz
 KKY1dl5JTrEl4N2/3WQViC1CjqJMblBv0VWF21bXuKrtogG/gCquROBXEPnB3yk3bMRSX+lrmE
 KAs0wPWNlpIawg3d4HQU3k8b5l+1UWk2glfxbA5klOLlXnOlYIPE/ZkVmWftXWiWlH53JSXc3E
 wQg=
X-IronPort-AV: E=Sophos;i="5.68,217,1569254400"; 
   d="scan'208";a="121856172"
Received: from mail-dm3nam03lp2051.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.51])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2019 01:59:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB3N/VybO6L6pg9Kp5/VJTjHtb72Lz1sS7jLK1iunDDGowC/u6NACezAEf0YdW4TbA+DimDE2RclUa5Xdm61Q6HYAinD5WPFI0oA/7KOFa4AETP7k9NMwjR7JZT3Xe+iOvYTmOw3QYe+z0Y/HDfdKGBa5T7SB/ONR4BEgbo56+MGseEgonzrGdVDgWPIG7mWM2LgdB6mIk4fRBsAkGOI732512uyBn3+oo+lGF1NTVKZgU1Fa/ZQhAJMuwr0Q6ELT87Y8h6FwYpvsG5yNZqnotAuAkGre9/fAt1o7FZH/uisNGwh/JKWAi+R13FHXA1d2KXS5YNYJA/cWEldjmTNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZuNGYfGxl6JJ7P8U6SUHQHb89pIAxnv2TXw8T/s+DU=;
 b=WMwsXHoT1dzyWaUjeX9WbczHu10IIz/HpqAqkNY6djG7/L0GFHu8IsAaVfisPjcvhjWKP/cxpIQGu/Zmrn6MQMRsKHH3AvL2yNrpU1I3YVchm62LrWaDmUpZskzoSONQfO+d5k3ewJD/xLGkMr9vm0GldqirgWs2WSIIuhONzWfweMHX0oBaJtljQBWaCSw2D2A7BstZSyYs1WrHq0eCOPuV19MJG2t053zjOIOKIpU7TCvBy1iItBVTvrLFlbKctp5KWkkEh32jkV7cxCsaKxeJ0V+MWoWs2Zw7KMlgBPdVwEYbpxFnpE+XTJ1b7u2bUu1W/2yjlLYbwbh5Zs/jFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZuNGYfGxl6JJ7P8U6SUHQHb89pIAxnv2TXw8T/s+DU=;
 b=Y9qgTFXEUgl2b9iSRZSNOBDVKu4HebpC+sHIFuYUbMorwk11q51WTxWVu4IjSKwAEhaU8zuDMHMMrf+tHvqFlYXWuO4S3ae2fzH2eAno3PWbBQOHgsHzfez1sgeaS7K32FmhlU1ss4ey3SLTWBii8OJQyKZMpaSoB0mEfuafIYE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4679.namprd04.prod.outlook.com (52.135.239.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 17:59:32 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 17:59:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests 2/2] Add a test that triggers
 blk_mq_update_nr_hw_queues()
Thread-Topic: [PATCH blktests 2/2] Add a test that triggers
 blk_mq_update_nr_hw_queues()
Thread-Index: AQHViGLufTqpuGnt10i2lSsh/Ic8pg==
Date:   Tue, 22 Oct 2019 17:59:32 +0000
Message-ID: <BYAPR04MB5749D09A96E29B895D8D411786680@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81301d9d-c5ff-45e8-ffc1-08d757199750
x-ms-traffictypediagnostic: BYAPR04MB4679:
x-microsoft-antispam-prvs: <BYAPR04MB4679EC0EB6E3C3DFBAEB019F86680@BYAPR04MB4679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:52;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(446003)(476003)(186003)(486006)(6116002)(110136005)(316002)(54906003)(71190400001)(71200400001)(26005)(3846002)(33656002)(2906002)(66066001)(5660300002)(52536014)(55016002)(6436002)(9686003)(305945005)(6246003)(66446008)(64756008)(66556008)(81166006)(81156014)(8676002)(8936002)(7736002)(74316002)(4326008)(76116006)(229853002)(66476007)(66946007)(25786009)(478600001)(53546011)(6506007)(102836004)(256004)(7696005)(99286004)(86362001)(14454004)(14444005)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4679;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ip4J6QIukfbidmqIa/y1hNF0NP/4Ku1XHmsDwXBqmwV5EgknNTfVIbNJcxjePxWzaTjKwDkJ3lsNOeWHpKewpJrw9kSG4T5F6D1L0veOqi9eN7sWnttUuKuIcuQXlTJKg3gyXZjQuIsL5Nnz75nPZXewhcw+TyY+8H2KyWjYQCFyym5/V/xQO6yieVTzAnXGr603wrjozbFZvP4mA+9yqqS9slecEBYKVSy7KzIb/O8v4xxGNY3hW4oHDN7bxneA2RSp2Pfsa24BFFxtMUMIRrJ+ADwd0K/A9UxiTCt8TTowWSrtxR0Iq4XTYdT19dy+V+NEdJcKwcEuwbcHMm3YOtpOVOl28pC+9+ElJAHeR1WiueuGZ2PF7+MNTz9GkKBGa2JJY3oJ7cTQWX4mkiwhpqJGCDwDF9NAWNmVMl7Ht5xRW5Sd4TaAN5tnUXp9uHo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81301d9d-c5ff-45e8-ffc1-08d757199750
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 17:59:32.0081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0x2dJsv/2tyXl8nm7hMPYsBcRAgHGeQx80lWwUfDtbaJqMV4zOYac/qIYKGMFTb9pHD3OVfWfRjnFZTn5r5UMqRS16SkW5sVeTLnhFWnKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4679
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Look good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 10/21/2019 03:57 PM, Bart Van Assche wrote:=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>   tests/block/029     | 63 +++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>   tests/block/029.out |  1 +=0A=
>   2 files changed, 64 insertions(+)=0A=
>   create mode 100755 tests/block/029=0A=
>   create mode 100644 tests/block/029.out=0A=
>=0A=
> diff --git a/tests/block/029 b/tests/block/029=0A=
> new file mode 100755=0A=
> index 000000000000..1999168603c1=0A=
> --- /dev/null=0A=
> +++ b/tests/block/029=0A=
> @@ -0,0 +1,63 @@=0A=
> +#!/bin/bash=0A=
> +# SPDX-License-Identifier: GPL-2.0=0A=
> +# Copyright (C) 2019 Google Inc.=0A=
> +#=0A=
> +# Trigger blk_mq_update_nr_hw_queues().=0A=
> +=0A=
> +. tests/block/rc=0A=
> +. common/null_blk=0A=
> +=0A=
> +DESCRIPTION=3D"trigger blk_mq_update_nr_hw_queues()"=0A=
> +QUICK=3D1=0A=
> +=0A=
> +requires() {=0A=
> +	_have_null_blk=0A=
> +}=0A=
> +=0A=
> +# Configure one null_blk instance.=0A=
> +configure_null_blk() {=0A=
> +	(=0A=
> +		cd /sys/kernel/config/nullb || return $?=0A=
> +		(=0A=
> +			mkdir -p nullb0 &&=0A=
> +				cd nullb0 &&=0A=
> +				echo 0 > completion_nsec &&=0A=
> +				echo 512 > blocksize &&=0A=
> +				echo 16 > size &&=0A=
> +				echo 1 > memory_backed &&=0A=
> +				echo 1 > power=0A=
> +		)=0A=
> +	) &&=0A=
> +	ls -l /dev/nullb* &>>"$FULL"=0A=
> +}=0A=
> +=0A=
> +modify_nr_hw_queues() {=0A=
> +	local deadline num_cpus=0A=
> +=0A=
> +	deadline=3D$(($(_uptime_s) + TIMEOUT))=0A=
> +	num_cpus=3D$(find /sys/devices/system/cpu -maxdepth 1 -name 'cpu[0-9]*'=
 |=0A=
> +			   wc -l)=0A=
> +	while [ "$(_uptime_s)" -lt "$deadline" ]; do=0A=
> +		sleep .1=0A=
> +		echo 1 > /sys/kernel/config/nullb/nullb0/submit_queues=0A=
> +		sleep .1=0A=
> +		echo "$num_cpus" > /sys/kernel/config/nullb/nullb0/submit_queues=0A=
> +	done=0A=
> +}=0A=
> +=0A=
> +test() {=0A=
> +	: "${TIMEOUT:=3D30}"=0A=
> +	_init_null_blk nr_devices=3D0 queue_mode=3D2 &&=0A=
> +	configure_null_blk=0A=
> +	modify_nr_hw_queues &=0A=
> +	fio --rw=3Drandwrite --bs=3D4K --loops=3D$((10**6)) \=0A=
> +		--iodepth=3D64 --group_reporting --sync=3D1 --direct=3D1 \=0A=
> +		--ioengine=3Dlibaio --filename=3D"/dev/nullb0" \=0A=
> +		--runtime=3D"${TIMEOUT}" --name=3Dnullb0 \=0A=
> +		--output=3D"${RESULTS_DIR}/block/fio-output-029.txt" \=0A=
> +		>>"$FULL"=0A=
> +	wait=0A=
> +	rmdir /sys/kernel/config/nullb/nullb0=0A=
> +	_exit_null_blk=0A=
> +	echo Passed=0A=
> +}=0A=
> diff --git a/tests/block/029.out b/tests/block/029.out=0A=
> new file mode 100644=0A=
> index 000000000000..863339fb8ced=0A=
> --- /dev/null=0A=
> +++ b/tests/block/029.out=0A=
> @@ -0,0 +1 @@=0A=
> +Passed=0A=
>=0A=
=0A=
