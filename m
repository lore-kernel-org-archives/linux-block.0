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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E61EC4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0395261358
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhE0PRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 11:17:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51482 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhE0PRs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 11:17:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFAmx9139862;
        Thu, 27 May 2021 15:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ETvviAsPySCop9PwAkI3ApAJ70HxZ/kmeMTlrQyZyME=;
 b=vktXbLe8vlio/0YbwdSsGX8FFRIguUJtl2M8kVMexrEIDLj1TyZT5IrY72SUvphoMVkp
 qLn5IR7IlHPlsnHfEMlNFuLU2tW8uwYvkvDw4ExtAnutt7x2aeuJdVUW7CM9885Mz/Pc
 6c+cE82I6SfiKfpubNhM0dGKwZ4y6tzzHKp+fWxbHKz7pJRrXCKDECYNlQnChrh2qfNY
 ZRuTJYHYQYdu39yhpswvIiPmQvuu7pXxRPTjHNd23Sgr8fdtDB0OvIHRM5ERFgknSbsq
 rErvIAwfYIreVqrjRY7TLcFScQ3YIPu2RmtMS9RJPXUqwf6Af+7X4ni0LToxsAVpa9I9 pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfcmjfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:16:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFAPUS183362;
        Thu, 27 May 2021 15:16:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 38qbque8hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ileRwmMzMk8W/OVELRvIrrKnTPzKJL4GWxikdJ7RDnRxggJ6EqTqSfRrdSiyR+0dYSKiFYV3CFVxLeJOL+9V4wTIaIkJm2dbFhVLJW31DpDgec0IR8SWhESZUU1fIFUblTL5YMD4uV6n+g9cXg4NLWLrWgVsOB0b1MkpLBoe5uwmcLW8ApLc0EZBzRAQEHKhGvQWtWIeJHDWSZ5I0Zwf52/kW5zxszbz7pqR8D/QURY2VUkiiYBasXp2UXsrSnLG6XvVFCWiIkRJ3mhROZfNo9w8DQcuxF7SXqjy165jB97KLSNuUagZdnA48XZH9mN4R9QvFNJx47k8yE5v/8PXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETvviAsPySCop9PwAkI3ApAJ70HxZ/kmeMTlrQyZyME=;
 b=lSN9GLAI6/D0me1l4kYsnngj9+GSdJtixfHlCB0tUNB0QDmNlZRisID8QvlrcLoQiPpxXRuulDqcNH3mkkSEkAWRRe9OzQm2PjGyb+TYlrYO1RdxxXYj79YZArzuTxUSKsVy94yuj525j6TA7bGm1dC/4le4YP9eNhVRfHHNwoug526SZS5IcFupL4BAChFxjXQUr9MSEww3ddGsjjg7jjm3SmiEuy+BhAlck+7Na/0M6O6ggDKMUe0KiBZE3qjSQmn/YBOWFWTCK1cJB14ZInAt4WNsJdFIflbMskHXsUVfJm8BYaQR/Fgy5diPA5vezKx7aWGlvB1vJEmXp8rM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETvviAsPySCop9PwAkI3ApAJ70HxZ/kmeMTlrQyZyME=;
 b=MdlLG906MUChXB0d812Q0buc2/fhZ2Np1aWtC929T/Osjp5P4gsbfVwbqd2CnuljAcUHqGX5wTlHWtGduj7chGCJ0cnnFWp6JD4JH7kXHYY4R7yPd+Kp49H00qoaZ0d2/u5Mh1xOXR0/vXZDzMZ/ueb1+ZtrScd0jTV6eGmAF+0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2765.namprd10.prod.outlook.com (2603:10b6:805:41::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 15:16:01 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 15:16:01 +0000
Subject: Re: [PATCH 3/9] block/mq-deadline: Remove two local variables
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-4-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <e5e1ba78-a788-11e1-ad49-55f9c11c2ea6@oracle.com>
Date:   Thu, 27 May 2021 10:15:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210527010134.32448-4-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2606:b400:8004:44::12]
X-ClientProxiedBy: SA9PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:806:28::19) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::7b4] (2606:b400:8004:44::12) by SA9PR13CA0164.namprd13.prod.outlook.com (2603:10b6:806:28::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Thu, 27 May 2021 15:16:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30bc6995-7e7b-4155-7958-08d921225682
X-MS-TrafficTypeDiagnostic: SN6PR10MB2765:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2765635A497F21265C953DB6E6239@SN6PR10MB2765.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1vDHnUeoJo0JwNvZz9aJ5aVfvTX8PviozvA7ROR44RXFm0YqT+WbRBCvsdLc99BE73AnHSMo9poTKUN0hKs72qHcBZCbIDRvbaM4KNiTIPdXV7IxG42EHwIfR9TVABa2gpwLgTB0eWCFttGwGQdPXeI5WsCuJp0q/zqGDJppoOJPXky0/TmjPjlzaPHu3F1hzXfI3ssiX7pFL/32AtGLrvMOt0e4XqFe/EYFIDcOwBkCnxx6bA40GFB5V6d9JL1PnUZfTCI7tTP4roA19fIq6klrG39PamINP1bdDfaCjeDw4hE300U4+vIzPhuAbqrr1e4+xWWhjfy6PK1l4Rmo5arI4Z4D+fgdKbmOQO/92MfwGGhqqxiKqXZnKfknSb28I5PQya9m3ShkYHheKvlVgfTu2bPHB5updGVjiYppP3Y4pHXJG7PiL0fkfueE9PrNrsd0oeq9aBOJ37GUpJtK1sJ+l9krgvxqIOU45x2X9CO6EWhVp8/bgg6bCx1ifEqVSwNi/iGhrJmvAqMRojBGOMntvpr/hd7LeEakaHlbSMIfUp969ghYDcNcxfIE5Z5iYd2paOkxPz2rOiHvbeJ2tyYuRmRUxQsBjit7ljo/krkvhZ4fGshKsOAtB0jakYjVQKyHtYKDhF26CWj9bMYvt4y30wzVOzFynU7fqH50Fh3ySBLE0TOn3Y654MMeHvzV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(346002)(396003)(36916002)(44832011)(8936002)(478600001)(4326008)(186003)(53546011)(16526019)(36756003)(2616005)(8676002)(38100700002)(54906003)(110136005)(316002)(86362001)(6486002)(5660300002)(66556008)(66946007)(2906002)(66476007)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDdsUTY4QWRCbFFrNEFYdWlGbzAyQkcvVjN6TGV6Zm8ra2hRWTArbnlMRUN3?=
 =?utf-8?B?SHFGUlh4STdHQlNtcHkrUGNQc1g0K3pjOEtISkpTY2cyL0RRclg2QlBrU2hJ?=
 =?utf-8?B?a3pSeW1NS25QU0s5N2hYRGhseFFJdDNMTzRhRnhncDVGa09OZ1J1dFpjUXYw?=
 =?utf-8?B?UDFOMUJHckp4RFJBMkttdHJjbUdiN0tKK3c0U29NR3BmeUw4QUQxZDZqSGtn?=
 =?utf-8?B?RE5VK3FRYkRnYmE5UzM4eTVjbzM2NWsyUVNsRjhJU0lvU011MEF3c29qUjRn?=
 =?utf-8?B?YUNESk9WSGxWSEFhN2dVTTQwMWlZWFhhMGZ6T3VFZzkwUkM4VVY5VmlBNXQr?=
 =?utf-8?B?NWRjREhoL1JYUUl6Mm0rdElkcWNmLzVVaDB6YjFmSHJaZ2JjSHl4N1B0eEow?=
 =?utf-8?B?RHdqTHVCalY4TWM5TmpkUlZNYmFGU05SMnFKQ2tSQjFYU2Y3eDFrUG9lNVBH?=
 =?utf-8?B?MVVSRldVelpibFdsYldZK0ZjOFJNVGlVRmVXdTk5UFhFQUI4UU5ZTDVIOTdJ?=
 =?utf-8?B?SVBsYTZsZ0lISm5mVmRyZ29iQmRGdU4yeExsOGMvNitkMThtNUNoNHdMdDhJ?=
 =?utf-8?B?cHVndEFtV0FTWExZd1Y2OUE4THNxNW5kYUpmL3Q3QzR4RERma3RyY0JuODdj?=
 =?utf-8?B?Y05mczVXTW9EZWFvam5lMWNPb2VnSEZvelljVnF5N1V0VUNmeGk0bkVCaGhQ?=
 =?utf-8?B?ODQ4NU1XYUhxVFZ2aVBEbTV2blNWdDRTMmx0NDJscEtTR2pObFA5MnZBSk1N?=
 =?utf-8?B?TlIwR2FtSU8rSDY1NnY0UTJxeFFXQkoxYmNmVVlkTyt2ZEdlS1dQUUI2TDlp?=
 =?utf-8?B?K3I3eFVqVzlSZkxDVVdLdEViOUZUcFc3cGkwQnBLMG80WlRnMlhZZzhFZERQ?=
 =?utf-8?B?YThZTVR4MHpuajhTTlhHMFZBWUVta3cxcCsvc01BL3o3Q0ZOMklvQWNpaWlV?=
 =?utf-8?B?bnp1cXNTUmdnWnRJSXUyUG5xM1pvNjNLczI0NjVINFRBVlM4cFhtMDAwQVpF?=
 =?utf-8?B?bEVYSUFUd3FoWWpOdFZKdXlieVZBSlpwNVhlNkVvenVWTisyb2RYbzNuRUpz?=
 =?utf-8?B?RTJlQk5QL2N3bmVhME9XcDNYTnhHQXNudTNKM2RWYjgrMEdsUFBzU0pJWkhj?=
 =?utf-8?B?YXNXcHc2dm0zbVArNUlKcGxNWEdGbWhacjJ5L3R5WHUvS1lrUXhiK1Z1TnBX?=
 =?utf-8?B?NkpaTUVmckdCTG5kOFJtUXQ0dGZWZiswMVI3MTRhU3NPQ1docFpnUVZ5bzRy?=
 =?utf-8?B?c0RUQ0pVVENjbmdvYW9SYThReXFvb3BRVHdHcndBRGZFTkFyWXBsTDZPV0Vx?=
 =?utf-8?B?ekhzY253bEtVZVhtQUpIU2RYL2xvYk9yU2pIT1RETDNGWmV5YmxSbk00QW9Q?=
 =?utf-8?B?Z3ZlcGFNN21Qb3dNNmlnUThWYlJXaUxkYTh4Q2tITm5TK3NKdDRSaVF4V2lU?=
 =?utf-8?B?M3FweGJKQXpoSmo4RFJwcGh4VWp5ZHltMWF1NDJ6Smc2ZXlBYkFmZWhKTkUx?=
 =?utf-8?B?UkYvazdJSUhFZGVPTVlCbFRHWi9WTkM5c3JwMkNvbHRxK0UxNi9EclEvT3pz?=
 =?utf-8?B?WlEwRHNhb1JtM0xlUEZnWU5IV0sva3VtcElNeWppVklOK2M5U0Y5Wk1PV0I0?=
 =?utf-8?B?dzNpM3hNR2xrY1B2c1RhanF2dm9VRmEyenJLNlQvS1hJZjFVTHRaSzRVOVZ2?=
 =?utf-8?B?NE9oT045azlGbWRIOWtqUkRwR3hPSlJBMlZjTG1JaDlFNkFiTGtveEhzZFg5?=
 =?utf-8?B?d3pQV2psTllWZEJYczg5cU5zRDM2anRkL0xVcnB5UmdqRElud0hKUzdmcUhC?=
 =?utf-8?B?UmQzNyt3SThXYzlHMVFZdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc6995-7e7b-4155-7958-08d921225682
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 15:16:01.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpBFLyb8hoR1Sw8/oLyS+07BnMuQ/T7PDmGLF5kOEBA2szzyzaqqzkeZoYwjiKZR//QuphyCCDrq20jBc1Rqi8WgTMV8Vj6PLayNhza/HVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2765
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
X-Proofpoint-ORIG-GUID: J4-qKWeB2mrEE2jLEYFENcmOpzyBoB81
X-Proofpoint-GUID: J4-qKWeB2mrEE2jLEYFENcmOpzyBoB81
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
> Make __dd_dispatch_request() easier to read by removing two local
> variables.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 4da0bd3b9827..cc9d0fc72db2 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -276,7 +276,6 @@ deadline_next_request(struct deadline_data *dd, int data_dir)
>   static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   {
>   	struct request *rq, *next_rq;
> -	bool reads, writes;
>   	int data_dir;
>   
>   	lockdep_assert_held(&dd->lock);
> @@ -287,9 +286,6 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   		goto done;
>   	}
>   
> -	reads = !list_empty(&dd->fifo_list[READ]);
> -	writes = !list_empty(&dd->fifo_list[WRITE]);
> -
>   	/*
>   	 * batches are currently reads XOR writes
>   	 */
> @@ -306,7 +302,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   	 * data direction (read / write)
>   	 */
>   
> -	if (reads) {
> +	if (!list_empty(&dd->fifo_list[READ])) {
>   		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[READ]));
>   
>   		if (deadline_fifo_request(dd, WRITE) &&
> @@ -322,7 +318,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
>   	 * there are either no reads or writes have been starved
>   	 */
>   
> -	if (writes) {
> +	if (!list_empty(&dd->fifo_list[WRITE])) {
>   dispatch_writes:
>   		BUG_ON(RB_EMPTY_ROOT(&dd->sort_list[WRITE]));
>   
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
