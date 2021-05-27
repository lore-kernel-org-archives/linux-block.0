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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE38C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351976135F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhE0PUz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 11:20:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52844 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhE0PUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 11:20:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFBASh144579;
        Thu, 27 May 2021 15:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ppE7+/u6kbRm20odLMuQGIKOU8v/0doA+PXI3AcFbgI=;
 b=c6ic6Iuv+x9LqtKJBBz0/85HIW31jmpaOMhb/Etz1fIvNveKUmyWNZ5KryQYBePgob5J
 EyLFLhvuGqik9mg703LVXLgMfWO67PeNoUFv7F+gqmID0nK+svigqRHUs+IDpm1Bjmd+
 vYy8HtBjtOMZbOkOJrNAeOV2ZCiLyRWAnXVB4/J2o0UVebhCsT0LbLhkWhDXDT8ToFxd
 XRaOKvv+c2Sf5SMwrMLiLtSeMzIWaTLnC7WqZfZBmOXQU0NKTHNBJ1v9A/XPhqHew01f
 U2/CTDfYTAkdhOuLLBMZqsMQaDBKTFY/ZYUJiMH18qZ+EhzZVYmMvHtrVDxFCy7SZNGN iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfcmjsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:19:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFAM21183046;
        Thu, 27 May 2021 15:19:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3020.oracle.com with ESMTP id 38qbqueaky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+yKastDVGkdemv1ucJN1teBK1/R9YlCXI8JLYp97g/LMn8OjLpEuShq+iiP8Ph0D4U/flgeleuCTiiCphjtjaWDfE3O1xrHNYgKYJK0fMZBRUuwpPNEJ4jgBXQvk4NVC2LkHRZsZXZUH0IKJ/ejNmxHLQMIUc4bAg7s8Vs5wepJIGWprZXDGohXgzhar+1GYybYYXfZWk0QAEZ58R0BKgKpIqs+6s+2Z5wPDhVaJ88YntDy5+ahs3Fi3KT+pk5vK8amAR72mvEhg+TjOwQECvIvS5axBaW7Ho0g7fza3qVJdg+uRPQ5uOQ0455yg00nfiCUdP89X2+TDbNpo+flMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppE7+/u6kbRm20odLMuQGIKOU8v/0doA+PXI3AcFbgI=;
 b=iqJQpuJNYpHVYSgpwWkk8smr0wg3xhzyD7fBZ4Kvfox/NqvkKILIF6fzqdGbpC0xejCatztKJaGXs7HX3CLZYs1gkVN2/Ic0G36MWnNvvuM9vbjMpygB9W7aZdDMFEVeeEPiGafSIp68gqlXKPP0jb22jFLcSKn7dXcpJQrfw3ABIu1gzrYG6cBUUtrOTwhd2zmtTzA8HHXpq4b7dASsA/IPpToAYZIHchyc10G5J9KVnrqqAuvgAGlH3BqSOyHYn+jDUzix6GhcjR6jS4poEOIFYiCX1BTdKRPFMxzeE5Co+DWVwsv9KpXd4rKBwnAgmiktEHSYdHTTXJgsMidFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppE7+/u6kbRm20odLMuQGIKOU8v/0doA+PXI3AcFbgI=;
 b=juNQlkkEEu6sQDOMqqI/PdMosGjtFsf+x60gHoN31c7n/V2SjPJQiFvu8VZmw3LMav/WFkoGeJ8KXUbbUE44AsoDuEpNUuflXfvJVdLr1k8ref75+3I7b98G4HPkagqF/M+dEksGetJFRrkpTiBPY3etU1eWO9Ii3hMDDDVWgmA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2461.namprd10.prod.outlook.com (2603:10b6:805:4f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 15:19:05 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 15:19:05 +0000
Subject: Re: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-6-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <8eb91234-4384-fd08-2d45-00b4bee0a245@oracle.com>
Date:   Thu, 27 May 2021 10:19:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210527010134.32448-6-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2606:b400:8004:44::12]
X-ClientProxiedBy: SA9PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:806:22::34) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::7b4] (2606:b400:8004:44::12) by SA9PR13CA0059.namprd13.prod.outlook.com (2603:10b6:806:22::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.11 via Frontend Transport; Thu, 27 May 2021 15:19:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6f3c0a-f19a-4a30-a368-08d92122c40e
X-MS-TrafficTypeDiagnostic: SN6PR10MB2461:
X-Microsoft-Antispam-PRVS: <SN6PR10MB24619F505C161955D24C948CE6239@SN6PR10MB2461.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYyfPU6MnuWWOa7mXLCpWLP87aQFG9RrIz6blR6PybGQkGtUjEdWrVsQ4d7GEO/KJGF8KsIGU8x5OjJXrih8dz5puaqYcquc0Qz142/WrtZhbCV+A0hnxD/rjid62bfe1U6ygwmwvCKnuNsgQTHa6qtpOMDlgbSkHrXedgy2/wiG+dRltfEVSP/x+kDuKLRO2xBHJzGjOQirSvvtufpOaUA6fCuRmue+TWbGMxY1Luvq7CADb4G2t8cieVfvRLsYNevHaTQchlaO92DPfCFSoYsZW/6m0lNQSM33paHDuvjy66Av0/CNNlIcAIjG1/uy/ZQsqd+lUiS9EkFvW6mQ3RpVybnkdrEo7ozCNTrNiruxWwFavnTUpo6nhpFwXBAWdrFzxmw/KJSdJHs0jxOLq9ccNsQqU3+lW9YSEhmY2/bOr2tzWIcY0KIUtooh5G7xHfM6Oqrt9sDCu0eAnGwJc/1Yq93n+Ed8p0DF3MypE3Vn+QvUpSijrzUIkfU8qP37MX79fx9JDUm44VO41F1srlXCYLnvGegZXqlECrrVAu1cT69Ysj7zmpS+m04LQOmtW0hdj1jmwoKAvRO0A7ISUpJ6ef8zLQHCCcurS0E7F6/P0CYCGyzHmk/Wp7tP9Nc1ywOaz2u0VPrqYTNbHa2/HAVWK+QLKVhm5tFYTcLXcYszrIHgiMQHHuYWkpcGx4FH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(86362001)(44832011)(31686004)(83380400001)(8936002)(31696002)(478600001)(36756003)(38100700002)(6486002)(2906002)(4326008)(2616005)(186003)(16526019)(54906003)(316002)(53546011)(66476007)(66556008)(66946007)(5660300002)(36916002)(8676002)(110136005)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUZmZitTRVgwSEw4VFJCM09OY2hkSmtPQm43anR5R2U4S2o0WTQzN1RjWTJV?=
 =?utf-8?B?VDJDY2N3dzM2UnJvSm1qNkdkQ1pvZGIzZzFEVVNBSExUUlNtQUVEcGFHM29B?=
 =?utf-8?B?bFR1djYxM2Q0NG5kZjM1RWF2Q3VSOWxvaEo1M0JzNUV0aFdUSVhJeE9pUU94?=
 =?utf-8?B?aFlDUGpXVTFOakFUVmo1TkxYSXFKZllVNGpjZDhRb29XU3hmQTMyL2ZCeGM0?=
 =?utf-8?B?TU1YMVdDVVI0aW1Gb09LTlBjOW1uNGYxMktUTFQ0M3lIUmlhWFRuTjFWY05M?=
 =?utf-8?B?cS8zVWxKMzhrZ3dob0xwOFMrbW9LaXNPZm5CNW9VN0YvTmV0cGpFZ215VW5T?=
 =?utf-8?B?dTlGcEtUTW5FdTBmK3A2Nm4zK2JmU0U1ZGVqUWhYcThhU2djV25HbDRUaHV5?=
 =?utf-8?B?V3d1V2p5ck1yc045OTVPcVBsQmY1VmFVK0FFRkFEcmVBT0txL2I5Ly8xZmFq?=
 =?utf-8?B?YU5yY1dLc1pzeW1ndUtQeGU3RnJqYzlERWM0VXh3dDhxQlBQcmVIYURxcGhR?=
 =?utf-8?B?WUlHRTRjT3JKWnBhakUwRVV4SkxpaXdhUHhsSW5EOTMwd0ZVdHBFVTVwKzZa?=
 =?utf-8?B?VzNleVJGUzlxOFJmRHhEQXFDbVE5UjE5Sjh3SmZSSVh1T0ZibVJtZ25Bakk5?=
 =?utf-8?B?ODRuZWlXUFJtbUZDanQrUzRHNWp5UmEzdjg2VkxiSTJ5a0tJN093clpmMURL?=
 =?utf-8?B?dk5ZM2t6THltRmQzK2o2SEt0K1VXeUJPMUwzWDF4T3FzYnVOZldpZVN5L3Ji?=
 =?utf-8?B?MUJvN2RpcDFXQk5CdWxPMXQyNU5hdVBwUmM0bUp5Z1g5K0Y5OUpvZGdvVUFY?=
 =?utf-8?B?VENnd3FiUjRQZlZ0cm9pOEQrN3VoUFYyL2xvZUFrWFAxUnlabzBPRW12WU96?=
 =?utf-8?B?d0FzYkcrMVdMa0gwZjRCeFdwL1ZmV2x3c0piZWZ6Q0JkK01QRXczS2l5UFNU?=
 =?utf-8?B?S3ZhNkN2QnZvdEp2MGNUdDROZkVScGlFcGlrbDRXUWQyQnI5UVF4dk5SOVhl?=
 =?utf-8?B?djFEeTMvS0ZWYWMrbVBHSGNVaURjYmZJNThnbFBEYm1SZlZqcy9QLzRpV2w2?=
 =?utf-8?B?Yzg4ZUUrQXpkRVYxdkxXYVZxM0FCK1kxa0U4emZGYmhZSUlUMDJSMHluQVNH?=
 =?utf-8?B?cTZJVENJelJyei8relZESlptUFVTb3h6Mk1ldFhOZjhrT3BIbVorb1lVSmhQ?=
 =?utf-8?B?ZGJQK1p1Z2F3emsyUXZCd2ZiY2VwdEEvVlN6ZDh0aVRGNzZzc2h6OEhiSUUr?=
 =?utf-8?B?a0FRbXFsV2tmUE1zR0paS1ByajgzTXFnTGh2WWpVK2ZKTG9oUDZHSE11WlM2?=
 =?utf-8?B?RXN4UVFyRGFzOUt5QmdpdnM1bm5CcGM5cHNNdFd6Mk10ci8wamVxSVpFUFZt?=
 =?utf-8?B?b3hJL0ZGNm9TNThKMDZPZUxmRGtSMlhsNm1ZUjJyWDhScFhmbk9mMXcrV3RG?=
 =?utf-8?B?ZTArK1V2U0w3RC8xN3B6a0EzaFFUUGJFWmhrbnlBZHhPZGpxZmgrS1EzSm1y?=
 =?utf-8?B?TkZ2ZUNxTVNQWjRELzF1WS9kaERzMGNOMUVuOFpCeWdSY2VRTVRzSWdhNTZy?=
 =?utf-8?B?Z3pxYVBrT1FkRWNaZ1pzUnppVTFabHdpaDBvcVh6RUhZSmMvMjNKZHVKQTg3?=
 =?utf-8?B?MXlYNThKT0k0VEF5TFlKYlFmVU8yT285bExqT0ppVmpWVnVMTjdjUTF0R1dM?=
 =?utf-8?B?cDYrNW8wcHdqYUZFeXBENjZaOUN0TnFCbUV4RC9ONFpBd0d3ODFHWUJiQzNB?=
 =?utf-8?B?ZVBqNXZ1NXZ3b2JUNHc2VWRvdGpvTythb2swdGJ3c0Z0YlJHVnhXUXVpLzhj?=
 =?utf-8?B?VWtoSlNwSEV5Z0s4UHFFQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6f3c0a-f19a-4a30-a368-08d92122c40e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 15:19:05.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVL59HZaaZjLnUtvC+aJMy9GT+LjNyV817yVPearNc+5z6YJjPdL5HH8kQc/g6Y2lRmd0ajpOyOmYVkIKNP14Jo6or8sGNvn014YdMpZX2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2461
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
X-Proofpoint-ORIG-GUID: oxKvJoTSVIQ4iQnGmt3vgDrrx2opvCjR
X-Proofpoint-GUID: oxKvJoTSVIQ4iQnGmt3vgDrrx2opvCjR
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/26/21 8:01 PM, Bart Van Assche wrote:
> Modern compilers complain if an out-of-range value is passed to a function
> argument that has an enumeration type. Let the compiler detect out-of-range
> data direction arguments instead of verifying the data_dir argument at
> runtime.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 96 +++++++++++++++++++++++----------------------
>   1 file changed, 49 insertions(+), 47 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index c4f51e7884fb..dfbc6b77fa71 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -35,6 +35,13 @@ static const int writes_starved = 2;    /* max times reads can starve a write */
>   static const int fifo_batch = 16;       /* # of sequential requests treated as one
>   				     by the above parameters. For throughput. */
>   
> +enum dd_data_dir {
> +	DD_READ		= READ,
> +	DD_WRITE	= WRITE,
> +} __packed;
> +
> +enum { DD_DIR_COUNT = 2 };
> +
>   struct deadline_data {
>   	/*
>   	 * run time data
> @@ -43,20 +50,20 @@ struct deadline_data {
>   	/*
>   	 * requests (deadline_rq s) are present on both sort_list and fifo_list
>   	 */
> -	struct rb_root sort_list[2];
> -	struct list_head fifo_list[2];
> +	struct rb_root sort_list[DD_DIR_COUNT];
> +	struct list_head fifo_list[DD_DIR_COUNT];
>   
>   	/*
>   	 * next in sort order. read, write or both are NULL
>   	 */
> -	struct request *next_rq[2];
> +	struct request *next_rq[DD_DIR_COUNT];
>   	unsigned int batching;		/* number of sequential requests made */
>   	unsigned int starved;		/* times reads have starved writes */
>   
>   	/*
>   	 * settings that change how the i/o scheduler behaves
>   	 */
> -	int fifo_expire[2];
> +	int fifo_expire[DD_DIR_COUNT];
>   	int fifo_batch;
>   	int writes_starved;
>   	int front_merges;
> @@ -97,7 +104,7 @@ deadline_add_rq_rb(struct deadline_data *dd, struct request *rq)
>   static inline void
>   deadline_del_rq_rb(struct deadline_data *dd, struct request *rq)
>   {
> -	const int data_dir = rq_data_dir(rq);
> +	const enum dd_data_dir data_dir = rq_data_dir(rq);
>   
>   	if (dd->next_rq[data_dir] == rq)
>   		dd->next_rq[data_dir] = deadline_latter_request(rq);
> @@ -169,10 +176,10 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
>   static void
>   deadline_move_request(struct deadline_data *dd, struct request *rq)
>   {
> -	const int data_dir = rq_data_dir(rq);
> +	const enum dd_data_dir data_dir = rq_data_dir(rq);
>   
> -	dd->next_rq[READ] = NULL;
> -	dd->next_rq[WRITE] = NULL;
> +	dd->next_rq[DD_READ] = NULL;
> +	dd->next_rq[DD_WRITE] = NULL;
>   	dd->next_rq[data_dir] = deadline_latter_request(rq);
>   
>   	/*
> @@ -185,9 +192,10 @@ deadline_move_request(struct deadline_data *dd, struct request *rq)
>    * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
>    * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
>    */
> -static inline int deadline_check_fifo(struct deadline_data *dd, int ddir)
> +static inline int deadline_check_fifo(struct deadline_data *dd,
> +				      enum dd_data_dir data_dir)
>   {
> -	struct request *rq = rq_entry_fifo(dd->fifo_list[ddir].next);
> +	struct request *rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
>   
>   	/*
>   	 * rq is expired!
> @@ -203,19 +211,16 @@ static inline int deadline_check_fifo(struct deadline_data *dd, int ddir)
>    * dispatch using arrival ordered lists.
>    */
>   static struct request *
> -deadline_fifo_request(struct deadline_data *dd, int data_dir)
> +deadline_fifo_request(struct deadline_data *dd, enum dd_data_dir data_dir)
>   {
>   	struct request *rq;
>   	unsigned long flags;
>   
> -	if (WARN_ON_ONCE(data_dir != READ && data_dir != WRITE))
> -		return NULL;
> -
>   	if (list_empty(&dd->fifo_list[data_dir]))
>   		return NULL;
>   
>   	rq = rq_entry_fifo(dd->fifo_list[data_dir].next);
> -	if (data_dir == READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
>   		return rq;
>   
>   	/*
> @@ -223,7 +228,7 @@ deadline_fifo_request(struct deadline_data *dd, int data_dir)
>   	 * an unlocked target zone.
>   	 */
>   	spin_lock_irqsave(&dd->zone_lock, flags);
> -	list_for_each_entry(rq, &dd->fifo_list[WRITE], queuelist) {
> +	list_for_each_entry(rq, &dd->fifo_list[DD_WRITE], queuelist) {
>   		if (blk_req_can_dispatch_to_zone(rq))
>   			goto out;
>   	}
> @@ -239,19 +244,16 @@ deadline_fifo_request(struct deadline_data *dd, int data_dir)
>    * dispatch using sector position sorted lists.
>    */
>   static struct request *
> -deadline_next_request(struct deadline_data *dd, int data_dir)
> +deadline_next_request(struct deadline_data *dd, enum dd_data_dir data_dir)
>   {
>   	struct request *rq;
>   	unsigned long flags;
>   
> -	if (WARN_ON_ONCE(data_dir != READ && data_dir != WRITE))
> -		return NULL;
> -
>   	rq = dd->next_rq[data_dir];
>   	if (!rq)
>   		return NULL;
>   
> -	if (data_dir == READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
>   		return rq;
>   
>   	/*
> @@ -276,7 +278,7 @@ deadline_next_request(struct deadline_data *dd, int data_dir)
>   static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   {
>   	struct request *rq, *next_rq;
> -	int data_dir;
> +	enum dd_data_dir data_dir;
>   
>   	lockdep_assert_held(&dd->lock);
>   
> @@ -289,9 +291,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   	/*
>   	 * batches are currently reads XOR writes
>   	 */
> -	rq = deadline_next_request(dd, WRITE);
> +	rq = deadline_next_request(dd, DD_WRITE);
>   	if (!rq)
> -		rq = deadline_next_request(dd, READ);
> +		rq = deadline_next_request(dd, DD_READ);
>   
>   	if (rq && dd->batching < dd->fifo_batch)
>   		/* we have a next request are still entitled to batch */
> @@ -302,14 +304,14 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   	 * data direction (read / write)
>   	 */
>   
> -	if (!list_empty(&dd->fifo_list[READ])) {
> -		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));
> +	if (!list_empty(&dd->fifo_list[DD_READ])) {
> +		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_READ]));
>   
> -		if (deadline_fifo_request(dd, WRITE) &&
> +		if (deadline_fifo_request(dd, DD_WRITE) &&
>   		    (dd->starved++ >= dd->writes_starved))
>   			goto dispatch_writes;
>   
> -		data_dir = READ;
> +		data_dir = DD_READ;
>   
>   		goto dispatch_find_request;
>   	}
> @@ -318,13 +320,13 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   	 * there are either no reads or writes have been starved
>   	 */
>   
> -	if (!list_empty(&dd->fifo_list[WRITE])) {
> +	if (!list_empty(&dd->fifo_list[DD_WRITE])) {
>   dispatch_writes:
> -		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));
> +		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[DD_WRITE]));
>   
>   		dd->starved = 0;
>   
> -		data_dir = WRITE;
> +		data_dir = DD_WRITE;
>   
>   		goto dispatch_find_request;
>   	}
> @@ -399,8 +401,8 @@ static void dd_exit_sched(struct elevator_queue *e)
>   {
>   	struct deadline_data *dd = e->elevator_data;
>   
> -	BUG_ON(!list_empty(&dd->fifo_list[READ]));
> -	BUG_ON(!list_empty(&dd->fifo_list[WRITE]));
> +	BUG_ON(!list_empty(&dd->fifo_list[DD_READ]));
> +	BUG_ON(!list_empty(&dd->fifo_list[DD_WRITE]));
>   
>   	kfree(dd);
>   }
> @@ -424,12 +426,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>   	}
>   	eq->elevator_data = dd;
>   
> -	INIT_LIST_HEAD(&dd->fifo_list[READ]);
> -	INIT_LIST_HEAD(&dd->fifo_list[WRITE]);
> -	dd->sort_list[READ] = RB_ROOT;
> -	dd->sort_list[WRITE] = RB_ROOT;
> -	dd->fifo_expire[READ] = read_expire;
> -	dd->fifo_expire[WRITE] = write_expire;
> +	INIT_LIST_HEAD(&dd->fifo_list[DD_READ]);
> +	INIT_LIST_HEAD(&dd->fifo_list[DD_WRITE]);
> +	dd->sort_list[DD_READ] = RB_ROOT;
> +	dd->sort_list[DD_WRITE] = RB_ROOT;
> +	dd->fifo_expire[DD_READ] = read_expire;
> +	dd->fifo_expire[DD_WRITE] = write_expire;
>   	dd->writes_starved = writes_starved;
>   	dd->front_merges = 1;
>   	dd->fifo_batch = fifo_batch;
> @@ -497,7 +499,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   {
>   	struct request_queue *q = hctx->queue;
>   	struct deadline_data *dd = q->elevator->elevator_data;
> -	const int data_dir = rq_data_dir(rq);
> +	const enum dd_data_dir data_dir = rq_data_dir(rq);
>   
>   	lockdep_assert_held(&dd->lock);
>   
> @@ -585,7 +587,7 @@ static void dd_finish_request(struct request *rq)
>   
>   		spin_lock_irqsave(&dd->zone_lock, flags);
>   		blk_req_zone_write_unlock(rq);
> -		if (!list_empty(&dd->fifo_list[WRITE]))
> +		if (!list_empty(&dd->fifo_list[DD_WRITE]))
>   			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
>   		spin_unlock_irqrestore(&dd->zone_lock, flags);
>   	}
> @@ -626,8 +628,8 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
>   		__data = jiffies_to_msecs(__data);			\
>   	return deadline_var_show(__data, (page));			\
>   }
> -SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[READ], 1);
> -SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[WRITE], 1);
> +SHOW_FUNCTION(deadline_read_expire_show, dd->fifo_expire[DD_READ], 1);
> +SHOW_FUNCTION(deadline_write_expire_show, dd->fifo_expire[DD_WRITE], 1);
>   SHOW_FUNCTION(deadline_writes_starved_show, dd->writes_starved, 0);
>   SHOW_FUNCTION(deadline_front_merges_show, dd->front_merges, 0);
>   SHOW_FUNCTION(deadline_fifo_batch_show, dd->fifo_batch, 0);
> @@ -649,8 +651,8 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
>   		*(__PTR) = __data;					\
>   	return count;							\
>   }
> -STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[READ], 0, INT_MAX, 1);
> -STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[WRITE], 0, INT_MAX, 1);
> +STORE_FUNCTION(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX, 1);
> +STORE_FUNCTION(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX, 1);
>   STORE_FUNCTION(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX, 0);
>   STORE_FUNCTION(deadline_front_merges_store, &dd->front_merges, 0, 1, 0);
>   STORE_FUNCTION(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX, 0);
> @@ -717,8 +719,8 @@ static int deadline_##name##_next_rq_show(void *data,			\
>   		__blk_mq_debugfs_rq_show(m, rq);			\
>   	return 0;							\
>   }
> -DEADLINE_DEBUGFS_DDIR_ATTRS(READ, read)
> -DEADLINE_DEBUGFS_DDIR_ATTRS(WRITE, write)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_READ, read)
> +DEADLINE_DEBUGFS_DDIR_ATTRS(DD_WRITE, write)
>   #undef DEADLINE_DEBUGFS_DDIR_ATTRS
>   
>   static int deadline_batching_show(void *data, struct seq_file *m)
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
