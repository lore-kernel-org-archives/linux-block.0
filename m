Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFDCC43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E016120659
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 19:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EruGscDD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LVs0bidz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANTKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:10:21 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16756 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfANTKV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 14:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547493021; x=1579029021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gxvb5x1ToeoNH6Rj/RJyRddu8y4Zw/tDJZ6jzzaMiWk=;
  b=EruGscDD14Bv2nat8DZM6bbZmQWSy2GWaNTx76AHtVpq4qmNrkMyN1js
   22oGj3dMKmlrnB9iDdw3CBJc6nj2wkgsmoBPbTp1o7ZqnMdcqlX5sSilX
   lV2aL5ZCJ3h8muPlPxS7MnA3lwDUHTMIdBmiNYKztzD5ANHFujkj2IDDA
   P1nQmc+TldH7zd3cI00IFt8r6eXMY80ND7hiHLJOurZX1uuwEKsJRkqcK
   28phth1BkND210B40BYOGlMvrA+xfHItRHMUTsGQUmfI0zwgG8qlvsdjC
   NTmFkrx4NHiPGZ7n9D8xunawXMxdnyBZS3thgsvLQScfrxg9UdWH28VDK
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,478,1539619200"; 
   d="scan'208";a="100522320"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2019 03:10:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0clfkUUck9PF2dD7RRL8b2lOyUZ346e143f7rQ+IBw=;
 b=LVs0bidzYExdedpNvDUoTrRJRpaFe2KxlhyLETxD4WfkyQPNN1iWXHA9jIpjjowi3JewsO2uD0WcrslGacHKQRbT0Nu3Cw2NBxum5XOoLO8GakeIcsYPDhyH2u6DI3LH/eK9qxB7V3E8tT87u964UTqlqwg7exO/cfvf4ZUnX4Q=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4231.namprd04.prod.outlook.com (20.176.250.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Mon, 14 Jan 2019 19:10:17 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 19:10:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Josef Bacik <jbacik@fb.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] loop: Add test for changing capacity when filesystem is
 mounted
Thread-Topic: [PATCH] loop: Add test for changing capacity when filesystem is
 mounted
Thread-Index: AQHUq+XocWtqOEZ43EisNFOW0c6mLKWulgz2gACKQXI=
Date:   Mon, 14 Jan 2019 19:10:17 +0000
Message-ID: <BYAPR04MB45026647498A4B84C5001EA686800@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190114084811.14455-1-jack@suse.cz>
 <20190114084811.14455-4-jack@suse.cz>
 <f3988910-5c64-2ab4-a4e8-8255d72458b1@i-love.sakura.ne.jp>
 <20190114104119.GE13316@quack2.suse.cz>,<20190114105001.GF13316@quack2.suse.cz>
In-Reply-To: <20190114105001.GF13316@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4231;6:lZTC2DlPDl9fUhRT5MvMgdaQOE4T4jkjxw21tHKzvbcBiWDWZa/FtBh4td+jVL9nhHn5ua1xrw8x7t4iiENNghVJr7eYl4XPUaep2LJp2zW0wD5avzPjKCGUniTPcnarmcrtwufDNyDuIhdZ15b264s9Ab3Pz5He8Gg78TI/i+BqA8L3p4Y/VBj/yHANaYvjulAZIx5ut6CyL46OfXDkoqCKcbtOQCWZ40yHwuT5dJmJbc44UfyWs8+lSvtm9XlWB/pwNh17zd4vwLEkWM/zk3hGHm9/Y55YBSbUs1d+qL+FMZSOV0hwLTmr13hH0k2ZlG9+tu75QwT0upTF+ii0fLEWeJIAASNyDjKafTEI/9Nl8UXjQu45YCujkcbC0zoiSzCeF4V58dpcrW06xGUID2A9cxR5YTaAnAe3wqCfrhy2mgHMVMClGjQD16cg7RPXQ6Nj0FPQ2+zRgHZujVm52w==;5:Cegi9MXamJR4Sf2PH03594H/5o1VvGi3bXNtmzyTccGkg2glhjaS/lyoZt7267Ftjsv5Q4l41qMfXIkQRh8GIWZwNemRWnIWXuz7JJB1mbswVePDnaHBV2w4mRfKQ0ofZGkOo7+Kj6LeElDUtYfQjd3v9jc5BXtsPY0G4tjgsAv3wttObwb4yIutFdD8HFWG+2OC+jWG5sH5lPpLoH9NEw==;7:RnoFlu7QLqiNkpNvnESAHva3GRktweNxjyBcM/R2WrpfxB78bbMPv8NpVhHG8qFsA7VWZU6qw/SiVgyLGYQy88VYtm4FA5LxgXVDJUcwATrWWCwCBFtvD6YFcTqklc/KJhnWTWllbcCaDXGBP0s5Hw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0c47240a-5565-43d8-41e8-08d67a53ebd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4231;
x-ms-traffictypediagnostic: BYAPR04MB4231:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4231A61801271C1642378B4E86800@BYAPR04MB4231.namprd04.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(43234003)(189003)(199004)(51914003)(446003)(6246003)(74316002)(11346002)(53936002)(53546011)(478600001)(33656002)(72206003)(99286004)(229853002)(25786009)(14454004)(66066001)(4326008)(6506007)(6436002)(71200400001)(71190400001)(93886005)(186003)(9686003)(106356001)(8936002)(105586002)(102836004)(6346003)(86362001)(7736002)(26005)(305945005)(5660300001)(486006)(2906002)(14444005)(5024004)(7696005)(68736007)(256004)(110136005)(316002)(345774005)(55016002)(476003)(54906003)(6116002)(3846002)(76176011)(97736004)(81166006)(8676002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4231;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2yu2ugLeiEdW0JfyORt2rUTeW3wiMoUmibEGcA3goaFcLU4lr1lsA3UhE570mfafS36+xLZWSfk2uoZ+LdY4vImwkw74TP8jCxL/boHxeDqMdZfPPUWV5ddsrOK/V4UmoEbxCzY3g+zYuNdQxsdhI88WCfIoakpwweltdwev4pUnPI0kd74c00w/ZP/NnqL+bgyPP6J0bOW3s+CzbFpIPb87Ya2a/tYNlXstYFYa3tV/VjoMO3t52s5Aw+aSbD7NigCNChXrqDzlafcXPggRYoQ6WyzoOr9GMYHmO3YnMQAGHPjzht20BNC8JooZEL8S++lax6PQ/1lB7ueglj0sweGmFu7B0bHRWlzX6Np/B6Vu8zi0UrVPNeh5FmBzQxEHvzKHnOzeh+W//k4ghlOl/rztbzh5ozRMmS3ae40G0Rs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c47240a-5565-43d8-41e8-08d67a53ebd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 19:10:17.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4231
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan,

Thanks for the test.

=A0 =A0 =A01	From 45a003672775cb6dcebc99d7ddfe19a1c9507ac3 Mon Sep 17 00:00=
:00 2001
=A0 =A0 =A02	From: Jan Kara <jack@suse.cz>
=A0 =A0 =A03	Date: Mon, 14 Jan 2019 09:23:42 +0100
=A0 =A0 =A04	Subject: [PATCH v2] loop: Add test for changing capacity when =
filesystem is
=A0 =A0 =A05	 mounted
=A0 =A0 =A06=09
=A0 =A0 =A07	Add test for changing capacity of a loop device when a filesys=
tem with
=A0 =A0 =A08	non-default block size is mounted on it. This is a regression =
test for
=A0 =A0 =A09	"blockdev: Fix livelocks on loop device".
=A0 =A0 10=09
=A0 =A0 11	Signed-off-by: Jan Kara <jack@suse.cz>
=A0 =A0 12	---
=A0 =A0 13	 tests/loop/007=A0 =A0 =A0| 38 +++++++++++++++++++++++++++++++++=
+++++
=A0 =A0 14	 tests/loop/007.out |=A0 2 ++
=A0 =A0 15	 2 files changed, 40 insertions(+)
=A0 =A0 16	 create mode 100755 tests/loop/007
=A0 =A0 17	 create mode 100644 tests/loop/007.out
=A0 =A0 18=09
=A0 =A0 19	diff --git a/tests/loop/007 b/tests/loop/007
=A0 =A0 20	new file mode 100755
=A0 =A0 21	index 000000000000..3598aeba4443
=A0 =A0 22	--- /dev/null
=A0 =A0 23	+++ b/tests/loop/007
=A0 =A0 24	@@ -0,0 +1,38 @@
=A0 =A0 25	+#!/bin/bash
=A0 =A0 26	+# SPDX-License-Identifier: GPL-3.0+
=A0 =A0 27	+# Copyright (C) 2019 Jan Kara
=A0 =A0 28	+#
=A0 =A0 29	+# Test loop device capacity change handling with filesystem mou=
nted on top.
=A0 =A0 30	+#
=A0 =A0 31	+# Regression test for patch "blockdev: Fix livelocks on loop de=
vice".
=A0 =A0 32	+#
=A0 =A0 33	+
=A0 =A0 34	+. tests/loop/rc
=A0 =A0 35	+
=A0 =A0 36	+DESCRIPTION=3D"update loop device capacity with filesystem"
=A0 =A0 37	+
=A0 =A0 38	+QUICK=3D1
=A0 =A0 39	+
=A0 =A0 40	+requires() {
=A0 =A0 41	+	_have_program mkfs.ext4
=A0 =A0 42	+}
=A0 =A0 43	+
=A0 =A0 44	+test() {
=A0 =A0 45	+	echo "Running ${TEST_NAME}"
=A0 =A0 46	+
Can we add loop module load/unload at the start and end of the test case ?=
=A0
or is there any specific reason we are not loading and unloading the module=
 in this test ?
=A0 =A0 47	+	local mount_dir=3D"/mnt/blktests/"
=A0 =A0 48	+
=A0 =A0 49	+	truncate -s 1G "$TMPDIR/img"
=A0 =A0 50	+	mkdir -p "$mount_dir"
=A0 =A0 51	+	local loop_device=3D"$(losetup -P -f --show "$TMPDIR/img")"
=A0 =A0 52	+	mkfs.ext4 -b 1024 "$loop_device" &>/dev/null
=A0 =A0 53	+	mount -t ext4 "$loop_device" "$mount_dir"
=A0 =A0 54	+	losetup -c "$loop_device"
=A0 =A0 55	+	# This hangs if rereading capacity changed block size
=A0 =A0 56	+	ls -l "$mount_dir" >/dev/null
=A0 =A0 57	+	umount "$mount_dir"
=A0 =A0 58	+	losetup -d "$loop_device"
=A0 =A0 59	+	rm -fr "$mount_dir" "$TMPDIR/img"
=A0 =A0 60	+
=A0 =A0 61	+	echo "Test complete"
=A0 =A0 62	+}
=A0 =A0 63	diff --git a/tests/loop/007.out b/tests/loop/007.out
=A0 =A0 64	new file mode 100644
=A0 =A0 65	index 000000000000..32752934d48a
=A0 =A0 66	--- /dev/null
=A0 =A0 67	+++ b/tests/loop/007.out
=A0 =A0 68	@@ -0,0 +1,2 @@
=A0 =A0 69	+Running loop/007
=A0 =A0 70	+Test complete
=A0 =A0 71	--=A0
=A0 =A0 72	2.16.4
=A0 =A0 73=09


-ck




From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Jan Kara <jack@suse.cz>
Sent: Monday, January 14, 2019 2:50 AM
To: Jens Axboe
Cc: Jan Kara; linux-block@vger.kernel.org; Josef Bacik; Tetsuo Handa
Subject: Re: [PATCH] loop: Add test for changing capacity when filesystem i=
s mounted
=A0=20
=20
On Mon 14-01-19 11:41:19, Jan Kara wrote:
> On Mon 14-01-19 18:44:22, Tetsuo Handa wrote:
> > Thank you for the patch.
> >=20
> > On 2019/01/14 17:48, Jan Kara wrote:
> > > + # This hangs if rereading capacity changed block size
> > > + l /mnt
> >=20
> > Is 'l' defined as an alias to 'ls' ? I suggest not depending on such al=
ias,
> > for at least 'l' is not defined in my environment.
>=20
> Yeah, my bad. I have it everywhere and my finger memory just typed it int=
o
> the test :). Of course 'ls -l' is better for the test so I'll fix it up i=
n
> the next version. Thanks for review.

The test had a couple more bugs which should be fixed now so attached is a
new version which I've actually tested inside the blktests framework ;).

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Honza
--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR
    =
