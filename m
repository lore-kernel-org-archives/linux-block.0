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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58979C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D4613CC
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhEYTPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 15:15:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47056 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTPM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 15:15:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ5q9w132403;
        Tue, 25 May 2021 19:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5esaQhA6XpoN77DvBTtM8HGwzXCcreg2/cX65hsj+O4=;
 b=dmc7qqGh5T7IQv7SDrVRHXeFttgomIGgt919KOr7ze83y9wls2DCs5iOFoB4U7ac0BkD
 5cNtdUa6ZBmtn+jLQ2vYfE6v4vcVrahLfXmcmovgNEavGwFzjDk/eZRgBNIzvMr5sWSQ
 XNdIFXHlFIUXUFWSKy5YxK/uEJ9c+PkaNqnUHmeGbb+QalDn2DP45dCQ9a3xk9/3Al/G
 l8iTn0V2BXfztrFsg8VRzoiMjpjgrXC7ECQS48EYb/pUSZ72qd8urpDAX09+R4xl40b4
 PKX9uPTIDnl1WMtlLjl8MNJQQZf1C0F0s8c9oKeR33dTzzRH6mmlOABJdQ7qnsqJgJVa lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38ptkp70cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:13:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ5G7D009020;
        Tue, 25 May 2021 19:13:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 38pq2ugup2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwHjJSbmID3cuIfEyLAAU1+zOCkKpTnoDdoR2UWGZ7tcEmg8COaVH6uw7Gldvax4CGwA92H9+bo228u6AnhGjcdyjH3yuePadAD+uOU+g28HRRO29gSQV4Cem7l4UeRc27sna7y3wMz9xU5fTqRdBkurTVCw9kDPdPRxuWwj+H3dPmtq5/m1PcEauGvr2Iy/I2zO8IYOd7zsV+Yo9T+jrzQoO7ZkowRtIkz/kdV64hjGgE84Q89j0otUj0gX9IVxzXXSXw9lYYkJqVxllvZAnrkTjNSjCi4u8B32t0hJcUVvJ0CABl1wUWv8UeENFWCI5U54yOeqXYokFwkvEqsktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5esaQhA6XpoN77DvBTtM8HGwzXCcreg2/cX65hsj+O4=;
 b=nynXIH04iSORF//OmiCli7kHvOWoZ1+eAafok541PUGvjnADjEJj5+2aOA0yhf55/fHiIruGQZYA/Dn+D+u1wwMmRUzevrETzHtXE8/CAwYg0rbz4Exx+rFFPO7uY1paczR1FX2QSER2rPDLcRT7KPqGAfxW90ciKYLfPfs6+eEmhiFFhyob/ioD3jzS9Yda7Ch4LPv4GfAg5adc8ZF8ygMEmLFY6W+C8IzdjmPr08PEiF9EKRVTruAuq11KajpFDj4JwpRNqnzprDJdtjYnlHb0DoaKmStngi31bRzZSoIr1uTgyU7h2n0S4U7SVhxtiN+Gj/K6qI4LS1cPovW2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5esaQhA6XpoN77DvBTtM8HGwzXCcreg2/cX65hsj+O4=;
 b=T/P3xR9nZlILhgeIGzzVQ8uMxIsTHugFEBB3H9vQbiay+obNbeEva6F+tohUAGWpzrvcuALH6slCthrLMqHDvS672yMSvvGYr8gTxW+Z0lT0dXRUBtfJcFv7I85FkJaI8syWU7O2F9MNVAwyMb/nFkrDWdUCWa5y1WfNCGCL3V8=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 19:13:36 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:13:36 +0000
Subject: Re: [PATCH v4 08/11] dm: Forbid requeue of writes to zones
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-9-damien.lemoal@wdc.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <e7f1d9c8-c0f5-424e-fa41-25fa6c7eb21d@oracle.com>
Date:   Tue, 25 May 2021 14:13:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210525022539.119661-9-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SN2PR01CA0064.prod.exchangelabs.com (2603:10b6:800::32) To
 SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SN2PR01CA0064.prod.exchangelabs.com (2603:10b6:800::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 19:13:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72461ce1-9157-4539-064d-08d91fb13257
X-MS-TrafficTypeDiagnostic: SA2PR10MB4683:
X-Microsoft-Antispam-PRVS: <SA2PR10MB46833D97A2D167882BE980AEE6259@SA2PR10MB4683.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPjOuZh6wg4BF8qGbVptRm8q3DYvwUDQqUmTAxmFU7EdkGpEK2TXoSWE8S56cxQ4ilJfD6VptY6UhWy98VdIHG15DMDaolHCbTebYhB3QV5hBA9jQesORH7Qou74EimKAQNbWuDHhsf3hU6bZwIKqWI2cfj+ioLXg8hizjrCrVrdkNRWFzGfT1E9LNmf0HwmRX8CSHBIX2Oll31wJUOnxkP9dkpbc5MxFTnXcvkKrgmB0T+NnP/73r+qiVAkydU4LGOQliue9UtdIv88x1jxXmrNB72o97+KWm41cRKhQpk3T0O+Nm9ZwdyC3lLKSWLxohp89M6mBgGWILGPuOz+nESeDr08oax5I81C8KgPaANsDjGoSnuzdn6Vxqoh+PYhPV9SH8cDCZpWPXsWrzmI8LoEcR2iEgsS/GyL+tpQO5xyo3tWDYuXdTm0/Z0pVC0f69zO/rgGtfCzwHJfIPKum5NuUUE8YprlVFE5kU4ujR5VXuRqcsloq1pG7XkI78Dq+duEdSg3wRqH+n1orrq4mDt5V9gXjxQQMj8yjRIUpWHzkEnHdAjpBtaxUrwLz41MgJf3Zw9k4LT2RhIoih0I+GGQuJPsnp4HHo+k86gTN/aZxk3IJ4H5+qnzdPx4lG5RGuIMfFI2ap3HGXmD1GZo+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(31686004)(44832011)(53546011)(956004)(16576012)(2906002)(2616005)(186003)(6486002)(36916002)(316002)(8936002)(16526019)(478600001)(36756003)(26005)(110136005)(83380400001)(8676002)(31696002)(66556008)(66476007)(66946007)(5660300002)(38100700002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RVVjZWZ5Qk5CbzhYdm9OMG9FUUdtMFBiYjJZT2JvNUNjSGp5MENyUHk2U3M3?=
 =?utf-8?B?b1lqYXZKY255WXZkT3l5UlVBeGpTRklaOWNab2ZibkhxSE5pbmEycmlNelRW?=
 =?utf-8?B?eGhLNno5eXJiMXZFazcvSkpnSFpyRWJvZFJUTit4Qk5LR0dHeFhIc05FQ2Fj?=
 =?utf-8?B?cENPWUYzL0I2TTJmd3RzdkY2WHRyd2JXVjRaWEgxb1B0UlQrNlpLYXoveEY2?=
 =?utf-8?B?Yi9rUkNJWEROb2xoV0ZuV2hYNDhLVHJsTGZZcGtmczg1di9kTGlmNWpyekN6?=
 =?utf-8?B?bVZpZXJrNGthNld1QzRyME1zeVlhOFdjRnN6TEl5andTQzFxVG4xaWlxNXhL?=
 =?utf-8?B?MUVRZlFETFN4dmJCZEljMnl6NEV3TEtBUXV4TVN1Z0pHYUZ2OTdLRm82Lzlx?=
 =?utf-8?B?dW9JUmNyVlNQNmpMVDRBZGdIQVgxdHlwVTJJYUlsVHh6cjZRRVRQeHdMR2Z5?=
 =?utf-8?B?bitzeXJGbFBoZE9iU0VwT3NxWC9Db01GVkhGYlBzeGVleDZiYkZEdEFJaUZZ?=
 =?utf-8?B?VnVnZXJ4azFHazZ1aGhXb3J2WVlYeGNzMHovS3VtYU5rWlR3MzBmb1FEM2tT?=
 =?utf-8?B?QURFdTZndWFGNWxQR2YvOFA1NFNHQzh3S1NqV2R1U3lKK2poc094b0FWRWtL?=
 =?utf-8?B?SWhSODU3TExTd2ZOZ2hlZDlTc3ZRR2pScy9wMlpIUExqWktZeWt2ck9LUUo4?=
 =?utf-8?B?QzMxMlFpdnloQXJQdENnOTdDUC94eUhBWjZCanNzSVRyT3RIWjl4WTVhWS8x?=
 =?utf-8?B?KzFadFZnbFdNUEFwRVJOcVdMUndtbkc2L2dKeC9vOUxVSkp2ZHgwdCtXTk9H?=
 =?utf-8?B?aXFnbThPS0M5YVZiNmdXYmJUNDQ0OGlNOWhvaTQyYXRTWE9MRnVod1N3TkY0?=
 =?utf-8?B?NmxxNDFTcUpFRDlPTDlzZmFlSlV5SWYvZld1RFBEWVdVOU95aW5sSzdtNGRD?=
 =?utf-8?B?cU1qTlVEQ3R0cm9hMnQ0R0J5V3lVYzZmL1BTUW81SjZ2dk1qb2dmMUFETHJX?=
 =?utf-8?B?bXYvM1lYM2M3K2pCZ3VOcGw3cTNodEdiVWNBWktJUmxNcnkrL1FzVXpIcTNx?=
 =?utf-8?B?MHZkSlVuOTBkZmRDaTFkNHgycjNqQSs1ODVsb2kzSXpzaGx2TjZKcStNaFYy?=
 =?utf-8?B?TUQxM0g0NXhEV09ObjhqN0o5YnNPVEMxMjBaSkloUm1JSk5FM1p5RXE0a0JP?=
 =?utf-8?B?UXhpYi9pb2NYUHczbnEwaysrRUdVZWp0QzBsQStaOVc3VEEyWWdRODdEOHNE?=
 =?utf-8?B?U0Fsa29jTUxvcUxUVWVrWDZDVDhkYkwwOEpvcjhKY1JjK0t6VjVJVTZpKzJq?=
 =?utf-8?B?SlVpWnNWUjNXbnNnR3NuZXZnTE5FZWFlL0dINUR4bitKREg2QXVQclhSZEZm?=
 =?utf-8?B?a3lybWQ1YlozbG1sUEZ5WlYwNktBWUIvR0NyYit3SWJ5MDc3bnlHVWJVOE56?=
 =?utf-8?B?Q2FtZC9xeXp6TmNVSmJ1Z1pRbVhYWnB6aHBWeTVtT0hFQUdUc2pUZUdOK3lF?=
 =?utf-8?B?SDN3SlZVNlJtSkdqUDdCUU9zdHZ5b1FtcHFEaXMwSmZyUlBhcG93Q1FXMUVx?=
 =?utf-8?B?OHk5dExkamJZWWNHOUhqeVBhd1M4QjlyY1NHWnpTMnQ3a1oxQ0R3QWNyR2dt?=
 =?utf-8?B?dUk1a25tYVpwTEQ0ajFzMStHV3lvTzFPNnI5Z2ozb2tKZDlMWkg1Q1NKNXo4?=
 =?utf-8?B?NzgrNHBWbFFEdmVHanFPSVVpT1JwQ0todjQwQm5ITy8wczJ4WnpCYkdNZ01D?=
 =?utf-8?Q?E0/zh8WMycSxJt6dtpdJUXEppzRzzr71tGHin/I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72461ce1-9157-4539-064d-08d91fb13257
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:13:36.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsA1ADwuxUDaNAquB0q2SifGIsRhuxy3Jo2pj/NSXRBGawcg7Z09inWtWomtJY1wu9aCIO/Q3G3UxSVYBvOoxmT2YskEqya/hlnjW7OVbFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
X-Proofpoint-GUID: LsySq-wGEeOZuAEXyzGZW2cPK1Q_TKw2
X-Proofpoint-ORIG-GUID: LsySq-wGEeOZuAEXyzGZW2cPK1Q_TKw2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250117
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/24/21 9:25 PM, Damien Le Moal wrote:
> A target map method requesting the requeue of a bio with
> DM_MAPIO_REQUEUE or completing it with DM_ENDIO_REQUEUE can cause
> unaligned write errors if the bio is a write operation targeting a
> sequential zone. If a zoned target request such a requeue, warn about
> it and kill the IO.
> 
> The function dm_is_zone_write() is introduced to detect write operations
> to zoned targets.
> 
> This change does not affect the target drivers supporting zoned devices
> and exposing a zoned device, namely dm-crypt, dm-linear and dm-flakey as
> none of these targets ever request a requeue.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/md/dm-zone.c | 17 +++++++++++++++++
>   drivers/md/dm.c      | 18 +++++++++++++++---
>   drivers/md/dm.h      |  5 +++++
>   3 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index b42474043249..edc3bbb45637 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -104,6 +104,23 @@ int dm_report_zones(struct block_device *bdev, sector_t start, sector_t sector,
>   }
>   EXPORT_SYMBOL_GPL(dm_report_zones);
>   
> +bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
> +{
> +	struct request_queue *q = md->queue;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return false;
> +
> +	switch (bio_op(bio)) {
> +	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_WRITE_SAME:
> +	case REQ_OP_WRITE:
> +		return !op_is_flush(bio->bi_opf) && bio_sectors(bio);
> +	default:
> +		return false;
> +	}
> +}
> +
>   void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>   {
>   	if (!blk_queue_is_zoned(q))
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 45d2dc2ee844..4426019a89cc 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -846,11 +846,15 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
>   			 * Target requested pushing back the I/O.
>   			 */
>   			spin_lock_irqsave(&md->deferred_lock, flags);
> -			if (__noflush_suspending(md))
> +			if (__noflush_suspending(md) &&
> +			    !WARN_ON_ONCE(dm_is_zone_write(md, bio)))
>   				/* NOTE early return due to BLK_STS_DM_REQUEUE below */
>   				bio_list_add_head(&md->deferred, io->orig_bio);
>   			else
> -				/* noflush suspend was interrupted. */
> +				/*
> +				 * noflush suspend was interrupted or this is
> +				 * a write to a zoned target.
> +				 */
>   				io->status = BLK_STS_IOERR;
>   			spin_unlock_irqrestore(&md->deferred_lock, flags);
>   		}
> @@ -947,7 +951,15 @@ static void clone_endio(struct bio *bio)
>   		int r = endio(tio->ti, bio, &error);
>   		switch (r) {
>   		case DM_ENDIO_REQUEUE:
> -			error = BLK_STS_DM_REQUEUE;
> +			/*
> +			 * Requeuing writes to a sequential zone of a zoned
> +			 * target will break the sequential write pattern:
> +			 * fail such IO.
> +			 */
> +			if (WARN_ON_ONCE(dm_is_zone_write(md, bio)))
> +				error = BLK_STS_IOERR;
> +			else
> +				error = BLK_STS_DM_REQUEUE;
>   			fallthrough;
>   		case DM_ENDIO_DONE:
>   			break;
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index fdf1536a4b62..39c243258e24 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -107,8 +107,13 @@ void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q);
>   #ifdef CONFIG_BLK_DEV_ZONED
>   int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
>   			unsigned int nr_zones, report_zones_cb cb, void *data);
> +bool dm_is_zone_write(struct mapped_device *md, struct bio *bio);
>   #else
>   #define dm_blk_report_zones	NULL
> +static inline bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
> +{
> +	return false;
> +}
>   #endif
>   
>   /*-----------------------------------------------------------------
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
