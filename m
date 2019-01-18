Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F72C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 00:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9D320896
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 00:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K1nv6afq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k/hQ3LsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfARAEW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:04:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14323 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfARAEW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 19:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547769862; x=1579305862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=swWFNMzqlNOfR7OKvhugPo+litgDuiJbqiIPASbHnCM=;
  b=K1nv6afqvSAvoj0dx+guqnqSdK0vxjMLJaPbT0LdRiyeNC1hkXx6kE2C
   XygxkRr0gJN7N7XV8M2ZLtZj8ZrFZaVFTWJSxW+XBJoz5t9gxo0LXQ90b
   9kvK5lQv8vnEXtPCb3q1smDp61tjPPZv/1IUyPLE6jS4K0HFXm0rE1pos
   1azLbdtK73TaV21F4ugENYwFigyJQKH07PoQRf7OqGU83YPI8W+gCL1h3
   aczNLY38MYMR93WHdEH4PpXSLMw5/ZBCAQ5nlD0cmKE0cQKN+/fAnA+TZ
   42Dej8iQIe+oFx2Y6GC2a86Oh5ps28gbbURF4XyK79QdZNIB3718/NTwc
   g==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="100326447"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 08:04:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccR08tTo3XK5fAxUw1UcLfmdwOmnpNRoD/MQwPpRT2c=;
 b=k/hQ3LsJyb+EKlkktW65Y0cmgNfb+bXrYFgXDKuIipV1MJJOgR51gqQUhjihNsCrzjSLrXB1Rdh4ij7cL6VNw6e/YA20P5WHySq4nr1p35FhZpHbMPEmfZQOCV8NrYZIpRDTrMDtCver6aVebMyBYtqQYGKDvhkgjLC/h6p28yQ=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4903.namprd04.prod.outlook.com (52.135.232.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 00:04:19 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 00:04:19 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Omar Sandoval <osandov@osandov.com>
CC:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH blktests 2/2] nvme: test resize of a namespace with
 file-backed ns
Thread-Topic: [PATCH blktests 2/2] nvme: test resize of a namespace with
 file-backed ns
Thread-Index: AQHUrmR8fZmOH7CZlEi1oiqoXxWrL6W0Iykn
Date:   Fri, 18 Jan 2019 00:04:19 +0000
Message-ID: <BYAPR04MB4502DFB8875F3D6835086C6086830@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190117125906.15479-1-jthumshirn@suse.de>,<20190117125906.15479-2-jthumshirn@suse.de>
In-Reply-To: <20190117125906.15479-2-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4903;6:szd2/sixOa+ZKDDr/bVl1d7zTk0j1a12285ZE/hrTgQm90rH32aSPpgaX/KvhXobsP23+ju6xTdD7cc25c7hg2kegFRpqaiPcOMJk6r6ILGEF7HiGl4s7vz7CiYLAnyFQtqMBj1tzdTd2FMwFNfSm6/AiczBWk/7q8vG5qu1qSlR9R/UcqLV4IJzSZXBAwDCa0VYeD09OfrnLDyBCZFBYGH1cw8WTnRVWF/1vCeUX/kbRoigxu3q3xnrH9HyTVoyNr5/VsnRHjOR5KmtFklTEyY3fZEGPgCz6wXrKd05zWh/o7iB89ZCv1FX3cd17Qjrqg2XXoMHxO9BHx7wyGulWzYk4D4nP2jZ0CMLN+s/NDOqvDSYRluk35anhMJI3grzXN2xRY+NW0k+89h9ISm5Jo3BKI2KaXBKeyfYvz99fgIJILxelXPxJzSrk18BuqaL/o0sS9kmTz3ChFkj6WJkwA==;5:cwUGpJxwnoE1Zn1lDpNC/nxNnNFaKaNfdmUGeDXqVo4rKrWA/L3s72ivjo7ozz5UKl/jksHTK18JZXZKCIoWnxyRzdXFnk9e+3qFDI/lyZPV81qBlASludY4RnxowBIsePdmMekVYuB+dESHDgNDdh1wsrpqR87bQNtiECZ1okcCdlH5k/2IlDCDtE8bVH+r9tx/41zMqiapKi4yoF449Q==;7:nUfu2KOQB7R8v+8IsZD5OEwOPdE+5+og6it7qEnGW2tdakeybGypVhO2fGwV/Q1dseOHvRzENHQ0Fakv5fJWvKfO2FG2+Lo4BltO5PSv8cWPwgVK8xG9aDkdSja1nvVMJE0Jd58vtbgZ6iGxfQNBlA==
x-ms-office365-filtering-correlation-id: 3525c0df-f1c8-4c06-322a-08d67cd87e67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4903;
x-ms-traffictypediagnostic: BYAPR04MB4903:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB49036CD51DDEE58A57FB12E9869C0@BYAPR04MB4903.namprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(51914003)(199004)(106356001)(105586002)(25786009)(72206003)(478600001)(476003)(11346002)(486006)(446003)(33656002)(4326008)(9686003)(71190400001)(71200400001)(66066001)(229853002)(55016002)(6436002)(8936002)(74316002)(8676002)(256004)(305945005)(53936002)(102836004)(26005)(81166006)(6246003)(97736004)(76176011)(6506007)(3846002)(6116002)(53546011)(186003)(2906002)(7696005)(99286004)(7736002)(68736007)(5660300001)(316002)(110136005)(54906003)(14454004)(81156014)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4903;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UbNxWVoikT8rum2dOno92SUdDscuZD6fTryp+5lwklREJ1fexgQaAJ1fgFL40kvgIU8N/8UzfNH0yxEk9bID2B5kLeSCkZ3raTmIA2bXXs3oFUP56kTRnhQvYlB2UEjGA6yV1hPejd+R/AT8K+BnrgtAwtrG6bjqx0CW85qup0kBtZVIMZBUyOxovbVp8YK7ctsQR+7mebopm3OTfM9uJgAAaT4HAkbkgYZ5MK4yhjnLM+aH1hYtn69Egtw2W+srjiCk9SvsSjypoTDGRahFHwMrlhG43bNru+stOW4pCRQlnN2QrOAOp9RtGZFoqmBwXuQ28zRzfdlmcOuVbHkOShXMzLqFzFUbLp0OIveyxBLcLakze0vPEEQGzjL/g4Q2JyVj0kWfE7JSMZA+aFDAY40wsL2BhVyMKcdYM66iGTU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3525c0df-f1c8-4c06-322a-08d67cd87e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 00:04:19.2604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4903
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Thanks for the test, I actually have a patch for this one, if Christoph and=
 Sagi okay with that I can work on it.
Although, not sure if we want that sort of management code in the target.


From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Johannes Thumshirn <jthumshirn@suse.de>
Sent: Thursday, January 17, 2019 4:59 AM
To: Omar Sandoval
Cc: Linux Block Layer Mailinglist; Linux NVMe Mailinglist; Anthony Iliopoul=
os; Johannes Thumshirn
Subject: [PATCH blktests 2/2] nvme: test resize of a namespace with file-ba=
cked ns
=A0=20
=20
Test resizing of a NVMe namespace by creating a file backed namespace over
nvme-loop with 1G size, connecting to it and then resizing it to 2G.

Check if /proc/partitions and blkdev --getsz $DEVICE see the updated size.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
=A0tests/nvme/029=A0=A0=A0=A0 | 67 ++++++++++++++++++++++++++++++++++++++++=
++++++++++++++
=A0tests/nvme/029.out | 10 ++++++++
=A02 files changed, 77 insertions(+)
=A0create mode 100755 tests/nvme/029
=A0create mode 100644 tests/nvme/029.out

diff --git a/tests/nvme/029 b/tests/nvme/029
new file mode 100755
index 000000000000..8c94af039d0f
--- /dev/null
+++ b/tests/nvme/029
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2019 Johannes Thumshirn
+#
+# Test resize of a namespace with file-backed ns
+
+. tests/nvme/rc
+
+DESCRIPTION=3D"test resize of a namespace with file-backed ns"
+QUICK=3D1
+
+requires() {
+=A0=A0=A0=A0=A0=A0 _have_program nvme && _have_modules loop nvme-loop nvme=
t && \
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _have_configfs
do we really need loop module here ?
also missinghave_program blockdev ?
+}
+
+test() {
+=A0=A0=A0=A0=A0=A0 echo "Running ${TEST_NAME}"
+
+=A0=A0=A0=A0=A0=A0 modprobe nvmet
+=A0=A0=A0=A0=A0=A0 modprobe nvme-loop
+
+=A0=A0=A0=A0=A0=A0 local port
+=A0=A0=A0=A0=A0=A0 local nvmedev
+=A0=A0=A0=A0=A0=A0 local namespace
+=A0=A0=A0=A0=A0=A0 local file_path=3D"$TMPDIR/img"
+=A0=A0=A0=A0=A0=A0 local subsys_name=3D"blktests-subsystem-1"
+
+=A0=A0=A0=A0=A0=A0 truncate -s 1G "${file_path}"
+
+=A0=A0=A0=A0=A0=A0 _create_nvmet_subsystem "${subsys_name}" "${file_path}"=
 \
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "91fdba0d-f87b-4c25-b80f-db7be1=
418b9e"
+=A0=A0=A0=A0=A0=A0 port=3D"$(_create_nvmet_port "loop")"
+=A0=A0=A0=A0=A0=A0 _add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+=A0=A0=A0=A0=A0=A0 nvme connect -t loop -n "${subsys_name}"
+
+=A0=A0=A0=A0=A0=A0 nvmedev=3D"$(_find_nvme_loop_dev)"
+=A0=A0=A0=A0=A0=A0 namespace=3D"${nvmedev}n1"
+=A0=A0=A0=A0=A0=A0 cat "/sys/block/${namespace}/uuid"
+=A0=A0=A0=A0=A0=A0 cat "/sys/block/${namespace}/wwid"
+
+=A0=A0=A0=A0=A0=A0 cat /proc/partitions | grep ${namespace} | awk '{ print=
 $3 }'
+=A0=A0=A0=A0=A0=A0 blockdev --getsz /dev/${namespace}
+
+=A0=A0=A0=A0=A0=A0 echo "Resizing"
+=A0=A0=A0=A0=A0=A0 truncate -s +1G "${file_path}"
+=A0=A0=A0=A0=A0=A0 printf 0 > ${NVMET_CFS}/subsystems/${subsys_name}/names=
paces/1/enable
+=A0=A0=A0=A0=A0=A0 printf 1 > ${NVMET_CFS}/subsystems/${subsys_name}/names=
paces/1/enable
+=A0=A0=A0=A0=A0=A0 sleep 1
+
+=A0=A0=A0=A0=A0=A0 cat /proc/partitions | grep ${namespace} | awk '{ print=
 $3 }'
+=A0=A0=A0=A0=A0=A0 blockdev --getsz /dev/${namespace}
+
+=A0=A0=A0=A0=A0=A0 nvme disconnect -n "${subsys_name}"
+
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_subsystem_from_port "${port}" "${subsys_n=
ame}"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_subsystem "${subsys_name}"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_port "${port}"
+
+=A0=A0=A0=A0=A0=A0 rm -f "${file_path}"
+
+=A0=A0=A0=A0=A0=A0 modprobe -r nvme-loop
+=A0=A0=A0=A0=A0=A0 modprobe -r nvmet
+
+=A0=A0=A0=A0=A0=A0 echo "Test complete"
+}
diff --git a/tests/nvme/029.out b/tests/nvme/029.out
new file mode 100644
index 000000000000..e9571c7c9300
--- /dev/null
+++ b/tests/nvme/029.out
@@ -0,0 +1,10 @@
+Running nvme/029
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+1048576
+2097152
+Resizing
+2097152
+4194304
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
--=20
2.16.4

    =
