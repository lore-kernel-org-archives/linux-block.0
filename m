Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35AEC433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 09:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiI2Jmf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiI2JmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 05:42:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFBA1319B0
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 02:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkF22Q+ePzjnFeyjtkNrd77rQB5PlZ8y1R4a18VcMtV1r7EuXlxjvvcMCqpYvz+kqEUWqsXVOWAfOpekmOWMgB54a/wk+jh4ioJsdAiMci2bElwNMqs8VQmxB7w9swLip289p1ihWbvb+vXZq12pbs/PNQtFiTbLGI/cQpUIQBPnBFtQKNjj2Qyy11MNcQgM4WHdp4NNpEl9sNfwcVVHSZi2NdeDIa9DeC5eg4+a9B7WwmbFApmixqdmt14meXg6bm2pY1WtNWfe6L/5/PFdGO8+4/vjIiKFWOMXpn3RrBXzj61z1I5wYU8EhDtw5mZGffB8ornyF1zpU4VNcEx/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ5mpA8er17Zh6sj3oyVd7ApaVaM4KXGIyD8iI2Q+bQ=;
 b=neecHF9wWlOobPSMBBYsWCtv18dPuaQaBSAk0oQXl58TauBAY78uSNj2eaM0+RBQmCyaSvAr6gaKnjzPPNtvU9SegjlLUt0CKgkbmuLlNaCQ2MStG4ExQ3z2vObVbYwxWi4c/a04C65uA5CksCxkPAyFeFOTWayNVXf24i2gZPxr1VFiXYYVyWppaj50jiB6xmx62Avik8ett9i/X+mrjnO9z2VciG0h/SiCmux9xiDxOqmfle/5GBRmETD8QtrBaL1co8GgY0hl9L4xMkgLki1FDbUc23JnPDvjnIRQEwIkYCHE07BvW5J+TlzKYpRRgc+EXR1q7phfbEli5vVOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ5mpA8er17Zh6sj3oyVd7ApaVaM4KXGIyD8iI2Q+bQ=;
 b=oHh2BxFyMcpCcxceclA6kzZ28hhOZVInnEk/80iHEyx6ZI5gdKKo7FUWG//cGVufOkwSFvF10/3agx8MiGZoPDx42eCnCgoOUqbG9bXezrV1qWDZC/S+ZUehlzSHEliajM0eMPZfAG8d1Qk7jvKrGu5RM+95EEgyscN6dQpv+R7D2GZGDVqYuR67WR6wjsy9y0MXtvjTQYK5nGS6wa+vJ7whfxhrWdK9+AZFCrpm9hvjmHj/4getixaTLQ5addc5W+k8Q4WCKQwGuE64FnEd8W8hq/TIfaN/MbJDiPNSbLVXWst+UVbRap2686oSwvbjlQoUcuLV4HoQ130ckZDXLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 09:42:16 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%4]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 09:42:16 +0000
Message-ID: <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
Date:   Thu, 29 Sep 2022 12:42:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220928195510.165062-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: f5704607-69a1-4478-8e9c-08daa1fee52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fR+12LncL7n4UblwrS3bWVwJXBipEGpmKXyCGDTly9MHD7vtaOV50IBwhBa8iCYSbDDiG0U1mHeQ3h5zOxs8AiGaFAEwLZ7d/3fzyAkqaoE4Q+yFzMaFHnnHuy6npHWMso2Ly+wzZNa+foLELGxw4GWIvPctCx6cBqeQoXqZg/LzGabzbld2oNML6ny9Y+JWh4w2SRwXoEm2xEuL8hUtllIS7nmQKXJ5AofEEvKaSQGZ9hD2ZJCmPlqxTh5pUmzkt+pk6deaFjXzM9RW0fC+QXPgWNdn3UB2L67Fd8wkjBT2J+CDo2ANQPSFh0oPemX4KJMv1BvzeyY2L5b9Pu5a2jVUKuysrVrmFRAyRL3joY02rI0/uydU89l5zKT1CSO3UjbDwgL5JQMv9QJsr9fpaHq62GH4+NmPI+L+Ngtu2dX8/ilvLPQBS9nU6YruqyffvTpjobSKOUuCgbdJVm5pREFgkIMmqNWA0ULTXqGRAYRaN/XstAgnQoZloWLun8FpY7clhotraLlns+7E8moyk5FX+uANQPpp+NMrjdL48EIYK7QhrC/gf76ED9uiK6p4sdmZJLD0SgvH6YFuwweFIwsZ5V4JhJeZAx0BEiAGUosonySDs6dLBvXfoQy5rypinj/tD3IFafy4jU+mC4WVsZTKsvI83pWGdgPrW3XYMsv6w15yUQ3AFD0FQWbhxr+N7bq9yp44AAdc3Ug3CaysopFbqqXRcgNU5Im+zj/B6QY8W0Eoe78/dNwosKOtM/A4I2/wNxwYT5LZc2KNg1GE7NYk2zqY4BvQ5Ku961qFP14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(2906002)(6506007)(66946007)(41300700001)(83380400001)(478600001)(6512007)(5660300002)(54906003)(38100700002)(36756003)(6486002)(8936002)(26005)(186003)(31686004)(6666004)(86362001)(66556008)(4326008)(53546011)(8676002)(66476007)(2616005)(316002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTM2VlpNTE0vcUFKc2xnR1VSd1owdGFNSld3eWdTVkRrRHBXUnlFSElaMVVH?=
 =?utf-8?B?WmRVYVlzTXU0Y0dZZS85bWg1TmlMSzJsdUNJMUpLMHRIWGwzeUZidzlESFRS?=
 =?utf-8?B?WlJibDVIQVE2N2VHbi9lNm5vQ2NtekI5b2RPcXFBbFRlakVHc2cvRGVXbzdz?=
 =?utf-8?B?Z1JKUEhjZCtIbmVTOGorNlFuOFFGUE1ZL0srcVlEdmd0OEhBSnd6bUI0M29y?=
 =?utf-8?B?M2hwVHJBMnBPamt1Qmk0UWRSU2hFcVFmamVtdTNiWWdpYkszTFlOdHpraUlN?=
 =?utf-8?B?aE5kVlRRQ0JOWTlibnljYUdFaWdLa0JqTTRhMWZLeDEzOFRYVzJDQWZwVlhv?=
 =?utf-8?B?ekE1aVZRSVBDeWNGcE9JRURBQUtLWXdISTM4dVlaSjRKajN0bXNpZERJcEsw?=
 =?utf-8?B?WXJRTzVVMGhVUlpLSmZYcC9Md1VKUVN0T2ZWd203b2ttWFR4eTdNVUZrU1RJ?=
 =?utf-8?B?Z1g2OUJSeFlvWGZSa0UxQ0pVL01FTmE2azF4RjgvT212OHo5eHJHQjk1UHlv?=
 =?utf-8?B?TkwreldxaDl3ZDNrbEpEYnErZHUveVJmeTRRYVZSN0hKbFJQWW1keFVyMzlu?=
 =?utf-8?B?K04rYzdhU3BoeDdNSEtRTGlCcGVxYzlXK2RXNU5MdHhvMU1lcllqdElrR1RC?=
 =?utf-8?B?M0o0TEpzUDlGRTd0WVBTTnNhTGtoa1lKL3kvQzg3Q1ZjbUlrMzNMYmdWV0NE?=
 =?utf-8?B?RFJhL0pSZlo4cjJWREZBK1hnMlBmQnM5b0Mrb2VUME8raXA1djZmZjFTSm52?=
 =?utf-8?B?Mkpla1RnQ2RrOXFidFhEY3NaYlZIK1IrMlhlVkNTQjF4YjVzVm5Bb0tubmdv?=
 =?utf-8?B?R2dFcmExa1BEcGlJNWswVm1wTTg5NmZNYkdWMW12TmUzeUJKZjhwU2x1N2Uz?=
 =?utf-8?B?OXJXbG1aUUFFbTA5Sm9oSGdWOTRlNDBzeUFuZzNvYUZKN0JLSkNqY0dtdHM4?=
 =?utf-8?B?WUc3V2ZYUWVxcy8wMmYrUzlKSHFGc3NNTGcvWUo1dlFIWHFEZkVlU3VIMjhW?=
 =?utf-8?B?YW5Vei9ZUHhWRHF5Rk9VejZBdGh4cHM0c1ZEMFVrUnllZ3FQck0xWkFQTlNr?=
 =?utf-8?B?WTgwNWZ3MnVMSGpydUltZmxvUUozcThPMEZxam1HWVk5Ynl5RmlrTlB3T1lQ?=
 =?utf-8?B?SjN4OFBsUUJJUU1uT0hURUYwaGJBM05JdVRpQTB0MkZYUU55VWFVWDlONnhn?=
 =?utf-8?B?aFpGWTQ3VzN5NGRxbjBpdmVRM0dzK3prd005bC8wSTBqaVZYakxDQjhwOVd4?=
 =?utf-8?B?b2oxTGtFN2hwNDVUbk80eW1Ca3F4OVF3MDEzUVRYQ1FYZThLRVE1NklLaVph?=
 =?utf-8?B?YUttZUV2cituNEhMUzVVMU54RUFuWmRBT2NKb0p5czN6RllkQ08zVnA3bHVY?=
 =?utf-8?B?bWE2cTlWNXZ2clFVYk45K0hyZ3pyRm9NRUxoSmNVVEJ3M1VLa202dHRyS2FE?=
 =?utf-8?B?cjlhbjd0ampoMldIdGlDeDlmU2NZd25PcnlBVVQrQkMrUkNyUmhqWnVmU21n?=
 =?utf-8?B?TzJwNUROVWxXYWRjdExBcHpNTmRzTVNsQjVOUEkvVzR6OUU0b2dnME4raDd2?=
 =?utf-8?B?bndLZm9mbDdZc2NhbGJ1S1VIa09qakdvQ3V3K3dLUDNqZGtMVlNrWkFiWGlD?=
 =?utf-8?B?bWV4WDhGd3g4aVFSNmRRVm1zY2ZiVmY3YmZBK3luY3QwRXlSUFJobyt4S2FI?=
 =?utf-8?B?OWRkVGNLNWxoRDRCK3FKWisybFlBUGp4L1VpRkhQNFZTcHMzVU1WV0ZCSGlM?=
 =?utf-8?B?T3IyWXZ0QWVlNk8ybHdBcUpGRmtXUUx2YitqMEZlMkVCd3pmMmRUVityOGkv?=
 =?utf-8?B?RHA3MENSclRjdFFSRDRJamRjVzgyaTdQVS9relVFdGpuOGp2MXg4bnNYODVz?=
 =?utf-8?B?MnZ6T3pmYkpUelNnNDVXZTR0TFhteGRYc1M5VDZPUlkveklzcUNTZDR1ekY3?=
 =?utf-8?B?Z3N3bDNEOWdsZEVETjJzdWF4aGtNU2pmQ2RNSGkwa01qNnJEaUdZRUpHODRE?=
 =?utf-8?B?d3lJWFY3d1VUMzVneUhxK2Jyci9DUTNVWWZka05Ua1FYTC9TellJdkMweTk3?=
 =?utf-8?B?aW5XWTBRMUlwUUZlbnJxZmxkSURBY2FkMTZrLzJpUVFhSUxMN0ZYaEpqeHE1?=
 =?utf-8?Q?7XOMtjuWfPPKSsZwL866mEQ2v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5704607-69a1-4478-8e9c-08daa1fee52a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 09:42:16.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKzAzCC3HdyuusMtnLzDLbKjHMJqxO+Hgy6T1P0YS8pRJEOg+tR54OQLogHMGiX++9B1PYhS/DMlsm2ZpBWPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

On 9/28/2022 10:55 PM, Sagi Grimberg wrote:
> Our mpath stack device is just a shim that selects a bottom namespace
> and submits the bio to it without any fancy splitting. This also means
> that we don't clone the bio or have any context to the bio beyond
> submission. However it really sucks that we don't see the mpath device
> io stats.
>
> Given that the mpath device can't do that without adding some context
> to it, we let the bottom device do it on its behalf (somewhat similar
> to the approach taken in nvme_trace_bio_complete);

Can you please paste the output of the application that shows the 
benefit of this commit ?

>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/apple.c     |  2 +-
>   drivers/nvme/host/core.c      | 10 ++++++++++
>   drivers/nvme/host/fc.c        |  2 +-
>   drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>   drivers/nvme/host/pci.c       |  2 +-
>   drivers/nvme/host/rdma.c      |  2 +-
>   drivers/nvme/host/tcp.c       |  2 +-
>   drivers/nvme/target/loop.c    |  2 +-
>   9 files changed, 46 insertions(+), 6 deletions(-)

Several questions:

1. I guess that for the non-mpath case we get this for free from the 
block layer for each bio ?

2. Now we have doubled the accounting, haven't we ?

3. Do you have some performance numbers (we're touching the fast path 
here) ?

4. Should we enable this by default ?


The implementation look good.

