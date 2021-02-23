Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0216C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 05:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3920C64E27
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 05:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBWE7t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 23:59:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33834 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBWE7t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 23:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614056388; x=1645592388;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UDWljbSMHf4dC9sxIOOM7d4pPjrVeXLCN1XTph+0bwY=;
  b=BE1l43CkAyTdc1uoJW+niZMQSbD1Q9RHfPdOPbsLNdBgVxKP+vXi2+GD
   lK3xq8YD0iPcABKiR1pIk9EAEnFLXQSDWrqIGrjRSQbVHEmtfQ3LlZYSe
   MIJ/dG+hp5/9eACQ9gjR6y0YzvqAmZDYZG1drViprZCGyyBIYNFXa2cie
   v24l676QQbIZ0xIkVLu8Izor09OwUPKWa/sYbUx+kLT9+NHt2M/ZuJ1dx
   zXY8uX/DeV+NS1oyTuPsIdFilDsYE3oXoOPGl5BBz0XQ6Qh2HiGhhHVtp
   PAM24BqwgnFETniFvetv3fxkwiznrfqZTf9IkHfm4SvfEIFnJYjuCOIl7
   Q==;
IronPort-SDR: +85CvSmQ/rcud5HfaUNII7kgr9FhykEOkiVnNyWT2leersN3u5oFL2UzbZObUWqowg4hqVUkik
 b/wrs1W3T9p0nvGfA+D47tcK48zdb+Ec05qiYAHwpNU05h21l25Sl1dT6lRcMP7f0iWrU3MVin
 D8/GN27c9ylZ0oVsMiNzaL0WTtUbm1UQ8BKVAaRAYHLGLqdnpDpVouV1/+mVa9kFZvI2bxz4RN
 Jncb/J4ZaGGnG6EPWhvWqbGwk+/WrbClsb9ZSrh8LQSSmnUBrbtAWIjmUPCYoq1Nzgo8s1f8Ey
 HuU=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; 
   d="scan'208";a="165042323"
Received: from mail-bn8nam08lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 12:58:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKHrapNJ+z3+pliRGWLcHvVFO3f+7vx6QhB1Te26Y328rsdeg48jyZfr9lKoSjJTT1n7TZ1Ta5pa1a/q4yQFo98tFAUW7zrD4sjjDo3bVNfZM5QDCzlt5OQZk9nJ8Efx1J/bz8DxtSVygP0N0nceI1l8Xde241ncWQcEDqJpD/UClrU1G27qMHNt4o4km4zOIw3lRXz2luZQRIsUUVm9MpTZONwevAhutvrEHgI7zzb2cHmg67v5vmyqq2+Q4xFNOiLcq7W0nk+L2FO9E4k1nojAk2NNnCRexBVtjjcTxeyCsu+2XxauHnVzd1ABwdWudnwQDE7XCwdDfEP5Bd/3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A83NoKrt08ynbBdmgjsIfrIX0opzCWXTOUyC8/oscjU=;
 b=WN1ue0CR1CWhSZnWdnLK6uNrvZs2lJNL3oDCZ2QgcxQiYyqcOu9Xk2m80E2OqQkzhILatdCHi6fQkOukl2rEs+rk/akuZciq1I5nvzs1OuGLFCWrJ4iljEtt1+AzWI/XxHgMYkevsVCKKsH2ceJ0PTEfFR17FOLwnPl38oaXs7k3OeV1BIxGCpe/VMBL/EzNUsNGqJJuiNR1wDnesB1Br/zHZxxLScPQyibOoXWVLoAr1HJldqYr9JGx0a796k77UfXO/u6gKEYlaVG0kEZ0pxcoO2dyPbiDy8CQWQ/i40dgRSZs+XgqDCBspejylJXKUtBc81jAI6u0T/uUI6gHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A83NoKrt08ynbBdmgjsIfrIX0opzCWXTOUyC8/oscjU=;
 b=yzR8kgNtmBOsAKzo0H2BEwPLHMpqRBs805oYc7OMFQxNiWTnUW13SnExDW/nNmWM6LWzz0fu+K3eIpNWvmiH7lWitFjSY/KdbPiBJEmVAXnPyFnpudNDCgX2vtOxTyC7ZYNS9SQoZAoeAOapMr3uGNeePOQClfUCiP0df2J8HAI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4037.namprd04.prod.outlook.com (2603:10b6:a02:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 04:58:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 04:58:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     David Anderson <dvander@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Topic: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Index: AQHXCZD3vAo2wh9jek+o1gtQqbdo1w==
Date:   Tue, 23 Feb 2021 04:58:38 +0000
Message-ID: <BYAPR04MB496545CBAACF978B9E11B77B86809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
 <BYAPR04MB496566A72BC5641BAC7D279F86809@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CALAqxLXWs0GUZv=zWFK8hvnnkEgfMXvr_tZPyPaPBra=k9yf-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7ca2191-e124-44c2-aaf9-08d8d7b7af29
x-ms-traffictypediagnostic: BYAPR04MB4037:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB40378C7D709E4CAB0E17668786809@BYAPR04MB4037.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pz5jVOHf4P0XxyhTXM0YDPN3YubXr73XZko9gZPNu3k7mzAmF9RHXVST3AJBT8t9MP5GQNPnhbaqRByn5JjrAwr+ybghIFK7wTwgBUqBC+6UGfxNpIeGVajJbFxziA0eUi6Ar2+yQ1MQXqPrE0IYRUFYb1Xf1w0CiV5Isp3v6VjJpF04HOJ4PQSaiym/W9MFyhg49j89C4uKN9iV0zxx/2onsoLH0HEskDqpQ89L//cwDgBwsWhc6anxgTXn9yFZO73UjhqzO6Qth+OmMdAbLp1qndrYR+moM8DWSyG+D+xUhed7Fh0eqKE1QWDsEyfyliq0VBd7z1VgDFgTFBbu0O+V9ZG4si0NscF4fdG2CeXOvHYtdy4Yv2JmSf5ag6njX9Du23EAYiHgS0FCuRutHufLpBEcMcngwxXIzXy6XjxhK+Y+wPpMUpzQq8NlmwQgjnC/BJzFlZTdxRr3MqiaaSLyx5kA4AEO16t1BgUZHucnySQyjZG8KjPuE/eJBq1j0cOkzRZLV7Go1pXR/aLn3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(66446008)(53546011)(64756008)(66946007)(8936002)(186003)(316002)(478600001)(6916009)(26005)(54906003)(71200400001)(2906002)(7416002)(4326008)(76116006)(55016002)(5660300002)(9686003)(66556008)(66476007)(33656002)(91956017)(7696005)(8676002)(52536014)(6506007)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7WcFMI5hsA1xUgQDLLXOIlpc/39EXnWlJNAK6G2zMJpdzE+wqDFXCGC2er90?=
 =?us-ascii?Q?P5M+P/ehjrycqmphJ8RfelKbLgZN9Hd6qniUbH1swVrpNdvVfsOifGbeMwqL?=
 =?us-ascii?Q?ypIBfRgZ67wsS7e5rY5xgZbIgzrxvZj4gcRI0ylo6s/3hALKhtx01U7JOPqN?=
 =?us-ascii?Q?fkVzFUQdgciDkrd6HuFADi0FOjLHp4QJJpVyQ5asl3XNcFFEkuDmHItR4ls4?=
 =?us-ascii?Q?dEhg4JldHHzOQWlrKY6KYG6W/EOUevLHeDIm1k4pkbLy2yuS8kT/ZoxWXMQW?=
 =?us-ascii?Q?mY6xb6YMBA6sU9ahX7yViFf4jL6hcUkM3RUjsq8KrbMBe520+ohhY1Qo/jS3?=
 =?us-ascii?Q?yGybBW74q+6wl+iwjCIGp2biAm9umSY2OU3BXmGpGAUqr/lSALVJUZOpWEwh?=
 =?us-ascii?Q?Su3kz69/p4v8JBO19yAMb5zV/Kfite4I2aHAx6hJFOnH7bQocpFLGH+L3JVg?=
 =?us-ascii?Q?T6ehtvGaDjayMg1r7wMMaoh2Qs5VBXeoTmuY0QS4E996xR+OZiAuMFsoorP8?=
 =?us-ascii?Q?oQijNX3mIuEL6wNIavxERH1cMIt09rCcYUM+2v38cDebXs4cNT256Z/pJAN2?=
 =?us-ascii?Q?DbH6Rr35hvhrZUASbnln1JuOdAGtM2BPnRimD9MahpqvcyjCSZiJwGJya80H?=
 =?us-ascii?Q?AFSKHKzRbVpGkWlYM/2DWe04gw7pFUhEs2hi7Jvl/M66B4tCu2pr69HQKwf5?=
 =?us-ascii?Q?C//Y2i5RiIfAc2R1+SPIGssL+gm3WoXL0MLq92X6uQAbLOH8QbSMC6/WXShI?=
 =?us-ascii?Q?SNH7XUtyeW9k8YN8WJI4RJmjyrh0ejcteN13RNAMQ9shIzpxqZNkJtJ31x36?=
 =?us-ascii?Q?zD5+4tFrfafZZs16gPsAzUJSWIKboT2aBo8ZZzMj5o6kFAs+EjLaiKjc6/NJ?=
 =?us-ascii?Q?hBsTaefpvJiToghVpuVDJ/w4LzF0Ljv5c6WExnrEa7dWc0Vp6T8WIxRxk+WQ?=
 =?us-ascii?Q?cvnJvMRG81eisWQ4J7aShigLtuUQc1el5kaTecG11tdkrRjfEXJuv+b5Hf5J?=
 =?us-ascii?Q?trthlRWGar4Qioh2DcjwmR1HYJ0lxzKNhCahW/DEAaBztxgeajVJGxKPnVYO?=
 =?us-ascii?Q?QFCGrxrK6nNoNzLygurrlJlC/unItMadeETphHSwpIb0qDwE97at0G7XP7Ol?=
 =?us-ascii?Q?BS334XaT1ge2E//QO0k6VCFeDUGAKK8Iyz5MyIAF7RVdf29628BHimXvz4UN?=
 =?us-ascii?Q?bSvhOQCW5sFp5WwhCnCOTHBMcYvthOpvl9Sy3BC9o2SX9KOpjjpXQXdG5EmN?=
 =?us-ascii?Q?vrJbI/Bq0iOG7H12Ey81+QFcwxHF3+8/jU4Xw3KfOLh3wgLcTCMy0psfR9E4?=
 =?us-ascii?Q?MgHS9cCugHCDZTYxcv18HleY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ca2191-e124-44c2-aaf9-08d8d7b7af29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 04:58:38.9456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHoh6UHhtB+KwbNv731fdy1PI0PVlhTH2vH/NOJdEpn4C5AvR6i9gS1ac1yNdTYF0vpV27NIC1cRVwZy5+I9X0j4n2eRnd2elmhxE7z8Las=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4037
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 20:22, John Stultz wrote:=0A=
> On Mon, Feb 22, 2021 at 7:39 PM Chaitanya Kulkarni=0A=
> <Chaitanya.Kulkarni@wdc.com> wrote:=0A=
>> On 2/22/21 19:07, John Stultz wrote:=0A=
>>> [   34.784901] ueventd: LoadWithAliases was unable to load platform:reg=
ulatory=0A=
>>> [   34.785313]  bio_alloc_bioset+0x14/0x230=0A=
>>> [   34.796189]  bio_clone_fast+0x28/0x80=0A=
>>> [   34.799848]  bio_split+0x50/0xd0=0A=
>>> [   34.803072]  blk_crypto_fallback_encrypt_bio+0x2ec/0x5e8=0A=
>>> [   34.808384]  blk_crypto_fallback_bio_prep+0xfc/0x140=0A=
>>> [   34.813345]  __blk_crypto_bio_prep+0x13c/0x150=0A=
>>> [   34.817784]  submit_bio_noacct+0x3c0/0x548=0A=
>>> [   34.821880]  submit_bio+0x48/0x200=0A=
>>> [   34.825278]  ext4_io_submit+0x50/0x68=0A=
>>> [   34.828939]  ext4_writepages+0x558/0xca8=0A=
>>> [   34.832860]  do_writepages+0x58/0x108=0A=
>>> [   34.836522]  __writeback_single_inode+0x44/0x510=0A=
>>> [   34.841137]  writeback_sb_inodes+0x1e0/0x4a8=0A=
>>> [   34.845404]  __writeback_inodes_wb+0x78/0xe8=0A=
>>> [   34.849670]  wb_writeback+0x274/0x3e8=0A=
>>> [   34.853328]  wb_workfn+0x308/0x5f0=0A=
>>> [   34.856726]  process_one_work+0x1ec/0x4d0=0A=
>>> [   34.860734]  worker_thread+0x44/0x478=0A=
>>> [   34.864392]  kthread+0x140/0x150=0A=
>>> [   34.867618]  ret_from_fork+0x10/0x30=0A=
>>> [   34.871197] Code: a9ba7bfd 910003fd f9000bf3 7900bfa1 (f9403441)=0A=
>>> [   34.877289] ---[ end trace e6c2a3ab108278f0 ]---=0A=
>>> [   34.893636] Kernel panic - not syncing: Oops: Fatal exception=0A=
>>>=0A=
>> If you have time then until you get the reply from others, can you try=
=0A=
>> following patch ?=0A=
>>=0A=
>> diff --git a/block/bio.c b/block/bio.c=0A=
>> index a1c4d2900c7a..9976400ec66a 100644=0A=
>> --- a/block/bio.c=0A=
>> +++ b/block/bio.c=0A=
>> @@ -663,7 +663,10 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t=
=0A=
>> gfp_mask, struct bio_set *bs)=0A=
>>  {=0A=
>>         struct bio *b;=0A=
>>=0A=
>> -       b =3D bio_alloc_bioset(gfp_mask, 0, bs);=0A=
>> +       if (bs)=0A=
>> +               b =3D bio_alloc_bioset(gfp_mask, 0, bs);=0A=
>> +       else=0A=
>> +               b =3D bio_kmalloc(gfp_mask, 0);=0A=
>>         if (!b)=0A=
>>                 return NULL;=0A=
>>=0A=
>> P.S.This is purely based on the code inspection and it may not solve you=
r=0A=
>> issue. Proceed with the caution as it may *break* your system.=0A=
> So with an initial quick test, this patch (along with the follow-on=0A=
> one you sent) seems to avoid the issue.=0A=
Thanks for bisecting, the patch you are referring to is with the similar=0A=
fix for bio bounce ? =0A=
> I'm wondering if given there are multiple call sites, that in=0A=
> bio_alloc_bioset() would something like the following make more sense?=0A=
> (apologies, copy pasted so this is whitespace corrupted)=0A=
> thanks=0A=
> -john=0A=
I've asked Christoph about how we can go about this issue, based on his=0A=
reply I can send a patch.=0A=
=0A=
I think having kmalloc is what we want to avoid in the fast path, with=0A=
that in=0A=
mind in my opinion we need to fix the call sites with kmalloc call if numbe=
r=0A=
is small,  which I think it is. Let's wait.=0A=
=0A=
Meanwhile it will be great if you can share the result of the thorough=0A=
testing.=0A=
=0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index a1c4d2900c7a..391d5cde79fc 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -402,6 +402,9 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask,=0A=
> unsigned short nr_iovecs,=0A=
>         struct bio *bio;=0A=
>         void *p;=0A=
>=0A=
> +       if(!bs)=0A=
> +               return bio_kmalloc(gfp_mask, 0);=0A=
it may not work since nr_iovecs needs to be passed=0A=
> +=0A=
>         /* should not use nobvec bioset for nr_iovecs > 0 */=0A=
>         if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_iovec=
s > 0))=0A=
>                 return NULL;=0A=
>=0A=
=0A=
