Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E00C43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 13:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiF0NFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbiF0NFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 09:05:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C6F101F6
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656335096; x=1687871096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t7yj/F7wP/qRzygIThoCdmqtcSWFRaBRQIS8UMZP9is=;
  b=KhS2H43I4omF5aGo3upcwuCmdgjU3qNbvqFNhW1BjJSZHisGBdBzdzIZ
   rgSUN7DlNA9VdgZmc3LhYhQtJBQOYtjNfyNt6Vq6Edri/c3cAQqRB9FWe
   QwMDh/xiLbRUnseQQTHphvlUpk5xfw21HkO0sj6pplTqyBtIeQ5aXEUOt
   +50uNIHshfreSxyqUjL3sFabwDcpiqwVdmRyCli5DCBpQOo/vhnEh31cG
   6ZNNxy+aPFGmj0IlfOG1ro0KJIgT6tNWZ2iYBTNdForUeLGjM/Y83/SuR
   okc1FADZpprNxtcyGeIZuEmxrQQXYBj8PicARScQDlIUTFOfIIlko6mf9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345443509"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="345443509"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 06:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="766666352"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 27 Jun 2022 06:04:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 06:04:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 06:04:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 06:04:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB+bk6rJT5Zw2AApuDowrYVJM3PoLo6cKchc50/mOZZ3zp4pzGuVYAYIqOCpvCd3Xwer/HgQz+qhW57cUYHi9RWh7vtrWmBasweroZGdhKQGEJeYRHmf80dnQffvu37TUeXtfwrSmnnGThe738tDAAoENru0JGW+nNWx4Zsm8rFTqtCvVm7Iq2jFQiHgvUqQT7e/365CYKorGJtfCex0ZlSkXzO7+iah60iYWK7lVb+sNH0oUmiH3Y39LWVgOljtkCPrRjgZZ0yasezwm3qLISZSByrXqkdQK72JwtidtqZN+GgKEc/YE/XEhLYubDrXKpZrP87rBD8+ksdT/9szrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1/Q62f9nwNoRIEmLikHweKsQVqAwq0j0/7kgYjP97Y=;
 b=JAJBHaWx+D/YmFlr7DhRMB4M1EcdgIznzW5JZFDaZ8ZfrjV/S61yYSTmn6KYhJG5HU4AUIN2BrLP3vxdQRHf9kOZWz4vY8RKNdoi3VjUteoLGLxxKl+N+HSYWP7gduUZpkmYwUlGKhB5UierhbX6zn1uesC67II3j+DzazxLNDk7+prLiChpfu63oCq3IK7/7bvPHSos2Y/c66ewrqmbR0LzEzgdAHYT388zxjTzbksfX8aFKdZco2Syos061OHcfRk+DJsMA7+ExMx4Mx7qp2uS5ZcAuc3LTlUzKA5Iu+Bzkb9peE/oGJNonBrj5mPRseR8wzrtAkPnw5kRGNwsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM6PR11MB4156.namprd11.prod.outlook.com (2603:10b6:5:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 13:04:46 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%6]) with mapi id 15.20.5332.017; Mon, 27 Jun 2022
 13:04:46 +0000
Message-ID: <3ced687a-4308-aff6-4bc2-3f604d98fda2@intel.com>
Date:   Mon, 27 Jun 2022 15:04:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH 49/51] PM: Use the enum req_op and blk_opf_t types
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-50-bvanassche@acm.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220623180528.3595304-50-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::11)
 To MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 497bf5e3-b419-49f5-d20f-08da583d9bda
X-MS-TrafficTypeDiagnostic: DM6PR11MB4156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZh0wnBuHB1rwCIl031usyKvvWcw7FhmQENMFWJTQ2DmjQ8N/KfoWDsZeYzJj1EHeJMNc2I8Vdo3/tLZdrYGjj/cnz726FmGKMhCK/52dJPh9goU7q3CP+6uXtLNY0rTAJ/3uv87pR2rIJlvbrUIWtPqv1Z+FFloGM2NT0oj90sD5MT+AvrPcpJ6xCwEnjRXkXstSGgR+vNQ85ZicHCNoPFNLV2qsUzAXLYssQ/OtbporoggM3zgbGWruh9Xx5gJnYJLVN4o/2DF/zK7wP1cFXRu8i7pNbEa7z/X2d56ni2ZGOnknNx+1qDyMmJjVRlH6WkEO4uDjT/VIZnirFqwv5ed1PzewI3/6QoJvOOSNd9Hkzi5xuWdANWvAwHLCZOv0vPlb1Ggvg19y+sVTBF21x3nT9EYpieWSmv17DhJwqmmjcL3kCjJxAWtUPrC1q4f8pv125b6NKOXHzaQhMfpEReaf/80yVXz2/b0aUU5sB94Y1OR0EwDfZRyK9XS2BSUnLNQfz6PI+LX1DXHvUXXbSomM7D9zR29b1tKQkq+b5QUmo67Pez4Ss0Z95e/RzXh34Y7Q2m/ac6FC1Ma0TPA27cu5HGA68e8cx3h+gki4tcCV6dN3zV842KBDyU4pURGp/ytTuuhJL6uykzcgUQFjdDr62HarNZHANA18OlTyMkpIk5QtHtxMZLg0+4dG0/RNoJIOuElmYY3+h95sSBKiL9tA1MJhz0LqNZLD14VVqkHnCLuZvfyN3vJqilw9ZoOUid6VdOLw1PH5qkx3DPGyAMVSYuVWejifGOCjQYbgNgbwvx8U6ikivcMAYSLF259
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(136003)(39860400002)(36916002)(83380400001)(6666004)(26005)(2616005)(6506007)(41300700001)(53546011)(31696002)(8676002)(186003)(6512007)(316002)(82960400001)(5660300002)(8936002)(31686004)(4326008)(36756003)(110136005)(38100700002)(2906002)(66476007)(6486002)(478600001)(66556008)(86362001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWUvYUMyWVU5ZkV3RWxuVUlFcExnUTk5TVQwMTE0U1dtMjJxNEZ3VVl5dHJI?=
 =?utf-8?B?K1BwMi9kZjdHR1F6K0NhSjU4YkZGMko4c3hRR3lEWmNRUVNad0lNcDVmWUJI?=
 =?utf-8?B?cTVkT09CZjB4Z25LT3hEbldWL3dBcHBCYjFlZVVCUGJjc0FxUjBLdHZKMGpy?=
 =?utf-8?B?NStGaXA4cHdncTYwRjdnS2dUeXZ4R1k3c1NYUG42cE04aUJQNTJCcXFJZVhE?=
 =?utf-8?B?ZWQ3Z3BZbUFzOHJJek9XMkxHNHFXYjBLcVYzditIVnI3cjR1dy9DNm5SYi9M?=
 =?utf-8?B?ZldJKzFLbFlDaGoybThId09VQVgvbFZRb201bmxlcDBGVHFKUUFkcEd3MGh2?=
 =?utf-8?B?a3hDTkdBditDQ2s1RVY5Q1ZJRE44NlVQVURJNUpTSVdrUkdva3d0MkNXZ2hp?=
 =?utf-8?B?WlU3YkxqOTJITGFKUW11RjJuZnBNcDRzR3hpUVg1NEhxWTk4cWtUY244RjV1?=
 =?utf-8?B?QXRLbmZXeGJ3cWw3Y0pZOE5ISTF5L2diNHdWRmxiMEdmNERQcHZFWWhnam5z?=
 =?utf-8?B?WWhibmVUbEp2akh3ZDQ2TW5aTlpFR09DQVhEVGI2dHl5QUxpSHpkMTU4LzMr?=
 =?utf-8?B?Nms0TTQ1bXhZbGFmb01KZkV2VkFBblFmdUljTy9EY0hRUjhWUWlFUjNTTjZx?=
 =?utf-8?B?c0tJWEJ2WmFBYk5rSW9HUmU2c1VOMlBvNU1yWFN4R3RWT0tkcEFyd2Fid2VI?=
 =?utf-8?B?SEpENDBHTjByUzRtQ2tUMVJ2TzRIWjBwMHNnNlRSdW9SQXZuM0NNSEw3N3U0?=
 =?utf-8?B?cmVZSlJUQ2xSM3gzTGdKV0s5YUpQbXhaeno5NStCUG9YUnJZYmYrb05uZE8x?=
 =?utf-8?B?Q2F2T2hpZWd5b3doanp0UXE4R012M1A2RG44OG10QWo2VUNRNVdJUFhxVzdy?=
 =?utf-8?B?MFltM0E4RkFJcmZxRGtaZWtTaVJZMkdzeE9uM1lxN01KVDF1MTZ4NVRuK3NK?=
 =?utf-8?B?TUdFKzZySCsxZFBaMUlBSXgrRlNGbUZRak42blE0MHI0RytvVFF4dU55dk03?=
 =?utf-8?B?bUIvMWszRkFFakUzb0phVk9WcGU3ZGNqaEV3Ymc5UFVVZWV3N0tPdGVPYUNj?=
 =?utf-8?B?ZkdYdHk1aTJvVTUyL2hyczBFdkhEaVBxWkRnSyt4YU0vcWo2TEJYUEUxUUo0?=
 =?utf-8?B?V214TzRXbUwvREdqMTJjaHA4NUVvYTRDTUwwRjBkdERFM0xIbWI3Qm1QcmxC?=
 =?utf-8?B?R1g3YmVWL1N1eEhJY2FUM3RFbDhIZFkzNHhEN3JPaG5zWkV5dnVoaGJkKzBm?=
 =?utf-8?B?YTEyT2p2N1QyaUFjVGxJMHFSWTZldGlMODFOcVRSUmFzcVZhL1BLNjVjMGZZ?=
 =?utf-8?B?T285T2hjNFJFb29razJJNUFhVjMwaEhzNkxwVWFNY3NnYnNLRk02WnZ5ZS9T?=
 =?utf-8?B?S3pEdUtMT0tUSmQzcUNUYjg1NTBBb0x0UURyZkRNL3lkRis3QjVrMFhiVkhy?=
 =?utf-8?B?dDc4dVJ0b0ZSbzNtR2wyN21jZGt1Nk1RTnA0NEl1UEVJWGJrbDIwNXlodHcz?=
 =?utf-8?B?RlFmRnRWL0czVFcvUmpHMGxVUTAvMDNCU1BKcGEzQW5jdkNUQ2V0YWQ0eGpS?=
 =?utf-8?B?cklpUldUUTRHK2d5NHJoR2I1QkpVU01RQ0dHSlN5MXJCVk1tdk5lNEFobzJR?=
 =?utf-8?B?aS9RNTdnQ2Z4dkFzZ1FNVUN3RVRFTHhCT3YxT1JaZ25PcmFlQ3VMOWdYZzZq?=
 =?utf-8?B?VmVYK1V4bi8rSUFHYVl5eHpGZ0tjOU9pU05ZWHJ1SmNzWUc5K1d0KzlFQ1ho?=
 =?utf-8?B?ZEU1ayttS0hDZ0hFWDMxcndhZHR4YUhnN2txdFpreFNBbmlQV1k0N2ZYWDI2?=
 =?utf-8?B?WDZybGUvYVpCdldiK01HcDNwSHBITGtoYVRrYjQ0dHp5d2ZialVUYlI0MXVK?=
 =?utf-8?B?YmFXT25UZXBzNm1WaXZ4N3BVdm8xQXZkWWFJakZLbzRCVVhrSG9PZVQxSlFY?=
 =?utf-8?B?eXUxME1sZ3ZONGFQVEExcmhFYVpHa2RVc0JaNFlhT1JkRDBjcFRWVE4wNGpR?=
 =?utf-8?B?VVpEemhUNVRDVG9rckxRbkpYU3prQzlORDd5NlU0dnA1QzVmMmRKRGpZcW5D?=
 =?utf-8?B?V1YvMXRvN1IwbjZMMnR5L1dnYWx3dFNvVzNBVmp0ajUvQmZpOFVuZE5SWUdj?=
 =?utf-8?B?Z2lJRjREcDBnUmpRbnV3VmFIQzRrL1RvcnNqNG1ZM3FJeXg2QkFxOEE1TFdK?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 497bf5e3-b419-49f5-d20f-08da583d9bda
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 13:04:46.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aoo27IMuQxhm5JXa4wr9raTlLO0yF2GGN+OxQEibQ/ykbyQHDD92Wt2AG8WHc4ZDRIXL+w4Q+HO36rQiUV+FPLoPatAuYlTnXD7RgcnpW0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4156
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/2022 8:05 PM, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or if you want me to pick it up, please resend it with a CC to 
linux-pm@vger.kernel.org.

Thanks!


> ---
>   kernel/power/swap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 91fffdd2c7fb..db01cac40a4c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -269,8 +269,8 @@ static void hib_end_io(struct bio *bio)
>   	bio_put(bio);
>   }
>   
> -static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
> -		struct hib_bio_batch *hb)
> +static int hib_submit_io(enum req_op op, blk_opf_t op_flags,
> +			 pgoff_t page_off, void *addr, struct hib_bio_batch *hb)
>   {
>   	struct page *page = virt_to_page(addr);
>   	struct bio *bio;


