Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC5C282CD
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 03:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3D20989
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 03:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M3EFlaPv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g5QiyZgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfA3Dqs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:46:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36148 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3Dqs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 22:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548820008; x=1580356008;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YSVqWfkg7PiRFj9CSEmxm+Cw0Qc+pTdlE7kAYHE+5NU=;
  b=M3EFlaPvHGgYXDsgOqKO+MRIzGYKN890TZsuyCTFah1lp5ya9L6KwkjI
   0xAQ9vjlVaxKrZt1aPovOSxTXZs6xQr1c2jXXpvq6np/jYB1Zu6uyGveW
   CjUx/ONfLOIuUss4QYpSyzp+m4H1QoFLZqtt7+M1gcPyCbDKeg27Ys0CV
   tHeGK3Trw8B2aTo0HMDb9QBx2UWKUSdQ5CYH8fIJ6oBIA4g75o8nxQLJ3
   65etZpGSVDw3kkBS0zooOu45i5o5RSCaXvtryHUHJSVYgXT3d1PbgNz/i
   XswfNGmtv0cwP//U0U4yyrlggpo0UzRcvuIgrXWWER+SSu/PWFfiWa6rN
   g==;
X-IronPort-AV: E=Sophos;i="5.56,539,1539619200"; 
   d="scan'208";a="100091719"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2019 11:46:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx2CQLOez3cWHGiYX0OKXZy6Pmw3bZhspvOhAgmupZg=;
 b=g5QiyZgC0O7lrHajFwIMxJaZh8kqu5aGAF+8CzN1UMJfWURjRkS7Mlbyz8MGvNtlVk/p4pr+mP8/4suEqJzBsMnJ5mX7Qj2G+FsxfwLHJUnye1ZsmLo9IyhBCTXZbLq6mnDehJGbTTc6Ut7NAGhld3MKDFKoJUsq/wn8TXWZhw4=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4133.namprd04.prod.outlook.com (20.176.250.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 03:46:45 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 03:46:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Liu Bo <bo.liu@linux.alibaba.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block: add test for io hang due to blk-iolatency
Thread-Topic: [PATCH blktests] block: add test for io hang due to
 blk-iolatency
Thread-Index: AQHUuC32DDKgL7zuREmiBFrA16E2GKXHKoky
Date:   Wed, 30 Jan 2019 03:46:45 +0000
Message-ID: <BYAPR04MB45022333823441D3A4FEA5B586900@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190129235407.64401-1-bo.liu@linux.alibaba.com>
In-Reply-To: <20190129235407.64401-1-bo.liu@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:d911:1efa:e0d9:a558]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4133;6:cri2y+FV7rC5Hy8NelQKGGDWiHEyWQoFuBDZjE8CpCSg5xx/rFJ5iOpjDmiuRzDofLQVgH7ev5lxxmDau/JKDULSd6arkhwv/fALO1v/gg6Pdbz7LPs+vhWVMZOwBpJJKIrnnGz0hoqA8ptMdjO0Jao/SBBgIvySO7P9wDNz/cEQ9g7OCFoFBaavFpM7iASUxwLT4Ov24iMo0DUXi+gdhGnB6aL4nNRYCYue8HebPEo7UZqL1yZY6xnoeWpbcgNou2901o5MiP+wR059amhrQHfGp+F/FNY2JiRudAshFpFywF8ytPP+rizWBh3+/xxGfMJOY0khKaz4+kDf40J6FtuMNYr/jOBQNmdlNaY7R5a54ZFnniZDfQlkcKMvi5iTUIQEERmXbYvGY09vjI60LN4S8ZvwPFJW9JP2TBhoXxE/ZTXa3Yp2jaWru5PgVEoAJEOBxIeTxrXnDg7IJ61dKA==;5:tTls05Eg1gaL9ZxZgd7ghhMQf+RXVl0nEG8v3gIiOy7Kfhxi119r9b0EtNP2V9YUaETAi03u1BMNF6vEmxDDQvMdLapzYrZmt2Ba2Yk+y/hUzvvUNEi01PDCWbld/GLIO6oOBXQXrlOEqY+DRGqgQm9Y6TeQ/rYutlzUOwaBbY0Fm1Aiqzk7XvfibuEduGeLWR7xpHG4KuXmZZ4uXoAhFQ==;7:F6wPufA64AMu3zghwn2NmvOByYm9IWPHjptUewrt0pfwtlZCA3evQr1fFObXRDFVTFF7b33DUh4u+3Wf7wSBFS1h/UEaXevU7D317cHPYzx6xWKdEdyS3TYwC/JWbvRBk4kB6Fr2w4QLL9rE8nOXkA==
x-ms-office365-filtering-correlation-id: 1b6ef43d-5947-4c14-7b7c-08d686658e78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4133;
x-ms-traffictypediagnostic: BYAPR04MB4133:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB413399E1F28294CDD3103B7D86900@BYAPR04MB4133.namprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(51914003)(105586002)(8676002)(81156014)(8936002)(229853002)(81166006)(256004)(68736007)(86362001)(97736004)(25786009)(6246003)(53936002)(2906002)(14454004)(9686003)(55016002)(106356001)(6436002)(72206003)(6116002)(478600001)(7736002)(305945005)(74316002)(316002)(33656002)(186003)(110136005)(486006)(71190400001)(71200400001)(476003)(11346002)(446003)(46003)(76176011)(7696005)(53546011)(99286004)(6506007)(2501003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4133;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Xl2pXXqA7xDHH3kRGjBO2cXBf+UPnt79T/qydHjMRLUyhgNPDReMDtmy1rTtHvtSNWcW0/KKfBAoCk+mxBpJw7rpo/hSw8vqMxdv+YuSMt67hP1aCGmnDg3bH9i8Hpx7iuMErhzY7qXNfIhyt8Xn5WU1OLkcM5rSFzuQewjcsSeEqKWg1cEppMebdzjDjb8tA2wJCovzOcnI4q6koYJtBg7+/MCFqHfInGMImkNVB7o77TOg1WPH4s8IlGVVIwhJPgoXf6Z2C9XBrNMaTQanZq71l5oQSqNcwuQn+7Q94uOGSmQPqPUiH53JJMQ1rfrx0xF6I6OcjWCPuxM1GxlvXGwFG/yP/bEdgPL1/BOX7wqtxiOnUeN8P4petER7SAQLLCelaIgNdGPvZLKWzxOp/OoXXtG1Xr+gGxyv5+hTmI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6ef43d-5947-4c14-7b7c-08d686658e78
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 03:46:45.7171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the test Liu, please see my inline comments.=0A=
=0A=
From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Liu Bo <bo.liu@linux.alibaba.com>=0A=
Sent: Tuesday, January 29, 2019 3:54 PM=0A=
To: linux-block@vger.kernel.org=0A=
Subject: [PATCH blktests] block: add test for io hang due to blk-iolatency=
=0A=
=A0=0A=
Add test for verifying io hang when enabling blk-iolatency after a few=0A=
IOs have been done.=0A=
=0A=
This is a regression test for=0A=
"blk-iolatency: fix IO hang due to negative inflight counter".=0A=
=0A=
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>=0A=
---=0A=
=A0tests/block/022=A0=A0=A0=A0 | 42 +++++++++++++++++++++++++++++++++++++++=
+++=0A=
=A0tests/block/022.out |=A0 2 ++=0A=
=A02 files changed, 44 insertions(+)=0A=
=A0create mode 100755 tests/block/022=0A=
=A0create mode 100644 tests/block/022.out=0A=
=0A=
diff --git a/tests/block/022 b/tests/block/022=0A=
new file mode 100755=0A=
index 0000000..6e5ab42=0A=
--- /dev/null=0A=
+++ b/tests/block/022=0A=
@@ -0,0 +1,42 @@=0A=
+#!/bin/bash=0A=
+# SPDX-License-Identifier: GPL-3.0+=0A=
+# Copyright (C) 2019 Bo Liu <bo.liu@linux.alibaba.com>=0A=
+#=0A=
+# This test is a regression test for io hang due to blk-iolatency, the pat=
ch is=0A=
+# "blk-iolatency: fix IO hang due to negative inflight counter"=0A=
+=0A=
+. tests/block/rc=0A=
+. common/cgroup=0A=
+. common/null_blk=0A=
+DESCRIPTION=3D"This test will demonstrate io hang due to blk-iolatency"=0A=
+=0A=
+requires() {=0A=
+=A0=A0=A0=A0=A0=A0 _have_null_blk && _have_cgroup2_controller_file io io.l=
atency=0A=
need to add _have_program xfs_io here.=0A=
+}=0A=
+=0A=
+test() {=0A=
+=A0=A0=A0=A0=A0=A0 local CGROUP2_DIR=0A=
+=A0=A0=A0=A0=A0=A0 local dir=0A=
+=A0=A0=A0=A0=A0=A0 echo "Running ${TEST_NAME}"=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 if ! _init_null_blk queue_mode=3D2; then=0A=
may be print a error message here and/or skip the test instred of just retu=
rn  ?=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 1=0A=
+=A0=A0=A0=A0=A0=A0 fi=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 _init_cgroup2=0A=
+=A0=A0=A0=A0=A0=A0 dir=3D$(_cgroup2_base_dir)=0A=
+=0A=
I'm little bit confused, CGROUP2_DIR is not initialize or its an environmen=
t variable ?=0A=
+=A0=A0=A0=A0=A0=A0 echo $$ > ${CGROUP2_DIR}/cgroup.procs=0A=
+=A0=A0=A0=A0=A0=A0 xfs_io -f -d -c "pwrite 0 4k" /dev/nullb0=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 # target=3D1s=0A=
+=A0=A0=A0=A0=A0=A0 echo "`cat /sys/block/nullb0/dev` target=3D1000000" > $=
{CGROUP2_DIR}/io.latency=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 xfs_io -f -d -c "pwrite 0 4k" /dev/nullb0=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 echo $$ > ${dir}/cgroup.procs=0A=
+=A0=A0=A0=A0=A0=A0 _exit_cgroup2=0A=
+=A0=A0=A0=A0=A0=A0 _exit_null_blk=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 echo "Test complete"=0A=
+}=0A=
diff --git a/tests/block/022.out b/tests/block/022.out=0A=
new file mode 100644=0A=
index 0000000..14d43cb=0A=
--- /dev/null=0A=
+++ b/tests/block/022.out=0A=
@@ -0,0 +1,2 @@=0A=
+Running block/022=0A=
+Test complete=0A=
-- =0A=
2.20.1.2.gb21ebb6=0A=
=0A=
