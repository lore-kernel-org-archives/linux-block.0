Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68296C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 22:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE0160FE7
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 22:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhJXWcs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 18:32:48 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:27233
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbhJXWcs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 18:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnT66pUQnqLZsBFhG5zuwANFGf9/Faua4X/2sbyWxiAj2jc3sc+WIeLjaycOO82/6ixC4l7tOo7DAL7ISGUrwZCumDV3d7v5FVjJAbzpTBDrHPvqncZQTeC6V9ozGdXVHnnNUprNc3geM8kHzTbdYFaUbc0XSn07qGKGi7X8z1l2me/UE1f260J7lQ+u8TmkLQZ5vOVoILm+PlUqZEkOUHid4dVvcWM+45rBWFyNMvVe8SXIPuh/wnyrLEEaB7c7NMXl6OklNuxNBs1Y6dx09E1nvwsm3L4UV4AGPuqO0fteeQzKjYRk6+I3x7l6CPS4r4HGQZ1sTxp7ZxgrkCr48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIRbmSB8njXzZZhds8OPWgG2CX+Ahc0vWEBMyao0/d8=;
 b=jptpDepFb2hDbWVuyDYWeA866TsKEhQIwZOFNXwAUSzW2i7hrNXKyCjl/mxJkqCQNe+/809Wo4vdzLrWL744RPcPj/+R8mVHn5Ly7Iao1yU0IXQkouwmaPW273vj0NUMY7oPX47aoKCJ+Rt0ezIxKKSBsvpsbXUcZMl+mDDEVpvMqeeOlWf2CUKD+3Nuvb50nqDxPR3s3x7uM7xqIIJVsWFzUtK1V7DPgvSSdIvVoyQkTqH/6FIOGUwwdePEnY3GRaNPgfNNBGG7TGXI+8PdqXl2pDZcXxBhVi/yoBu1/WCSA2Q15Khb1NmwPJV74UhBkx7eEQ2zjQup5ox8/8qGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIRbmSB8njXzZZhds8OPWgG2CX+Ahc0vWEBMyao0/d8=;
 b=FFo7cyzvFJswTfGD37xWrODseSeHepMKptwFiv6TfsETtrwtXUPiTGumL5+ZzYTdjxjrhl5adwW4ceGT9iVJcqrIE6qlUMypZilz231FeWpqGRDOUbinhPN+cqJZldD3s6XoO0tYTnGB0FMtu+CBAJz9bJDG2UEdI9vBdyMThIaLLxFP7v9grODZa3pzKptgJ+QmTxS4TsnLDO3ED/ow+mmHq/xYW/iztR2lmpqBAeryFlyAYHOp6J5L2Edec65gWG9acQOB9xwe+XUVvj7DY8Osv7n68v51QFvCRM1ztUduWXFUJq9l6WOxs0o0lVI/o/DhFEbI0SCE3hJ9Ie0vuA==
Received: from BN0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:e7::11)
 by BN7PR12MB2627.namprd12.prod.outlook.com (2603:10b6:408:25::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Sun, 24 Oct
 2021 22:30:25 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::dd) by BN0PR03CA0036.outlook.office365.com
 (2603:10b6:408:e7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 22:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 22:30:24 +0000
Received: from [172.27.1.16] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 24 Oct
 2021 22:30:21 +0000
Message-ID: <ad3d2af0-08ef-f878-c6cb-9ceaa42166d3@nvidia.com>
Date:   Mon, 25 Oct 2021 01:30:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] virtio_blk: allow 0 as num_request_queues
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>
References: <20211024135412.1516393-1-mst@redhat.com>
 <855eb993-074b-24b9-a184-d479bd0b342b@nvidia.com>
 <20211024105841-mutt-send-email-mst@kernel.org>
 <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
 <20211024114746-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211024114746-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13934d44-b96b-42d6-08e9-08d9973ddf98
X-MS-TrafficTypeDiagnostic: BN7PR12MB2627:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26273146FFECD5BB7D18519BDE829@BN7PR12MB2627.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hya5U9VzZHs1kLUHRww8SZ83mRcbHk72OVhPzrYlm5L/sDsZ7aHwBCWgzufdmzJQ4ie4w+C+AXCEIymzvjpsuZJr5oujT/HTxh2KNn+kSESxxurCpBLy5hl5fkRoMvR4CzebD3JlWrFJ7MFwgrbvz8m16iIxQaANoN+li6W26jbQzZfD47u52xk2ZfJFoMuB2cnIjIwaBXyVkYqapxW60Y2iuL6IsC0OF34l7O4jKYpp7NFnZbxWkAIw+ROkh5S0WPzS9iyONUOuFcl5/2/3zLHndPDa8K/T/igQNZuv+peODXNVpU+uizStgHGWgJtf/CdbHjmKPR8tj/43NKrHIjoAE8+ZyvE26BuTmbrf4HVEy7I5F0o6lG0Kz/Sr/9749GmObtKSFZMME/OSrXNNnn/U4Og/BxxDreD71pmiF8X3nXqJC25lRCZJ9YQDyhJYvdmEBF0hPAamBsu/lQY5GTy9zZo4DJbPV0WzgfBKVtIve/d1UIIJ3ZHiI/5wm70rFqo3n9gW5JnXJ5mHNZP86B7xtK6tmoVQ07UniECbRZmwwc/FVYgWgB+zQkeuxM2T1rwXtjBT+6ncDm3wO3kZ6Lb9iBXiD0J5RI1PBWu51voLQ9XEQNWbOnfImkIqrWwCsFBe7SpUZAXZGAbiCXm7RNAwLG20/xqiutXKj8RIeRso5ARAXSyJZ9Dx/K+etLMrDLIWHMOCpqDXGz8ro/wQWsZ9+eS6rv/2bnudoWE0/H4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(186003)(426003)(36860700001)(8936002)(356005)(2906002)(82310400003)(4326008)(316002)(36756003)(8676002)(336012)(2616005)(7636003)(16526019)(83380400001)(5660300002)(508600001)(31696002)(70206006)(6916009)(70586007)(31686004)(47076005)(53546011)(26005)(16576012)(54906003)(36906005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 22:30:24.7938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13934d44-b96b-42d6-08e9-08d9973ddf98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2627
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/24/2021 6:49 PM, Michael S. Tsirkin wrote:
> On Sun, Oct 24, 2021 at 06:29:59PM +0300, Max Gurtovoy wrote:
>> On 10/24/2021 6:11 PM, Michael S. Tsirkin wrote:
>>> On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
>>>> On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
>>>>> The default value is 0 meaning "no limit". However if 0
>>>>> is specified on the command line it is instead silently
>>>>> converted to 1. Further, the value is already validated
>>>>> at point of use, there's no point in duplicating code
>>>>> validating the value when it is set.
>>>>>
>>>>> Simplify the code while making the behaviour more consistent
>>>>> by using plain module_param.
>>>>>
>>>>> Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
>>>>> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>     drivers/block/virtio_blk.c | 14 +-------------
>>>>>     1 file changed, 1 insertion(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>> index 6318134aab76..c336d9bb9105 100644
>>>>> --- a/drivers/block/virtio_blk.c
>>>>> +++ b/drivers/block/virtio_blk.c
>>>>> @@ -30,20 +30,8 @@
>>>>>     #define VIRTIO_BLK_INLINE_SG_CNT	2
>>>>>     #endif
>>>>> -static int virtblk_queue_count_set(const char *val,
>>>>> -		const struct kernel_param *kp)
>>>>> -{
>>>>> -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
>>>>> -}
>>>>> -
>>>>> -static const struct kernel_param_ops queue_count_ops = {
>>>>> -	.set = virtblk_queue_count_set,
>>>>> -	.get = param_get_uint,
>>>>> -};
>>>>> -
>>>>>     static unsigned int num_request_queues;
>>>>> -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
>>>>> -		0644);
>>>>> +module_param(num_request_queues, uint, 0644);
>>>> Not the best solution.
>>>>
>>>> You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
>>>> example.
>>> Well your patch does make it possible to know what nr_cpu_ids is.
>>> But does it matter? The actual number of queues is still capped
>>> by the num_queues of the device. And I'm concerned that some
>>> userspace comes to depend on reading back nr_cpu_ids
>>> from there, which will cement this as part of ABI instead of
>>> being an implementation detail.
>>> Exposing the actual number of queues in sysfs might make more sense ...
>>>
>>> Generally you suggested embedded as a use-case, and I don't really
>>> see lots of embedded userspace poking at this parameter in sysfs.
>>>
>>> What I'd like to see, and attempted to achieve here:
>>> - avoid code duplication
>>> - consistency: some way to specify the parameter but still make it have the default value
>>>
>>> Better suggestions are welcome.
>> Just change return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
>>
>> to
>>
>> return param_set_uint_minmax(val, kp, *0*, nr_cpu_ids);
>>
>> The real amount can be exposed by common sysfs.
>>
>> We'll extend virtio_driver to have a new callback to return this value. If
>> callback doesn't exist - return -1 (unknown value).
> That doesn't avoid code duplication - the limit of nr_cpu_ids
> is applied twice.

It's a small logic duplication and not code duplication.

The param_set_uint_minmax is a new API to make sure that the value is in 
the limit you set it, and it will only called if the user explicitly set 
the module parameter.

In your case, you allow setting 0 value in the comment for the module 
parameter. And this is the oneline change I suggested above.

The second check in the code is for the case that the user didn't set 
the module parameter explicitly and we need to make sure we don't set 
num_queues to 0 (the default value).

So I'm ok with these 2 checks.

Adding a sysfs entry might be nice as incremental patch.

Let me know if needed, I'll make sure it will be implemented.

>
>>>>>     MODULE_PARM_DESC(num_request_queues,
>>>>>     		 "Limit the number of request queues to use for blk device. "
>>>>>     		 "0 for no limit. "
