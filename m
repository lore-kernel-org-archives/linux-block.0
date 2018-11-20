Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA13C43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 06:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E538208E3
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 06:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XI5eMHIj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PDwM7w9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E538208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeKTQfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 11:35:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49516 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKTQfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 11:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542694208; x=1574230208;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Ks/2qmyGd2xWq0onni1YsxNsUKbeEy1t2acgGxFIRnA=;
  b=XI5eMHIj+jPepwl+J5tAkR56z0onc/Y8FZkG/H12wC5qfnqdNjOv2uqH
   z8JotATobZ10IUw7ZUISQm+9ruQjP5zAOBbHBOTE4hamRz/H1i2r4ZThI
   ltRIaeoQt5+GJiIO7g8EXD+s2O1zNmWiznf+zadwVJbkHxZBwgIQfeoYd
   HSgSs/F0TG4i+NDzDxb6HGZFMQUw6sR2mUhqrR6Ql9qtqU4A2/Ygj3NSh
   CliJQfQ7YHkVTMOAzu0k/Ur5nsvZIyuppTCUMXldm6DQiZNs4F08+duQg
   MLV5M7dK/dJ9ftVxxhrGkZF/DOrSosjaXa4/Hxrn4aWOyFA2GLIY1CaaL
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="192461408"
Received: from mail-bn3nam04lp0111.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.111])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 14:09:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZwoPUl/GmyjzL5U1m1A22AymBOhfhuc76/g0IqoMrU=;
 b=PDwM7w9xqnl7Eqbq9VeNXPySa+zfFWCuQOMcFW4WHXw/r70McyrQNxrpqAXs9MosFC8qWvlm/WNTVA4JtG/sWXYkIgdBGUhJrEFdJ13qyXWkGrEni1HPe2MuprhOt4+/zxErly3nBL1D0IZdeSgqFcJoI0kRs1XmVerHT0Ix4tU=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1172.namprd04.prod.outlook.com (10.160.155.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.45; Tue, 20 Nov 2018 06:07:48 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 06:07:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: RFC: REQ_PRIO use
Thread-Topic: REQ_PRIO use
Thread-Index: AQHUgJdc+B28J8KGhUuvN21lz39tNA==
Date:   Tue, 20 Nov 2018 06:07:48 +0000
Message-ID: <BN3PR0401MB1640F33FA8F3FFF251DF8266E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1172;6:YA3PNZl4e2s1iwkI1BaaJHEP9kaalc0OKHWpx3UVAhXbgEFtTJQWoVhGJ5iv7iU8gAjuhGEZo+tmct94JuCo4CU5YakP6cl7uK5bPEDIkmeMnwmY7pTJnLmBfWJJbHEYUo1gPY1uZ6o+CgbnKvxzAtyAU+j6xDNMqDwzhNIRY0c6B0PhCCWORh0Q9wukzzygUlleJOFXKAqrhK8r0/QNrbcbCHeexxyVQJgqbHLkuD8wAh537hkJzCcnAn0Sn/2wT4ZCkrmfGzBlc+8t3FnJcEPoTJuMBTAmT8cm+zBIuIfwfR8HksyPweqqPCdK+q/JicdMJQP51XSZf5CzRDXeF1plj6wTfQYZON5JLJAkXvNv1Ha7S7EfS2gjs0DzVK/2ruBQKrfFSgKfQrjLZ8slkD5S6BuZfMcTcPmLAAb98Nukbo+BlZ4y0rCaMlZbkFZOGULfbjilGOQyTy2x0gKzwA==;5:vdN8X5T5MPXjQC2pwsCU4aEW4DPi1IjnC/7L6imXtgrKCNTNEx/U/mSAMuNSjJ2U45106VkAEEY7JgaNYDrADn5V6EqWRKAg+QgmKgaM2pJUjuYKyKwTOucDy1wmDNoXtvZQPv0yfLQzgF6xTjiJwpR6sCJ6ls2KQCnU2EwUX4A=;7:9qJ4PG8tmfXz5ZX7bAycTIEd/nAWQPBFSHZjRjrYC2SdDW7Kv/5cYyq/W0gsdUHmRzjuOVHTm9kIx+RYf1k7YDgnw/VHmvyXJSEjHya4c3yReVy2CYZrnnXMGXfIK9Invb9TXPrxxUyEaUMbyO+yHg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a843e04-fb06-4436-f934-08d64eae7f67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1172;
x-ms-traffictypediagnostic: BN3PR0401MB1172:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1172BDD1A19C236D172E0970E7D90@BN3PR0401MB1172.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1172;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1172;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(26005)(106356001)(105586002)(8936002)(14444005)(256004)(2906002)(74316002)(305945005)(7736002)(33656002)(8676002)(81156014)(81166006)(3846002)(86362001)(6116002)(2201001)(68736007)(66066001)(2900100001)(478600001)(2501003)(25786009)(97736004)(72206003)(53936002)(486006)(476003)(9686003)(55016002)(7696005)(14454004)(99286004)(102836004)(71190400001)(71200400001)(186003)(6506007)(316002)(6436002)(110136005)(5660300001)(7116003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1172;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oVDL6AJikSbwpMyIB/bkr6arygwoB96ZJbsfPr4nin1k1CwYW8Ge6w4vGc+kqKj8xjXc74xzjKiNccogThbR209enGLZWmnMF5xgTIT85LN93jFWL3Wx/g6UiFRnmU5+bzpHjW9EEdnHtV5IcWXqF7bAKlfAJVMeYOY7JGbkAsUazWogCJoWLbD7tgE3OcxkrQ0BUKhqQENsd5wwHyv8lDYZPkgBgLsW2/p2OvWJ3HOtIt+v9RHVe0v0unHR8KNTlvF7It5g9ZidOXGw7bZfnk9iwN+p7r9iK3Wx8zuz95mNEpZxahspG3XdxMxwI4Bj7pjhuEX/jbPucAXl3PQvNiW9SAxiGYwxZlAsMiMBBIE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a843e04-fb06-4436-f934-08d64eae7f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 06:07:48.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1172
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

include/linux/blk_types.h states that REQ_PRIO intended use is to boost a=
=0A=
request priority in cfq:=0A=
=0A=
__REQ_PRIO,             /* boost priority in cfq */=0A=
=0A=
REQ_PRIO is used by different file systems (ext4, btrfs, f2fs, gfs2, erofs)=
 and=0A=
a couple of dm drivers (bcache and dm-zoned), but nobody actually acts on t=
he=0A=
flag being set, certainly not cfq since this scheduler is now gone in 4.21.=
=0A=
=0A=
I think this mandates some cleanups. I can see 2 options:=0A=
1) Have bfq act on this flag=0A=
2) Remove it entirely and replace its use with explicit setting of BIOs pri=
ority=0A=
values, either directly through the struct bio bi_ioprio field or indirectl=
y=0A=
through setting the issuer task contecxt iopriority or eventually by adding=
 a=0A=
bi_ionice field to struct bio. For instance, ext4 sets its journald task co=
ntext=0A=
I/O priority, which result in all BIOs issued by that task to get an explic=
it=0A=
I/O priority value.=0A=
=0A=
If option (2) is the preferred choice, looking at the current use of REQ_PR=
IO,=0A=
removing this flag does not seem difficult at all. In this case, changes by=
 the=0A=
current users to explicitly set BIO I/O priorities can be done later with=
=0A=
different patches.=0A=
=0A=
Comments, thoughts ?=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
