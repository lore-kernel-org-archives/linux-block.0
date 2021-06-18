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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F0C48BE8
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45106613BA
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 19:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhFRTvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:51:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:54116 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhFRTvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 15:51:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IJgHJC021370;
        Fri, 18 Jun 2021 19:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vmLL4tBS5Q7Vtw9SreYfTs8Q+m/vmn+adlIrGkL5VSM=;
 b=UWrCNWb0yP6gEqoi/bxYSHv9TaZdHBVyg1+93MCDAENSXWY+dndVtrVGjmVQLncWeHdQ
 d9cooGhWS7njaWjanvVZEzdgWeJdcc8EhaMDPaqKxBZglBicoyPWgHFppcItEXhO0s+U
 DOBR3xQv776HwoKsnUU6BzI9bl/O2aJpdGXtBTdlRI8eLl8QjVpq6p/iUKXvM35mAS/d
 bu2NaOnuxlVxQwu57VZN0eV1s5DtaXNOYw/Qp6DORstnDieXFFxVKxtxtoYwsmdNWXDm
 JMbZxz/L4uraQXLtWE4+83pWw3HiMjyxANQ9WWZ1ODu/8oP7xYPBNBNoyMWNP0iwf16g Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39904886en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 19:49:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15IJfeNn083853;
        Fri, 18 Jun 2021 19:49:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 396wb094rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 19:49:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj8quNcNN1FAJHpK+6CC+GoHhqeHoY/7+tCvf5P4l5+/QDWcGrHjcJV517/WBxOq7HCo6+BT3BxXi7B8gbXZm5ytxOHEck/Dyk8GAYPcLHxbfATEj8h+8USnILxUdkRVrStr0o2A+lh52Iv8p3FhGOc23x5ko9xX5IIMiNqCdwTYdi63tFsId/uk+ckXOex4TDLmtCUkStWhngcFy1LZDn/yzWNH4RUBdTx0YexRqQF6UnxAtMONNdSnkJkaNzfe/iCvL5hYpnJzmxazrXqjQYC9zTEkZPrKYCtzHw8end4iOFqmGIX+PpFnVWk6st+MnVVhOXCzr4pbGHhns/Q4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmLL4tBS5Q7Vtw9SreYfTs8Q+m/vmn+adlIrGkL5VSM=;
 b=HHrlDctSPAvxlfPdcMp3HETo4f8CxUXFi6OOUH43oyyGmRlKxhOSiGk/Ibhs8LdxIx+WIiPtfMSs+euSxT2i6tZ7HHVPp6yNXsLMbu7rmb2UWUv5EoRLhZ/Hu+e7KJq9h53VshpmL+taiIwNZqAuOGT8XUFJNsclUXk+cLYGWDwpS/zdQggDhdigWRPkm14pOeGKbaG8C4eG98jtmY8jF9CQLgShR8egG/oIFnAN/LRDXlOW4x4wPiS4qcRIkhwM4evztJtrUgnsM+yfYy2BnNyPn+TyF9tSLtdfzEJWX0AvuGTjreNqviBzSfR9fkc3ORToqS0+VR/xqxFksFM6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmLL4tBS5Q7Vtw9SreYfTs8Q+m/vmn+adlIrGkL5VSM=;
 b=Opnyp7IvRyhr5GZkpNJ1CNotorr42fQCijU79VnU8Jj8x9/ZAbmqPyoM4FeSjTPZsyNi7zAFjw6RUXvGeAOfTV1k3cdMzJReOznHW4z9CxPkmas8w+fp64u4nafRG+4glRmLuy1gKD+lFXea2YogwmQHHFwpdlI7Cbf9Uy6A368=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 19:49:29 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 19:49:29 +0000
Subject: Re: [PATCH v3 02/16] block/blk-cgroup: Swap the blk_throtl_init() and
 blk_iolatency_init() calls
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-3-bvanassche@acm.org>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <11eba842-8ddc-a752-0431-f376e1a4f6cb@oracle.com>
Date:   Fri, 18 Jun 2021 14:49:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210618004456.7280-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SN1PR12CA0043.namprd12.prod.outlook.com (2603:10b6:802:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 19:49:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a222900-4a30-4e21-171b-08d932922f7f
X-MS-TrafficTypeDiagnostic: SA2PR10MB4668:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4668787FB92EC2C395A4F450E60D9@SA2PR10MB4668.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+mmy0QzLhqQgJKnDlLqhf8EPNajMtD+04qt2QuJYBy65In5yLAOW22fLEDC31Lk4TsXOKGWJFvawLFYSyfHhLrmhAbwnFTKUNUKLnMYuk91j2BEynwVDVXiZFqAKlP+4qzphxXaYV3eXY0LunQbvaL9tUmQ/3bkpbbka1YE+VBAIWlQ00OjiA0LC9lyJH4nTnVveJQc01FOCPjHOwFlljy537KrKYxdERh91SN1hQABjKgtleCvLkYTXhcNOsgqUV9jPi0svON929HlqiL/lavurY8xzwa1BBOaJCG4aBimz4m8gkqNode/vYilUDY3S3iHO0Zs2eWQUhH53rTVbelbBLd395RipuVJVYA/U8KFHhdJLi+NM4tseOj/WJfjwezRJPHmAgNqko3FLWEDh2Q5MGraRYRJvrCxc9WOtAwdYfhdCOd3aBmK46WGTTrV9RKFz6AeknVbsJpj7K/Fbq73zEVIujkTw0cpIO8h0glRdW0KBREgEAPXVyewPvIHeisO1zUNqdS2vN1T/hu0ldFtY2YoVxm8O5TYArC71tjfPZ2EFIQW0NDC3TYI4ugz7oERLeTMUnR0ulEdA4f8OE3ohmMQY7XnkspdYHJ8v0YtPOPBEvSpKHYgOPfZLpZZdp5TKrhNfEElYDBhCH1u6GSHejEl08lxpL0t801KL7O2lSN1x9xk93FtNmZypzUN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(4326008)(83380400001)(53546011)(38100700002)(36756003)(2906002)(31696002)(31686004)(7416002)(8936002)(54906003)(36916002)(110136005)(16576012)(316002)(5660300002)(8676002)(86362001)(6486002)(66556008)(66946007)(66476007)(26005)(16526019)(478600001)(956004)(44832011)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXR5T0MzVlprZTN6a0FzY1dpTk5EUHhKR08zanlMbXFJaTJVRm1zNHJELys1?=
 =?utf-8?B?elpTRVEvZTBtZ3I5WWp4dytQd0pmNFpMaXZzQkk3ZzBLSlo4a2s1N0Y0YXc1?=
 =?utf-8?B?OG4wWk53UDIvWkZRY281OHB2MzJ3VmkzN0pmNWlxVDhmQUxxRG1Ld2YrZzJh?=
 =?utf-8?B?cGRpZnBtNGZTLzhaOFZ3cHdyNmRyeGF5aXpWSjVTMitaS0FDUmxvbkNOZ3pz?=
 =?utf-8?B?alpFWXEzdGN0c0hXNHRUZllrWVRjdnFGMVYyc3dpTHFVU1VTTDNvMjZtVHkv?=
 =?utf-8?B?c0pIaXpqbXUvMFkwbWc2bGxJRUtCUUVtdk9DSU5iQ3BRMmtJdXJQbS9wTmRP?=
 =?utf-8?B?VCtnbnB2bVBKbTNuakxyeWpvbmdOaVhZN1FLaG52QXpERjQ3VVdjNnJTZGQy?=
 =?utf-8?B?VDVNMmdNajZITXBsVjlxVDk4TjZoMVVuZ05vZ3dBNEVFUTdSY2VWdXRLOFBo?=
 =?utf-8?B?WEp0NHNReHMrRi9NZWZHOEQwNzZYZ0hmeTJqMDNsOHhjdExyeHVmUitaNU9X?=
 =?utf-8?B?SCtLWk1QeEdIVFI0RVdDTEIyRHF4Sys1RkFwOTU5cEptZnJlYnR1VW1Odzly?=
 =?utf-8?B?WXhKVjFvY2h2aGZwQjZjVDZwVkpZZTJJN0dPNllUSGdieDZUOFlEell0Nmo4?=
 =?utf-8?B?ZE1TTGZwMEFhaXRXZEJMRWphSnUyK0NNU28zaS9ac1U0VkRnQitYUk0vM0cx?=
 =?utf-8?B?RXB0dXJzRkZBU2tGZktvdXV4WWd3Z2hoRHVJaldxaGhsdTVoSktEWTZvZ0Vw?=
 =?utf-8?B?elpFS1lwRTFlVUtmOS8yOG50QXJybzVuSWpadk1wL1dUdFdNMzBZdmduRTJL?=
 =?utf-8?B?d0QwM2l5KzZMYUVXOVBEZHdsRC9iYXYvMVo4djZPNnFIanA1QmRDd0M2UHA1?=
 =?utf-8?B?UE1DRmNodzJ2dm1QNFVJOXdSL0dJSWtHRzVMZEtnSHR3TG9FZE1rV1Z2Zk9a?=
 =?utf-8?B?aDl4M213c1pBV0Vsa09Xd1NSU1g5VzQ0VXBOSFBZcTlGb1VqY2tXQ1VJbWVn?=
 =?utf-8?B?SXU2VC9SZ2dta0gra014dHdQMnc4aUxBdjVFZ2w4R01TLy9lazJuRituUmxi?=
 =?utf-8?B?K3ZqSnIxQWhOTjlTc1graHRPNmF2Q0tJK3E2cExnOWpqeDY1bHJYZHBYL1oy?=
 =?utf-8?B?SFhXYU5lMU5sYThibDJzRVNYVFJDQWFrWnh1SkRHc3ZmWTYrT3pDL0lLNW5u?=
 =?utf-8?B?WnhSTjFNeUV2TU5MR1JkUW9mN0wzc1FRbG5FaTdJdkFSTEkwQTFJdDN2ek5m?=
 =?utf-8?B?cVJpRnBGeDZKZVBpY1JIamVZck5qaXpnTFNzTFFOTFpXVjJWdzN5MHB0Mlcw?=
 =?utf-8?B?dWR1U2lsd2NkeWQ5VXNsenFaSHpZSVUxSWk5ZitLQkx2cDF5bVJTRzIvTkJz?=
 =?utf-8?B?UUp6TnZ3aDYrUEVPczFJU0laUGppSHllWWJSbDFIcWRUd1gxQmZucTFBYWNC?=
 =?utf-8?B?b0NrM1R1RFVLeW91L2pDRmM1VVVVWmUzRXFQQ3FwRTFkQ0MxeVE1ZWhWNEk3?=
 =?utf-8?B?eHJCeCtLYThLOUsrK3FrUzRwV2dCNXJxZUUwbTU0VHh6SEozMTVxYVNKb0p5?=
 =?utf-8?B?bW15L1pZM1hBMWVCZUYvUkI3QWFETWFLUVNlUXhrbkEwdWsxYzRUK3dLTnM0?=
 =?utf-8?B?elBzTlNWK1ZMWncxOWRBU0Z4R2x4M2FWcmNHMm5WbjdZVXhTSURHeW5WZm02?=
 =?utf-8?B?SU5LR0NlZVpKSyttWlJ2Smt3VStlNUZHOStReDZhaHlnaUtSOEN5OERYQXdE?=
 =?utf-8?Q?yj/FCk+75cd9tsLVayJ2lOz41sWSy32zTD0btHg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a222900-4a30-4e21-171b-08d932922f7f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 19:49:29.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ5FkIFrwrWNhmq5/8Ukc3VZxg+PZlPiVMvkZ01fBRDT+gLiAJN4kKBY+bzzdA0yX3hseMj6sTXkiSMqjIrFw62NdcK9W2CUxPzONMP3Luk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10019 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180114
X-Proofpoint-ORIG-GUID: CeS4ASY0_EoQQDPyy4ZDTEJmfNiWj7Ud
X-Proofpoint-GUID: CeS4ASY0_EoQQDPyy4ZDTEJmfNiWj7Ud
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/17/21 7:44 PM, Bart Van Assche wrote:
> Before adding more calls in this function, simplify the error path.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-cgroup.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index d169e2055158..3b0f6efaa2b6 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1183,15 +1183,14 @@ int blkcg_init_queue(struct request_queue *q)
>   	if (preloaded)
>   		radix_tree_preload_end();
>   
> -	ret = blk_throtl_init(q);
> +	ret = blk_iolatency_init(q);
>   	if (ret)
>   		goto err_destroy_all;
>   
> -	ret = blk_iolatency_init(q);
> -	if (ret) {
> -		blk_throtl_exit(q);
> +	ret = blk_throtl_init(q);
> +	if (ret)
>   		goto err_destroy_all;
> -	}
> +
>   	return 0;
>   
>   err_destroy_all:
> 

Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
