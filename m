Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CEC433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 15:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D914560F21
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 15:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJXPca (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 11:32:30 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:21601
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229782AbhJXPc3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 11:32:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAI/xMUTiZEy5HSDcR9rE0nVj4k94PrKuevLjCIs2oUlXgxTPiN0tWQM+aQyNTY0cC784QYXibztA/cIkG/kKl/8ylD/9IVws0BS+l33kvP5RRDS+dSzmPGi703X371JqlIODaD1yRrBqP4MlawYIP7UnzKmDvZVxBuQwmqyfE78LFfJSxZ+ON//I7rESyxhZ3uYiTq8o0h2rt5VgZbPLOSn74kPgnaxdFHYE9WQiInZk5hC+UR1KwfauYwstILucSSidj9/3d5KZF24kKkribGuXrz9xNfvVnnuS49V4Ni28SKMOQMYO6cXqsn0QEVg4xr0nRrjmuIfPtV7ZJ+nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpsPugkGklJJDaxFTiu//6RzCB24oFMGQkNQu4hKAIY=;
 b=fgFmP9ga+5PfIUigWznlKUGb6383htRPrHfSKhQ8Pr5tfSMdka1MysLsrBCyKlLLQRhtz8yZR77WrUI1ZWwf0lTgWWbsHPtOOzQZ8t4fX8tP6n0LOvrk0PqRSJ7nmOoPECEjEPIQR/tMQTfIrNxe7flTtMEVX8ZEr00oGteNT5bPwYSLBGuU9AVb7+7gjVmlNSth4IZYEVJhf/edZ7VoAdvsxDP72W68i0YNhp/an2II0F1Bc6hHTsosn2QuuZP7aDVS5pNy4JAsO0ACJCJYr+cb5snbP1ZCRTiax4u3elvJBQ5vHuCBj4zvaSTi6tl6oSmFK6aWoPcWtfTbNAJ4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpsPugkGklJJDaxFTiu//6RzCB24oFMGQkNQu4hKAIY=;
 b=THZBHERPAsk8GpeTvScoV9jpbw7r6FOHq8j/Yw01FS/idi8pjM11GvEn24ZaKN1KKxI8tkSZkbRoRhOqRkSkvXB1RE7g5JkR+xtS7LDzL7Ce07K7/Pl3yho1/KXjCGonfzMeHTt8wnK9LVqDwBfi3scooHULnHcp8ebwd3ipS02iVIfIYOgiTX3oZTRdtS37srd3xJvkejKr7Szy0i5mfqiGNd9aspHLWLtH/q2TKVyQDxhLucyJNOwPGqntkx079ms8zA1bS/4orbOepIy6FI+6Y6ZKW3O3bzBPG0E6ToPNxsBeNRywS16iVQ/FNdHcrXv9sjNdEzhW9E2Q5JUuYw==
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Sun, 24 Oct
 2021 15:30:06 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::32) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 15:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 15:30:05 +0000
Received: from [172.27.13.118] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 24 Oct
 2021 15:30:02 +0000
Message-ID: <a2060fc7-cc4d-c4d4-e7fe-e4a1e544104f@nvidia.com>
Date:   Sun, 24 Oct 2021 18:29:59 +0300
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211024105841-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 404cf235-d027-43f1-13a2-08d9970327d0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2558:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB255851F828C2C6BF6AEE36F3DE829@MWHPR1201MB2558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXR0plkuaCJ5anz2fUmPmfs4n6xpjIUikLFPgBTqPGAEouDEytHMGafOFx1ZdqGtpbu0ibhdEpIDNHj1LtpR6xkm5SoFpLeypQun6ngoICl/Pw7Rd1mf4Tt/k06PIY+SZi0i6izKetZAHeyUhiNPg31wSRo2C/3Zt8y+IcQUfina8mgxqpKONjyHRKpIAOH05J0XZ1YPIIm/PlkdBn8MWjU9ZffWJcdLG3rxYRHeV2g4WYPu3+ASNvAvX17YzHnUB26nFdeWWcRDGO0vkPh6oDHtWhLPAtoJV5QMDEtDrcNSbRjOHEqiyk++QQSSAJGinKBjwXsuTTLjposlIrtqF8iVC0GyhAmZa7xKgTjPjJlXCOnPR/xD0VyuKw00jcrqPjSZIyrovpWeoDWFwQXH1x7e2PFvM2G+zDwKQ/7KDuPQm/I6GwOb1gS+kAZTlFEwuYhr1hLlIEYVPjPrCJW/zD9tSdM0AEr18LKEUnMx+L0y01iwbIYKq+PBCqSDXyBl14FPy6zX25KyuGSAhmNGk0n22hZMRqkz3Qj9k703X32CiEuanXjfRGFLNSHPByDiPKJuiz1TJe0rn+HqQcsoLwso6q53LpCd7+PwODZMrtP4hxJQY4C2nmsuOZ+dW3B6ya7tnBzY3DS7M2M7isa0lxMmz4TNOoEfPwqsx0CzAG7CjBpvPWn/beDIVe70WGxnwQJA4iDXN9eiRrchTwyozOD913vGOyh0QAenlr/po0o=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(7636003)(426003)(336012)(54906003)(82310400003)(4326008)(356005)(47076005)(8676002)(83380400001)(508600001)(5660300002)(2616005)(2906002)(16576012)(86362001)(70206006)(6916009)(53546011)(186003)(26005)(36860700001)(16526019)(70586007)(36756003)(6666004)(316002)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 15:30:05.6490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404cf235-d027-43f1-13a2-08d9970327d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/24/2021 6:11 PM, Michael S. Tsirkin wrote:
> On Sun, Oct 24, 2021 at 05:19:33PM +0300, Max Gurtovoy wrote:
>> On 10/24/2021 4:54 PM, Michael S. Tsirkin wrote:
>>> The default value is 0 meaning "no limit". However if 0
>>> is specified on the command line it is instead silently
>>> converted to 1. Further, the value is already validated
>>> at point of use, there's no point in duplicating code
>>> validating the value when it is set.
>>>
>>> Simplify the code while making the behaviour more consistent
>>> by using plain module_param.
>>>
>>> Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
>>> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>    drivers/block/virtio_blk.c | 14 +-------------
>>>    1 file changed, 1 insertion(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 6318134aab76..c336d9bb9105 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -30,20 +30,8 @@
>>>    #define VIRTIO_BLK_INLINE_SG_CNT	2
>>>    #endif
>>> -static int virtblk_queue_count_set(const char *val,
>>> -		const struct kernel_param *kp)
>>> -{
>>> -	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
>>> -}
>>> -
>>> -static const struct kernel_param_ops queue_count_ops = {
>>> -	.set = virtblk_queue_count_set,
>>> -	.get = param_get_uint,
>>> -};
>>> -
>>>    static unsigned int num_request_queues;
>>> -module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
>>> -		0644);
>>> +module_param(num_request_queues, uint, 0644);
>> Not the best solution.
>>
>> You can set the param to 1024 but in practice nr_cpu_ids can be 32 for
>> example.
> Well your patch does make it possible to know what nr_cpu_ids is.
> But does it matter? The actual number of queues is still capped
> by the num_queues of the device. And I'm concerned that some
> userspace comes to depend on reading back nr_cpu_ids
> from there, which will cement this as part of ABI instead of
> being an implementation detail.
> Exposing the actual number of queues in sysfs might make more sense ...
>
> Generally you suggested embedded as a use-case, and I don't really
> see lots of embedded userspace poking at this parameter in sysfs.
>
> What I'd like to see, and attempted to achieve here:
> - avoid code duplication
> - consistency: some way to specify the parameter but still make it have the default value
>
> Better suggestions are welcome.

Just change return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);

to

return param_set_uint_minmax(val, kp, *0*, nr_cpu_ids);

The real amount can be exposed by common sysfs.

We'll extend virtio_driver to have a new callback to return this value. 
If callback doesn't exist - return -1 (unknown value).

>
>>>    MODULE_PARM_DESC(num_request_queues,
>>>    		 "Limit the number of request queues to use for blk device. "
>>>    		 "0 for no limit. "
