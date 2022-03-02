Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A1EC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 14:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiCBO2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbiCBO2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 09:28:14 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE435DFE
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 06:27:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxMJNFW5uzpS+Z279AmqpdrTDYgw6O/hbBZsjcfjLGPS9rQAXGsB6gnr1J4yhJiM5Lul9ytLui6PyS83dbPcwq6xY/QrUVlj0eNs1Dm2GjCknej3eQI/h/XMo/aKFUxzw8VeSKchr6N09qK3NC3zol8OFHj8jeKYJbv9E26qi7lz7IhJHaZKzJij0YwdHWY4NlqAwzxMFmrFQIj6Pym4Cak8hRCOnZCTtUd0BN5FXlqjaNlVnHaoA9qQ2v/ehjfF+xHA6AmVF1HQKQxVQ7WiIFtSnRGWvJdEA4mwXzGiPF9wdZQ4RBLnNPu45m2zM5qn/cz2wVE+ggowdG16Q87GtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwRvqN8ou/P6ZswgKKdff5p9975K05a7uhOad7qOGvE=;
 b=FSmLAzAYIdhPgU14HFRa+aTLCv2y6S3UsFA6LdShc8GH6qwTiDqhWU2crC45Tm/N9148c/92jqtBU/PTrYoVs7ldgbI9dXzdFcQPXWhub0f4Xr5vroCfwJCAw2h8vJEo4qKoWjqUKjL35R7gX67AOfx3kTzAVCuQtAsVRSCw7OEgewb+KO5FB/U955JNwVgjqze0yBfq9u5XBoP3UjXv2lqjAKePN/3wH1TBJP7ZyoAjQ/OsSxzFMVgM2pVPlZU7O4lBJK9DalUGPdrmwi1IoyhcJt84b79BXUa5l0QyFGfi9aPJ6vwc35Rh6lsGqczGj5uKN+zuBqlQwtAPDRjgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwRvqN8ou/P6ZswgKKdff5p9975K05a7uhOad7qOGvE=;
 b=SHPyrDQt7Y7zUy5oHP81Cs3yjA3oso+L5yylf6lQvHTr8AfEj03cETwzlgjc0F1pHMYGGjjOXPBtSL4Kj28fPmXlTOpzC5JSPloMG4pfUFoknkRKVT7aFBfg7I0gKYkoHpmzYB0EAKgVqBAV9hOVvK4E/BkQj0usENoXMAeAhdRF+Y6ATpgsIkRBK4J6vDqvBKzWJkeSeSx06ig428TgFSmzgPqtJrh6BdtSlQmnVVrNNijKvSbQ2Yercd58tOQudTn7bWhe34jtq52w1CluXyhU7BVk8BgF64je59nQWLyWQgubYGMctt02aur8j2YfKnvvhMQLYXRMc13SRKzrYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Wed, 2 Mar
 2022 14:27:23 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 14:27:23 +0000
Message-ID: <fe42c787-700c-d136-75b9-5a3e1b6d1b4f@nvidia.com>
Date:   Wed, 2 Mar 2022 16:27:15 +0200
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
 <808fbd57-588d-03e3-2904-513f4bdcceaf@nvidia.com>
 <20220302085132-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220302085132-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::18) To BL1PR12MB5032.namprd12.prod.outlook.com
 (2603:10b6:208:30a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 361a9763-1971-46d1-2290-08d9fc58c41a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB36570094CAD13966C65C94B3DE039@DM6PR12MB3657.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3T8sI4w59pvSf3+7nYYC75jAbEApdekKguGxi7kd2nCL7IqdNBmQEO0nDV7f5uiIM+LbHaA9y20i9cDwRxO9eUZCi13h140ZCl/iV9jnseTpkVybLamAbRTrFCInCmGmnW002MakioDFhD+lvlP7nqro2tWg0Rhb3ThiSPHtj4P7hSNrPaYjxuiI2qJG2u/LWL4NyvhRZV5yuAYKUxOzsHvXe/GflRRZ3ZAlAhO2BKZp9OuyHTfO7C7O3iSEEIbmkPd3VPYr07RHe6YKM0yDP1PL9TJLr0X91aFn+BoXdQDCRu4NhOYFnziprBF6MzoStH/9PuCDuOD59cgMdWuyev3DdXKOejwMAMzrCA9lF1fjkJ8W5CcSSaPAexBQgoVzOoKELRm/Oo2f+E383n+TZBTkETTaZgWxH6c8SxVAouxU3b9/+4MHsrEmdH3NuQccG4Pmb4VulrFVaqJnN3zdFkHbysBsP8G7N0atWVMkOQWqg6J52TzuHA/h5CBqgES+wvZtwSStaWkyCTBmRM+dusSnzwHII8yfFX9f6Z6NaiFf8Z/Cn17i6sd96vDX7HynCktIUnhcXfGm5vkmgoD4zC36JUSrWM2ANR1U3JfYYDm8oMK0wwjXqJF76NmIa1oDiXKieZvo4YGA1kBJ/thBXUI8bFMSOpJtAdfwpYLhy9sBINim+2spzngWi5C6bvNZqgAkd3ngdGjXJ5hOqoJhjjE8usMi6gkq/jEhd+siNwBj0Oe5xzK+BBkvQOxVuAd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5032.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(8936002)(86362001)(53546011)(6916009)(508600001)(6666004)(316002)(66556008)(66946007)(4326008)(66476007)(8676002)(26005)(186003)(38100700002)(6506007)(5660300002)(6512007)(2906002)(83380400001)(2616005)(31686004)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xLTXdWbDlrOFV5SE44WFV2SWlmYlk0L2Z0VVIvWlZITnpHbmhRdGt0a0hY?=
 =?utf-8?B?MTltWXhMQVpUNk14VFNwaDhpd2ZvT2Z6TklxSkF5Z2d2OTNQMy8raUY2VTF1?=
 =?utf-8?B?MnRtOVR4cjVpY2lLOUY5L3YyZCtVeWtIbkhqMzJWRnlUYVlZalEzTDZhVDV0?=
 =?utf-8?B?YklnRWkxUXc5ZTMzNjV1YWh3UDNjM0Y3d1hKUm1ESlRZWHpFUDBVV1dneExG?=
 =?utf-8?B?ekh5RTlhdVM2WFM0bHZabjZJQWNYYmpMTERSZnh2c3dURENiK1BBZHhQenJK?=
 =?utf-8?B?cGQrdUlyRlZWMXErRkZzSUFmMU5sVm1Md1I5Z204RVVxUEhnNFRtRWRJalNW?=
 =?utf-8?B?VjBoalk5M0tLYjNpU1QxUmg2MDA2dVVibi85dEVZL3VFTWNjd2hzdFBSK1Vo?=
 =?utf-8?B?OW1jbXo2Mm1KQVBSR0NCdm91QkwrQ3dCS0FUOE94d3VEMU5MMlYyTXpjblNT?=
 =?utf-8?B?dXRERHRESy8remxvN1MrMDBWZlNpdkQ5RTZtRm9QYllHQ0wraTJsQi95QlZG?=
 =?utf-8?B?MFdjV0RZVmR1Wnk2K1dvM0hOTGVoYVRGclRjZGJjbllyczdMTklWNHhidnBU?=
 =?utf-8?B?dEVUaW5kOVJ4UHZnekJzY0d5ZWxBellrZmhuNHpIR2gyeVp1bGEyYWMrS0pt?=
 =?utf-8?B?alZKbGtkYzJWUzBucHQrcHNGS0RJOXI3aW9GcFVpMDJIQ3hPYXcwcVpuK1pZ?=
 =?utf-8?B?TUwrbWt5OEFSL2dVY05uMytmd2daWFRGMnZ2LzRzcmFPWkRqWTRCQm1vclpx?=
 =?utf-8?B?ZWV1N3pPb3pwVk92UmtrZ3lVbUsyS2V2VDdUakdjOGhkbEpiWUI4ZU1jaU5R?=
 =?utf-8?B?SlMrbG9QNkwxNnArL0hMRWxWUTAxcmNqV0QzQ2U0UXlEMzVaOW8zRU1UMzBJ?=
 =?utf-8?B?eFQ4Sm9GWWdRS3hZVUoxeXVTVW8rUkNMRDdhZE5kMmlWa1NNU2pPNmQ2S1pN?=
 =?utf-8?B?K0JaWXNISmczZm91MVpVQmJ1S1VGNTJ6Y2VrVkd1VU1QR3FlaWhLSjVJL0xY?=
 =?utf-8?B?dE52VnBWMGd0OEI3dUo3Z1VXektGaDI1NUgzQ0NtRkkwektFYllMK29TYzMz?=
 =?utf-8?B?QWdVdHF6QS9zQVM1SlcxcFVmUTZtSUx2Mnhhbm1PSjRqcWpYZGhYSEhjYWg4?=
 =?utf-8?B?dWtiUDlJc294T1JPNjloenNWM1JXSGRWcFVmdDAwUUVtdXhpTnJaMEpYbVNP?=
 =?utf-8?B?WkMySERlcGw4SmF4bm1RVm9ZZlhIQzA5NjdLb3htWWNkYk4vdlVVblpVZ21l?=
 =?utf-8?B?RjZFRDhnTUxKOFg1cE8wcnFlR2ExMGcwWHZKbk9taDJuMmZMVEpWVmhkSEIv?=
 =?utf-8?B?M0hhdSsza3VrWG82Y0kwRDRHZ2VtM2dJMUxYNFZpS0xQRGRVR1lybWF1RXAw?=
 =?utf-8?B?QVRSSkxTdGsrSFNhVmZ1YWlZcHJzYmtjRVRTVnZlMGdTMVFnWFltbzJCZ1VV?=
 =?utf-8?B?bUswbTc4eGQzQThNYTRaVVBIa1B0N2hEbmhsTHhlU1BtbkZEdWZEYkpsbUha?=
 =?utf-8?B?QkQ1Y01FdDY4RGQvbjJpWUZpbEhUbC9zYkpYTEtnZFJJSSt0d2w4OFBTRkhx?=
 =?utf-8?B?TzBWT0hIMGNGNlFxSXRITGVWaXVvdThXTTV2UklNQTdmbjMrWVBrdm1tV0I4?=
 =?utf-8?B?Nk44cU1MWUJkMjhYek9kUWR0MTZuK0Y5OVoveU95YjRqWEVrVTEySkhtYnpK?=
 =?utf-8?B?aEN2TDk4UU5JVXVKMXY0dkhtelBCbWFZdzd4YWg4a2duOEsySm11NEVWV3N4?=
 =?utf-8?B?U0JtaWtoYVhCWE96RFR1ckhTMU5VcHQxQUVsTlN2V0ZWYWVSZlBlZ041ejJ0?=
 =?utf-8?B?Y25IV2F1WTdtMEkzdkcxbTRZYk9aNlRDWXYweExYQ21qL1J3T1VCeTRjQ1F2?=
 =?utf-8?B?NkZTNFdwZjdseThtOWhSaFdER0dZNlJnaVY2cDJDYmxDR3poRHNlTGNWSVda?=
 =?utf-8?B?V1A5SmdmaENaYklFUmdRNkZBOXhzUWNEYzQ0aktQN3NjSHoralExcnp4eDEz?=
 =?utf-8?B?YmhKYjVJTXlqaXRzamRQWllmYU41ZlJPdVVxU1JnUE5zRFdsWGY5Ti9tK1NW?=
 =?utf-8?B?bFVMeUp2MENkOVBWZFRJcktlN2h5R0ZGZVF3UnZkU2VWOHdBbm91YlQ0eENw?=
 =?utf-8?B?ajQ3bHNkTk8wd0xoaDRvK1BwejdvUXpDNWFtV21CbjhWa01iOGlwMENXbXJ3?=
 =?utf-8?Q?yDM0gBVI2NDLRqVJOFzkyGw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361a9763-1971-46d1-2290-08d9fc58c41a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 14:27:23.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wQK7Aau9m7s+NN1JOA7xGJVIWZ5ci3+V4PhH+5cxp+jWvxoQZb02IXxiLcVIEhmiJbN0aO+QkGi9A69eTJMLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3657
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/2/2022 4:15 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 02, 2022 at 03:45:10PM +0200, Max Gurtovoy wrote:
>> On 3/2/2022 3:33 PM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
>>>> On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
>>>>> On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
>>>>>> On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
>>>>>>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
>>>>>>>> Currently we have a BUG_ON() to make sure the number of sg
>>>>>>>> list does not exceed queue_max_segments() in virtio_queue_rq().
>>>>>>>> However, the block layer uses queue_max_discard_segments()
>>>>>>>> instead of queue_max_segments() to limit the sg list for
>>>>>>>> discard requests. So the BUG_ON() might be triggered if
>>>>>>>> virtio-blk device reports a larger value for max discard
>>>>>>>> segment than queue_max_segments().
>>>>>>> Hmm the spec does not say what should happen if max_discard_seg
>>>>>>> exceeds seg_max. Is this the config you have in mind? how do you
>>>>>>> create it?
>>>>>> I don't think it's hard to create it. Just change some registers in the
>>>>>> device.
>>>>>>
>>>>>> But with the dynamic sgl allocation that I added recently, there is no
>>>>>> problem with this scenario.
>>>>> Well the problem is device says it can't handle such large descriptors,
>>>>> I guess it works anyway, but it seems scary.
>>>> I don't follow.
>>>>
>>>> The only problem this patch solves is when a virtio blk device reports
>>>> larger value for max_discard_segments than max_segments.
>>>>
>>> No, the peroblem reported is when virtio blk device reports
>>> max_segments < 256 but not max_discard_segments.
>> You mean the code will work in case device report max_discard_segments  >
>> max_segments ?
>>
>> I don't think so.
> I think it's like this:
>
>
>          if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
>
> 		....
>
>                  virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
>                               &v);
>                  blk_queue_max_discard_segments(q,
>                                                 min_not_zero(v,
>                                                              MAX_DISCARD_SEGMENTS));
>
> 	}
>
> so, IIUC the case is of a device that sets max_discard_seg to 0.
>
> Which is kind of broken, but we handled this since 2018 so I guess
> we'll need to keep doing that.

A device can't state VIRTIO_BLK_F_DISCARD and set max_discard_seg to 0.

If so, it's a broken device and we can add a quirk for it.

Do you have such device to test ?

>
>> This is exactly what Xie Yongji mention in the commit message and what I was
>> seeing.
>>
>> But the code will work if VIRTIO_BLK_F_DISCARD is not supported by the
>> device (even if max_segments < 256) , since blk layer set
>> queue_max_discard_segments = 1 in the initialization.
>>
>> And the virtio-blk driver won't change it unless VIRTIO_BLK_F_DISCARD is
>> supported.
>>
>>> I would expect discard to follow max_segments restrictions then.
>>>
>>>> Probably no such devices, but we need to be prepared.
>>> Right, question is how to handle this.
>>>
>>>>>> This commit looks good to me, thanks Xie Yongji.
>>>>>>
>>>>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>>>
>>>>>>>> To fix it, let's simply
>>>>>>>> remove the BUG_ON() which has become unnecessary after commit
>>>>>>>> 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
>>>>>>>> And the unused vblk->sg_elems can also be removed together.
>>>>>>>>
>>>>>>>> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
>>>>>>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>>>>>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>>>>>>> ---
>>>>>>>>      drivers/block/virtio_blk.c | 10 +---------
>>>>>>>>      1 file changed, 1 insertion(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>>>>> index c443cd64fc9b..a43eb1813cec 100644
>>>>>>>> --- a/drivers/block/virtio_blk.c
>>>>>>>> +++ b/drivers/block/virtio_blk.c
>>>>>>>> @@ -76,9 +76,6 @@ struct virtio_blk {
>>>>>>>>      	 */
>>>>>>>>      	refcount_t refs;
>>>>>>>> -	/* What host tells us, plus 2 for header & tailer. */
>>>>>>>> -	unsigned int sg_elems;
>>>>>>>> -
>>>>>>>>      	/* Ida index - used to track minor number allocations. */
>>>>>>>>      	int index;
>>>>>>>> @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>>>>>      	blk_status_t status;
>>>>>>>>      	int err;
>>>>>>>> -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>>>>>>>> -
>>>>>>>>      	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>>>>>>>>      	if (unlikely(status))
>>>>>>>>      		return status;
>>>>>>>> @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>>>>>      	/* Prevent integer overflows and honor max vq size */
>>>>>>>>      	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>>>>>>>> -	/* We need extra sg elements at head and tail. */
>>>>>>>> -	sg_elems += 2;
>>>>>>>>      	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
>>>>>>>>      	if (!vblk) {
>>>>>>>>      		err = -ENOMEM;
>>>>>>>> @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>>>>>      	mutex_init(&vblk->vdev_mutex);
>>>>>>>>      	vblk->vdev = vdev;
>>>>>>>> -	vblk->sg_elems = sg_elems;
>>>>>>>>      	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
>>>>>>>> @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>>>>>>      		set_disk_ro(vblk->disk, 1);
>>>>>>>>      	/* We can handle whatever the host told us to handle. */
>>>>>>>> -	blk_queue_max_segments(q, vblk->sg_elems-2);
>>>>>>>> +	blk_queue_max_segments(q, sg_elems);
>>>>>>>>      	/* No real sector limit. */
>>>>>>>>      	blk_queue_max_hw_sectors(q, -1U);
>>>>>>>> -- 
>>>>>>>> 2.20.1
