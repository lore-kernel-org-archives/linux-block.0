Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C72C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9499E613CC
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhEYTNa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 15:13:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34522 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 15:13:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ4bti181480;
        Tue, 25 May 2021 19:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pkZJbzFZ+qDHDG3v9wYENZaC930Hrz5HNLmSQv1F5C8=;
 b=cVzIVY+Gkj8e1AceIVji4UHlA77hE3enzscBb7oiRhpuPuIShtMEJzrjR0LB9Mqe+d8+
 xJ0o77KYlP4a4XuNi4pklA42jG+BJARQ2fRAUsdtqx3qOnKxtEHbzBAI4cIrL2n726Y8
 DO0U+qhueTCejqUv4glTjm/zh5hDay8zDBXtMm4K5+ecQczRzMmaHpXkUz6/uJyC/EH9
 Vb3Ea5kbuOeM1F4+Sjbc9wL8yctHbLWF/Tg0d8w8TWOJV7hPZ9dPT7F08fOF+7ftFdR5
 +PNCxmSTFa27xO6FU+0COd5U/zio6p/dVgHsqZjfzzwG9Bgbqw7PNbijESUjiaMAURcO zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38pqfcf3dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:11:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ656m016122;
        Tue, 25 May 2021 19:11:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 38pr0c283p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:11:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz9u1l1U3S5X085vwEbs6dfg9KakBN3xgSWJsVOsgWREq0KmTyzOv45++OUsjxb6PbphU7wUXDPrz4Gsp51F63oKLzIvX4pH6QZRcLP+OmEfSzt2dlXFOkL/sNUX7kCtoSvfS5m1DUJpNqghqaIwMwVckQfwidSO7DxTcHqv4pbpcO5+dMVxpQn59QJI1Mg1YSek/DcIjz5MHlJG0Y/3snVCydZ+by8moj1LDKzqTsarCeQ1tZnPBcIsDWeVc7rKJEcCS/TaYZYId5ayMfSAqLwB8QAmh9QXkyro1iH5zxDIz+yEDktFVcxEPJMqiAUwnzQJrGc4zOuX72lZ19xFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkZJbzFZ+qDHDG3v9wYENZaC930Hrz5HNLmSQv1F5C8=;
 b=nViJ6+e0ZVRznMbEPfCIQ/HDpkG/UWFJGUO5kLXth4WOFZ3wgkIDHHtPP4Ax+SHS3Ys6K8Y7UtXaOZFaMKt8aCBdhYCfWMPwbkKqVxVMQ0qQDzen7gTw4TBKPF6Fuw9tgNlhzYwnj3uBEUUzpK9k2EYMai0QR41nzTOkaWpl+flTp1mbE6T4eS8zRH7+5CgTE2fdXp+Ph0vZB/FCLj9LfHAQIUslMaB3/HXHjnD+8oEgf1GcMcyVzJVdufvrH6N6br+5uxbC9tELi5cbXs4OqmKL3E5s16AXEUzcUOlGSiwVHXzsJ6PJZ0HMryBk5yPwBGKcmZJnjan4uToHYFl5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkZJbzFZ+qDHDG3v9wYENZaC930Hrz5HNLmSQv1F5C8=;
 b=jNjd0M6nKNJ99icxFdc2Ko9snwpXhoozqePbUCRaPlnxX+tJ/jPdshcf/K+f2dP4tRSApHGYSf+y5WDHaIEUsAR3xNu4FnGPTKa32M1GBLz/Nw0cqHERyq+TBlx8SK2ic9jCzCBCkXixyBxh4pgXITE0MoBmiAFYWaYk6W+00No=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 19:11:55 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:11:55 +0000
Subject: Re: [PATCH v4 07/11] dm: Introduce dm_report_zones()
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-8-damien.lemoal@wdc.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <a920d481-6a0d-3951-2732-abd3287ae533@oracle.com>
Date:   Tue, 25 May 2021 14:11:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210525022539.119661-8-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SA9PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:806:28::7) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SA9PR13CA0152.namprd13.prod.outlook.com (2603:10b6:806:28::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 19:11:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b966860-7f93-4cc8-126c-08d91fb0f5f0
X-MS-TrafficTypeDiagnostic: SA2PR10MB4683:
X-Microsoft-Antispam-PRVS: <SA2PR10MB46830BF160FA50EEA3E40D9AE6259@SA2PR10MB4683.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TlXyovqPVh9EH+A7FKtgjLvdVBtQ7rAKiA36ooy08rgPEwXSs1u1fpYgliI/VcbFWAXc4AyUZckLMjY1SrtnkpC5CLWnDsd0RCNa+qgXzV2F4FCjl4uXRP7k8ZXzXdQPaazGn0QhzLrczPFi++oHw1lQ6IYT9DnNEOqpY9czTjvFEOmRs49qo/2MSSFg+i2WjycYLHVd+jUgdOh9pSe4XX1MdJLdudJ5kHvM2rwdvbfOL+MTlDqzBq13txJPvhr7bNpMYOkrNxZO59l920JzmJuMH5fl3rAwRWq8f+5jOuSNRw1H+3+IqLVgxyNeRFn6PViOkmTVLHYAgg54jkAsBQacLBxOyzG4mAq3WrxxkzUA0KLBo21DtzSPICDMW16T5cMezXOLNM5F69rhZDWbT7ApwpVTZw8x/ZL/a998GSTJoy7oNdah8FNKc1FnprS8ZQ4EZEL/n0n5y3gLpqTu904xxRdvAz6o4RcHa9ZdY1sHkKsze00srFkm8TwUHEXeByArLFxtiQar0Wmxhkb7bpd3YHyTFW8qR+cexq2S4SVJ/6EseErNnqYR1Mt0v/hqn9Ue9VexxCky6LroKtBlabHuj9n5yKwpiFNyxWRF9LTrqZrBi0lP12CUM8WhnjZttFL2SFGooRQ0MQNPjim9Jr0Pj0U6rKm79x1oFDWIZXAhbOTATU7REgBLiJ683LdQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(66556008)(66476007)(66946007)(110136005)(26005)(8676002)(31696002)(83380400001)(5660300002)(38100700002)(86362001)(36916002)(53546011)(956004)(2906002)(2616005)(16576012)(31686004)(44832011)(16526019)(478600001)(36756003)(186003)(6486002)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Tm5ER1FKZTh0cnRFVFkyM1M4RXJUT210czFKWjA1MUtzZ09URXVZTUQvMXFB?=
 =?utf-8?B?TE9zZ3Y4Y0wrSVJDK3g0OVJ4WWMycis2SXZqTGxxamI5TDRtc1lManNPL2lJ?=
 =?utf-8?B?MkNTVkovaGh6SU5xK0sySjdZNGJ4OVdLNkhVSXJjWlZIenFyaHg5bEtjRDEw?=
 =?utf-8?B?c1NNVEFHMFJJaWM3M21Sdy9QRXpWSzg2REhYYkE3c2F6STJTaHVadGtSbEdr?=
 =?utf-8?B?dnVrQytqWFNtYk13U2Z1SVpON3Rpdmwvb2tpWEVrSDZ4QnlLU044ZkR5VXZK?=
 =?utf-8?B?OXBrZnpzR1BlcC9WVTZDSm04dkVucmRrVUFOY0JuYjBzQWNLSUxhaGhHamky?=
 =?utf-8?B?VjdVYzYwTTRnaTlPcDZFZ2VuOWdBVUFQOFEyVGFnZEF2WkxjYjVIQjYzbU5J?=
 =?utf-8?B?d1J4bGh1eEVwQ1crSHFRREVTOHlMRVJSNTh4dnNGc3BVaEJieUFHcFdGMWNO?=
 =?utf-8?B?dlhCdXU1aVlrSkZqSFR4NFdJaUhlRG15U0VDSjFwdnBEM2FhQVk5NWZFdUlN?=
 =?utf-8?B?SWVjSTlBS24wSjhkRHVsRUFNazJZWlBqZGViWjV2Rk14TFdaSnBLRjI4bm45?=
 =?utf-8?B?d3lDSHRUQWgyMmU5L0sybGt6Y2lhdE9OVVNRa3YwS2FxYjY5L0xFTXJVd2kx?=
 =?utf-8?B?U3RFRGFvS1ZTem1VOTh2T0Vrbm9GS09RY05PcTdtSHA1UUFkL3dUaGJRck1C?=
 =?utf-8?B?RlFmNlN1MFhvZHVUd2RJeVUwR0JZYU1PajN2a1kxckNNV1RBNXNRWFIvc2V3?=
 =?utf-8?B?SDcwYTVqb2x0eU5iUSs4YXZNd0lGeG8zekF6TjdlNjFjRnYvUEpTNU8wbnI0?=
 =?utf-8?B?MTQzNXJTZ0NyUGFrVjFKbTVsUEVWMWVWT2ptZk1JN3NXUURDNXpleVNEQUpI?=
 =?utf-8?B?eTdLZjYvbGF2MGVrMHQ2eEkybEo1VHNtcTBRdXYzQ0FDeUpEMzR6aW5HM1lG?=
 =?utf-8?B?dkYrZUZyOGJTZDBUTzY4ZDRKV0NoMDFOT2p0NGtwTnJMS3c4dTZFVDhmNm1r?=
 =?utf-8?B?VkJwblgzdnZENUlYWitkeHg4SGRLY2tEb3Y0RHRFYlRBMnk1ZzN4Wk5Ralg0?=
 =?utf-8?B?cHFidU5oU0I5VWlLMlRFNFB6QmpaM2xFMEpNeVNmWlVtNDNOZEJOM3Rjd1U1?=
 =?utf-8?B?QzNBbnVpcUxRS2poWTNOWlZxeEJCMkZ3bkF2Y3liTnRtbWNwdjFzeUM2cTNx?=
 =?utf-8?B?bjZxL0ZOZkFRNzZxdFVxdGh2eEFxNFBUc2QwdjFPMFVrZjZZaHd3b1B4czEw?=
 =?utf-8?B?Ty9BMHlNWnl4ZndzVllQNFUyQmxpTE9KQ1lJazZVaGxPaStHSURqbmRqWWRO?=
 =?utf-8?B?QUxuNExXUXdUREorTm5VMDhiUWZzQ3ZIaTl2eFVhWjV3aHprU2dNZHVGU0l1?=
 =?utf-8?B?YTV2alBoeElNLzkwQTJZME9TUDRHaytwdVZETVpwaUhQeDBJcUZSS3MxOWdZ?=
 =?utf-8?B?cnROaE5wRnE2TC9iMEdDTWpHNU9qbytEWTgzY1RnY3lyWTMranc4M0N6V3Uv?=
 =?utf-8?B?L2dVTHhUZUtNRTRzRXk4R3NrSWNiWDN1OHovWFVaVlhFRThiMVdXUXkxV1NY?=
 =?utf-8?B?aXkxVmZ0QUkxeUZ5QWgrR2Q0eUMyWi9mWTlhOFJ4YnkwdHM2SmpuUklhTHUv?=
 =?utf-8?B?enRjRG0rTU50cUZTZWdMdGRId25MaENtLzJvUXNodkxaT200YXJFdzBhczBK?=
 =?utf-8?B?UjBoZEFjWE5RbzhzL1lyaWlHcEJ3SVpBblhIRXpaZTJyU0ZpR25VUVhuLzRk?=
 =?utf-8?Q?U4fi/dOTQA0K9cZOjjpz9YixxK1QRwloKhMEJa5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b966860-7f93-4cc8-126c-08d91fb0f5f0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:11:55.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQt+vP1xP93lmzFtPg8yRxHPdWcQy9xfTjV6xVnUlvoUv/xt9rOKHFvngV0lTrOwmTI49E+UccJe7Ynf1uyPzjuOtLFf4N5eSYNB92noNV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
X-Proofpoint-ORIG-GUID: AhDTuChmC0hIhr2fWgW2EB-Bd6BWutR3
X-Proofpoint-GUID: AhDTuChmC0hIhr2fWgW2EB-Bd6BWutR3
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/24/21 9:25 PM, Damien Le Moal wrote:
> To simplify the implementation of the report_zones operation of a zoned
> target, introduce the function dm_report_zones() to set a target
> mapping start sector in struct dm_report_zones_args and call
> blkdev_report_zones(). This new function is exported and the report
> zones callback function dm_report_zones_cb() is not.
> 
> dm-linear, dm-flakey and dm-crypt are modified to use dm_report_zones().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/md/dm-crypt.c         |  7 +++----
>   drivers/md/dm-flakey.c        |  7 +++----
>   drivers/md/dm-linear.c        |  7 +++----
>   drivers/md/dm-zone.c          | 23 ++++++++++++++++++++---
>   include/linux/device-mapper.h |  3 ++-
>   5 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index b0ab080f2567..f410ceee51d7 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -3138,11 +3138,10 @@ static int crypt_report_zones(struct dm_target *ti,
>   		struct dm_report_zones_args *args, unsigned int nr_zones)
>   {
>   	struct crypt_config *cc = ti->private;
> -	sector_t sector = cc->start + dm_target_offset(ti, args->next_sector);
>   
> -	args->start = cc->start;
> -	return blkdev_report_zones(cc->dev->bdev, sector, nr_zones,
> -				   dm_report_zones_cb, args);
> +	return dm_report_zones(cc->dev->bdev, cc->start,
> +			cc->start + dm_target_offset(ti, args->next_sector),
> +			args, nr_zones);
>   }
>   #else
>   #define crypt_report_zones NULL
> diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
> index b7fee9936f05..5877220c01ed 100644
> --- a/drivers/md/dm-flakey.c
> +++ b/drivers/md/dm-flakey.c
> @@ -463,11 +463,10 @@ static int flakey_report_zones(struct dm_target *ti,
>   		struct dm_report_zones_args *args, unsigned int nr_zones)
>   {
>   	struct flakey_c *fc = ti->private;
> -	sector_t sector = flakey_map_sector(ti, args->next_sector);
>   
> -	args->start = fc->start;
> -	return blkdev_report_zones(fc->dev->bdev, sector, nr_zones,
> -				   dm_report_zones_cb, args);
> +	return dm_report_zones(fc->dev->bdev, fc->start,
> +			       flakey_map_sector(ti, args->next_sector),
> +			       args, nr_zones);
>   }
>   #else
>   #define flakey_report_zones NULL
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 92db0f5e7f28..c91f1e2e2f65 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -140,11 +140,10 @@ static int linear_report_zones(struct dm_target *ti,
>   		struct dm_report_zones_args *args, unsigned int nr_zones)
>   {
>   	struct linear_c *lc = ti->private;
> -	sector_t sector = linear_map_sector(ti, args->next_sector);
>   
> -	args->start = lc->start;
> -	return blkdev_report_zones(lc->dev->bdev, sector, nr_zones,
> -				   dm_report_zones_cb, args);
> +	return dm_report_zones(lc->dev->bdev, lc->start,
> +			       linear_map_sector(ti, args->next_sector),
> +			       args, nr_zones);
>   }
>   #else
>   #define linear_report_zones NULL
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3243c42b7951..b42474043249 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -56,7 +56,8 @@ int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
>   	return ret;
>   }
>   
> -int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
> +static int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx,
> +			      void *data)
>   {
>   	struct dm_report_zones_args *args = data;
>   	sector_t sector_diff = args->tgt->begin - args->start;
> @@ -84,7 +85,24 @@ int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
>   	args->next_sector = zone->start + zone->len;
>   	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
>   }
> -EXPORT_SYMBOL_GPL(dm_report_zones_cb);
> +
> +/*
> + * Helper for drivers of zoned targets to implement struct target_type
> + * report_zones operation.
> + */
> +int dm_report_zones(struct block_device *bdev, sector_t start, sector_t sector,
> +		    struct dm_report_zones_args *args, unsigned int nr_zones)
> +{
> +	/*
> +	 * Set the target mapping start sector first so that
> +	 * dm_report_zones_cb() can correctly remap zone information.
> +	 */
> +	args->start = start;
> +
> +	return blkdev_report_zones(bdev, sector, nr_zones,
> +				   dm_report_zones_cb, args);
> +}
> +EXPORT_SYMBOL_GPL(dm_report_zones);
>   
>   void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>   {
> @@ -99,4 +117,3 @@ void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>   	WARN_ON_ONCE(queue_is_mq(q));
>   	q->nr_zones = blkdev_nr_zones(t->md->disk);
>   }
> -
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index ff700fb6ce1d..caea0a079d2d 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -478,7 +478,8 @@ struct dm_report_zones_args {
>   	/* must be filled by ->report_zones before calling dm_report_zones_cb */
>   	sector_t start;
>   };
> -int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data);
> +int dm_report_zones(struct block_device *bdev, sector_t start, sector_t sector,
> +		    struct dm_report_zones_args *args, unsigned int nr_zones);
>   #endif /* CONFIG_BLK_DEV_ZONED */
>   
>   /*
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
