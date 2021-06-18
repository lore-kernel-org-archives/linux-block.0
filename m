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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F81C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB0961284
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhFRTv5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:51:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18800 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhFRTv5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 15:51:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IJf23I009433;
        Fri, 18 Jun 2021 19:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=akSONl6Xf/zhEWtNiHrKkPn4FSMf6azf73uk7wfFOdk=;
 b=ClnFBhHHm6KUOvSEoWXioOcX5o/R79YBV242EA+sLjv7C7CK6I0sJroCsVDxNQE4OkFO
 k10d6hnQ3Yf1BwEO4NWXjDgY4qZmtJf7pThsLdxwDEChT1Bg2v9Rg3CyIFSMhSIWAU36
 M+kz5NMWS6E6cmLz6rcUUOjkeVgb4URycUWPj+jUXhDm87vxtzJFmqjO6HiBaA+ceztx
 f9HShon+Z7z//X7dsyuI1f91hia5KBKHqjTSntPcmyidXjj8xlE6V4Wg5jo/YeHnya7X
 GVSxzx02QbgCI6j/H9QNio2WCpWb04kCEJ+9vTJ/cH3MwPi2jEIZQryy/rS9g1Lw5sSC Sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 397mptmq83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 19:49:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IJfeNo083853;
        Fri, 18 Jun 2021 19:49:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 396wb094rm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 19:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5qffxYXQmSP1un2+zKiJj2nLJ3HuEe1e9AFbGfNeTVxZ7VBS03179GXqie+0HPVruDLVBKstz54jf0woosjaAUPwXSXz57CUFn9kJqoLDR1bstG1qTEHOJ2Hx+7lWrSB2UW3jFCJjEdvD0xL7NDk4FwdBp2Dm2jCRuuRfodYebkWmpEkRxs83IDljcrBqCOmNYNWMaBIQAekF/fPF5cEm0jcAL8bcMQyEGRkHJ+EvCH66akM1DvrJbPYewafQGAUma7HrhQBR2e3e34G+DqZxbtV51fgcr4AxzbxDvu+C5AF9GGqBFLjDLl4A7xdCb70vPru4fV0Ps1qGLAzyUwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akSONl6Xf/zhEWtNiHrKkPn4FSMf6azf73uk7wfFOdk=;
 b=j1zCElxmZ8f/YPCitRT2419tXPrSIUPS9KkzuqgbXyXyfOvkbH2VddIYUhq0gu6Zi5xhWyWLp/ymE3H/cXpbL+xf1rpGfjPN13RA1/EPXrJEEGU5xtoUcgIQ3c/S6rZlZnBvIac8Z4p1n8eLA5KRw9ZFdx1hNgIRZoVjzelgRAbpy4hgDgptKVtTlrPOXG6tQ4jduHntr1Z42KdbxA8rvEkFLV1mih7yBvg1wJlp5bUz+vTFxJEniwpzzU16vaG3RoR9InIqnH+S/50rJCKayqPvJnI4UJ9jQ967+SvyXk25Gh6Lyjs5WViT2c9M39QiQ1L+H1JJKOrcvPMNfe63pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akSONl6Xf/zhEWtNiHrKkPn4FSMf6azf73uk7wfFOdk=;
 b=Jwmp9prF4PtyUW+5Taus0CNWj0MjQG/YwV39qohsBqOkGJ8HRgOBf4nyDig9vc5lJc7ghytDYPXX0F0yo8hSmUIUVj7Z3VAeKM7WJ0DTZYyjteSZAUEqZfX7WCvwss4VZM3/ItJI28mOzzoCKols5T1xbrmZnQ/jlVoSesirKQI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 19:49:31 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 19:49:31 +0000
Subject: Re: [PATCH v3 01/16] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ
 entries consecutive
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-2-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <01ba8461-0c80-93e1-dab1-86373e175758@oracle.com>
Date:   Fri, 18 Jun 2021 14:49:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210618004456.7280-2-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SN1PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:802:20::18) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SN1PR12CA0047.namprd12.prod.outlook.com (2603:10b6:802:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 19:49:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcdc2bc7-5400-4438-b38e-08d932923073
X-MS-TrafficTypeDiagnostic: SA2PR10MB4668:
X-Microsoft-Antispam-PRVS: <SA2PR10MB466827519A1EF177244632EFE60D9@SA2PR10MB4668.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA66eKZV+rfa/+yPhQcWGwtiVGEpxPqYpAGxogQc5X4U+jvtwtLhANNeg3TfnaewOwe/8HmteRGJZj9LO9DEFmRacaUjfLjfJBBsGgqQ3ZRurT9Afu0qO7kpJuoWaAncziayxfC67a/zBg8vaWcfO6oHXZWCJYyWPMU2W7n35YqvMueU23zIA2AvUhscVO8ZBPHzfRdNFWr4/YFLFPtE/op7Wxp5Qdwy8XllTknosB0IxcBHTPZyzCnglrZpFOiYQTMrC7wM0Ob5beltUiGq3UA9R3kVfRF50luIGGzr9RAJMY9yqdft6rcpJ+I9Cz3KLJHDdquAx8DhsYblKddyLz0f0uhMMwg7VQ4Sx6Meg+Tv5JCVHbgp1s1tuzhfFvxLwtfKlLSXUBrOa86w4LoxAaOPSPQjMlrLx0j2pynQbN6qeNeLi4f7x04e4d3hriZxxDT2RcdQA0VOcly4/PCUiruzxfPm0dZtixEoCgcXYYDODT8A1whRBF9bHrRJszVPBv5xBftjSmebO4BubNSo5di1CivPswFFUpCROapC737M9FHT/lbBD986QYwBg54YzDiLTlNs0m2jTpcPl+IOP3ckbj2OFHt48Qktd5INcPqbqjFC8I5ZpX0lXJHi3rZx/+cgn/fAsPu7pdLYnpUXb7gb54y4Ep4Karb6on84HtdmCIwPZRZhObu9UQ1/4Aet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(4326008)(83380400001)(53546011)(38100700002)(36756003)(2906002)(31696002)(31686004)(7416002)(8936002)(54906003)(36916002)(110136005)(16576012)(316002)(5660300002)(8676002)(86362001)(6486002)(66556008)(66946007)(66476007)(26005)(16526019)(478600001)(956004)(44832011)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjByRDQwTXRXTXY1Yk93SWx6ZjRzQzBkTm14aE1KUGg2OGFTTSs0dTYzSmpW?=
 =?utf-8?B?dy91ODRHTEhqSkZBTlFpcUtDL1VzaVNkb0hWdWsyU0JmZHp3ZkhhL1YvVytV?=
 =?utf-8?B?S1dsMmdLWXUzOC9DOWltbkFOditTNHF5NWNGbVM5T2dYNExOUGVQb2FKMk9j?=
 =?utf-8?B?N3dWbi94SkZHZ2NwL3RqU0NtQWNwRW1uVndzMkJtaHdsUGZ6Z0gySHduRjNI?=
 =?utf-8?B?YVBrYTNGR29ra0d5YlcvNjNkRFQ1Q2ZWbldhSSs0a1F2UGZIaFVXQ1M5YkNI?=
 =?utf-8?B?OTJjaEFacUw0bCtpZDJTdzIxRWpqNHdKWVZqQXRNMllMOWp6Um1DL3lYaE9U?=
 =?utf-8?B?TDJyVzFjSEc1YjlRNmRoOE4zUXRDUHlYdTliNEVFWFVCN3ZKdDlSS0xOV05K?=
 =?utf-8?B?a2RZdXdtc0hsZ3VSbjVSNTJ4R0hZaWVoZzM5b09UL3g3am95Mk1yMC9zMTBV?=
 =?utf-8?B?dCtMSzRmZ3NSL0MrcHMrVUFCdzF6ZklsWjRuOWg3UTkwL1h2VG9kMHYycUhM?=
 =?utf-8?B?bjErenZvNEV1L1BBTTd2NGZVSWdxbW9tKzhxaGxtYUhkUGF0MEZLblRQcWtO?=
 =?utf-8?B?YWRMV3hoWTlLWURlTGhwenZ5NWZQY0FLaTEzNGlhSzk5d2ZyZkUzaGx5d01J?=
 =?utf-8?B?eDcyQmZEaXd5WVlESlBjUTd2MnExNm9aZVhLMFljVmJjL25qeVk0ckdIcHB5?=
 =?utf-8?B?cDNpSjRnMHFHdnFwMWlkNjRGTDdmV0FsVTVRd3EzdTZTVU9QZmt4ZEdzNVpn?=
 =?utf-8?B?M0Z4Q0FrMjJtN2p5cWFCZGY5cjcvQWoxd2hZbkZ4R2krUjQ0cWdoeGMyQmh6?=
 =?utf-8?B?SnhySjZ5YzdZc2c2ODIxTml4cGJKWjRvWWU0Q2xiQ3JsNDc0OUh3Ny9jaFAy?=
 =?utf-8?B?TTBjMXFza0RvL3hpZnZrd3grN0tNQVRWbk5xNnlZclBhb2NmRHN4R2ErR2l4?=
 =?utf-8?B?aXVoTXA3NWx1YTRsbDZDUlFSallOV285TkcxbkYrRUpUbklrNXhYd1dVVHRX?=
 =?utf-8?B?RlNIaGJBMml6R215Ynpla0QrbFN6S3BxUXowYmlVcGx0UTlQNCtGM3VUZVN5?=
 =?utf-8?B?QlBRcVhmU1VPWk5DVVJSSlQ5K01FWTNhcGZJNUx3bWo1T1VWbXFMZk96bkhS?=
 =?utf-8?B?TjY2RGRHR3FHc3JEYUZ0YldBS1lVNXF1ZTJsSW1xZktZejdVZGZrZVhhWDB1?=
 =?utf-8?B?emU3QzJ3RlkxQVg3TlhLTi8xUmoyTjhLbjh1OEZTdS9RUTJGWE0zUS9Hdmkv?=
 =?utf-8?B?VE9oVVFyMHlFZFQrRmlsQUsxMFZFK0ZQbFJxY0NCa2Q3d1Bpa201dHJwLzBR?=
 =?utf-8?B?WmpYdWxoVUFJUG9JanVBUGJDZkcwVENzNE1sM3NER1VyMUdWQWEzZE9HNGZF?=
 =?utf-8?B?ei9QR3JuZkxOZ29uRWVaTWRLazRYOE9YZUJjTzJyZFJSaStNZ1FEeWtOMThC?=
 =?utf-8?B?ZnZTYWxqWkFUSGRXRGxueGtHcERwTGhtODRHd3V0YjdBdEltM0FWQnRlMUZ1?=
 =?utf-8?B?R01zZi9MdlZrQ1A0Q3FmaWdmNTdiSSt0bTRQYkdIY0tBbmt2L2ZpTEhuZTN3?=
 =?utf-8?B?RXZKVjlnbUZnZEdsN3FFZUR6YXpzZ1VrUkdTajlWSG1ZY2VodjdPMjBNZGhj?=
 =?utf-8?B?K1UvVWJaMC9wNytwL0JGOVc4OGc2alVzRTZmdXdRTGlZbmRJRUc4dVVPODBj?=
 =?utf-8?B?dlh4cDNhMnBkT2U4b3lla2F2NFdkR2twc09GZEFGcE1VcDVldGtiandib2dV?=
 =?utf-8?Q?QI2oOKGy115LPvwSVdldRgoJOoO+a+KOB76/Rml?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdc2bc7-5400-4438-b38e-08d932923073
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 19:49:31.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBMjI2lLQhOwVfgqxQMcbrevOGj62Wfne6RLT07IdaQeiqxwi1uuDCnIcGPbFpTl991DjS1avMctfGqR7MxXbMElhplOgyG3g4y/nWVEtwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10019 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180114
X-Proofpoint-GUID: 8BciJ5fU9Wcm_AzJdPv38CO_JRMrij1b
X-Proofpoint-ORIG-GUID: 8BciJ5fU9Wcm_AzJdPv38CO_JRMrij1b
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/17/21 7:44 PM, Bart Van Assche wrote:
> These entries were consecutive at the time of their introduction but are no
> longer consecutive. Make these again consecutive. Additionally, modify the
> help text since it refers to blk-mq and since the legacy block layer has
> been removed.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/Kconfig | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index a2297edfdde8..6685578b2a20 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -133,6 +133,13 @@ config BLK_WBT
>   	dynamically on an algorithm loosely based on CoDel, factoring in
>   	the realtime performance of the disk.
>   
> +config BLK_WBT_MQ
> +	bool "Enable writeback throttling by default"
> +	default y
> +	depends on BLK_WBT
> +	help
> +	Enable writeback throttling by default for request-based block devices.
> +
>   config BLK_CGROUP_IOLATENCY
>   	bool "Enable support for latency based cgroup IO protection"
>   	depends on BLK_CGROUP=y
> @@ -155,13 +162,6 @@ config BLK_CGROUP_IOCOST
>   	distributes IO capacity between different groups based on
>   	their share of the overall weight distribution.
>   
> -config BLK_WBT_MQ
> -	bool "Multiqueue writeback throttling"
> -	default y
> -	depends on BLK_WBT
> -	help
> -	Enable writeback throttling by default on multiqueue devices.
> -
>   config BLK_DEBUG_FS
>   	bool "Block layer debugging information in debugfs"
>   	default y
> 

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
