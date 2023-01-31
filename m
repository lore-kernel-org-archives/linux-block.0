Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01325C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 17:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAaRs0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 12:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjAaRsV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 12:48:21 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968624EC6
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 09:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioWO2WZCy4ut3TWhorA10+P9lBt4VVJWlJ0nxdHgkn26Z/SZn59yrXtxKaxm8fALIrhkmKU+j5LIJgSfnp5ylEXMeTNV1uIaHG/czp5R6OAiOy5RZ9M7VoW++h//790QYKQ4QhhaTlsG+ZpdhqtjF8VDvxYVkehPFYSVjfT1YZZ24UrbS2MXl/g6vj+qBjUTwgqCeiw+6TfmiYeN/PKR6lxN8Nd3oilAX7GJrQvLqyZLrb6PR+BMAj1FWPtutgpdLWu+g/rHOZdphjOrbOfCMmd5PnpqUGvvkBOxA/TzOviBQYqd2aErDngLoZ0YzofbATMns+gl2U2GEALf2IFQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=At6p9SZaB//kF5+Dz/WIAkcrKgvzZIIfsK/kqGlm1d0=;
 b=YQKM8JhgEIu19vI/7sNdU+tml8lCVr+6SiVL0ST5CQIVfux/djeITXKkdRkYjnGbNCWXR5RIrVY2NypJfCMxHOXnH49te5ylc0JZDoJ5tucy1IMn+xRAgqq6MpyPm8SzCmYVyEYPDes/LfxJoawWV2GmOSr5Hkg0A0GI41mc92G7ktl3VrFaU1o9LPaNgYF2XJeW2OGXBZh3Q2ZXSYw/zpscdOdt0Tyd3lsGgXkucYjxq6agf1YoYiKlBF/l1h0CzMviXhtF+OhUbI49BYoohYLoQI3mGrWqpF7P26RYF33zlRjhA7DsQ6iEo/0JUwnkAMQiHspYq3UcMelCy7zPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=At6p9SZaB//kF5+Dz/WIAkcrKgvzZIIfsK/kqGlm1d0=;
 b=St0PYQEY1gVN/mlzWOODuAQ7S2XgpfWedyLoIVnxCd7X9CDAXgerhGnKdYn++T57DNz1dH1OIppOKWrdrN7TMsyupqAPl4PX79PpTZ+V04yCPKo94URu7tICXBcfow37X+yILSwqfH1a1snXo3h94kZoXyKdsQivASXkqIr5fn/c/JmFJkcNWOqrO7qOq9YSjJflifj91s1aaWYrG8qpYnsGSfePGjf1H894iELDcok4K4qmk4W0lQFp16fQFrQvizjFDgEuFuo0nMVe7YAqZb4h9IElip+QxPIS4ecNimptrQlXbffvqf5qwC3B/D/6WH+pESvDk79Pf5ybHffFrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:48:00 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3b11:5acd:837b:c4c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::3b11:5acd:837b:c4c7%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:48:00 +0000
Message-ID: <b7ac83d6-bcea-c942-1502-fc876957c78e@nvidia.com>
Date:   Tue, 31 Jan 2023 09:47:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] mm: move FOLL_PIN debug accounting under CONFIG_DEBUG_VM
To:     Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <54b0b07a-c178-9ffe-b5af-088f3c21696c@kernel.dk>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <54b0b07a-c178-9ffe-b5af-088f3c21696c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edf8e12-3a7e-4180-8308-08db03b34b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwK/bgEODxI6afsU6D4AZ+NC7ASrGyK3jqpatiwI1h6i+yIT0d26JNJB5IBJvzyMABw6BkNVoYg6BxzgsKOemZmXfIld9lhmvpKMc/zgl/jvB7h4pzhBP1D8xSnow+1UL7UuwA+JPTNpYx1maQAJUMrQ6bAZF8JrTitEfYJVKlwEGb9cJoVVgdC94NZoQKqMNG31PvQtBOso3geNJ3ic0z5dIuHqr0dpLfWjmQlhGcT79CECZYpe6J6KDuBYNOLJffndU05JHW+nGh4G58cFZHkIcsixtZMieu1msekQX8zqaE0ksQamGQ3oaIHUu28fd4KNQ/qnlp1GHWk6Te4n+TH6Lk64tpzIPxLocuZMiXIL8RviraJZHJkIUP3fjsHdRv9JrRo5f7WYekSmxuef0FYt2gcUt4UyNfNOQnarVaPttxB71krzKeBaregxDbja5v1+T+pS0+f79b9TG2uHVyCe0XhZYaF0OU19ofYJDp1GVL0TjtETLWewt8EDz/yBQzOmp9lOAA9WtaIn/v5bNCeHHurN4gy3em2bbuLgbky93Wlq9h37f+waR4Ay474XG/ikFO4sudnV/X35PdlXjWDevt45FuLnSnQ90I32OyHZrPqG+zrTHzD2+T1FzVIXMkGBkLG45RJO4UOUjYYm+UAy1i3X9VOu0GngOe6+CM7JGak9rLESbczrWTbFrhmkR9n3FOBmd0HQlw9ULd/0hPpZGSJfUy6pSE08X759Yb+qEwvbGtItZbWNgjKRRyHmrgzfKw0BjWRg0T1uSKLoZp/2z/rtDCCnnzLkiRqB6BJGTj1egABb8yN+uRx9Zkje
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199018)(31686004)(36756003)(38100700002)(110136005)(316002)(5660300002)(54906003)(86362001)(83380400001)(2616005)(31696002)(15650500001)(26005)(6512007)(53546011)(186003)(6506007)(2906002)(478600001)(6486002)(966005)(66556008)(66476007)(4326008)(66946007)(8936002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzg2ZDNpVzZUcDJvY2NMQXBFa3NwNmdNd3JWR1J5bmlCR3ZjeWh5bFA1REQ4?=
 =?utf-8?B?dUQrNmVPU1hEUkZmc0JqUU5WRE5ETklVeHJhUWlrRHJYWHhtcVVEQWU3blFD?=
 =?utf-8?B?eFZBSlpEdE9FWjl1ZFM5RWt0eFpDalBhYWIwblRFUDdZb29rYjdKYlMzTDVN?=
 =?utf-8?B?R2tjMWlrTkVGazNneitFYlF0bDF5V0tWL1U5OVA3K1lWdTFSYmVKUzk0U1VS?=
 =?utf-8?B?bkRzemVIV3dHKzEveTNjbExRMlJOS0k2S2Z0S3l1azlNZVRsdFFqckkwYWdN?=
 =?utf-8?B?TDVqd2p1c2JlTldEQlFMNkd2TVdwRzd5anZhd2FKWkVrOExrS3RIVmZiMld4?=
 =?utf-8?B?dnliWTVNdWlxd2RxbDQyTGRHZ3dVcENDai92TXBLWnFyamRISjlXT1MvYXRq?=
 =?utf-8?B?UUwxcXhCYkJEU2FpNU5jQ1gvZnA4QmlGV1B5aDdQU3R1MlhLYWZOZm5pYXor?=
 =?utf-8?B?cHhoWjY4OGorTnY1RGN6eG1GQkZVNEhaRjJkNm5SdGZ2N2V2WGd3SE5rM3A5?=
 =?utf-8?B?QVdEMnBQZit6UStTZVlEM1dUcW1vdjZ1L1d5dHRMZGNaSTZ5SVBSRXd0WW1C?=
 =?utf-8?B?SmZHZHIwQ1g4NkVBOWdkYVVIcnd1blRWK20yektHYjgvUCtYK3lTVzJscFRT?=
 =?utf-8?B?YlVDN3VNWmZxSzVWSURkYlplL0xyL1k0UFgzNlc1Z1dIUWliOTEvalhkMG1T?=
 =?utf-8?B?dXhRTzBKeFl2U2xWT293Njh6OVNiYlllVXVsaHdEMkliV3FONDJrekFDOVpw?=
 =?utf-8?B?cFREZUp4bU1oVWo4eGJ3NzY0MVdXYkcwWWZneFV4V2NjYkswQjAxNVVLaDNp?=
 =?utf-8?B?VmllaTdSN0hOT3ZNTmtnbkdrTzVBcWJ2MTdYN214V0hQSHJCdHkvdXlId1Jv?=
 =?utf-8?B?WWlmd3pGcWRiek9SVHpoa1kybXNxUndNdWM3cDUvUlMybDJveDFqZVBwa25m?=
 =?utf-8?B?b0dwS2dPSG5Tc1laeDNTY3RhMDM2QlhJZXl2alFUV2lGTWVsUFZ6WW01WnBM?=
 =?utf-8?B?bHBBM012RHNjdWpTYVBYVWFIb01jVW1xZUlTWDBZMkN4STF1Z0VLc3pzd29n?=
 =?utf-8?B?c0pUaklvSmlDYVNhWHlPakFVQUUyenVvaVRraThMVWZ5emt3MDR2RnFSbWNQ?=
 =?utf-8?B?b1JmZm1EVG02RG5DMnZabnljYkRDVDQ4a2gySHBURVY5bDA5bE9vVjQ4bCtn?=
 =?utf-8?B?SFpWUWpFbFFoVmpHenBMR01iYmZES0hlUFNSQkRSckwwTmlQdHU5MS9kdmhq?=
 =?utf-8?B?Q2VieTZxT01vV0p6V2RqQmgxaFhaeFJ0eUNDUmhzS2F6UlpWYld4VXhmQnR4?=
 =?utf-8?B?U0gxS0lzU3FyV3dMOFJ0YWczcm9WMGxKOTJIbS9iM1BXSmxLZTB6L1Y0N0Jl?=
 =?utf-8?B?TDdwMmNJcXRRaVVFK1FjYi9iQTlUejFsU0g5clNrbms0YkdJcHByVFhycUFZ?=
 =?utf-8?B?TEQ5QmRHUXNMVk5IT2NkdVJVcWRTZC9Od1EvWkIzNnp4WWJ1Z0dmODI1REh4?=
 =?utf-8?B?WXEvWnBPVERYQTR3SXZuL2g2N3pIdWlOYzhQeFBlMDlmSHRkdUZZbkt3OGNm?=
 =?utf-8?B?VDE3THlXYldBNUpmc0p2OFRTaGE0YllCWmhZTC83R1U4L2JKZmpUSXd4QTRZ?=
 =?utf-8?B?WEt0cTI3Tk1SQ2ljaGFmTENSWXNDSmxoZ3V5QTE4bnZiSjJiZFRXYVF1RUxx?=
 =?utf-8?B?MkxPQUZtS3RNMENqd1Jud0NOSHFtU09DK1A5OG5WMmZlVjlpcnJtK0dYV3Rm?=
 =?utf-8?B?NVBlZDFDUFI3N2tLcEMyL3RJaGNoaFFUaUdCMVlwNWVFbW5NdzdxdnYvWHJG?=
 =?utf-8?B?MmUrTHduUjZxQzJ2ZWh0Y2tRcXZZc3NtS2dCdmk4b0tFbGtFQ1R3L2RyTjNv?=
 =?utf-8?B?VURNdXZlSUx5amtzVmdqbnpDRUNxR3hkREErRkdkNCtjMmZPbStvK05UNzM5?=
 =?utf-8?B?UktIcHpvZ2piMjNqaXV6bnVWaGZpOStZYXg5WlRuTjc5eUx5Z1NaN2xuZTVX?=
 =?utf-8?B?eEp2eCtuR2gyL083NmpMMGxTVndmRGFyc1IyZUlXVkh4OWFHVFc0SWpBSnRx?=
 =?utf-8?B?bXJwUUZLLzNnY0RMYnJ5UTJuTXZFRFFXNk90ZVhLS3VNZnl1RXlGeStCVnow?=
 =?utf-8?Q?NRPyk+bjeTKC/RsYYddT6PDn7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edf8e12-3a7e-4180-8308-08db03b34b6f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:48:00.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2eIQyl//LsS4LqgipLwfLIHIOWHJcvIgEQ3B8dBLDcxrVGxLZRi606Uf/+WlMQzmTRDyTRUUlWZGJ/kQHoxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/23 07:36, Jens Axboe wrote:
> Using FOLL_PIN for mapping user pages caused a performance regression of
> about 2.7%. Looking at profiles, we see:
> 
> +2.71%  [kernel.vmlinux]  [k] mod_node_page_state
> 
> which wasn't there before. The node page state counters are percpu, but
> with a very low threshold. On my setup, every 108th update ends up
> needing to punt to two atomic_lond_add()'s, which is causing this above
> regression.
> 
> As these counters are purely for debug purposes, move them under
> CONFIG_DEBUG_VM rather than do them unconditionally.
> 
> Fixes: fd20d0c1852e ("block: convert bio_map_user_iov to use iov_iter_extract_pages")
> Fixes: 920756a3306a ("block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages")
> Link: https://lore.kernel.org/linux-block/f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 

Yes, that's the exact right fix (in the absence of some magical
high-volume, high performance per-cpu counters anyway). In fact,
originally these counter operations were behind CONFIG_DEBUG_VM in an
early patchset, but the FOLL_PIN feature was new and potentially flaky,
and also not yet in the Direct IO fast path. So during code review we
decided to enable the debugging information unconditionally.

But now we can no longer afford the debug counters in release
builds--but we also no longer need them, because the FOLL_PIN feature
has settled in and had enough soak time to be more confident about it.

Over time, I'd kind of started assuming that these counters were
necessary for release builds, and it required someone else to wake me up
and point out the obvious, so thanks! :)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> ---
> 
> I added fixes tags, even though it's not a strict fix for this commits.
> But it does fix a performance regression introduced by those commits.
> It's a useful hint for backporting.
> 
> I'd prefer sticking this at the end of the iov-extract series that
> is already pulled in, so it can go with those patches.
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index cd28a100d9e4..0153ec8a54ae 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -195,8 +195,10 @@ enum node_stat_item {
>  	NR_WRITTEN,		/* page writings since bootup */
>  	NR_THROTTLED_WRITTEN,	/* NR_WRITTEN while reclaim throttled */
>  	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
> +#ifdef CONFIG_DEBUG_VM
>  	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
>  	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
> +#endif
>  	NR_KERNEL_STACK_KB,	/* measured in KiB */
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>  	NR_KERNEL_SCS_KB,	/* measured in KiB */
> diff --git a/mm/gup.c b/mm/gup.c
> index f45a3a5be53a..41abb16286ec 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -168,7 +168,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>  		 */
>  		smp_mb__after_atomic();
>  
> +#ifdef CONFIG_DEBUG_VM
>  		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
> +#endif
>  
>  		return folio;
>  	}
> @@ -180,7 +182,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>  static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  {
>  	if (flags & FOLL_PIN) {
> +#ifdef CONFIG_DEBUG_VM
>  		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
> +#endif
>  		if (folio_test_large(folio))
>  			atomic_sub(refs, folio_pincount_ptr(folio));
>  		else
> @@ -236,8 +240,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
>  		} else {
>  			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>  		}
> -
> +#ifdef CONFIG_DEBUG_VM
>  		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
> +#endif
>  	}
>  
>  	return 0;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 1ea6a5ce1c41..5cbd9a1924bf 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1227,8 +1227,10 @@ const char * const vmstat_text[] = {
>  	"nr_written",
>  	"nr_throttled_written",
>  	"nr_kernel_misc_reclaimable",
> +#ifdef CONFIG_DEBUG_VM
>  	"nr_foll_pin_acquired",
>  	"nr_foll_pin_released",
> +#endif
>  	"nr_kernel_stack",
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>  	"nr_shadow_call_stack",
> 


