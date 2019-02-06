Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CBC169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 05:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633C2218A1
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 05:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="POG+gGpG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="na2yAH6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbfBFFVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:21:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24117 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFFVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 00:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549430552; x=1580966552;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=1LcAnLtwpzJZL6LIlaHCc4wvSzMdoo9JM1/tVbU3k/Y=;
  b=POG+gGpGXzt20Jh5ntwLZ22YJGajVTM0MwKLLVPThDg6oQTw0jQ2ym9k
   NxNRSjv7kZleKzju//Xi1Ecohe2GXgO9BM+7ZdCIVTrFwjRpJ9MJ30iVS
   t+O2/gP2k73s5zKfWa6mWtm7xSPFZ7Gd0CwU4NEcesG0QZR13L6A4JrK5
   kqXYGEMgxNFdSSFTE2kXxVqsTTPuDfopUjnZwawZn8XAf19LPBxipDadQ
   6OzDKCCa0rfHmWUKWE5T6zXWkdAGbonretkEqjC9dd3aokbpbi4442KdY
   EaZY9z9K1v5BcLQbJ9oJzLmgIVz861LAYhDeJvJei/jTDCzPOsa5JBh3G
   g==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="198757089"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2019 13:22:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2ZFSvejAH8LL6QhLTPXES6PwvDPfZYNSZsZbTmqI2g=;
 b=na2yAH6ir5wrd/E3AtmXoVWoA7so3ntbpfqPkwce1PaW17B8vzyCI/EUtJtyURGWGsA443+pyXTCCvS3G9jFN485/21/t3EaSXqcsKgS9nrAOu1TKQ2wV8wtnh4rtlLfYl9ceCWFXm9rFP909b6/mh0Ysmf+j5DmI3txIQBFzNc=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB4471.namprd04.prod.outlook.com (52.135.237.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 05:21:40 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::f827:c296:5af6:c2f7%5]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 05:21:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "hch@infradead.org" <hch@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "tytso@mit.edu" <tytso@mit.edu>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [LSF/MM TOPIC] : blktests: status, an expansion plan for the storage
 stack test framework
Thread-Topic: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
Thread-Index: AQHUvdXi8uW0z5RC40K0A2uBHEuuMg==
Date:   Wed, 6 Feb 2019 05:21:40 +0000
Message-ID: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB4471;6:iio1/QyUWlKlQWJrzR+LaFFEOGlm6U5NT6DTw3ZYt9giMdz87+5KAabpfYYdUKZKcHJzErLsMJq4x+8MkXtwRTWqg7uVQvQ65iL4csFpWhVBQEOXmvD/1Bjr3Po9txnfAtPgHzsIZP+ezIGtzeKfQKTzl1vc2qYXicC2HBgqm3G2JzApWV4XZmWeuLNYtp9qmVTUp00ZDX7U/Qwj4nbTeWt5Tm6lgGXofT0Y6S4cROQV3VwKEzMjYFfjo4KAESOVf4p3YEA3DxqnpNAzBorAyfA69f4+wEuHgkVdtJqqllaxnoPUL9y0qWlvoPX8fRuBj+hfecvAbuDfArd9/S0zf1aGEameB3P83gVlFN9CAdJwsgGH6BPuS1bwDQ2ceYM3Av1MzqGFCyZfdaWsB2X0GYTA1/VeOHEvDjLUGM5ZeRsaYam8xlW2UKdEIMEvq95WRU3LWjnWUpKiWmtCjNVpkg==;5:XTJfu9niR6ali+vukSe0hL7elylYmWddvZ2xvY66x1LX4NJrbVKBmwmUUiy10OV0WikGh9PlMYiAJa83HUOTJoEzhrQrcJCsHmQG0nzUW9ckwNqMS4h/MNFvhZwjmeINEiyoSdDPGN/sNkP335BF3edNytFlCnhgp3K/GkfTs/yL4vu1/Qpe5OSQeC20YCNBSXx1Gjv6rP9aA2mmqfavvw==;7:tDPgzNSc5KHtl+3oXkymvDmaDNXOF0thhzRfkxKnsg27TJh7hkpsYHOHj9qB9qnpwH/s4AyhdTLUaUKMFGEBFqADCwVXx04XPmgFxn1/vIbbTtglhAVowRAR2XAwHbyX9kjhjjUMuq7lkYaYSJyWFw==
x-ms-office365-filtering-correlation-id: 941809fe-0cce-49b6-371c-08d68bf2f9ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4471;
x-ms-traffictypediagnostic: BYAPR04MB4471:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB44712DA7B3181C4875C07383866F0@BYAPR04MB4471.namprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(45074003)(71200400001)(6506007)(7696005)(7416002)(4326008)(6436002)(5640700003)(102836004)(25786009)(74316002)(305945005)(105586002)(33656002)(2351001)(71190400001)(14444005)(256004)(7736002)(106356001)(9686003)(6306002)(53936002)(97736004)(55016002)(478600001)(86362001)(316002)(476003)(2501003)(68736007)(54906003)(72206003)(966005)(81156014)(99286004)(486006)(2906002)(14454004)(6916009)(8676002)(6116002)(3846002)(26005)(81166006)(66066001)(186003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4471;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SD3psOT0V85mQOqZ1Vp3z776rdPTREIxnjIhoMarE3eos7JYIjnwy4Y64BdXOedO3X8Es1Dga+6y1fQOgzcA7ytt4D9pTgPQEnWNIG3Y2CJvuDNy8rKVOsHoJp//fGSfB+tA3Q6vTSaovDO/z/uNkVnjxpHrpgF9pGzWaYfKZqQYlbkuLx3Lsc8TghUhN+FQ5CtxWZB/edLZDTnMWh/4ZDPMzyfC6gTHBRQW0w0lVk6WskNEYYzA5GF1mbvAj+cMlGFTKUlLVDGcNTRBulAYzU11gIL0ZRF1fEKJNLa5MoXkPYX90E9CzxqdqzsYV259pTLboTFR5p+cHsutQiW1jcwy1b7Isol6QgEabjaH/oaWkop8puDEyOnxAAHBo6D0EBIAKM1zOcL2FeLgkOPZsFkQW6EmEbzz5+Z2zwx15RM=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941809fe-0cce-49b6-371c-08d68bf2f9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 05:21:40.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4471
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since discussion of the storage stack and device driver at the LSFMM 2017
(https://lwn.net/Articles/717699/),  Omar Sandoval introduced a new framewo=
rk
"blktests" dedicated for Linux Kernel Block layer testing.
(https://lwn.net/Articles/722785/, https://github.com/osandov/blktests).
=20
As Linux Kernel Block layer is central to the various file systems and unde=
rlying
low-level device drivers it is important to have a centralized testing fram=
ework and
make sure it grows with the latest block layer changed which are being adde=
d based
on the different device features from different device types
(e.g. NVMe devices with Zoned Namespace support).

Since then blktests has grown and became go-to framework where we have inte=
grated
different stand-alone test suites like SRP-tests, NVMFTESTS, NVMe Multipath=
 tests,
zone block device tests, into one central framework, which has made an over=
all block layer
testing and development much easier than having to configure and execute di=
fferent
test cases for each kernel release for different subsystems such as FS, NVM=
e,
Zone Block devices, etc).=20

Here is the list of the existing test categories:-

=86=80=80 block=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A28 Tests
=86=80=80 loop=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A07 Tests
=86=80=80 meta=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A 12 Tests
=86=80=80 nbd=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A 02 Tests
=86=80=80 nvme=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A28 Tests
=86=80=80 nvmeof-mp=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A 12 Tests
=86=80=80 scsi=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A 06 Tests
=86=80=80 srp=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A =9A13 Tests
=84=80=80 zbd=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A 05 Tests
----------------------------------------------------------------=20
           9 Categories=9A =9A =9A =9A =9A =9A =9A               ~110 Tests

This project has gathered much attention and storage stack community is act=
ively
participating and adding new test cases with different categories to the fr=
amework.=20

For storage track, we would like to propose a session dedicated to blktests=
. It is a great
opportunity for the storage developers to gather and have a discussion abou=
t:-

1. Current status of the blktests framework.
2. Any new/missing features that we want to add in the blktests.
3. Any new kernel features that could be used to make testing easier?
E.g. Implementing new features in the null_blk.c in order to have device
independent complete test coverage. (e.g. adding discard command for null_b=
lk or any
other specific REQ_OP). Discussion about having any new tracepoint events i=
n the block layer.
4. Any new test cases/categories which are lacking in the blktests framewor=
k.
=20
Regards,
Chaitanya=
