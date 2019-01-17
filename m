Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA8AC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 06:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B3020854
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 06:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qH7FgQ1U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D2xd0As1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfAQGGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:06:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25914 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfAQGGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 01:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547705196; x=1579241196;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5ETg0e6s95Yhk9IqPfab5Vthh8rY0FkvYYFgDC+sw/M=;
  b=qH7FgQ1U37RwjeQkKgfkbPISFy2bwO+MhsNn02iSYYBpIP8aknGQtxRH
   EDlWb0Ybk/LtLbUWNfb0qraB+tJ/MqFGc9OYg3MTd5QX3Rk8uK2CpNj5d
   4xMEeC0EOAgt6qKeLI93c2LA5AbBkqoSC9MTMRqxcoU4f/SD1oN5sZ6jv
   K2V4J9k4j6P9iBwIRGLe1WnyXQOtpeRshmlqPb1fHnQvRBk7lfEJxZbSx
   yPJHnPM0vqdmGkyzUdtp0yIM1qkyN6zSZ6UCZswHDls6hALFJrVetcxlw
   cP1H9gXIdoRaJYjYXO/4q7ajvJ4hHeXOSKsqIapqtFbvBAmv0L6MlHqvJ
   g==;
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="103954168"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2019 14:06:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfpkXfS7NvNBdg5TvcnYKo9SGXXxdM+4xe9t5pKvJP4=;
 b=D2xd0As1qzPWSqytYymYHO1LPRm2S6nG7QkIvFXWHPB2bt8ftNWYQ+A7ctsPed99iC8oTQ8Mt4tvQ36cAB7545a9w/EJEtqiZlxn4Ad71ojHEBaH7YXX4nIcvcmVrYKOr156FqNqidt7PX9y5Ec7xYYUgM3w6Y6vMvfoSK3PseY=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2043.namprd04.prod.outlook.com (10.166.191.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Thu, 17 Jan 2019 06:06:33 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 06:06:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 00/16] Implement zoned block device support
Thread-Topic: [PATCH blktests v2 00/16] Implement zoned block device support
Thread-Index: AQHUqMgdtzP486PU/kucN+F29OugNA==
Date:   Thu, 17 Jan 2019 06:06:33 +0000
Message-ID: <CY1PR04MB2268C2C163B681432138A90CED830@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
 <20190117021613.GB25494@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2043;6:iGABDyOVNZ3PEl/xnVeb+UObBydHnPj+GQEHPz+QbAP+k92xRcBBgNPTx1aTfZRvfNmASPIOp1gL5Mb27z53Zv3mGf5YOdeQUjxLUIkv1dcl6DTJtD4axb4brkzZRmWC8qNVxiZD8EC/9o0coKi8WGralrEekXqzRzLmKuZrctMF3J8MQ94e4S5ur4nXk+DSne8c9Oozm3TpEqDjnxGuOdxCz4lbRyZteMgWZPbXMbBsdbhMqW1iWvQvOjbw9VnMR/8fkvxnY6xWqMZ9XRpZj/F2796zLyGKmX5Ls2gtL9h9i58AaX1h80cdHYZD8nVBC+nx9zT8DkOolLhJubfbd5bobJVlgK7uJp3KN74XQzCEenvg3liBXz8ZLsNIMWq2WtIUoBazkPqZuV3E77JNg6t6bvI1AwJTFDvvJQElS+mVmV7ozb7KqLXEJDG+tS/IlHfJC3dTEWhwrAOBN8qphw==;5:zgs4OkVnWmLbw9Y6mLu/Bi2wS3YYa5aeGf3mZ8GH0nuozsyBiRENAWb0TMEkWQaNhmEtmcjTKpZMFV009F24R7lkI7FotewBChgustnN1siksySJY6CN8QeJZOpQy5RLCriW5xr+W+jsSFZ1RBDGoXuPt7xjvKjbdGK7OapAEcGFOfPoYySLq9ddkgFxh1CIsdAQTAjjFr8/pVlbpgdLEg==;7:81Pe+Req5hCodaa1oIN3Ra8OPN/DpVjWzfJ2XZkNAK1JPKZ5MpZLBw5bVIsQSXr0di4xZd8hXqIYgpkm2YcubJ3pdXfyusAd0MGBy4hRLHjSJxF0r+nzY7aONGIpVKVef4otcoHURvdUsRogeyRLmw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 872c3ac4-54b8-4749-9c57-08d67c41eea4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2043;
x-ms-traffictypediagnostic: CY1PR04MB2043:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB2043416547A04CFCE1F54595ED830@CY1PR04MB2043.namprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(189003)(199004)(2906002)(33656002)(6246003)(316002)(54906003)(71200400001)(476003)(446003)(86362001)(81156014)(81166006)(71190400001)(8936002)(53936002)(14454004)(8676002)(478600001)(74316002)(105586002)(102836004)(53546011)(26005)(76176011)(99286004)(186003)(7696005)(6506007)(6436002)(106356001)(9686003)(97736004)(5660300001)(44832011)(256004)(25786009)(6916009)(7736002)(305945005)(66066001)(4326008)(68736007)(486006)(229853002)(55016002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2043;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E03BfCMRtAuC6JKUE7FQIC3gGTsA4pOvfzHhWdhU28JPzxecVY+9IUT07Tjrya5o1GU3+1fAw59o/w0cIi41sLWgdkDDnAA718HOsMCndRYA9+Bdh3rJNdLAf3pAosZyW/Dx51KoqjCpKxN++FVghNydMFtd73g//GqiHfzE1Q//uJWo2RMUqebM8ZsIg5VFR+h9IbqsvZd+RfyRatmKjpms9L1rah34sljxmmC5diXUrt4pLCLckXRfK4pzjX7u/3fGMClcam15zviYgBYkVaY1cR3DR6TsKot09ERmSoGwCnl8MoCtS4kbntrUYkzGDUc4W9AWBS+r8WT62YYko8WOe8LcPbhSeyKGMIHMV0oAQ3/vhstdFuBs54pI/s09rI05Hml7dZfFger3MIe5UN6ahYy1d835Yr1HPd8lGhU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872c3ac4-54b8-4749-9c57-08d67c41eea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:06:33.6956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2043
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,=0A=
=0A=
On 1/17/19 11:16 AM, Omar Sandoval wrote:=0A=
> On Thu, Jan 10, 2019 at 06:37:09PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> The current blktests infrastucture and test cases do not support zoned b=
lock=0A=
>> devices and no specific test cases exist to test these block devices spe=
cial=0A=
>> features (zone report and reset, sequential write constraint). This patc=
h series=0A=
>> implement this missing support.=0A=
>>=0A=
>> The series addresses two aspects: the first 7 patches introduce changes =
to the=0A=
>> common scripts and configuration are introduced to allow existing test c=
ases to=0A=
>> run against a null_blk device with zone mode enabled (new ZONED config v=
ariable)=0A=
>> or for these test cases to be skipped if a test declare itself as not zo=
ned=0A=
>> compliant. Helper functions are introduced to facilitate checking a devi=
ce=0A=
>> zone model.=0A=
>>=0A=
>> The second part, composed of the last 9 patches, introduce the new zbd t=
est=0A=
>> group to cover zoned block device specific test cases. All these test ca=
ses are=0A=
>> implemented using the test_device() function so that target devices can =
be=0A=
>> specified in the TEST_DEVS config variable, to cover a variety of zoned =
block=0A=
>> devices: physical real drives, partitions and dm-linear setups on top of=
 zoned=0A=
>> block devices, etc. Furthermore, using the infrastructure changes of the=
 first=0A=
>> part, the TEST_DEVS definition can be left empty, resulting in the zbd t=
est=0A=
>> cases to be run against an automatically created null_blk device with zo=
ned=0A=
>> mode enabled.=0A=
>>=0A=
>> 5 test cases are added to the new zbd test group to check the kernel ioc=
tl and=0A=
>> sysfs interface, zone report operation, zone reset and write command han=
dling.=0A=
>> These tests are simple but only a start. We will in the future send more=
 test=0A=
>> cases to cover at least the regressions and bugs found and fixed in the =
zoned=0A=
>> block device code since its introduction with kernel 4.10.=0A=
>>=0A=
>> Another still to be added part is support for host-managed ZBC emulation=
 in=0A=
>> scsi-debug to further improve test coverage without requiring a physical=
 SMR=0A=
>> disk. This work is ongoing and will be added to blktests once the releva=
nt=0A=
>> scsi-debug changes are accepted in the kernel.=0A=
>>=0A=
>> Changes from v1:=0A=
>> * Fixed _test_dev_is_zoned=0A=
>> * Added _have_fio_zbd_zonemode=0A=
>> * Added patch 10 to move _dd to common/rc=0A=
>> * Addressed various nit commented on the list=0A=
>>=0A=
>> Masato Suzuki (6):=0A=
>>    tests: Introduce zbd test group=0A=
>>    zbd/001: sysfs and ioctl consistency test=0A=
>>    zbd/002: report zone test=0A=
>>    zbd/003: Test sequential zones reset=0A=
>>    zbd/004: Check write split accross sequential zones=0A=
>>    zbd/005: Test write ordering=0A=
>>=0A=
>> Shin'ichiro Kawasaki (10):=0A=
>>    config: Introduce ZONED variable=0A=
>>    common: Introduce _test_dev_is_zoned() helper function=0A=
>>    common: Move set_scheduler() function definition=0A=
>>    common: Introduce _have_fio_zbd_zonemode() helper function=0A=
>>    block/004: Adjust fio conditions for zoned block device=0A=
>>    block/013: Skip for zoned block devices=0A=
>>    block/018,024: Skip when ZONED is set=0A=
>>    check: Introduce group_exit() function=0A=
>>    src: Introduce zbdioctl program=0A=
>>    common: Introduce _dd() helper function=0A=
> =0A=
> Hi,=0A=
> =0A=
> Thanks so much for the contribution. It'll be great to have some tests=0A=
> for zoned block devices.=0A=
=0A=
Thank you very much for your review.=0A=
=0A=
> One thing I'm not a huge fan of is that setting the ZONED mode hijacks=0A=
> the existing tests to be ZBD tests. When I'm doing a full test run, I'd=
=0A=
> like to run those tests in both modes without running the rest of the=0A=
> test suite twice.=0A=
> =0A=
> Instead, what if we added a per-test setting like CAN_BE_ZONED and a=0A=
> global config RUN_ZONED_TESTS? If those are both set, we run it once in=
=0A=
> normal mode and once in zoned mode. This also avoids having to blacklist=
=0A=
> tests which don't support zoned mode (although we'll have to remember to=
=0A=
> whitelist tests that would work on a zoned device).=0A=
=0A=
Yes, that would work too. And the CAN_BE_ZONED per-test case setting can al=
so =0A=
control if the test should be executed against a specified zoned device or =
not. =0A=
Will make these changes.=0A=
=0A=
 >=0A=
> The functionality for falling back to null_blk if no devices are=0A=
> specified is nifty. It'd be nice to have that as generic functionality=0A=
> instead of specific to the zbd group. Something like a per-test=0A=
> fallback_device() function which sets up the fallback test device. It'd=
=0A=
> probably also need a cleanup_fallback_device().=0A=
=0A=
Good idea. Instead of the entire group fallback device, it becomes per test=
 =0A=
case. Will make the changes.=0A=
=0A=
> =0A=
> Let me know your thoughts.=0A=
> =0A=
> Thanks!=0A=
> =0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
