Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331D1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 10:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiCNK01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCNK01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 06:26:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56813ED33
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 03:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCNkl7s3U3YnDRgKs+HNg6ayc6vheRj91ehLtPnh2hoeFsuELri+WzmP008NIGvQjAh8zFc5DB4BX+wVf5eneqnXri/OEl6JMt09MfJeqvo0QbmkVvWqCzShuJvbyKTuxRdno72rjT8QiY7936r0T8O/8+1A0JWhaegpRlCTRh9hV3JPaH9YwRXJuthDr/DzrbWbMPXjO4zUjaxeBQhQgG+F20TpnPa1RbPMfHovJhgPkcBeT1ert1tbnZ8nhlkOYh4e8mHQvzQ/RPGHf0iR/e28f0nckb2HYeKsFgc0pR8h0xUR/+830sUIgq+ZMZW0/G2RUBhkZTw80gHW+KDC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E745PuhQ02VcGhZWSJKavhlEMvNIbvXnqf6UsRhKqyw=;
 b=bIKejEY+nP4TQbdmKrbpPsI0NnbAtqDaAVijBJlg44YCsudrzBgg4aLoP6EgKT8OL4vTQqx0Fi5kQ4BpBiMuuzVunbl222Pz7Tdiv267OUdzxLZCjUf9G9xCGcnLxnmiJ1IUwwv6u/WMK/KmZgYjpBoLkfGj4QUuKU9eqvyCNSSTNn7ehSN+lhMKLZIzJJfmG4oxstQ9bc4CScRaelFulT/ITEcn2NJNSL2Tej2QUoBXKy7eqIk84OQu44k2rd9dG4Q7WaHOvKvCMYzJVQrXM0GZYNu8rnSPV/VbUOKPIIBoFhMoKS2vqE0SjvJTr0Jb6p7HMT+JgGGxBEZcb0qi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E745PuhQ02VcGhZWSJKavhlEMvNIbvXnqf6UsRhKqyw=;
 b=gBe5+DaLvyKoXZ1xrvLhnw2M1zdtL8eLLVvpXP4gW1Y/b+Ka8QaWa3HZEQmax12jGSgeqr2dSJvR5EcX2CDTDWKtKJoddhszKlxo9W2RC6PDWmXjEp+2y+i+3ZevrflVnLgwJEmbZq2R1bUVI8OASiSryBlfoqdvhyR7Ti338/cndHnsl04TCfx66jLuFmd++Jqfw0RrY11HcxWb0nv1K1qh/9MoABeSI8iZnXS3bpGrOhLi4hj1ggLYkxNY6Eb/Pe42cimUCUGRo4tWOwrhh3FxKAj5TpQelXaGUzdzBRftqrTtAGD5eTl8oNENIo3j5fubWJfil55S2+71Xi3r3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM5PR1201MB0236.namprd12.prod.outlook.com (2603:10b6:4:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 10:25:16 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 10:25:16 +0000
Message-ID: <e441429b-90ef-a2e4-1365-3f55c7ff21d0@nvidia.com>
Date:   Mon, 14 Mar 2022 12:25:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <20220311103549-mutt-send-email-mst@kernel.org>
 <YitzuxYHywdCRKVO@localhost.localdomain>
 <c91ad1e9-8c5b-ff1e-7e7f-8590ea6c67e8@nvidia.com>
 <Yi8OSE2hYoS8rSEo@localhost.localdomain>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <Yi8OSE2hYoS8rSEo@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deee27c1-65f3-4c2c-4a21-08da05a4ee97
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0236:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02368BD061115158BE293674DE0F9@DM5PR1201MB0236.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVJwsxRdchtONVU8X7haaqb+QpF8VwOLejbyldT6F+GT0TalqbhEnjTfOf41WpUXSKt0iWH2vL6BPpRBKdkgH91JD19grzQ8vWv27J0/+mV93whlARRKGhsEM3U9/W8PifAvklD7Y1CG+dpUC0gKKADoCTuzhzCsrLtL8w6tyGdAQUt+n0jcD894OsZgq4zqs7GweD6Jz2EEFDHiBjkdoeOnwW+w4YMqbHADrxyxx1CztrxpBBcZ0JAWC44wGApz7+WhYKnqZLuMBhDDRP55d5LFdD8Sb0OP+tp30rdW/zmTfU3RN2ivIY5acBWv2E+p4hZs74X4Bw4HZseIDsmf9NXtLmCq5lwDvOBW6MQXTVkJN2ZvsWvMtAmfIe9Dj8t/LJPB1Gfusg/KZcKUPqNRlQcXTubVStb5j8uuDHxhPDSqhJMq8L5nliNqUU4kn4WsTl0n2X4agiNeOyUG1R9NaWoh2DXOFqb28WlEn6AzUsUt1kJTZ03KBX39DAmGvIXQQGtOycY3BgS1klc3PnSHkrJ/5MudgqhBAT59rkBPLCTpGIIJmUs1b7f52G9aI7WA4jyfr27Ubz+E4LGk1FZCN57WGc7cxpg1B6wKSoUwQTbK6Y0Qn42aWfjYXTs1LCN3Ii99p7OdXW57tFVR6Q7DooIcEyFauTS1KGmec+2en6zdStj/IcOM5kkOTY6RGrdPpnRY/f+yuaHYenErrcegvk3wleeKZQ+JM+ApwdfDBT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(66476007)(6512007)(4326008)(38100700002)(6506007)(8676002)(66946007)(6666004)(2616005)(66556008)(2906002)(186003)(26005)(83380400001)(316002)(110136005)(6486002)(36756003)(86362001)(8936002)(5660300002)(31696002)(31686004)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkgwTmYrZ2RkdWo2czNreENndGZLWjV5UmlwQTl2WXdZeW8raXVCR1hmaHBH?=
 =?utf-8?B?OEcyaVk2Mm1HYkdDT3QzUWZqSFNFclRFOWFPb1diZTRXT0QvbHhIQVFjWjZ4?=
 =?utf-8?B?Q0dBNXo4ekdINWlnOUN4TUhGRUI1OXRQSUZ5cjNYNVEyeTRaNnNrWnZNTG5r?=
 =?utf-8?B?WWtpRmd1cmtGMzlReWFlSzBYREpTK29xY25CaEpudldWZFRJMFhGZm50cGdB?=
 =?utf-8?B?N2ZaY2VVQ3V2cjQvWlFiL0tlWVhGbXNuem1SYWpJQW92YndHd0dUMjVERXYv?=
 =?utf-8?B?MVlFMVJyVlZoNitvMkkwWmFSTjBuMFgvQmJiWEJrTDFlb2tPL0NHbklJOUQw?=
 =?utf-8?B?RGtJYmhHWDBkL1FsOGN4VzNFMWoxUXE0SmJJT2RsTkdCRXdzV2ZiMHhTdWtG?=
 =?utf-8?B?TktIWGQ4eU9GaHovQUQxUVY0clhuVUxLWm84NUxRcFpoNFJQaTRGMlh6UkdG?=
 =?utf-8?B?cTI0d1VXSldBQkVZWEtvYTI0YTRWenJmakJLNHI2azRDREtEakI4aTBFUjU1?=
 =?utf-8?B?dlFaaGlRamg1VHRkVXdBazJ3NzVXRkxWZXZRUDNKcWFWdnYvaDFNZzVHMlI5?=
 =?utf-8?B?c0dlVDllVFhBeW1XRnVGZFJwUWowNlVFV1d1WktpT1dUTmZJTU9DVG5vOGF1?=
 =?utf-8?B?Q0p2ODVtRm1zSEpXUkxqVnJxcHl1aThyQU15Q296NGp2TThaRnB5eGw2MlZi?=
 =?utf-8?B?UWZzMGRCS3M2S2h5ci96d3JMOHNNV0FEU2xpa1ZVaEwwWjgrV3FOTmIzbWll?=
 =?utf-8?B?c1F5bXhNeVFzdkh4L25jdW4xYzhaTkZTUXRXOUtuMjlITWtTSko0enNSV1pi?=
 =?utf-8?B?UWt1dGI5MEg2WEZLM3kveHVKeW1SMWJRQ3p0elRJUS9wcWozY3pvYlJyS0tw?=
 =?utf-8?B?VVJsblRrVWM1VVRFY1Y0TnZ6R1U1VDlheUhTT1JqM2FxVm9FMXVvZGtFODZO?=
 =?utf-8?B?eXllS3ZQTmhYTUlURVE5QVNYMW1zNDVaL0tMY3AvV2FmbE1HMnpiV1k4WFlP?=
 =?utf-8?B?dkp2K1dPTkFqeFRMSndyeHBSOWVYV2dEZlZVaHdscG1hWUdDWUk4Q1h2eDdQ?=
 =?utf-8?B?QUNqQWZOZ3F2dWdYMms4SlhvdnF6M0VuTmFCbHUzTTFQanJjUDFGektEcmtt?=
 =?utf-8?B?aDJ6ZUlpWlErYkVpOUFCL2hCQVBvd09uVVJ2YzhEclNjYmozc2pyKzdzRHov?=
 =?utf-8?B?aGdRSnpVcXkwblVqazkwOXNDdUc5SndhVCtjaDh1TnBINC94ZVdTZ1NFa00w?=
 =?utf-8?B?Znh1NXdoS0MrWW5MZGRoYmtMMVZTUjRlSTdmMlFvUndNajFiN09PV3FXTEVj?=
 =?utf-8?B?ZU1BTlN2UXF5bmV1U21wdVlNNUc3bXFKVHJ2Sm10V2xVU1FKL1ZpL0FsWVNq?=
 =?utf-8?B?eXdZNklTQldGYzFOaDNiYU96RzVnOXBSM2N1VzVGZDVoeC80dWxWdi8vcUZV?=
 =?utf-8?B?YklqdVp5UG14L1pxT3IvTzFsQWtWKy83bFlsZGQ5dVE2ZVIwc3pYVVZCNTBH?=
 =?utf-8?B?ZWVFRUV0ZmpHL3YyVDR6YTVocUU1Y0lsMlEyak9lSHJWQ0t6UVNyMkdrSXB5?=
 =?utf-8?B?dkw1d0wxWmFGeFZYUkMyWUNzSnB1ZHpLM1hzOWpIYWFqUkxTVzZoZ1pCajFj?=
 =?utf-8?B?ZWZnSXVqNmFwNStBckRuK3pvVjJiM3UvYy9Hb0FSYm9YSzNVZXErSWhrSTBD?=
 =?utf-8?B?ckNFWmJPMCtUVkFaM21zQVZGbmFVaCtFbGJyaURsWmpSenNIS290cUxHRTR1?=
 =?utf-8?B?RVl1YnRSNVlkNnVjb0U1VHZ4d1h3Ly9FaitIdjJGVWEraEN0bExkU093MEsr?=
 =?utf-8?B?cW4rWWprVjVkMlNsL0NYZmVyMzRyTU15UFR2d0RKRjA0MkhqT2p2ckpKZmk0?=
 =?utf-8?B?UmxGcmJPNERyeXBuaWN0RVR1TVpMSVoxb1U0azRMVVQ3T3JUazNnWnhSTjBS?=
 =?utf-8?B?NklndWMwd1FUNm1obVF2Yi9TN2RqZ3cxYzVuVkI1cDRuM2tHVkxKcHN2UHRG?=
 =?utf-8?B?UUs0UTc1cWl3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deee27c1-65f3-4c2c-4a21-08da05a4ee97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 10:25:16.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRArBRptOl66mZZLeQZf9t2ZNfX9p4HPEVqXayH96vzNfIG0gw8soq8owjdc+AQ0WFFH8jxn4WMIS2h9yk8vdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/14/2022 11:43 AM, Suwan Kim wrote:
> On Sun, Mar 13, 2022 at 12:37:21PM +0200, Max Gurtovoy wrote:
>> On 3/11/2022 6:07 PM, Suwan Kim wrote:
>>> On Fri, Mar 11, 2022 at 10:38:07AM -0500, Michael S. Tsirkin wrote:
>>>> On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
>>>>> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
>>>>> index d888f013d9ff..3fcaf937afe1 100644
>>>>> --- a/include/uapi/linux/virtio_blk.h
>>>>> +++ b/include/uapi/linux/virtio_blk.h
>>>>> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>>>>>    	 * deallocation of one or more of the sectors.
>>>>>    	 */
>>>>>    	__u8 write_zeroes_may_unmap;
>>>>> +	__u8 unused1;
>>>>> -	__u8 unused1[3];
>>>>> +	__virtio16 num_poll_queues;
>>>>>    } __attribute__((packed));
>>>> Same as any virtio UAPI change, this has to go through the virtio TC.
>>>> In particular I don't think gating a new config field on
>>>> an existing feature flag is a good idea.
>>> Did you mean that the polling should be based on a new feature like
>>> "VIRTIO_BLK_F_POLL" and be added at the end of features_legacy[]
>>> and features[]? If then, I will add the new feture flag and resend it.
>> Isn't there a way in the SPEC today to create a queue without interrupt
>> vector ?
> It seems that it is not possible to create a queue without interrupt
> vector. If it is possible, we can expect more polling improvement.

MST/Jason/Stefan,

can you confirm that please ?

what does VIRTQ_AVAIL_F_NO_INTERRUPT supposed to do ?


> Regards,
> Suwan Kim
