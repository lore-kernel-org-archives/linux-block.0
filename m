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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE2C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401796135F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhE0PWJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 11:22:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhE0PWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 11:22:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFJxh9127390;
        Thu, 27 May 2021 15:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hFQMd8lOUCN3zJyJy/eYaI1KCJkIl6xRyXutUY/CQIU=;
 b=pg1d+rvmqd+lkuRO6TLOFluJ2N3t1zKIPiNyVMSt2m9r0liECJHwWod7y5BK662+BRGg
 2zkewY5XJMgkjYdulCs7GQrGIqh1p/j/SfzB549kznngRZDfuV3Vz6HgM3RGgXRZsGWY
 ashI/v7SjgmS2TstTCXthOm5k1/kMEtq6A7Ovh3B/sZx2mpoBDFgrtP2CUTGUmD33B17
 7Hl0Uyf0wUzBPUf5Qh3dWHqfJfEY1KOnVxyrdi4lS9c43aBD2oHnDBQOwG7v9kqsOR/Y
 TbI3o11rRtpGDm+VEOVySom2EVIYrctUdVgRiGeFgCjHfOyBmCWyWssVP3YwL7RIOsJS Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ptkpcfex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:20:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFB8CY112490;
        Thu, 27 May 2021 15:20:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 38rehgp36e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHqE+R3I2uw+WX44E6utJhyemFQyEDWbJ3xtwBezhjTIEnqr3QdRs3ro/CcPDq9FCyntuvHU4n9Ux1+l60e1iBaLMEk1tkN8HAwhPljaFLEa/cJhp6ZqZmBwTpQGZSgLhDyE7ftqO9btGCARQ8msQA0HoYBEhyypa+i/BMGpzp/mRYaQ9Z5at2PBBRM4mx1sV0mtx/puwttOYNYmcxItPcmCbNtLDpXh81Cg8Kk5W4+DCpfugLgFjFinuPfNmLuhKdJ9bme1F3ebQmJXjVIVQ73yU9aJhq/7wCd/bpGXkyns7KELdP0V8uNP9gh2uW1HSq5Gsnh8SdMdJlM12rZqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFQMd8lOUCN3zJyJy/eYaI1KCJkIl6xRyXutUY/CQIU=;
 b=IDrHrhPUosOf1lZ8KfUpg+95kXrF6VhTaojtOy9RK4fiD5QU6V8/Mq3lLXx0wE1SpeOfIGOyoI10XkKUaEf+YAIS/4TJIg9M6P5+1HTNSgzQFE9FtqC2JWtWzJM6bAX5CTIR2OioR68LzyUUBcZOd2Q9hwbkybIa44/J5dhfmVfE++0V8nR49JyAIbrTD91BoR4b0Ie+9XxRdP977Ofh5hfKnEfs+SdDkdD5PqbhiBBh897haLglJ6LNmY9KzQZ/HgScSedqqtS4twoCe5MFY3ziRV3hXeQGsIBpbGEIaj/a93SB/eHaX9vnx1mdF4gTxJkWkrFWrQ+P+x3yK5x8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFQMd8lOUCN3zJyJy/eYaI1KCJkIl6xRyXutUY/CQIU=;
 b=Lzralfv+906inSqghuMd+BmBbg3PI+LCYbzm0mgg4bMDZyOk1bbPwisqnD6/4NZZCDoSrME6+bEV3hrNG3VrwV5OKWK8qtA5yjGN2kgg/7du5RQ4dzOLxbgk2Q/zAtqAFlE+LoNjC+odrsBe5JanBUiu1YCeTd5FEVN4Fzej53I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2911.namprd10.prod.outlook.com (2603:10b6:805:d7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Thu, 27 May
 2021 15:20:22 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 15:20:22 +0000
Subject: Re: [PATCH 6/9] block/mq-deadline: Reduce the read expiry time for
 non-rotational media
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-7-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <15177f81-a390-dede-7a9d-030dc4cda596@oracle.com>
Date:   Thu, 27 May 2021 10:20:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210527010134.32448-7-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2606:b400:8004:44::12]
X-ClientProxiedBy: SA9PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:806:22::32) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::7b4] (2606:b400:8004:44::12) by SA9PR13CA0057.namprd13.prod.outlook.com (2603:10b6:806:22::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Thu, 27 May 2021 15:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04341ef2-1d2e-40a4-bc0f-08d92122f1e0
X-MS-TrafficTypeDiagnostic: SN6PR10MB2911:
X-Microsoft-Antispam-PRVS: <SN6PR10MB291123EC0B86C366802D7F41E6239@SN6PR10MB2911.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPbUCl1rLiBnCb4E8gI0mlQBhi1L6cfVMJx96pCeo+zFo7wguYBBfZLqZRMxQENJwC+lnVAwjkVbyeAUuhhCPIaO191fp7nzf7sbqC66uaSv/LVO2am4UjvmLcPe0BuDUHdfFFEMy+4JymKROHa/J2bV/GP2hqkCxiOCViYsaUDueRtSm+wHZF3ac0/isy7el9Xd+vpvocZ2zksjy2W5o1F1O5CuM/tIWUWtgQRbUQMIisD4y5n1/NSFLDR8qByEjDTwAnxEuyt1RD+WlQh4mdGQr5TcqYGNgrZ6jNokEFntVSLk5VIPYsIMu5eTu/m2KpECNssnt3Xt0X80dlP0J3YImvQCntXmEI2Aq16mimCoqsVseX0CFJwflQ/QKzKmpDA5TgSj8gsqYluvODH3qnpvCWirZl7EvwSiMhU47srIdXVS1qvW0tFKpHBX2BrZwgOSaB2XKsPWCSrs4y8t4CgjyOckta0j0Eo+t5M41DRhdd0nH0whlwHnoZHGf8DEFT5H5lqcMakq7HW+I05pE3g4JGz21xBIpc47f7oa+glWPEtkSPFOJAQ8dJz6R1C0apVlhOkgY2jrnroLapm7xmdob5ng6z/NRvk74dcuhcX3xMzI2LV80z7/4/luw90tN7FCvhJZnxm33fTQaTHGqjd7TvcRB2raelTzAy0e3em9aI/AXyVC6fNkaKsF7g6H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(478600001)(66476007)(86362001)(16526019)(31686004)(66556008)(83380400001)(2616005)(44832011)(66946007)(2906002)(38100700002)(110136005)(54906003)(186003)(316002)(6486002)(8936002)(36916002)(8676002)(36756003)(53546011)(31696002)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVFRdXEvYWIwZEFjWnpiem0xMDM3UFlUVXFWK0xIU1paSElubXNxOUlXWTYx?=
 =?utf-8?B?c09TbXl3bUY0anJtSURaR2NWUEp2bEtFeEp2bFdFcnQ0MXMyQ2JndWdRV0t6?=
 =?utf-8?B?QTRPSmZjVitnbExhdjdEV3lQaGE5Vk4vaUtRTkdNU0ZZdlE2UlJEczBQYzBN?=
 =?utf-8?B?ZW1BZ0VCZnN6cVNHUGJxZVVnL1Q1YTM4V25EdFppZUkwZjhHeWxQR2h2NXlC?=
 =?utf-8?B?TGdHY1BYa0R1RnhHdFZlY2doajgrdXVPbEhTeW5LaEw2bTllcnB2YS9XVUEv?=
 =?utf-8?B?RUNKM2xsSTJUeDRkR1NjWHl2ZExqOHkrOEJYcFVsRUE1dUFEaVBzL0ZDekZW?=
 =?utf-8?B?eWg3U1RRSlZUZCt3ZFlvSHlCVHNBeWVNems0bENUMWpGVzl5c3FyMlUzYzdE?=
 =?utf-8?B?ME1DRmJkajJUbFJXVlZKWUdOc0h3ejhrYnNLOWNEeUVTd2d0UkpmY2U3emtD?=
 =?utf-8?B?K1NJNm9GbjdQSFU1UVpwWW5TUHp5ZjJvRW9JREZuUy9UZHVUNHVTTThTSHNI?=
 =?utf-8?B?UjhoODVIckJGbjhLY2xvZlVsdU1KNU4yODlYYTJURWRqN3RyR3VJZWVGREFN?=
 =?utf-8?B?SFBYM2tEOExmNjhPbGxDbEc4UGpJUWw5ZHU3Z3VJYlJMR3J5K0toNmo3bWI2?=
 =?utf-8?B?aS9RSzJYRitITFJlYTVoVkgzV3BYSE1IUkc3ZDdnbXJiVzVqdmhSZEJpaWR3?=
 =?utf-8?B?Um5yVDFRRmZRcFlhOHQ0ZmRBck1JQ2lwQlhhZDVSRmozcVZtN05hOWU2S2Vx?=
 =?utf-8?B?L05oN0RjUUJpOFhrdXduZnI1REFTUVJKU1hMMkswSUJ5OTBteWJNV1lvZXB3?=
 =?utf-8?B?eWVKeXQ0bjAwQ0hoUmNuRzB2ZXpTNlRBMzJFNm9ZL2xNQkFsbHhNcjMzdUxR?=
 =?utf-8?B?YUhkSTBqSjlHb1l2SytCWUlWaVlDeUNaWWRhVlZYWis5Mi95MXlRVE1tK1I1?=
 =?utf-8?B?MW9IdTNSMlFLaW5aV1JzREx4K3VIYklENER0KzRQTWVSd215bE54dWlLUkRa?=
 =?utf-8?B?S2R4NC9LZ1RaSEpuQTF6eTU2cXZpQXlMSG5oaGhqS05abzMwblQrTmx5cTRD?=
 =?utf-8?B?QWI0dGI1ZXYrYnlManh1NytNdzdjYUQydlJMZGR6ZWkxWTVPMkNFSHhjZ3Ji?=
 =?utf-8?B?U2JDay9WL0ZiOHhTaVJJWldPdEhrTE9rSjhpOStFQjU1UGt4dXRjazNkUEl5?=
 =?utf-8?B?L09lWFJZSkhrdDJWdlVPWFdpOFNRVU55OU5FZzFQSEtubFV1MStTbU1qY1hC?=
 =?utf-8?B?djV6QmxzQk1INW9HQS91V1lhUzhIRGUwSWdDT1d5L2pzbkRQZDlMdWR5N1Iz?=
 =?utf-8?B?UzdDc0cvcGlFczc5VmI2emNnK0ZJZDRYbHJhUEtFUGdsZ0FEZkN6M3FOYkVD?=
 =?utf-8?B?Z1ZocWdqalc2M1lNbXIzRlFjc015dEpuUnMwK1hoS3BSMGU3Z0pRa25OYmQv?=
 =?utf-8?B?SkpsUy9aalI1T2t1aENmZXdBdGN6dkhxcU01Z0Vhd3dNcXh0SyttMmgxS3ZX?=
 =?utf-8?B?Q1F3QXA1U2wyR1NMZVhYZzI5YnR4dlptSW84UWtaU3F4WnU2NG9qN2hTbXNN?=
 =?utf-8?B?OW9BS0ZOYWtXSmVNSU1EOHh3eCt2dS9mZklEeVNoQXN0RWFLWXJuQ3NheHRi?=
 =?utf-8?B?RXR1OGxMdUhSZXpuUFk0Z0tHNFl1dDNqOWdDblNqTTJpUWxUa3FxVmFwMWZB?=
 =?utf-8?B?U0d5OWhScTJwOWtCYkdaK3RWVTVkWVlRT0pLTVk2MUcyTDBwZU16aVdVNVhY?=
 =?utf-8?B?cGIybHBFa1IzYlVQbC8zaStvb3hPK09ZeDMzRjlKNDl0RXoxV1hRR3FrZHBy?=
 =?utf-8?B?UVlyVkFuQlNqOVhmMGxLUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04341ef2-1d2e-40a4-bc0f-08d92122f1e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 15:20:22.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBZJ40jfqmDQho5Q0FMFcEEpIUmondiRkx1KtEd3Wib7O9a774GqGe0+TdjBepsNysTai6tbtfHw54Bs+HsPOjmwzeLzyWo2g+LWf78UmAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2911
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
X-Proofpoint-GUID: KJF7hkhE5z9TFMq9EaHHDL3A8IvYN5Iu
X-Proofpoint-ORIG-GUID: KJF7hkhE5z9TFMq9EaHHDL3A8IvYN5Iu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9997 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270100
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/26/21 8:01 PM, Bart Van Assche wrote:
> Rotational media (hard disks) benefit more from merging requests than
> non-rotational media. Reduce the read expire time for non-rotational media
> to reduce read latency.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index dfbc6b77fa71..2ab844a4b6b5 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -29,7 +29,9 @@
>   /*
>    * See Documentation/block/deadline-iosched.rst
>    */
> -static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
> +/* max time before a read is submitted. */
> +static const int read_expire_rot = HZ / 2;
> +static const int read_expire_nonrot = 1;
>   static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
>   static const int writes_starved = 2;    /* max times reads can starve a write */
>   static const int fifo_batch = 16;       /* # of sequential requests treated as one
> @@ -430,7 +432,8 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>   	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);
>   	dd->sort_list[DD_READ] = RB_ROOT;
>   	dd->sort_list[DD_WRITE] = RB_ROOT;
> -	dd->fifo_expire[DD_READ] = read_expire;
> +	dd->fifo_expire[DD_READ] = blk_queue_nonrot(q) ? read_expire_nonrot :
> +		read_expire_rot;
>   	dd->fifo_expire[DD_WRITE] = write_expire;
>   	dd->writes_starved = writes_starved;
>   	dd->front_merges = 1;
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
