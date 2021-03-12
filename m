Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D48AC433E0
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EEF64F64
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 22:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhCLWdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:33:10 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38609 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbhCLWcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 17:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615588371; x=1647124371;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ugAdIfK4Y8p2hT1XQ15mQOBrDRJzHYLDOJf0rTiU5r4=;
  b=Pw2otMQb7L32yIyHtA3UPJQT+nYoM6qY/ae2F9aEgIibZrbkbPYSavAI
   dioDl4lGiNf34ERnUwIM8qNQsVCV5M7TetmVA2UoA0tdr9rQZcD27SE1Y
   4BvHeNyf3qK5c6Zg+e8ZEYGrAqOm6LzOUZBWiISUrLplYgbvnFJDMSjwc
   1yPqRV+FYV4H29ONZi89BrigUDyVFo8krm5wDkdqq8oNb+r7L5tJbsUq2
   FQxKiAfiRiCXyUKkc0TvCRhAerztmYLpsEXZbk3iGDfefBTT9lS7aLZx0
   BnftY+efa1BO76AXsUztx8YucZqCuFHH0x7dU/EM05Z9ZPVrnFf6bvlu2
   w==;
IronPort-SDR: 5UbE3DjmiAvdCTUSeO4HpV+gaSjGJLXE2ZY/LPPcDdFh3YGaHXA+ltdBXZlLufZ34+pwhPIu8M
 EghqQNUDYYR88TRqzuMoycSxCHiFGwJhKPHhqcU7ss6EOxLh3Pby0M9eSqF/dUQuFwMTA7NXMk
 AdCpnATNVjF7FoRo0+2uNTgoUWWB4DYtG6dXs3GDxaUHNaSpeBw97SwaDK6AcJ7chHEAcUtsEB
 7sG9hAAgwXoM6sBrbkNJzl7JgDBBKV/kDeB/uccRlFtDYLP/5rDzcGlUOzkGp56a8A1BqmmIk/
 EXE=
X-IronPort-AV: E=Sophos;i="5.81,244,1610380800"; 
   d="scan'208";a="166534027"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2021 06:32:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Am4bvOt/le+xCRBEAOuH/andcpyXrBrSze8+NKJDOyFlLxnYRVFugiHC3KHq1essSR/WpXBXXzEQ/Jebx2X97V68smN+GUjpeIlwDoYu2E72hxiRa3k4EFQbQeqd02UVB+nYKZuF0vaCcSelxJKH3QvfMeC9dOETTtg6q185s4XNMQadyY4EzsCpPp+Ak2Gh+P1jFBAT/j65QYj/wRONx+4ayhTmBrmLcw4D002n1C1fw5BYBCi5M3P60wsfEU7vQLnrqh4iUMSN+pBox/z8H8gCKBIjQXqjaLENdj4sLoAiXczNEmpxZ6NbXUlzGELtfrYjvTMrPxujsZNaJzvcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVe4sQlWCDbVy1T4k5KqJFIziiaQOyL7sLFAYu0UCmQ=;
 b=LYDlH3VPctls2ObBEm0OiIZOTXx+Xe7/YXdDcX/2EUy7i8NYJ4KofxK8CUcyyxnhHLHHidEASduVmWQmVmzEqikVCK4Lmb5jIPxi/FIrrcVtbFTcUOmnRtkZwDSXMDXCyaAVzbRGr0jBUIR6m8jIT3XtYfVUj3+CiHRZNTmOCopHbmOuVlQ2BO2yYjdoPbDape/dCaRT7YJfQANgHOKIodrvguVYrjqrT1F8iDj+v+WG31m7gr+RMOOTD4Vj7zmjy5UZ4kYDCC/8S1xyX+CXxbnEgG/y48wkuCXnUxvyc4PiB5AdecaISv9mt+a3iOrcUEGsF+2QwBxCqd8ovV9uIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVe4sQlWCDbVy1T4k5KqJFIziiaQOyL7sLFAYu0UCmQ=;
 b=EW4ZmQGBYnVEZ8kP4H8fZtJksm5LAj03JvIxa1B0923Zy6dYxnLW7m+1AdhzjNXrh2EbH3Fuv+b++hUF8s2CH+TrO7H05RKiUpmGOHwIijZs2NNeviyWqqwyTc1nxQkgNL7WlRNM8cNSS/Z/gzMUAZlyX2u56gu1mXPoyHDkQwI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4980.namprd04.prod.outlook.com (2603:10b6:208:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Fri, 12 Mar
 2021 22:32:49 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 22:32:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "yanfei.xu@windriver.com" <yanfei.xu@windriver.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix possible bd_size_lock deadlock
Thread-Topic: [PATCH] block: fix possible bd_size_lock deadlock
Thread-Index: AQHXFm/BBdsOQMCsFUCpesdiLb6LDg==
Date:   Fri, 12 Mar 2021 22:32:48 +0000
Message-ID: <BL0PR04MB651467F82F7B303829D2BB26E76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311121139.205222-1-yanfei.xu@windriver.com>
 <af8f7d00-d612-c0d2-e254-ff3c967fb94c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:bccc:6f52:efed:4bfb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bf3a731-b373-4281-5a5e-08d8e5a6c41a
x-ms-traffictypediagnostic: BL0PR04MB4980:
x-microsoft-antispam-prvs: <BL0PR04MB49803F00F106C0C07642FD3EE76F9@BL0PR04MB4980.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ix1rv4yjzxrsF/gHg7Wc1E/nja/aaDIRmBLl9A7fA5f0XlD2/x3VsDfrKpGnrbN5aneywG6T4kRJkK5hQiW+VKuFgCTO6JysPinXIkiM03qlkEyFrbUwh+DildFqKeOolly4S60xkXqEqOZXWvaxakHZ3jkAFuT5dnVuoLo2DbtKbdbCwhTZ3s7pQvk3SneXxdMfz0bXDLrE7uLWWZfY3yeBsfrx7nvc1NnRWcee39EpFEU43IHj2PhqHzapY7vOmG3u+bnQ8hznCt496aqssbSnpS8gOs24rimwlSCa+dz/SaI/XFzyaE7PmYLI+ctqQG9vfLrLY+hvYwAhTJYZ3Oz22beaGRn2sJS0F2mGUdEHZJJ2sUnEoCOeZSAGnEeQ+DKQJ4LkIHmYdpoAbBLjlPmFAbF32StYs15w8akQjUKZIWd1YkuxsdL+vSxZjG2LW5DbFJSxL1pEZqQ2Ek04KlBgAs6E0Jt6zlnBXDsOZxuRhG4+aTOrDzt3a25QcBB2SIT+x+FWATkvaZc+urleniCBiy4y0aiFH0zQyiRrpbrMJMTDIn2cyCfK02W4X4yRpTTSVvcJa7coakIW4T7gGc3BAalkoSQItmIVPWM9uFw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(4326008)(6506007)(55016002)(66476007)(66946007)(76116006)(33656002)(91956017)(2906002)(83380400001)(186003)(7696005)(9686003)(66556008)(110136005)(45080400002)(71200400001)(86362001)(8676002)(8936002)(54906003)(52536014)(66446008)(316002)(5660300002)(966005)(64756008)(478600001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yVCJpoItzRpj8s/r0I75G0MnZOSDwToUrCthSfcKg25ufZzlIScLHQs98l+5?=
 =?us-ascii?Q?XbF5+6ah3i8EWVQl9JDpJuCXJ/6WwOpALxLIhkCybrefJa7/Mn+Oozy4/OjR?=
 =?us-ascii?Q?J0TG1jOaSUa2p3F3rsuZnowTgX7WM7wikOo3/EL6SAM1TMPlGWgIkHiMdM5E?=
 =?us-ascii?Q?orFiDiQaL/eaGgx4LaaAODDYjXTmE0gxGzNjagUEsvwl25n0LTgtV/KgaUHo?=
 =?us-ascii?Q?JeTkKdlvYfZONxWTWNRdaUmOERB8LNOMd5Ao6t2MGbE75kNXL8mj9vMZZDRa?=
 =?us-ascii?Q?O9ZRJ1qhR4wo1f347xY+7XN57rVEPzbUJJxmBr7F05sKQkyF7vDij9bV4+1Y?=
 =?us-ascii?Q?sNzRgHCTm6Vno36NV7l1TEtap1sbxy/JSOAtFXq0HGbkZC2VGBpam3y3STXg?=
 =?us-ascii?Q?wjSVZgq3Usdx1U+aZ5WVwik51licWW+4yz0HWQn90JwNGsnrJkRSrzZUe27q?=
 =?us-ascii?Q?hx9pKQRqbMb6ngyzRUGzAh4ZNMNQmjR3Wt9GJI04i9nMZWTsKdhcCib2p1sH?=
 =?us-ascii?Q?/QkvM7dCnkCy/PleG2nXpzMwCpq8sEwUXo5f1dMYy2mvz1FmEhVO5yjCEJCx?=
 =?us-ascii?Q?I00arNUI8LryQRZr4/8obSg/zIu4OjbwbWLX7PLq5Cl3cWEMpY9n0FP+JuFB?=
 =?us-ascii?Q?91yVBuQR+TQjPyXxMM0XGGSzbBfQiK0BCNLIGmwOWerhAuQ0NXGLEEtwD/yb?=
 =?us-ascii?Q?x8KmZw4rEmqeuG8mVHj+PAMDLh32fYQpZeo+5wRo4HCGmTtklvo2Pkais2au?=
 =?us-ascii?Q?LFpm4ng0JnbFuQHP4sHX2ojBOIJ2U4mVIvfFVtP2ybsUwUbK89SiinCdb4E3?=
 =?us-ascii?Q?gyB3IomN+ENpUSdUfuFdkn7aUQdfOzXeTKt+Vg+u2E7WqDrbOTXLjVm5/g3b?=
 =?us-ascii?Q?fNkHJCYUTby+q4OkTZezdjCgmpBf5MSk7R3jDmzUbU6JhDnHLxk3JhQorG91?=
 =?us-ascii?Q?BuJChFxHOhQdz9W/kyjvnulwYAbJJOMNR+oVF6dnEPGhev4Ipjseu2Nigfhd?=
 =?us-ascii?Q?NgmUcsduwDYMsoeDKcnoxLbLdFHJTWvqISfTU1u3K2gZQVboYpBNAze/OhHJ?=
 =?us-ascii?Q?BCxiadvRENWVHIu1CJ+q/RAYnSVb+6hS0hiweRHsqU6nTOqrvorcox1XFYii?=
 =?us-ascii?Q?lVfF1ziqOcg+2ox6FZ5uuVDXEyole14ZdeegmpQvs02bOd3gJw03XyWZgeY9?=
 =?us-ascii?Q?Q95QzSDJjhoA3IlPHud2hYWQZKwAuu4/xUf3vmChNQk1hEtBCE6LRSJUzRWV?=
 =?us-ascii?Q?H2MuNz0O8whuXj2mmVIgl0T1tsWA53RYXM6LmtE3m7/ZNemp1O/XqNjr1nCX?=
 =?us-ascii?Q?mfCmCuv4QazA4N7y5lbfig1rrpQduqDZuHqc6mv/q5XY/35gspN5GQv54UoU?=
 =?us-ascii?Q?aks8Kv3OGTsKCWroSLzl0mF8V4MSG/mAuh2LTlo/IFtUkHpSZg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf3a731-b373-4281-5a5e-08d8e5a6c41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 22:32:48.9611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d80c+rilVmacZ9ngOXME85050qepviRrA/j7jy7weOHaEEUEeOLNsJwZmGCSPJ8xwiYhfI25OCnX/UDKZiSEdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4980
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/03/13 4:37, Jens Axboe wrote:=0A=
> On 3/11/21 5:11 AM, yanfei.xu@windriver.com wrote:=0A=
>> From: Yanfei Xu <yanfei.xu@windriver.com>=0A=
>>=0A=
>> bd_size_lock spinlock could be taken in block softirq, thus we should=0A=
>> disable the softirq before taking the lock.=0A=
>>=0A=
>> WARNING: inconsistent lock state=0A=
>> 5.12.0-rc2-syzkaller #0 Not tainted=0A=
>> --------------------------------=0A=
>> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-R} usage.=0A=
>> kworker/u4:0/7 [HC0[0]:SC1[1]:HE0:SE0] takes:=0A=
>> 8f87826c (&inode->i_size_seqcount){+.+-}-{0:0}, at:=0A=
>> end_bio_bh_io_sync+0x38/0x54 fs/buffer.c:3006=0A=
>> {SOFTIRQ-ON-W} state was registered at:=0A=
>>   lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510=0A=
>>   lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483=0A=
>>   do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]=0A=
>>   do_write_seqcount_begin include/linux/seqlock.h:545 [inline]=0A=
>>   i_size_write include/linux/fs.h:863 [inline]=0A=
>>   set_capacity+0x13c/0x1f8 block/genhd.c:50=0A=
>>   brd_alloc+0x130/0x180 drivers/block/brd.c:401=0A=
>>   brd_init+0xcc/0x1e0 drivers/block/brd.c:500=0A=
>>   do_one_initcall+0x8c/0x59c init/main.c:1226=0A=
>>   do_initcall_level init/main.c:1299 [inline]=0A=
>>   do_initcalls init/main.c:1315 [inline]=0A=
>>   do_basic_setup init/main.c:1335 [inline]=0A=
>>   kernel_init_freeable+0x2cc/0x330 init/main.c:1537=0A=
>>   kernel_init+0x10/0x120 init/main.c:1424=0A=
>>   ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158=0A=
>>   0x0=0A=
>> irq event stamp: 2783413=0A=
>> hardirqs last  enabled at (2783412): [<802011ec>]=0A=
>> __do_softirq+0xf4/0x7ac kernel/softirq.c:329=0A=
>> hardirqs last disabled at (2783413): [<8277d260>]=0A=
>> __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:157 [inline]=0A=
>> hardirqs last disabled at (2783413): [<8277d260>]=0A=
>> _raw_read_lock_irqsave+0x84/0x88 kernel/locking/spinlock.c:231=0A=
>> softirqs last  enabled at (2783410): [<826b5050>] spin_unlock_bh=0A=
>> include/linux/spinlock.h:399 [inline]=0A=
>> softirqs last  enabled at (2783410): [<826b5050>]=0A=
>> batadv_nc_purge_paths+0x10c/0x148 net/batman-adv/network-coding.c:467=0A=
>> softirqs last disabled at (2783411): [<8024ddfc>] do_softirq_own_stack=
=0A=
>> include/asm-generic/softirq_stack.h:10 [inline]=0A=
>> softirqs last disabled at (2783411): [<8024ddfc>] do_softirq=0A=
>> kernel/softirq.c:248 [inline]=0A=
>> softirqs last disabled at (2783411): [<8024ddfc>] do_softirq+0xd8/0xe4=
=0A=
>> kernel/softirq.c:235=0A=
>>=0A=
>> other info that might help us debug this:=0A=
>>  Possible unsafe locking scenario:=0A=
>>=0A=
>>        CPU0=0A=
>>        ----=0A=
>>   lock(&inode->i_size_seqcount);=0A=
>>   <Interrupt>=0A=
>>     lock(&inode->i_size_seqcount);=0A=
>>=0A=
>>  *** DEADLOCK ***=0A=
>>=0A=
>> 3 locks held by kworker/u4:0/7:=0A=
>>  #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_data=
=0A=
>> kernel/workqueue.c:615 [inline]=0A=
>>  #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at:=0A=
>> set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]=0A=
>>  #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at:=0A=
>> process_one_work+0x214/0x998 kernel/workqueue.c:2246=0A=
>>  #1: 85147ef8=0A=
>> ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:=0A=
>> set_work_data kernel/workqueue.c:615 [inline]=0A=
>>  #1: 85147ef8=0A=
>> ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:=0A=
>> set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]=0A=
>>  #1: 85147ef8=0A=
>> ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:=0A=
>> process_one_work+0x214/0x998 kernel/workqueue.c:2246=0A=
>>  #2: 8f878010 (&ni->size_lock){...-}-{2:2}, at:=0A=
>> ntfs_end_buffer_async_read+0x6c/0x558 fs/ntfs/aops.c:66=0A=
> =0A=
> Damien? We have that revert queued up for this for 5.12, but looking=0A=
> at that, the state before that was kind of messy too.=0A=
=0A=
Indeed... I was thinking about this and I think I am with Christoph on this=
:=0A=
drivers should not call set_capacity() from command completion context. I t=
hink=0A=
the best thing to do would be to fix drivers that do that but that may not =
be RC=0A=
material ?=0A=
=0A=
Looking into more details of this case, it is slightly different though.=0A=
set_capacity() is here not called from soft IRQ context. It looks like a re=
gular=0A=
initialization, but one that seems way too early in the boot process when a=
=0A=
secondary core is being initialized with IRQ not yet enabled... I think. An=
d the=0A=
warnings come from i_size_write() calling preempt_disable() rather than=0A=
set_capacity() use of spin_lock(&bdev->bd_size_lock).=0A=
=0A=
I wonder how it is possible to have brd being initialized so early.=0A=
I am not sure how to fix that. It looks like arm arch code territory.=0A=
=0A=
For now, we could revert the revert as I do not think that Yanfei patch is=
=0A=
enough since completions may be from hard IRQ context too, which is not cov=
ered=0A=
with the spin_lock_bh() variants (c.f. a similar problem we are facing with=
 that=0A=
in scsi completion [1])=0A=
I do not have any good idea how to proceed though.=0A=
=0A=
[1]=0A=
https://lore.kernel.org/linux-scsi/PH0PR04MB7416C8330459E92D8AA21A889B6F9@P=
H0PR04MB7416.namprd04.prod.outlook.com/T/#t=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
