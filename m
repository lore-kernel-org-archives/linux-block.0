Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13768C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 03:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED38760F3A
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 03:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhH3DIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Aug 2021 23:08:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6771 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbhH3DH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Aug 2021 23:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630292824; x=1661828824;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yHwLWqQDhVS5ZMYB0hd65Q2oxcRsi0oyaZ+3uSuJE2Y=;
  b=XVE41Seh9ofyplxowARjylkGdagFtP6XQSo+3/76ifmfEx9MOkeGwKjG
   wJKaVI6M/6Yj4RT0nlCpqdhejXX3qgD6eTBTI9jQe9YbW4M9s1yU7g7PG
   qmgdDevOJPh9yWN/ke+1RH6zXAmlUxicr0VHbmbo+roRQ6JEsP+JUgx+a
   4Ee8giToU9oncR693jC2wm/mzbcm8I7JopUQDjqKLWbHE/yqiATM+rQ64
   +X3rRGtBVjKH9BAH8aJFUIcCRp69bEUOMMjXorN3+MF0Zin/TA08HGrLU
   wO5mZptoexF8ro4BOxTocS2iu1efQAntbyNBTjwmEIzQ2KeNVQMEflTD5
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="282516646"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 11:07:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USlHcsK/1PVTKrTt1QnUnpKX1L9zuCfbVMIuFTLIokxDWPl9E4RDtSbvfcsQuvd3zJ2KjT9pj7NjlH4js9wZO/UY4JfhHqKg6tLrqRu4ddo8Z8PBBLSRHu5LTcyZ6cKlwYVGiWhtIu+/1JNNHiWKX2i/rQ07DWGCZj8gFzBZ9+e1r2lcu610d7YQT3GGL1LiPbd4gA6JlslFyO9ZgoFKcX0C/LAunV1QkE1YtndxXT3HZ8UaytUaKF0wFL5tJeTISr9vdnJQFBf2V57t2J5Ckr+lhtmxEdOQ9J7CW7W3lQTWRJY3e5kAGQXDMKF5BAMlGbGz50UOVszYeJOYMdM06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2ynbDZfkIk/GxrI28QcRGWlOn2mdLY/Xce9CHW9Yts=;
 b=Yi52Lv9Q7EGD7E2/hl/MP1Um+87wNuzz2vGA/5cVDoGMB8ZOCC3lCTVi2KlJlnlgAzxulHOsE4De+1er0sv3qeTO9LMb+EHvDOmn7UJK871nExoV6ee+njQkE292eggXbJkMr9AulpWYC4sgt/dTX97N3h+ak7qrHo0zbCsZv+NXSRV09clgg0cQRElfqihbxZVT0BWjqckZDkeawr7w5xYoc1Vig/DA0usB14ackMYJptQizJ1tTklUG38Y66pWmEhTOtYxqG0WYVSBSNAegSx41xZFU23qS8XlxXRceGJxdaiFpH7oEEVHDLCTxOaBA6z0Psd6iAxv8dlkcavmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2ynbDZfkIk/GxrI28QcRGWlOn2mdLY/Xce9CHW9Yts=;
 b=oTKZstH/YG4j0ivcZnRNysmYofNPeIPaMZ1y8rNH/yYAuADzLAAvUNsDM3e6o/m6TOgVMO4LPcvuvgGPcSgUnFBufqUgEZJy1brby0z085XAmX+RmEbCMREixLur1yR+eJ1jHyxIATN+Gv/FBq9TXMaNy4SM1AnDlCScvAMGA3E=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6076.namprd04.prod.outlook.com (2603:10b6:5:12a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 03:07:02 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 03:07:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Topic: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
Thread-Index: AQHXmohup054y2Fbq0CVF3wAgGvrJg==
Date:   Mon, 30 Aug 2021 03:07:02 +0000
Message-ID: <DM6PR04MB70817A17F89A5654A46F3729E7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
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
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d85e04d-086e-4e2e-cd44-08d96b633d5d
x-ms-traffictypediagnostic: DM6PR04MB6076:
x-microsoft-antispam-prvs: <DM6PR04MB6076C771BAE452D46928CCB2E7CB9@DM6PR04MB6076.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1VB/UoRYO2ntTDqp9iqC2bkXcJg/rsGVCJHWjz8lLUTsiPmYwrfLruJi9lsTmuaJUkOdNFFH+QXHvtqdttFwIC5I2oEWb0wga2T3u48MQaJVTzmN+QUz1WlMRRMMzuPfEVAl5sYr88wg+TI++gRT4e1LOJlDxta0f8oYlpJA/1Soi6jEnP8muDretgNymJVKR9I/b1OxCfT0WQ0Ox4s42zwXzorfriioFXM99BbtK7xdZae8kbDiWi49+LdzzUeHl/9WHHSrD3rxnYbz3Im4tx2iUxx7vuYpTkYrgNThLxJyBcI+fAD+E8wYlBARY7NS8M6OzIshyus1PXHuZqDIZSDpSIDHBhPpKQo9GsmDHnybg2UxOdy+0q3bi0vKku4unpIglWIegbFaQd3wZUVvgvuHv/Qv9yh9z7D1eR6KYlv+k6gumVxsg2tzUxUkMCeIdm2xMzdOZKqWNiAGbJA++J8vJU9Mb/wTx92wkPDtUfdmNaGzbdEZi2cidX65Uga//VGERwRpyF/Lg39PnL1lEJRZ+9DrInSECOpOUw+UdS6/Jqi5T1yYh4bvf2HcqsHZd1C4RJf0UDIZOZIIiQ+05mQ6RnJx5HJcy3rZtf20x39hplw+sobyvdm9XGSNRdE08oBekECepO69nwU8ppYvgo25fOxTBLh5EvhbfXL1o6USXVwtvkE1v1t/Wl4gR1GH1pN/SknOkdgY4BzOTzlQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(110136005)(76116006)(66946007)(316002)(83380400001)(86362001)(2906002)(122000001)(8676002)(52536014)(53546011)(6506007)(66446008)(66476007)(64756008)(186003)(478600001)(55016002)(33656002)(38070700005)(71200400001)(91956017)(38100700002)(8936002)(5660300002)(7696005)(9686003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K3q2N+j8ZfM7qApLL0/K8chWKvaEDMGCbtAkGkG91+gNtWFeMhHLtFjBWcVr?=
 =?us-ascii?Q?Wn16zcSSLUuXfH78WchYtEC281eUBPTAdQ+m6aCdePq6lHNWT/bzvsYMKVxF?=
 =?us-ascii?Q?96YCivPrVlJdrywd5/gilc/axCnVKSMs5x/18T6j8dimWgTuGsI7c7pU9OlX?=
 =?us-ascii?Q?v4FnrrS1M6FLK2gNhMgnpoAY2dL28f9S1LRm2XuIzrTapycHAt07zTQFvHaQ?=
 =?us-ascii?Q?zwyjo03qrgjPy3XUWnTudskHmzZSO7Lc4/j67GI8y5J/iNXqlyGSP5Eiw6Cy?=
 =?us-ascii?Q?1hWMnxS+1h6vQc3RyfLj4FusfBtsX0EnSP0a0oHJgSZN54nsPv25so78SJ6S?=
 =?us-ascii?Q?Qx7nPp23mfgfKe8KyDyOgKDexzr358lRfjNFfyx1PScwR7vjkW1VfprCjhsa?=
 =?us-ascii?Q?bD+VwGtBvNXX47lqOcFGhtUp24MjqR3QEcY3M05SbTVk3kX/SSNd8uFJ6SCg?=
 =?us-ascii?Q?udG64JX2/HZZhvdSfccugJi6KfgP0dkvLJ8y4g2ELtxzZz4AK+iBsoXHQDFA?=
 =?us-ascii?Q?6Dx9AfhmgNrmigboNw+QRE6RFP36drWfT298lEN9uBfWZxnJumbwWDbNpNCx?=
 =?us-ascii?Q?ZaqSxa0iJ8BtDrJI/p6D5/yZ5Eo3JnQCgNwKLoO3xkt8bYJ6SAfKZZ3QFDZ6?=
 =?us-ascii?Q?mX9rPRxNIrR9cPyIFJNEb5uUIZk8UszYkMpOxArdrY6XRpPt99mJqRCqFnjs?=
 =?us-ascii?Q?idGGNUMRKShkVFUAYCNgncQfPEdQP7gAZa43ex/K1un71bjMWjzfOhMB69yC?=
 =?us-ascii?Q?N9zT+d46IBWsOR5WMZutdBm+bxPwRp0UPH0uRj817AebtXWYEz6OVoZxi9vV?=
 =?us-ascii?Q?qhBpbG/z1cGA25tBqAMdYsf6gnkmn8uiqEviLCcVqJTpMDRKlCCHxUPhOmBB?=
 =?us-ascii?Q?psjNRMeHtJOIb5xTg5PvHWfnSgVqBsJS9v/2XgCQIKgERTZsRtdFakxTbTXY?=
 =?us-ascii?Q?qG9q4/7JGWTvpLgDVCZp1zlT2AfCYbE0j0/luUeoE04H7Tnb5u58wAqcmp5a?=
 =?us-ascii?Q?SLbEPFVRlAn4b+mTqrqPE7mNPTmZdar44VSKsulX2i779vVzvsUdahFOlHh3?=
 =?us-ascii?Q?n2by2QXjbHRUssmCLCdzZ2eQHoLa2W8F5LBTXqzlUaROfZAgQgtZuHEDazXx?=
 =?us-ascii?Q?m6JQcyRX+P/YQ+mt2npziurDxSG4BxTLUYExUZlfXEpHmY7JYAKCBNWtdD7z?=
 =?us-ascii?Q?0DY4oitlFAw9LIQDuRVPAyngKQ4bOxqErJxap+s/ca3gnoAjrcq6XrHAg9Qz?=
 =?us-ascii?Q?5T3J81BbJha7OtfKW9npT1NM4fQ2TV/8oGdC6qkAkXrHX07MubwLsE+/SVP+?=
 =?us-ascii?Q?Vy2CqDSoHTD/nOFvj0unZsBUt7F+SmG0OK3E0kluoAFAN9o1GbqQ9t6KRaHj?=
 =?us-ascii?Q?ecNo3RIdQjJB7m/JEMueHCp2Ny3p+Tb2znfDJqO/plEQq4I/SQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d85e04d-086e-4e2e-cd44-08d96b633d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 03:07:02.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTNMa/U5KRJ6GLnR4g1eCJ/wTk4tSeLTcNt/RnakDu6UnqoDgsQcghK0/Z+cPZePiwIzlFqGWl2UKYpPUH5/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6076
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/30 11:40, Bart Van Assche wrote:=0A=
> On 8/29/21 16:02, Damien Le Moal wrote:=0A=
>> On 2021/08/27 23:34, Bart Van Assche wrote:=0A=
>>> On 8/26/21 9:49 PM, Damien Le Moal wrote:=0A=
>>>> So the mq-deadline priority patch reduces performance by nearly half a=
t high QD.=0A=
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
>>=0A=
>> I got this splat with 5.4.0-rc7 (Linus tag patch) with the attached conf=
ig.=0A=
> =0A=
> Hi Damien,=0A=
> =0A=
> Thank you for having shared the kernel configuration used in your test. =
=0A=
> So far I have not yet been able to reproduce the above call trace in a =
=0A=
> VM. Could the above call trace have been triggered by the mpt3sas driver =
=0A=
> instead of the mq-deadline I/O scheduler?=0A=
=0A=
The above was triggered using nullblk with the test script you sent. I was =
not=0A=
using drives on the HBA or AHCI when it happens. And I can reproduce this 1=
00%=0A=
of the time by running your script with QD=3D1.=0A=
=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
