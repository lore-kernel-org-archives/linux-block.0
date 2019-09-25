Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E632C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8DB205F4
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DCygSL0m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jH9wyqVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfIYR4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:56:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46269 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfIYR4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 13:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569434160; x=1600970160;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oiVXbOeRsZafdAyYWqxkPQasNpufxJKS/QfNcg4loy8=;
  b=DCygSL0mDF8x0BBQTiAh5sH7xDT0Nhvxl+XrLvFEZ6BNqcMioisgo8R0
   Btk1XfCga+uUdu7vpKin/R5T0dYhtNWZ5JRG7bGLcfNexYhdoAbwHBAjC
   xfdCEdDnSxuaXLEYld1+yXLPOPc5Nhi5fgBmxXtsKeZEo2bW9uwBZDMdn
   RnUpsxkzGYSauJ+0f+RmOAyCXshIXLZa8hKtyMWX+4OW8VvkdyXLQbLkL
   UERE8t4D+pO8J3KTZP8wlZSs6Md8uRL9AmzCrLfo1u/hKuD0gWEagD+qJ
   hd/UToxRUc9TLIv/WVLEX/wWrFRm3kDr9/bvIBf+qgQbLIZk0ih5L9p+j
   w==;
IronPort-SDR: c1nF+XYjIUr6YuBNpaS58xX09komUqY5ffQvfNQs5S5LB2+xv+SnVXwrZW8hpe1ADTt3rUUs6F
 +G51xqWTrG4iuLgGIAHkPqLnkEvrX2h+AZb/FLTxt6m4dL3BqqP7ltRbOjxgV4ktGv/Iyl5cMl
 AgBW/9zGwgY8aCpkXNfy43s+S04AA7S7cbdxWfhkbKNkgk6bYGWRPq/nQCEHNSZbRoOjy2Od30
 6S+FawCt9f646bLdZMpSTG6lPcTqlr6EO+2Ka2N+UecyMpuuGG9cBUJYL/fjKpynDmdvSMrXDL
 F0k=
X-IronPort-AV: E=Sophos;i="5.64,548,1559491200"; 
   d="scan'208";a="120665675"
Received: from mail-co1nam05lp2051.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.51])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2019 01:55:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ0m7ehlpmlAMuo5szP14Ddr9lr/WlI4UolgT2xME/PO0TkrUcPTg3TbafmE3YEUxGRuqj+AopaiUTKCZ4XHOp0RX4QZi83h8BnN4WLMcO2w9rblI5hqfE/ZKKQ45tQ5jJGMbwF0FQlTrn/Bw+xfbzq9olP2CvLUj/8SOfnGqbUwWXUUcrSy9Aw73AZROhmVACQgK2E7ZotcbrzvhudSF9whFJ+Z09qP2MF978ecs6d4uIbtNxwyD3hpWBiEVNnKeY5BozRcoTrkT+XSE3da+SqH4Zh1cxKw5AMwzUig8Acj8yvB7dmaWxLl3L8jCq+bGzIN+ZGp80c6SmYn4FF2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtEtNL4LbhN5YVKW7ZUX8MJ2wDEWunAKDaOfJmwIDG8=;
 b=DTxTco8NdgPEocAHTuprKddfVVwoaRnR8RZXHw3QOISY5GkubFXbkhLst+UfbCWEtKw59f0kN9iEe80obDslazcID0jCg5Bt5yN8uA3Ms4Bx7iwLP4vVJn3OUmVfp5Mv7wiv7WZo6vWHPy+yNtjNwt2mY6XZvYDD7ENMcVqcSkipZtWGsjC05DnPWcSLq+i17MJudai68uyB3yzRdEndFYMUgHGVOoAurSCu4hRp9u+5H6GRh0MGdHFBLoz7wEMwN80MQi/hEFkAgJXkHzltLrdFnnfydn99OlgqxKOO/cu8a3JLMQk4lSt8wJDRMi024xqrd8UdrD2UXjDJUcjNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtEtNL4LbhN5YVKW7ZUX8MJ2wDEWunAKDaOfJmwIDG8=;
 b=jH9wyqVjABwZEv8IXNpwA7n4N+u35Mh3xX2Gk6D81idvYUpVj/lvJWkRpWfd22n6zzzaSOmvwcrRPbKskvG+ffedOXGDUaisLcpJ+KoNfhvtvpAIf7EbcUdH/ErcmsEg4QFc+kxTehJyWYB8NQxIC5gy2lw6QRd78UFdKOGbpBk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4133.namprd04.prod.outlook.com (20.176.250.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 17:55:57 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 17:55:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: WARNING in blk_mq_init_sched
Thread-Topic: WARNING in blk_mq_init_sched
Thread-Index: AQHVc8ItP5axwXV6OEOhaCfuM27lXg==
Date:   Wed, 25 Sep 2019 17:55:56 +0000
Message-ID: <BYAPR04MB5816244183004247FD3D1074E7870@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <0000000000007909bf059363878e@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd34d16c-43da-44ed-75de-08d741e19df3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4133;
x-ms-traffictypediagnostic: BYAPR04MB4133:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <BYAPR04MB4133A440336E355EBB5733DBE7870@BYAPR04MB4133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(189003)(199004)(2906002)(102836004)(53546011)(5660300002)(25786009)(66066001)(76116006)(3846002)(6116002)(14444005)(76176011)(6246003)(110136005)(7696005)(9686003)(2501003)(186003)(7116003)(6506007)(74316002)(26005)(7736002)(305945005)(6436002)(66946007)(6306002)(86362001)(2201001)(316002)(256004)(14454004)(55016002)(64756008)(66446008)(66556008)(33656002)(66476007)(478600001)(71190400001)(71200400001)(8936002)(99286004)(81166006)(81156014)(8676002)(966005)(229853002)(486006)(446003)(52536014)(476003)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4133;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +enWsnmKpQA7R5bAi/3vCy/Ogm+ja9TvOFwBE6zXHOpFttzsDbiGxXXg5GAl1M0nU+YGXHY67TgQ7x5hQlqjBRBn2EXEc1LwuEI1R673IGxuQ1XP3cO1dSQDsUFk2SFqxHQlWXotzzL6ZJa7zsF+it5uCqu087zAR2u37zqiiG8qXYTnM7Tw+feHiNRasPhN5guCrbXcEe38rKnvpW407gmYffdSQjBQMhYcJVxalgpFUNZKZzCb+Id9w0QAzXXn04GooRcvyFrUih6ofGJOofsTmUi7qlOn8CYJO2FEMC7n62baNPZ38TtNxIvPLj3NIISWhiSYzp/NFwubgLdRi6cGLQt4u5b9ysCxOvQtFFKoIjA/zX6D/s5IYmLbg7ALNdutZWP6hXX2TzlyqjW+UJoFpQaellDnGPJSWVIax8FtO4JDft1LRKWsWlKH/cEzKEyjsWEcdT3b7h9Y2jOOkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd34d16c-43da-44ed-75de-08d741e19df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 17:55:56.9180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aymhMMVs48jfBqaN0zImfmfKUyC6VDL6wKbtvz5JjlHPDa7eI0bn4bzXfYKMR9kFseLlxc/QUzoUD6JE02IiAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/25 9:56, syzbot wrote:=0A=
> Hello,=0A=
> =0A=
> syzbot found the following crash on:=0A=
> =0A=
> HEAD commit:    f7c3bf8f Merge tag 'gfs2-for-5.4' of git://git.kernel.org=
/..=0A=
> git tree:       upstream=0A=
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15f5baf960000=
0=0A=
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50d4af03d68a4=
70c=0A=
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db2c197f98f86543=
b69c8=0A=
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  =0A=
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)=0A=
> =0A=
> Unfortunately, I don't have any reproducer for this crash yet.=0A=
> =0A=
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:=0A=
> Reported-by: syzbot+b2c197f98f86543b69c8@syzkaller.appspotmail.com=0A=
=0A=
Oh... When the queue is initialized and the elevator initialization done by=
=0A=
elevator_init_mq() is executed without the queue sysfs lock held. In that s=
tep,=0A=
if the elevator initialization fails, blk_mq_sched_free_requests() is calle=
d and=0A=
will trip on the lockdep_assert_held(&q->sysfs_lock) check on entry. I gues=
s=0A=
that is what is causing the crash ? But I thought lockdep_assert_held() onl=
y=0A=
spits out warnings...=0A=
=0A=
Ming,=0A=
=0A=
Your patch c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_init_=
mq")=0A=
removed the sysfs_lock use in elevator_init_mq(). With that, should we move=
 the=0A=
lockdep_assert_held(&q->sysfs_lock) call out of blk_mq_sched_free_requests(=
) and=0A=
directly call it lockdep before calling that function (that's ugly) or do y=
ou=0A=
see a nice trick for handling the special case that is the first initializa=
tion ?=0A=
=0A=
Cheers.=0A=
=0A=
> =0A=
> ------------[ cut here ]------------=0A=
> WARNING: CPU: 1 PID: 25817 at block/blk-mq-sched.c:558  =0A=
> blk_mq_sched_free_requests block/blk-mq-sched.c:558 [inline]=0A=
> WARNING: CPU: 1 PID: 25817 at block/blk-mq-sched.c:558  =0A=
> blk_mq_init_sched+0xad6/0xc00 block/blk-mq-sched.c:543=0A=
> Kernel panic - not syncing: panic_on_warn set ...=0A=
> CPU: 1 PID: 25817 Comm: syz-executor.4 Not tainted 5.3.0+ #0=0A=
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  =
=0A=
> Google 01/01/2011=0A=
> Call Trace:=0A=
>   __dump_stack lib/dump_stack.c:77 [inline]=0A=
>   dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113=0A=
>   panic+0x25c/0x799 kernel/panic.c:219=0A=
>   __warn+0x22f/0x230 kernel/panic.c:576=0A=
>   report_bug+0x190/0x290 lib/bug.c:186=0A=
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]=0A=
>   do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272=0A=
>   do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291=0A=
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028=0A=
> RIP: 0010:blk_mq_sched_free_requests block/blk-mq-sched.c:558 [inline]=0A=
> RIP: 0010:blk_mq_init_sched+0xad6/0xc00 block/blk-mq-sched.c:543=0A=
> Code: f6 e8 9e 03 00 00 49 83 c6 10 4c 89 f7 e8 82 08 37 04 e9 ce fd ff f=
f  =0A=
> e8 c8 81 3f fe 48 c7 c7 72 5c 35 88 31 c0 e8 1d ae 28 fe <0f> 0b e9 ce f9=
  =0A=
> ff ff e8 ae 81 3f fe 48 c7 c7 72 5c 35 88 31 c0 e8=0A=
> RSP: 0018:ffff88802225fbb8 EFLAGS: 00010246=0A=
> RAX: 0000000000000024 RBX: 0000000000000000 RCX: 489d2508ed9c7100=0A=
> RDX: ffffc9000e9a6000 RSI: 0000000000009af7 RDI: 0000000000009af8=0A=
> RBP: ffff88802225fc50 R08: ffffffff815c9744 R09: ffffed1015d66090=0A=
> R10: ffffed1015d66090 R11: 0000000000000000 R12: dffffc0000000000=0A=
> R13: ffff888026958990 R14: ffff888026958080 R15: ffff8880269580d0=0A=
>   elevator_init_mq+0x317/0x450 block/elevator.c:719=0A=
>   __device_add_disk+0x6d/0x1140 block/genhd.c:705=0A=
>   device_add_disk+0x2a/0x40 block/genhd.c:763=0A=
>   add_disk include/linux/genhd.h:429 [inline]=0A=
>   loop_add+0x5d1/0x780 drivers/block/loop.c:2051=0A=
>   loop_control_ioctl+0x422/0x640 drivers/block/loop.c:2174=0A=
>   do_vfs_ioctl+0x744/0x1730 fs/ioctl.c:46=0A=
>   ksys_ioctl fs/ioctl.c:713 [inline]=0A=
>   __do_sys_ioctl fs/ioctl.c:720 [inline]=0A=
>   __se_sys_ioctl fs/ioctl.c:718 [inline]=0A=
>   __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718=0A=
>   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290=0A=
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe=0A=
> RIP: 0033:0x459a09=0A=
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f=
7  =0A=
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
  =0A=
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00=0A=
> RSP: 002b:00007fce60497c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a09=0A=
> RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000006=0A=
> RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000=0A=
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fce604986d4=0A=
> R13: 00000000004c3118 R14: 00000000004d69f8 R15: 00000000ffffffff=0A=
> Kernel Offset: disabled=0A=
> Rebooting in 86400 seconds..=0A=
> =0A=
> =0A=
> ---=0A=
> This bug is generated by a bot. It may contain errors.=0A=
> See https://goo.gl/tpsmEJ for more information about syzbot.=0A=
> syzbot engineers can be reached at syzkaller@googlegroups.com.=0A=
> =0A=
> syzbot will keep track of this bug report. See:=0A=
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
