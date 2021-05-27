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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF7C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E62610A0
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 15:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhE0PSm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 11:18:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbhE0PSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 11:18:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RF9XHJ111356;
        Thu, 27 May 2021 15:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=X1HbGvr4jKa77QLUBJp29Aw4b+L4ZZcoUCRYNm0aNEE=;
 b=z72rVV2rbNa6Ltz4xmEy7Ll27G8FhSRv9R+mY/N+gu0i2z1AtM2nFxUMZXS/etXgZnna
 Xq2sMIcf3uww1P7ZgEMU00M1oW6uitaYaUpfQdNLRNE0gdmdjC8i9IcN+Mttk3Vf+Y77
 gwcHjyspbXO9xKvVrdHcILsfThkREcFVZwsZd5oA//BULYfK0goCeSOaD97UDCJLs75U
 4Fohu8Iclb5986XJId7n8WpmJs1eljGcp46bQsJGO6do/3i1ONUfVVFxe/TmVplVoj09
 +CB2M8vb1DebO2o60SY2hoBLcWw/rIsokZjuhxrdrOZMTxX+BNs+mRXyxySR4N23oh9I 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38ptkpcf3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:16:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RFBZ7i195874;
        Thu, 27 May 2021 15:16:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3030.oracle.com with ESMTP id 38pq2wgam1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIG8aj1UwFhHYZmifhysH1DIk0zkJnV1VHkcsD2pIU7jNty6KlGk1H9BclAzi6gcBhB3MUOFKaiL+goze78DfxJFOSyBtak1SYQkBdWYZCEim9L6Yn7tEQjEOj5Arti256DqIR93CJB5FVWpTB4atCFbhTi89Dd1IE3Um9TmtaNNkAwV68/LWUGBMDoT5uRuBFK5Iib4Mw9LAHpcATAO9RjlY+uDFCb+gXpQF5AFsZH4EGD+WesEI53VtV6SOE8eyHN2TYXjFUe2JyGLpjlba6o02X+oeG2l3u9fNhuNDj222SghK++OaSN660fV/mGD+vaBFWeR7R/b9mdXdImpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1HbGvr4jKa77QLUBJp29Aw4b+L4ZZcoUCRYNm0aNEE=;
 b=Yht+Fng10Voz6W493VvCCFNZoVAysk0L2yjrk6CHORVsHhXufjqttqVn5Um5KkktggK9SIywNrVPAdOS8YU2Ju07hdCRs0jsNzsWP0OU0/FAprDj8eBdDJoCtGymRyy1VlABrW24SWhJTmz5hXf13/+IbSbRAtbbg5dWNO+XZzd8moJ6O3u8oIY4yMrqOQCL1GUaFsZLG1Ojuz2mRYyBS6VO52wRZqsLMS2u/XfrWTc1pvglltltfRZN6PHqd++jRzXD0TaNylXUmaWNISo/z4ZvZPu3r+a5jIoN5nFeHTmgGEoxu741W7JyFL0+bKtXFGIxm5gQDrJVlE/wq14L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1HbGvr4jKa77QLUBJp29Aw4b+L4ZZcoUCRYNm0aNEE=;
 b=Jqxhhdfg5L8QEuGGBHA06nbZ+yKCR8TJPV20UU6pIURUHrQIAMS71xuelzzAITHeFFs3ppi1sSpnEBZnzxr2QvIdMRf+acIdh/MVlgCCdFDLv3WlL4engK7qkj8ez+yG3/h45dzdd5R3VZSVRhA8BUJ4F1YkWHrIHzhrkrw9jt8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 15:16:54 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 15:16:54 +0000
Subject: Re: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-5-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <101a91cf-9987-e856-fe7a-38ebd4ab543b@oracle.com>
Date:   Thu, 27 May 2021 10:16:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210527010134.32448-5-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2606:b400:8004:44::12]
X-ClientProxiedBy: SA0PR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:806:d0::21) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:91:8000::7b4] (2606:b400:8004:44::12) by SA0PR11CA0046.namprd11.prod.outlook.com (2603:10b6:806:d0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 15:16:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e8cb12-8cce-4f07-5fd9-08d9212275d1
X-MS-TrafficTypeDiagnostic: SA2PR10MB4667:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4667FDEFC3C19918D6DA738DE6239@SA2PR10MB4667.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbK8c6yiw5E3itZDEO3YovvEkYxUE9/n20Ff4NczRvagxks6yxXY49XqPvOENBlKRvvan017zyNnSyyQAncjwOZ/jauc8bWNE21E2XFrwj0NLduLOQlQQMlAfpEQVO+I4wuwZGPVjd+Lc09QNkY37GuJrZASAr9CPcIQC8ICBVJkWdbdg78+zwnM2TvXbUTEf9LhrMq08HDgG5qw+MM+2147QHDn9XwuUoDsZaEHbxc7xLH8rCh2+vbdcF7gHZM85vOwZeKYovNHaRfYxHW7awrD2hUORGDn8Bag5m4gYRMX3C9XuFvng20skdynRM5NBmrSNCbt02rkGcP7BOyhBuEPkVV4dJr9q4EUPqeUtAEapGUUjUnFF/F+8Be4LooHjx5hElyrxKTg+KzP1aqwoMJ8uOGgjBo1KU8M+DOPhmPEMQ6IK8ECHQQ9lPPFlDJbOaJqDT1yxlnYng8jFKUE3eoJwcQ2cOYz44oC24XtcZw6KtS7t4wv+Xmg7n2Ue1OMRmE4AoTnJieB7jH2QK10SUi21OIzXb/7X8wshaK9vhctrG+LQYC9lM4jX02USpk0IFXEXuDMR1B4LpXODNcQoQclaN798unBaIB2tZPOrYWTM6M9W6Jawjwj1k0rMEV9kQo09Uj43HyU2bKPQpC2GlSe76B/e7mkzmcw+fq4aPqrXfRA7LYzcvvhUhMo/qM9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(366004)(346002)(54906003)(86362001)(2616005)(110136005)(16526019)(6486002)(44832011)(8676002)(38100700002)(186003)(36756003)(316002)(478600001)(36916002)(31696002)(66946007)(66556008)(66476007)(53546011)(31686004)(4326008)(83380400001)(5660300002)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGx4dWdmMUJ6YXZCRllrZ0JuVHF1TGhCTlY3cWI1ODFPN2NrKzBIU2c4MGVv?=
 =?utf-8?B?SnpOdlcwVmNqd3BLSUlOdXNPUWJKbDBxaVI1eE9peHozeUV0MVQ3VGY3ZXcz?=
 =?utf-8?B?VjV3TWdtQTdrZmpacUVlUlpEckk0OVBiSEpCM1ZhcUorcVQ4NmxKNlBkblFv?=
 =?utf-8?B?Ym9xMW1veWUwT3BWTm9CLytFOVNqQ28zTkg2Z21sWmgydHprRVJaQ1FGSExU?=
 =?utf-8?B?ZjdmME1BVDFOamR1UktUUGJTekRzYmdiMVhGZytIL3pRTWltK1JiMGdlYTR4?=
 =?utf-8?B?eXBOM2tNZC9jZFpwcjJhZXp3NkgrcVNkQ2ZGNjhOTjA4QVlYRjFXbWFFUytU?=
 =?utf-8?B?aFptV2lGa1FQcnc0Z3dHblhSY241NEJWMGVYdEFmQ1N2SE9oeTc5dytST2lO?=
 =?utf-8?B?ZkdxNDluQmdXTm9ySkZkWlNGUmpoeTMxN3JuN3NUS3J5NmtYbnJiMkVVRWpI?=
 =?utf-8?B?RlJlS3l1WlpULzNuVWRVMFhVcEFYeTlqa216bVhWOWxVd29GVXhRc1VLTjJs?=
 =?utf-8?B?eHV2eURHcnhrR0pCWVlSaWd2Y1hUV0syQ09HZUo5eTIrOWxMa2dRbnVqaDho?=
 =?utf-8?B?Ty9LcWFsVHBSbGFSa0RvZGRCS3pqQjB1cHNLekxpTFI0Mkl3VCswSDlnTmtH?=
 =?utf-8?B?b1lZalI5WFJUdWhxUGhkdUFjOTQ1dS9ablVBNFZpTktPYnYwRG5nRFhrWjNE?=
 =?utf-8?B?MnczSWt2Mkc2b0xuMkFhcUNJR2lUYXZLUiswVjh1Mkw1WkYyNEx0ZzJQUkJz?=
 =?utf-8?B?WXZrOThOeEVZZTlzOEdqeW1iQmhJUSsvbGpVMFUrZ2hkZUlodnZhRm9aMGhk?=
 =?utf-8?B?emZ6TTJpdVhnWThOekNGNGRkNU9LOGRyK2wvc01RaHUwTEpoK3lJY2tDNWtq?=
 =?utf-8?B?K3BBOStidW95NUxlTTFNUlFvSUgzTGxEdm4yRVZPMGJIVk1zZS83T3NNOGx2?=
 =?utf-8?B?L1FETTg1MTJwamJKbW5JbnlxMFB0VVF1MHJOTkl2RFdMTUV6amhDZXRCSG5O?=
 =?utf-8?B?WE5kYmRod3RmNXkvSm9FUnRzNHExUjNrQmhlaG5ibDJZWkdyT2NnVTI0cE1x?=
 =?utf-8?B?VVlsQkhkak9VN2VGelVDdUd6VnFXMjlqTEtaQkVKdkhLWXBKMzBHMHM5Rk93?=
 =?utf-8?B?SkFRWTRiUFJjNEJIOENQTjlqNVU1ejRKdUJiRldJMTdFOFUvbU1jOVhtNVYv?=
 =?utf-8?B?SGhlbzlPb2s0dzd0RHQ3dXRPU3NSRkl0dTArVkc1a1l5Qmp4am04OHJTelNr?=
 =?utf-8?B?amdvZHBsR0c3YnltdVRCUGQxVFdITUVRR2JVOTlYenlyeUk3dTl3Y1dHM2hu?=
 =?utf-8?B?Vk1rbDJJaW8rU3JBaFQxbnBkQnpCd2JOWnk2bi9mMkJsMThYRE94VzlSbnhZ?=
 =?utf-8?B?WXBzVi9DQkZoSWs4RHk3bkhpdGsvekQzdTBNcGpURGY5TGZhVzdTUWFUekVs?=
 =?utf-8?B?c0c4Y3RUbVpyS1NlRVYrbHdaNE5hMStZRUJNVmlSMWU1SDlNbkh3NDlobWFQ?=
 =?utf-8?B?MElPTUhDaWI4MXQyUUVQeXk4SVBsODRTNjRLdWhoOWJ5OUpwbFpGOFY1cm1C?=
 =?utf-8?B?aSt4cFo0K2pGOThqdGwrZWhycVlWYVdyTmRYeFJoVmNzbnFzV2pPcVcrQUgw?=
 =?utf-8?B?aFZ6RDBCVHJhbWFISW5FWlY2UVVlb3c2eHAvcWRLeTBpMzN1eGZxenFkV0Zq?=
 =?utf-8?B?eWpYUVR4RDQzbmxQaUpMa1pqM0p6dEdyY3NHYUJMcWw1cTF6Z0JUYkVNSUVr?=
 =?utf-8?B?cElnNlY1N3luM01SZkczakQrOXFiTWE2MVArd3J6ZWNtTlFlQzNlQ2NkYjVC?=
 =?utf-8?B?VmVZVmNHcVREOXZlbHZnUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e8cb12-8cce-4f07-5fd9-08d9212275d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 15:16:54.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqTG6K+BK+/dGSaYZsbswWRjf8LEDcMpkJtDZoGmO2l38TNJbT9Fm8MaKqEw6DonqyzW3hUBQ2kDE2p/tRpFX7qtgiD2bXayBGSqQ1IGknA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270100
X-Proofpoint-GUID: cO4FWwhOOWIBbGKWZdWJAz1tDOikNtua
X-Proofpoint-ORIG-GUID: cO4FWwhOOWIBbGKWZdWJAz1tDOikNtua
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270100
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/26/21 8:01 PM, Bart Van Assche wrote:
> Change "queue" into "sched" to make the function names reflect better the
> purpose of these functions.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index cc9d0fc72db2..c4f51e7884fb 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -395,7 +395,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	return rq;
>   }
>   
> -static void dd_exit_queue(struct elevator_queue *e)
> +static void dd_exit_sched(struct elevator_queue *e)
>   {
>   	struct deadline_data *dd = e->elevator_data;
>   
> @@ -408,7 +408,7 @@ static void dd_exit_queue(struct elevator_queue *e)
>   /*
>    * initialize elevator private data (deadline_data).
>    */
> -static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
> +static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>   {
>   	struct deadline_data *dd;
>   	struct elevator_queue *eq;
> @@ -800,8 +800,8 @@ static struct elevator_type mq_deadline = {
>   		.requests_merged	= dd_merged_requests,
>   		.request_merged		= dd_request_merged,
>   		.has_work		= dd_has_work,
> -		.init_sched		= dd_init_queue,
> -		.exit_sched		= dd_exit_queue,
> +		.init_sched		= dd_init_sched,
> +		.exit_sched		= dd_exit_sched,
>   	},
>   
>   #ifdef CONFIG_BLK_DEBUG_FS
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
