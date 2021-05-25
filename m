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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F227C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E2B613A9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhEYTKz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 15:10:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50260 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTKz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 15:10:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ5tI5179139;
        Tue, 25 May 2021 19:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=sE4HPoVmP4VTi62fCWTy1GFJFb9s9oaNciYsK7NhYHw=;
 b=OmPJTwwBm+Ag+X+DB1d3LgQb9AD+bVXdcUp+luMZjKqAOEpe1c7hofDDkutjqbN4Gko+
 bFJt2bGfL4Wndd+3rVYar2g+IsG2Ia6aqY7pgYYQ6duFiED6KRi6NlF4fZ6U89VwvLny
 D87cXZvIVnFdrxyW17e1gf7jewJlcaMtmB8BidElfQuzHQjqyjkSZsX7F1nPnJSb9P+C
 u1d9v1ZbZImnCgog4xLguAsHPh1dRexTKr8Pko8Q5NloTHctmupG2cUKlcpuuR1afPLh
 L2r+QFLRTek1NtsoititMH/jRv/HgIG4ki9AAXY0YXto2iF29B0IsT5R1svQbfFMbmsT VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38q3q8xge7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:09:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ5GJu009027;
        Tue, 25 May 2021 19:09:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 38pq2ugqa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iasqhoGLqgLlCbFawYYvQo1Mof3up5XF5/K9bBqtEj8amyn/WHCB+emYRsF1aLW7aGxcNl8m607cI18B6BIkvmQQCuJuStPP0r/Kr7X7fqNVBMxOvltSS7N04VCzyZ8XUqBY/SI025af7w4x/3o/rp6EfuvMHV89fH+ih92h+ht5h1Ps+m3tF77IwBk3ZvyfL2KXbBDdGe1kvbW4ec8MyaaXZwr/i5M9HhirMuSPXOzQdykbkKAuTJ+HbdEmqAJlEoNuxEcsxGPx4NbtSDqnT5M168/vdkse+IOf54NwzrrpjiJccl9Dz2A2UwYgnL53BlHNajpfpL90uR9tZ2jhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE4HPoVmP4VTi62fCWTy1GFJFb9s9oaNciYsK7NhYHw=;
 b=YpIuAlO5FZcPXZnOJXS9MJBmgNzI0yx1YPHqwLO8kDfYePkThHxbhx+Os1Dhk21RxwnYMhwvOqUIB/SUodLFYruDy+MkWXaxFJcEuLrhJ8NhPBs4bS0VnMLZbP2kuASBENQv8Wd9XlVf1UkQBXtTRm1BmfYMZvQ+sLnoyucnYQSOTcuFJEGuJqdBW6RNZVHBbwFS10wpjrR7ejFiquXlkf9tkzcN6g7AyoBTZWOar23WYpUdXSvz/O3zMlc6bxvRALYosUx3pE3+gnKCef5n3wK5yGQ/5pnkesbdw/1yK4+46jLdkEi7BFqXi5TNn1JKwDU3hdERtAJKoYk2pRLr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE4HPoVmP4VTi62fCWTy1GFJFb9s9oaNciYsK7NhYHw=;
 b=HySYz/nkPueVVGDwjcHb1wC/uyoI1OfQNARUMKss8gdCpfWllzj4MfAIchVMjH7yzrryQEkXgk8YfMKxif7Wvd+vHzDHBBewdGJiF3S7riYEPXsAqc1ZxVt2lPUx/Vo46Vw9sA14t0T/1DgpVzPnjQWFAa9yIWS5PPFcVQjm7bw=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 19:09:16 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:09:16 +0000
Subject: Re: [PATCH v4 02/11] block: introduce bio zone helpers
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-3-damien.lemoal@wdc.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <d1a56459-9ea9-86e9-9af0-48d2461cce21@oracle.com>
Date:   Tue, 25 May 2021 14:09:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210525022539.119661-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SA9PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:21::31) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 19:09:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb3ef0f1-f928-431c-7ca6-08d91fb09785
X-MS-TrafficTypeDiagnostic: SA2PR10MB4793:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4793851FB5DFA77E31CA60B8E6259@SA2PR10MB4793.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urjXKTg5DNb4oifLPbOHvzni5L2M0ifg8wjG1JNQz4kA2E6/8XynpZ3csy70km1yd+220FfbS+RqiGBuO5gBDnSqdppqnpKA2ggCgjXhqjAf35bhPVnIlA/rMsh8hjfga/lRWVJgew5bSTzTgG67ziSWQmuLTUxjSIAj2ebI6VLJZ7Z4z0f80gLy/aAGLwRRfGKfWFLMg6isXnjeTLU6Rj6GJokd++psuEBeoX6ESH4K7VOOMHhCYIHg6chedFZxIjHxF5IMtTlT2h1I/kyyqH2kebUBjWBiVmECh1lTYKjlJ3drjmNvW7Ej3SJF1X2wzi/PC+aNUNAl5iaroKbC887vmPDv/IJs1KfMiyh4Vh0ArCJBjdTDfJyDHWVMopt2OEv2Z876xJD7gI+3HSSdmBBo35cK1RHdgPTnhI0b8q9iX7PcJ8ZpUF36OYRIV8D36mJ0amFkQW9pHJ6iIHE+DGybJOW1EudcL8qZeHtJPEI6PA3xnUjTf0KgtMo84Ix2FzpPjs2QgrcureUHm2Xz4IfZWVXhODBDbRRKvPC3kz7lJx0fzigWYa3ZRv2ZpQ/iN/fiagqxrS2SmXRo7RVI25hboLUWWMqEifYbqcCERPzvHqYHKj+NJ6nns6AnvB5wkT2BvEEtR/v0e1rI2u7hCWdoKw31BHwojYKgxXRkIfoavcRxRH1X/T7zLK5Y1aYACaIBq5XrsLrs/bxR0NSMIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(346002)(396003)(38100700002)(110136005)(31686004)(66946007)(16526019)(8936002)(36756003)(8676002)(86362001)(478600001)(66556008)(66476007)(83380400001)(31696002)(6486002)(956004)(53546011)(5660300002)(26005)(44832011)(316002)(16576012)(2616005)(186003)(36916002)(2906002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cnFLL20zV1ZSc29WVGF6akxIUWZ5ekt2OUVQWGsxbDlsTS9ZdCtERG12elVD?=
 =?utf-8?B?Z0pqdSttU1crdXdQVzV2VGVaMitQbk94NlNOLzJ4Z1lDNkwyYWhEUnFjUDJN?=
 =?utf-8?B?c2xjZG40TzZHcXo1WS83NVc0TG5BcUNsY3U2ektCWHFINFgrQmZ6cU14Z2g1?=
 =?utf-8?B?d1B4am0xSHRmV24zUHlHVkZPdE5iUC9PQlZmczM4eEEzZG42MEtJNjhkU0Vj?=
 =?utf-8?B?dzhSN0V6bEZub1BKM2ZzK1ltY2h4THI4QXkwYzQ4Qyt4NUMzSmRUcjIrTXNw?=
 =?utf-8?B?RWF2Wk5yNWhBQUUxVXE4ZEMwbHpKZ3dQQ2poTkxZek5pZDJsZ3RWMlhsMmc1?=
 =?utf-8?B?YTdScDhEWnQzaFA4aDcyL2EveXJnQmxOSmhnbktPZSttVHplbi9XbitITy9P?=
 =?utf-8?B?MHNIMG1NOGtVOFJzM2lCVzI2dElqUHNhbUNwblRuTnlnU0hBYllvNTFsL2VD?=
 =?utf-8?B?ZFRFOEhNcW5LMjVWTnFWWlByYVBWV1haSmpsN0hNVWI3ZlR5cllxMUxscFdk?=
 =?utf-8?B?QVpkT25qTWJDL2Jwd3kyaVBUdm8zS0kxaTY5OXJoV0J0ZlhUS29sTi9CZUQx?=
 =?utf-8?B?akVhcGJWMGcwTEw3TFlpcnZ4OW9TRTBQME50RFIrQmNQY09CbkhOa2pmZVJF?=
 =?utf-8?B?eWZjZ1craytaQmNtNUtsajM5cDlUN2JCbFdjVlBGc1ZVSUlIV0pXeHRpQXFh?=
 =?utf-8?B?encyZjFWNkM4NG1OSnZGc2hsYmZLc2RCVkNPSVZoZ0t4NzF0Z0cvVi9DNWFp?=
 =?utf-8?B?OGt5WG5aVnlodFhsUzEvWHYwblRJcENCMGNxMjlVMjYxVGJVSVVkSndTQzNa?=
 =?utf-8?B?dDRTMHBvL0FBSGJ0bDBORS8zbWdZT3BJeGFtbk01NURkcmIwMmYwUFZjWFNN?=
 =?utf-8?B?emZZQ2NHbUlTMDFMZUZ4Q0FFOXh6YXc5S0pqVFM3SU03VEt4VlIveU5KVGNz?=
 =?utf-8?B?M2FOYTE0SW5SUER0KzNMVWEzYU1LMXptUFI5VVVGSHZub3lxeUM1R0M5WldN?=
 =?utf-8?B?YmoxRVAwYTJWS29aK1ZMRVBqZDVmUlJyWjRPU0MrUDd5Mlp0RDZUWkFKNVlG?=
 =?utf-8?B?aGx1ZlhDNkdLM09OTnp3M2NPTW1MRm44cVhBdURteVVzdEppeUVFMktaemt1?=
 =?utf-8?B?SE9wN2N3TndyRzdLTEVTa0p5cjFGZzlUOHZVV2FQVzU2eUc0REsyMlN5N0FG?=
 =?utf-8?B?Z1hjQUcrTU0welFtTWl2Vy9wd2R3bGJ0OWNMcnR1WkJHT1BQMWNFemJxMnpM?=
 =?utf-8?B?RlBKRmV1VS9wbkhGT3hySEZML21LeStXVTJOa21KWkZyYUp0TSttRlVIVUtN?=
 =?utf-8?B?VkRFWENmaGRxQ1A1MWJlNmJrTU5qTTlZUkZndzlvMGs0OVJKM2VmNEIwVHJG?=
 =?utf-8?B?RUpQdVRFUi85M2piQVg3NHVadDBBbE1zRzVoSG1hZmVjMVNSQ2NZdU4zVTlP?=
 =?utf-8?B?bW9LOVBWak1OTGxkQkJwVHlWWnZCZm5vcFhlcEgvUy8vSDJWd3dlZlZBWVly?=
 =?utf-8?B?VWJuNTJIbW1CMStqdkU0WUw4b3cxRVhPV0w3NUhzMDhZd01jRGVkdzUrQWhS?=
 =?utf-8?B?a3lzdzNja1lZazliSWNoL0RHWTMycWFtOURSbFQrMUVKN1I1N0sxQ25jUmdT?=
 =?utf-8?B?VC9LSnhnd3hLRjF0NCtFYXljdVdKclR0TkZuUWRqRWZZV3M4Z2NaV0lXbFYv?=
 =?utf-8?B?cTdsZG05MnJsaURFcGRTTGMrL2N2UWhkOE93RVQ1ZUlCMnB6QVV4NUpsaFFt?=
 =?utf-8?Q?WU7/gqJYzng2s6jpSt/ZGQwfS8bPrhmRuRS0buy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ef0f1-f928-431c-7ca6-08d91fb09785
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:09:16.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmnMuRMcUiBDGqRYAaBiOPxbkz86tcu5Av8i+Dpoebr7SGUhRivG6aXyuJgRJM0M+wVoirw34VvF1lRxUIlduDUCM09dUo7M/m1daFKeUWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
X-Proofpoint-GUID: YGSOB72yRvIgedu4FXeTg0mkCSM8pr8L
X-Proofpoint-ORIG-GUID: YGSOB72yRvIgedu4FXeTg0mkCSM8pr8L
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/24/21 9:25 PM, Damien Le Moal wrote:
> Introduce the helper functions bio_zone_no() and bio_zone_is_seq().
> Both are the BIO counterparts of the request helpers blk_rq_zone_no()
> and blk_rq_zone_is_seq(), respectively returning the number of the
> target zone of a bio and true if the BIO target zone is sequential.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   include/linux/blkdev.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f69c75bd6d27..2db0f376f5d9 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1008,6 +1008,18 @@ static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
>   /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>   const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
>   
> +static inline unsigned int bio_zone_no(struct bio *bio)
> +{
> +	return blk_queue_zone_no(bdev_get_queue(bio->bi_bdev),
> +				 bio->bi_iter.bi_sector);
> +}
> +
> +static inline unsigned int bio_zone_is_seq(struct bio *bio)
> +{
> +	return blk_queue_zone_is_seq(bdev_get_queue(bio->bi_bdev),
> +				     bio->bi_iter.bi_sector);
> +}
> +
>   static inline unsigned int blk_rq_zone_no(struct request *rq)
>   {
>   	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
