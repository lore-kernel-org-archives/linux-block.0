Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD4C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 10:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiCNKdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiCNKdl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 06:33:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358C43ADC
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 03:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN/VZv3o6U/gGZkC3Yz9nl0zF4AyZgYzswPXmljbsxLJ4+oPzFxtuNDaaCgg/p34FyvFHauNqDwrw8OoM0MnZHty2Q7GtrkMxC8N6nnYyS2c4WuS9bXXGEPyL5yTdoSI80EawlTcaBxrRUWxHibT8q1kGYwMPDeL7XCWwF0zQOcuD7U6QB7CHuxEEAQvekqHyNxGvjCQCCt4i8q20dygd8pjn+YihH5dyOi29uBKx2rzESTFmCLz0LOcftcrCWIZdveQFyvkYaIHG5LrZTNPTOW4jgzzlamW42nWrCqhOph48Vqfcpts7YmsZA0sdDnJ+IY7fiwP+9B77r6PKzy0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0vQLQsTqgjkUwCfOnO0hH/pzJXxOOYILH8B2UuRAO0=;
 b=KGBrJ9dAQh4ZGcYsKPgHkGZxC31sV+8NrhmzGQ3IRKPMJQ+kzN/uVaiZtQ+ROhgbwRjpK1TPBCNK2xdbOBz84ULjdWT80r+VMU4toK+Q2sONoKyIf8JK6fQKguqRjEv8qjAWejmDhROySJ9nv8t+d37gNnEwsoAQaAcqJ9casaT1/d7YtE3gG2K1jvqrd+g/kS8uKqf/RV2hN9bZodQCKC+sRpT5gfiLePFNUlddmpm1EF+qN/hnaYsOX2EV+k6vz9ZBLNBWo1HcXum4riB2QnjD5nDgoxqNfZFatXKgaG+f0b9Wo8JDQOt3OQMKyarGyyx5bb7oAkdwhhtTco0M4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0vQLQsTqgjkUwCfOnO0hH/pzJXxOOYILH8B2UuRAO0=;
 b=lg7yGF7kHmWuH9yq5+tfbaVym+IgSWxmDiR8OP3orjnmadBOocqnPgDCaucToqcrL+ihmogWY9OLIPEp7zIyuPgT7x2DqwU19F4SxMBN2s5c9Qeg/OOPMSKqDGBTaQsvO5bDVShXFEvG1dGSUFko9lgpkjOy6+E70tIoOqRq7xIuc+yHd5MABOqUeT5yTFr0EebC9aB4nCO/nGJOsqdiObk9APyyb/R+sKzWM52C0Uia1yqddB/Wj7zLbhAZNxf423HQ8CSCUvMkqnLf61UorJ8XZuWiHz18BEv8TsPfhAXOl77mzY2pVzLaiHvYATgp2Q1ED3DThCpPJAbSWRmVEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH2PR12MB5531.namprd12.prod.outlook.com (2603:10b6:610:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 10:32:27 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 10:32:27 +0000
Message-ID: <ac61bd0b-19c0-3e65-50eb-f2c012c236b9@nvidia.com>
Date:   Mon, 14 Mar 2022 12:32:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, suwan027.kim@gmail.com
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <c851906c-c619-4e87-3272-9c41ac256052@nvidia.com>
 <Yi8RJHO4XDDKYHAF@localhost.localdomain>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <Yi8RJHO4XDDKYHAF@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43cf8f6e-d708-4906-1d64-08da05a5efa0
X-MS-TrafficTypeDiagnostic: CH2PR12MB5531:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB553179BE4180047C556E4BCFDE0F9@CH2PR12MB5531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1iixAB4Sl/7OR9vnLiuZb4zZQyeeMUQsl6hsdf7+JYdFMH3eOv9AfyW7TV1WCBcB8Dyk7AVKoImRQv1YPkxgtBFdkysdp2FDM78YE5w2KkWmLXZ2FCxq+PrVBuFDXUXxKj37hrepJ20R4u5sAneWhyzWTiBVSP1Omc24hTYM+LQJkWRcPjINq178L6tsoWr3kr83oPiEq0FYYsxgApIXm+Qso/Wy3c4vxkx9Mz3fwfD+BSkHUDJDCReJ9uM21Nxza8W80XEBCP75w4kbpfkEfeQ5K9OfI3wPpT8lvVT1NeOL0tzssl/3vNUSTGM9Tsw+HgYJeZsEium8UzqyQPn/53WmLEutETqZqRzdtYzS0zjXNmY4uBzCReAkHonllpGEp5HM2ykZr4BmvM0vi0N1J4N7N6mP8Zc+2wgj2DyLN+BlxZ+hpOPBC1SM0bMlOlHWC9hYS6vcdS+JkyOgoHkiMBp1k7t8PlFVXlK40qxKPFUg2RHNDPBZeuVgXINRxXs+fMnDWYJ834DeUyNUQpwJ/t4XNsT0he4ITXa25emeL4Mlc9+PblVV6fgWNuNYHHg+LiLUCWrCsCFhr5OHhWWig7zNl7V1bWqSAUPiKRaczZ+Lu0KlrF4IokQj2JNeQEohJvxCZ93Yp0fUGG7gK02DrQQQC2lBitWoJzF7JDK0N6Mah0WqnBVrFqIC4se/Bt/YJ50sHYBm3Q75VhPx3wtve4sXhDYOBodvL/PoUay1BhKUHoRBVJe6VH20nto2uWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(31696002)(66556008)(38100700002)(186003)(83380400001)(53546011)(86362001)(2616005)(6512007)(6506007)(6666004)(31686004)(26005)(66946007)(36756003)(508600001)(316002)(6916009)(66476007)(6486002)(8936002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdDVnEvVUNVUnp6RnhRZXY0QW9XbHdrMVlNM0xxUnZBalZQMER5dEc0aEsz?=
 =?utf-8?B?aldUdFhkaGw3UkpWSC9qYXBIWkkvTkszUHNTa1QraWc3RHgwbS9ENnU2K2FV?=
 =?utf-8?B?NnBIQzQ4VXBBeFRZM3JaVlhHbnpZT3JiNE9GWE9aUmx2L3diYkwzL2VWM0VN?=
 =?utf-8?B?b0FjWDZpWGFzQ2ZYSVJqZ2piVHp4cnR5SHdZNFcvS2hESVZmL0t3NjRkZ20r?=
 =?utf-8?B?dVZxeVBvT2dQTXZVR2tMaGZpbG1oNEQzWDR2OWRnY2ZTMklMYktDdU53Zm9t?=
 =?utf-8?B?ZTBNcmdrekZhWWZJU2pRZ2p3WHZoUDY5UHhybDBlN2JwTUpQYnJyekppQ2FM?=
 =?utf-8?B?c2M4UUxLMTdUY3EvYVM0S2pNZWQ4WFNxM2d3U3l3dXBGaURIS1YwUzFBYkwr?=
 =?utf-8?B?V3lxbGtKK3JBNnk5eGxBc1M2eWlCeXNCSjZrZEFWcVZLblg1Y2pHK3pIbDBs?=
 =?utf-8?B?bUI3YXhsZUo3RXA4K3RwUzJRanM1K28vbnVNbDg4Y3hldUZkYXJQYTBueDBZ?=
 =?utf-8?B?TGk1R3VPUk9jVjhCSTZ1TElzWlJtcXNiSnN0T3QrWGZkN2xzNjJoMXpOL2JK?=
 =?utf-8?B?b3VKcW5tSU1qMmphRGNmOWZxQ2lmWVRXLzRBUzd2MTJRMFpIMnVzb0V4TEJS?=
 =?utf-8?B?SGE2UWFrNUwwOWZVdE04b0FFNVNZbElqUm11RWFSUUFKbjRVRFR6Mmw2MkRv?=
 =?utf-8?B?OUMwN1g3QUhSRTN3MVYwN1NTMEJMVitxWFMvMVE5eFJGSENBQnhPc1hvdEN1?=
 =?utf-8?B?UWh0R1JXb2lreW9Rek91UDU5V0x6dnFpU1J2UjB2TEtyRVZSTmFOL2lpSHhs?=
 =?utf-8?B?aEw1RWxyc0h2QzlVbUZhZjNXS2ZFbWxKYmJKZTFKZ1dhS1J1WXRkNDNDVFB3?=
 =?utf-8?B?S3hwS2dOZXl0V0ljbENqUEwrYit3T3hHVmZ0dVFLdS83WFhYZ0hsNUJqbDVj?=
 =?utf-8?B?cDU5YlQ5Z1RmajVMMDNpeWZoTHBVd3U1b1lGUTU2TFhmWlU1MmRxeW1OWGtx?=
 =?utf-8?B?bGxFNjcyVHBaM01lNC9HdEZFTnNJUkVySTY1bTBsR2ZTeU5Jb2lrVU01bytC?=
 =?utf-8?B?OUt6SUFjYjh4cUU5NjhoN0ZmRjVrMzF1VDRRelM4NW5xVEZnUVhYSFNmNG8v?=
 =?utf-8?B?ckN6SHRmZ1BVNUxLL3dmaStjZWovcHFIMklZc28weFVsMzVqVjFqOVdmT01l?=
 =?utf-8?B?N2YvZExPNmN1cXl1a0xjRm40N0Z1eFA4ZDdLMVc1dW0yZ2twb0VWTkpnaEVY?=
 =?utf-8?B?Q1hhV1FWeWlUbUdsdVcwa3Y2WUg1VGFzT09pbnhqY0J3RmJGRlI2VFZWSXhs?=
 =?utf-8?B?RXJIV3RrbE9kRTZ3RmxpSmRlTzJJWVI5dVFoUFZqVFpTUGJhb3BEWHU0VWdO?=
 =?utf-8?B?YWRER2x5cXRQaDVzS2hNK0gxQ3EwSW1PQm9YalJ4OGxyVzVYaVhiTzFSekM4?=
 =?utf-8?B?Q3dYNk1mVzcycDJ5YVR4WDJ2YkM4aXBud1hLNEgvY1B0L0Z5NHlPZjlpWHZY?=
 =?utf-8?B?U1lZVFhqZzh1cWw2eXJKWi8xZTd4bWd3ZHZaZ25VUzVvNEZNaWowVHVwWEsr?=
 =?utf-8?B?VytvaExOeXdZbHc3TUZjdlpxZC8zUE9LMWNNWEtNSGtGYUYyMkFDQnNxVkVs?=
 =?utf-8?B?WGtrTElRalNycVpKd3dSdUh4bktWVlBET2tyS0VuZFV1L1dReXlKVDVmdGV6?=
 =?utf-8?B?OFFUTTNwbDROUjAzb0tkZG1yc1BNdTZBQVpLVmpjZHBodkZFTEZZTkJhK2NY?=
 =?utf-8?B?b3ZwWDRabnBpZlN6czBGL0lBcjVuR0djTG4rUHcyL2o1ekFtbk82S2dCQVE3?=
 =?utf-8?B?WkdaVUU1ZkpmSFpTVGNQQ0plVzhLc2NMelRyVzEyd281ZHh3TDVmRmtQbmQz?=
 =?utf-8?B?S1lGVEpndWpPc1JwTVloWXJRYmh4UWNOd2c4dW1qNVpNak9va2VTZTFidUo1?=
 =?utf-8?B?MFBrRlhLbnhDVGJPQ2ZKaFdxcUV0QUFoell1TU1QVHhwbFRSYkEwbHNaWTdV?=
 =?utf-8?B?Mi85R1NmUlNRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cf8f6e-d708-4906-1d64-08da05a5efa0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 10:32:27.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4C1lWolc1JNrclW8mtnmPCUqwQC67LQnDTqMdjk00GViFshz3OILVglMnFa8+vIrs6JLFYTjB5KGY331iakXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5531
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/14/2022 11:55 AM, Suwan Kim wrote:
> On Sun, Mar 13, 2022 at 12:42:58PM +0200, Max Gurtovoy wrote:
>> On 3/11/2022 5:28 PM, Suwan Kim wrote:
>>> This patch supports polling I/O via virtio-blk driver. Polling
>>> feature is enabled based on "VIRTIO_BLK_F_MQ" feature and the number
>>> of polling queues can be set by QEMU virtio-blk-pci property
>>> "num-poll-queues=N". This patch improves the polling I/O throughput
>>> and latency.
>>>
>>> The virtio-blk driver doesn't not have a poll function and a poll
>>> queue and it has been operating in interrupt driven method even if
>>> the polling function is called in the upper layer.
>>>
>>> virtio-blk polling is implemented upon 'batched completion' of block
>>> layer. virtblk_poll() queues completed request to io_comp_batch->req_list
>>> and later, virtblk_complete_batch() calls unmap function and ends
>>> the requests in batch.
>> Maybe we can do the batch in separate commit ?
>>
>> For implementing batch in the right way you need to implement .queue_rqs
>> call back.
>>
>> See NVMe PCI driver implementation.
>>
>> If we're here, I would really like to see an implementation of
>> blk_mq_ops.timeout callback in virtio-blk.
>>
>> I think it will take this driver to the next level.
> Thanks for the feedback. I will implement .queue_rqs for virtio-blk
> and make a seperate commit. Later, I will try to implement
> blk_mq_ops.timeout as you mentioned.

Thanks this will be great.


> I will send the patch series soon as below.
> [1] support .queue_rqs for batch submission
> [2] support polling I/O

I'm afraid it will be hard to implement polling if virtio spec doesn't 
support it.

So lets see what the maintainers will say and if there is no such 
support we can add it to the spec.

So for now what we can do is implement .queue_rqs and .timeout (both are 
orthogonal to each other).

>
> Regards,
> Suwan Kim
