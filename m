Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17677C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 13:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiCBNZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiCBNZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 08:25:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670712DE7
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 05:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgOkBg+zByysWZjV8hrH7vAlKHP7eb/M3AoUTcWNMP+RJDb/KEqIYHceyC9YjIVbSudJzYSGXZdg3zZGgCsHnDSf/ee29yJ5ezaUThx8Co0z2kSFerdLMbAgW/xrkNAkDI36YHLo2WlRQFo5gFS+yulm5cLM1LDBJg1ooUDlqvVxXJ2jyETBlyJX9UGRcPbPMCODQrDBKUe0pzhrccjd4HnY7RD6KCVDLKoS7xUMWxWfdhqPRp3UXzWkjmwajYi1FjlqA3DVWkwpg7O2GXFFpNZ3t2sFh+d1IrtCwrJJOvDVj30LrcHXd0m78ZirIYrz6FTBIEMV2MOhLKlNRupr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVsCD9gH6beZaCrSU71V8t0yy071i9uEQY5uXNujGw0=;
 b=P1hUjUsQVwlx67KPhH3Ys6FPN7eXktW4hy6Xv3262y+asvxCE3pjTiQLtMbS/QapATw5wtn33IGPm5sITM8dhBBxQ0efAGyGZk8vVsQ/RVIjk7Puyw1KIQAg50WA6eadGH689Ahi/5N7JJfQ7Ue3dxxvTyLLJXdhYSWIEmCmkLgo0JVGS/a4bxHHBHh6mZ5nmbZyBRmf3yl6l9ZyPut9Yp90KmirWBfMg/o+Or57I4EfFsQW7Qe/w2Qnq01Q0nfYO9BQqGdRWjC8++otjgC4Si45UsvfvH6L+agmakfi6ulLQ8qjdrzPftpd5amJIRlGnpDt/ELIwLj6H4GS7y7+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVsCD9gH6beZaCrSU71V8t0yy071i9uEQY5uXNujGw0=;
 b=B0ewJxeN1tNoZ7B0Q2tu/WHqI3edrJnrLl/uNCrEu0BilM8s8H05Xgij5kEM4NDzX9ql+eGaFwS1DXsPLq1h73WA8H1P1o+1E33PBPhrjMTWTupeutAhyHbdDKpoj9SfU7v5BZ1uThJ1t1CeeslbnGF2PJjzlZZPCYDcoquY4trv5sqDEnzsbegFgdCfIR2znPNIWf/8b5jbhLiYuP0vGbyW7tNymmY5XaCfRY7qL+cmDJViYyhHvQVIKuWWnhsU7yc4pvhuYqpWv7DIafk5SE21vKrIAtLqm1sI6yOzcPf7fOiTrtJvnSUptkeWPP1YNVxIBKXncvu02oVbKpgF8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by MWHPR12MB1504.namprd12.prod.outlook.com (2603:10b6:301:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 13:25:01 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 13:25:00 +0000
Message-ID: <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
Date:   Wed, 2 Mar 2022 15:24:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, jasowang@redhat.com,
        axboe@kernel.dk, hch@infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
 <20220302081542-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220302081542-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0005.eurprd03.prod.outlook.com
 (2603:10a6:206:14::18) To BL1PR12MB5032.namprd12.prod.outlook.com
 (2603:10b6:208:30a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdf79afe-b51c-4791-f2f8-08d9fc500d8b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1504:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB150487BFE7742DCDE18F55F3DE039@MWHPR12MB1504.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9i5PY5pldasMf116a9nWutm0TFUyIEqUClJ9Jg5Ek1A5sM7IVanBwLRCpAnnSM2JcMANmBO0kC+eXxJhGO8DGZ2lUW9fPXK3/cvZNosBkNLGzrtW+a4Pv5s6Nff66Aukuuim2ySWvuqlwzVBSjYQ6x16V6XHHQYeFWRbGslJJffqFL75R4TR74G0CxcYW8RYJkD3otBUGIZYc1owveP9NVTR3nGELTGhXqBh/0i8jvRPThvaSNBmkP3OmA5dT24yYkDmyyL5hrptFezsei4gYxKOaZrBQ+jg+rrCuLe/QmrzW8g7tzM9e0H9MDJ1xMt4TsrfRXb6QSP0/MrWXe05HI9GzxnfwImlYkzZ710f1PKJTJVsD266A0rMNcAXxqlasVn+VBO3RoJ55XqyCYbNSPz6ARDvvlMe6qWlpRsCJSRxBGD+EO9HipIlBempvjNb4mSDYDJxzVLj2TBvcbNGdJtR6ItMnVRxyPfjajN+XG7BRNurcvX0gmpmXC+xqp2OS5O36HZwWa6btZ421evGrAkNq9cvLvX7YmQDJ1u47LeqiAQMeP55TGipvkMAmBxU4JEqLDR01IUf+mhV2Oe6Gs8putdzQ8pqjtITD1sQJS6tUC1waaH3O3pnOo9FbALx2nZKYLCnteHoScYxmhridT+cNjtiGjTRmfXdjXNziRfyjzccF/vkNpkIODolZrqJpfxlSNjnmZk9c4cbTpoLLZkF46sAgUiFnLG3nyw83m0X6c6+HZdxAXJl4DDu/n6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5032.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(36756003)(6506007)(66476007)(5660300002)(2906002)(66556008)(66946007)(31686004)(8936002)(186003)(83380400001)(2616005)(6486002)(26005)(508600001)(6916009)(6512007)(53546011)(38100700002)(6666004)(4326008)(86362001)(316002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEE1TGFhQWtrbzV1dlFkU1hyNGw0OVIvYXREaWpwMXNML3RXU1V3N0JURWZq?=
 =?utf-8?B?ZGNjUlJwcWxod0w3UlRHN3g1Q3JXLy9McXBKWnBTdTJUck94UEp2WStTYWEx?=
 =?utf-8?B?YXVocWJzVjcvTUJwYkpOUXpsVE0zemlaS0xqMzRlNzliQjcyZlBpdTV2Mzc3?=
 =?utf-8?B?QzVGNG0vR01DS3dtcDZVcmduTGs5ZVFsb1I1MHlLNGxtUG5yNmkvdVhOQmtI?=
 =?utf-8?B?aEJUUjhMdUFwY3UxbmQvVzQzNUpjSmsrYlhOYVJ5em0yMXhYNVQ1VkREV3VY?=
 =?utf-8?B?UHZwMFNXcXc0SFBoUDlvWXh5OWREYWc5SzRlYjFRQUd4SVRMeU5PL1hTZTlz?=
 =?utf-8?B?bkNEYlRFYWpVbTdSZElpU3hHVm5ScUd6NXo5V2ZuczV1dVhlR3hOT1JQV3Ur?=
 =?utf-8?B?M1hudURRVjJjNnZGVkxYOGdEQ3BURnZmYlJpYlBJbjh6TnQ2UzJVeHMvSjVK?=
 =?utf-8?B?WHFwa3d4V2pydFNVZGk5RW5QT3ZtSzZ6RHVSZU9BVFgxd3VLKzVLWVppbTR1?=
 =?utf-8?B?aDRLdmhCeUpCWGowZWw1NWR5WjJaaElBZmRXNWcvdU5LTC9LYzFiWi80blNz?=
 =?utf-8?B?Vnk1bjBxanZqMmFqWFp1M0E4L3A2YnZCM2x3dlV0aXVTKyt4RE4rbkxxSWZm?=
 =?utf-8?B?aElVVTdoUEJMUGdJZysvN0pQc3UwK0JrbkRGN1k5eUprOVF3U1VaQ2EyaE5z?=
 =?utf-8?B?NTRmYVlsdjRRT1Axa3dEVmgxOEdCSzArc21UK1lwb05LN1daaWF1S0gzZG1M?=
 =?utf-8?B?bjlqUXVaeXFQQU00NnNpUFIvKzliUFFIS3NuTWZaZmJMem16eGVwU1VZdWdP?=
 =?utf-8?B?b004VXNLRzNGV3NQZHRBWEhNY09NRkRoTjZKYVVxbExnbmlwTkMvKzBMbVpq?=
 =?utf-8?B?bXV1ZWcxWktsS2p0V2xDWk0vWWNDM3BiamlKK2k0eWg2Q1RBeDRRbGdqL0NH?=
 =?utf-8?B?UmZxbUlCbXgwS0I5NDFxbllKWGdsZW1xTW95K1F4Q0pLWHllS2tFVGdkSDhp?=
 =?utf-8?B?UlZaeWtZMkxCbUNFcUpUUEpkTTZlSklMZnNZQmFRNWdUNzZ4NEJBQ1F4Nm1X?=
 =?utf-8?B?UlpqV0NLb3JKektkR1dVai8rQ08rU0pQUUt1R0xtL0NPWVVmMG1WK3RYa3lR?=
 =?utf-8?B?OWNVUlFncXRJQ2RjWUdsRldCUjlJekFqVkgvU3BPN0N4TUFiNk9WRGpROUpF?=
 =?utf-8?B?cmlKM3RUczVkS0ZaVU1BLzFnOW55WkYwSUt2aVZRcUF6dEwwRDl3WHJhK0pp?=
 =?utf-8?B?YUw0cEc4UnZLVFV4WWxWck5LOXd5b0lydjdrTWh6Rmp2TjNTTHVCQmxiaHBz?=
 =?utf-8?B?MTZncTVjUk5CamowTXA4UE1RS3pVT2o5SHRRZUJJOHBmQjJNOU5JV25PdnFX?=
 =?utf-8?B?OEJ1U2lqODhLYW5xN0xSNVZPeHArUUx3cURHaWhwc2xuNi9lNUdHajA5UEtt?=
 =?utf-8?B?R1FyczRXZlJDYnBWZWVzd2h1UTJZY25Pb05KV2dWS2p0Ti9TaWF5UTBrdEdS?=
 =?utf-8?B?RHJ4SDFmRnVsaG80dk53bHVPMlpjWVM2M0JMMnJCMXhEbjZKNjFFNFo5NmM4?=
 =?utf-8?B?ZFowUzVJeXhvV1NvRWI2MVJEOTduRzV4Mm1tVjZWWmFqYTI4MXRHajdxaDY2?=
 =?utf-8?B?Q3ZmR2ZBdHdwNE1LeWM3L0pUd1QrbzdnUVFQZHJQUnZwdkJOS29BRll6WklK?=
 =?utf-8?B?b2VDSGpuY1RZWHB2ZkY3ZGdVcUYwVDFVMFkydTh0bGNkUU1icHFPK3B1Skpm?=
 =?utf-8?B?NFRPelg4L2g3dEVUQ2t1K0J2QzF3TDVZbVZaVEk5MG4zUGVIeHlJQWUybXNJ?=
 =?utf-8?B?eVVMZE16Z2t2bG44VW5zT2V4SmdEd0IybVhOeHM5aWkwMS9FRkNoL0V3dVQ0?=
 =?utf-8?B?YmE4WVRFN1dVekNOTGVXM0RSV0NLZGQ2YUFZbWJxQWVUUERTQ1ZxMDFxTEVo?=
 =?utf-8?B?ZXp0SmsxQVNIVE1FUEo4K096WGZSZ0JkNzg3QlBEbFAvYjI1dWRrY2NwdGJi?=
 =?utf-8?B?bXhSN1lkQjN2ZFViNW9TYVhiaVF6SXBTM0NIVStJamFIeVhNUnc1aCsxdFR3?=
 =?utf-8?B?TmozbGFDZVNkRHM0RWlSRWlsWmcyZ3hoZXJ6YTlyN0M2cEw0T2ZZNW9kcm1V?=
 =?utf-8?B?b1duY2tvQmNYeStGVFFJbXZuWkowRDRSRXlKeWxPcFd4ZmFtNWRRUUl1ZDhm?=
 =?utf-8?Q?Oe7wIr6PSq091IWZ34Wz0LI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf79afe-b51c-4791-f2f8-08d9fc500d8b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 13:25:00.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmzuzvpuhKzU5WDjKC9t1GAvRMMmVbWVB4rND2u4PnDFcKGfap4U43okqKpnx+un6e9+Ilz0N/FsQuchuNxp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1504
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
>> On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
>>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
>>>> Currently we have a BUG_ON() to make sure the number of sg
>>>> list does not exceed queue_max_segments() in virtio_queue_rq().
>>>> However, the block layer uses queue_max_discard_segments()
>>>> instead of queue_max_segments() to limit the sg list for
>>>> discard requests. So the BUG_ON() might be triggered if
>>>> virtio-blk device reports a larger value for max discard
>>>> segment than queue_max_segments().
>>> Hmm the spec does not say what should happen if max_discard_seg
>>> exceeds seg_max. Is this the config you have in mind? how do you
>>> create it?
>> I don't think it's hard to create it. Just change some registers in the
>> device.
>>
>> But with the dynamic sgl allocation that I added recently, there is no
>> problem with this scenario.
> Well the problem is device says it can't handle such large descriptors,
> I guess it works anyway, but it seems scary.

I don't follow.

The only problem this patch solves is when a virtio blk device reports 
larger value for max_discard_segments than max_segments.

Probably no such devices, but we need to be prepared.

>
>> This commit looks good to me, thanks Xie Yongji.
>>
>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>>>> To fix it, let's simply
>>>> remove the BUG_ON() which has become unnecessary after commit
>>>> 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
>>>> And the unused vblk->sg_elems can also be removed together.
>>>>
>>>> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
>>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>>> ---
>>>>    drivers/block/virtio_blk.c | 10 +---------
>>>>    1 file changed, 1 insertion(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>> index c443cd64fc9b..a43eb1813cec 100644
>>>> --- a/drivers/block/virtio_blk.c
>>>> +++ b/drivers/block/virtio_blk.c
>>>> @@ -76,9 +76,6 @@ struct virtio_blk {
>>>>    	 */
>>>>    	refcount_t refs;
>>>> -	/* What host tells us, plus 2 for header & tailer. */
>>>> -	unsigned int sg_elems;
>>>> -
>>>>    	/* Ida index - used to track minor number allocations. */
>>>>    	int index;
>>>> @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>    	blk_status_t status;
>>>>    	int err;
>>>> -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>>>> -
>>>>    	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>>>>    	if (unlikely(status))
>>>>    		return status;
>>>> @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>    	/* Prevent integer overflows and honor max vq size */
>>>>    	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>>>> -	/* We need extra sg elements at head and tail. */
>>>> -	sg_elems += 2;
>>>>    	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
>>>>    	if (!vblk) {
>>>>    		err = -ENOMEM;
>>>> @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>    	mutex_init(&vblk->vdev_mutex);
>>>>    	vblk->vdev = vdev;
>>>> -	vblk->sg_elems = sg_elems;
>>>>    	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
>>>> @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>    		set_disk_ro(vblk->disk, 1);
>>>>    	/* We can handle whatever the host told us to handle. */
>>>> -	blk_queue_max_segments(q, vblk->sg_elems-2);
>>>> +	blk_queue_max_segments(q, sg_elems);
>>>>    	/* No real sector limit. */
>>>>    	blk_queue_max_hw_sectors(q, -1U);
>>>> -- 
>>>> 2.20.1
