Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF5C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 05:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3B92147C
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 05:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bqVqhbI6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E8mix4cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfBGFHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:07:12 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2342 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfBGFHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 00:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549516032; x=1581052032;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EVUgunW4/qk/JnHVgy8ldq4aoe0/TBR1NOq903F+khg=;
  b=bqVqhbI6WLyjEhtILlBpFacpU/oVL1nT/JoRUXR1nhDws17KOtHw4YBr
   Nugn5uUvshjKbuMgee986zlH533WoIoOgZ9ViQwuITgOt2vE6WSHEkeK/
   8HEqK/OS+nwmzj6obnGh8z+JCr5zIu/OMlsnOa9hpRYZA4Vjbun80BAC7
   ys3NOyU+988uX5nhcw0iZtXkcSWuSCWnCmuLEX74lv6zcQJ2QufXCk6UJ
   XAMtvgGpqrQz3G6wpG8jF7CVbThiLHnxNUP7Cg483LM+cbhJ0yU56DerS
   7YYZcPzO+tNDfReq9sIDS6HwKMOrw/Sc5DyHYCBSZPPDJ0BazgkOQ5/eF
   g==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="105665697"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2019 13:07:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK1raiQBWZnnXuq/hMHvFp8jDiNh9jOUB2a6y93PXkM=;
 b=E8mix4cbJnc5ho+k/l3j3J57a2DOJsnKwIBJoD9xAmMwkEZKbAyb1sZKrQWldmlST6fdIuP83h7CexzR6nbvYVZmsDJ+GsxyWdqW21roUmzw6QSfRHiDQLpLA8xLFTtdwZ6v/Sm4bSoJaGFFbbvj2p1pLCeN5RkdOEmMPeP8IO4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5528.namprd04.prod.outlook.com (20.178.232.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 05:07:06 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::88b4:7016:f0cc:7bbb%3]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 05:07:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "hch@infradead.org" <hch@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "tytso@mit.edu" <tytso@mit.edu>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
Thread-Topic: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
Thread-Index: AQHUvdXi8uW0z5RC40K0A2uBHEuuMg==
Date:   Thu, 7 Feb 2019 05:07:06 +0000
Message-ID: <BYAPR04MB5816AD0D34E107EA79B69219E7680@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <2ed684c6-38de-1717-5787-31b00c72ba4f@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5528;6:Uv8kqD/PTmC8xPywhUc3VP/7oLmHewKzsFoNEq2n9tEbkLNChKsPlRoVauFvtc1Qt+o2jJdy+LxGeb528eu/u42UEsd5uk2Ry6LBjnKkVNhGQ5N9Vf3JQcxnRak+WK/AQTfpZqO8m87NAJlI9IqcIr/NuIf5ZYvu8S4Xn1wPVQPrxf+AH4oZhUEH08qoizJiBnJmKKGQRPM2ViNijnHRRJwZOJFZzm/2LQlbM3wl9rezvW4cXixlsn7SUMnRiw0qSdtphiAk8jMB48yCcchXUp2f9+o8Sms070BN/wX9im4mmVFDfaLwbfmSEKousKc9siwPJc0ynCOTooXChyGa7R8mgF4gADPLk96Bo9w0bmaKR8aWtnKWMCDPnObI623RC+7YZdyUkbGrTryCRvh7fxToZIBsZmXOBcQ4zKl9/7t+d6kaGiOy8PuGQJbNF6xSJPxc7JfnSQAEVfpr/fTaCg==;5:zDQMrpjcaiWhi7PActd+LdirGPBKTKI0t+9kEpjRoduN3GLFVBNFK/JBN/2oEe8Jq2eUNjf1XFf0asrZ6OfPNtxJI83v6yBzHiTUTdsNwdw9s3AjGnzeE+B4f818fckvXOxQdpY0mxUIhKQF7cQvnnGQHxLhXMW/5+WlDvUdcxf12n6XkTXwzX9b9TV3eVbr0iE9RJwWNr1DHhIsqCpFzA==;7:3fnjM7M2bXb0ARsEQROZb9QKCbe8/hEU04pw2ZQmKiJaZ5o9wPZKZwLkIepgOeAtiOMTso7nL0Vr8c4Ih4J84R1RgWD7g8GxKDHsRr3J6qNKtHgmVYW4AEAarKMrlL/YJCOP3R6vuDXUJrx9EuCZQg==
x-ms-office365-filtering-correlation-id: 31230f0b-3df0-4bb2-bf4f-08d68cba1b33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5528;
x-ms-traffictypediagnostic: BYAPR04MB5528:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5528262D5CBA5D093E8B6A45E7680@BYAPR04MB5528.namprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(39860400002)(396003)(189003)(199004)(45074003)(6116002)(3846002)(14444005)(966005)(561944003)(256004)(66066001)(2906002)(110136005)(316002)(229853002)(86362001)(106356001)(97736004)(71190400001)(71200400001)(105586002)(486006)(54906003)(72206003)(53936002)(478600001)(14454004)(55016002)(186003)(74316002)(26005)(9686003)(6306002)(81166006)(305945005)(2501003)(8936002)(4326008)(81156014)(68736007)(6506007)(7736002)(8676002)(7696005)(99286004)(25786009)(76176011)(53546011)(6246003)(476003)(33656002)(446003)(102836004)(7416002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5528;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x5w5QRVwZiC+vxAuwZLu5jYrImsRSjmCAav/gKKkFeej9G3vYqK3XzK9DEOLq0kRFIH2bYfqQsrOQ1U5KVxm4Du+qi7ikKLNL31C/oCmBxpqim8UiIhuHS5BfOQAnAr/A6OjHBI5tiew4+yRwfekOdrQCY4T2eejgDoiLbw3HIZ3fJvw10rOwFdpiNZ0Kutzdb7pT/H2oVgDg52M0KzpMIYDfo5X2OdgZvZTjjMWaW/YhwvWcm1R1xjgRDdhaugfaLkL7mL4Jlk2DWLb0BeKLc29UKCOgmjOU98PZc7TryjlHD/cHOrJJXGTVzCmeTlhbnnU2lmT1we6bwZZ7yh17yoYy+yfJPjsJP4NYZPZbNhn4ftK56QrLCnhimFb1WUkPt7ZQ6Lu+r7FQkeE8yngmAVzYfkFwzhWdyncq9MgSCA=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31230f0b-3df0-4bb2-bf4f-08d68cba1b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 05:07:06.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5528
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/02/06 19:32, Johannes Thumshirn wrote:=0A=
> On 06/02/2019 06:21, Chaitanya Kulkarni wrote:=0A=
>> Hi,=0A=
>>=0A=
>> Since discussion of the storage stack and device driver at the LSFMM 201=
7=0A=
>> (https://lwn.net/Articles/717699/),  Omar Sandoval introduced a new fram=
ework=0A=
>> "blktests" dedicated for Linux Kernel Block layer testing.=0A=
>> (https://lwn.net/Articles/722785/, https://github.com/osandov/blktests).=
=0A=
>>  =0A=
>> As Linux Kernel Block layer is central to the various file systems and u=
nderlying=0A=
>> low-level device drivers it is important to have a centralized testing f=
ramework and=0A=
>> make sure it grows with the latest block layer changed which are being a=
dded based=0A=
>> on the different device features from different device types=0A=
>> (e.g. NVMe devices with Zoned Namespace support).=0A=
>>=0A=
>> Since then blktests has grown and became go-to framework where we have i=
ntegrated=0A=
>> different stand-alone test suites like SRP-tests, NVMFTESTS, NVMe Multip=
ath tests,=0A=
>> zone block device tests, into one central framework, which has made an o=
verall block layer=0A=
>> testing and development much easier than having to configure and execute=
 different=0A=
>> test cases for each kernel release for different subsystems such as FS, =
NVMe,=0A=
>> Zone Block devices, etc). =0A=
>>=0A=
>> Here is the list of the existing test categories:-=0A=
>>=0A=
>> =86=80=80 block=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A28 Tests=0A=
>> =86=80=80 loop=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A =9A07 Tests=0A=
>> =86=80=80 meta=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A 12 Tests=0A=
>> =86=80=80 nbd=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=
 =9A =9A =9A =9A =9A =9A =9A =9A 02 Tests=0A=
>> =86=80=80 nvme=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A28 Tests=0A=
>> =86=80=80 nvmeof-mp=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A 12 Tests=0A=
>> =86=80=80 scsi=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A =9A 06 Tests=0A=
>> =86=80=80 srp=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=
 =9A =9A =9A =9A =9A =9A =9A =9A =9A13 Tests=0A=
>> =84=80=80 zbd=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=
 =9A =9A =9A =9A =9A =9A =9A =9A 05 Tests=0A=
>> ---------------------------------------------------------------- =0A=
>>            9 Categories=9A =9A =9A =9A =9A =9A =9A               ~110 Te=
sts=0A=
>>=0A=
>> This project has gathered much attention and storage stack community is =
actively=0A=
>> participating and adding new test cases with different categories to the=
 framework. =0A=
>>=0A=
>> For storage track, we would like to propose a session dedicated to blkte=
sts. It is a great=0A=
>> opportunity for the storage developers to gather and have a discussion a=
bout:-=0A=
>>=0A=
>> 1. Current status of the blktests framework.=0A=
>> 2. Any new/missing features that we want to add in the blktests.=0A=
>> 3. Any new kernel features that could be used to make testing easier?=0A=
>> E.g. Implementing new features in the null_blk.c in order to have device=
=0A=
>> independent complete test coverage. (e.g. adding discard command for nul=
l_blk or any=0A=
>> other specific REQ_OP). Discussion about having any new tracepoint event=
s in the block layer.=0A=
>> 4. Any new test cases/categories which are lacking in the blktests frame=
work.=0A=
> =0A=
> One thing I'd love to see is more hardware/driver specific tests. I'm=0A=
> sure Broadcom, Marvell, Huawei and all the others out there do have test=
=0A=
> suites for their HBA drivers but not a single one of these tests is=0A=
> publicly available.=0A=
> =0A=
> We're also lacking tests for things like ioprio, persistent reservation,=
=0A=
> bcache and so on.=0A=
=0A=
+1 for ioprio discussion. I mentioned my interest in discussing this in my=
=0A=
invite request. Having it as a topic would be great. Since we are in the mi=
ddle=0A=
of blktest improvements for zoned devices, I can try to put together a prop=
osal=0A=
as a discussion base.=0A=
=0A=
> =0A=
> Adding support for collecting gcov information after running a test case=
=0A=
> would also be awesome (this is missing in xfstests as well).=0A=
> =0A=
> So I think a session on blktests can help us get the gap closed.=0A=
> =0A=
> Byte,=0A=
> 	Johannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
