Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F7FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 15:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbiCPPhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiCPPhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 11:37:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0196D1A6
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 08:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByvW6uXnH2+Y4ea2q9bWstZJFCt3a/dAv1hEbhW1ovdljxrfa+aOtzbgngYADj/CMop20Wg6Vvkr5TJj9x3aXYDKw9XY/4BUf+6y7oUEJxF5zrnjQwGVNvPvonvenoLpu7Demxs1J+yaN2AnuwHFRQ5QddaQ5lUvDRJ5SLhAdDaFmvv3bx9T0jZdf0gyDU3G/iE1T4e+XrLm3esT9fcBThEIWuZXp5sCpYnsr8qK4nMUtdVOOsOvUgz0YEKICTuVg5aNPhsp1vMLk92IyT+MU+yxPp16tU3sdg/TgHqxbtzXP9u/oGcyXSnuTTuTUMtlhqa7x+HlluOHvMv5RV4l+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZMyAkFX3okdD4huL0FR62qG6VMixKQxyL6UYC0vJY0=;
 b=VJDExNQy7/1rjHJ/doP+aHJyaGK0cTSPctka37m0W+p21m6qYYll9Cg5PLhnqlwGXKdvy3nwVlaje8tbGTrvcKJymdP3xe4hPa8gqXJ9kysabM0c1rQXxylybrIW1q6h9MWLQDBqDBCzSgWr1Bg1p6pAEDH6GhZvXlEHnkduqYkdCkIgA9JTdqDdj6u+j8skiuj9e7541lLTyiw+S1m2dvIpLDUFp00K037C9zG3BjHlaOevzyEo24xPO7PDiES+OB20wvdzVxDrp5XWUzQoHj24BsTpFgssNnNpiJewAxIwD++me9LgYCMqaxH1tU/VBFNdO20ZN90/MuDgBwJoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZMyAkFX3okdD4huL0FR62qG6VMixKQxyL6UYC0vJY0=;
 b=JBFZ70zU3lG98TtVK8SxpzGe7urC4jsRcMTd+KXrDsjO++UED5iiK463EI7hW7GRYHTbtTO1udSkYdIjR8Yj7uZbWkBab+MWF6xzWllI4juin+OU6kre5zSzU81OYCyrtlq6ZfsxpvXihtKYPKkmplCy2wE1JB9Ynd6Ff+agrnGleqou8gDaLYyTcEpm4tKKBkiCy7UXgZFRN5hg1W0ZVldtuijASRnNKunHEvNBLvmG2tH7NfF8KikShSwKkdrfjTPwiecKDZ3OM4LmBJBZmAFxF2HnGPj2cHpz3yc8gPxDPy4YqHWB3tMXFI6/jfq1l3cH5Q9MQ4lH6PB6CFgOag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 15:36:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 15:36:29 +0000
Message-ID: <96836799-8d1f-3865-e2e7-721150445e6a@nvidia.com>
Date:   Wed, 16 Mar 2022 17:36:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>,
        Jason Wang <jasowang@redhat.com>
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
 <YjIDIjUwuwkfRS2d@localhost.localdomain>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <YjIDIjUwuwkfRS2d@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 950db7e7-ef6f-495c-e445-08da0762bd33
X-MS-TrafficTypeDiagnostic: MN2PR12MB4143:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4143216FBD4FD4B5F6E90518DE119@MN2PR12MB4143.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jfaCw4gHBiR8jb7EUB9yDGhA72oPETXfuW+lAouV+YGx9umU13EWMVfL74PsAlrFmrafpEi7EHvCiVMOWWGWOZoNbqaGi2m3K6Qs5qISJdwfJbzzofrv22PwqbNZSpTLhbSjPkBOQxuPSu/H035b/Qjq2G3ct5Fly0d507f975b8gPZ7fF6J5mfElRrwmJEbEBK7PYcUM5W/hoO4hp6XR9+K/aKcsCyNKHpbtzZSrEs1kON5cPviVrcyvA5VT+3l88kyn6pLsZyXBTl6CnZ4Mczm+q/9pin086XQDyt2nStqp/yitY7FLEn44E0Atp/Fiw/zF1tiZFsEGuuSRzDxZ+KgD8VG3mrF7FW91FfpZ/wM82ZRVzwB6CopQ4TB+tg/E9p7DO7McjVeIx0bwvVOIZglsvWWRkr3re3NQJUD65jILhZT5Pu9CJh/Fik654QQHQQwwezAq/KE26rQ4nZaGfN4GlteebM/SWMkwmW8ocLZYpqctvCJvEfmpgqGxfXbw0yYy9qB98lfyeZGiadfpE1TdUD/KUACx+IU4OnINlkuMuXyTeCty2mAbHJYmF8WCgIbB0cVlqwZDjNwpMsX9x3ONNvJG/CWEU5TS5jQqPYj2mWW6exgpUMCEWDTsfi5UNG7Agbcq+I2R0UgcR3lW0l5tTd4mk+kavLQTkKZL8OdeVDgpcWGMEDrPBG8xBRFisv2f/NhfuNsSYElhT/SmrW4Zbl29k8UTKV4UjQ7C1OeBpqYN22Mb9OkTJYw1WVa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(38100700002)(2616005)(31686004)(110136005)(54906003)(316002)(36756003)(2906002)(83380400001)(8676002)(4326008)(508600001)(6486002)(31696002)(86362001)(5660300002)(8936002)(53546011)(6506007)(186003)(26005)(66946007)(66556008)(66476007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3lad0ExVU12eHAwN2hnUmJBNFZDRldMSGdONW9IUFBHR2JnWlhjZURlYnpm?=
 =?utf-8?B?L01reEtoRk9rNEJEQ3U2clM1Mzc4WjdRZ1hPck9ZL0I3b0E4NGhuYWoxOVRq?=
 =?utf-8?B?WndVNzdQRFpGc1RNZi9EK0lsNkhHUUpneDQrMi9GbzY4OGNYTUhCYnl3UFAv?=
 =?utf-8?B?K2QwQmFpMEFBVXRqTVpyVEFDSWRDTVIxWUIrTWJkeHNDRVNkR0VTT1E1L2ZC?=
 =?utf-8?B?bUY2bG13Y1BwNERtRnlqLzZxL0IrODNLbk5HaXh5VjhuNTRkc2greTJtRlhB?=
 =?utf-8?B?WVdHdFU4SmJlenl4TlI5UUFRazMyaTlPL2x4Q1l0SEtjZEFBV3k4ck1MODNQ?=
 =?utf-8?B?Tk0xMlBRaUVDTE0wRTVMYTJmQ2xxYjdPTWFnS1l3QVg2d2FFRk41a0ZRNThW?=
 =?utf-8?B?YkdHSjkxS09ZTUNjT0F2Yi9xTkxFUHFMWnNJdzM2VmdqWUk5MU04ajRHMWIx?=
 =?utf-8?B?dmlsVHRyQU5sUkZENDdaT2ZpQ1ZYc2xoblRWQ0ZBT1VLUURtMGhHNHBCQzNJ?=
 =?utf-8?B?eGF2RDByVUpYY1BnVUY3SmRicVo3aGo4V25WQ251aHkzUXloblMxd3ZQcWxm?=
 =?utf-8?B?YzVTTTFHYjJmOUF0amFXSUlwQ2d3T2lvUWxOdmg1Vlo0UDV6WTRpT2p2YUts?=
 =?utf-8?B?SFYxMWZyY2VKTFdLdGphSmpRMUxjVzVFVTdjQTMvTmljakFxTUlKaEh1Risv?=
 =?utf-8?B?d213eFgrSU94K0tBeVZ6YjhHNzVvNVllN0w1VW1UeE9mMlFXdkVCdDFmYXkx?=
 =?utf-8?B?MlhVYmJNRnpLdWoweURWR1Y2bWVmWWVNMU9iMlJvZnZBdGxoSW5GM0tGK2Nx?=
 =?utf-8?B?Um4xOFU4OSsreUp4MC9oZjZEMXpUdjZtMmwrMnVYeVVuWVF0VWxNOVFFWHNU?=
 =?utf-8?B?SEF6SGh3MVB3ZkZCN2UyVUgwRHhnbXVuUGVZMlkzdTdkVTJ1Zm5TSmFEeTMz?=
 =?utf-8?B?SE9RbzZaT3VLa2tjZGZnUGtFSVljTE85Vm1UM2R5S0lVcG03Qkt4dzJJZFlX?=
 =?utf-8?B?Q1RrUzFYc1cvWkM3VnE1dDYycDRhWXFvemUydVZ5VFlMU0lrUk5paWRLbVR2?=
 =?utf-8?B?ZVA2SEFIZ0xhV3FiTlE1dlBRR2VKWEphZzFFcDBRMVdZeTZvT29qWGJDTjJJ?=
 =?utf-8?B?cHg5cWpZQTZrOWhPN2lLZFovWEdTZVhvKzdBOW9pc2JMK1Vsd04xMTdZdVhZ?=
 =?utf-8?B?MkdOQ1dsZUh4WVo2WWZXN3RCMElyQUpUcWxJMkNCc0s1UmN4VFpaTnV5cHhD?=
 =?utf-8?B?UHREbWtXbnZDbHFNNVFNbXZEdnVSTU9EeVJYZ3Ezcjc5VGpmYXYyL1pnakwy?=
 =?utf-8?B?dFY2WHlaSmpmRUtianNQS3FiVjRHQ01MRzhkcStGR01RNCszK01BYzQ1YUJL?=
 =?utf-8?B?dWppODAyS0ZzRnBTQXpQR3R3UEE3K1djY093akVWMHFwRWtSNVNIaC85Nmkz?=
 =?utf-8?B?TmoxKy8vb2ZBY21jbHgwQzNkUVBHUTgvRzY5NmxnYUNmOXJLaWRkL2pwaEtG?=
 =?utf-8?B?cEpVSUl6blRPeG4xcjIvNXkzSTVDZVdwOEF5YUVRU0NydEFRVzUwaHppdEZW?=
 =?utf-8?B?OWhQNi9UM2JlZHVGRjk1RWkwdjA5MEdOeVdqNktXVkFpYTg5SmorTXRXRHpv?=
 =?utf-8?B?NEFYMWlPR3g5MHRhTm5LTkVLWXg4bm9jMUtWb2lKOVE5bjN4REVXaER3bVQ1?=
 =?utf-8?B?ODlESm1QeVFlSkJDQlJDeWo4NXZEY1FzVHZkZ21DejdrZ2htWGo1bjlEeCtS?=
 =?utf-8?B?VW9sYzJwNEp5V0c3N3U2ZTM2aDZHaUIzK3NtSFJuQmJpRk16RFcvbXBMMFVz?=
 =?utf-8?B?d1p0Wko5SVd4cFNXNlNyR2E0bnFOSWRpYkFPVEFCZytHVTZQVWFPSFNOVC9u?=
 =?utf-8?B?K3FtcWRmbWlIbjZZZGpFc3Nka3Z4dE9WaDE3anIvUGk1ZjE1Y2NsSGtEamtm?=
 =?utf-8?B?Uzh4Rm5maUt6RzBpc1AySVk3NFlCajRMWWJvVktlcWV2ZCtYeVI1TGoxYUtS?=
 =?utf-8?B?S2ZISU5uaVV3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950db7e7-ef6f-495c-e445-08da0762bd33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 15:36:29.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRuuHs+H0EFspzE8NqwA58yosUkZNIq3FhVuzEy4Du4/SzwsEfLMYRYj0sDresjr9EyWkUYkgzBQmrMJpis7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/16/2022 5:32 PM, Suwan Kim wrote:
> On Wed, Mar 16, 2022 at 10:02:13AM +0800, Jason Wang wrote:
>> On Tue, Mar 15, 2022 at 10:43 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>>> On Tue, Mar 15, 2022 at 04:59:23PM +0800, Jason Wang wrote:
>>>> On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:
>>>>
>>>>> On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
>>>>>> 在 2022/3/11 下午11:28, Suwan Kim 写道:
>>>>>>> diff --git a/include/uapi/linux/virtio_blk.h
>>>>> b/include/uapi/linux/virtio_blk.h
>>>>>>> index d888f013d9ff..3fcaf937afe1 100644
>>>>>>> --- a/include/uapi/linux/virtio_blk.h
>>>>>>> +++ b/include/uapi/linux/virtio_blk.h
>>>>>>> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>>>>>>>       * deallocation of one or more of the sectors.
>>>>>>>       */
>>>>>>>      __u8 write_zeroes_may_unmap;
>>>>>>> +   __u8 unused1;
>>>>>>> -   __u8 unused1[3];
>>>>>>> +   __virtio16 num_poll_queues;
>>>>>>>    } __attribute__((packed));
>>>>>>
>>>>>> This looks like a implementation specific (virtio-blk-pci) optimization,
>>>>> how
>>>>>> about other implementation like vhost-user-blk?
>>>>> I didn’t consider vhost-user-blk yet. But does vhost-user-blk also
>>>>> use vritio_blk_config as kernel-qemu interface?
>>>>>
>>>> Yes, but see below.
>>>>
>>>>
>>>>> Does vhost-user-blk need additional modification to support polling
>>>>> in kernel side?
>>>>>
>>>>
>>>> No, but the issue is, things like polling looks not a good candidate for
>>>> the attributes belonging to the device but the driver. So I have more
>>>> questions:
>>>>
>>>> 1) what does it really mean for hardware virtio block devices?
>>>> 2) Does driver polling help for the qemu implementation without polling?
>>>> 3) Using blk_config means we can only get the benefit from the new device
>>> 1) what does it really mean for hardware virtio block devices?
>>> 3) Using blk_config means we can only get the benefit from the new device
>>>
>>> This patch adds dedicated HW queue for polling purpose to virtio
>>> block device.
>>>
>>> So I think it can be a new hw feature. And it can be a new device
>>> that supports hw poll queue.
>> One possible issue is that the "poll" looks more like a
>> software/driver concept other than the device/hardware.
>>
>>> BTW, I have other idea about it.
>>>
>>> How about adding “num-poll-queues" property as a driver parameter
>>> like NVMe driver, not to QEMU virtio-blk-pci property?
>> It should be fine, but we need to listen to others.
> To Michael, Stefan, Max
>
> How about using driver parameter instead of virio_blk_config?

Yes. I mentioned that virtio_blk_config shouldn't change.

The spec allow creating a virtq with no interrupts.

As agreed: polling logic is orthogonal to batching logic (.queue_rqs).

>
> Regards,
> Suwan Kim
