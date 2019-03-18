Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430CC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B229F2084F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 11:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mRK/eRQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfCRLIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:08:40 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:27456
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbfCRLIj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 07:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m79MolMY9q4CeGJuP9uNMfdWXBMrNaanIkdAOAIti4k=;
 b=mRK/eRQHtdepjzWoT4jy1fF5hp0IaC6/HMdagCVgELdpAC12ROni5X31NGAKvDaIs/HaCbthOO6FJcIVcrJ7D7CtSkjH/k6GGOSyoWqx15Tj6Wr9aRTpVlvmSnXewvCvcUFg3KLryrqndrT5xPX03xseiOaZHZZNDNjQDJ8csPI=
Received: from HE1PR05CA0175.eurprd05.prod.outlook.com (2603:10a6:3:f8::23) by
 DBBPR05MB6588.eurprd05.prod.outlook.com (2603:10a6:10:d1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 11:08:34 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by HE1PR05CA0175.outlook.office365.com
 (2603:10a6:3:f8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 11:08:34 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1730.9 via Frontend Transport; Mon, 18 Mar 2019 11:08:33 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 18 Mar 2019 13:08:31
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 18 Mar 2019 13:08:31 +0200
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Mon, 18 Mar 2019 13:08:28
 +0200
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
To:     Yamin Friedman <yaminf@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Yishai Hadas" <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        "Tariq Toukan" <tariqt@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
Date:   Mon, 18 Mar 2019 13:08:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(189003)(51444003)(199004)(36756003)(93886005)(65956001)(65806001)(316002)(16576012)(58126008)(229853002)(47776003)(126002)(476003)(110136005)(6246003)(356004)(2616005)(2201001)(2501003)(8936002)(86362001)(106002)(67846002)(11346002)(31696002)(23676004)(2486003)(76176011)(77096007)(53546011)(26005)(446003)(81156014)(8676002)(81166006)(6116002)(3846002)(14444005)(2906002)(2870700001)(65826007)(16526019)(106466001)(7736002)(478600001)(336012)(305945005)(5660300002)(561944003)(54906003)(64126003)(186003)(486006)(31686004)(50466002)(4326008)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6588;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f73e51a9-4bc3-4e66-d4b8-08d6ab920fce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6588;
X-MS-TrafficTypeDiagnostic: DBBPR05MB6588:
X-Microsoft-Antispam-PRVS: <DBBPR05MB658820B4E54C2AE4F67E2690B6470@DBBPR05MB6588.eurprd05.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: B7WAoXTWP8dACKn7PF/MQBU//J8W1KqWsdMDn+xcWhL1THy21VgrRO4PjYnY6Ck2J+6doL/jhi4RlD90nqzKsEz5UCvybB4UcLxcehxAMSg3sh++UNBQWLMs84gxKYY5ThglpspqP6XeJchCC04pqLr1LeX++DDDc+bRboNTQgv2KQMoPfXNGJdsbFKzxlNhz5uHPpzKRzIiChw8w6mmdu7NFAjx/fA3Qcv7sr1wCiP66yZDb1Rdwhob+BeryHnO94P1ezTNd4Rxj78YNIqUs6HhSA5Ppe9mYKKCbqLuO4UD7PNB9RccPtcEzgzuTe+e5mIVglJR2ZvDV3qeRXZH8fhaKo7hks9c5Xh8mDPG+yuUSU1meIzNElA5lw/x2REyZ7UwpnH5g9JNNhnLdMaB4Bi7pXcvUgRs+WyfMwGLCnk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 11:08:33.4999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f73e51a9-4bc3-4e66-d4b8-08d6ab920fce
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6588
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/18/2019 11:24 AM, Yamin Friedman wrote:
> On 3/14/2019 1:45 PM, Max Gurtovoy wrote:
>> On 3/7/2019 3:56 AM, Sagi Grimberg wrote:
>>>>> net_dim.h lib exposes an implementation of the DIM algorithm for
>>>>> dynamically-tuned interrupt
>>>>> moderation for networking interfaces.
>>>>>
>>>>> We need the same behavior for any block CQ. The main motivation is
>>>>> two benefit from maximized
>>>>> completion rate and reduced interrupt overhead that DIM may provide.
>>>> What is a "block CQ"?
>>> There is no such thing... Also, this has no difference
>>> if a block/file/whatever is using the rdma cq.
>>>
>>> The naming should really be something like rdma_dim as it accounts
>>> for completions and not bytes/packets.
>> Sagi,
>>
>> I think that in the future we could use it in nvme since there is an
>> option to set the interrupt coalescing in NVMe spec.
>>
>> This might improve performance for NVMe driver.
>>
>> We already see some bottlenecks in performance (maybe driver ones)
>> while developing the NVMe SNAP feature in Bluefield (NVMe emulation
>> using Smart NIC).
>>
>> We're trying to get 2.5-2.7 MIOPs OOB from 1 controller and it's not
>> trivial for today's driver.
>>
>> So let's take this into consideration when we set the naming.
>>
>>
> I agree that blk is not the most successful name, we were trying to find
> something that would work for general storage applications. I think
> rdma_dim would work as it is completion based but then when we want to
> use it for nvme it will probably require code duplication.

agreed for rdma_dim.

Yamin/Idan,

let's discuss internally regarding Sagi's proposal for 
moderation/coalescing per NVMe queue (and not per controller).

maybe need to update specification.


>
>>>
>>>> How does net_dim compare to lib/irq_poll?
>>> Its orthogonal, its basically adaptive interrupt moderation for
>>> RDMA devices. Its sort of below the irq_poll code. It basically
>>> configures interrupt moderation based on stats collected by
>>> the rdma driver.
>>>
>>>> Which approach results in the best performance and lowest latency?
>>> I guess it depends on what is the test case. This approach tries to
>>> apply some time or completion count limit to when the HW should fire
>>> an interrupt based on the load in an adaptive fashion.
>>>
>>> The scheme is to try and detect what are the load characteristics and
>>> come up with a moderation parameters that fit. For high interrupt rate
>>> (usually seen with small size high queue-depth workloads) it configures
>>> the device to aggregate some more before firing an interrupt - so less
>>> interrupts, better efficiency per interrupt (finds more completions).
>>> For low interrupt rate (low queue depth) the load is probably low to
>>> moderate and aggregating before firing an interrupt is just added
>>> latency for no benefit. So the algorithm tries to transition between a
>>> number of pre-defined levels according to the load it samples.
>>>
>>> This has been widely used by the network drivers for the past decade.
>>>
>>> Now, this algorithm while trying to adjust itself by learning the load,
>>> also adds entropy to the overall system performance and latency.
>>> So this is not a trivial trade-off for any workload.
>>>
>>> I took a stab at this once (came up with something very similar),
>>> and while for large queue-depth workloads I got up to 2x IOPs as the
>>> algorithm chose aggressive moderation parameters which improved the
>>> efficiency a lot, but when the workload varied the algorithm wasn't very
>>> successful detecting the load and the step direction (I used a variation
>>> of the same basic algorithm from mlx5 driver that net_dim is based on).
>>>
>>> Also, QD=1 resulted in higher latency as the algorithm was dangling
>>> between the two lowest levels. So I guess this needs to undergo a
>>> thorough performance evaluation for steady and varying workloads before
>>> we can consider this.
>>>
>>> Overall, I think its a great idea to add that to the rdma subsystem
>>> but we cannot make it the default and especially without being able
>>> to turn it off. So this needs to be opt in with a sysctl option.
>> We can add flag in create_cq command that will
>> try_coalescing_is_possible instead of module parameter of course.
>>
>> Storage ULPs can set it to True.
>>
>> Also in the internal review Yamin added a table that summarize all the
>> testing that were done using NVMeoF (I guess it somehow didn't get to
>> this RFC).
>>
>> I guess we can do the same for iSER to get more confidence and then
>> set both to create modifiable cq (if HCA supports, of course).
>>
>> Agreed ?
>>
> I think that adding a flag in create_cq will be less clean as it will
> require more work for anyone writing applications that should not have
> to consider this feature.


As we discussed, let's check with RDMA maintainers if it's better to 
extend alloc_cq API or create alloc_cq_dim API function.

Sagi/Christoph,

how about adding a module param per ULP ? as we use register_always 
today, create a use_dimm module param for iSER/NVMe-RDMA ?

>
> Based on the results I saw during testing I would set it to work by
> default as I could not find a use case where it significantly reduces
> performance and in many cases it is a large improvement. It should be
> more of an opt out situation.
>
> Performance improvement (ConnectX-5 100GbE, x86) running FIO benchmark over
>       NVMf between two equal end-hosts with 56 cores across a Mellanox switch
>       using null_blk device:
>
>       IO READS before:
>       blk size | BW      | IOPS | 99th percentile latency
>       512B     | 3.2GiB  | 6.6M | 1549  usec
>       4k       | 7.2GiB  | 1.8M | 7177  usec
>       64k      | 10.7GiB | 176k | 82314 usec
>
>       IO READS after:
>       blk size | BW      | IOPS | 99th percentile latency
>       512B     | 4.2GiB  | 8.6M | 1729   usec
>       4k       | 10.5GiB | 2.7M | 5669   usec
>       64k      | 10.7GiB | 176k | 102000 usec
>
>       IO WRITES before:
>       blk size | BW      | IOPS | 99th percentile latency
>       512B     | 3GiB    | 6.2M | 2573  usec
>       4k       | 7.2GiB  | 1.8M | 5342  usec
>       64k      | 10.7GiB | 176k | 62129 usec
>
>       IO WRITES after:
>       blk size | BW      | IOPS  | 99th percentile latency
>       512B     | 4.2GiB  | 8.6M  | 938   usec
>       4k       | 10.2GiB | 2.68M | 2769  usec
>       64k      | 10.6GiB | 173k  | 87557 usec
>
> It doesn't really make a difference to me how the option is implemented
> but I think it makes more sense to have it dealt with by us such as in a
> module parameter and not something like a flag that has a larger radius
> of effect.
>
>>>
>>> Moreover, not every device support cq moderation so you need to check
>>> the device capabilities before you apply any of this.
>> for sure.
>>
>>
