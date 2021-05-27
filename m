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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008DC4708A
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819AE60724
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhE0PQR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 11:16:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50374 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhE0PPh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 11:15:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFAvpP144495;
        Thu, 27 May 2021 15:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mRMuunGt6SbZ3Mwwg9F1oOHRvrneB4YuFD/IE9fCOZ8=;
 b=TB6MNlbNc+FcKGKuGzG9AQ7emRKN9419NjgIF97sot5/X4QvlpgyOeMza3MbGzJVDGWu
 Amktww511304AEOxOwJwCtYkUnyGNkBLL+bfFcA6GKrzGqGkn2m6oPdQd2J+tXV3hlkS
 eVSb76rjI7werPaHT+8x50E4mlHVXFDW9re++Cg8GZnjjwkZk9VvElAaD7Pql8uQ8nus
 1sHFzuKyddvymeg57R9JENce00GnEEw0re3fn6OtKou3vNQw8LeBIbwxK4oPXgt9/Uju
 HBvR21ZNFPOmwxLHApo90b0GBx4Cv7QIIi01oV9XLscx/JlzfIQjjMkAGKEdWAHB3m3Q Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38pqfcmj7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:13:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFBcc8195962;
        Thu, 27 May 2021 15:13:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 38pq2wg8hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWHBqdX/VI2OSDfsVBUQqeqbd55H45gfyJI4X69fC0Ix3ecr+pNaRHZXx1V6mhiADb5EvePajsGAlSOi0U9OGOuvIqHUyFxRfRSbFa0r5PoMSYx9Q9P0HkiHY80la1gGFnzo7eztpguBnYEX2JmKjddjpRCzBfAk8HnL0l79Z33Q57mmyzBLPVXHZTZq2KnG0TZlT44bXnI5tmRuQIr5wsOCgkKxSzaoKvHxvoC65tTGTc6dPM/4jDVOscjNiKuTQvg5I/5zUzcdrMQHV+ylkd7kdNBHHXQFw/esyTMyatjEI1p6+4vkGmgvcqQpCuEx0fDL0KiR3nZlQxi6dnij1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRMuunGt6SbZ3Mwwg9F1oOHRvrneB4YuFD/IE9fCOZ8=;
 b=DN2u/Ag7ccff4Rtj0qvk5+qiMSvpU+n3TAS+e2eyaNDYhdVwJ+/89klnF13FYUuCeNzYcmoiIt9Qx4nXVHLrGNUiQw51gSSedC4RZVCNMUL61joZSBlh41Z7o5aAHXjyw6qVS1Hlyrcm61Wt9R4FVluLs/rSdjCfYoNopNtSbkF1gfkXoU7ktX2NZeKeLqU3q2ooyqNr0V0HBZ7TgZmgqWXAETxnj5gh0gGf+AOt7OOjCjtdIddwTX1Dyt6bUefmhP2+2cloQ1bKvS7BQ4vSJDAe5PFZS+7hGW4w+aVqwh4wOJfZOYGG457jaoCWr3J4pr1v8/VUD0q8nvWHnuGnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRMuunGt6SbZ3Mwwg9F1oOHRvrneB4YuFD/IE9fCOZ8=;
 b=KDqsb2nxWUadPQurWcISBWEgnirZ7cDc8HPWEddFPJswYtn5CdTTv9LnaUwv/MgUqU/sTmlKJ1ApRcGOCpBfB8nEd6tKDSnkXg08U1yXdxYlA3hK4kDyLUc4yEGpenEIv7fgYviOai/0X7FYzHyslr8YcqjJOvpD62gmNObKaOQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 15:13:51 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 15:13:51 +0000
Subject: Re: [PATCH 1/9] block/mq-deadline: Add several comments
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-2-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <2432ef89-b105-5027-cdda-320d8c7c31d2@oracle.com>
Date:   Thu, 27 May 2021 10:13:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210527010134.32448-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2606:b400:8004:44::12]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::7b4] (2606:b400:8004:44::12) by SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Thu, 27 May 2021 15:13:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d0ebb45-e97e-4c43-5939-08d9212208e5
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:
X-Microsoft-Antispam-PRVS: <SN6PR10MB30229409E0F4AFD0945974F3E6239@SN6PR10MB3022.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbrUYj4AIgmQcQJNAod0OS2BBJR4yTpYDyUeex92oSasZGJifp/gPIL/YpxTJDJvT2IApdWx0Hb4s5duSWCbJAE73ztOBkMDXurNhumf5sYFgC82cLid6GBytX3hcVWIPKVtwzUxEBe+2v2oBYbe/1312HlWeIMjI1L48rFUakwZnmmJbuuJijzoj/09iqJmf6b5tyaXp//nVyUnimBq9yZSqPVP2sURXZ+OZgiagOvAaZL3M4sQuQmv2aukffCmy6e1mWG6dj2r5W+z9kC0AK2mWKJJLp+ZJFCImHQesI5tkuSLqYxqTAxnqA65m2siFQ4t0xK/teGFET8QqUOL8X5QkVmzGoJ6zZNvsdOrDGjdudeyKGCB/weRVe9A/XgRRKY/StiPiAtqZ0z0iBy4jmFeIBOntUoMTl2vHwHfz6NUJJgbIqErYjBJ7u0gj2OIeBqj+Ubdrss6MHhNzp3s2s90sYmg72pgn5CoVYEBI0eVhAKmqS2ed/7rkIG2bEH6TYL5qkxuA1htZlDHbCHmJfYRlQKyFWjRZ1ct/yQ12jFAYUCbhVQfMpI3MoEhJaVHKC4ArDp/icazT201LtIj6vho8sTvsPMCD2v8IwBNfNJdTDYrkogmqPOZe0CZFVbwJkaLeuphgLsbMZ64ta5LesV5xJ9ZeWEOe+jo5nyyESZEBwxN8YhW74EJg31/Vuxu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(346002)(136003)(110136005)(16526019)(8936002)(53546011)(31696002)(54906003)(2906002)(86362001)(36916002)(478600001)(5660300002)(36756003)(66556008)(31686004)(66476007)(6486002)(186003)(38100700002)(4326008)(2616005)(66946007)(8676002)(316002)(44832011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aTEzeXk3bER6dCt0cjVwb3JLcmtOdG9Zc2FoK3IrNkpMV2dSc1BBdlB6cmp5?=
 =?utf-8?B?VmV0K3BoejEwaDlQQVpISlladll6VjdJa0U4azBGU29lK1RkUnJwZzlOUU83?=
 =?utf-8?B?TGEyU0JleWRpbm9oUG1TY29BVXdFcXhjdHNpcWlZK0VmQ1NFc05GRWhxWENk?=
 =?utf-8?B?Tm5sekNRQTdUdFU2M3REQ0VPckFYN1Z4WkV1cXRkdFQzSS9UV1Z4Ylo2eG5J?=
 =?utf-8?B?aU9PSEllL0N1OTdUM1IxeDBmNVA3WkxYeDJBNjluMXZzUzdHZWlidWRpNVZm?=
 =?utf-8?B?SWFZb3Bob2VTQlVTRDQ1ZFFvMG1iZHE3SXhhYjljY2prV1gxUkJESm90SnpM?=
 =?utf-8?B?Nk1uYXhxREN5YWtLR1RyMEhFYjkxdHRaL3hHV0Q0S0JKSGhrU28rRGkwcjEw?=
 =?utf-8?B?V2Y3L0UvRzNScmd0ZkdjRlZVTXBFMXV4cXZ1emxCV3JCYlVYZXo0WmlCemRT?=
 =?utf-8?B?eDFlRVZvY0p4bGZPcGUvVVc0a3AwNEFqUmVvTVNuTVpHd2gvZW96cXIxTXIz?=
 =?utf-8?B?SVhuRUFxUWhTdzlBU1RPYUJYTFc2ckhUblJoVjFLSy92Mkg0TE1KTERkVzBZ?=
 =?utf-8?B?SjV3cGpPUTFicFpYbjV5MDFYNTZjdlNRM0w2VkZYbHVsak5xQzA5N1oyaXl4?=
 =?utf-8?B?WjNjTHVVcFpad0xqNzJlRXFlQVliQjB0YVoxTjg1UmI3ckNXaWQ3SEszZTFm?=
 =?utf-8?B?UGxPSzhGOTk0ZnVGOElidU9BeDJpaUNFbVBWTzUrZVZqbWlzbkdxMW9YcGVv?=
 =?utf-8?B?dnRpSUE5R1UrdE9NTGpsUFB3MlpLZXYyQ2FzY2V5dDhnenNnMURuVnRobHRL?=
 =?utf-8?B?SGp5NGlHVVdsSHUvOXMySnR6RjlkRmxCRDJFV2xHb3piTVU2T2FpNkhta2dr?=
 =?utf-8?B?ejNUSHpxbko2M0JrQm5TN3MvUjUwVFdXOVJVUVl2NlVBS2NhZDFnaFlEdWxJ?=
 =?utf-8?B?S2h1eE8zVlVPTzcxdm5YeFpvdW5lc2tvWjFsTzd2MDA4czdtN253bEE5MVRm?=
 =?utf-8?B?V09ydUlvMXBzeTlSMTU2ZkZuZklZOTlxT3dLdjY4N2doNU5TeXpNeVNZd3dl?=
 =?utf-8?B?OHRuRVpya1N4bUFvcXpzYmU1OW9tVFphVlRmS1FZaG5aa0tYMVRLeGdmNTFM?=
 =?utf-8?B?RDAxTjlVbSt2SEp5YW44NjUyUHpoN3VsSUhvdEV2cnR2eFQ5RTFrbDVYeUZY?=
 =?utf-8?B?QStKOGRST1F6UHdNYTFmT0phcjJSVVVnV1pFOFZwdWxSRnFXMCs1cFVISXFD?=
 =?utf-8?B?SU82dHYvTEUvTzFJWGxpOCtIZENEMmt1ODJZYmt6c0ZVSXZ3TzQ4a1VWRU12?=
 =?utf-8?B?NnBiWXVkU3JOK0FSNHJucE4yRW1CVjBobUVTcXloUUF0YUhlYWFMNGlqQkl0?=
 =?utf-8?B?UDRKd1hhblhxUGZMQytqN2ZubnArYWZtdW5BUHhjdEhjU1B4ekdINDVrRzJE?=
 =?utf-8?B?ME9SYnRvRDN5S2xqZjErWVhSeXQrZjhpMUtNMkhpVnYvdlpleHBTTXY5eG1K?=
 =?utf-8?B?dHhybEEzdndQaUZYU0pra2pyR1JURG1rVzc0SmVvTTJOajJaVXJQclFjcjVJ?=
 =?utf-8?B?amNwbzQ4emorU210VUFhK2w0Ty9DNGNDcFR5bEUydG9KQzNUYm1GZ0grMURz?=
 =?utf-8?B?ZEFwY1NyMVgrdVYwZHFERy9MbzY2M0tXQzBmSTd6TmZHSGtOWDNmTjNOYXRk?=
 =?utf-8?B?Ny84N1RmQ2kzQ1hRQ3RrblRlek1SZ0V0K2xsWFBpMmdBR291bjFwa2pJMGdX?=
 =?utf-8?B?WGRhbXFpNDcrNWhGcXlkaDlqU0FhQWVSWWphNnJYb09LS1JmNm4wZmczOWtr?=
 =?utf-8?B?N3dGNEJENUZzYmp6SWx3Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0ebb45-e97e-4c43-5939-08d9212208e5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 15:13:51.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykWbPqu786C1Sc92HA/SmoXTiJaYcMgQ1G1OTYA8TsrWyH6gDsK6gAElgUpzEk7JqEwFI+doENSAUzh/vGyPmdZKAzfmRrJOa6mraxtb5IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3022
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
X-Proofpoint-ORIG-GUID: G_DHKSP3vsMPnoVyN7CF7cylZeGoyYIU
X-Proofpoint-GUID: G_DHKSP3vsMPnoVyN7CF7cylZeGoyYIU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/26/21 8:01 PM, Bart Van Assche wrote:
> Make the code easier to read by adding more comments.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 8eea2cbf2bf4..64cabbc157ea 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -139,6 +139,9 @@ static void dd_request_merged(struct request_queue *q, struct request *req,
>   	}
>   }
>   
> +/*
> + * Callback function that is invoked after @next has been merged into @req.
> + */
>   static void dd_merged_requests(struct request_queue *q, struct request *req,
>   			       struct request *next)
>   {
> @@ -375,6 +378,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   }
>   
>   /*
> + * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
> + *
>    * One confusing aspect here is that we get called for a specific
>    * hardware queue, but we may return a request that is for a
>    * different hardware queue. This is because mq-deadline has shared
> @@ -438,6 +443,10 @@ static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
>   	return 0;
>   }
>   
> +/*
> + * Try to merge @bio into an existing request. If @bio has been merged into
> + * an existing request, store the pointer to that request into *@rq.
> + */
>   static int dd_request_merge(struct request_queue *q, struct request **rq,
>   			    struct bio *bio)
>   {
> @@ -461,6 +470,10 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
>   	return ELEVATOR_NO_MERGE;
>   }
>   
> +/*
> + * Attempt to merge a bio into an existing request. This function is called
> + * before @bio is associated with a request.
> + */
>   static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
>   		unsigned int nr_segs)
>   {
> @@ -518,6 +531,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   	}
>   }
>   
> +/*
> + * Called from blk_mq_sched_insert_request() or blk_mq_sched_insert_requests().
> + */
>   static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>   			       struct list_head *list, bool at_head)
>   {
> @@ -544,6 +560,8 @@ static void dd_prepare_request(struct request *rq)
>   }
>   
>   /*
> + * Callback function called from inside blk_mq_free_request().
> + *
>    * For zoned block devices, write unlock the target zone of
>    * completed write requests. Do this while holding the zone lock
>    * spinlock so that the zone is never unlocked while deadline_fifo_request()
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
