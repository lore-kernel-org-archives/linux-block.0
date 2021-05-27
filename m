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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B7C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEEE61358
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhE0PRN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 11:17:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47140 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhE0PQe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 11:16:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RF9DqP067802;
        Thu, 27 May 2021 15:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4LedU5Z+GeOlAEl3NTrNiB+ioXR07+cdZEZbHFDSnWQ=;
 b=AxeIW4bvbsgMzQOgUu45vxIn54GJtWEsCMW2gYI8upX80ljz9xYX9/l2YMNKy1GZAjHq
 Uwo0leezwPhSWNgFOG3gEuQuVhBTKWC9rEfXXDAiJqyquXMIH1mwTb8kWF7Be82ld653
 lievCF5x1MY5xsy1P74bj/9vVKW8fE1KDkN5BTT1VG6fqn1sZA8vlctQcsWIh96JcyH5
 mAu4mNn17yqWzZSFfasZzMk+LrSs0C60Az9QvWSiemowxwsfZt9TRC9k2XAw+Ux/3dq2
 Xf9xoz86NfNiBK4/j69+0rA5c+tq6m/zc3vmfz1GrKbMuXAelaP7L2dOm4IUmc/ROwDC qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38rne4824g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:14:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFB8Hx112510;
        Thu, 27 May 2021 15:14:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 38rehgnc81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkizIAi+QzcuGauw+E6v9Otqa1LdgMn/w/F4Esrxm+d0l2rD52kKTUTEFM74t8OnkBNFrFDs+XkO2Hvpoea958bYYfG2fkWvmKQyS150zkLfHmjYP0K56aDV2NtqfrgzFBHhjlw4Jn7GfODFZ3BrkCxWAUoKXwms3lC3UAupxwMYHc6M77sOylX0p2qHu+agOCRRH4DYCzeWgP7ee88RYMYmx7x5RkDdcxwBTlsJLoeq4wL68/tNZcWKcMRW9cO2+QywBTowJLyYjAL5fBFVzQpnv9LSfIEqi0hPA1ztT2/toBgVAcbRt9MHl/chfn7qzDICweGMPd6+D+P/aZbchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LedU5Z+GeOlAEl3NTrNiB+ioXR07+cdZEZbHFDSnWQ=;
 b=ngOt4ED8Pjhfccri9Oa+pegGtwXf8To3eUl50LcYXNbg9PDfRA2WwJ0apSI/iw5/H1leBLqMvNxxX8t1FOtaWvBMntQMqxxaDecxA2VAy6ze28AN0GEUnTEAek+feFmCGq731yEKYBqEfNdoug1+I855iJ4Hg+w1RBDPhSbjeMigVx94RlP9TU57rC7YdyG9ydsWNytU2w9twL7yunvGw+a4ROSLf4z5rDRC79hy0UwOgvbGxbzFWksDnsZa0yU3OC5C7KPRjc6mXb+wC1/YAtSsZl0oSQiKC24J7sCZIaOx28MdVb1aY8GmE/OOFnf6Onljq3FxSGqQIR92hyr7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LedU5Z+GeOlAEl3NTrNiB+ioXR07+cdZEZbHFDSnWQ=;
 b=C1d2N6Tlr2QenePwkaSWroJnMoRvrlCWTgS0PjdnICUD0oZm17WJPlnvPtnyncK2tuhP2gAhleZRwegbHt3uvTOt4E8iFiX6s22WQVtYMHDlBnp0IqOBT3obOEGB0m2RPn6hRnTIhQyrqkPuQi+Up2cCsmm+4CJ+zIt9RROzPaQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 15:14:51 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 15:14:51 +0000
Subject: Re: [PATCH 2/9] block/mq-deadline: Add two lockdep_assert_held()
 statements
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-3-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <d31afd4d-388c-a4b7-8944-8642a141ee40@oracle.com>
Date:   Thu, 27 May 2021 10:14:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210527010134.32448-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2606:b400:8004:44::12]
X-ClientProxiedBy: SA9PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:21::6) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::7b4] (2606:b400:8004:44::12) by SA9PR13CA0001.namprd13.prod.outlook.com (2603:10b6:806:21::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Thu, 27 May 2021 15:14:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d31e05e9-dd8d-43b5-3daa-08d921222caa
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:
X-Microsoft-Antispam-PRVS: <SN6PR10MB302229E34C2B1FB5129E25D5E6239@SN6PR10MB3022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DY8OK6itBHbYF264d8K9gzyI3V40tC1Whtxr5fkcH+1FgS845Oxpz2BWd2BlfYjmcVlqhDldySTdURcsvnzHNx5KH3Ckare4BXQFZB7Iu4FeafNayBpEdmxgZylQT5hc5SH0VxknKvrFgD/5NYi6LIHgDJ5szDfqoccONNyqf4LXcAgRIEYcaSqtH9StqeLGic9tTY7wcngoiBuaf2qm5t5/9Svls3BjAQ8zEZfYZ1ojW9ognr3dl+Vd49n2+C0Ss6BeuKHL1mnmoN3uybi7Zjv4d95OMjsPDFoVOvspoPQs/bwjQbC2yFNvkvTFBKXBx9VCs4q5PXOa6kRbo+JMDPskfHVgJLVeVlBkU96qMXbvBWyjWv13pWdHY6G9UmReM28V2gDrmeu4wy+uA0yrRbv9nW1EzJo7rhm44NBaTS+2OCcw0evzAVEG+a+aGVPpOlo7TOcLWWFs4J08JQkOrjQe/0KqVqE0zrmvnURnkfa3rfNf3MOD+jXtdyrStFcF0HJx7gR1lxJTs2REyFtCMjLN+KZgDN1Zc/ga3VnnMzUcTXqN6K9NWa6CCj/F0/Kdj9cNeaN/ZayteDNeWjCccLBxaGMABCRMtk/sShquUsIcsJD/trsTixWR/3flnIDGA9+xkjlYFl1I8/jKygaxnjL0vxMHdV0Jl1cFRYJv1N/Lj9e1y47V0uAwXzf8e+Lm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39860400002)(396003)(4326008)(38100700002)(2616005)(66946007)(36756003)(66556008)(31686004)(6486002)(186003)(66476007)(44832011)(83380400001)(8676002)(316002)(86362001)(2906002)(8936002)(110136005)(16526019)(54906003)(53546011)(31696002)(478600001)(5660300002)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SHZETjUrN25ndllSSG5LNHB5alphSGMveHozU2hXSEx4azdqQ2d3Y0hPU0hP?=
 =?utf-8?B?T2dpSk1yUG5PK3Bta0UvRFk0QjFwMks2T1BvcmNrcjdqM0hVSWFuVUlIaWpR?=
 =?utf-8?B?THZRdkRuYXZBSW5OTUJoNTJQdkU5dzhmenFmSzRWWUh4cTlNcXF5OERuN2M1?=
 =?utf-8?B?S1dOdEk5WUNPOTgxN08wT3g2aEFZWUFRNWNxUjNMZlFMc2tUczU2NWZPdVY1?=
 =?utf-8?B?ektmYTFrQnYrY2xmRlRIU1p3K0djZHk1MHpnZERlUEFuRWVsMHJGY3VzWGlh?=
 =?utf-8?B?OVc5RGpTTTFMNEF1VzV6M2c0cXpBWjFaUjZZQnRvYXlBWHFOUkZYbmVlNzJC?=
 =?utf-8?B?QmJIdHBubWdveGR3Q2RaT2VhTGdnNkN0NnlsVG03L1pka2R3NDB6OS9TM1Jo?=
 =?utf-8?B?bStnd0R5M2lTTWdzS3EwZ3JDaW9WRVo2TldsMWZ0Y2ZHc1Q1aXczRUExWDdX?=
 =?utf-8?B?b01VeG1hT1d0M0RtWkZQS0ZoZ0tVQjlySGhMYnFqMzN6cEFtcUJaVTdZK1RU?=
 =?utf-8?B?MTh1cDlWdU52dXVJSmdwRExSU050ZXRzMmRoejMxOUJwUTVNcklxalNtanhF?=
 =?utf-8?B?VkNQWU1jaFJnUGh5NW93MmdBTSt5Z3Z4YU5DUS95bWxvbURpRVpuMlcrYzJy?=
 =?utf-8?B?S3NTbXdoTkpKUVViTExvUGwrOHNsYWpkRlVjaUpPQTZ2T2IzR1BjTkRvWTJw?=
 =?utf-8?B?ZFVzQTJCY0ozbjQrbnVpU2VWQkREVVdUK0U4VFZUemFva3M0aG1zSHRYNkth?=
 =?utf-8?B?UndJRkdtaVB0UVl3ajZBeUNEZ2xjQjA5dzUxZ2tVNjh5NlNpbG9xaHpHZzAx?=
 =?utf-8?B?SDBoNCtGZDh3Tjc2UzMwcEZLT0VLVnpPVVNlS0c3emxodWRzSVM1c2FSdmFt?=
 =?utf-8?B?WHJoVlNySHVmWUphZGJUWkgrVnNiS1lUUUlWSmYwWmZzWmtnUU8xeUFQS1gx?=
 =?utf-8?B?UzBGbmtxUjNmZmpJQjJydm5HQjFxZXRZRnhkVlJidXNRRDd5S2dERUcwRHV0?=
 =?utf-8?B?N2hINmFZdUpycWtteWNZbkdpNkV6cENIWnJXT2gzazBlNUFZTUFHOC9wNjRP?=
 =?utf-8?B?YXRYcjBqbWkwM1cxd3V5bnljRkxleTNHRkJRZkV1QVA2ZUU4VFhZc3NHTDh1?=
 =?utf-8?B?MmdZOVE0K0d6YjJJaG5BWUU1SXp6TUlhcW9LSXBsc3ZKTjU3b0NieGFjQnk3?=
 =?utf-8?B?TE5XbXpVY29GU1dYdjQ3MjJNTitIM3YrVWdVck9DOFdDRmxoU0hNa0pEYWhs?=
 =?utf-8?B?VnR6Zm1mRnhLcmVVVVdVa0xjemtlRVAyTXc2VVlBTW0vS1htWVBmMldqR1RN?=
 =?utf-8?B?c0RMWDVPcEx2VXNhQTZWSVFLZE5qTllnTnNjRmFaRHVZdkpLTWZybTNlUkdL?=
 =?utf-8?B?ajUrQXlvYVBDd0xvWVV5b1VrWlBNMWlSZjJsQ2llRG9HN0xwUnZrc2c1N3JM?=
 =?utf-8?B?aFJBYyt6ZE12cHk1UERGSzN0U01rT01XRjJwWU1rSlk4SnFobXh6Qm9QNFRY?=
 =?utf-8?B?MUVVSzlkNlorUnZxd29kd21uT3VSNjJOYnk4dXo0VzBMeHdkTGV1TG10cnp5?=
 =?utf-8?B?MDRWV2wva0Z6TUJmY3lXVDNIbjZSdUZUTEM2WitMRnpCemwzeitZd2RzRmZq?=
 =?utf-8?B?bjhNT0FwQ3pRcmxuYnhYa09BUmtkNlFKaW9SVytNTUdNU20ySE5mb3ZVU2kv?=
 =?utf-8?B?MGxKQjF0WE5BTFltL1FEUkViZG9ydFF0VlR6WkpuSGxLN2xIM3N4UmNtWWdE?=
 =?utf-8?B?TnlLdFZad2R4Nkh5THV5ZEdXTGIxOVpVUUw5Qk5URVdET2N5ajh0eFYxMGhQ?=
 =?utf-8?B?QWdHWHZOcW44VmplRk5Odz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31e05e9-dd8d-43b5-3daa-08d921222caa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 15:14:51.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBEefDig9XXR21wjShVp+MS3g6N0tqYPe6UaPCkb7tMRbR8h9QpYsVHJhjtSxLblmwS/sD6JIGn2SY7OKsc7APAdXSXqQ8wA8UZdNMxOngc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3022
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
X-Proofpoint-ORIG-GUID: W5865YhMSeJS0VTe-gHDnQoftpFGnDGu
X-Proofpoint-GUID: W5865YhMSeJS0VTe-gHDnQoftpFGnDGu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270100
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/26/21 8:01 PM, Bart Van Assche wrote:
> Document the locking strategy by adding two lockdep_assert_held()
> statements.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 64cabbc157ea..4da0bd3b9827 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -279,6 +279,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   	bool reads, writes;
>   	int data_dir;
>   
> +	lockdep_assert_held(&dd->lock);
> +
>   	if (!list_empty(&dd->dispatch)) {
>   		rq = list_first_entry(&dd->dispatch, struct request, queuelist);
>   		list_del_init(&rq->queuelist);
> @@ -501,6 +503,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	const int data_dir = rq_data_dir(rq);
>   
> +	lockdep_assert_held(&dd->lock);
> +
>   	/*
>   	 * This may be a requeue of a write request that has locked its
>   	 * target zone. If it is the case, this releases the zone lock.
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
