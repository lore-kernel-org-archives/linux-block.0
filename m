Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C48EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 16:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiCNQe3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCNQe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 12:34:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B462EB
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 09:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B01HfEbCCDPRPhwD2mIlaSW5yeNQ5qspUj9n89KSuyWHVQHUJ37A4gug2BPJ+d4PlrL5Qzjco/anVrowm5tiDY/EWLUwg6swrikc3QU4nOrn4pbkEoIHzPUPULYpvpe97xxh8K3mJ5RuXaAk55fRWRfgX1/PWFBYnWKS405ckhe6FV6N9cfn1TLCNMK9KBrAzlsaX2AKCgDgAcg5QWQcM3rptb4ITDtgBkVP7Rbxqs/eLa5bwulg0FFBsYjPkZALUMNzYBVW2x5apiUboU919Me3VgXCA6RMzSV5ohxTBG52Y1+E2+uP+1jEcSwlULj/1PCE/BHav3Sqbcm1IFZ/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0YEizlfw8xj3cO0Zqj75NTL/gg9mp0Ztkwm4mxcbjc=;
 b=SlhrQgrAqE9Wdqjf/2dObb389eQaUuKEhmJsBm3Wr8b5IFMj9dLZp/kvYHjSwZlYnUuxXzjkfcwNKT6A60Yf84aXiNRYS/QQCLjcO+GfYN0nxv7YyCG+qMfRFfR7aajDovZKSPYEqS+cU/s3vG7leeYF4WUp4jyxQ1ma5ahuztgVbN1auVDj9WIVp9SoJMcppNp5nH057KNHfsnmyjIL4pQvdDq6JuSOXz1rbgdKymaxmbvqUGWOfS5Sy0yQ+gOYrUdI0MN9OclVYcG5jboowMe6I9ScEiZ1qQACQdagKkKCFKzU67BZ/BI9IQga9ap79s8ZFrpT8n0Ww/KAFGcYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0YEizlfw8xj3cO0Zqj75NTL/gg9mp0Ztkwm4mxcbjc=;
 b=J4gi8JLipAGlUZtxZhqTdFiuIXZ0YIQlvQVAwvXzNZq5XCVwXdJju909E/Ahrq1LBgxLalzz9sj/B88myfmb1YZV9qjJ8qIP1ZrShwTm9lxDDSa+2P3I6fkT/meJTMyO8iKej0tl2Rl5dbMvF9S+zgEd0GwATq5zSq+N2nQK4gZVP4NOsG/Y0hTCOO94nJAJnGJFkEg3TaI5KTkPTp3TrYvM8JB9Oi3gDFs/43veKCREt0cJRHMInCRrYL0AnKmhn58maOazUwC5BOBYkvh8lM+Zx+vNFSX8/+DWMjC7YDbhyxbcOdf+YD3nPAyF35KZUGLqlbhIGSIJKu6vlsreOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MWHPR1201MB2559.namprd12.prod.outlook.com (2603:10b6:300:e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 16:33:13 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 16:33:13 +0000
Message-ID: <332c35ec-734b-d2bd-dd0f-c577b1c6174b@nvidia.com>
Date:   Mon, 14 Mar 2022 18:33:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Suwan Kim <suwan.kim027@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
 <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
 <20220314071222-mutt-send-email-mst@kernel.org>
 <d9121e3c-abe5-fe4d-8088-8339c418c7a8@nvidia.com>
 <20220314111306-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220314111306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::42) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea95ec18-ea4f-4426-e52e-08da05d85547
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2559:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB255992F59C0628525B9C38AADE0F9@MWHPR1201MB2559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njP4oOZGH1vVZgofRRBYaaHuIxdbaQLa+glHj75HPkveDJpCl+MbsdKHDRofFQHEP3/P+PfxC0d0a7XYjXA6qcpcaq0aB3S6g/d1C3waxMl1QcH2ktPAvRIdZ1NxMH7hBXTXxbd5KDA9kFCGMHcdhUEzmUIvJjVJoqnUgycZ+BcoiQqBYxO9EjmXSiLhn+ilD5DoosfDd01qntsdqqsINHxJfkdN6rj1US17nZ/j9U4i5rJTYbvoyVhTIePwnlT4knMLw/tFAEL7Um/JCRkAz4tEVv/37gAWkf6I6Bof4jCfnE+wTWeQugDt3ROdXE71n1ZceYa2zSAHE64Zpz9QbEtDRNXX+TkOkCXKMC7BpBc6tU3T0wOhcCif3IfYDPByTeNvRGkNPXxsEAqvl+5UuDrv/LMj3EBxJIgdym1ETgpu/tPb0qToxUUJlgWqYFY7Qsb3ddnFoQxgyCKhBrEWr/3d/SubbJ21abXgBBhap/JO7O+k16jaGWFJY/ZPA+jI5Lji/hVEeqFHm2KUg5vce8nJYsJrcmEms/JJ2iA+NjbRaWDfRAsgIQQ9jlICI49x1aNQA00+sL2Ob1I8ow0xODECwwFIx4auqvI7yBnk1EQBLGiyENDWcbyVX4j/68dzFIDVwpqunkJPdV1DcMZh447ZJHqODN85muSgLRlfZCw7UhBzW3y4h6FoR1ZACZysXw2dHolvq4tGS8knTj3AntjyBiJ8f1Pc4izuwF12UsfN8HvxLomoVw6j5K0KU3Bl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2616005)(316002)(508600001)(4326008)(8676002)(66946007)(66556008)(66476007)(6486002)(26005)(31686004)(53546011)(6506007)(83380400001)(36756003)(186003)(2906002)(6512007)(5660300002)(54906003)(6916009)(31696002)(8936002)(86362001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDN0SFBXM05ndzlBQ054OVhIL0ZpS2VrRnVua2g1Z3hmanRiYlRaeHYwMHIx?=
 =?utf-8?B?S2lSUzhaNm9uQ1VQT1BYS1hrL3lQWmZHUW5xUnBzeVF1OU93ODQ3cENsMXBN?=
 =?utf-8?B?Z3pLV09jdXJTQTNZeExVOGNHRUlJZTdJUGpXejdya0dEejBRQTFnRkFDWElu?=
 =?utf-8?B?M0VqWW1penVpektoTkRFR285Wkh6eVVuSWE5eDJnT0tDSDFGczVscktoa0g3?=
 =?utf-8?B?WXQxVlNuUWkwWmdSR0thMi9GVFgyUEloVmorajU4eTcxVURzV1ZSTWk3ODVQ?=
 =?utf-8?B?dndtNUF3RDhtZmZmQXZiR1JRNTNVb0J5bERWTEVFMElpR2l6NTNXYWNRR1dZ?=
 =?utf-8?B?VzZYVWttMjhLRGJLMXNpdE42QVJLcVJDYnVCTVA4ekMvZndDb0RwNk9NOXp2?=
 =?utf-8?B?Z0JaT2ZYamdJcnR4UjdKL3F6bFVJaWFtOWkrT1MrV0ZzZ21nSVZpdjV6cWZw?=
 =?utf-8?B?My8zQnEzSWNlejJ2TFdVQytnY1JucXlwR1M0ZThaK1NPei8zOVpLSWhsVDM4?=
 =?utf-8?B?Y3o2a0p0WGx6K29kS2Zua3l0dzVPSzAva2YzTWJTaVh4ZVZRMWZack5jczNW?=
 =?utf-8?B?N2lqNVVFanlkcWlXQjU5dE1ETFpVRXVVY1FKTkpiTmttc0tMekdYRy93UG0z?=
 =?utf-8?B?NTR1em44SGt6REI0MHlxeTdFZ2JQWUE4bVA3RGNWYy9qOG5xZDNXZXlMbUc5?=
 =?utf-8?B?a21ZZVhoeDBBSkduRWRGZytOakQvdW5xODY0MXFqR3UvR1JCRWhjcis4RDZr?=
 =?utf-8?B?VzhOaHlIZGhHOTBia1ZYWSszblh5Mm1GSnEwOUhSUWFOV1BqbUVMbjdEUmpi?=
 =?utf-8?B?cTB2cTdzdkdySHNGbmJUMnNnek9CV2VHTjEyd1RTUmRVRnNkMnJXaUlZOEhv?=
 =?utf-8?B?UEVIc25EaHYyUFlvT1F6a3QxZXFSMGc2cjVJT3ZNU2NDTGJOK2xobWxybW5F?=
 =?utf-8?B?SWlLRzNINFUxOEczVFNBdHhFay8rTjhzd2JjdjN5aGNlVDFFTlFNSVNTdkVz?=
 =?utf-8?B?K3Zna3NJdlZPUS9CdU9pcGN2eGZveDR5L0FiNkNkZXZXMWhzOTA5d21ocTFo?=
 =?utf-8?B?L3c4RWhHUjgraUNsclZxQkk2dUFDTmZoejQ3d1F6eUU0Zm5KS1hwTHJ6SGJI?=
 =?utf-8?B?S0ZYVjlkUjVZSElsdmFVbGdjbVdrTVJXNC9NdTZOR2pHZ2hobXZLN1l6QWhD?=
 =?utf-8?B?NWt0bUM4QkRtY0FFemlWQ0pyellmNTZJbVZpOTdpTURyY2hmYjRob1JHSjky?=
 =?utf-8?B?VUU2aEtvUTdWRlBCd0h6K0lmK0czL1hvdGZsWG5TMXkwMUZVN3hnTjIvZ3dV?=
 =?utf-8?B?VFRTSjhBZWxmTnp2ZkRPeVZMZU9MdkxubUtCRGp2anlsUWo2Q05OQTZVSjhl?=
 =?utf-8?B?TURWR2Zna1ZqZ000NG92ZGgzcXlxQnhlVUU0NGlKczh5RlFza1NGNzhFb0tS?=
 =?utf-8?B?ZzJ4QU1mU2JpNi93U0pFRHJsTHd2djVNRDZOWGp1NWR0VnIyRlVvSjdBUmR5?=
 =?utf-8?B?cUlDOGpERDJ3ZmVsbDdCWGZTQXhDVVJXdDBvMGFhbmo2QmRZYVc5NTZzOEZz?=
 =?utf-8?B?YTZhUm5FZERMa0hDaks1aC9PcUZYTGZtYmVCSmh2NlRLQlNzZWRudkovcE10?=
 =?utf-8?B?YjBQOEZibFdVOEVwWFNycXhNUEd3VHdxTSs1Nmt2V1VSTUZoUFV5N1RlcWh0?=
 =?utf-8?B?NFBDUzVJTGJjMWkrUGNNdnlObnhySVVzUTNjQ2NYZ1RaVkF3UHprSGF0dVZl?=
 =?utf-8?B?cTNDTmJqa3BxbnZFLzd6a2V1VisrTTdTakZvejBua0l3VDZob2ZBVmhKU2FI?=
 =?utf-8?B?dDhoRHV3ZnhMb1hnbWNCZHpiL2xMQm85RnJBNjNOYU1mSDk3MnBEWnlwTGl5?=
 =?utf-8?B?S1ZuTldIenByUEdYUjdWSFIxSy9KRHAvdkVpTGFiR3VpZTNoaEE0N3lIZ3pY?=
 =?utf-8?B?cDRvNHJUUG5GWEZiTmE0SmxNcXR5L0IyZmpQVU9NR2tKcnRNUXBmNGliZkFn?=
 =?utf-8?B?amd0d29qTXNBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea95ec18-ea4f-4426-e52e-08da05d85547
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 16:33:13.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZjXvESoVCVOB0RNzggSqSTkMgkStYRmIIAYR1ajTJ0ROo3pPK+h7HaxjcNcyZf9ELoq0kz+hd/ehMjjTXsrqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2559
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/14/2022 5:15 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 14, 2022 at 03:26:13PM +0200, Max Gurtovoy wrote:
>> On 3/14/2022 1:15 PM, Michael S. Tsirkin wrote:
>>> On Mon, Mar 14, 2022 at 12:25:08PM +0200, Max Gurtovoy wrote:
>>>> On 3/14/2022 11:43 AM, Suwan Kim wrote:
>>>>> On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
>>>>>> On 3/11/2022 6:07 PM, Suwan Kim wrote:
>>>>>>> On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
>>>>>>>> On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
>>>>>>>>> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
>>>>>>>>> index d888f013d9ff..3fcaf937afe1 100644
>>>>>>>>> --- a/include/uapi/linux/virtio_blk.h
>>>>>>>>> +++ b/include/uapi/linux/virtio_blk.h
>>>>>>>>> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>>>>>>>>>      	 * deallocation of one or more of the sectors.
>>>>>>>>>      	 */
>>>>>>>>>      	__u8 write_zeroes_may_unmap;
>>>>>>>>> +	__u8 unused1;
>>>>>>>>> -	__u8 unused1[3];
>>>>>>>>> +	__virtio16 num_poll_queues;
>>>>>>>>>      } __attribute__((packed));
>>>>>>>> Same as any virtio UAPI change, this has to go through the virtio TC.
>>>>>>>> In particular I don't think gating a new config field on
>>>>>>>> an existing feature flag is a good idea.
>>>>>>> Did you mean that the polling should be based on a new feature like
>>>>>>> "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
>>>>>>> and features[]? If then, I will add the new feture flag and resend it.
>>>>>> Isn't there a way in the SPEC today to create a queue without interrupt
>>>>>> vector ?
>>>>> It seems that it is not possible to create a queue without interrupt
>>>>> vector. If it is possible, we can expect more polling improvement.
>>> Yes, it's possible:
>>>
>>> Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
>>> \field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
>>> by the configuration change/selected queue events respectively to
>>> the corresponding MSI-X vector. To disable interrupts for an
>>> event type, the driver unmaps this event by writing a special NO_VECTOR
>>> value:
>>>
>>> \begin{lstlisting}
>>> /* Vector value used to disable MSI for queue */
>>> #define VIRTIO_MSI_NO_VECTOR            0xffff
>>> \end{lstlisting}
>>>
>>>
>>>
>>>> MST/Jason/Stefan,
>>>>
>>>> can you confirm that please ?
>>>>
>>>> what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?
>>> This is a hint to the device not to send interrupts.
>> Why do you need a hint if the driver implicitly wrote 0xffff to disable MSI
>> for a virtqueue ?
>
> VIRTIO_MSI_NO_VECTOR is an expensive write into config space, followed
> by an even more expensive read. Reliable and appropriate if you turn
> events on/off very rarely.
>
> VIRTQ_AVAIL_F_NO_INTERRUPT is an in-memory write so it's much cheaper,
> but it's less reliable. Appropriate if you need to turn events on/off a
> lot.

An "expensive" operation in the ctrl path during vq creation is fine IMO.

I see that nobody even used VIRTQ_AVAIL_F_NO_INTERRUPT in-memory write 
in Linux.

>
>
>>>>> Regards,
>>>>> Suwan Kim
