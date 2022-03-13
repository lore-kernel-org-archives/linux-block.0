Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C15EC433EF
	for <linux-block@archiver.kernel.org>; Sun, 13 Mar 2022 10:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiCMKim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Mar 2022 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiCMKik (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Mar 2022 06:38:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25491F65DB
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 03:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfz3efzABf2UD8AbWXZT8sLlqrhS6OPgdfBnmOSsAaZEcTPxMdJBrLuhGu6tJ70mutT11Iu0nvFHQE0J+WYB+ItkzeTQdRA8XhwCoXRXMrVnPaQpx9wogzBo30cUBcB4kqSPEgNJxT4z5wmgtwrQlA43Prgk/U+wGVRimHSl1uFoTqiYJkkUr0tVVk+Ux/I8jXqZ/gnNHo0U7APPixKAb4Af6iGSVkSj41FylSeg25c6vUuIkJuo5vfCcD3iiX3UCX3WWSVAZztbavSQeHYOMaA6Hq9v1Re4fJF+an64dmrydRt6eRa10BnqXTG5hb7HNDP1VwISJBY8lA80AaxTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBN0spg5xQXEqq0jaBW/pUFkUdKkHr1ESbVKIZZ2Twg=;
 b=IehPDMlNzc/8bZCNZVdXHibJAIDZ0yrLpWVu8PVWI7m1twmw25FawPHLdcJLEO4E4peWQlTXCwFBVhGmKoZ2xNUsitMmq64gNvNEwN2EVIlzNVqsl4lEWEmpFMu/KSbQ8ddK/drIy4dIlfyWM/T/QLPj185etwQt2XVcyuZfWaUKKjcGGrF0digCmAwzBdzF6yijmOvhPfaZ4CZtTES7q5gEUmsX1dhexbAkkA+1qkdJG5m//JlPeUTiA9ooUauAStCKvr/vqgU99GmS2gXCG4ZzxwUGQm8UT63nsZDH7p7rsem6mV00htVhQXn0vaUYCAo+lJZwcPkvBiG155r3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBN0spg5xQXEqq0jaBW/pUFkUdKkHr1ESbVKIZZ2Twg=;
 b=JIni7mmMKjbbuNN7ec5N5hitHmhNuTQekh/FGMp00SMIKHXOutoKIStJtiMO9+6QRrOvblqBZNwCtpY3K7fz1KCkBzZLlTf621uBzDgwMXVu4SKHNg01ibBewpmHeHwBVNdwHJwAhmC0dRV671hmIoUfaE1Edm5xd+biuJidWWb5VYsO81/47PiC1mwjAvX2h6fp6fVan7vHd4pwJNDLz+ifE/JamK1otsVDUH2CFtZEXChILF4lls/+puMYwJ+6MhKvssUlSQZYb0yq0rydcnIBmqtCeKAmYBiO0RvwKi3mFgSqfOcwyv610lfa2ougFRxEvXiOBZsqFLObOinAJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Sun, 13 Mar
 2022 10:37:28 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 10:37:28 +0000
Message-ID: <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
Date:   Sun, 13 Mar 2022 12:37:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, suwan.kim027@gamil.com
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <YitzuxYHywdCRKVO@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0106.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::47) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 287eb324-65a2-4b18-5749-08da04dd7899
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB435781A8ED39049718B325D1DE0E9@MN2PR12MB4357.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkIWg+5X0xiqqPsDaBOO5MorYSWSN/41XhiAyjqM6UY26sm6nqoLUU+pioAdCLKnBh9keLftVQpj7kkTLHv7gWUj9O1JKNe8udgaveGLdEIWLavRKzHuV1eR+HU5cDnm2SvpHUlh9mlp951rw+KuUqyW3Hlmot6SXTqmiDCEYiVpOAFoyAg2V55JXmemEVLT50VEbf7S31+R1Xb/8SH+4YAkw38bwMrlWA1BZXTOrmoD8EaK5HV49EdCtDwI6O15MHdalg9op+uYVaz4gIzW+0xsesMaI5X+HsHYFctnwrmiga8TcC+QIbMVJtdedYjHlhl7ukLLmtuZED6b+q5j1mcEyx+sE4PHtn5zhFI0iKcm0gaE+gpAbD1DTnqUlcYnCIv1zsnWovwdyHJ0+OkpvwNep7JpeN6QtHxkG6IIEXn9MR6IxfuMKMh3zuP4ADf2NLbT3d6M+fnhz5C2NCTkQdAc4xuRiNXmROAYb4lZlihP3l/3ILzYmBCmeeNlxFJGlFHVnXPXK5IiBEKPA4qy7RJmtG9UKdjSKekf8hFlluSI5cFHjgliK7zz+eAnVkCNlB/fi9u1IcFdkiKzKQ1XbVW7UNFbP5XPuqrIwS51/Ammw/J2f0MAGPXMXBAv0n22CKzXxhsFO6M8JxhLFB2CW3Rx0dbWrqqmrTEevseDiy+P1kvZ8MxBQvUN7C09y19glJL+PiOZJuF3/3pL3JCNMxjV3Czz3UYw2ixRhg0RrhbHw/sZtnxyV2AMu7jlZVEN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(5660300002)(6486002)(316002)(31696002)(66556008)(186003)(4326008)(8676002)(66476007)(66946007)(26005)(53546011)(38100700002)(6512007)(6506007)(2616005)(508600001)(110136005)(2906002)(31686004)(6666004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hJQ1Z0bXhieWdlZURZTm1rUytQS05STkRHUmU1VVhhV1VhRENYRlBQT25s?=
 =?utf-8?B?RmxFa3BnYjNrV1B1cnEzcXBOejRLUzBPVkZpM05mbE1FYzYyVUl3aUppY3dq?=
 =?utf-8?B?bnpiUkdxaVVnOVYyODBVdjBVbVZVUFdFb1dRRWVmblJSdUphYUp3Mjd3U0gz?=
 =?utf-8?B?WDUraER0dHVMZ1lNVlhKYmJEK3FTUFNSUlJMcmFoQnUwb2doUDcvazc5cytQ?=
 =?utf-8?B?YTAvZVk1NjltckZFMUg2SDhYOWkyaVEzU3YyN0NGR2tQL2tNeGo3dXRiK0tq?=
 =?utf-8?B?RmN3Wmp4aHpPZG9wYWMyZnVyRUQ3aWtxN3h2LzZjWnFsRjUyczBiRmZtU0JD?=
 =?utf-8?B?NTlzNjEzUUtGRFNnaE5SR1RtYzdLL21IcFBlakF1TlVjQ3lPWHpMWTlhTldD?=
 =?utf-8?B?M2VGelorRmM4Qmd4N214RHJPTWNhalo0TkhwT2hTRWRSeUhIZ2dSN3B6cHJt?=
 =?utf-8?B?QkcrS0NzbWVuMXppTDlPZXE1dEpmZGVrSFg5WGV1S2VodzB4aDRHQjdFWHBT?=
 =?utf-8?B?a0tpWVVCOFN6WGRkTFRUcUdjeU45ejA0aVREMWlTOFBNdDZrQXo2d1F4c3FI?=
 =?utf-8?B?d2syMWZCRzJHZndsY0l5eWxQMXB5b213YS94aE85MFVlek4wZWluRjBwNlVS?=
 =?utf-8?B?dHMvVTRPUCs4aHdXbVJyTlY4YkNsTFJRakpDa0xFK1gwc3JVS2dLY3dOeFdQ?=
 =?utf-8?B?RVhLMzF5N2E0eU1VLzAzZFBPaC9WcmRyelhpZWJUQkVHVGdZbzlTaVRWanNp?=
 =?utf-8?B?U3ZkTG90dnRzbUptZk5JTm9Oc1hlMUQ0ZGZMbktOaXNweXYzUmZvd1pYdVJY?=
 =?utf-8?B?VHVsQlhxNy9hUEJPQU1xdFJoRG0rVmNTeUxubmN0RnlOb25KQVlHNjEzcEF3?=
 =?utf-8?B?N1hzazZycmQzTXVQSmQyZENIdmM3T1A4YzZSSzNSbFkvQ1JDZ1l5VGtxSU4x?=
 =?utf-8?B?SG9lME4ydTE4dzdYMmE3U3NLdWdqZzl4RHFXOE10ZE5vc1B5SEZtWWxLT2pz?=
 =?utf-8?B?YmU1NmpPbjBWQTJ6bURkWTVZU1Yyc0U2eGtFdTlCb0loVm92L3hDYS9uLytV?=
 =?utf-8?B?dFVveVdyMnFGRWNYSjRYN3BWTUR5cDU5dFhjSDdGck5HUDV2cVlxR3haMHVk?=
 =?utf-8?B?Y2lqM2w0Y2NVaG5aSXhWUFlCQ1MyaS9mU3NyY2hxRXZzQ1g1cGNoc0pBR3RU?=
 =?utf-8?B?Q0ZVQVFIZG5XSWVZa25jWUdqT0pSUW9nTkhoWGl3Z2Z4clZGejU5REtYY0ty?=
 =?utf-8?B?WkNxZ1pRYmtMRHhBT1Y5NWtCaE9LWjk2anZOSStTQThDMnhGdlBwWnFlbG11?=
 =?utf-8?B?L1czQVF4RWZyOTFNemNVTXZteWd6em1ySGphTkFQdEwzMjBhQkIyYzJ6YU56?=
 =?utf-8?B?RTVodGpSbFN5YVpCWkM5WkRia1pzTjdZeDJCbXVpZ3dYTVlFaDZzVGhpb0Uy?=
 =?utf-8?B?dXl5TCtiOEtJQ1dYNGZDN25FLzNHUFE5M3ZST05xOHRDS0pPYXhMQS9xUWl5?=
 =?utf-8?B?eE5xZTNMeUFsK0k3Ti9ESm9jblVTbG03YXljM2lHa1ZHOXlNY0k5TG5uVXNn?=
 =?utf-8?B?VmlJQ3BpWDRSRXVXZ3Yvc0lqdS8yRStFdy9Ic0xOZUl6L2pxQno4MnNJZmk4?=
 =?utf-8?B?bHVqR21pZmQvOW5qeUE1U0pMd1dZRTZJcHhyb0ZSVWhvM0JOc2dyU3dlRFEz?=
 =?utf-8?B?U1E1ZEM5WUpRNitEb1YvNWx4cTk5QTdjbUpKaFNJdDVzemwyQ1lZK09Demdy?=
 =?utf-8?B?MTZYa1ptRzV5YjdMQnpLVkE5SE5SV29IZnMzOGFGUlRQWVBpUjh0ZG9sUjBU?=
 =?utf-8?B?ejN3dEVtUk1nbm1yMklLSWNERktKbWl5ZjdvTlNlTk5uNDVhRU1Xd3pWRVMz?=
 =?utf-8?B?eCtsYlN1c09IWDBFUXNJbndFYi9jNDJSMU1qZ3pON0JINlduSFNmOUZmSG81?=
 =?utf-8?B?bzZEcjJEckEzK0Q0UlBOcTUweFFqZjR0RUlDT1JPcGJQTkZHMjQydHFuZEZF?=
 =?utf-8?B?bU1YcHJhdG1RPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287eb324-65a2-4b18-5749-08da04dd7899
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 10:37:28.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTqsv680omz4hvohmBcItwHnZ2m8g5bWxv5Kfw6vlaGmq9uLj54wxuWd6LeSgTX/Ktm6lO25bBfGu2kXk7TKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/11/2022 6:07 PM, Suwan Kim wrote:
> On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
>> On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
>>> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
>>> index d888f013d9ff..3fcaf937afe1 100644
>>> --- a/include/uapi/linux/virtio_blk.h
>>> +++ b/include/uapi/linux/virtio_blk.h
>>> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>>>   	 * deallocation of one or more of the sectors.
>>>   	 */
>>>   	__u8 write_zeroes_may_unmap;
>>> +	__u8 unused1;
>>>   
>>> -	__u8 unused1[3];
>>> +	__virtio16 num_poll_queues;
>>>   } __attribute__((packed));
>> Same as any virtio UAPI change, this has to go through the virtio TC.
>> In particular I don't think gating a new config field on
>> an existing feature flag is a good idea.
> Did you mean that the polling should be based on a new feature like
> "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
> and features[]? If then, I will add the new feture flag and resend it.

Isn't there a way in the SPEC today to create a queue without interrupt 
vector ?


>
> Regards,
> Suwan Kim
