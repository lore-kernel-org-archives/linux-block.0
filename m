Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D95C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 21:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242D460E90
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 21:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbhH3Vnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:43:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56419 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhH3Vnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 17:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630359776; x=1661895776;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=j33mjOGyFABGvqHwqilaolXFMnSiMjDql0BWn4WqRmc=;
  b=jrPzdXvHK9kD7yCUXYugShpg7ww/EGYhgHo53k/VD/Cki+wewFfnsryu
   TpWfaEtKMfMLlQl9II4m2lstmaC5gNXcyUGqvSfUlKIJglG9VRsaYK7Ev
   PVtNSoVPEc/IlZgWvqrRlUjfifX5hUPTpTruWeObjySNXn1+KBxTzQ0m7
   wutZIFEbTIjPEQguEPRa9CzC1zCjT7MdtkXEJnNltikgvfGViP7shl3i4
   8rVqMbOEzbcjYEAs19RUOZbTR6+R5US6bcuSBBrzjzTPsY+CoO+jDWNPc
   iJaoRaV3unyvi0nerGiiFtf7YL5Ch3TkmGHL+eCjlrkfbZg+Upbx5tpNQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,364,1620662400"; 
   d="scan'208";a="183576969"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2021 05:42:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPohk1Pn6DBaTzT3snfTRGryhl9YYFE6zDbp0e8mmNlpF7W5qodNZsoNIW/KY7k5drR5cWfqLEoCuCzr6tGH6AkkDFATYxKUd5ZVgt4awpLbklobjATcIalVFzMsPEXhNqEaYDcwHFog04QT20M3/0Yb1PEg8+2YbiY3oYobPNKz4/Lgoez2mULi6sU7R7kum9+88C1d5kCKvr/1WgiVxvhyyDRYyWcfTopYDDrV64cFoR/t6YzqQ6WEsvWlL6tg1Akd5tHf+u0lJT5GIeud0aZSj/oGk9Zw4RINTWzqEMNbmN2hYePkBPssuzZrVEoEgzA/Sk3W+vQr0JGy7PE4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUt2SIhUHsG5Coj+mAmEykXb7DqIIYxB8r5tfneL4a8=;
 b=ldDW/RAZktbub1O5BD7Q/kLTRq3wh2koj6pa2u7V6wMHfe7TCP+X6OWDxjU98lhUJzxhvLlGRl3rAz7/hlbXx/ofNPi2dkN4MC/J9VrEjAFUxiYzwQsLbBw183J0u85z+l4tWwO+oHquCbhesANOAwNaqXEaA4PwoTX2cQ8nJ0doHBzVvPqSIb1Qv1EhxnIf1NgWmLN50VQ3Mu/50xoxVxj3nNKLZKWsfbGzYnWWmhmcalm06h4kbiCBzdQV+knzkzooV7d5D/BS1hquZtgM7ZNiOm2pl05bOYETYotPsY5BKDd/Y3VWmHAEek0R4DezAavFyPOmR+iPYJo2hcK6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUt2SIhUHsG5Coj+mAmEykXb7DqIIYxB8r5tfneL4a8=;
 b=Hn7sHV7qq3dRoXPHHvVaZtzothjHfTu3O5SuoGUA6oYZuf42IeXGQaiNfgKKpqEhEDAuB88iIJi1A2MQeKj189aL89y5wXyJWl5BD5HhiLBBQOEuM0GBDMXCrAPZOTGG+u/bvoeMaS4k6zXS7C6ug2ySmD2LUybZCU8ZVPdv3m8=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5881.namprd04.prod.outlook.com (2603:10b6:5:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 30 Aug
 2021 21:42:54 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 21:42:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Topic: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Index: AQHXmohup054y2Fbq0CVF3wAgGvrJg==
Date:   Mon, 30 Aug 2021 21:42:54 +0000
Message-ID: <DM6PR04MB7081BB19D1F07EFE4534870DE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
 <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
 <6ad27546-d61f-a98a-1633-9a4808a829ba@kernel.dk>
 <CH2PR04MB7078A227EF9087A45CF4535EE7C89@CH2PR04MB7078.namprd04.prod.outlook.com>
 <9953a4f0-841e-9a94-d451-4b8ac889d62c@acm.org>
 <DM6PR04MB7081A6BD32CE97BE4149FFFAE7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <ed6f98b8-232e-808b-83b7-98432b5a2450@acm.org>
 <DM6PR04MB70817A17F89A5654A46F3729E7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <cb651839-bc72-5b85-c531-af28b84dcbaf@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bc678b9-19b6-481d-d49b-08d96bff1fe2
x-ms-traffictypediagnostic: DM6PR04MB5881:
x-microsoft-antispam-prvs: <DM6PR04MB5881B498C825DBF8B2AB2BA2E7CB9@DM6PR04MB5881.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Y98p33jiUXD5m+pf++AiLSDzFbgHW2FMy7/amlyzRli/lvADsHlQsVkWjplLiSQhHRskGmiF+piSIi7QK+2LByidFQuvuzSGVUUj0/b9dFv3MaBLkD2adTb6X65pKci9J4IjMdWumhYdkNMhHulHoBQKb1uXiTTYQJcoaEQ+9iEs5ND4NYWZSpkx4kmJwrg21SP8qi18JuaUiPVQEP76TbgLX/vr03+q0mNRjyWbj8HonwlNb1FXZqRyR3/FPS9enFNx7ngtdKIU6c8IzyEBpsqQ/Jn8Q0nbA14GojhysWyaTEM853jN8/Rvct0xhFeSCI6w7s/fs21RtWMpB0Swc91wMf+Iz9pYQ/ocITp0dAY8GYpY6BZp8m01ktpVhBuDzJI362bVdHHT7Wk6MNnjBnLWJOcxOlVCxlafcq/zRwejfDpq3TH0As0qqR2inwHGjMxzwF1qIqi1k9IK32kpGps9pIm2K3YwGSvZ8Hdwxg6AV7IRoX6g4s8+4DYa9fl6eqdNwFPnTm88L/+X0nWF+cea1x7daKexDuDg4tVkfP9nu+haQnwmb3xrBQOyMqgdMWYcepQQsK3ounJxau89s8xZ5MxSIe9FP+xMswOtuQnKBy29vmijDTx4NSBL62SOYfr3tswulBdwwZRJ06V4q+mXuJVGQOzePKQn7mjIxjBkfxcuwJpmG8KZ2Upta1euK+r8HesFE044pUXJiQcyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(71200400001)(5660300002)(83380400001)(38100700002)(55016002)(9686003)(66476007)(186003)(66556008)(38070700005)(76116006)(478600001)(122000001)(52536014)(66446008)(53546011)(33656002)(6506007)(8936002)(66946007)(7696005)(316002)(8676002)(86362001)(2906002)(110136005)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RdudS6FrAkh5xlZ1av7zCjj9qzMS5r3vhz2jSAdsco9Ur56g5EdmNewFHzIX?=
 =?us-ascii?Q?ns3s5grA2ZESA/bOAvVRfA2ylJ8gTPqmrMVe8RG5IrMcOLPhR5fijjaozOX8?=
 =?us-ascii?Q?hpMYxdNcb1nAjtYaO30vSixLDWnKjoXOVtjHMWbSMBu9PXGq/ORBslo+wPOM?=
 =?us-ascii?Q?uZEswJppJ/JVgDfT8u2wt5sWA6IgnWwiyc8tyjt4b7vUMdKRH7qGrZ8XqX+Z?=
 =?us-ascii?Q?redBcyzeuq7OZStRqZjzfdicWTy4LsMjrj37sz1Ilu22KG8KZojE4VZ/nOxX?=
 =?us-ascii?Q?ML52f6aQt6MBNaYc72JnpCxdhwf3Pt7qNG+tqoCiTucjpvCyYDMeKJq4N5D6?=
 =?us-ascii?Q?Gug+UZ2B9UsABAxAgcQxtsw74yG6PcZZdqd8GwSnrD9vHgSj7cj6vaJrUPqy?=
 =?us-ascii?Q?VT1dMnnLg6fl0hzHKGpP4kn5Y2CZxKcq91RGcgH3V54oOMgLu7GIF8wwvKIg?=
 =?us-ascii?Q?LBh4+gZ1oksSiq6XXq/9E7CQXNpy90WmXAV5O2TJFqlI19axejVp9GUE3nUl?=
 =?us-ascii?Q?+dRX4D230/7+3fXwW3hj1wGbnHO2ilV1rJa4kFteRMHVIA+mB+qMU0yT9xZG?=
 =?us-ascii?Q?uPToxtPyW1VCKJmcANrs/GKkKpnFggC2y+l/tiy3Rs+VWI2zOBw1ys+aTRWe?=
 =?us-ascii?Q?B49yG7rhKzD9fYCh6D5q0Xbogy6QetG4AnYp/8OJheKDnNLYaNfrQ3tRXv75?=
 =?us-ascii?Q?oNV/b4YhDWgly4OqzZkkNCAJjYdBhPWa0tibb1B1n3Bl7gO1i1vptCQbATJ0?=
 =?us-ascii?Q?w15A8zc+XMpp1OHt6p8tsF2OPu4aYWwbN/Jxie4U4hQeHczNKfpWF4b+CVlm?=
 =?us-ascii?Q?EVrW1Tg3cA8/ak4zVACBOmYouqfYXsfKH07RvC1wNvxlQLha69A30zLTMr8j?=
 =?us-ascii?Q?3oeAt9NNwD5KkfrPZlOS6pewBAmtJrx3WQRduIAyyOKxIpfCpsSTNjt1KMy/?=
 =?us-ascii?Q?tRwHTMN4MW/EkmWV4kf2Pwf9vWrp5y6yDz2xlcWmEy8H9+3DCeKMSqpjrDyI?=
 =?us-ascii?Q?4zlbPw/JryxooZ4cZw8jCnvIo97NLO3gHGrVJaQLZMV6qEAavcusmZQXjAoK?=
 =?us-ascii?Q?1oUIW9GSFwNzBvYyJ9NIz6nHdqffL8fJvqBlqLbrKmrmGEpwPpb6jvs8kcDC?=
 =?us-ascii?Q?ap4D7y9sEQhIUArTU5ka8D889Aan4Kpr4TR2vADY8/3E9MbwCX+Z6wmxLgNu?=
 =?us-ascii?Q?E5RcFx3qMzKoCjzKbhmXGTFAYHHkc3Iu2+H9OPiztIaydJvtiK2JM+0gsr/G?=
 =?us-ascii?Q?VzESNdigQtOnPd3WWjUrXMOXngMRdC2ACwWNhqqNgF3KOYBkNTh1ugMpQHIk?=
 =?us-ascii?Q?ZDTWU1lKIZ9qsCv6sUGbRDt1yg7w3pSfmGYrbEtYTRXDI/HlUzLcHF/a2Hgj?=
 =?us-ascii?Q?rytMs0/c91dp8vTwM9A0WJkUCpZvFUaRBP1+Ob02xJ6HPPkKMA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc678b9-19b6-481d-d49b-08d96bff1fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 21:42:54.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnFnd06eJcXozanfYA7QpaM4OD8f+lyehdCIdMeOUQ8Tm64YuCX3ZTpC+ViVQWN5Tcle2DDTsrbek5Ao9zp0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5881
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/31 2:14, Bart Van Assche wrote:=0A=
> On 8/29/21 8:07 PM, Damien Le Moal wrote:=0A=
>> On 2021/08/30 11:40, Bart Van Assche wrote:=0A=
>>> On 8/29/21 16:02, Damien Le Moal wrote:=0A=
>>>> On 2021/08/27 23:34, Bart Van Assche wrote:=0A=
>>>>> On 8/26/21 9:49 PM, Damien Le Moal wrote:=0A=
>>>>>> So the mq-deadline priority patch reduces performance by nearly half=
 at high QD.=0A=
>>>>>> (*) Note: in all cases using the mq-deadline scheduler, for the firs=
t run at=0A=
>>>>>> QD=3D1, I get this splat 100% of the time.=0A=
>>>>>>=0A=
>>>>>> [   95.173889] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kw=
orker/0:1H:757]=0A=
>>>>>> [   95.292994] CPU: 0 PID: 757 Comm: kworker/0:1H Not tainted 5.14.0=
-rc7+ #1334=0A=
>>>>>> [   95.307504] Workqueue: kblockd blk_mq_run_work_fn=0A=
>>>>>> [   95.312243] RIP: 0010:_raw_spin_unlock_irqrestore+0x35/0x40=0A=
>>>>>> [   95.415904] Call Trace:=0A=
>>>>>> [   95.418373]  try_to_wake_up+0x268/0x7c0=0A=
>>>>>> [   95.422238]  blk_update_request+0x25b/0x420=0A=
>>>>>> [   95.426452]  blk_mq_end_request+0x1c/0x120=0A=
>>>>>> [   95.430576]  null_handle_cmd+0x12d/0x270 [null_blk]=0A=
>>>>>> [   95.435485]  blk_mq_dispatch_rq_list+0x13c/0x7f0=0A=
>>>>>> [   95.443826]  __blk_mq_do_dispatch_sched+0xb5/0x2f0=0A=
>>>>>> [   95.448653]  __blk_mq_sched_dispatch_requests+0xf4/0x140=0A=
>>>>>> [   95.453998]  blk_mq_sched_dispatch_requests+0x30/0x60=0A=
>>>>>> [   95.459083]  __blk_mq_run_hw_queue+0x49/0x90=0A=
>>>>>> [   95.463377]  process_one_work+0x26c/0x570=0A=
>>>>>> [   95.467421]  worker_thread+0x55/0x3c0=0A=
>>>>>> [   95.475313]  kthread+0x140/0x160=0A=
>>>>>> [   95.482774]  ret_from_fork+0x1f/0x30=0A=
>>>>>=0A=
>>>>> I don't see any function names in the above call stack that refer to =
the=0A=
>>>>> mq-deadline scheduler? Did I perhaps overlook something? Anyway, if y=
ou can=0A=
>>>>> tell me how to reproduce this (kernel commit + kernel config) I will =
take a=0A=
>>>>> look.=0A=
>>>>=0A=
>>>> Indeed, the stack trace does not show any mq-deadline function. But th=
e=0A=
>>>> workqueue is stuck on _raw_spin_unlock_irqrestore() in the blk_mq_run_=
work_fn()=0A=
>>>> function. I suspect that the spinlock is dd->lock, so the CPU may be s=
tuck on=0A=
>>>> entry to mq-deadline dispatch or finish request methods. Not entirely =
sure.=0A=
>>>>=0A=
>>>> I got this splat with 5.4.0-rc7 (Linus tag patch) with the attached co=
nfig.=0A=
>>>=0A=
>>> Hi Damien,=0A=
>>>=0A=
>>> Thank you for having shared the kernel configuration used in your test.=
=0A=
>>> So far I have not yet been able to reproduce the above call trace in a=
=0A=
>>> VM. Could the above call trace have been triggered by the mpt3sas drive=
r=0A=
>>> instead of the mq-deadline I/O scheduler?=0A=
>>=0A=
>> The above was triggered using nullblk with the test script you sent. I w=
as not=0A=
>> using drives on the HBA or AHCI when it happens. And I can reproduce thi=
s 100%=0A=
>> of the time by running your script with QD=3D1.=0A=
> =0A=
> Hi Damien,=0A=
> =0A=
> I rebuilt kernel v5.14-rc7 (tag v5.14-rc7) after having run git clean -f =
-d -x=0A=
> and reran my nullb iops test with the mq-deadline scheduler. No kernel co=
mplaints=0A=
> appeared in the kernel log. Next I enabled lockdep (CONFIG_PROVE_LOCKING=
=3Dy) and=0A=
> reran the nullb iops test with mq-deadline as scheduler. Again zero compl=
aints=0A=
> appeared in the kernel log. Next I ran a subset of the blktests test=0A=
> (./check -q block). All tests passed and no complaints appeared in the ke=
rnel log.=0A=
> =0A=
> Please help with root-causing this issue by rerunning the test on your se=
tup after=0A=
> having enabled lockdep.=0A=
=0A=
OK. Will have a look again.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
