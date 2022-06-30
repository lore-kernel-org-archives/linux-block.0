Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6962C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 15:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiF3PVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiF3PVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 11:21:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E9C3916C
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656602486; x=1688138486;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b1RviFlUf0+7fm5teRDejs7Q4JiIaFhIzLubboVyLpE=;
  b=a160vF2Glf6b7rl2HiNJpjcU7xNEMDMXauVI6qmicOpUOTV8X9uFIuXl
   EVXhv1cSUlWgtN5arR6gBuTNRwi2WTE8usX65YWuhavkE+zYc/XASj9Yf
   frkdBJd0nonjvV1LHF78WvpzgIrDnG2/wB2q7XE/jkn+VfkwmmAKc/RDA
   mJq0CydfdHIU+bAeBEuT0vqh8ezsv/7UDcg6NPKDvpTe2Zxt1G8Aj8Oqg
   NfKlzQPGm188N5QZAnsMZT/PhHTvTDvcsBoYMeBafpIx9XrR3ArJlG8Sm
   whprhMXF/aSoff5lSCQFOln6U6sh1U8kWu6VM3UaL6rA9uMxnzgvuyrgV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283477695"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="283477695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="623766993"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2022 08:21:23 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:21:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 08:21:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 08:21:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OozRKCDIc5EYFmGy8q/zJs1aiSn5tXMPKiesYqmVIZKw2MF54BW9iNo4pdprPS/XgC2q1R63WD1K77PKJBud25ZCQfuHmcwncOHhJ22dUi6Z81AlmUTJFiccrkaYHxc6ZG2H8d+yb/RnctuodFPgMDm7oCx2shtU7DmkNL7vIuUyOjKHaBasGZ0F9EB/qHzZeIGKBJJtRzjgsP/QznSVaOaMxxdf4y93V4HteKmMlkFcjzX717s+x0+dVourSDbGAllqmvJ4Z/BGAn0rAIDuIv+DAq7/l8MGL1ujC8NiP+LrJR7qrL3XFjtS6MyGBUnrG/hnX6QglpgI1GExMDe/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOHBXRI+QJUiedPaYLapkrSD6bSF3N6BmHpItuvdH2A=;
 b=QyOJP7/jkVO76mzF85w6TS4YsyiLIaxQAU1VobqtoIjM1EedPvHkb6k7IsvjZttkLiztknvi+/mA+mT18cqR7fjtt99QmCMmeYXWTn1vFbTCoQO8edIsrnJrtovNmQA2dWwBYhsxZB6HrT4pivXqBFrxdWW38yMiWLDqm2tjHs6TdMXqAQZocFcMoZtAIl9cRhd5DcFv794uP3ydR2Wc13/0ChhTK83QxV4BFajRLr5Kh1nebJQKEyYIuXXTgslJKuW/iZ6BKk2m7w9NrxJlhMZ+bjpXhZP4DaGmkvs7TKrQgSZbMgu6yZi4tzu36ajxELiW4qWfzxNZGLlVRiFDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM5PR11MB1497.namprd11.prod.outlook.com (2603:10b6:4:c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 15:21:20 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%6]) with mapi id 15.20.5332.017; Thu, 30 Jun 2022
 15:21:20 +0000
Message-ID: <1aa52d6d-64ef-7c24-bdc9-f69344b433bd@intel.com>
Date:   Thu, 30 Jun 2022 17:21:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v2 61/63] PM: Use the enum req_op and blk_opf_t types
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-62-bvanassche@acm.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220629233145.2779494-62-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::17) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33970add-fbe2-4f6b-b386-08da5aac2f68
X-MS-TrafficTypeDiagnostic: DM5PR11MB1497:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HU3DdNrRVlc4fwa6x0XaTeFh8s9CcsarTqLFfaYS6RJFHhMbO/mCzvcPZ7DD8WcHmvHsMAw+U1dZewGSvo0uKyfkX7rzXHOiDuCpqZv1PHgSn+rpx9BZbK4LBnTpb+D73OYWvtTKtsUk5KwC1PGK4EMzAfAcMy+YrV6Ikzw/Q1xz3QuLC/eARcOIYHFhhFdO/DCDCYseLFUuQHvfJ3cQOZ9pXaFFFxzu0EXCg1VQRYodJIKYMibLFntMt39OK9Mtu5Cw0JHHxLuL+HQnPxX5MNMMJIgpJTz6dI1VpWVBmqEkcpQrShFXsjVNRqXPPnCKyo5XhHH5cZASpY6hudpFJS+ab1hzpxGBFzG/+rWIhw+e7cy2o4b9jhUYSrPrzF+7p1ze3oiy3b9HPd7YlAzCOROfrY4DNZLAoaLxxXsWahlGEwq9OOCR5AJzdcHq/Ve46tTt16YOanEp0VfQMSjmossVf4CRjhrCsdSWj8kRLfjjZcfNOtZqUhmmlnYy3A058bJ5MFaou5qkjovHZipdOu/YhpVl4o4yCMcnCeGiz8uOy6MTOtwVb61Aq4wZj3Pjaim39bzdjSTntWf/UxDFQE5KKzgUit7D4TlpSXej8idDysJANcHbFHJ4oZl9zgZwn1q+gNK7oj8Ma8dBLZfLQi0RJi0GJotddFHA8u9HwvDYLnAmUKiriCy/M94ABwEzEOjmnD+LUGuO1kNIiNKTpbpKaZUWnhCM4LJE9ak8taNSMGvP6nqy5u5HJAyTnoLWTwMqwepK2Uv0oI1yHa5VM2rvSRBIJKNDiP2SD5ln7QyRuiM5bNy3ls/jSJ7jyg4y++CQBUnUvkRNtESyE5Ak2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(136003)(376002)(396003)(8676002)(8936002)(26005)(53546011)(66556008)(66476007)(4326008)(316002)(36916002)(6512007)(82960400001)(66946007)(38100700002)(31696002)(5660300002)(186003)(83380400001)(86362001)(110136005)(36756003)(6506007)(41300700001)(31686004)(6486002)(2906002)(478600001)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBTaHNnRDZFbmVuenpITDQ1SllwbFQ1YWYyYko0QXh2Q01CQzVJNld3S2R5?=
 =?utf-8?B?V1k4WHJGZFFyS0FaTWJkN2xYUUJaNS9GMGZVZGZTOEM4OCtLM2N3ZUJHMnoy?=
 =?utf-8?B?bExNamxWeHE2TWxIU2FkNk1xNm9udk44UVNzSG56Qi91Ykl3VmZVZHh3VzdE?=
 =?utf-8?B?d0hCZnFWM0NMVmovTlpBK0JlZzQ2WksrMlBuNHhqZGlORGFiVEZsQjVlUUJt?=
 =?utf-8?B?YVlDaDYvOTE4bStpempuSGtNVkhybzFVU3RMUnFzbVc0enBzbG04SkUwM3Yy?=
 =?utf-8?B?emlvd2ppSExIT1J1bGNPVnZDMUJEY3hZZVJzNXpPUGp6Q2dkNVZwQ3FTNStT?=
 =?utf-8?B?VGxucWxyeWpTNHU1NUVwV2JNNFpYL1Jlem9jVXhRVGJDeThpZDROMFVsZVg1?=
 =?utf-8?B?dm5KeS9VZEhINTd0QVJkRkp2a0Q5d1RHVTRyZGRza0hhZXcyQzRTTCs1MnQw?=
 =?utf-8?B?STdXWVljb1liTjhpTUIrOCtWN1E1cXRwb3dFSEdZVHZRSjBiWXMxV2o1R0Jn?=
 =?utf-8?B?VENWSHJsZ28vOVVMbmxuOVpFYXFHM0hsWjcxbWtieW1GQ29yNXNiY3hMZXZq?=
 =?utf-8?B?UDNMa3diZUFRL0hWZU9YeVNZUFdtaVU4blp4QnExbzlJSUlkaU1aRS9HeUoy?=
 =?utf-8?B?ajdzUzNneGc2MkFEa0JIQlk5WTZhWEgwSUYrSjZBcVFUSDNEZXpkQjFIdGRW?=
 =?utf-8?B?M1pBZjI4NDFjdXVQMENjYUdGaSs5b0dZN2NRdzhoUmhjTGtVbk9kcFQzZ1kx?=
 =?utf-8?B?UURVWTR2RUxSS1gwVFYza29qTGVzaGpwRWV4aHJ5czR4QmFXK3VaMVNFSTRX?=
 =?utf-8?B?YXp3QjF5OWNWeE4yaEZZQlpUVFUxNmM3YnVvc1ZXeE5rQ2lhUjRtZ1JTNFU4?=
 =?utf-8?B?SjY5ZkJEcWU5Z3FUT291UUJ2WHhYNU5hamFRU1dSQTRaQjNKYmlyWHFIRDVW?=
 =?utf-8?B?VXJvaURYOFMxdUFqeWdBTGZGYzlxbW1vcHNTZDFFRkFNY0hNdXMrVE4wdGdj?=
 =?utf-8?B?ekhGUjBMQUZ6cWN0dFZaSGlhTEZmenhnOVJGb1hsRk9XZzRYU1cxY3QwdnRu?=
 =?utf-8?B?eHc5b2RYY1QzVDR2R0t5cCthVVErME5XZzdhQmR6TCsrZ3Z5MXJLOVNpbFJj?=
 =?utf-8?B?aDJSeVB3cDFQWW1tOGxMLzMyZHZDMW1td1AzUXJvNDVSU3NoNThTclRYQ05I?=
 =?utf-8?B?R0lsbjArVk9ZSjVaeEk3TFBPTTdDa3haMU53eTBKblRRMk93ckZMR3hWYXl5?=
 =?utf-8?B?YzI5a0cyVk5CankrT2pmWjdqd2drSld3Um1VZUlNSWlqRC9Wdi9ZcTdMVWpn?=
 =?utf-8?B?ZVhrSndkTUpnMVNndzhYWCt6Ny80LzcyZTA0MjhmUTgzNnVVMWl4SlM1Vzky?=
 =?utf-8?B?VFQvRzFuODJqRU8xZ0JQalJrMVovTklTblNtZWNLOVVFeWlSd2JGMkNiR3B5?=
 =?utf-8?B?ZzA2ckFabDQvNXdrL3J3cTZ5czlqdGRIdDJpTzNhaW1zQit6a0I4M3l2dkRD?=
 =?utf-8?B?eEpvMmhLR3k0RHZGaElqS1BuTkVlMUR4bFAreWhOUmZhS3BWQUxiL0FscXN6?=
 =?utf-8?B?TUhQQmhRZUJpSFg5NE9HOElIakRFdndQaGpkYVVZbk12Mmo3QUxRcjVxQTdh?=
 =?utf-8?B?cHFBSklKVzc1MTNFWGhHS3RMY3FIQzBkYzVGbURiWTJaeFhqeTZuUjVQQ3pF?=
 =?utf-8?B?ZWtpNjhjbzhQSHVBb0RBa0IvK2o1V00vTVM0M1VyUzJtVG01a1ZTY2p0d1NK?=
 =?utf-8?B?Y0Z2V2o1WEdUclREdkJDUjZXV0JSc1ExY1RHcUpPdDA3bUIyZ0YwNEpJUE0w?=
 =?utf-8?B?NUZGMUJ6MU1OYWRxTk5PK1k4bFdUVys5bVZLYWwrQTRGY0dlTjlkaURrc0tU?=
 =?utf-8?B?YlBTZ254dkV6RXlUUk5DeUVTdFJHU1FiTlJ5VzAreDFET1RWUGQ0elVuTER6?=
 =?utf-8?B?T2svc09Dd2tvQjdpNDg3UEpZdFJjUUdyQlVXbTVnSmF2TTZnSWhYNCs2WThk?=
 =?utf-8?B?OXFTNDlrNWdCVmZ1aStiOXdRNkxqQmxXa2JneXYwcXpGZUNpdzRQbHJydldE?=
 =?utf-8?B?WlZoYWRTdEJQbWpBWk5XT2hDQXArSnhTV0lQYzhobzRxU0FZWms1dG9QeVlx?=
 =?utf-8?B?NHlsTExQNjAydm5vVXpITzBhR1c3ZTl4ekFGQlJ2dmFnT1dodHNZZGlodnpY?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33970add-fbe2-4f6b-b386-08da5aac2f68
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:21:20.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnD9ic/TtDd4kkYOc22DVoWv8aenoHsWgxwEdLTkaFzYGMR9D+elAjlJ9blInSjkz3zxdac8l3rYIL0GHgBIr5EAjayEeWcqPr0vYKoezys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1497
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/2022 1:31 AM, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags. Combine the first two
> hib_submit_io() arguments into a single argument.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   kernel/power/swap.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 91fffdd2c7fb..277434b6c0bf 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -269,15 +269,14 @@ static void hib_end_io(struct bio *bio)
>   	bio_put(bio);
>   }
>   
> -static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
> -		struct hib_bio_batch *hb)
> +static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
> +			 struct hib_bio_batch *hb)
>   {
>   	struct page *page = virt_to_page(addr);
>   	struct bio *bio;
>   	int error = 0;
>   
> -	bio = bio_alloc(hib_resume_bdev, 1, op | op_flags,
> -			GFP_NOIO | __GFP_HIGH);
> +	bio = bio_alloc(hib_resume_bdev, 1, opf, GFP_NOIO | __GFP_HIGH);
>   	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
>   
>   	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
> @@ -317,8 +316,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>   {
>   	int error;
>   
> -	hib_submit_io(REQ_OP_READ, 0, swsusp_resume_block,
> -		      swsusp_header, NULL);
> +	hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header, NULL);
>   	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
>   	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
>   		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
> @@ -331,7 +329,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>   		swsusp_header->flags = flags;
>   		if (flags & SF_CRC32_MODE)
>   			swsusp_header->crc32 = handle->crc32;
> -		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
> +		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
>   				      swsusp_resume_block, swsusp_header, NULL);
>   	} else {
>   		pr_err("Swap header not found!\n");
> @@ -408,7 +406,7 @@ static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
>   	} else {
>   		src = buf;
>   	}
> -	return hib_submit_io(REQ_OP_WRITE, REQ_SYNC, offset, src, hb);
> +	return hib_submit_io(REQ_OP_WRITE | REQ_SYNC, offset, src, hb);
>   }
>   
>   static void release_swap_writer(struct swap_map_handle *handle)
> @@ -1003,7 +1001,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
>   			return -ENOMEM;
>   		}
>   
> -		error = hib_submit_io(REQ_OP_READ, 0, offset, tmp->map, NULL);
> +		error = hib_submit_io(REQ_OP_READ, offset, tmp->map, NULL);
>   		if (error) {
>   			release_swap_reader(handle);
>   			return error;
> @@ -1027,7 +1025,7 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
>   	offset = handle->cur->entries[handle->k];
>   	if (!offset)
>   		return -EFAULT;
> -	error = hib_submit_io(REQ_OP_READ, 0, offset, buf, hb);
> +	error = hib_submit_io(REQ_OP_READ, offset, buf, hb);
>   	if (error)
>   		return error;
>   	if (++handle->k >= MAP_PAGE_ENTRIES) {
> @@ -1526,8 +1524,7 @@ int swsusp_check(void)
>   	if (!IS_ERR(hib_resume_bdev)) {
>   		set_blocksize(hib_resume_bdev, PAGE_SIZE);
>   		clear_page(swsusp_header);
> -		error = hib_submit_io(REQ_OP_READ, 0,
> -					swsusp_resume_block,
> +		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
>   					swsusp_header, NULL);
>   		if (error)
>   			goto put;
> @@ -1535,7 +1532,7 @@ int swsusp_check(void)
>   		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
>   			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
>   			/* Reset swap signature now */
> -			error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
> +			error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
>   						swsusp_resume_block,
>   						swsusp_header, NULL);
>   		} else {
> @@ -1586,11 +1583,11 @@ int swsusp_unmark(void)
>   {
>   	int error;
>   
> -	hib_submit_io(REQ_OP_READ, 0, swsusp_resume_block,
> -		      swsusp_header, NULL);
> +	hib_submit_io(REQ_OP_READ, swsusp_resume_block,
> +			swsusp_header, NULL);
>   	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
>   		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
> -		error = hib_submit_io(REQ_OP_WRITE, REQ_SYNC,
> +		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
>   					swsusp_resume_block,
>   					swsusp_header, NULL);
>   	} else {


