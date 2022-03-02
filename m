Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A4AC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 13:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiCBNqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCBNqD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 08:46:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66E5C656
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 05:45:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l10mXYwsn9CHJp7EEfP+5pXCUboRMMdoCJs6lWzhFwKHs4nhuLEuxcGargHh6WvBxloSxT8O92tMDWrcaxyqjgyHmNUgzkySQbzTkNGvIB5AZS1BwE1C5RwQlVPqB+mOoU/c4zn2zS2+MxEJhZvDFgO4qWU9nXJaiAzVS4lFVz9nB0MtpgFL2azolgt+Mv8WvwLQJlE26c3MnYJ4WeVtQyY0eODrkYMS+FCeAq1Js6hesODAE8zyChXiRoc/LOxw2FrDf7oiOwhxpLVmPK4o2Lm1hVSGFtiPE0MNqb8wq77S7G3jdtY6ZtM1Nc7dKkk4OW3ICrgsdJo/4Iu6r8bbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w+xJqu13FrXHnuzjmefh/pu/P9zF4gpe21VxDNNBhs=;
 b=YNnnCJ1qKMEubTntAELMuz44bxTgiIzNLWms+s1FUk1ZwCNFDmcpv2mhyfrDWJB5llfUZ9qCvKlVPcicj6uE/woQn8BdjJ06GGXDf2a2vCdx7KyXev3W5KJiDsro5Ny2BAYdlX2+EquFPWNaMqHDVMjYpbKfCJQaFhVvU6+EkKAe95tG0fnnIxmtQRWBf2sNTVIg2pQU0cdStHo9xt/23MhOqG4euAutOXLoCUpq1Vgs2ppeQCOThjIUfB9hyXB9AxDueMIDpf7jNIaFq4kIj+KsDwTSK3rlOEz9Bdbgu6OOMGGIOd8Iu1wFCbI/GkFovD32ndI81U1TjMfMNtOG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w+xJqu13FrXHnuzjmefh/pu/P9zF4gpe21VxDNNBhs=;
 b=q1SlA4d61bGJwCKQmJXZhPxVGb1jvBWiOaGx+wpda/0MJO9209AGu7ekyh0olxun+IgfnCMisnoue9rokUCkFhPSsokPM7yv2oioE6L6XVQYBOv5hG8dAnqmp2pGRI2aQQ36nEtkwuMkjV/cYIAg6L9wQgbBy7+dE4EY6oa2Hf5S2rQ4k8+VivyrxLfj4NeQf+9QZu2IMtCwanO7mgvdBkOMN2yYjUHaj6w3lxuGSc4PIBnxaA9wxnSshOpSNf/inywF9G1oYlPGcUdtwwUzjxuzd5XJMvPhL4s+ubMc66aA98kkbnrFVvFjKum625+sR1P3jYpL7GaG6x4/5QsyBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by BN6PR1201MB2482.namprd12.prod.outlook.com (2603:10b6:404:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 13:45:18 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 13:45:18 +0000
Message-ID: <808fbd57-588d-03e3-2904-513f4bdcceaf@nvidia.com>
Date:   Wed, 2 Mar 2022 15:45:10 +0200
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
 <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
 <20220302083112-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220302083112-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::20) To BL1PR12MB5032.namprd12.prod.outlook.com
 (2603:10b6:208:30a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d3fa346-c698-42eb-198f-08d9fc52e31b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2482:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2482EA26B14547E3DAAC6083DE039@BN6PR1201MB2482.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKXyfKTiRxUIG6c9HnTK9mDu4xk650fwvS/Kr1MJZRRrn4d+VxgvGmvj9jXAGF/aEFpAjc7+5Xas1rUeh/v5HQGZXuYgQpoIYekzy8sdvJ1dL35ujfseyg+tXmgMAkQYVHsr5/NbxEtawinNDmbPr1m0h2fL22MIhf/g+X7P9fCGveGEIkArfWRUUYrLM7Z3VNcDO5U0atUOyIeEgnPo30YSpnj+g592cXFOllFmdwC7Bf8FKBr7rTp/7zXk/SiB+WiKZwRBjgIdDzZbuYGpHSbRZU/o0kzAg1/CHCcxHngxMRpVHiMj5JlRop8qtWgcQrL0U79OJVQ7hlWTo/d3E/kLBCgp13it5GYOg16UD5S2Bir+VhmzYaOKAIkUSE4chcjMNjVBvYWMWKrleNgA/rpQbRWprjKpK44k3XNbr1752jI6w58VR9yDEEvNhx5Wxf8y+HpPr4MC+M8JNYbSe1TV4pPqRAh4rqs8DevWyHR9yP3UemhXs2pDGcwJVSBt9CwE76Y46Rorx8L6DNLmWe+iFQXPfYnnSIk38LRLftTgeCyrpfSR7zWa9HgSOVTUsXh734y1zzolj7MbVwo+0vrLDfnvcXyt9JdcbQCnYvCvnTSWRmPHX4kjWJ1a0SYgKFzSWOyd6nYEZLbJXM3viScsKqp1+KVX0PeyFFSFP21Z0rUjhRuf2dw6jbbiKVDS3F7zSQP8+RzwrXZzMFjLicrpOIiWcQVxno2TqMp3bOm7228F7o1wMe1ef1PabaHs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5032.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(26005)(83380400001)(186003)(2906002)(31686004)(8936002)(508600001)(4326008)(36756003)(8676002)(86362001)(66556008)(66946007)(66476007)(6486002)(6512007)(6506007)(31696002)(53546011)(316002)(38100700002)(6666004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdrS2tTckVzYkNPS0N0bDFXVTl1UlYvNXRBMGcrOE5FTmh1SWhNNDN5ellj?=
 =?utf-8?B?OEUzbm5ndVQ5RVE4UlRRcXpaMEgxcEM3QmpRN0Vwb1ZpK3ljZ0JkY1BNVHJN?=
 =?utf-8?B?b1R4MFBsYWpUWE5Pblc0bXQvcGlPby9ibGpQWk0wT3BobTZmSmpCdEJuWXlH?=
 =?utf-8?B?NEZYSDZURzFBLytOQ3A2RHlRbzhRZE9ib2RXQ1lrYlczTmtmNGxIS0ZOc1pL?=
 =?utf-8?B?RDNPdFdxaXF3U2xGb0QxSTVaRlhxb1N6QXFaYzNUS0c5dHZKZ2JGL1YvYkdN?=
 =?utf-8?B?M2ZQV3RFU2toUDcwWnV6clBETmNzN1dlcWtaS3RyMGNaSmdaQ2Zya25kQ01Z?=
 =?utf-8?B?VExabWJaSHJHYThKUktoS1gxRXo1eldaNFNSbzVDeHdUWVkrSHE5cWtpWlZ1?=
 =?utf-8?B?KytUUjlRNmxDQS9admxYSjBScHRnd3lYUjBTYWdBUnFlWStCcU4zTVhHb0pG?=
 =?utf-8?B?empzYVB5QjUzVC9HbVZmdVNHSldCaDdaKzVGWTdWTzJBYXYyQWZta0FKa3Y5?=
 =?utf-8?B?dVFObUU2bUk1TXdVZE8wbmFnQWhOallkOHhhaEJiQ1hFeUowYnJKWFAyMit2?=
 =?utf-8?B?R0sybjlDOWRUOWRiajJDM2dMYWNZZnYrYW9lek1ERldkOHFESG4vUVc5dGFM?=
 =?utf-8?B?MDAzdHE4K0VEMzl6SW9lcnFETXdKR1h3eHY4ZktqV2dlSCtNZVAzMTN3ckJS?=
 =?utf-8?B?KzMrMDJuTEVWTHYzazVsNXh2UHg0YkkwV2p3djFHOGU1NUttVWQzcm9iOFFP?=
 =?utf-8?B?aFFRakZxakJCMFdwMElGQTk3ZENkTldpc1JrcWhUYXJEdjdOTjlSNWRVOFpz?=
 =?utf-8?B?Tk9kM3JYTzB4RlVwYkVyMHNKUjdqUDl0ZkRZNmRvWUFhaEUwVUgrbTRjSjBX?=
 =?utf-8?B?TGtZM085bU9QSHlrbjNSejhaREJwN0sxd1RneDNjYjdzb1hEemI4UG1BMmN2?=
 =?utf-8?B?eWRMZXozYnVPRDRYMTd6dEdFUHk1dDdCTk1zMDU4ZkZBTTdwWEFjZnNOZWZy?=
 =?utf-8?B?Mmd1UlNvZURJUHdBTy94VW1yeWhFNS9jaUdGT29WdGxvclJwNUVreFdpM2w0?=
 =?utf-8?B?YzBIaXpaZGZwWXNWOU9WOXRHdHlCTDhlYUh3YUFGS0I0aktZOFZ6NHp4bXJR?=
 =?utf-8?B?Ynk4T1h4Y3dOcDJwaG9HMjVjSmp1MmVDd1h2NytVTXFDYmJzRC9NMjdiWWhE?=
 =?utf-8?B?QWlyYlYrZTMzWDFDNUowMEswdCs2N2xRY01UTTk1WnZna2pOYmk5RWdDeUdK?=
 =?utf-8?B?WnU2WEM3VmloWG9pMXdHUXBrRUNhV29FSjc0OXFpZE50Mmd4UzA4MU5TODZC?=
 =?utf-8?B?ZDRMRWFIdUFTSWpFeVFocHZhRDhWNUdUNHFBekp5aHpqcEJDdXZ3MlkzWUJ2?=
 =?utf-8?B?Qk43SWlLWUxvWE91RHVEa2lpYTB6eDNDc2FVTElMZ2R6enhQbzNuR2RySDVL?=
 =?utf-8?B?OWdBUHFIUzFpaHZ0K0s3QlFJZ25XTHVHdUZNMXE3S3FoZU1ZY2ptUHk1MGUz?=
 =?utf-8?B?NXU3OCtFREcwTEhYbW11Vk1uaVc3TzVka09WUTRTOXhuTkJSNGJNK0wyZ01Q?=
 =?utf-8?B?MHFMbHE1bGdLdlNUMk83ZDFQclNpYzNLbzJXNFVHNlNFdVlBOXp4WWJMdFB3?=
 =?utf-8?B?ZjlsaFhWb2dUVGhWcDJ5Q0l4YVlCYUcvSmhvSmlWU0dxMXRKU0E2MGJ6ZXlj?=
 =?utf-8?B?UGxBTEc0VmRXSkhWT1k4bmJBQnd4R0JGVU05RGVKck1FNG0va0YwdjgvWElC?=
 =?utf-8?B?VDZTVnF5Y1NwdkVLcXBEZ0M0UWxKYWI5Rkx4ZFczckZVcU4vbks1NEZrNDZK?=
 =?utf-8?B?SlVVY2dXUFZJc0lLWWMwQlhwTkxzWXMzUGZzUEZxY0lKV2J1R25HRE4xWG5p?=
 =?utf-8?B?ekN6elIrVWRrMWFuZjcxRUxYSTRYWlhKTVk1RU1VOTNQRTBMUzJ1TGFwWUEr?=
 =?utf-8?B?ZHB0RUduSkNsc1RsZnFqVU1WRWFEalVvWVN4eks0MERTQy9uNENGWndQMEhR?=
 =?utf-8?B?Q3RlUTJ5SkxnZEZSb3NaZEJOQks2bDVmOFdnTXJSdWpBclE0c0NHYlRhUDNy?=
 =?utf-8?B?SnZ5NmFTK2xkc1BQWWdCRjlTRTRqL0dwbnd0aTFoK3B0UFl3eUhKOTJtclkw?=
 =?utf-8?B?ZkVKYzdTa3NjL1B6ckttYU5VeDdZc0pzdkppN2NrNkZUajNWZHVNem5xWGxN?=
 =?utf-8?Q?138i41YwEDrXDG45hILuK60=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3fa346-c698-42eb-198f-08d9fc52e31b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 13:45:17.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3HQyI8AKu01nqd6HbP+Fwv0MhdYOG90XNpkGQhO0OO7S6fhz8GAdHL+UmJ5MrOauRDsYHcA2r5Vq1MlWOPmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2482
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/2/2022 3:33 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
>> On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
>>>> On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
>>>>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
>>>>>> Currently we have a BUG_ON() to make sure the number of sg
>>>>>> list does not exceed queue_max_segments() in virtio_queue_rq().
>>>>>> However, the block layer uses queue_max_discard_segments()
>>>>>> instead of queue_max_segments() to limit the sg list for
>>>>>> discard requests. So the BUG_ON() might be triggered if
>>>>>> virtio-blk device reports a larger value for max discard
>>>>>> segment than queue_max_segments().
>>>>> Hmm the spec does not say what should happen if max_discard_seg
>>>>> exceeds seg_max. Is this the config you have in mind? how do you
>>>>> create it?
>>>> I don't think it's hard to create it. Just change some registers in the
>>>> device.
>>>>
>>>> But with the dynamic sgl allocation that I added recently, there is no
>>>> problem with this scenario.
>>> Well the problem is device says it can't handle such large descriptors,
>>> I guess it works anyway, but it seems scary.
>> I don't follow.
>>
>> The only problem this patch solves is when a virtio blk device reports
>> larger value for max_discard_segments than max_segments.
>>
> No, the peroblem reported is when virtio blk device reports
> max_segments < 256 but not max_discard_segments.

You mean the code will work in case device report max_discard_segments  
 > max_segments ?

I don't think so.

This is exactly what Xie Yongji mention in the commit message and what I 
was seeing.

But the code will work if VIRTIO_BLK_F_DISCARD is not supported by the 
device (even if max_segments < 256) , since blk layer set 
queue_max_discard_segments = 1 in the initialization.

And the virtio-blk driver won't change it unless VIRTIO_BLK_F_DISCARD is 
supported.

> I would expect discard to follow max_segments restrictions then.
>
>> Probably no such devices, but we need to be prepared.
> Right, question is how to handle this.
>
>>>> This commit looks good to me, thanks Xie Yongji.
>>>>
>>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>
>>>>>> To fix it, let's simply
>>>>>> remove the BUG_ON() which has become unnecessary after commit
>>>>>> 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
>>>>>> And the unused vblk->sg_elems can also be removed together.
>>>>>>
>>>>>> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
>>>>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>>>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>>>>> ---
>>>>>>     drivers/block/virtio_blk.c | 10 +---------
>>>>>>     1 file changed, 1 insertion(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>>> index c443cd64fc9b..a43eb1813cec 100644
>>>>>> --- a/drivers/block/virtio_blk.c
>>>>>> +++ b/drivers/block/virtio_blk.c
>>>>>> @@ -76,9 +76,6 @@ struct virtio_blk {
>>>>>>     	 */
>>>>>>     	refcount_t refs;
>>>>>> -	/* What host tells us, plus 2 for header & tailer. */
>>>>>> -	unsigned int sg_elems;
>>>>>> -
>>>>>>     	/* Ida index - used to track minor number allocations. */
>>>>>>     	int index;
>>>>>> @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>>>     	blk_status_t status;
>>>>>>     	int err;
>>>>>> -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>>>>>> -
>>>>>>     	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>>>>>>     	if (unlikely(status))
>>>>>>     		return status;
>>>>>> @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>>>     	/* Prevent integer overflows and honor max vq size */
>>>>>>     	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>>>>>> -	/* We need extra sg elements at head and tail. */
>>>>>> -	sg_elems += 2;
>>>>>>     	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
>>>>>>     	if (!vblk) {
>>>>>>     		err = -ENOMEM;
>>>>>> @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>>>     	mutex_init(&vblk->vdev_mutex);
>>>>>>     	vblk->vdev = vdev;
>>>>>> -	vblk->sg_elems = sg_elems;
>>>>>>     	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
>>>>>> @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>>>     		set_disk_ro(vblk->disk, 1);
>>>>>>     	/* We can handle whatever the host told us to handle. */
>>>>>> -	blk_queue_max_segments(q, vblk->sg_elems-2);
>>>>>> +	blk_queue_max_segments(q, sg_elems);
>>>>>>     	/* No real sector limit. */
>>>>>>     	blk_queue_max_hw_sectors(q, -1U);
>>>>>> -- 
>>>>>> 2.20.1
