Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E69C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31C520645
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EVZOPAgc";
	dkim=temperror (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KTk539Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31C520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLLXUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:20:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30193 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLLXUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 18:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544656832; x=1576192832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+VPidNkeWpeu0IyI9UGyZ6N9x13qpCfNh77VOPHr5EM=;
  b=EVZOPAgcykKW41BPexWdCbN/u6mXv3/gsKBpIM+e9f/lWJLT0LYd/jfO
   TQtcxjqvPbf2WFBOmGoGbbvQ0KQPRuuzWTwRchv48OLn8y6mzZty5axzq
   cg1pU0NHAUz9CQWxUnWYG4Zom/19lA9rrG08wZff+cfMJdS1W2DYq820x
   eIH6LUkNj8mAbnmGir6SKT/9d0E+8arxfXUQ7/kLf7UWpDcSJQWuWMwig
   wMeQffio2F4kGcCe3ouPTNrz/F73mqHyxd+PG1lZ79ZH3j7xU0bg6aXAv
   JGkB3xYUnfeuMqmbIsgzpwQJrjFkrbAyxZ+vr7RswvPjAIDTjNvcpZLjv
   w==;
X-IronPort-AV: E=Sophos;i="5.56,346,1539619200"; 
   d="scan'208";a="98205617"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2018 07:20:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5wSvhHCI+f+BP2m8IntC17DyoxUKMPIBASNjsGRBBw=;
 b=KTk539OcEmZmAgNFc4qcoxX5CLkfuEgyBezFFriOkVXuulb1DklShcXZK9jcCVYfPQL2M/jeMEM2EwKjnL+iBFqDYki/LG2aq8wyzbgRw028QmiYGhGDVSmJc/GjzmYnpZEVe3PyNbnMw4XB1lns2KobR2tkVAILL9CNucT3sUw=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4904.namprd04.prod.outlook.com (52.135.232.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 23:20:29 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::6155:b583:4364:5623]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::6155:b583:4364:5623%4]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 23:20:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Omar Sandoval <osandov@fb.com>
Subject: Re: blktests: trying to debug nvme test failures
Thread-Topic: blktests: trying to debug nvme test failures
Thread-Index: AQHUkERufe34jpyzs0ySrLqYx1ftr6V3dw7bgARKHkY=
Date:   Wed, 12 Dec 2018 23:20:28 +0000
Message-ID: <BYAPR04MB45025DF7A923440F452E1FB286A70@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20181210045419.GF1840@mit.edu>,<BYAPR04MB4502E9683DD6F4D6C9BCFEA586A50@BYAPR04MB4502.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4502E9683DD6F4D6C9BCFEA586A50@BYAPR04MB4502.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4904;6:zkYtt1FZnwGADvh5e7n4R8+e3VcoBYTdE0RfTvFnQxbDuq1TkWdxI1N2xTvGi+i+ejpEpsK5P+yTM+awMRKe3fl1EAEBfzX81x/ASplIJ9l8N6I3I1eWVqcLgl9yYonhh+Lw09rNquRGsF58D3dL/XY0vQ3Tm+vgXJED6cYSl0x8lzAm0rJRntm+DP5cAbIRHqfMlkbY/yC/fmB6RszW/jOvZLDhSaWpDC4BPBHkkcsUkabZWwS4Jq3iyYhexPUqZyCtxtZsNBxtRRHGG4MyIcQhSV8IoEcf9FcixoCKAWdB1NuI18Slck26z4CWDtzXGSggA6nfQq8HTPlF2tG5fhjoF3PiBkWFLMv/s8E9pugH66vLpWHll+XvmHZY8zdzQ6I39z/EWnTGpPOwVdCHg0gPkCShuzn+zn0rUu4aYp2Q6u1kYriTjgr5niTc3D/IVclj8vDtrudW/bESCQmnKQ==;5:h4cca+M5AqhxqZJsf2/t/29Ceu5sMA1x3rAtD2c5eFWcPzv1sSPJ8+r+e/mHhj8ezbaC/CVqXHlA81H3uHQfsZKYJIoyyqx9KbY1F9usi9pG7/akHr0WKABV/VFNVNap9rHy0eTkL+qbw9MUToCJjIvsGqtw86KQA92SJh3JaCw=;7:TDCCwo5Yg5B85Lm5oDCuKfWSvq4hiMcQG/oscAhpkDhaijRRUqsknmQzQRYk+HjpldCQAqP87gkeqECTyYJVu8zKQzeSpbvu0cc6FzxGCI/wIieim2IpPy27mQ7X5bzw1kFe/zJVD7CdZ8sj2ZefoA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1eedb1aa-d65e-482b-d614-08d6608867a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4904;
x-ms-traffictypediagnostic: BYAPR04MB4904:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4904C5DC9833FC3045DA0BBC86A70@BYAPR04MB4904.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230020)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB4904;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB4904;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(186003)(76176011)(6506007)(81166006)(110136005)(55016002)(81156014)(7696005)(2501003)(5660300001)(7736002)(575784001)(14444005)(2906002)(256004)(6436002)(229853002)(74316002)(4744004)(8676002)(66066001)(316002)(8936002)(14454004)(72206003)(99286004)(33656002)(68736007)(4326008)(86362001)(446003)(476003)(25786009)(71190400001)(71200400001)(53936002)(3846002)(26005)(97736004)(2171002)(6116002)(478600001)(102836004)(305945005)(106356001)(53546011)(105586002)(486006)(9686003)(6246003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4904;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tvbcMEhrsbqgyalcWzqqI3ChP4bReVTXTMqKNPIW7uJrvQe/RbHEty0IsGhOVnosy1L1l+oNzqJZKRkpx+zjqNrPElN8hfwCWYB9AnNLJ+0UpLA/gdLXyUYX2v9onkgzi6jKe/fzA671TUX8aLLsYmjbDPKlUPkxUxIFrf4WaAjbNTWVWS1jTzDquGORPCyAj1wxCx1QH6Ax4VHzR6gZGKtiFc5Ot9YwUdgHCpqq66ttSkObglJRts7pRQZYiTUSZxY+Ev1jWcx5YTFt03e/8rEGbocdfC2LG/Yvvm12O2Pt68mJTEFn+kDtKgPsXbYo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eedb1aa-d65e-482b-d614-08d6608867a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 23:20:28.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4904
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ted,

I was able to run most of the tests without any problem, except data verifi=
cation tests which are producing some hangs randomly, need to dig more.

Can you please share the dmesg output at the end of run ?

From: Chaitanya Kulkarni
Sent: Sunday, December 9, 2018 9:48 PM
To: Theodore Y. Ts'o; linux-block@vger.kernel.org
Cc: Omar Sandoval
Subject: Re: blktests: trying to debug nvme test failures
=A0=20
=20
Let me take a look at it.




From: Theodore Y. Ts'o <tytso@mit.edu>
Sent: Sunday, December 9, 2018 8:54 PM
To: linux-block@vger.kernel.org
Cc: Omar Sandoval; Chaitanya Kulkarni
Subject: blktests: trying to debug nvme test failures
=A0=20
=A0
Hi,

I've been trying to run blktsts in an automated environment, and I've
been trying to figure out which failures are test bugs, environment
bugs, and which are kernel bugs.

In the NVME tests, there are a number of failures that are caused by
the missing line:

=A0=A0=A0 -NQN:blktests-shubsystem-1 disconnected 1 controller(s)

I'm not sure what that means, or how to fix the problem.=A0 Could
someone give me a hint?

Many thanks!!

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - Ted

FSTESTVER: blktests=A0=A0=A0=A0 69a95c6 (Fri, 7 Dec 2018 10:13:57 -0800)
FSTESTVER: fio=A0=A0=A0=A0=A0=A0=A0=A0=A0 fio-3.2 (Fri, 3 Nov 2017 15:23:49=
 -0600)
FSTESTVER: fsverity=A0=A0=A0=A0 bdebc45 (Wed, 5 Sep 2018 21:32:22 -0700)
FSTESTVER: ima-evm-utils=A0=A0=A0=A0=A0=A0=A0 0267fa1 (Mon, 3 Dec 2018 06:1=
1:35 -0500)
FSTESTVER: nvme-cli=A0=A0=A0=A0 v0.2-918-ge145ab4 (Fri, 7 Dec 2018 15:15:48=
 -0700)
FSTESTVER: quota=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 59b280e (Mon,=
 5 Feb 2018 16:48:22 +0100)
FSTESTVER: stress-ng=A0=A0=A0 977ae357 (Wed, 6 Sep 2017 23:45:03 -0400)
FSTESTVER: syzkaller=A0=A0=A0 4b6d14f2 (Tue, 27 Nov 2018 13:16:46 +0100)
FSTESTVER: xfsprogs=A0=A0=A0=A0 v4.19.0 (Fri, 9 Nov 2018 14:31:04 -0600)
FSTESTVER: xfstests-bld 461a0aa (Sun, 9 Dec 2018 23:39:23 -0500)
FSTESTVER: xfstests=A0=A0=A0=A0 linux-v3.8-2246-g12eec16d (Sun, 9 Dec 2018 =
23:15:23 -0500)
FSTESTSET: "nvme"
FSTESTEXC: ""
FSTESTOPT: "blktests aex"
CPUS: "2"
MEM: "1979.4"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total=A0=A0=A0=A0=A0=A0=A0 used=A0=
=A0=A0=A0=A0=A0=A0 free=A0=A0=A0=A0=A0 shared=A0 buff/cache=A0=A0 available
Mem:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1979=A0=A0=A0=A0=A0=A0=A0=A0=A0 46=A0=A0=
=A0=A0=A0=A0=A0 1828=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8=A0=A0=A0=A0=A0=A0=A0=
=A0 104=A0=A0=A0=A0=A0=A0=A0 1891
Swap:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
BEGIN BLKTESTS Sun Dec=A0 9 23:47:00 EST 2018
nvme/*** =3D> vdb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 [not run]
=A0=A0=A0 /dev/vdb is not a NVMe device
nvme/002 (create many subsystems and test discovery)=A0=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0 runtime=A0 29.493s=A0 ...
nvme/002 (create many subsystems and test discovery)=A0=A0=A0=A0=A0=A0=A0=
=A0 [passed]
=A0=A0=A0 runtime=A0 29.493s=A0 ...=A0 28.269s
nvme/003 (test if we're sending keep-alives to a discovery controller)
=A0=A0=A0 runtime=A0 10.227s=A0 ...
nvme/003 (test if we're sending keep-alives to a discovery controller) [pas=
sed]
=A0=A0=A0 runtime=A0 10.227s=A0 ...=A0 10.246s
nvme/004 (test nvme and nvmet UUID NS descriptors)=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=20
=A0=A0=A0 runtime=A0 0.347s=A0 ...
nvme/004 (test nvme and nvmet UUID NS descriptors)=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 [passed]
=A0=A0=A0 runtime=A0 0.347s=A0 ...=A0 0.316s
nvme/005 (reset local loopback target)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [not run]
=A0=A0=A0 nvme-core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns)
=A0=A0=A0 runtime=A0 0.292s=A0 ...
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
=A0=A0=A0 runtime=A0 0.292s=A0 ...=A0 0.258s
nvme/007 (create an NVMeOF target with a file-backed ns)=A0=A0=A0=20
=A0=A0=A0 runtime=A0 0.202s=A0 ...
nvme/007 (create an NVMeOF target with a file-backed ns)=A0=A0=A0=A0 [passe=
d]
=A0=A0=A0 runtime=A0 0.202s=A0 ...=A0 0.151s
nvme/008 (create an NVMeOF host with a block device-backed ns)
=A0=A0=A0 runtime=A0 0.423s=A0 ...
nvme/008 (create an NVMeOF host with a block device-backed ns) [failed]
=A0=A0=A0 runtime=A0 0.423s=A0 ...=A0 0.386s
=A0=A0=A0 --- tests/nvme/008.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/008.out.bad 2018-12-09 23:47:40.514592807=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/008
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/009 (create an NVMeOF host with a file-backed ns)=A0=A0=A0=A0=A0=20
=A0=A0=A0 runtime=A0 0.320s=A0 ...
nvme/009 (create an NVMeOF host with a file-backed ns)=A0=A0=A0=A0=A0=A0 [f=
ailed]
=A0=A0=A0 runtime=A0 0.320s=A0 ...=A0 0.311s
=A0=A0=A0 --- tests/nvme/009.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/009.out.bad 2018-12-09 23:47:40.947926140=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/009
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/010 (run data verification fio job on NVMeOF block device-backed ns)
=A0=A0=A0 runtime=A0 27.516s=A0 ...
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [=
failed]
=A0=A0=A0 runtime=A0 27.516s=A0 ...=A0 27.912s
=A0=A0=A0 --- tests/nvme/010.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/010.out.bad 2018-12-09 23:48:08.994592800=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/010
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/011 (run data verification fio job on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 21.947s=A0 ...
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [failed]
=A0=A0=A0 runtime=A0 21.947s=A0 ...=A0 23.609s
=A0=A0=A0 --- tests/nvme/011.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/011.out.bad 2018-12-09 23:48:32.724592785=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/011
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-bac=
ked ns)
=A0=A0=A0 runtime=A0 58.246s=A0 ...
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-bac=
ked ns) [failed]
=A0=A0=A0 runtime=A0 58.246s=A0 ...=A0 51.121s
=A0=A0=A0 --- tests/nvme/012.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/012.out.bad 2018-12-09 23:49:23.934592771=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/012
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 13.267s=A0 ...
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) =
[failed]
=A0=A0=A0 runtime=A0 13.267s=A0 ...=A0 13.653s
=A0=A0=A0 --- tests/nvme/013.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/013.out.bad 2018-12-09 23:49:37.694592754=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/013
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/014 (flush a NVMeOF block device-backed ns)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=20
=A0=A0=A0 runtime=A0 5.472s=A0 ...
nvme/014 (flush a NVMeOF block device-backed ns)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [failed]
=A0=A0=A0 runtime=A0 5.472s=A0 ...=A0 6.397s
=A0=A0=A0 --- tests/nvme/014.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/014.out.bad 2018-12-09 23:49:44.164592749=
 -0500
=A0=A0=A0 @@ -2,5 +2,4 @@
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 NVMe Flush: success
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/015 (unit test for NVMe flush for file backed ns)=A0=A0=A0=A0=A0=20
=A0=A0=A0 runtime=A0 4.390s=A0 ...
nvme/015 (unit test for NVMe flush for file backed ns)=A0=A0=A0=A0=A0=A0 [f=
ailed]
=A0=A0=A0 runtime=A0 4.390s=A0 ...=A0 4.524s
=A0=A0=A0 --- tests/nvme/015.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/015.out.bad 2018-12-09 23:49:48.744592747=
 -0500
=A0=A0=A0 @@ -2,5 +2,4 @@
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 NVMe Flush: success
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/016 (create/delete many NVMeOF block device-backed ns and test discove=
ry)
=A0=A0=A0 runtime=A0 22.275s=A0 ...
nvme/016 (create/delete many NVMeOF block device-backed ns and test discove=
ry) [failed]
=A0=A0=A0 runtime=A0 22.275s=A0 ...=A0 20.610s
=A0=A0=A0 --- tests/nvme/016.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/016.out.bad 2018-12-09 23:50:09.434592742=
 -0500
=A0=A0=A0 @@ -1,6 +1,6 @@
=A0=A0=A0=A0 Running nvme/016
=A0=A0=A0=A0=20
=A0=A0=A0 -Discovery Log Number of Records 1, Generation counter 1
=A0=A0=A0 +Discovery Log Number of Records 1, Generation counter 3
=A0=A0=A0=A0 =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
=A0=A0=A0=A0 trtype:=A0 loop
=A0=A0=A0=A0 adrfam:=A0 pci
nvme/017 (create/delete many file-ns and test discovery)=A0=A0=A0=20
=A0=A0=A0 runtime=A0 22.004s=A0 ...
nvme/017 (create/delete many file-ns and test discovery)=A0=A0=A0=A0 [passe=
d]
=A0=A0=A0 runtime=A0 22.004s=A0 ...=A0 21.729s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns)
=A0=A0=A0 runtime=A0 0.378s=A0 ...
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [failed]
=A0=A0=A0 runtime=A0 0.378s=A0 ...=A0 0.323s
=A0=A0=A0 --- tests/nvme/019.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/019.out.bad 2018-12-09 23:50:31.664592737=
 -0500
=A0=A0=A0 @@ -2,5 +2,4 @@
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 NVMe DSM: success
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 0.306s=A0 ...
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [failed]
=A0=A0=A0 runtime=A0 0.306s=A0 ...=A0 0.254s
=A0=A0=A0 --- tests/nvme/020.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/020.out.bad 2018-12-09 23:50:31.951259403=
 -0500
=A0=A0=A0 @@ -2,5 +2,4 @@
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 NVMe DSM: success
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/021 (test NVMe list command on NVMeOF file-backed ns)=A0=20
=A0=A0=A0 runtime=A0 0.298s=A0 ...
nvme/021 (test NVMe list command on NVMeOF file-backed ns)=A0=A0 [failed]
=A0=A0=A0 runtime=A0 0.298s=A0 ...=A0 0.255s
=A0=A0=A0 --- tests/nvme/021.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/021.out.bad 2018-12-09 23:50:32.241259401=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/021
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)=20
=A0=A0=A0 runtime=A0 0.414s=A0 ...
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)=A0 [failed]
=A0=A0=A0 runtime=A0 0.414s=A0 ...=A0 0.366s
=A0=A0=A0 --- tests/nvme/022.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/022.out.bad 2018-12-09 23:50:32.647926067=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/022
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns)
=A0=A0=A0 runtime=A0 0.359s=A0 ...
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [failed]
=A0=A0=A0 runtime=A0 0.359s=A0 ...=A0 0.338s
=A0=A0=A0 --- tests/nvme/023.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/023.out.bad 2018-12-09 23:50:33.017926067=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/023
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 0.308s=A0 ...
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [failed]
=A0=A0=A0 runtime=A0 0.308s=A0 ...=A0 0.269s
=A0=A0=A0 --- tests/nvme/024.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/024.out.bad 2018-12-09 23:50:33.351259401=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/024
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0=A0 Test complete
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 0.302s=A0 ...
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [failed]
=A0=A0=A0 runtime=A0 0.302s=A0 ...=A0 0.294s
=A0=A0=A0 --- tests/nvme/025.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/025.out.bad 2018-12-09 23:50:33.724592735=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/025
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0 -Test complete
=A0=A0=A0 +Test Failed
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 0.291s=A0 ...
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [failed]
=A0=A0=A0 runtime=A0 0.291s=A0 ...=A0 0.264s
=A0=A0=A0 --- tests/nvme/026.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/026.out.bad 2018-12-09 23:50:34.077926069=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/026
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0 -Test complete
=A0=A0=A0 +Test Failed
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 0.288s=A0 ...
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [failed]
=A0=A0=A0 runtime=A0 0.288s=A0 ...=A0 0.293s
=A0=A0=A0 --- tests/nvme/027.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/027.out.bad 2018-12-09 23:50:34.417926069=
 -0500
=A0=A0=A0 @@ -1,5 +1,4 @@
=A0=A0=A0=A0 Running nvme/027
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0 -Test complete
=A0=A0=A0 +Test Failed
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns)
=A0=A0=A0 runtime=A0 0.297s=A0 ...
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [failed]
=A0=A0=A0 runtime=A0 0.297s=A0 ...=A0 0.284s
=A0=A0=A0 --- tests/nvme/028.out=A0=A0=A0=A0=A0 2018-12-09 23:39:23.0000000=
00 -0500
=A0=A0=A0 +++ /results/nodev/nvme/028.out.bad 2018-12-09 23:50:34.744592735=
 -0500
=A0=A0=A0 @@ -1,5 +1,5 @@
=A0=A0=A0=A0 Running nvme/028
=A0=A0=A0=A0 91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0=A0 uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
=A0=A0=A0 -NQN:blktests-subsystem-1 disconnected 1 controller(s)
=A0=A0=A0 -Test complete
=A0=A0=A0 +The '<device>' may be either an NVMe character device (ex: /dev/=
nvme0) or an
=A0=A0=A0 +nvme block device (ex: /dev/nvme0n1).Test Failed
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 total=A0=A0=A0=A0=A0=A0=A0 used=A0=
=A0=A0=A0=A0=A0=A0 free=A0=A0=A0=A0=A0 shared=A0 buff/cache=A0=A0 available
Mem:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1979=A0=A0=A0=A0=A0=A0=A0=A0=A0 55=A0=A0=
=A0=A0=A0=A0=A0 1787=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8=A0=A0=A0=A0=A0=A0=A0=
=A0 136=A0=A0=A0=A0=A0=A0=A0 1882
Swap:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
END BLKTESTS Sun Dec=A0 9 23:50:34 EST 2018
=A0=A0=A0    =
