Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EE0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 11:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355285AbiCPL1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbiCPL1A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 07:27:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30609652D7
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 04:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3m1RI9oyDVmLMxiSrHPuE3LXet6y4YMdtNNBn428g4lt5K2WcQp5gcLvHd80LKuyJUYefn7bDDaUjT1GIbES2yTZaePJHszFpKLTmukbMHis4ir9+tTJB1dGNXRjedSOCHCpRpMCtz+lVRoY2IuWfYHxUJy9ksygconrzUok1oGdzhSgUR3tHW/KAAWRrM7D+y+ZEP3x7IXtvnikbu3DmvjanRjRorK7yxy0loZdnXSBHrwn19W1DgO9Jc3ieC0RDSheX7YYwmvOblEJ8b6lvPxMTs92XbWu+sS0C/V2S4ZVhO19uLGcUVmSoSjeKDR6SJv0RPfyxGXji4XpsX8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu1x0bFDyTi1b4/Z10Shfjrqju1IIBqhnNTewJF6mKw=;
 b=MeFS03B9Bul68mfwi9RoxKwG27pBUZunJXZQs90lKJ4ZaKyH/z/P4mHqtleG5yToslDeCTjTfcYISH9hVg5XgV0mrTZYSq4rFShocowyugZslto7rV6HBgIYUqAE4gLdQAR7Z5LYyCDv5MyIGuznVuiYFPfDAmmhsLEMqg1vJR/G+lf0p+pR5vpJTdEfHA/aO0viasUIItLFHWjo2+YXclWVh4Yl86ovBzuspayzspIy8O65cGnZg/7unUcGUjFO9rKLT/+4O2DUTZPIVKwFyZ6KUBU4geNW1Yw3Wv1Ciq9rH6w4K4hkbeCfLiqsPJbjYQxhgXw8jBCrsAJ+mZ3I8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu1x0bFDyTi1b4/Z10Shfjrqju1IIBqhnNTewJF6mKw=;
 b=KpSO6zAP3dJjcfGdJPfFwd7eMqBkhyh6O68Cbkr0EO33+fBBgmZXPuYnUlfswyQhP6TqMXG3zIPq2Ughi2lVh1QZlOcoviK1A0x68lT2itPOYQBJtCHlA3U2C2IFHu5S1qF7z2zCu6tzyzB2nsvxz2TivvmmTPtuD7HGpohs014k5Uijwak7QBlIrZYfutb5clyMkgKFFf+LkyDNco6vnnM5IC1rFZPql3wLbqyS3zhFHSsUxAJddoDbf7N8Tr3luaAhBOtLz2EChmf02Nkag0P8/t2v/vh3iChhmPJgCcW1kQ9YFCMJ6CWbwvf0N8rB0O9sB9gcl9MNu4+AWmBECg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY4PR1201MB0200.namprd12.prod.outlook.com (2603:10b6:910:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 11:25:44 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 11:25:44 +0000
Message-ID: <b692982d-f597-894e-2c35-98e5d9059573@nvidia.com>
Date:   Wed, 16 Mar 2022 13:25:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>,
        Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst <mst@redhat.com>, pbonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
 <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
 <YjCmBkjgtQZffiXw@localhost.localdomain>
 <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CACGkMEtxadf1+0Db06nE3SuQZhvyELq7ZwvKaH8x_utj91dRdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0075.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da092ea0-910e-48bb-013d-08da073fb61a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0200:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0200D9EE625E6CDC651C4AACDE119@CY4PR1201MB0200.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oEv1yrkzmcZfCWwbeAsYfUcSSBmddq7IrZ6LvmVSR5Qf8jFLs8eaz9YSbtYN417tvlcaiglalFF5hWOWXN0VXNDCKn5hVFlLXLHUOZ0Hlk7+P5k1UQM+mt+m0EFjOT/co9jYEOYOSb0X5tQvYYz1XdhCXqlZBuJ3aVdko9N+EFCd7s+5gezc6oWKzMXmvKzf+UMw+t9Jgh+e3w5GI8gduwWFy3A/6cwr1P18rDBV7Tp6lHLaa+x9seb3gZBSU/S2D0i7oWMsP2uu4g0yHQ3eeWeCP/R0kZghYZxdkSFkJFQVtupEPo6lSPPx6imRUqcT6Nga8yFOEaqMKpMgCbluE1UZeuLKfLkqrZbRJX1tyF46bcsqKlv6c0fL+iGAHzY9YX3qOI0/Vx1TkBr1xmtr4Cdwv0N2bbd0P7o2YWgdy2NdKaGGp7thQw9HtRKgRM706U2Rn5lC2N70KlEZVMOae+a2tbezbCrtoFOMp737Smx7PJsNmnuqePSAPBYMAICemGrvvx958Mua9c88GXfm6gpaIJm0tc0VNeZtioxoRtUUPqh6n/yp7J8IUyq6RH4m983uhnzZJ77Ms47UnOxu3L9jDi/s+AFJjA+/sDo7lrsFzxGmXyWdhe1jrUO29AYuMtOVzfjwigcpYLx21aN6cJioqg3iIbm701WdqhYSOVo3JJQkrYlLGQIwsOHKYetuBsCNbRxr9ioSjU+UtIuafCJAiwtsqXhHmsMSfDag6Z+5l7QePyR92FrYIz2tKoA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2616005)(83380400001)(53546011)(6512007)(5660300002)(31686004)(2906002)(36756003)(8936002)(38100700002)(86362001)(66476007)(66946007)(31696002)(6486002)(6666004)(508600001)(26005)(4326008)(186003)(316002)(110136005)(54906003)(8676002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk1peDAzenM0eXovdStBL3VLdjVORzNDSVVtcUo5akFNY3lqNkxzVzRsSVkz?=
 =?utf-8?B?Nk94bDlQWG9BZVBraERSaHJlVWJlcCtRNHduallCT3p3c3l3K0x2NTFsdXU1?=
 =?utf-8?B?dVVhOHJwVC9XMDJJa3IvUlZzeWtyYUgxcjRLengwMTNNM3VpbmJBZjJXOVJS?=
 =?utf-8?B?YzRjOEtCU0p5MHAyb0FwMWkwcDBDMWFHSEtXOHNDWi9FaW93SU9NMC9DdGtG?=
 =?utf-8?B?emxDY2xNOFRFYlhPaVRhajdWK1crUGZ5eXBOVW0vWmN2eElEZ1FDRDdtanBs?=
 =?utf-8?B?SzFMcTc2TDh3aTc0Um5DYlRqVTNGOVVabkZxSUhGbUlVNFdaOVVQNlBsWHpS?=
 =?utf-8?B?QjlSNXBTOFVkRFhXT2xHSis3Z3Ryb1NCTXNZdVQvaG12N3pCUjlnN0VEeTJO?=
 =?utf-8?B?RFkvRXI4SGZ5V0N1eENya1dQYTZ5eEtab1dRNEt5MVhWL213Q0ZaSURCdDdO?=
 =?utf-8?B?TGdvbzNyejlONnRja0FUUThPR2ZlWFBZTllpVUM3a2hjL29UbUhaWU9zZDY2?=
 =?utf-8?B?N2NkR3V5Szk1WXc0NzFtQVNEa29BWkg1VFZQWk9EaGtTRmJxTXUwOUNiajVn?=
 =?utf-8?B?dVh2YjVyYW1aYyttMUhrMzlRbVNmSktJYzdzK0J2ckNsbkhUdnV5NlhDdHdo?=
 =?utf-8?B?QW5GelUwdGQ5RXRhMXNldFhvTzMrdSthSkRvWWEwYlFkZ3dXaWw1Ni93UVhr?=
 =?utf-8?B?R0pYY25WdXZCMWRSbWc0L3NQQjFEZk8vM2JoVHV0MWJiTE9sSldLb0o4Z2lN?=
 =?utf-8?B?aVlXbWZ3OGk2dnd5bGpkS1kvZkg3bUY0M1RhMk8zWExud3hiWmNPaHp6Y0hy?=
 =?utf-8?B?d3JNUTlndVgwcWp3dERxODhvUXFlM1R2NUVjelV5RlMyYVdwU0FSUW9aRFhB?=
 =?utf-8?B?WG13ZlBZUis0TVV2OXRESm5IUnd4cy9uWkc4c3NBQjdvdktDbHI5L2JtdkdI?=
 =?utf-8?B?MWpGekwyMSsyd0xiY3l0R1V0Y3VnYkRtbG5FQ3lQOHluMWlTa2R5RjZQZFE3?=
 =?utf-8?B?N0xOemltVDBqc1BtV2p0VkxkZThBdnJWUTArQW9sby9LNFdqTXF3VnpaajMw?=
 =?utf-8?B?Yk43SHdmRmZaQ1dlVVV1UkRyTXlKczFvRVYwUkpERmhJL2hpWHlqOTh0OFpG?=
 =?utf-8?B?MGRSdkJzdi93RDRpRjN1ZUxXTHE0azlSVVBSV1VzYmlmejBtaUxqSzZNT0Fp?=
 =?utf-8?B?eWQxTHVDMjRBTmd1UXlVaHBPb2xWamIzOWRJcVBVSXkxamhnOWhKUzBrMUM4?=
 =?utf-8?B?K3BsVnNpUnZUVjNuT0lVY202bzF6YUNaejJNT1NMTG1obTRldFYwd2pGZWxT?=
 =?utf-8?B?cTRia2hXWVNZQ2MxQmVKOUxXV00rMXFvaFJsM0RmVHdXVmJwb1BIYzFwYnhr?=
 =?utf-8?B?eWR3MndteXNSdXZ4cGM2b2RVRmVaTkpicWhEQTFRWGlHM0MwQjFYTHY5blAr?=
 =?utf-8?B?ZVFDRnV2TEM5MW9iMUdMYVZiSHNScjA4d0hlV0pvVjJmcnlPMjRSUEY0TDd4?=
 =?utf-8?B?b0Njc0FXOXNLcFRvQlA2YU5EWHJOZHltVlFNMWZsM3lqWTJvV2JvRUFack5u?=
 =?utf-8?B?UURQSVBwQmVlL0YwS3dXaUczY1BiVWNWNlFVUU50RnpxdThYZDJXRmh1UWk4?=
 =?utf-8?B?c2xxTTRYcEJYWEtPTE9XMW9nb1prQVRJc2ZKLzFkNXNjUXJ1RUFULzVDbnhD?=
 =?utf-8?B?RjA1ZXRQcFJBSXpSWDc1em4ya2JxelpZNjdNNnBkaFFXanZ6K0JYRDZGeHY1?=
 =?utf-8?B?dlRwczVHT3N5eTA3Y0d5cDV1N0lscHlZOEQyREtXckY5bkVFbUZ0YVBrQjRU?=
 =?utf-8?B?Smx3R2dxdnkrb2NMVCs5ZTBFd2Y2cm9LNUpkZFhQWHFDVmRRYkNheXlVR3hu?=
 =?utf-8?B?RjhGYkpGWjNOelp1eFVGcnY5NUhEY1FyU01ua0plWnVIaHlqUmpBT0tTVUtU?=
 =?utf-8?B?MXQwVG10MjY0VzlYL3QxR1c4K1ppWmJpelh2Z0tuc3dkN2hicDk0bFc1WVd5?=
 =?utf-8?B?ZFFzTTBMTDRBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da092ea0-910e-48bb-013d-08da073fb61a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 11:25:44.8181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nywi7S+VfaE07W3QPiB2rzjDEA++5gpUhSu3EwfTtNJvV0lM6Rkph9iR+ZynReCCG8ibEYgpya207GZstVHnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0200
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/16/2022 4:02 AM, Jason Wang wrote:
> On Tue, Mar 15, 2022 at 10:43 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>> On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
>>> On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>>>
>>>> On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
>>>>> 在 2022/3/11 下午11:28, Suwan Kim 写道:
>>>>>> diff --git a/include/uapi/linux/virtio_blk.h
>>>> b/include/uapi/linux/virtio_blk.h
>>>>>> index d888f013d9ff..3fcaf937afe1 100644
>>>>>> --- a/include/uapi/linux/virtio_blk.h
>>>>>> +++ b/include/uapi/linux/virtio_blk.h
>>>>>> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>>>>>>       * deallocation of one or more of the sectors.
>>>>>>       */
>>>>>>      __u8 write_zeroes_may_unmap;
>>>>>> +   __u8 unused1;
>>>>>> -   __u8 unused1[3];
>>>>>> +   __virtio16 num_poll_queues;
>>>>>>    } __attribute__((packed));
>>>>>
>>>>> This looks like a implementation specific (virtio-blk-pci) optimization,
>>>> how
>>>>> about other implementation like vhost-user-blk?
>>>> I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
>>>> use vritio_blk_config as kernel-qemu interface?
>>>>
>>> Yes, but see below.
>>>
>>>
>>>> Does vhost-user-blk need additional modification to support polling
>>>> in kernel side?
>>>>
>>>
>>> No, but the issue is, things like polling looks not a good candidate for
>>> the attributes belonging to the device but the driver. So I have more
>>> questions:
>>>
>>> 1) what does it really mean for hardware virtio block devices?
>>> 2) Does driver polling help for the qemu implementation without polling?
>>> 3) Using blk_config means we can only get the benefit from the new device
>> 1) what does it really mean for hardware virtio block devices?
>> 3) Using blk_config means we can only get the benefit from the new device
>>
>> This patch adds dedicated HW queue for polling purpose to virtio
>> block device.
>>
>> So I think it can be a new hw feature. And it can be a new device
>> that supports hw poll queue.
> One possible issue is that the "poll" looks more like a
> software/driver concept other than the device/hardware.

Agree. Device/SPEC should give a possibility to create virtqueues 
with/without IRQs and it does.

The driver should use this capability.

I don't see any change in the virtio blk config space needed.

>
>> BTW, I have other idea about it.
>>
>> How about adding “num-poll-queues" property as a driver parameter
>> like NVMe driver, not to QEMU virtio-blk-pci property?
> It should be fine, but we need to listen to others.
>
>> If then, we don’t need to modify virtio_blk_config.
>> And we can apply the polling feature only to virtio-blk-pci.
>> But can QEMU pass “num-poll-queues" to virtio-blk driver param?
> As Michael said we can leave this to guest kernel / administrator.
>
>>
>>
>> 2) Does driver polling help for the qemu implementation without polling?
>>
>> Sorry, I didn't understand your question. Could you please explain more about?
> I mean does the polling work for the ordinary qemu block device
> without busy polling?
>
> Thanks
>
>> Regards,
>> Suwan Kim
>>
