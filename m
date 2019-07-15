Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D203AC7618A
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 05:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B74B20838
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 05:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bw7fqmbH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FkGkbbyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbfGOFn2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:43:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42224 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfGOFn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 01:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563169408; x=1594705408;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4hx671f/aQhME8AYjWzjwLSB0YbXUExgJn7TMeOrvXY=;
  b=bw7fqmbH/xrkxoO7Kxx8x0PIJs7p7g8kPYqgT5qruOGwUhxV1Sz1mA/X
   DGdb7jhSlYBWGx0fZ/cQM2HqtTtrdjuQQU/K9ccfMS6O0QVx17p5WDIww
   F3G3+vfSWyWr0X1n7pbgZiGXDuVAEPOBVjmB7iCqi664Mubr1y3aC4afJ
   b3y4658oq0dx+Fg6ouGt0AAILYZDlZEr5CVnJe4NISu8bIjm+44Totd0/
   K4MkCsBZUhdusB88HIVxhLrNSDOkqQyXnzWJ8CV1RISk4E3WkauSE3jLA
   8eZSqCi5alZYPVZKNekEpEYlWnQ8gR4OxRr8mHwqVDAhxaa/A3Gtv5+vL
   g==;
IronPort-SDR: jybk3ZN2A0JTW10dVNAPs4Mn/enD2M/BjcQUDgE7uNZXVMG5F8DSI94iQYVzXGHiy4kyV5umJ6
 SiuiMIcG1Fa4XzliPVJIk/EMoUkegu6ckQL0cwR6mQnpNxdvBQ+w7b2CmwF1911Z/cFsXHEKWQ
 0ilceFUmUV1B1LLMEyatywdLZF9HIHQADxCrF3M+ZEL+t2IkZrR6MIhby7bVukDjDeodZqjDdD
 xzROP8RvIJMGWYW9MHkEPd7sncdEIFr3fXVYErJlsIgia4AiC8Xce+Y3ALyJhbzJIDo0/QZ9Zp
 /Js=
X-IronPort-AV: E=Sophos;i="5.63,493,1557158400"; 
   d="scan'208";a="117811435"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2019 13:43:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n93VPa2YJX/AIFpHcl2hxbxStiyEWExabknuJ2EDvCDOuUYJFypoKMJ1EjQR2jmrn7AMQv9Im5aki1pjbl2dD+kO8pcWnbixJqLWIvYfVOVWPq3L5/mbSmn2GVJOfJdHbouFJJpZkfIhJWEXKJRb7/b7UXCn0bB97CvZr/LXaiIvQVzBntzwFhGKe1l1K9qtBEugk6skuC6NU1Xw/vGpIbKTXdr6aQ2SWqnaA5F0ZZW0mm4NLsmoObCFlRG0XF6L8mfCPMMQ5xxL535DEXxq1LdhvB67IB3vZReZPOcej82Rdk9zLCQ7bvNQkwqYb3JxiqbqROqsnEzUGKj83ngF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyZ9f0PWBB0PgRCksS1xQ8gxC87+B8rYNAv/g9j3SkM=;
 b=ZuZuW0vGTxP/bvxNlme7c8UEwWE0JcyQkI8VRwZkOV00TKNpLSL0dxtXfxIqbaZwRsiiSGoYJLvdS9O/Uz1eGBaF6pWU//MNafiaPbRtbkB9Tmz5GTRCDlRDUmDGfsdOBNgyFRRu7d7dBqMFdwJCBdhF0OvFOnEfp7qIJEjh9UAkm6GPPgOoXAPWNuHJ+I2eP4B5QNPTci1lZinkQgZxZEDIb1u2BrZhaizYH1al2YaZOnu9RBl8XsIaCKqMTDPUYw5L9153c/zMRPISiwx5eKjx3PHpGut7zQ60kIgBNexT5ESzY3Kmol4ZHgKoB/HwdRBRWmTvZ8teyxCTfjj92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyZ9f0PWBB0PgRCksS1xQ8gxC87+B8rYNAv/g9j3SkM=;
 b=FkGkbbyO1+Xra38EN9EuzPPIIwDZZx67VfMwqJiMNAljPlTycMdRy7gMJNzlizhfgcfUcsAkq8WyFcmKCX30ufhYPdg+XPEg9aYBtJQBPOYCbM4MCgp+mfp3/7vMSP8Est0pARZf+/y2o+rlXtFQaxyoZWNsdmiOEUdvFCcRO7Q=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5653.namprd04.prod.outlook.com (20.179.56.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.13; Mon, 15 Jul 2019 05:43:24 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 05:43:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [block:for-linus 20/23] include/linux/kernel.h:62:48: warning:
 'zone_blocks' may be used uninitialized in this function
Thread-Topic: [block:for-linus 20/23] include/linux/kernel.h:62:48: warning:
 'zone_blocks' may be used uninitialized in this function
Thread-Index: AQHVOVrdX1MDkvxcvEijEWF8X5rW2Q==
Date:   Mon, 15 Jul 2019 05:43:24 +0000
Message-ID: <BYAPR04MB5816C2EFC9D3C9FEF6DCCD2CE7CF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <201907131730.Br9OqtbO%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baef5ff0-5171-4daa-e63a-08d708e75ab2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5653;
x-ms-traffictypediagnostic: BYAPR04MB5653:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR04MB56531CC6C8BDE647E56B9276E7CF0@BYAPR04MB5653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(189003)(199004)(6116002)(25786009)(8936002)(966005)(3846002)(68736007)(86362001)(478600001)(53546011)(102836004)(6506007)(74316002)(186003)(26005)(33656002)(6436002)(19625735003)(8676002)(7696005)(71200400001)(76176011)(14454004)(476003)(446003)(305945005)(2906002)(54906003)(256004)(66556008)(53936002)(316002)(9686003)(7736002)(110136005)(52536014)(66446008)(5024004)(4326008)(229853002)(2501003)(14444005)(6246003)(486006)(64756008)(5660300002)(55016002)(99286004)(6306002)(66946007)(66476007)(76116006)(71190400001)(66066001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5653;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zs9hjebFcBCTLXnrRWcurOrfHU5Py8RBGY8aaP4rgo0S2/U7Xq5rTK4vpk1Hrvm95GxZqcEQsd2iA6lM6OK4wIYRMAXUti82OuKyhjw5fiQOROVK/G+6hY5xV7SYk5xx+UOqABQx2FgigVsVkIdHWSzO2AZiF9VfeYOv3Z0vf1gTuDnW5+BGCSE0WpalvL8rP6Es5zdN56+XoOCdVjF+u33X+b50sBMNV8vCITClFNanEnOFdUg5li6NjKJoOSMRg6jcnekuTS+c/VsmD93pBiLsvj0VW9RdaQKVVnERxYWVFK1g8ps/9OnaGN2YBVshycF+RzZCKvbWyHW1xe2NaAaTxRc149Pfvlxar14EdNSBHYrvDr+9f/i9Ous2oVdC5O/4VuOvVRbjIQ8kzPrRqoX9/vk8nJxTHXQpvILfMFM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baef5ff0-5171-4daa-e63a-08d708e75ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 05:43:24.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5653
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/13 18:10, kbuild test robot wrote:=0A=
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/li=
nux-block.git for-linus=0A=
> head:   787c79d6393fc028887cc1b6066915f0b094e92f=0A=
> commit: b091ac616846a1da75b1f2566b41255ce7f0e0a6 [20/23] sd_zbc: Fix repo=
rt zones buffer allocation=0A=
> config: c6x-allyesconfig (attached as .config)=0A=
> compiler: c6x-elf-gcc (GCC) 7.4.0=0A=
> reproduce:=0A=
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross=0A=
>         chmod +x ~/bin/make.cross=0A=
>         git checkout b091ac616846a1da75b1f2566b41255ce7f0e0a6=0A=
>         # save the attached .config to linux build tree=0A=
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dc6x =0A=
> =0A=
> If you fix the issue, kindly add following tag=0A=
> Reported-by: kbuild test robot <lkp@intel.com>=0A=
> =0A=
> Note: it may well be a FALSE warning. FWIW you are at least aware of it n=
ow.=0A=
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings=0A=
> =0A=
> All warnings (new ones prefixed by >>):=0A=
> =0A=
>    In file included from include/asm-generic/bug.h:18:0,=0A=
>                     from arch/c6x/include/asm/bug.h:12,=0A=
>                     from include/linux/bug.h:5,=0A=
>                     from include/linux/thread_info.h:12,=0A=
>                     from include/asm-generic/current.h:5,=0A=
>                     from ./arch/c6x/include/generated/asm/current.h:1,=0A=
>                     from include/linux/sched.h:12,=0A=
>                     from include/linux/blkdev.h:5,=0A=
>                     from drivers//scsi/sd_zbc.c:11:=0A=
>    drivers//scsi/sd_zbc.c: In function 'sd_zbc_read_zones':=0A=
>>> include/linux/kernel.h:62:48: warning: 'zone_blocks' may be used uninit=
ialized in this function [-Wmaybe-uninitialized]=0A=
>     #define __round_mask(x, y) ((__typeof__(x))((y)-1))=0A=
>                                                    ^=0A=
>    drivers//scsi/sd_zbc.c:464:6: note: 'zone_blocks' was declared here=0A=
>      u32 zone_blocks;=0A=
>          ^~~~~~~~~~~=0A=
[...]=0A=
=0A=
Jens,=0A=
=0A=
This warning does not show up on x86_64 native build with gcc 9.1.=0A=
I just sent a patch to remove the warning, but I do not have a c6x cross=0A=
compilation environment available so the patch was checked only on x86.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
