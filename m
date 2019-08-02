Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEFCC433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 04:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23F2205F4
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 04:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nX6fn9TY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DtMunLfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfHBELj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:11:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10703 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfHBELi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 00:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564719098; x=1596255098;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aep9RMXATTI76Gb25KqWMYBT7zW8o7HbTYA3a+r1pe4=;
  b=nX6fn9TYOPvUjqTKDxOcNAyF0o0SDenTaB0pUUrN3Cg6NngKsn60G1G4
   K30DSALYr0AZaFFVCHGj395L0Aw+IZmzpAeaJaT9rRyoLhWrz3JhpJaFY
   7je00PW4piyzTKeKS7AIX0BJuZo48dQMS2zrJ7kcsI/lmVfmKHDlX3/ci
   /JcE6Bi0wGOnLlpRIFkqfKceE6cL7TkgvcHSN7SBOBGapbOOmM77OG2fG
   41TTkG6PKWP3c0WCd0xbwRsZyAJyAEXFWsw09AF0MnFRAxuDcp9QEnrhV
   pwEAKjDCdY/4NR3uAOuqAAkjVWGnREmZTLy05f16twsiYz15Q7hGund2a
   w==;
IronPort-SDR: 4KDMoyjqbsSEl3+7MEXTMp3Gj0mMO6YbzZLcu82Nz/p9RGpuuua29cDB6/QqMNXkX3niiUhI4G
 XhnrBZO6UNqydzE5tW9qjWIWOk70SkU6Hj3DbLDkodcmX/i7o2DTRJXH9D9+wggKLgPscbt3bX
 qyeHE/YQPtcY3dwaNmJxQKjmTroQh2ysHVJm9PkMiuYT7l7xkHjqHBCSg/JwJroJfddR0mcuVO
 X36uiU1bM98BZV5OreM4HqLqWMcvr3cAEMIRTKgvJSKxh/ImS1iG33v3aVNVVF+OQICquVBQR/
 M7c=
X-IronPort-AV: E=Sophos;i="5.64,336,1559491200"; 
   d="scan'208";a="221241026"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 12:11:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXey7fiD0A/ak3T4Z/0gGm/mdaKyy5r5OSNFNTUfVeOj18ZCqYKXQlV3Fgg13MhuVqZZ1SuRkSJ5TAOWwJ0rEAxIi73FqMYgiIyO9s9Qd4R7WtcM63hgNn/IGyNrD9+DtUzs/yLL2+2uDXMfxZP6GzQuacl3ZkyughuqOdPgZHlobH+NqJN5724IoZO6Qn53JyjQxLqI1HJWRpBNUys2yeGsFwn8kyWUY4k37B9e7LMbFxAvo1RlaJ0xq/dWmwdkxCMudDlP/ewBOd+jKs0VERL0YQ+DaafxORKVO7h7CFUOCkv9m7XT8/42tnKGzEl/gKx5/O84CsGqceFqSKT0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vm16KLtSu5TsUFOV9MlXwY/neoRNSxD/lMTmdZ3OoQ=;
 b=bW/jdbJi+KZuzOWgaWkEDm9mtRjq4veDKwo+49y0THji7Tqc3v3yWhB8Ez7B4jD8z6WgZEuN+9lThdrUXOdAHiMhl1Ak0qQa7qHcdJ5aeUHsmKh7YQyS+ivUXQX7wTo02SQSWfna1ZUEBgHgHaGYx2mH2vKaMtf79BKUYMdSgPxiULRwXUib22yUGKIrBE54PS67vSriPeRphHqmWgF06eDbeyvL3QRAzwofJyUErJCMARGnL2zj5xOxG5qsUzme31zRIGF7ASHHX3jqlHdb4sa3SPTMUjHWIYc4zbDlPyu/3uSWJStbbn6kiuHrWD5AsGRFNgg8nVXTJXc9Wz57VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vm16KLtSu5TsUFOV9MlXwY/neoRNSxD/lMTmdZ3OoQ=;
 b=DtMunLfnYXfvtlgR5mcUrH54KRKUt+H8GDSa+Vxr8bO9i+TIjyAbp1uxWvsQnrsvoGTWp9H+RI9KkjCaCZzB2w+P/BVeAtoWgh3fjIjiLBhT+pX+JhXzA7ay5RfC7vg1PIxd8SkWFaL30R8kcBLbaajMTUOMO/oLtCpjdWVhMW4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5032.namprd04.prod.outlook.com (52.135.235.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 2 Aug 2019 04:11:37 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 04:11:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
Thread-Topic: [PATCH] block: Fix __blkdev_direct_IO()
Thread-Index: AQHVSFLzGnfcCVN4LE65o4/UfXYJWQ==
Date:   Fri, 2 Aug 2019 04:11:37 +0000
Message-ID: <BYAPR04MB581664B63FCC7A77B8D48A77E7D90@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
 <19115dcc-8a4b-8bb7-f8db-e2474196a5d0@kernel.dk>
 <BYAPR04MB581699C381CE35C34DE45EBCE7D90@BYAPR04MB5816.namprd04.prod.outlook.com>
 <0bf921d3-162b-8e51-63fa-5da757ccbbd2@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aa89b8e-a42f-414c-8cd7-08d716ff8367
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5032;
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-microsoft-antispam-prvs: <BYAPR04MB5032325B842F33F021B6049DE7D90@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(51914003)(189003)(199004)(305945005)(74316002)(7736002)(8936002)(81166006)(81156014)(8676002)(99286004)(2501003)(76176011)(68736007)(110136005)(186003)(102836004)(4326008)(54906003)(55016002)(6506007)(9686003)(86362001)(316002)(53546011)(6246003)(53936002)(66066001)(26005)(2906002)(486006)(229853002)(446003)(25786009)(3846002)(6116002)(476003)(52536014)(66446008)(64756008)(66556008)(66476007)(7696005)(71190400001)(5660300002)(66946007)(256004)(14444005)(6436002)(478600001)(33656002)(76116006)(14454004)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5032;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D0ZRtSdEMj5al5kM6kMU5+Jf6nsBQbF2YfxCn08b8wEF58+isEDV1UbM8XPj+SeH+n3rY1R+3ZSr7iyUvGpR7NPqIWp9QZEMwUI/yIdU3+R8d+cvdZ/UycLBInOX2aa11rHUXAr24C58XKIAaxv8LTUF9OmeHF3c7G3TRfqNqILXIlMlo2CPstWdAPByBRRWaO2PQ4z2JmjLWmR/tpnQuDszhY2yWbr3pd/rt17DOoSggosjfYlbhHshbeMbCTAcvKsE5aYYok96qSFrsOnmd99znIboG4r81koEuI1QqEFE71l8nosFIEaNwncorUE7YPY7s478gqYwF2lHwxdRzeBuBAkPgp3bxx7n7sKwEcZrYlrIk06/xaEp69d6wiw5M1oJQxPqsuCOZXplqXknIJQfQm6xTKbZUr3Z1Gca1No=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa89b8e-a42f-414c-8cd7-08d716ff8367
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 04:11:37.1958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/02 12:57, Jens Axboe wrote:=0A=
> On 8/1/19 7:05 PM, Damien Le Moal wrote:=0A=
>> On 2019/08/02 4:51, Jens Axboe wrote:=0A=
>>> On 8/1/19 4:21 AM, Damien Le Moal wrote:=0A=
>>>> The recent fix to properly handle IOCB_NOWAIT for async O_DIRECT IO=0A=
>>>> (patch 6a43074e2f46) introduced two problems with BIO fragment handlin=
g=0A=
>>>> for direct IOs:=0A=
>>>> 1) The dio size processed is claculated by incrementing the ret variab=
le=0A=
>>>> by the size of the bio fragment issued for the dio. However, this size=
=0A=
>>>> is obtained directly from bio->bi_iter.bi_size AFTER the bio submissio=
n=0A=
>>>> which may result in referencing the bi_size value after the bio=0A=
>>>> completed, resulting in an incorrect value use.=0A=
>>>> 2) The ret variable is not incremented by the size of the last bio=0A=
>>>> fragment issued for the bio, leading to an invalid IO size being=0A=
>>>> returned to the user.=0A=
>>>>=0A=
>>>> Fix both problem by using dio->size (which is incremented before the b=
io=0A=
>>>> submission) to update the value of ret after bio submissions, includin=
g=0A=
>>>> for the last bio fragment issued.=0A=
>>>=0A=
>>> Thanks, applied. Do you have a test case? I ran this through the usual=
=0A=
>>> xfstests and block bits, but didn't catch anything.=0A=
>>>=0A=
>>=0A=
>> The problem was detected with our weekly RC test runs for zoned block=0A=
>> devices.  RC1 last week was OK, but failures happen on RC2 Monday. We=0A=
>> never hit a oops for the BIO reference after submission but we were=0A=
>> getting a lot of unaligned write errors for all types of zoned drive=0A=
>> tested (real SMR disks, tcmu-runner ZBC handler disks and nullblk in=0A=
>> zoned mode) using various applications (fio, dd, ...)=0A=
>>=0A=
>> Masato isolated the problem to very large direct writes and could=0A=
>> reliably recreate the problem with a dd doing a single 8MB write to a=0A=
>> sequential zone.  With this case, blktrace showed that the 8MB write=0A=
>> was split into multiple BIOs (expected) and the whole 8MB being=0A=
>> cleanly written sequentially. But this was followed by a stream of=0A=
>> small 4K writes starting around the end of the 8MB chunk, but within=0A=
>> it, causing unaligned write errors (overwrite in sequential zones not=0A=
>> being possible).=0A=
>>=0A=
>> dd if=3D/dev/zero of=3D/dev/nullb0 bs=3D8M oflag=3Ddirect count=3D1=0A=
>>=0A=
>> On a nullblk disk in zoned mode should recreate the problem, and=0A=
>> blktrace revealing that dd sees a short write for the 8M IO and issues=
=0A=
>> remaining as 4K requests.=0A=
>>=0A=
>> Using a regular disk, this however does not generate any error at all,=
=0A=
>> which may explain why you did not see any problem. I think we can=0A=
>> create a blktest case for this using nullblk in zoned mode. Would you=0A=
>> like us to send one ?=0A=
> =0A=
> Thanks for the detailed explanation. I think we should absolutely have a=
=0A=
> blktests case for this, even if O_DIRECT isn't strictly block level,=0A=
> it's definitely in a grey zone that I think we should cover.=0A=
> =0A=
=0A=
OK. We will work on a test case and post it.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
