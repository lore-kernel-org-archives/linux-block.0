Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE4C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 05:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CDD20657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 05:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WdzdOlgv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ohIMbYqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAQFPx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:15:53 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27538 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfAQFPx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 00:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547702152; x=1579238152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p8XsAi6fQ0Qox/eH/k/wSRmwws0lf2cJnbfZj8snA6U=;
  b=WdzdOlgvGXvGkAbd53JHCqzBQLLu0PpGDTaDRnVpdtvKKfS9tDNggraj
   hTNQfYd5+WoJD0vCtxoG8R5xKyVsVcy+ZoYRiNpmT0tz7anD4LzMi71na
   Xjjvb5JjoiesLhuaHYPkIQgsptTeuYWgcivcK3zyfWWeAgovC3KbvTqnR
   X+Lnv+ynJQYQQfru/jUhiVHygwaDCQ1oK37FVejrmqVZYYjvIYadWimQq
   YbfZwvVUBnRCL+AvIVVt6SvILNTSG5gGGRxsIMVvE/uwAvtpK5Iw/nITO
   I5Vl7wh6a5owQ6dWWOCPUuopRqqPPSKCywAa9Pi5JKB6bE3qLOF4NeFrH
   A==;
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="103951074"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2019 13:15:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x93au9AZfsb4iSJLNA3p65vfTNz3SpY4nPtHcby/dJA=;
 b=ohIMbYqNO6fd82XpOxrLGZo/CDrELmb3H4TBWD7S6/hJxtvUMERmhcG9QNHis/agMNbYomlNi/9CmT1dYPjA/JL600IItmX++axTo5Bi1+3DAZMAl4UD4xmwoFxaLCqoIKmzAzf5wZRp+At7L3bWQAeeGoJ/dpSAMXcrkL5W2fw=
Received: from BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) by
 BYAPR04MB5061.namprd04.prod.outlook.com (52.135.235.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Thu, 17 Jan 2019 05:15:49 +0000
Received: from BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667]) by BYAPR04MB4502.namprd04.prod.outlook.com
 ([fe80::11c:b9cd:4076:a667%3]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 05:15:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH blktests v2 00/16] Implement zoned block device support
Thread-Topic: [PATCH blktests v2 00/16] Implement zoned block device support
Thread-Index: AQHUqMgdIOGMm3d8ckOMa2tQ+r7KLqWyw6yAgAAwXgk=
Date:   Thu, 17 Jan 2019 05:15:48 +0000
Message-ID: <BYAPR04MB450277D982706B476DB56D3E86830@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>,<20190117021613.GB25494@vader>
In-Reply-To: <20190117021613.GB25494@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5061;6:Se1hoq4nppZUKNHgx74chfxC0siMXIVCsePS7m3lFKXShVLrxo8CJy2azqkQgadjLdQNtg9MdcTJYgl2z75XOznPrIbSx7qDl/jLqkqcEfDZn24eFpdm+gDNXrOdgGw0ZWF5u+MCVnL3tNzGT/+vxSEIJxEyUWoWAM3YAyPHpeoRlniMk28xom1f3LseAVxLThnABOfR8rmkjEWUaDF17Dz/ZBcbWBGmQDkzRykvQhbpG1U8z/Qo9Zp6aRBg/ku3VhvfrHbkJGxz4aUMmwq3majLAsaPKJlqK89Y7hXlW4IEbm6L4Nk9nvHwSinYjeush5P4McVZajxT5SIwf3KP2TJq1qnv7eVXOhm2xmFBbHDXVrJ0V3UXKlQbUDfR8LEyY/BjSJb5ZTfsWQSEfqhDbwR0KySSC2w21nocq0etQY8UA3JVn2OJ3BVgCVAzg+qua7V1EWxp646EX6Dw5Rrbgw==;5:iwjR0gZUoowqtULHRPq5Ij4pathWtj9gqS2gH9PcOtL36lRdE6nrlwpKGGVMjxUjJ+quIvaycWEZzoN0N6wbOzFUDUysTweHXdteB8WgwQBoBG2Z/fPWRROvULQkvpq653m8NwRrbnzAaMLEk052lQOYKX/1/Hi20DijB6HnRYaKPDluo8gXHdIlgHQoP8WrzXPr/6KyCjGv7C7QT0Cgxg==;7:AQztzM1L5Qw8fsZQ1Q9f7tohZ1fetDhy3hhZ2Fkok2BmjcRTrj8opuAZs3RC/5IvxQkt1/lvD/lDJXi2u+6YMyOsIBX+XloGbPyCF41L6Dnk70WJtdPME1whalqviyhzcd7K0K+D538qQSZEbcemaw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 90f623bf-5921-4609-122d-08d67c3ad7d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5061;
x-ms-traffictypediagnostic: BYAPR04MB5061:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5061AD83175EF87A59B6771086830@BYAPR04MB5061.namprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(6506007)(5660300001)(68736007)(55016002)(486006)(72206003)(14454004)(478600001)(6436002)(26005)(3846002)(6116002)(53546011)(7696005)(6636002)(99286004)(76176011)(8676002)(305945005)(7736002)(2906002)(81156014)(8936002)(186003)(97736004)(81166006)(54906003)(229853002)(110136005)(316002)(71200400001)(106356001)(105586002)(71190400001)(25786009)(4326008)(446003)(74316002)(53936002)(86362001)(11346002)(6246003)(66066001)(476003)(9686003)(33656002)(102836004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5061;H:BYAPR04MB4502.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aKF8AQxk2UiB+XQbhThl+qlPR/BG0bb3ssYwBKWej1AuylhNhEs/hPRd8O2TwKRH9JzIDbaXI7nLTctJKICI5kQiswnlziV+9G/bs1vUjgeiOWyYFN+lCpzYrzH4E2WQ5fgoLhW6X2gDo9Kd6p/5+0N/5H0FsV5e5tP7KAbxlzRuQkfmasCjcq56YnfVeNVSbOSks0RQwAIHTi6KHa2icLAFm3+TX81/hBfsNx8eYb2eUlXQIV67bGnTAlTfrVkPGD0yK8xRiUFgLnfVlPhJhlIGZE9dlMeDxiJd2PfDVZzVwJz1X5vAUiLYrIuLoE+MlsQaMAAD4fAqJRzunoBoS0SThBw0JpSTBsIbGprUYAJxuxxZuffDXqcCjmzfWWBxP98LQV1K/QhDjUelUV+248WjJnaamlheBJIACjWB7fs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f623bf-5921-4609-122d-08d67c3ad7d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 05:15:48.6309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5061
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org






From: Omar Sandoval <osandov@osandov.com>
Sent: Wednesday, January 16, 2019 6:16 PM
To: Shinichiro Kawasaki
Cc: linux-block@vger.kernel.org; Omar Sandoval; Masato Suzuki; Jens Axboe; =
Matias Bjorling; Hannes Reinecke; Mike Snitzer; Martin K . Petersen; Chaita=
nya Kulkarni
Subject: Re: [PATCH blktests v2 00/16] Implement zoned block device support
=A0=20
=20
On Thu, Jan 10, 2019 at 06:37:09PM +0900, Shin'ichiro Kawasaki wrote:
> The current blktests infrastucture and test cases do not support zoned bl=
ock
> devices and no specific test cases exist to test these block devices spec=
ial
> features (zone report and reset, sequential write constraint). This patch=
 series
> implement this missing support.
>=20
> The series addresses two aspects: the first 7 patches introduce changes t=
o the
> common scripts and configuration are introduced to allow existing test ca=
ses to
> run against a null_blk device with zone mode enabled (new ZONED config va=
riable)
> or for these test cases to be skipped if a test declare itself as not zon=
ed
> compliant. Helper functions are introduced to facilitate checking a devic=
e
> zone model.
>=20
> The second part, composed of the last 9 patches, introduce the new zbd te=
st
> group to cover zoned block device specific test cases. All these test cas=
es are
> implemented using the test_device() function so that target devices can b=
e
> specified in the TEST_DEVS config variable, to cover a variety of zoned b=
lock
> devices: physical real drives, partitions and dm-linear setups on top of =
zoned
> block devices, etc. Furthermore, using the infrastructure changes of the =
first
> part, the TEST_DEVS definition can be left empty, resulting in the zbd te=
st
> cases to be run against an automatically created null_blk device with zon=
ed
> mode enabled.
>=20
> 5 test cases are added to the new zbd test group to check the kernel ioct=
l and
> sysfs interface, zone report operation, zone reset and write command hand=
ling.
> These tests are simple but only a start. We will in the future send more =
test
> cases to cover at least the regressions and bugs found and fixed in the z=
oned
> block device code since its introduction with kernel 4.10.
>=20
> Another still to be added part is support for host-managed ZBC emulation =
in
> scsi-debug to further improve test coverage without requiring a physical =
SMR
> disk. This work is ongoing and will be added to blktests once the relevan=
t
> scsi-debug changes are accepted in the kernel.
>=20
> Changes from v1:
> * Fixed _test_dev_is_zoned
> * Added _have_fio_zbd_zonemode
> * Added patch 10 to move _dd to common/rc
> * Addressed various nit commented on the list
>=20
> Masato Suzuki (6):
>=A0=A0 tests: Introduce zbd test group
>=A0=A0 zbd/001: sysfs and ioctl consistency test
>=A0=A0 zbd/002: report zone test
>=A0=A0 zbd/003: Test sequential zones reset
>=A0=A0 zbd/004: Check write split accross sequential zones
>=A0=A0 zbd/005: Test write ordering
>=20
> Shin'ichiro Kawasaki (10):
>=A0=A0 config: Introduce ZONED variable
>=A0=A0 common: Introduce _test_dev_is_zoned() helper function
>=A0=A0 common: Move set_scheduler() function definition
>=A0=A0 common: Introduce _have_fio_zbd_zonemode() helper function
>=A0=A0 block/004: Adjust fio conditions for zoned block device
>=A0=A0 block/013: Skip for zoned block devices
>=A0=A0 block/018,024: Skip when ZONED is set
>=A0=A0 check: Introduce group_exit() function
>=A0=A0 src: Introduce zbdioctl program
>=A0=A0 common: Introduce _dd() helper function

Hi,

Thanks so much for the contribution. It'll be great to have some tests
for zoned block devices.

One thing I'm not a huge fan of is that setting the ZONED mode hijacks
the existing tests to be ZBD tests. When I'm doing a full test run, I'd
like to run those tests in both modes without running the rest of the
test suite twice.

Instead, what if we added a per-test setting like CAN_BE_ZONED and a
global config RUN_ZONED_TESTS? If those are both set, we run it once in
normal mode and once in zoned mode. This also avoids having to blacklist
tests which don't support zoned mode (although we'll have to remember to
whitelist tests that would work on a zoned device).

The functionality for falling back to null_blk if no devices are
specified is nifty. It'd be nice to have that as generic functionality
instead of specific to the zbd group. Something like a per-test
fallback_device() function which sets up the fallback test device. It'd
probably also need a cleanup_fallback_device().


[CK] Sounds good to me, we can make this as a prep patch-series and use the
functionality for this series.


I wonder will that be applicable to all the test cases?
Do we need more generic functionality into the null_blk so that we can use =
null_blk
by default?=A0


Shinichiro what do you think about this?

Let me know your thoughts.

Thanks!
    =
