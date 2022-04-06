Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB489C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 16:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbiDFQs1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiDFQru (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 12:47:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5112359F9
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 07:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi4d5ZD17eA1/A7q/Pcrfx0bqEq+B7Gk31W/fF8ilZmrzYYOPj7Zwnwqd6BNTCY/EIsxZT/DaOdAC2K8qfwGBsfi2q/FDybJz0LrA+F5hBz7FQupGWnI7Kbkfln5RvlpFzQlt3apn3u7gYedV33w4Jp0uBLxJgMjawB3X1tgr+XP5eROygqykWTeJK9u7JVDEchmovFhoZQZNcXfJgi2vJckML2aKzAh1ADDqNsS04ktDsh7E2u3mpqgyDaTTU1VWLsMC9Pk1YS2tqTV/PGnW5JCzvkz33ldvcAdPPZtjlH+vd2fx4EBLkgW8LG1g5zL6V07q6qIdzywc37BhVv9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzHOTZ748udHTVSMRj69Y2Kw9nBu3U2rjtICUabj/FU=;
 b=B0RmFK73NbhCeZQraTx6moMI3CPfu5VU8PzYJ6Jjc+XnroZv/YXySKWkETDppXh3uGfYbqYrvzu0ta7lf43Nei612Vnxac5e252RbckUBKw/MoZwCANrOhz8tvbGysXIW9WgbarqMldXYtxOsA4jK3W1P8FtE9w1+3wvW4MvyFkSLzMYw5GBRPTlAz3lXxbiNiFXUWzQ0BV65OAPQS4bTLdsBtRHJaoGWIWjajHYybJOE7kQ5Vr2hDmqkAh3NsBxJ1bvONTpxGhwoQmaok7S61B3hUllHdQxdJ9ZXcWOzRFr8koBJHTY8M+nrR02ulgGxsiYecG+SEQtFEC2zaRwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzHOTZ748udHTVSMRj69Y2Kw9nBu3U2rjtICUabj/FU=;
 b=dtH2947cTS2E50fYPYEV5knaXZeFXg/trc0o4h1J6no8qIH1PsKY20keyfc0UkOpi/aOZlIYpRfpxCXpOPYrU8ekc0DSiK2u26vlsh3g6E/A12Vti9u6rBfa/lB5c4+n6Gs6KOqD3dPR4IPyPrW8H/bJlvskF3MlX57mpjlJ6+uW72Kumix+RBaYcSEW+bzv6BScrAgWBGCFfrWs45EodPFm1lmusfH7OU8Hi0aTWAAZbnYHteDmyGfR7A+Xl2AjV6DAKKm6Y/PSm3E/vWyoJkWLacl1mssQr8rlzWzzEPHL1ayTIu7AT3dqsdmRax+/jQysYFIEAHsHlF+6aN0KZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH2PR12MB4646.namprd12.prod.outlook.com (2603:10b6:610:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 14:10:18 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::313b:8981:d79a:52d0%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 14:10:17 +0000
Message-ID: <ea4c7e7c-b8cd-dbfa-4cb9-900f0ffcf821@nvidia.com>
Date:   Wed, 6 Apr 2022 17:10:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/2] virtio-blk: support polling I/O
Content-Language: en-US
To:     Suwan Kim <suwan.kim027@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, dongli.zhang@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-2-suwan.kim027@gmail.com>
 <Yk0ebS3cl95XtOuj@infradead.org> <Yk2YiSIB2OZv1FEb@localhost.localdomain>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <Yk2YiSIB2OZv1FEb@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0107.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 460510d0-2aea-4d98-22d4-08da17d72da1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4646:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB464603CC783DD6ED39D78181DEE79@CH2PR12MB4646.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmXqPauT2WS7O+2M2ob7KgVxWC70Ta1FhQIXTs8Qq0XhNyqlkGERWac7Smwt1uJfgTAGkNOqiH3VmebDzTEF8YXLWwzTK6OMTb1GleXUDBksySYx0yNIxz21QvliQ8p2PPWU2J1aYw9sNs3XtGTdUwW1Mcm4LELP/I6hVQ7y3q3KxH9zj19P8wCrgY4yaa6aVzgD873zMAZP1nFcDfHFBx+36lzNhM54DRd/carM+zUq2mDKmXCe75ZrvTkBz1qFDg/N07qw34wea3bCF59J2H9ndN7hXfzLpkwFA6wySwlOVEFf1WU8X3MXOju0WIQw0Y8EPutcAGerKV5a/0WcjMVPXsUtztYO0QoQcYVsghr6SFV3r/6doy/IuHYGAjq6XeKVufk1o0zeHND/P+zHjP9+YDdmE8r3ypCDBmpWGwdgmjZ/MkBINrD/3EcdPq2w1boz2Z3HKbrK1uG1pT/OxAZIOd5TtdWaJZBp67moam1PFfl6GsIpGxUt22kGGQyoq21WADiff+HRxJN4TPoWFt/phZbIAjH3cBwatRAHsr3GAAsoLUmRGMhE/A16L6K+Rpbrg0Gmm0UM0SCp5wCEiPLSiEyUhQe870eEWeRHUcLG/v3nZNysssK9fjllXhtHhCRxo483H/5ahNHyUgzSSCWqt+1Zicz1e6uCV/Vg3atyGjM2ccDH9tzMSRRBmSN05rmPVUioldXBbrHEMZ4uiJAC7mvouy8zYw90JI4a046xsgFgbK9+29xEikdJj04J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(53546011)(31686004)(8936002)(2906002)(83380400001)(36756003)(5660300002)(508600001)(6486002)(38100700002)(66476007)(66946007)(26005)(110136005)(186003)(6666004)(6506007)(316002)(8676002)(2616005)(4326008)(86362001)(31696002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dPQ2YzLzRtZ1ZTZHlITTZsTmlLVTJBbFpsa0RNZEJYVHBEMUs1MDRPY2NT?=
 =?utf-8?B?eFFFMkpPZE8vazJsdzNPb1Y1UnNudlA5MmgzTnlMTUt1eDBWTnpvVWVXRGpI?=
 =?utf-8?B?SmR3WGd3UytYQUdPb1k1ZVc2NVZ6c3o1TUpvUDJIcVg4MXljL1Fjc2dMYWFn?=
 =?utf-8?B?M2FKTTdtQ0g4RWNBLy9oRDBpN3RPN2pqWjRjT3BzNUE5eUlsNmlBZkFDL1dx?=
 =?utf-8?B?MFZHdUNIajdGd0pCOTI5dVFpMkNmSzhVOXQ0aGl1QlZ2MC9SczV0Ylg1WXRC?=
 =?utf-8?B?NHZ1aEpISjM2cVFkSFBGTUtoYTlQSTNzaUhVVEsxRHdnNzU5bG9HQlVMQmRQ?=
 =?utf-8?B?T1E1alZES2JPUFpwbW5SUjg1dHh5N0NmU2dicjdlS0hLbHVtc29jdkdHRUVF?=
 =?utf-8?B?VEtWaGFKNGJIakowSFFqcHlYL3IxUWQyQkNOR0ZuRjduRzBXYVZTc0xmK3Rh?=
 =?utf-8?B?RmRCQW9CMXFlUUVmVGFiTE83c3FYaHBscjFaZXhDcktVUHl0Z2ZPRVlDekRq?=
 =?utf-8?B?ZWZIMXRxL0ZlWC9OelRsN2FISHcybFRWazRnVkt5MG5iazRHSHp2UVFwZHFw?=
 =?utf-8?B?UlhvZEk5SW43bEVSemcvdkZMOGRjSlluQk1jbDRIZ0NLb3MwcWJSOGp5ZDk5?=
 =?utf-8?B?T0xtK1NiUTRnOTZnUmhNMnNwZnIrS0xDc2dRWHo2bE5MRlROUUNjTUY2RzU0?=
 =?utf-8?B?MEo3Qkt3M1MwUGcxVExZcCsybVpBU0IrcWJ2TkUzd1JvZll2Z0dWRUd3ZWRJ?=
 =?utf-8?B?TGlid0NYVWVKQ1gyTjV1SVhmbmkyNWRmMS91UVphZ0xnYzFlZ1RhYXoxNDQz?=
 =?utf-8?B?SEs3ZS9BcDVCb2QwOWNjWnpTSFlkb0NpeFJraXpFdmxSaElYQmJZbDNLd1cr?=
 =?utf-8?B?RXVQVG1vUVdybmgrWDdiSHlHejVxcXhiQXU5Ym0waUxuZ3FQTkNQeUlERUE1?=
 =?utf-8?B?ejc1OVRlMmFxbldxeU9iWDNTMjVWTERVTHZhK01acVpaaDIrQ3QzNWdpUjFF?=
 =?utf-8?B?ejl5QjFheHgvLzlSTlE5RVlXOUJDZC96c2FLaHhESHIrekwyNkxlYUpicmZP?=
 =?utf-8?B?b0cybkMrdk1vMGZla3dmQjRNN3dySk9YYmhqbjU0c2loeVA0RTREWlV6VUpR?=
 =?utf-8?B?WldSV1FhMmFQb1FTVThkdXc1R1ZRU3BZdHprU3dCUWU2UEJHQmYrWm4ydGlj?=
 =?utf-8?B?ODhzSHM5MG1PeTJTUElBekJSdGk5V1YzWkVGUHpHR0hMOEVmd2M3K1UzR1VB?=
 =?utf-8?B?T0RYRXVFRWpiRGQxMkxJVkJlUVA5VUUwSVM0SndwaUZOSUt6dUZyZXRPWnhr?=
 =?utf-8?B?K2diK21veVZLczkvaUVDZkVHTFNyZzBzVEwycDc2WXFjZitVRkl1TjBDYWFE?=
 =?utf-8?B?ajAyaDRZaVE4TFh5WWR0Y0xCZWtSOGQ4d2t2QUlwWFZzVGtjZDZEM1NFVEdF?=
 =?utf-8?B?b0Y5WGtsN08zYk5HZ002eEZXUU1SSk4vTUhiSGt6by9aYUZBOVZFQkF3RHZh?=
 =?utf-8?B?aUI2Q0FOb2o1MTQycnNVazZpYXFHWi9qbkNWZjZIUmtvcUN0WVEyV1pWdy9H?=
 =?utf-8?B?NC9UeW1HRlhXR3RiZ2gwWkVlZUwvb3Jpa05EQUVUNStnMTh2SW9pcHBYRmlD?=
 =?utf-8?B?NlcyVi9VSmtBTGVqbEo5ZGFUaUp5YVVrQU9QbVdDV1hudlBLU0tQQ2ZhcmRz?=
 =?utf-8?B?NURXN05hbi85MFlqbjlScEJCays3RFJ4ejlCMWU1Rk5pb3N6ZUE1ZHZEU2po?=
 =?utf-8?B?TnJYNTZ1RVBtKzgzZjR4cFl3S2RBR2tRU0pqeUlKUGV6ZVBlZlhKblhWdFlr?=
 =?utf-8?B?QXk2d2doNVp1blQvY1liaVNCZnlKVlBDeGU4RDE5aFJWYUI1bk03a1VLUzBU?=
 =?utf-8?B?TTd3dWhYZnJKTjlxZi93RU9aL0U0NjQrSUxXbDQyTWJLQ3dkd0tXR3A1aTc5?=
 =?utf-8?B?U1BpL3FlV25hZnkxaGFEL2pVcytlT1ZlT00rVmwwTmpYTFhiRk9IbnN1QlJE?=
 =?utf-8?B?MG9zT0o5WGlsbTlTSXVhbVNuR1o5QmcxOXQzODZDa3BOdHdudC92U3Rxb3By?=
 =?utf-8?B?WE5jdzA0bzg0RWNuRit5WENRTG1vb3Y4UndHU01TNkpIMVpTVnB3cktvOE8w?=
 =?utf-8?B?MjhQM01XSmtGZmo2cGRhc05PanVncnowK2JCdWVDOFdwcGNVcEFubHVaQlk4?=
 =?utf-8?B?TUo4T2JTd2t5MUdCRlNrUlQzRlQwcjdxQ0NGODl6dmh3TVYrUTRPbzJQWFQ0?=
 =?utf-8?B?cHFPL3dWZkVVNUVqZGhraWNFN1NkUmorM0xDNkxTSU9lcjF6SUR0azl6Vm9a?=
 =?utf-8?B?SDlHaFZhc3ZmT3R2Q3QyQWM3MGNJVVNVOS9hckpBUS9QRmdUL21UT0ZNQ0lj?=
 =?utf-8?Q?DQSpG12WqldEDEQ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460510d0-2aea-4d98-22d4-08da17d72da1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 14:10:17.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv9VBW0dbfm7lc+cDaPVCP9KSNzGmr3OVraGxL80dRyYZbBpJYw5yNRhbtP1Sgc9E7/z+DEbfy3+9zq1Afg9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4646
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/6/2022 4:41 PM, Suwan Kim wrote:
> On Tue, Apr 05, 2022 at 10:00:29PM -0700, Christoph Hellwig wrote:
>> On Wed, Apr 06, 2022 at 12:09:23AM +0900, Suwan Kim wrote:
>>> +        for (i = 0; i < num_vqs - num_poll_vqs; i++) {
>>> +                callbacks[i] = virtblk_done;
>>> +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
>>> +                names[i] = vblk->vqs[i].name;
>>> +        }
>>> +
>>> +        for (; i < num_vqs; i++) {
>>> +                callbacks[i] = NULL;
>>> +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
>>> +                names[i] = vblk->vqs[i].name;
>>> +        }
>> This uses spaces for indentation.
> Oh my mistake. I will fix it.
>
>>> +		/*
>>> +		 * Regular queues have interrupts and hence CPU affinity is
>>> +		 * defined by the core virtio code, but polling queues have
>>> +		 * no interrupts so we let the block layer assign CPU affinity.
>>> +		 */
>>> +		if (i != HCTX_TYPE_POLL)
>>> +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
>>> +		else
>>> +			blk_mq_map_queues(&set->map[i]);
>> Nit, but I would have just done a "positive" check here as that is ab it
>> easier to read:
>>
>> 		if (i == HCTX_TYPE_POLL)
>> 			blk_mq_map_queues(&set->map[i]);
>> 		else
>> 			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> I agree. I will fix it.
> Thanks for the feedback!

Looks good with fixing Christoph and Robert comments (memset removal).

Please run checkpatch.pl on the new version to verify we don't have more 
issues such as spaces vs. tabs..

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

>
> Regards,
> Suwan Kim
>
>> Otherwise looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
