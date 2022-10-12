Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B97AC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 23:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJLXBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 19:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJLXBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 19:01:19 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A965F3
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 16:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn0H9hyifZBahwxLw86gvXrXSuOYkxh9TfZfFzYrwmdb/misnHmtJJHJ4+PLQG/S68XWilqyyt/ReA7eoUvQlq1QfEUbNI75S6pXdw+tJnQLds/ykbj2X6D+LpxBc+MRmjClsUSt8CWnTsPcYH5LYEjOT2tKg43VvUoVgwMtpJrndzuDf3ZbMhneOPGXY5aD6InyG0OKeEZA041T4eMCp3C57VAn1U5XVGUuAk4O/2aKU+Jmv/4afXD3s+WW4V55PGT31ch92W446+Qzuhx8CG9QfR8jefKsecCvl0mBrhF25yT+bRFQUoIyG6o9GOdylRme9cw2gv6gSjqUIOuwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sEr0qAPWo9giUQSFs3329b+G1CHO3sCl47tSet1imw=;
 b=lL3zaUQNk0ojeNpWR7vC6KUSs3aMQV4VO3T+guwjiWxN7V3sWbhtal8UEU9HEB1TMnjx+mruJmM5llkODaAKoVFevW1vAqz1j/YO7xTOP2d+U8XDoy5uygcza3pQD9A+bpxyoUMz5IkMnb8wCRTh7p7LS6D0s6c/qd/tDUO2+DP/aHRIU6X2SSvkTG8xWMAVTqQpN15szdc4PgStdx0XcUBODNTi3OthlNwev1yJzew+fCd70Z/xk35KJc5Xc4TlVtqu0A5ZngVFeIwEoAx97FUo3l0rAVOVzsluldoYz0QFrkrJvIDEmXJQUvl+QMQwl6qOl+CWm+hE4b68VkMGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sEr0qAPWo9giUQSFs3329b+G1CHO3sCl47tSet1imw=;
 b=rPokgpAYJ6yvfhKVdZVJYWgZvP3dxzg7goJ0ZI2879i4U+81Nh7B7/RNm+ZuFqvBnFYJtqSj+/+pouKn3tKWaa0xE3Fi7xOv6wUm30qLavAN+oglN2FqIBNqAYa8C0Sg4rlMhTD+M+W87Y0pVwn8dC+zKO4dTQpWYZiq6LEAAQoLZ4EgQGr/xIv2bo6HmJCfq8qXm1lDb32wagmXncTXabU0j8nCrTVYJG6jGLp3zbbemYp0nRrl0YHZMkiYUrRxAfIkdKPGTa0tQtHpkxUEFaeDnpt1i+BaH5DHxi42wyGtMZIgUQQUzHiMMghhSGl9+k5wWz9k80oXsyET7/wxtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 23:01:10 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::be26:bf50:ab38:2014]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::be26:bf50:ab38:2014%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 23:01:10 +0000
Message-ID: <63b02394-d932-a385-9267-515c71bb65ee@nvidia.com>
Date:   Thu, 13 Oct 2022 02:01:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
 <20221012010143-mutt-send-email-mst@kernel.org>
 <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com>
 <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
 <CAErSpo6azrPRAAkENVzXJOTWHCi1PLa8DHJMVKKj_cun8b+K1A@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAErSpo6azrPRAAkENVzXJOTWHCi1PLa8DHJMVKKj_cun8b+K1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To BL1PR12MB5032.namprd12.prod.outlook.com
 (2603:10b6:208:30a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: c18151fe-251c-4ee8-b7ed-08daaca5a753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPBgOQT6F5owwQy06q8nVGuSezFcS6N6VOSHZ6FUZYi3MffRvn2SVxLPssM3R/B4zvtftjcY44CZW02YZYcDyS43FFuTLfHRDlN5qXrVhqL1lWoL91IUQxfan8653zNW9N0Cg39Zd4Roqzs4Q95317Jo6UTPQ6xtOrz6s17j22YXkPjgAc3KHwkxJIr87RwHXzup2oN1tisNYvX4T4kZZJJdoxBjxZJnb0gYrbIWDrEXsNpOB92zytMa53drgfC8memMlWdFtkab5TdpwnfLacF+9MCKrxeFn9weTzYR813Wmxa6HQwH3IxQaj+O0LI87cHK/38cBwr2Mi0lWqNAMVcdN3gKgMdTGzId3jue0EZvoy8cJGzOhhD9uNCxOdCrLB6bfMRaWLxq1N/ImOcqsZg0H4fITngUgKeYczM2HVuOrwWZADpyFDnDRAHiRGBF1q817IjOF2T1B064RwjsDwgWAVpVTYUbuK+WgIlvuETIyxfKykouS3dxJdg4MjcoZBzWxXqT+0ekjSLkggxFMRG+nofbZQfxM1MEFVoSopgWKODszZkeV/ssgxCLo1ZHix/12/fG1tAc92qUVoQ+EiytHSsWRxhZmK2w7dd2P043APGP8c8I2HkanIGZq/b7ykV+21ioL03KDvIKXq6anY9i7C/UgNhQ/I1nRaVxHnUjoV1G7XTCwDuvXkDctfE5CI+nwybrKvzzxEsGwm9hfDTqTvK0vYn3m7eRBbsWZnyfgP93VWu5pDVTbLx/dfseZKiJZOjgyAevW9FNE4HI8pZMbpnwbC/njOxHHDE7wiu1j4FGKxovY5RIo6ItlLzRfP0Jq2hKQfbx9odK4vTNzAgsvutniAGoV5dUKYNgpOqED1K/zArHW0CuZ5EKCy/V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5032.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(2616005)(186003)(83380400001)(8676002)(5660300002)(38100700002)(41300700001)(4326008)(6512007)(966005)(26005)(6666004)(6506007)(316002)(53546011)(6486002)(6916009)(478600001)(66476007)(66556008)(66946007)(8936002)(2906002)(31686004)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azdueWVFeUF2ODFFNzUvMENubHJwb0NyLzl4bzkwaTVjUmtDb3lhZThpWTky?=
 =?utf-8?B?b1NnOG95RERseGYzNENQSEgyak9qNkxCQ3JLNXNKVTdoalVXZVk2U0k2QkI5?=
 =?utf-8?B?ZHcxeEFtR2ovK2F2SGlpd2pWanRmcFdWQmZiWkI0ZEtVWjRKSU1qTld5N0w5?=
 =?utf-8?B?cDViM24rOTcvT3lzL2dTWURBNEZGRjFjRmxKOEZsYThONkVUZWpVY3c0REZw?=
 =?utf-8?B?VWtFSHpCaC9OUnhNZVdPaE50c0JVMnJ1cjZxZjdGYnJ3Y2JQWkRKbkdxLzF3?=
 =?utf-8?B?VExSZkZnZDIrbTNKZTZSQ1hIT1p6d2E5NUJNOTFXNW16N3ZNZFJKcW1BdkNW?=
 =?utf-8?B?aFNjR3o3QmNGa3h4V1ljeXdCRGhFVFFKeW5Zd1VXQ3hydTI2d2FYUEM4Z0Nh?=
 =?utf-8?B?Ky9RdHE4M1RjVGR2azd3MGFERmIrSktDYlVxSDBsZGtZVVF4WW00REFtaXAx?=
 =?utf-8?B?LzNnUyt4OVFEbTFoQ00wMnRHQzQ1V29kdTdVN29vamFuRWtaSU44KzFtbjRQ?=
 =?utf-8?B?aGZ4eWFpS1llcU1PNVRPVzNNQ21YelBkMERSOU5SY3JKTFNLZjk2UHVkdFo5?=
 =?utf-8?B?SlBEajJGVThHUjFvWnFodFJVbVYzU1d1dXltTThTVnV1aHQ4VEpKWVZSd1JV?=
 =?utf-8?B?N1JCanlHKzJuZ090UnQ4M3ZEUVdUR1BvSzMyUkxwNkM5R0RrSnJKY1Q3Sjh1?=
 =?utf-8?B?S00wQjVmVjZXQmdTd1Nsa05wWk1FRWhGY3p6M1NBSUh2R05TeVU5dDBsdGFn?=
 =?utf-8?B?akdwVXhpZG5rY1Njd0M4N0JNb1Aray9wb1lHVWowSjVQanlWUG5ERktBOXhi?=
 =?utf-8?B?aU9rME50SUlCaTBTa2o4SjRHTWJ2WHhXMlhINWdOMVBIRm55Z3FwNVJaYnRj?=
 =?utf-8?B?MmZUSWtQWkFaTWpZOW96WS81Vy82TkFUVURDRUpGenR0aTE3cmphNDJwV1R3?=
 =?utf-8?B?WmZoL2hadWFEcXlQT0R2by9XeGtCc3lqaDd4alZTd2VYbjZTbkZPMUNrZzBr?=
 =?utf-8?B?dkFaSVR1TTFNV1gzcmxXMEFnaURyVXp2d0pBNWlvU3Q1WEhnblh0UHdSWmJw?=
 =?utf-8?B?VmZoQ1ZOemRHN3p5bzloQ05vc0psRHdqWVAvaDVkb0RrM2w2WWVMZkNuYVpU?=
 =?utf-8?B?Y1BGNVhFbjdIbkNiNGxWenhaN1dvVUZsb2pIUmc2WmVNclRMVmVLN0dQdWxn?=
 =?utf-8?B?Y082L1lNWnVYd1JQOEJxWVl6RC9TODZjMkM0VXEwNjBOditkNDN1bFMraXRa?=
 =?utf-8?B?N3h4TE14Zm5QTTdXaSt0R1hHcWJTM3Rlako0cFRPY0V6dWI5bW52TTFTZ1d3?=
 =?utf-8?B?Z0dqRGtLOXIxamJ3OXRFcVJHUi8yMk1HdjVudlBFQnZiUzN3NWhkTG85VTdq?=
 =?utf-8?B?TEZib1JmM1RjOGVmSzJzWVFYS2lWQkQyV1Zyb0lPRFR2aVlGRzdIUjlrYmJN?=
 =?utf-8?B?Y3crNmNlczRBSTJ5VzE3cGlYdGtIcUhub2RkRk8wUnArL3JESUt6OVpoeENP?=
 =?utf-8?B?bFBMRnZwMWhRZ3FwTXBLYTJ4amdWVU1TREhFYTczNEkvNk9YdHJVNVRadXor?=
 =?utf-8?B?Y2xPaHdQd0E5S3NKQno3UDkrWEJ3aUYzNy85SGE0dG1aei9YUjhRaVorcHkz?=
 =?utf-8?B?WmM2ME43eDg4RHVybkwzWHhGNWFZbjV5UkN6UEJPMkR3YnY1MFFhNUU4bVNp?=
 =?utf-8?B?R0J6Q0l2WXJRR0s5SXVLRUgvSXpvWHRSVnBYenVOeHRyQjR3WTV1dzFWemk0?=
 =?utf-8?B?WUVoTlhOV3RRQk8xOFpqNjU0MmJuaksycWxiQ1k5SWpJL0xZME9SbmFpdm1X?=
 =?utf-8?B?c0VMMEJEb1NoSm5CV21UNEJFd0w2VENMeGtrekpadmhpd0J3RmprSGZ6S2c5?=
 =?utf-8?B?TVRDNmVtR2I1VlhoMXJJK1JGTGVDOUZSZGROSnk5eFFyUEtDK2taaldrM1Av?=
 =?utf-8?B?eFl5WXQ0L2NaWGZhR1RoVld5ejIzcllLSVhvRVV1MkFsdVFWNDZxdWFzT2xN?=
 =?utf-8?B?NzNlNW1GOEFvSUVzWXRPZzYxTUptRnZGTUc3UmlOZ1BOczJ0dHJjNkd2RFdB?=
 =?utf-8?B?dmJuc0xSaGFDSWxHbVVpYzgyRzRhNG9ZalRNcUF4UHZEL1EyU0pSLzNDaDlV?=
 =?utf-8?B?NTNNV0ZDZXM5SkgrSXJ5UTVnTVpYVE03RVhYbzlNTDBtT09oQU41YXI2UHNW?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18151fe-251c-4ee8-b7ed-08daaca5a753
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 23:01:10.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj9fR2+qCT4yGvlNjLuiNL3xquYZLx5a6EtI7pJ+t/mS6W3QGcpSbb/0YyuVu2CR5cTjrBQk0Kw5/fjGXexmAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/13/2022 12:20 AM, Bjorn Helgaas wrote:
> On Wed, Oct 12, 2022 at 5:01 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>
>> On 10/12/2022 11:42 AM, Max Gurtovoy wrote:
>>> On 10/12/2022 8:02 AM, Michael S. Tsirkin wrote:
>>>> On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
>>>>> This is instead of re-writing the same logic in virtio driver.
>>>>>
>>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> Dropped this as it caused build failures:
>>>>
>>>> https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com
>>> maybe you can re-run it with:
>>>
>>> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
>>> index 8e98d24917cc..b383326a20e2 100644
>>> --- a/drivers/virtio/Makefile
>>> +++ b/drivers/virtio/Makefile
>>> @@ -5,10 +5,11 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>>>   obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>>>   obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>>>   obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
>>> -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
>>> -virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>>>   obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
>>>   obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
>>>   obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
>>>   obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
>>>   obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
>>> +
>>> +virtio_pci-$(CONFIG_VIRTIO_PCI) := virtio_pci_modern.o
>>> virtio_pci_common.o
>>> +virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>>>
>> Now I saw that CONFIG_PCI_IOV is not set in the error log so the bellow
>> should fix it:
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 060af91bafcd..c519220e8ff8 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2228,7 +2228,10 @@ static inline int pci_sriov_set_totalvfs(struct
>> pci_dev *dev, u16 numvfs)
>>    { return 0; }
>>    static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>>    { return 0; }
>> -#define pci_sriov_configure_simple     NULL
>> +static inline int pci_sriov_configure_simple(struct pci_dev *dev, int
>> nr_virtfn)
>> +{
>> +       return -ENOSYS;
>> +}
>>    static inline resource_size_t pci_iov_resource_size(struct pci_dev
>> *dev, int resno)
>>    { return 0; }
>>    static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool
>> probe) { }
>>
>> Bjorn,
>>
>> WDYT about the above ?
>>
>> should I send it to the pci subsystem list ?
> Yes.  I don't apply things that haven't appeared on linux-pci@vger.kernel.org.

Sure.

MST,

can you confirm the above fixes the build errors before I sent the v2 ?


