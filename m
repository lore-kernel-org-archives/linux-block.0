Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4BC10F25
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 03:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A8720728
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 03:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MhKBYvEe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mpPoqZbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCJDHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:07:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52565 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCJDHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 23:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583809664; x=1615345664;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cu7wvgOHIrb0rF2kflC+5CeoEC+M6d23nxNzq434F+U=;
  b=MhKBYvEeKBTvWGmDWmnwuE/cOcdYQcMun8OEr2bamfWROTHZxH9F4pIc
   OS46sbATwT0g1Kf5hoHGPMsMul7KRkXuj6I+RA18EAPFzJioXSIdK2R9V
   57FuEJdX/1G2QEDJBUNNdcFANrUWkkZj775CRENayyaVmeI00Zv84Po7m
   w8tBuZTcTvyYPr4zbu4QGldvNQu3AyYpgNOSLvY1ZF80vA0wAKi0Dvwlk
   xiR116/eEKtACMqQlVRKaiixTH/p+YgV0FDPuy6UtMXBDtZswBFxj5ay7
   cY7ipmi/9GYTFl5IJ5VOB+qWTajfPE4rizfFxqZnnWdxmb9fVvDFoEh2s
   g==;
IronPort-SDR: 857nMt26dBC0ctro9TUWRRtnEbdhcy5MBJIJktXgwHXK+raTiAgycPqEgtOmvAMK4rB+7/+UD/
 I07rg61ICD8rpyLHPGc78KHFtbSgksN8CUs3onhfFtf8PPV6GbzuBSV5r3QJDL1Xq/o3Hb3EiP
 8bImz6HfKxEaKc6OpgSFsmRVDJYMJaKrMp+2d4JPylREBPv6uMGUVlA072Tsg+meyeSVgV34jk
 7uk93adJcsFV+wtZ0hY/sL8Y8HaT+uX2xRc2fzJQSPiZlSWPRNpSDeUr5XDnPlcyn6gWt/tGGu
 DLc=
X-IronPort-AV: E=Sophos;i="5.70,535,1574092800"; 
   d="scan'208";a="132029265"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2020 11:07:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUaNDm+zN5kzGIy0MSD/Se7c3TcEax2/pqBWtGza3c31A0BTGjvvVajWTxCEUNVXNzt6uzhlD1q94CcmLE24ydmka9Ko18eC8GX6rsHinUcB6LNvmYcy7G2KNczUYYiy6cRbi9fGOUtCbN/6MQ6bZ9ybXFCI1mFZbMYotUAgZhFvA6lrM1PIdK/SqW4J+6+A2Z6XJcAf65PQ4wP502gghgDqneF7V3DksB5FTfMXFdpAbrtWNhO/2fZiGtpheSKTOYQ8zZh2ibiNFduPmbtn+IgGnqzc6wYgKq+ixOxfo+r+Z/bbdteiwyVw6sDkVVkbPiRXhGS1HMMjyN6oz+Do8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PT0grNzh7o1M0JGhQvGX+ILLbVznB8R/+APGBwrT7g=;
 b=EdJk7vZt0Cpay9MF/VfTLzMhWAZqx5yYuqX4rfGY+HCOXM3nHy5Yi/GEL4oCoMWKY1ROLh/Y5hudEpYLbr+3kXvwR25nI5fx/U5oHptUgTjDItoC+EZLX019Pz2l1N9DooZ4E21uZUiIa5pleuWgZEow1iUhV9LqgZbRhqz1ttYn6NTqg+r8vnRGphn6pexMfmW7CM/2ks8fERgI5t3bZj6N1qWv/jpbZR312i6HgKFF95kjcYLtkAfgM0frkkqId/MHkrnUktJIwlCdPBToofbb0K7e255um6V8JIKpwFI53rtltLW7QTp3frl4yxx0JoVFWRnBvUy8HS8B9ZmQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PT0grNzh7o1M0JGhQvGX+ILLbVznB8R/+APGBwrT7g=;
 b=mpPoqZbF8d0+X/X7LhDPolSGO/Lsmn/5YSchl1pupfACfmIwCQP7Qmd2JmQcyPHy15OjyVSUgFe44rhgAfUaE+TuhuU1Mepn42W2KNQw86m63CNCoZQUNZt/IpS9SZPAaeOLPBEAc95MuRbVRWgwU6dR4ddD4vZrTdo9QckcewE=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (2603:10b6:a03:10e::16)
 by BYAPR04MB4950.namprd04.prod.outlook.com (2603:10b6:a03:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 03:07:42 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:07:42 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Thread-Topic: commit 01e99aeca397 causes longer runtime of block/004
Thread-Index: AQHV8c4FlOkNXDceTU6Nwl3i3vnr/A==
Date:   Tue, 10 Mar 2020 03:07:42 +0000
Message-ID: <BYAPR04MB5816C428F1E23B1030579887E7FF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200304034644.GA23012@ming.t460p>
 <20200304061137.l4hdqdt2dvs7dxgz@shindev.dhcp.fujisawa.hgst.com>
 <20200304095344.GA10390@ming.t460p>
 <20200305011900.2rtgtmclovmr2fbw@shindev.dhcp.fujisawa.hgst.com>
 <20200305024808.GA26733@ming.t460p>
 <20200306060622.t2jl7qkzvkwvvcbx@shindev.dhcp.fujisawa.hgst.com>
 <20200306081309.GA29683@ming.t460p>
 <20200307010222.gtrwivafqe2254i6@shindev.dhcp.fujisawa.hgst.com>
 <20200307041343.GB20579@ming.t460p>
 <20200309000715.sqgsssrauzmmpli2@shindev.dhcp.fujisawa.hgst.com>
 <20200309161430.GA4871@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [2400:2411:43c0:6000:9183:2c1d:9c5e:d831]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 596fc968-3e10-45b5-7ae8-08d7c4a032dc
x-ms-traffictypediagnostic: BYAPR04MB4950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4950B76532FF1AFB414B5452E7FF0@BYAPR04MB4950.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(316002)(110136005)(54906003)(64756008)(6506007)(66446008)(86362001)(66476007)(66556008)(966005)(53546011)(4326008)(71200400001)(478600001)(8676002)(8936002)(81156014)(186003)(81166006)(66946007)(6636002)(76116006)(33656002)(66574012)(7696005)(9686003)(55016002)(2906002)(52536014)(5660300002)(148743002)(60764002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4950;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k8YdKjzarIuH35WSV1anDj36eqX0JP+h9d8Aqoq9cp9wQ8OkhhKVgamy64iuWucVZXnqGvj7GBEAdZiHMXypDUQOFNFUDlx+m56AEfqI6+egRiTj7t8C/ulvXKvQObP3X1RWKUoBKc0eOp7eLlWIA3OyQOyDEEidJkdzhvdn+l9O/uIQVADUNCbIoGqH3jD6fTDDYIZnEGae0fqFQg8vNme+s47z4t3o7kN6z6ZCEQPDvqm/8UGw2dS/rRCk+cq39xlSVfqUW8p+F79w2a2LoEpEXeAQ+dBOBsToSqN+eXFDpLhUz7IKkLgLcFd2pt1bZXYhTxcRX642L8iW/d3lcfrJbSg4rcVRQ6AQhr5CkISomx9xjZ70vpjTmaET4iNpcWo03jgilM5JPvVoeIPWBeAiIleF3d/sNPpfWDyBmRUXu7uQ8qlPbHezk+NPxPXVVGvnCM98Rzwk+6wjPqoiaiUobq1bMRCum11vYpZJy8wSZjwnwIGR/B5Kf2vQYJf1r3SrELWd/ExMmven2kXiEa2eMCVa6SalVkrOmoTb6MY5y5Qy+ThEpzoMZP6LznyzeIohZc7cyYVQRw9bPXJRlXQBqRASzbQ5Vyb9m0UHj1B70N2vW2pN0RCHpfQoCm75
x-ms-exchange-antispam-messagedata: iB4uhPg4YVTj3j9KlA8qC4xLbVc2ZJCDN+9W5yGhxEwsGyk1imTqk604GDZoO6YzMIK8pPkgga9ZT+Kknc7SzXVnL2q8GWeWBcEEcueSejkiVVSzMyKaMZTYc5EK0SJEWd6QWpLOv8I1kDzLpWDkbLS1sYiRf36VP1NeJmvrWW0LqIXW5791baQtgECtUMkXMqHa3r6G29v+GVlhbbq0PA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596fc968-3e10-45b5-7ae8-08d7c4a032dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 03:07:42.2396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOAYBE6XUqG//zdIK1NldFhRdTpVWEn1Xp/o1XKeEbbyJR/hU5wv868p7jadZb7NVKStFZ21qXRQXIOQlbGVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4950
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/10 1:14, Ming Lei wrote:=0A=
> On Mon, Mar 09, 2020 at 12:07:16AM +0000, Shinichiro Kawasaki wrote:=0A=
>> On Mar 07, 2020 / 12:13, Ming Lei wrote:=0A=
>>> On Sat, Mar 07, 2020 at 01:02:23AM +0000, Shinichiro Kawasaki wrote:=0A=
>>>> On Mar 06, 2020 / 16:13, Ming Lei wrote:=0A=
>>>>> On Fri, Mar 06, 2020 at 06:06:23AM +0000, Shinichiro Kawasaki wrote:=
=0A=
>>>>>> On Mar 05, 2020 / 10:48, Ming Lei wrote:=0A=
>>>>>>> Hi Shinichiro,=0A=
>>>>>>>=0A=
>>>>>>> On Thu, Mar 05, 2020 at 01:19:02AM +0000, Shinichiro Kawasaki wrote=
:=0A=
>>>>>>>> On Mar 04, 2020 / 17:53, Ming Lei wrote:=0A=
>>>>>>>>> On Wed, Mar 04, 2020 at 06:11:37AM +0000, Shinichiro Kawasaki wro=
te:=0A=
>>>>>>>>>> On Mar 04, 2020 / 11:46, Ming Lei wrote:=0A=
>>>>>>>>>>> On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki w=
rote:=0A=
>>>>>>>>>>>> I noticed that blktests block/004 takes longer runtime with 5.=
6-rc4 than=0A=
>>>>>>>>>>>> 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: inse=
rt passthrough=0A=
>>>>>>>>>>>> request into hctx->dispatch directly") triggers it.=0A=
>>>>>>>>>>>>=0A=
>>>>>>>>>>>> The longer runtime was observed with dm-linear device which ma=
ps SATA SMR HDD=0A=
>>>>>>>>>>>> connected via AHCI. It was not observed with dm-linear on SAS/=
SATA SMR HDDs=0A=
>>>>>>>>>>>> connected via SAS-HBA. Not observed with dm-linear on non-SMR =
HDDs either.=0A=
>>>>>>>>>>>>=0A=
>>>>>>>>>>>> Before the commit, block/004 took around 130 seconds. After th=
e commit, it takes=0A=
>>>>>>>>>>>> around 300 seconds. I need to dig in further details to unders=
tand why the=0A=
>>>>>>>>>>>> commit makes the test case longer.=0A=
>>>>>>>>>>>>=0A=
>>>>>>>>>>>> The test case block/004 does "flush intensive workload". Is th=
is longer runtime=0A=
>>>>>>>>>>>> expected?=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> The following patch might address this issue:=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> https://lore.kernel.org/linux-block/20200207190416.99928-1-sqaz=
i@google.com/#t=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> Please test and provide us the result.=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> thanks,=0A=
>>>>>>>>>>> Ming=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> Hi Ming,=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> I applied the patch to 5.6-rc4 but I observed the longer runtime=
 of block/004.=0A=
>>>>>>>>>> Still it takes around 300 seconds.=0A=
>>>>>>>>>=0A=
>>>>>>>>> Hello Shinichiro,=0A=
>>>>>>>>>=0A=
>>>>>>>>> block/004 only sends 1564 sync randwrite, and seems 130s has been=
 slow=0A=
>>>>>>>>> enough.=0A=
>>>>>>>>>=0A=
>>>>>>>>> There are two related effect in that commit for your issue:=0A=
>>>>>>>>>=0A=
>>>>>>>>> 1) 'at_head' is applied in blk_mq_sched_insert_request() for flus=
h=0A=
>>>>>>>>> request=0A=
>>>>>>>>>=0A=
>>>>>>>>> 2) all IO is added back to tail of hctx->dispatch after .queue_rq=
()=0A=
>>>>>>>>> returns STS_RESOURCE=0A=
>>>>>>>>>=0A=
>>>>>>>>> Seems it is more related with 2) given you can't reproduce the is=
sue on =0A=
>>>>>>>>> SAS.=0A=
>>>>>>>>>=0A=
>>>>>>>>> So please test the following two patches, and see which one makes=
 a=0A=
>>>>>>>>> difference for you.=0A=
>>>>>>>>>=0A=
>>>>>>>>> BTW, both two looks not reasonable, just for narrowing down the i=
ssue.=0A=
>>>>>>>>>=0A=
>>>>>>>>> 1) patch 1=0A=
>>>>>>>>>=0A=
>>>>>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
>>>>>>>>> index 856356b1619e..86137c75283c 100644=0A=
>>>>>>>>> --- a/block/blk-mq-sched.c=0A=
>>>>>>>>> +++ b/block/blk-mq-sched.c=0A=
>>>>>>>>> @@ -398,7 +398,7 @@ void blk_mq_sched_insert_request(struct reque=
st *rq, bool at_head,=0A=
>>>>>>>>>  	WARN_ON(e && (rq->tag !=3D -1));=0A=
>>>>>>>>>  =0A=
>>>>>>>>>  	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {=0A=
>>>>>>>>> -		blk_mq_request_bypass_insert(rq, at_head, false);=0A=
>>>>>>>>> +		blk_mq_request_bypass_insert(rq, true, false);=0A=
>>>>>>>>>  		goto run;=0A=
>>>>>>>>>  	}=0A=
>>>>>>>>=0A=
>>>>>>>> Ming, thank you for the trial patches.=0A=
>>>>>>>> This "patch 1" reduced the runtime, as short as rc3.=0A=
>>>>>>>>=0A=
>>>>>>>>>=0A=
>>>>>>>>>=0A=
>>>>>>>>> 2) patch 2=0A=
>>>>>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
>>>>>>>>> index d92088dec6c3..447d5cb39832 100644=0A=
>>>>>>>>> --- a/block/blk-mq.c=0A=
>>>>>>>>> +++ b/block/blk-mq.c=0A=
>>>>>>>>> @@ -1286,7 +1286,7 @@ bool blk_mq_dispatch_rq_list(struct request=
_queue *q, struct list_head *list,=0A=
>>>>>>>>>  			q->mq_ops->commit_rqs(hctx);=0A=
>>>>>>>>>  =0A=
>>>>>>>>>  		spin_lock(&hctx->lock);=0A=
>>>>>>>>> -		list_splice_tail_init(list, &hctx->dispatch);=0A=
>>>>>>>>> +		list_splice_init(list, &hctx->dispatch);=0A=
>>>>>>>>>  		spin_unlock(&hctx->lock);=0A=
>>>>>>>>>  =0A=
>>>>>>>>>  		/*=0A=
>>>>>>>>=0A=
>>>>>>>> This patch 2 didn't reduce the runtime.=0A=
>>>>>>>>=0A=
>>>>>>>> Wish this report helps.=0A=
>>>>>>>=0A=
>>>>>>> Your feedback does help, then please test the following patch:=0A=
>>>>>>=0A=
>>>>>> Hi Ming, thank you for the patch. I applied it on top of rc4 and con=
firmed=0A=
>>>>>> it reduces the runtime as short as rc3. Good.=0A=
>>>>>=0A=
>>>>> Hi Shinichiro,=0A=
>>>>>=0A=
>>>>> Thanks for your test!=0A=
>>>>>=0A=
>>>>> Then I think the following change should make the difference actually=
,=0A=
>>>>> you may double check that and confirm if it is that.=0A=
>>>>>=0A=
>>>>>> @@ -334,7 +334,7 @@ static void blk_kick_flush(struct request_queue =
*q, struct blk_flush_queue *fq,=0A=
>>>>>>  	flush_rq->rq_disk =3D first_rq->rq_disk;=0A=
>>>>>>  	flush_rq->end_io =3D flush_end_io;=0A=
>>>>>>  =0A=
>>>>>> -	blk_flush_queue_rq(flush_rq, false);=0A=
>>>>>> +	blk_flush_queue_rq(flush_rq, true);=0A=
>>>>=0A=
>>>> Yes, with this the one line change above only, the runtime was reduced=
.=0A=
>>>>=0A=
>>>>>=0A=
>>>>> However, the flush request is added to tail of dispatch queue[1] for =
long time.=0A=
>>>>> 0cacba6cf825 ("blk-mq-sched: bypass the scheduler for flushes entirel=
y")=0A=
>>>>> and its predecessor(all mq scheduler start patches) changed to add fl=
ush request=0A=
>>>>> to front of dispatch queue for blk-mq by ignoring 'add_queue' paramet=
er of=0A=
>>>>> blk_mq_sched_insert_flush(). That change may be by accident, and not =
sure it is=0A=
>>>>> correct.=0A=
>>>>>=0A=
>>>>> I guess once flush rq is added to tail of dispatch queue in block/004=
,=0A=
>>>>> in which lots of FS request may stay in hctx->dispatch because of low=
=0A=
>>>>> AHCI queue depth, then we may take a bit long for flush rq to be=0A=
>>>>> submitted to LLD.=0A=
>>>>>=0A=
>>>>> I'd suggest to root cause/understand the issue given it isn't obvious=
=0A=
>>>>> correct to queue flush rq at front of dispatch queue, so could you co=
llect=0A=
>>>>> the following trace via the following script with/without the single =
line=0A=
>>>>> patch?=0A=
>>>>=0A=
>>>> Thank you for the thoughts for the correct design. I have taken the tw=
o traces,=0A=
>>>> with and without the one liner patch above. The gzip archived trace fi=
les have=0A=
>>>> 1.6MB size. It looks too large to post to the list. Please let me know=
 how you=0A=
>>>> want the trace files shared.=0A=
>>>=0A=
>>> I didn't thought the trace can be so big given the ios should be just=
=0A=
>>> 256 * 64(1564).=0A=
>>>=0A=
>>> You may put the log somewhere in Internet, cloud storage, web, or=0A=
>>> whatever. Then just provides us the link.=0A=
>>>=0A=
>>> Or if you can't find a place to hold it, just send to me, and I will pu=
t=0A=
>>> it in my RH people web link.=0A=
>>=0A=
>> I have sent another e-mail only to you attaching the log files gziped.=
=0A=
>> Your confirmation will be appreciated.=0A=
> =0A=
> Yeah, I got the log, and it has been put in the following link:=0A=
> =0A=
> http://people.redhat.com/minlei/tests/logs/blktests_block_004_perf_degrad=
e.tar.gz=0A=
> =0A=
> Also I have run some analysis, and block/004 basically call pwrite() &=0A=
> fsync() in each job.=0A=
> =0A=
> 1) v5.6-rc kernel=0A=
> - write rq average latency: 0.091s =0A=
> - flush rq average latency: 0.018s=0A=
> - average issue times of write request: 1.978  //how many trace_block_rq_=
issue() is called for one rq=0A=
> - average issue times of flush request: 1.052=0A=
> =0A=
> 2) v5.6-rc patched kernel=0A=
> - write rq average latency: 0.031=0A=
> - flush rq average latency: 0.035=0A=
> - average issue times of write request: 1.466=0A=
> - average issue times of flush request: 1.610=0A=
> =0A=
> =0A=
> block/004 starts 64 jobs and AHCI's queue can become saturated easily,=0A=
> then BLK_MQ_S_SCHED_RESTART should be set, so write request in dispatch=
=0A=
> queue can only move on after one request is completed.=0A=
> =0A=
> Looks the flush request takes shorter time than normal write IO.=0A=
> If flush request is added to front of dispatch queue, the next normal=0A=
> write IO could be queued to lld quicker than adding to tail of dispatch=
=0A=
> queue.=0A=
> trace_block_rq_issue() is called more than one time is because of=0A=
> AHCI or the drive's implementation. It usually means that=0A=
> host->hostt->queuecommand() fails for several times when queuing one=0A=
> single request. For AHCI, I understand it shouldn't fail normally given=
=0A=
> we guarantee that the actual queue depth is <=3D either LUN or host's=0A=
> queue depth. Maybe it depends on your SMR's implementation about handling=
=0A=
> flush/write IO. Could you check why .queuecommand() fails in block/004?=
=0A=
=0A=
Indeed, that is weird that queuecommand fails. There is nothing SMR specifi=
c in=0A=
the AHCI code beside disk probe checks. So write & flush handling does not=
=0A=
differ between SMR and regular disks. The same applies to the drive side. w=
rite=0A=
and flush commands are the normal commands, no change at all. The only=0A=
difference being the sequential write constraint which the drive honors by =
not=0A=
executing the queued write command out of order. But there are no constrain=
t for=0A=
flush on SMR, so we get whatever the drive does, that is, totally drive dep=
endent.=0A=
=0A=
I wonder if the issue may be with the particular AHCI chipset used for this=
 test.=0A=
=0A=
> =0A=
> Also can you provide queue flags via the following command?=0A=
> =0A=
> 	cat /sys/kernel/debug/block/sdN/state=0A=
> =0A=
> I understand flush request should be slower than normal write, however=0A=
> looks not true in this hardware.=0A=
=0A=
Probably due to the fact that since the writes are sequential, there is a l=
ot of=0A=
drive internal optimization that can be done to minimize the cost of flush=
=0A=
(internal data streaming from cache to media, media-cache use, etc) That is=
 true=0A=
for regular disks too. And all of this is highly dependent on the hardware=
=0A=
implementation.=0A=
=0A=
Thank you for your help !=0A=
=0A=
Shinichiro,=0A=
=0A=
It may be worth trying the same run with & without Ming's patch on a machin=
e=0A=
with a different chipset...=0A=
=0A=
> =0A=
> =0A=
> Thanks,=0A=
> Ming=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
