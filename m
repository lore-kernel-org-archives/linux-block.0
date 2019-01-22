Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C335CC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731FB20823
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ijKbPXYf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B+v51N7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfAVS1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:27:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54732 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfAVS1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 13:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548181629; x=1579717629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hv9zgs/jHA1RXgORfIFc9jthxJUK9Jb6S+YUg1VMDtg=;
  b=ijKbPXYfXFNOznkTUkc6W2g6mU76GVXRA2gcUbeNgDKHDrK5MmvZZLEb
   slNuRSLdB/PBonC5u+aCS16H9OsaCdoGtPnnZ57nw35eTcgHLoTwNCG8v
   Y5E6mfRo0TriXhRwOEzxYGQvRiY3boA1dKMjuqRNKy0g+Gbn4uzgkyGtb
   cFsHGmJz4gk66hircKU/837I7iK/X0ajAGRAuE1RnXrvcVApyB8ytv2nq
   Ms5vev+mXpA4vF8+8tqL8JgikUB+9xp/lhEdzy1h0+DVZBrng3GhFaLHK
   dR20Txp8vjLaS0icXz3bhKArCygtR6dKOxuQL2XCzbIgkEOVL/y5bL8Qn
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,507,1539619200"; 
   d="scan'208";a="100731468"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2019 02:27:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMw8PSSZwxS8C1Fi+qWZ5FLsIjj1FXjP3YpjPSsDEd0=;
 b=B+v51N7XoSMPGOhy4N9SIihKamNYvDKa86Y9tDJC6FoYIOw+oKu0NsEttkAHArvez44JGAeYowHuTWiv0CagvcakxYEytTDO0UbfgEDMHb6pV00pU7i0uu+FaDs7lq+SialBNLd8Ia9++mO1vPtkvGux3vlFaktBMw9614RHBq0=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4293.namprd04.prod.outlook.com (20.176.251.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 18:27:06 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 18:27:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Omar Sandoval <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] loop: Add test for changing capacity when filesystem
 is mounted
Thread-Topic: [PATCH v2] loop: Add test for changing capacity when filesystem
 is mounted
Thread-Index: AQHUsYEmFriazCBikEW/lyv/+NDV8aW7nLUS
Date:   Tue, 22 Jan 2019 18:27:06 +0000
Message-ID: <BYAPR04MB45024986E0179C64C80F1DA186980@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190121120203.13644-1-jack@suse.cz>
In-Reply-To: <20190121120203.13644-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4293;6:Q3icEGD0bedErIGonxuMmet0XFyp5oE1/NIBwvc3afKaLn4nms+niPALdNxROddXsYR/+9Z8nfYXCX+piWSQyUzzdNxOrKeHedP9evOwZfJKdhsLVPm2z7MRGtKKKRwDh2izK9EJy1FOl21pFuB/2EefclVoHDi2tYR1fJjolea3kp29vNIcHQoI7x2jWrQZqdNpmiYZ2f45qLd9mGb8hZKObKWkyOrsvhuPyZ3Rvibvv4jW0c4A/aw/FAWB17Rhms5dYsV55SiQcPq3SF4xEQXA1v/ngLme1Y3llt/7EgV2wNKLqkkc5LeCZBeQW6mGDQ8Q2tTz2Y+lUQi9TUgxzZ/e0yO1Zeq/3sR+03cVyRykIrM1PCoyDKuImWiXZO/nSjUxNGIE2Z3E8aezysVm1ZuzC+XdCOFNIP6ls57XEfnORAbQesX3AbwDtxCkcMW4W7Aafl8P7pcX15CH6HXNGA==;5:ME7CRgzwvo8cBvPftagG9fnopeC7udmcQqqLIt5XbCSA88qN+tCbRds5gQSbhgDtz4PyQd48RfSPY8Cl+OfwNDoe3nqHUvp0XMgo6YHy4Rr1bwwWugn3X5wddzjorHohZL/eOL85r5cBdFCuJV7ey8jpnczXaa28Baac0L1Yk2ndPVpenvsHteRQNIqjYImhgXubzhFtUwlcfYHjxoc5qw==;7:kbbPgmzjxaAw8CneMfPubSKayfoms01AUJAgzpDtCuc2ld+kcZq0NBR7NehhxpGKBYHXFLrKDPRBac5KX+emoyVkMsZVqm3XBrxy0zqeq0+lnRzJ+BoHp/zVe9PR8Yt5nN/tEcAvT4t/6Y9yArnLHQ==
x-ms-office365-filtering-correlation-id: 852ead56-9290-477b-fd4c-08d6809736bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4293;
x-ms-traffictypediagnostic: BYAPR04MB4293:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4293843252338AA454D7221186980@BYAPR04MB4293.namprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(86362001)(229853002)(305945005)(6116002)(74316002)(3846002)(55016002)(6436002)(316002)(81166006)(72206003)(110136005)(8936002)(68736007)(478600001)(2906002)(14454004)(81156014)(8676002)(7736002)(66066001)(105586002)(99286004)(106356001)(53546011)(6506007)(26005)(186003)(476003)(446003)(6246003)(102836004)(25786009)(7696005)(9686003)(11346002)(33656002)(76176011)(53936002)(256004)(14444005)(486006)(4326008)(97736004)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4293;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZOus7Okv4tPL/YfZGB5J4iIoTwHaQXIMTaXmIDtygDgVEnXcAUXMF23HVEi+v+DMAsdo8ickiNh4vsFbBxVnMNnw/Yfs+UlGeKMtc935k8n9jcqRWTk+k1+8ZYq2O8UbWYW2rxyg851kPVAumrunh9VscDfh5UMcOLt5KOLbrVa8KEtV1820Z93DdN78r/tXZvZefjOEiwOzD8UvvrOO4dEK0N91E5Xyh5ZgGnJ34bDp6YxVAxuCbutQmcvPqHAn2CPhwuqPNph3Hho9VmKHXjXc0Myh6lIypyPzQAyzEI5UfqJRpLN36tNAIP8+UjcRDL17u7/tCrV1T0TelGijGxOpSfM2syrRmAzYebmphZL8Tb/lB2BHzFGE0MD4oMlamRXA5x3e07XRXlqVP4Uqcn/YQn/zqmMxcIB4uuabs0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852ead56-9290-477b-fd4c-08d6809736bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 18:27:06.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4293
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.

Reviewed-by:- Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>.




From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Jan Kara <jack@suse.cz>
Sent: Monday, January 21, 2019 4:02 AM
To: Omar Sandoval
Cc: linux-block@vger.kernel.org; Jan Kara
Subject: [PATCH v2] loop: Add test for changing capacity when filesystem is=
 mounted
=A0=20
=20
Add test for changing capacity of a loop device when a filesystem with
non-default block size is mounted on it. This is a regression test for
"blockdev: Fix livelocks on loop device".

Signed-off-by: Jan Kara <jack@suse.cz>
---
=A0tests/loop/007=A0=A0=A0=A0 | 39 +++++++++++++++++++++++++++++++++++++++
=A0tests/loop/007.out |=A0 2 ++
=A02 files changed, 41 insertions(+)
=A0create mode 100755 tests/loop/007
=A0create mode 100644 tests/loop/007.out

diff --git a/tests/loop/007 b/tests/loop/007
new file mode 100755
index 000000000000..97e6468de4e5
--- /dev/null
+++ b/tests/loop/007
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Jan Kara
+#
+# Test loop device capacity change handling with filesystem mounted on top=
.
+#
+# Regression test for commit 04906b2f542c "blockdev: Fix livelocks on loop
+# device".
+#
+
+. tests/loop/rc
+
+DESCRIPTION=3D"update loop device capacity with filesystem"
+
+QUICK=3D1
+
+requires() {
+=A0=A0=A0=A0=A0=A0 _have_program mkfs.ext4
+}
+
+test() {
+=A0=A0=A0=A0=A0=A0 echo "Running ${TEST_NAME}"
+
+=A0=A0=A0=A0=A0=A0 local mount_dir=3D"/mnt/blktests/"
+
+=A0=A0=A0=A0=A0=A0 truncate -s 1G "$TMPDIR/img"
+=A0=A0=A0=A0=A0=A0 mkdir -p "$mount_dir"
+=A0=A0=A0=A0=A0=A0 local loop_device=3D"$(losetup -P -f --show "$TMPDIR/im=
g")"
+=A0=A0=A0=A0=A0=A0 mkfs.ext4 -b 1024 "$loop_device" &>/dev/null
+=A0=A0=A0=A0=A0=A0 mount -t ext4 "$loop_device" "$mount_dir"
+=A0=A0=A0=A0=A0=A0 losetup -c "$loop_device"
+=A0=A0=A0=A0=A0=A0 # This hangs if rereading capacity changed block size
+=A0=A0=A0=A0=A0=A0 ls -l "$mount_dir" >/dev/null
+=A0=A0=A0=A0=A0=A0 umount "$mount_dir"
+=A0=A0=A0=A0=A0=A0 losetup -d "$loop_device"
+=A0=A0=A0=A0=A0=A0 rm -fr "$mount_dir" "$TMPDIR/img"
+
+=A0=A0=A0=A0=A0=A0 echo "Test complete"
+}
diff --git a/tests/loop/007.out b/tests/loop/007.out
new file mode 100644
index 000000000000..32752934d48a
--- /dev/null
+++ b/tests/loop/007.out
@@ -0,0 +1,2 @@
+Running loop/007
+Test complete
--=20
2.16.4

    =
