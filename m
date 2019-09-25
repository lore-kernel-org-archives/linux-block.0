Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E58C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237C2208C3
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 22:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CcMJTl1+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LCDZr8Sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfIYWNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:13:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65070 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfIYWNf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 18:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569449655; x=1600985655;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EFOOhMDtZK9gk31m+L93pzC4fVWd1eHrMOOY0EVeiHc=;
  b=CcMJTl1+pUEqbYsTq+kQ1vjyIixKu6VEGZ2X80PL9mdG4/lJwweha+E+
   Pgu0CzeD+dnTeO1/c6DlqgqVnjEkHeU/8iVjcRgoO0gL3kwQWwCT8h4k3
   nkk8W+Qns7uE1tdgeqPd21fc3y3AiHxiGPvOzjKHtC2muf5MW2dYr8wyN
   UDsD8ylOJuU3eEhWLC5cU9i2JZnOtFQxEdnbO1E/wf14whXAHt6lmKBpH
   ST8rUhYoQJKKgTshs5/02YUK+82BIkiI1lKaje4bCpyzhgbgXowgC+jyO
   DC2IaQ/OMEbzwfIe6Yu1h7GzxE3+C4NBftNk6svIfVEoWfQqrC9Jrf/BY
   A==;
IronPort-SDR: xyt+VlrhkjmXu5AWIsXcVI6p/bIibuqXxkTgqo1tJroQkk9OKSdjidM9hNyRD19qPsvIeAkqFU
 IDRAq7BuHICW3CPL3dWfabO2vvhz35NZ0X1liRuiYdE4EsvSv9NQDP8LFALbXUP6VhH0J8watt
 OKPvbzXK+TBM+bsVUYvU3+euZt4+XG4n5PoNh6fhQ8VwYeNrBFIAJvn+5PT7CwlZPYPuwOptmS
 RD1orwmQZZWQQXJTe0KqtR+Xw+gcHPM/8zg1s5UvAWvW4+4sTiwf7TGTC6cukZPRm+8JjBGkkN
 yEA=
X-URL-LookUp-ScanningError: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559491200"; 
   d="scan'208";a="219954271"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2019 06:14:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePQiiCyxOn1l5FdT7KO4VmhSpRC83IVNjqdNcd6ZPWSm9DwZnl3gxjwknNYy3pWwex3XQ/4rMBuvKEa0np5rAy762FpQ12UhGhWQTwTl9qXI7UOdK9DqYGPs48v1qTHDirLLKSm33QWrmE8o1wPKNGEoFsdfCFQsabrnUSsWtOfq0Cx23tjBNkKmKFU0mxmnVV90+er4djXUWZNEgJfqBzFX89Bbs6nxUhaQNaf8p7fny1RFMNh9bq1bVB2fyQ08SvyYzig30ZJfzVYj/iDjnyiqq5sQiakVeMvwTkYm/emb5O9SzEIRqxKaiJAiO6S1ku7naalp36hKZ0Tz0lvPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2exqWsD3muopUcCBwwtXgLaibLOP9fxzKS4iOapggMc=;
 b=A5v0eTyORpsLFxdVjFDhotl7ZbgineDKWC9WM8tlcxZzPCL/zV4Ec833aVigUEM2xY3pl748B8YZRhbHyVPQA7YR5sT0akdrN+knkIgtkIyGlht55UCq5ehk57+37DVfN8QfHyPXwVkzmiBM+JfjOQ10P+bbVyWoBBObP7mP/2gI9Sqjjs+FNIl9UZuXpzFlw6jl6y4dQDeLcDuVbf9AmWnnlBnCBoFvQjUhrNuimYJv3OD5K1kN62E17cqiU17uFQaDcbO/7v8qS98qvkQ3aDYUnwVio8rAp+hSshPY2Q9cJasQvqvPXvepUH7/kfw5j/YWMQwZTRwUnTrxmvMoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2exqWsD3muopUcCBwwtXgLaibLOP9fxzKS4iOapggMc=;
 b=LCDZr8Srpkd342lWbzdVSflWk//cvBBo9RVLInm4FU4YTzGE+IUatcYv4q/A97CsWqFhlB8BZ78mrfqMgZsGzQLiajKBwSIudQhD1dr1TgB8fFGK2llWJDrZnRQxZjQJi62V0E7kEUn8oNSOqKWl6kFF5hH14uT5OgreTDTnIgw=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4199.namprd04.prod.outlook.com (20.176.251.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 22:13:30 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 22:13:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: WARNING in blk_mq_init_sched
Thread-Topic: WARNING in blk_mq_init_sched
Thread-Index: AQHVc8ItP5axwXV6OEOhaCfuM27lXg==
Date:   Wed, 25 Sep 2019 22:13:30 +0000
Message-ID: <BYAPR04MB58169DBC0647FE4C91338844E7870@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <0000000000007909bf059363878e@google.com>
 <BYAPR04MB5816244183004247FD3D1074E7870@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5ddd795-8c25-4a61-7e62-08d742059941
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4199;
x-ms-traffictypediagnostic: BYAPR04MB4199:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <BYAPR04MB41998E49E17F79D13B92AF3EE7870@BYAPR04MB4199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(8936002)(76116006)(71200400001)(71190400001)(186003)(86362001)(316002)(2201001)(7116003)(486006)(25786009)(9686003)(2501003)(74316002)(102836004)(55016002)(478600001)(26005)(7736002)(110136005)(6506007)(66066001)(53546011)(6246003)(305945005)(99286004)(8676002)(81156014)(81166006)(52536014)(6306002)(5660300002)(7696005)(76176011)(446003)(6436002)(3846002)(14454004)(6116002)(476003)(229853002)(66556008)(66946007)(64756008)(66476007)(2906002)(256004)(66446008)(33656002)(14444005)(966005)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4199;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jwltx1eBaxMoM2KhYVL2+UB+nk9hE9eLlaOua54TgaHkoiBgjqrwt5zJ3JTDWv0Qi3hkcUs2ymGTrjAQUIdOYsUPuBKy4VZRafbYFKIm2+NrWguM8ja899xr68a50RZAdpX0o0hLYS1mx9r1deDNBFa3WyYyqAqPTVdTG2LIYrCxsdwvaSU35L0T5yTC7FvB+WJ71ahOWVrL5sS+Ny7v7tauKZdnrw9HQ2Qkzr+ccT3hixT6VxtGpk/1jRCu6xqL0AE6r41/Us9yzOS/gfKsi/ODeguFpOwNGIVusPfuFUWDzQFeuLi4N0j6YfNEXT8EeRpG9DAIZU3MRv1VCEcokBxX+F+/2TEaORIsdskh842C1R7F4fiYkqwvc3sfhDkTYWYtxiL8ZDPsGWDEsH7RLEcgCByVCAer9HAKJ2FI5LezuRtYNYjOBAelDaN2cmCGCZVsdzT8m5gMZQkIQTkgkQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ddd795-8c25-4a61-7e62-08d742059941
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 22:13:30.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Y7qn1A6dkBj0wk1+IQuiy/rIKO8OeUxU8N4xPO8VjdEE8ieyy5kMper8aEWTXBcj5csZ7Wk+YZ4seIvxyvpDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4199
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/25 10:56, Damien Le Moal wrote:=0A=
> On 2019/09/25 9:56, syzbot wrote:=0A=
>> Hello,=0A=
>>=0A=
>> syzbot found the following crash on:=0A=
>>=0A=
>> HEAD commit:    f7c3bf8f Merge tag 'gfs2-for-5.4' of git://git.kernel.or=
g/..=0A=
>> git tree:       upstream=0A=
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15f5baf96000=
00=0A=
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50d4af03d68a=
470c=0A=
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db2c197f98f8654=
3b69c8=0A=
>> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  =0A=
>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)=0A=
>>=0A=
>> Unfortunately, I don't have any reproducer for this crash yet.=0A=
>>=0A=
>> IMPORTANT: if you fix the bug, please add the following tag to the commi=
t:=0A=
>> Reported-by: syzbot+b2c197f98f86543b69c8@syzkaller.appspotmail.com=0A=
> =0A=
> Oh... When the queue is initialized and the elevator initialization done =
by=0A=
> elevator_init_mq() is executed without the queue sysfs lock held. In that=
 step,=0A=
> if the elevator initialization fails, blk_mq_sched_free_requests() is cal=
led and=0A=
> will trip on the lockdep_assert_held(&q->sysfs_lock) check on entry. I gu=
ess=0A=
> that is what is causing the crash ? But I thought lockdep_assert_held() o=
nly=0A=
> spits out warnings...=0A=
> =0A=
> Ming,=0A=
> =0A=
> Your patch c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_ini=
t_mq")=0A=
> removed the sysfs_lock use in elevator_init_mq(). With that, should we mo=
ve the=0A=
> lockdep_assert_held(&q->sysfs_lock) call out of blk_mq_sched_free_request=
s() and=0A=
> directly call it lockdep before calling that function (that's ugly) or do=
 you=0A=
> see a nice trick for handling the special case that is the first initiali=
zation ?=0A=
=0A=
Please ignore. It looks like the gfs2 tree tested does not have commit=0A=
954b4a5ce4a8 ("block: Change elevator_init_mq() to always succeed") which=
=0A=
removes the possibility of having blk_mq_sched_free_requests() being called=
=0A=
during the first elevator initialization without the sysfs lock being held.=
=0A=
=0A=
So if the crash is indeed triggered by the lockdep_assert_held() call, then=
 this=0A=
problem will be fixed after a rebase on 5.4-rc1.=0A=
=0A=
> =0A=
> Cheers.=0A=
> =0A=
>>=0A=
>> ------------[ cut here ]------------=0A=
>> WARNING: CPU: 1 PID: 25817 at block/blk-mq-sched.c:558  =0A=
>> blk_mq_sched_free_requests block/blk-mq-sched.c:558 [inline]=0A=
>> WARNING: CPU: 1 PID: 25817 at block/blk-mq-sched.c:558  =0A=
>> blk_mq_init_sched+0xad6/0xc00 block/blk-mq-sched.c:543=0A=
>> Kernel panic - not syncing: panic_on_warn set ...=0A=
>> CPU: 1 PID: 25817 Comm: syz-executor.4 Not tainted 5.3.0+ #0=0A=
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
 =0A=
>> Google 01/01/2011=0A=
>> Call Trace:=0A=
>>   __dump_stack lib/dump_stack.c:77 [inline]=0A=
>>   dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113=0A=
>>   panic+0x25c/0x799 kernel/panic.c:219=0A=
>>   __warn+0x22f/0x230 kernel/panic.c:576=0A=
>>   report_bug+0x190/0x290 lib/bug.c:186=0A=
>>   fixup_bug arch/x86/kernel/traps.c:179 [inline]=0A=
>>   do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272=0A=
>>   do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291=0A=
>>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028=0A=
>> RIP: 0010:blk_mq_sched_free_requests block/blk-mq-sched.c:558 [inline]=
=0A=
>> RIP: 0010:blk_mq_init_sched+0xad6/0xc00 block/blk-mq-sched.c:543=0A=
>> Code: f6 e8 9e 03 00 00 49 83 c6 10 4c 89 f7 e8 82 08 37 04 e9 ce fd ff =
ff  =0A=
>> e8 c8 81 3f fe 48 c7 c7 72 5c 35 88 31 c0 e8 1d ae 28 fe <0f> 0b e9 ce f=
9  =0A=
>> ff ff e8 ae 81 3f fe 48 c7 c7 72 5c 35 88 31 c0 e8=0A=
>> RSP: 0018:ffff88802225fbb8 EFLAGS: 00010246=0A=
>> RAX: 0000000000000024 RBX: 0000000000000000 RCX: 489d2508ed9c7100=0A=
>> RDX: ffffc9000e9a6000 RSI: 0000000000009af7 RDI: 0000000000009af8=0A=
>> RBP: ffff88802225fc50 R08: ffffffff815c9744 R09: ffffed1015d66090=0A=
>> R10: ffffed1015d66090 R11: 0000000000000000 R12: dffffc0000000000=0A=
>> R13: ffff888026958990 R14: ffff888026958080 R15: ffff8880269580d0=0A=
>>   elevator_init_mq+0x317/0x450 block/elevator.c:719=0A=
>>   __device_add_disk+0x6d/0x1140 block/genhd.c:705=0A=
>>   device_add_disk+0x2a/0x40 block/genhd.c:763=0A=
>>   add_disk include/linux/genhd.h:429 [inline]=0A=
>>   loop_add+0x5d1/0x780 drivers/block/loop.c:2051=0A=
>>   loop_control_ioctl+0x422/0x640 drivers/block/loop.c:2174=0A=
>>   do_vfs_ioctl+0x744/0x1730 fs/ioctl.c:46=0A=
>>   ksys_ioctl fs/ioctl.c:713 [inline]=0A=
>>   __do_sys_ioctl fs/ioctl.c:720 [inline]=0A=
>>   __se_sys_ioctl fs/ioctl.c:718 [inline]=0A=
>>   __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718=0A=
>>   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290=0A=
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe=0A=
>> RIP: 0033:0x459a09=0A=
>> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 =
f7  =0A=
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 f=
f  =0A=
>> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00=0A=
>> RSP: 002b:00007fce60497c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=
=0A=
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a09=0A=
>> RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000006=0A=
>> RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000=0A=
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fce604986d4=0A=
>> R13: 00000000004c3118 R14: 00000000004d69f8 R15: 00000000ffffffff=0A=
>> Kernel Offset: disabled=0A=
>> Rebooting in 86400 seconds..=0A=
>>=0A=
>>=0A=
>> ---=0A=
>> This bug is generated by a bot. It may contain errors.=0A=
>> See https://goo.gl/tpsmEJ for more information about syzbot.=0A=
>> syzbot engineers can be reached at syzkaller@googlegroups.com.=0A=
>>=0A=
>> syzbot will keep track of this bug report. See:=0A=
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
