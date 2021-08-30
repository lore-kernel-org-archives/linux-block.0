Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872FC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 03:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4906B60F3A
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 03:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhH3DG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Aug 2021 23:06:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:9125 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbhH3DEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Aug 2021 23:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630292639; x=1661828639;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Eh5pckAR+U0TPPa32QN804f3JRGJDlTIbXbFbdrrpoc=;
  b=MXeQz7uZ4/JrRxpy2RQywM/beeKOuJBtmlxXd0MDVILQe6cWg6LTXQaR
   CsoaYKq10qDgjVtbFx29HP6o1IChzsfaMmJzNZDg2oJSw3yijx2xAABG5
   Xb9miXBeAjM44hvPa0P57SNoDGN9pyD3yPbDx8YteeKZruYthsD8BFs0O
   b7dNH3u5ufvzEfuZZ1NPnF06zfzt4z6bjOKFUYLrvIsGSpxHzpbqo0WbH
   T0Tmbqci8WrguGVN8Pt5zz62IuZgIALWS58Z3JNo8oSz+whtPc2ghfIfR
   rvSJ2qvN+X5CSeximpLcmBkWX3JYeByvHDKfnoEZrQKiOLynlu9rwkamR
   A==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="177837841"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 11:03:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3GBRGC88ZsfZuWcYfsu0pkuB/M5FSMqJNSk/tlA+aXHD4cQ2ZtSBF2bOB0IfCpxPMy1rVlS3RxtPv94MT1ADte6e6YHG5/aDHPMjEvPRXbHnyoClO4Z/aCY+0/Y59BNpbFhAeUsuYIqZvV1qtq/JW5VDD90Nl7lESQZeNI/SqLThujik0sharax05DluLOO5FS3dLVw0oumMDDUzNOtHGPgiJaR8by55LPYnPTNOIX5v8irnsbGyOi8GjF7+zsji5vGcEoKT8L1fOqlCgb5C1LgEQ/GiQXiKQ4RiTVQfkWcuOHyvy6FfQgba0gwCXFrh3a/YtJMOxfJeLvCD8Y2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm1kxadzMjVqm6E/8b7tKEuDN4R2GMop9W6elOWwciM=;
 b=i3O5sV2uio0V0DrwFxfe1bCb9Z3eFVxuR9mIhMCYDFSrNE0heexy7n269h+HGrSlsqB6s3cqkIIwwMHvZcmssXSLWT0ONYnHdj55OEu+EiqvSoW+1ywDcdxKZfYaYG/B+XhwBvK3SA7ayAT8Y6a0NKgCs3SA1PAPVdlMgWwYsRIETl8JOK9kL3Fu0tXyENxFT9Elm9gndNbG9ac9UUB6kY76jZ+SL/3kfQarPxRAEeXgDHVP4vShQgSbSVPujYK5qNI3SHEwNBmnV6wHpy90FKir5nDhct/TjJubB9/9J12OAOQ7/0aP+V/RzZlbm0jLCP0DuN3jVg4/iz2PeD0SrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm1kxadzMjVqm6E/8b7tKEuDN4R2GMop9W6elOWwciM=;
 b=WZ0vgvzDfYvpc2Lf1B+dCk1TZyiYj3xcMDrh0VjghkPxnVOMjk4wn5fWaA4ecpahf7jqdvx3m+WDK9Uewki4zAbNI+UD3VrgJuZ8cqN7mLqWFWmZcQD5i7L7dqLdo9woY+JtUjPMKuNqmJWyWJ6miwy/joD17V5eP0kPuid3Vl4=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR0401MB3637.namprd04.prod.outlook.com (2603:10b6:4:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 03:03:55 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 03:03:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Topic: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Index: AQHXmohup054y2Fbq0CVF3wAgGvrJg==
Date:   Mon, 30 Aug 2021 03:03:55 +0000
Message-ID: <DM6PR04MB708173E3AA6AEFFC4971FEADE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
 <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
 <CH2PR04MB7078A227EF9087A45CF4535EE7C89@CH2PR04MB7078.namprd04.prod.outlook.com>
 <9953a4f0-841e-9a94-d451-4b8ac889d62c@acm.org>
 <DM6PR04MB7081A6BD32CE97BE4149FFFAE7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210830023145.GA15087@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a3a4197-e423-40dd-fbb9-08d96b62ce10
x-ms-traffictypediagnostic: DM5PR0401MB3637:
x-microsoft-antispam-prvs: <DM5PR0401MB3637728B1EE9DA444CDC1820E7CB9@DM5PR0401MB3637.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+UWUdQhMj+2qMaebtDaHE2qZifT7cgOJt3Wy9Ia4ezK60v6LdAh9EdfZYPeSvbxPzRQLXHDrlMbz7pF8Ukkh18aHW54OOaGH1WoppOi2LBDffgEZ2iJ0a3GiYdhxrSSO5OIwsV7+rNjGZgWfYjGYBDjPsocUP0yXGa/rS3G3UU0bP42Brh8ru+XA38rDzmwK4fkviuC4t8Ivzyp2w6XZGb+JfOuUXdz9Z7Qn7Oi6Z9m8h9NSQJmskYa2zEdEz6voAE9fnvH4lK21XqDP8PoRF04zogTusQezmmJStCZF5v0+A9okinwtpI1BGRB0W4s8AOAeScYxVQmEnMnJRcmI5Mw6QROm8EwI/7oJJ8mG8gRVhKdDDnqVzrYdQYZUuw74Id2U3VuGiZsbjXYCakWnxnHzigasrT3H1SDli8r+ybf/b+GlUXO1OqDVLNCV8/f4sAHlzv14FZTO1UQazI9TiG86sJ00e2jWKUvOAsFSshEQiuzK6/LVwdtUHz/hJGp4Bnk21cnyTUA0IYfqXqFZmKeOx1YKzeEsdziTzeygAUUDDUhS8AkBHTo30/98caW4MA2kQaF5RTvrBAMxahgsnEZmLzMYCMSIccBjZee6ahs/0qXIi8vVClLd4oECv2GJhCOH5EpL86/7bWXi0Y4iNS+E8bp1hOe5cn+2M9hLaZV0F6Edf1ukA3FzCTIKQtzpTI6ogdUuAVN7E07/2YbcZaUeYyjXZvFGHbq34OPyMTgQwJJYeAgNz1+DHoncjVuT4SjNgYId6dG2ZW2XKyOoXysDoxKeHKLnPCPm+UV+NQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(55016002)(122000001)(9686003)(4326008)(966005)(66476007)(66556008)(64756008)(53546011)(66946007)(86362001)(478600001)(66446008)(91956017)(76116006)(2906002)(38100700002)(6506007)(71200400001)(33656002)(38070700005)(186003)(8676002)(8936002)(316002)(54906003)(52536014)(7696005)(83380400001)(5660300002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yd5wkWHcGkV4GuBPLmjzDv1Tei7+3ZPvuonFJlrA3HX8dr0t/waoWZTyB9tf?=
 =?us-ascii?Q?ejNN/VER8T1uh2JBAKV3TT5CaLFNqRDG+03AHKV3NJJ0Vmxm2yQY4SXZWvzY?=
 =?us-ascii?Q?6zIUf7OOgifm3VZZVovEM+1dc7x2LV7NAEFFhqTasDw7e5LF9lktZMTwk9fv?=
 =?us-ascii?Q?8TAlhNRoGpDTz4xQfUZUSx1i9DmpQEVJwwKJwTBYYFEzpxdVYs6cGBcGGD1g?=
 =?us-ascii?Q?pyZ5p+K/rrGHZ5unXYdrgWfDauKqNSDdl9VwEGhKi7dPbH/QGY0G959r0pj7?=
 =?us-ascii?Q?SWuVsY5ByXnew3Pgy/AJICuoE7Orr2Pi9oKq7v6AMcbbOaj6Span++ZR8d1K?=
 =?us-ascii?Q?gtuLQamiR1jUyCSeGIgZDcBeSG9T0OFMsAAulXlHq/i2IXak7jSJUGdU5NzJ?=
 =?us-ascii?Q?zpawWtrDD7v6owu98PuXPj0SkFZBmfmlJ76vaqZYFJW9ZRw6UWCKQf5MTdTr?=
 =?us-ascii?Q?bvKp6w28WBhD+79fTph0gn3z6IsD+ghS6NUo2hi4SZIuLvnMP34B6wisKLxS?=
 =?us-ascii?Q?I4aCuBLVFjJl7fivfeDQq3S7raXIdipg6+ErVqQPNN8YNLp4haGNx/seekoY?=
 =?us-ascii?Q?OAS0oXRWOfQxMqI5aAH5XScBF+zY7kwAmnM6zw060GCRp+2nigAjp+eEju5b?=
 =?us-ascii?Q?gUmmcVB8NDwgKMoXLj9AygOMRTZbT0EOxmCJ/mCZN0cEimbjQFfuGjlpjeK4?=
 =?us-ascii?Q?RBjGe8qzqvFcHkarfLYr3ZQ5UlMSQW108LfymRYrkYE69Y4USVr6tVX2tDIj?=
 =?us-ascii?Q?JBTpHavBK6wYraJvHqPuySKnUzbxkRRX9iMCPl81q0nWMGk8inKHvMequm3E?=
 =?us-ascii?Q?6U5udtDY94xR3l0n+LgVFn2gQANcC1/tvLxfocw8dZa8evBgekf3z6b2qjoM?=
 =?us-ascii?Q?UMsXUbmb2a4kCpZ730zLOaEc9yKUJ4EgDuI7QvS9M7ClIjdAjBw9RKMQ7SvW?=
 =?us-ascii?Q?BYbPwPMHrV4d7sW4Dg0ZjQSDSkxLLWE1DeSBX1Fn7NTjZt/s8shp3QpcegN3?=
 =?us-ascii?Q?iIesrLBiKuJHndgckp5QgLCrMIMXRUDiWIjLmw8usuaNjlpcHUSAJ7RluL9Q?=
 =?us-ascii?Q?ZuRIiRL3toobhLKHrQAlFa0BTAJFL7nsaKgit0ipOi8779BLAH4gjhoeqmdi?=
 =?us-ascii?Q?8UpfH9aDD2TCVvHqg0rWCjbPwA65QK+kX0Fltfeo0VRaCSeomZpAc4LxV2AI?=
 =?us-ascii?Q?XCOMYxGlWW+bP5Dn7c+iHmZR01zBZlgWFZdyhOl3N+9PNXFjmu/wwWxXPHkf?=
 =?us-ascii?Q?oXFNMXPVVDTc2ust1z0LFPT+z77vMRVsAlakErq1/Oee0AJrdXedPQGVDhX4?=
 =?us-ascii?Q?vZf1HeB5U/erstFoRQEe5REKxSglyVhLojRJYVi4a+zB5eMmZJ7jr7dCNEvt?=
 =?us-ascii?Q?MxWrO0FUO8ndGeWd/Ev4JiVM+wraepZoaRToIr7P3wg0ASCBUA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3a4197-e423-40dd-fbb9-08d96b62ce10
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 03:03:55.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dn54tm1a96d1bkcI4aCmq6MJqt1V1GByWjykjjnZ+lCP3ms31n8SiX5jlCh2lTPm79ztx72puN9zUz63S0DSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3637
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/30 11:32, Keith Busch wrote:=0A=
> On Sun, Aug 29, 2021 at 11:02:22PM +0000, Damien Le Moal wrote:=0A=
>> On 2021/08/27 23:34, Bart Van Assche wrote:=0A=
>>> On 8/26/21 9:49 PM, Damien Le Moal wrote:=0A=
>>>> So the mq-deadline priority patch reduces performance by nearly half a=
t high QD.=0A=
>>>> With the modified patch, we are back to better numbers, but still a si=
gnificant=0A=
>>>> 20% drop at high QD.=0A=
>>>=0A=
>>> Hi Damien,=0A=
>>>=0A=
>>> An implementation of I/O priority for the deadline scheduler that reduc=
es the=0A=
>>> IOPS drop to 1% on my test setup is available here:=0A=
>>> https://github.com/bvanassche/linux/tree/block-for-next=0A=
>>>=0A=
>>>> (*) Note: in all cases using the mq-deadline scheduler, for the first =
run at=0A=
>>>> QD=3D1, I get this splat 100% of the time.=0A=
>>>>=0A=
>>>> [   95.173889] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kwor=
ker/0:1H:757]=0A=
>>>> [   95.292994] CPU: 0 PID: 757 Comm: kworker/0:1H Not tainted 5.14.0-r=
c7+ #1334=0A=
>>>> [   95.307504] Workqueue: kblockd blk_mq_run_work_fn=0A=
>>>> [   95.312243] RIP: 0010:_raw_spin_unlock_irqrestore+0x35/0x40=0A=
>>>> [   95.415904] Call Trace:=0A=
>>>> [   95.418373]  try_to_wake_up+0x268/0x7c0=0A=
>>>> [   95.422238]  blk_update_request+0x25b/0x420=0A=
>>>> [   95.426452]  blk_mq_end_request+0x1c/0x120=0A=
>>>> [   95.430576]  null_handle_cmd+0x12d/0x270 [null_blk]=0A=
>>>> [   95.435485]  blk_mq_dispatch_rq_list+0x13c/0x7f0=0A=
>>>> [   95.443826]  __blk_mq_do_dispatch_sched+0xb5/0x2f0=0A=
>>>> [   95.448653]  __blk_mq_sched_dispatch_requests+0xf4/0x140=0A=
>>>> [   95.453998]  blk_mq_sched_dispatch_requests+0x30/0x60=0A=
>>>> [   95.459083]  __blk_mq_run_hw_queue+0x49/0x90=0A=
>>>> [   95.463377]  process_one_work+0x26c/0x570=0A=
>>>> [   95.467421]  worker_thread+0x55/0x3c0=0A=
>>>> [   95.475313]  kthread+0x140/0x160=0A=
>>>> [   95.482774]  ret_from_fork+0x1f/0x30=0A=
>>>=0A=
>>> I don't see any function names in the above call stack that refer to th=
e=0A=
>>> mq-deadline scheduler? Did I perhaps overlook something? Anyway, if you=
 can=0A=
>>> tell me how to reproduce this (kernel commit + kernel config) I will ta=
ke a=0A=
>>> look.=0A=
>>=0A=
>> Indeed, the stack trace does not show any mq-deadline function. But the=
=0A=
>> workqueue is stuck on _raw_spin_unlock_irqrestore() in the blk_mq_run_wo=
rk_fn()=0A=
>> function. I suspect that the spinlock is dd->lock, so the CPU may be stu=
ck on=0A=
>> entry to mq-deadline dispatch or finish request methods. Not entirely su=
re.=0A=
> =0A=
> I don't think you can be stuck on the *unlock* part, though. In my=0A=
> experience, that function showing up in a soft lockup indicates you're=0A=
> in a broken loop that's repeatedly locking and unlocking. I haven't=0A=
> found anything immediately obvious in this call chain, though.=0A=
=0A=
Arg. I misread the stack trace. It is an unlock, not a lock...=0A=
=0A=
> =0A=
>> I got this splat with 5.4.0-rc7 (Linus tag patch) with the attached conf=
ig.=0A=
> =0A=
> Surely 5.14.0-rc7, right?=0A=
=0A=
Oops. Yes.=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
