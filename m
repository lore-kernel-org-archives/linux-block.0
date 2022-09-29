Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF5C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 10:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiI2K0M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiI2KZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 06:25:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060CFAC53
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 03:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIdWUdfHI89rNSbapWUNSHY9KmxYPC6lyXHrxvnXcuABWpCLGJCF2ouHjb+7duTRLuLbBNu1SKJhyyKdbSpJ0W8yISUJnm0ysX1SjkUpeZfeIcTIbz6wvvN4fxkDC+HgNpGWx0RE+1WLaQ2tcwaGmHZzcfgJES8zObpIRHknh+6Ne3LxPfpWna+W6AGFbPY8u1VWMGHrCwgQn8rLbheU98Vqvd7F/OhkeLmffGNHa38B3Fbk4fvO9O7acGFQkpWMX9iVWNSQBW15hkKyq32cf3BifvgX+tNrDMboAuexRX+3M4J7MZcERRZkLlG2Cu29rYvcrlxzOHfehkcvKRqfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOKFGMi+iUXYCOD3JtcwgKjgWFtd1Hi/6OWvJMkcik4=;
 b=a4LPhqZUNynREpkbm61yaMdmGYaoPKGsEZHSFx3MNQAlIgrH4/JGCyOrQIOE6/B44nKliw0zzMoqXV3fh7mlHJSle8J68kU6tjPNT8JYG7UjafICD60Y7Mrw0GmnS9gc99l8S5ZvpXY0Kwnb7bVESyQTW9BwjehRyUdUqHxgTvjeOke6on/kZ831vL62tEt0V4JWYUrc8FTaxS3yPsvaDHSqviV516pvB0M7myW4qEuZdeAUmFe0GlnF6x3pILAT6qH26Uw1h5KaH/gjUT1u3Dc7QNb8IbkZy/QQ2r1VUEYvyciynBfF5RihMRLu+gtt1vN5wbA/KXeCHyaPRZfZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOKFGMi+iUXYCOD3JtcwgKjgWFtd1Hi/6OWvJMkcik4=;
 b=aRenhwsTICbXsQyjCNz5J4b/M/3EPDI23/FQu0hBU2JfFDj+xX9xYdbkx2MOL1nf+hMSX4raXLNIP9WGBuoUHWq3IbB6tHrwh7BKneLI+LcR/snYPiYZR7fDAZBCllY6IZ9Zl6g+EfDhwn9PxdOgmULfOdztkDXdYpHKRjhdR6r6HpNwN9Xn4AKBKZKI/djkk9wWkWAcXkFzH1QLjK5WXPrjVT5DdCdphEutHRwLBA1yJR43NCoi0kPQpYXlADg6rxruzrLYqs34jn+jLMu2rIr4ZhjtuR+njN+iOthsZzv6EDfroRAlfdOn7umn8KYjA2K2dxrLgHOLMke517VRuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.15; Thu, 29 Sep
 2022 10:25:46 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%4]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 10:25:46 +0000
Message-ID: <97ebbbc9-a102-a67f-280d-9b80b1509b54@nvidia.com>
Date:   Thu, 29 Sep 2022 13:25:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 729fb38a-d031-4300-2c08-08daa204f87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zt/oPAkoSM+pLclgkCzvsm7WmCnq/tMPU/CA/D7WkqUkcn+hrhYWM4nbpCHBby1TyYpB5c3k+CDHDKqz4fTSOGYxApmrQtcfhwajt+Jq4FAxbU/lh+d0vF4h49tC198wUqybO357/oVLBEYEMqRXtYoC6aYvneL3Rv8+EtloyPe+8H809bePcMbLjmrlWUuazuKdMNtKqvaa4CiOW6wFxGlUoOERJ7WLhdCKgOnJy+Kk49HLD9+uiSd+vWOyAz1n6y7+39aB0EpOdCni3iJiyr16WAZugmwLPRwd8Gg6gmIUHP+BJmniGDOR6RqCOMOgmlcpWxtSf52DKPa1WwcA2YdmeN/+WEnJzMzQ2082LE5cKlIpaTTXA7kO4WDPxx6qAFTikfES7U49KVtUy9GqGA8fN2BJHDhe+92wz2VimEjTOFH98cY1h2/dYKmiIpYGiPRB8OxyCgjBbyR9Bx5SCKTHEcJXo2ge0hSsZFeDdo/K6YXuevJ08mDJUGCH+1xU/7y1laIcwmM1WPZ3Ro/Z2p51yjnOfgMWEaC5JoBg600CefJ2JZn9VpIWvwaQIGM+dSVhhZj5lpO9HgrZpJV8MuIX+IMzY5eYUIQQKph/1pl+vMhfv/Ffh9f9vBNdO37ujx1WXp6qaJ2s1BceOx1FIYJyYPqnqxeQSLMdBFK9USkHM2hCZNK0lqQsdhl4rg4UJh2mRepq3cc6ifhJuGqBt7PS7ZFsubtkqqNXqThDDo2j12UpFj5Ho1NEr7lBtnJuhxIXPoHKaZyqEceLIC3ghSVVxC6cwsuz8xuz3R9dVx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(86362001)(31696002)(316002)(2906002)(54906003)(6486002)(186003)(38100700002)(53546011)(6506007)(83380400001)(26005)(66556008)(2616005)(4326008)(31686004)(5660300002)(41300700001)(36756003)(478600001)(6666004)(66946007)(8676002)(8936002)(66476007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pkREZPdmlFN2tycFh4Z3pSN1l0UFgwTnFhajJQeFJob3QzTUZUdjBpbzBl?=
 =?utf-8?B?SmYvK1V4MXVMTnUwSkd4K1UvdWFWL1B6T0R4RHozd0tBd3pxcGpnZVZoTENp?=
 =?utf-8?B?ajIwU1NsTUQrK29NMjloQmVKQjRVWFdWYUVidzhSMk1JVHFuN0xQaUczWTZZ?=
 =?utf-8?B?bnd2eWhCWVBYcjQzem0yeTlDQ3gwbnlHcUE4ZHJyUk9wcVBDVkl5VDhVam1l?=
 =?utf-8?B?R1hENTJOTUxwdmxHbFNwVXIyaGVSa05LaW9vZE5nZ1d2WTJPT3FLNkZ1V0Va?=
 =?utf-8?B?SXYzUkV5UmUxT3U3NnBTalpndjZ3WXNmOFZORTJ0ZjFXRXR6UWNDSnNwQmZN?=
 =?utf-8?B?elpDaWJ2NVNkVnZkZ09kOFJyUW1mNG5DQ3RZWjBtR3dwS1hYeVBjZ1pabGc4?=
 =?utf-8?B?dk9RWnJKWGR2RUtyOHFrNXdGOFdxM05nVk82aTBaREtWZ0lmUlhUUHBTdk0z?=
 =?utf-8?B?L0QyR0lUUmNoSlVLOWdKcDBKSm9mYmUzYnJWeVJERzIzVWVkOHM0cWo4d0Vz?=
 =?utf-8?B?OURSUjQ0ZFlTQmFXQ0Nmazl4TWtTcFdtZlBWTVJMV2xGUXAwMFBPMmZVemRG?=
 =?utf-8?B?cWZsZkpKL1RkRjhBZ0FHTGFiR1Uxdkc2Zk4xWHNERFp4L1E1SHljekdIbnVz?=
 =?utf-8?B?WE4zb0sxRVQvQ1Q5Ky9GWm9RdStYVWhlcmgxQ3daNUI2ZHlXSnVibU94Zi9X?=
 =?utf-8?B?NjR2QjMxSGlrRGY5RE9wTXh3L2lJMEp4S3UwY0d0aDZhTDlLWGNEdFE4VDFH?=
 =?utf-8?B?SUowRVdaTmYwQ3N3N0QrL3VmYjBsdjh3Qis0RW1mdVpXU2U2NFRNcWlQY1Na?=
 =?utf-8?B?ZXBXeDNNaTc4bXBwS1hXL3d3dEw1NzYxOFpncFVVZk9LeGtuUVdZVlVTd0dR?=
 =?utf-8?B?a1pJSWhUV1k3YjZoNkdFeU84Y1NwVWxWTXJKZFgwcUx2SG05ZkJmUUNheWJF?=
 =?utf-8?B?d2ZKbmd6OFc5ZFg4c1NUODMzNHNwNE1zckZVS2NxVm5NQzhNdkp5T2pZZTRN?=
 =?utf-8?B?NWdVajZWZXNGQkVuVy9wN3NnVGxvMmtNZEQ2dUpKSmpsZFU1UnNYNjdxMzZD?=
 =?utf-8?B?V0s4S0FLSFJBWHZRa09aZ2RTYktkTWpXRjJXcTJ4dGpBeWNvQ1NiRUlEK1J5?=
 =?utf-8?B?OFpxckJHTWt6U3M2NGFUUlBkOWg4bFVmMDgzdGhYcUVCY0thZ3BMQmFxV0lO?=
 =?utf-8?B?SEVUUTljZDcwSmQyVjJTQ05aWkJVRWROTmhtK0FHeG1NUmdXU2U2WWJHalZy?=
 =?utf-8?B?WGZuVzZObXFhbjdJcis3L0gzNnZSL001YVNqRzFQSllHcXhnUVcvOGpPcXly?=
 =?utf-8?B?RHFUb25DT1JMR3dmbWhWMVRTWmt0L3U4SFN6WktGTkpuanRxbW95anoxUHFR?=
 =?utf-8?B?clFwMVdPZTZNdmxlY1MyVUpQT2RPR0JuQW5rUVBNNjNaM2hWenV3QWlOcEJt?=
 =?utf-8?B?VVl1M0FnUVRxTVBJemJBWE16alkwVjR3SkVRM1JSNGpuczEwdkoyVmV2NnBC?=
 =?utf-8?B?N0orVERIVTZEd3kwY0wzQlgvMTNUNXAwTlVoZWd3YnYzSzV4Vkk2a0tLbElP?=
 =?utf-8?B?U2hxd3ZxZUx1N3krOXRXQ0cyRmNDcG5ObjVsUk4rbllFdVg5ajEyN01SdHJh?=
 =?utf-8?B?dDN1ZWpGM05BRGVlcUtHNWVJaTg1eEtzQmJxRGFobThTMkY2Nmc1ditEeVl3?=
 =?utf-8?B?aWVoY3pqUHBabjRCc2NBQStQYzd6YTgxakQ4dktpcURXUnlseDlDNHNVVU1U?=
 =?utf-8?B?djRZUGgvOFZSVEVKNlR0TDVCeStLczNDN1haR3prYUpqbjlsdWtYZmxjdndm?=
 =?utf-8?B?OUgxVitBMmFvNHg2SnY3V2ZWYnYrdWZPUEZnUjIyeDlEOUxlQjNSeDlBVHZu?=
 =?utf-8?B?dnU5Vyt5b2Z3UmZXaExVSnpMaHNUOTNzZU5HdTZpb1lyT1cwa1ZRcW10N0tG?=
 =?utf-8?B?aStzSE1QY244NVdpeGxsazFGMDFSb2lmM1ZJOCszQ1NqZUJPeVFXM3ZEQVJY?=
 =?utf-8?B?bDR0TGwrZmdEcGtPanJ2eHVBNkVPaXVlcmlzei9RazlVZEFFbEgzVlRHdXZO?=
 =?utf-8?B?aHhYMlRSSTZNS1lUWjZXenFndnZSZDdGMEs4dlQzbk85MUpxS3c1ZStyOWtP?=
 =?utf-8?B?UElHUGVFc0ZCM3BxUzhvcUVrSk5tTlc3azlFMk5XWE9RKzdxY0l1UVlsYm1R?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729fb38a-d031-4300-2c08-08daa204f87b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 10:25:46.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hwSUbvmcwM6zVbOWOx6MJJ8DQGbeXqhOjbawMTRTgL5IoWD0OAp08i6JvRKqhg3X9BE5Lj/9srQmSCLFHi+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/29/2022 12:59 PM, Sagi Grimberg wrote:
>
>> Hi Sagi,
>>
>> On 9/28/2022 10:55 PM, Sagi Grimberg wrote:
>>> Our mpath stack device is just a shim that selects a bottom namespace
>>> and submits the bio to it without any fancy splitting. This also means
>>> that we don't clone the bio or have any context to the bio beyond
>>> submission. However it really sucks that we don't see the mpath device
>>> io stats.
>>>
>>> Given that the mpath device can't do that without adding some context
>>> to it, we let the bottom device do it on its behalf (somewhat similar
>>> to the approach taken in nvme_trace_bio_complete);
>>
>> Can you please paste the output of the application that shows the 
>> benefit of this commit ?
>
> What do you mean? there is no noticeable effect on the application here.
> With this patch applied, /sys/block/nvmeXnY/stat is not zeroed out,
> sysstat and friends can monitor IO stats, as well as other observability
> tools.
>
I meant the output for iostat application/tool.

This will show us the double accounting I mentioned bellow.

I guess it's the same situation we have today with /dev/dm-0 and its 
underlying devices /dev/sdb and /dev/sdc for example.

This should be explained IMO.

>>
>>>
>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   drivers/nvme/host/apple.c     |  2 +-
>>>   drivers/nvme/host/core.c      | 10 ++++++++++
>>>   drivers/nvme/host/fc.c        |  2 +-
>>>   drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
>>>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>>>   drivers/nvme/host/pci.c       |  2 +-
>>>   drivers/nvme/host/rdma.c      |  2 +-
>>>   drivers/nvme/host/tcp.c       |  2 +-
>>>   drivers/nvme/target/loop.c    |  2 +-
>>>   9 files changed, 46 insertions(+), 6 deletions(-)
>>
>> Several questions:
>>
>> 1. I guess that for the non-mpath case we get this for free from the 
>> block layer for each bio ?
>
> blk-mq provides all IO stat accounting, hence it is on by default.
>
>> 2. Now we have doubled the accounting, haven't we ?
>
> Yes. But as I listed in the cover-letter, I've been getting complaints
> about how IO stats appear only for the hidden devices (blk-mq devices)
> and there is an non-trivial logic to map that back to the mpath device,
> which can also depend on the path selection logic...
>
> I think that this is very much justified, the observability experience
> sucks. IMO we should have done it since introducing nvme-multipath.
>
>> 3. Do you have some performance numbers (we're touching the fast path 
>> here) ?
>
> This is pretty light-weight, accounting is per-cpu and only wrapped by
> preemption disable. This is a very small price to pay for what we gain.
>
> I don't have any performance numbers, other than on my laptop VM that
> did not record any noticeable difference, which I don't expect to have.
>
>> 4. Should we enable this by default ?
>
> Yes. there is no reason why nvme-mpath should be the only block device
> that does not account and expose IO stats.
