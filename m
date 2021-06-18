Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F56C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74ACD613BA
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFRTvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:51:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51306 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhFRTvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 15:51:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IJgRjs021405;
        Fri, 18 Jun 2021 19:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iRWEkJ85Egj4kF/MWp7srSxqLHUGHT2l74KMbobWRkk=;
 b=IbweypfqqQRy+JkhAfUAhCm336CVEaSOFvbuDzS1mqc098XhDZt6ps46rngugUm5UJG/
 xw1ZiE9nb+WCAu83yoL+/Zgpr3bhPwQXBOA/x10szS4hlEVHTwClDlQKsAO3VkHcLHFm
 Ta92zSY7iWhZb3lbGY+f/ekJMYSN+14uNV9c2aZFoU0YDx1mw1ga9pHeFbthn5MAjW/4
 6emlCkGuLDH87B1Q8fmKyERh3UzwkxVqRelbzFQlKba/Qq8PomvjBPiXvICgE8f4JrK5
 8jSzZ+LpRwLcPvIRP9cwML26T3WGLFCfwz9X+QFiLasYKv9+CWZKGvfqkNAATw+9wStN JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39904886ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 19:49:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IJfDKE144987;
        Fri, 18 Jun 2021 19:49:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 396waykcdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 19:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBr1iRVrWF/ru5LCA/LjOR0K071MrT/OuWHZr9zJR34bcj8emU918sy+2hOyCuJa9z2NrV1HqXlgoOYslwqF7j3snpqET0La76VN06MhtSd2O+ILQ4yzwgriXer0WS/cjbrBlBRIoDlqmp7EzLA6eMiCLgGlZjKxJmdtZZf6+fjq1T0JPpC9342caTZsco/LrcGk8OGHovnssVtMUv+F0i65EdbCKoSdJx7Mz2Gc1M6P5acRw6iIDlht+loWWZaDH4IcFBv913vxfWHgLP2kEnDSs8feo9a985+cmorHIbtOWcelIZir0LcKCAjYfCOgjMo5sVKDkOHOEPCjDR5/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRWEkJ85Egj4kF/MWp7srSxqLHUGHT2l74KMbobWRkk=;
 b=b5vH37Lt5ciscSfbV3vqHrp8v9bcohYsgMkNfm/oNfNcwAeH3iWbqtc8IWDo5AbIbXTmtyz6bTZIEki7KPjhxw9imzfDXWpYJUAFbfkoYNPaPSEApDnssrWCFPVFKpjLPfaZgWB6gQoywEMTLnHTzYYWNzTSaVcB4wiGIjfyNwlrEGGwR6AVIYDvDZAuz+ngAuBt8hUKkHanUXn5dp+5TmaVFVXsmMCe+UPZht6+cxhjLXOHy85m60EPfIVbr/8zd0On2j5qb3gy4V2DlCC4+J5snN6xIdwYS4Buhk14UNv72ilLXseez0NAC8vZs2yrcWezjRx1XHwxyRh1jsDiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRWEkJ85Egj4kF/MWp7srSxqLHUGHT2l74KMbobWRkk=;
 b=umja+FJyqRa2MrYs/xxYCDX2kcWr40pFaJFrVKG4J8ETZC4Sphjk4kCfBaV5MjKPfK+6v9oVgQoLF085Iz6yAsxL1OurfHH6SLiLd6WAyNCxWwp76vMMyaZYMbImI5SrGsHOmgCHpxRTqDU6WUx3kuBjZYwhF++dyNIM4/rXsEM=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 19:49:26 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 19:49:26 +0000
Subject: Re: [PATCH v3 03/16] block/blk-rq-qos: Move a function from a header
 file into a C file
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-4-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <dc50dc40-f9ec-baf8-6cc0-5f5ca10f41e7@oracle.com>
Date:   Fri, 18 Jun 2021 14:49:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210618004456.7280-4-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SN1PR12CA0052.namprd12.prod.outlook.com
 (2603:10b6:802:20::23) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SN1PR12CA0052.namprd12.prod.outlook.com (2603:10b6:802:20::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 19:49:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 980bfca1-9a66-4db4-be34-08d932922d6f
X-MS-TrafficTypeDiagnostic: SA2PR10MB4668:
X-Microsoft-Antispam-PRVS: <SA2PR10MB46682EE243AC4919C61B3651E60D9@SA2PR10MB4668.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1obnHlCxJI+qrwNIeNfp+xJVWuV3nEDRQGVoFbl2wRPsSV7Jb+5K+GNNQOImAWFSkaULHOiETfLV7mnVAkN8tC7cG04Hm7jDFFR3l7XVq9XPgjyGsk0uKjy0ZFBF8tX6iavmqMDIk15tZYFhsRkqhzf/y4Ad6Oi9kkC8Loj3/IdpYPX5MSZoOL+XWFgK79k1jxgIHrw75+6j/lrcbxqxS7CAu0TxKMzlOt2uoK+v3U25K+58jhjldO0U0qqwWPjQwMBaoBaLip+/SuTgufWrsUBn0XUcohh8scbGzMRguBOKbY1JXcn18vIxAOU6zP8dtryG63273gTr0siq1SiX4WQ3OALNnEHJFt9WC+NOK60PgoWCbZPsGLRhy/4rakjGhK0w6LlLhkTOMHJnIWppZG+0jlVMWZyIXoNp1Joarsbm71yAJLCOliOyS8SjMoYHBSy+csG79d+/HiYVqPC10I9Q8Lq5iW9RgxtaPSzwk4AmK6zH3qSZscWjLfO4a0t1JFaspoXEnJKuLI6R2lgcclvXEmJk62yf+QMRd4rD9/bRR5bsoxn0+Ry29UJGKeY2vUwOfbu8VP/dpcor3SmKi/+8gRSUdsMDFzH6I2SI7cW20jFRb1GRm/D9GGyPv91Z90/RtAl7SD83xOsibpCWH3Qcxclb67OfPOOOhva+PkcBEcRRKegQjbcd4Woh4FjK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(4326008)(83380400001)(53546011)(38100700002)(36756003)(2906002)(31696002)(31686004)(7416002)(8936002)(54906003)(36916002)(110136005)(16576012)(316002)(5660300002)(8676002)(86362001)(6486002)(66556008)(66946007)(66476007)(26005)(16526019)(478600001)(956004)(44832011)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklBaVRxSHJLYnRqMXQ3ZDVDd0JKYmEvOEdsWHJxMGVpWW1Ud1NaaDB1YkRj?=
 =?utf-8?B?MTJSbkNSZGN4cjFMNEVhZGFHUnRsMFBDY0c1b3pWeHJGREV2cjR0RGxyeEll?=
 =?utf-8?B?a0c1Z0FDNXRDR2huRHNhd0JtN1lOeElLcEdZeU1wV1dvcktNcXhCY2JwMUlO?=
 =?utf-8?B?SmZpdmFzY1ZZN29ab3Uwc0s2RGg4Z2pNMU1WS2RSK0RaT2hFOGtOQy9aMFRa?=
 =?utf-8?B?YUMwWTFIbS9vMnRsUmd2NlBGRkxSWW8yUHhPandPd2ZWaFpobWlJRkxBUlFM?=
 =?utf-8?B?NzVTVHZFSHU1MXduRUhnMzJFZTJXZkVlRW8rM1UxWTlVQ2dnalJiNlhWTTht?=
 =?utf-8?B?d2dOTnBYbEZaeUU5VElxSFNka2M2em4vU3ZaYm9ta0RsWGxpN1pDNGY2Vkpt?=
 =?utf-8?B?QnZadFVRblZDSm43STFtVkY5c2VtTHJnZHRKK3EyNFN3VmhaZFlCdlk0M0ZL?=
 =?utf-8?B?Y3JaRHBSK2JGK3czMjU5WmVkU2hZZi9LbURwYUdyZGowSFVucTFBZTBiazE4?=
 =?utf-8?B?WTk2TmJmK1FOTjJDSDBFQzVNNW4zOXNVVTQvcGJ4SFRoL3FQb0hLMGxsSVBX?=
 =?utf-8?B?NUJzZzI4cldRUmRjdGlxaHE0MHBFN2JianFiZHBJQUFmZWNNYnpTOUVKK1pr?=
 =?utf-8?B?NFlnMFR5VUNOOFZYNUJKSkUxUU1iWE5DWk5UVHhMM3B0R0ZxNEErTG9BUTRU?=
 =?utf-8?B?QkFDZHNQVC9FN0hvUFZhMXRMNXlqajBEVDhFTGlnaGV4eEVkZ29aVzJaRG5Y?=
 =?utf-8?B?c2VlaHp5RUpMN2dmcUtHMVJzNGRKSVphZFVNQVVVb3pMSGl1SmltSlg4SVdL?=
 =?utf-8?B?blFjSk0yQUt5RkFtWmlUZjFxamZwUUdtcGhuaWRSRmJIajlpMDFvWUM2cHZU?=
 =?utf-8?B?dEt4UnlTOEw1Q3A1M0xtdXJ6bUdaZU5XRkpnZVFRQmFOK2ZDTFFEb0pIbm14?=
 =?utf-8?B?dXVxSkloUU44NHh4RFB0QzBkSDRJZHJnRlo0OXdtVDdQWXVuTTZPTEdmdUJB?=
 =?utf-8?B?S1lHNy9ENmFlME1ySW02SlIyRlRia0F4UnFabHhIVUJGWS9CbW5rTkdITm5Q?=
 =?utf-8?B?SUxmaitlR2NjTGRVUGlIYzNKa0g1cnhGUTIwdlpRNWsvcFN0eWdKWWorSDI0?=
 =?utf-8?B?UWw3TzgzNy9kMmZLMm1mWmtNRjlpb0RFNlJmMTNzajFSdk1adlhFRy9LNXIy?=
 =?utf-8?B?OGQzZ1RWMzlhT3haWFVnZWRjUVhpbHJEdXlNbmJmWUpnODFTd1ZwMERXaytr?=
 =?utf-8?B?ZzlaR1pVR3oyT3psVE1Ja3h2aGp2U2dHdkR1MzFmVlhBTENtNFhVTmU3UlNW?=
 =?utf-8?B?Nk84bm9Bam5rUU5rblVQTWxLTUxQUEdMVWtRR1VKVm11a3NhYWx5R0EzMGRX?=
 =?utf-8?B?NFZjeHBvVUQzMzRuOEJLQi8zUzIxZUI0NWJXeFYzT0cxcXhCQ3VhU1N2QmUv?=
 =?utf-8?B?eGd0T3Q4MmdDMWFNOUlCd1NvdGpaeEtMeGVQRjBzT0U3L3l6MDRsVU1qN1kx?=
 =?utf-8?B?V1h5dFdTaDcxakJMa3NVZjEvcSs5UFFtZDJBV2NvWVlmQ0hvNG1Pczd2cUN1?=
 =?utf-8?B?QVBUZ2JQRHhZSFcrZXRqaHVJMW9XYjE2UFZucmdWZ0VzN2d3UVJ2U1VhelU5?=
 =?utf-8?B?a2hZazJ1ZE05NEkyMmlnd1ZNMktXcVRpNVJqMFFvSWlRTVdQTDZ2Y0lWVGZh?=
 =?utf-8?B?RFZvZ2g2SGsrREkyQmhoTjVuY09XN1RxMUZ1ZC82SzlocW9kYmQyT1E3SEtM?=
 =?utf-8?Q?jhvaYOUweZM1uI68n15AI/UG0ypMxJeOMXBWJ6a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980bfca1-9a66-4db4-be34-08d932922d6f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 19:49:25.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+zhJBE9OQNgN376s5KeVk7ZM3SOTMo0OQmdfeUeL4XDHP705rAlOzrw7PJANQ3CBk72t9VzYJrDhmFWTQPbQh/oA+UeMGksao7qJk3xBFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10019 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180114
X-Proofpoint-ORIG-GUID: qVfYYFADX22g27cn68hoSSm99lzSDuuC
X-Proofpoint-GUID: qVfYYFADX22g27cn68hoSSm99lzSDuuC
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/17/21 7:44 PM, Bart Van Assche wrote:
> rq_qos_id_to_name() is only used in blk-mq-debugfs.c so move that function
> into in blk-mq-debugfs.c.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-debugfs.c | 13 +++++++++++++
>   block/blk-rq-qos.h     | 13 -------------
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 2a75bc7401df..6ac1c86f62ef 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -937,6 +937,19 @@ void blk_mq_debugfs_unregister_sched(struct request_queue *q)
>   	q->sched_debugfs_dir = NULL;
>   }
>   
> +static const char *rq_qos_id_to_name(enum rq_qos_id id)
> +{
> +	switch (id) {
> +	case RQ_QOS_WBT:
> +		return "wbt";
> +	case RQ_QOS_LATENCY:
> +		return "latency";
> +	case RQ_QOS_COST:
> +		return "cost";
> +	}
> +	return "unknown";
> +}
> +
>   void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
>   {
>   	debugfs_remove_recursive(rqos->debugfs_dir);
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 2bcb3495e376..a77afbdd472c 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -79,19 +79,6 @@ static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
>   	return rq_qos_id(q, RQ_QOS_LATENCY);
>   }
>   
> -static inline const char *rq_qos_id_to_name(enum rq_qos_id id)
> -{
> -	switch (id) {
> -	case RQ_QOS_WBT:
> -		return "wbt";
> -	case RQ_QOS_LATENCY:
> -		return "latency";
> -	case RQ_QOS_COST:
> -		return "cost";
> -	}
> -	return "unknown";
> -}
> -
>   static inline void rq_wait_init(struct rq_wait *rq_wait)
>   {
>   	atomic_set(&rq_wait->inflight, 0);
> 

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
