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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F2FC2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3EB613BC
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhEYTLr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 15:11:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36714 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 15:11:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ56mO109942;
        Tue, 25 May 2021 19:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yJnB1cbNzco7JRCJnkdpdlSAaHtGOZFTYhyY25HML38=;
 b=J9RA063gijNxp3rkLii2atBB7yS9Ri9YYnoi92Nw5YNSpcePu8bUWmKnP5a+/whlKitY
 8mYOh+yBuIK9cCHMZZfoqmOp7fqeQJlXO0EvvPHQg28tyLI5kWdgqepuOPunlDjOaj/A
 qz9cn8NhnQgn4osPx5IsqRiGy7pc5lY89kTIusnBbM5mWqAl2Pt6p3s95j7uO0Yw8o9X
 sVWPnUwouqdybsFzIxCNWYtr/YnO/txkKFK33jdLhP2747xFQJ7Rkl+i3S8Mtj1r2ZSZ
 JkDPxROOta+vrDCglOoPWegCBD33SFoCz+yO5dI2bIJo+SWw/8O2cJWi2G08yGmAx+Lp Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38rne42m8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:10:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ6CxW105796;
        Tue, 25 May 2021 19:10:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 38qbqshmn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzUFCoMShrK0isgnQ1qkWdHrFg38i5x5vS4IxRYHAnZLuCN31HhANzgr9U1BqekjBGzH96a4eaK2w7l06Bh65mmf1+sluo0cAJX93ZIInSF6fn/A5ReTNcWKwl5DzwMC52XTXcbiiayDTjr7TDHPuaVxWLvCJQhjiyJ7fXpsFDcsswWFylyzJVGVvpEIYrHQ2LtcIxMqgUIUb1xADA2zqavb9TfMaldrjG61FLXiKZ34FvlWkqiJik2Oo8JH94mrCOtRMue6tnR10PfoitW0UPi8cz1JtfQUnKHD5WQoz2jUtZB3rrffcpMerRf0OA2KGER/wnj00Gxr2XMB3xoOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJnB1cbNzco7JRCJnkdpdlSAaHtGOZFTYhyY25HML38=;
 b=CMAMlUULrLS+ELhVtI3KbKCmhTl47lP9vSJg14cTHddDvHMxQVsQX0NNH1qm3iuU10WUBQ98IDYMauXf+Rrsp5uGSFe2a46v/UnIT1Cz0feHWP0p0Rqj4LRcqBHP7n3kQS39aXTtXsadnjIZ/QictaiV9w2/EZz999bnZL9N/Sx3AMze/6h9KsqIS+9SE6S2VnEyEXzYFEVRPqwBl6LHyPmyDP3Ax55J6tVDAh/KQx3Zva6oq/mCLzl37eV0IdryspsWFvtfTYImSk5ZjKS/vxItG0DfpKS0Kx61j6WTP4GnSAm1N4lk9Sl6UgMTupwXn/5GBPCt0chWeiu+qQITtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJnB1cbNzco7JRCJnkdpdlSAaHtGOZFTYhyY25HML38=;
 b=Wgb40zepXxp1dODi6Gv/Qkz6lvLR1IDhZiCvZnINekDtdZURljaVl6PIuRw5B+bAaI5GsqKW8hUnKVfCfwsXNQwrrpWMDnrASLPn7msGDgaEfw4N8m0cD0dOJncajAEA6XbdIwS0puppg6NUyl0PUHR7GZLRt/0zEemTEGMLcHw=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3024.namprd10.prod.outlook.com (2603:10b6:805:d1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 25 May
 2021 19:10:11 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:10:11 +0000
Subject: Re: [PATCH v4 05/11] dm: cleanup device_area_is_invalid()
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-6-damien.lemoal@wdc.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <fc584a3e-12f7-6ecb-1e38-98e69b93849f@oracle.com>
Date:   Tue, 25 May 2021 14:10:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210525022539.119661-6-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SA9PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:806:21::9) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SA9PR13CA0004.namprd13.prod.outlook.com (2603:10b6:806:21::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 19:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12757a94-0870-49fa-e73e-08d91fb0b844
X-MS-TrafficTypeDiagnostic: SN6PR10MB3024:
X-Microsoft-Antispam-PRVS: <SN6PR10MB3024C9E2CD98942D577D364AE6259@SN6PR10MB3024.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTCveVA2QqfVTmJ82XsjbwbpQrKAkuawBuZmg5uj7ebC/B0VpBudKsrSWfWUblsbiyqM0k+JXNeUUMuAIQoyAyDbIvwWfKuWioFar8ISw+SpZKBis82RUcKM9UL8m5GcJd/ZBdpqqA04/HQi97l0F5WJbcOD2eiDq3wmibkVxpYvhpJXEP/TiBwr5H9ZB8m/+2IQ+JE/0orwT9geuZTJJddzzKVTtQWU9LlFbAPy3DEIfVujzYV+FLDfVF6UFjQJN+eCeouCRvnxp8B7z+2kkXFmeDXTadFouHXith28O9sQTi4cejOvO/oHCiI/GHoWX6V4et8PHrfQZi2qlPr4r09sjfl6gBxRBPA/d3rMTOhotBh0ZtEVik1LRsDEo8Hh5FlYiVXo6naarqu0WyjuMyFFvBApBWqbg7XTQgmN1yuR8wbR4yaUw5D1KdRHuNAsVn3+GyAAUMcGgJ/X3ZTKEusXG4c9iVmTr4KfVYgEas2ITuqJdX09SgJfRVq1M4URq0CURHY+GaPEKhSfZxs3Z/s710ShskRMEH34KmFjSfZzRXfPzST3jlYclyRYjowBPfX4djTkTmdBO2uV9bxlSsyokpjpMkiFmnS3MsSQShjbLuUruJzpqAAaSxtvzmibAtEuSy2SrHUdgITNL1nykFwtWUyiVOr4SOwrIdz6hQYCTMm+wEoFG7oNsW427eCK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(2616005)(66556008)(66476007)(110136005)(8936002)(26005)(2906002)(83380400001)(6486002)(31696002)(66946007)(31686004)(38100700002)(956004)(186003)(53546011)(86362001)(8676002)(36916002)(44832011)(478600001)(16526019)(16576012)(36756003)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnppNGUvNmtQam5MSHYvWFZhOTB2dGNuei91UHZlOXBLL2plM2xmQkJ3eVR4?=
 =?utf-8?B?aGhMekFHTHZxVVUrYWRVVS9wZHM5eFJXNXluTjZrMmw0WEx3a3ZkSTNPR2ls?=
 =?utf-8?B?Y2xkdUk5VWk1REFMZmNHYjFTTUFHaVNnRkpQMVEraUpjNmU4OGZaaWIwc0V6?=
 =?utf-8?B?aDY2VG0ydjJCQXdiU2R3a0xBWU14eGF6Z200azJEV0tIc1RnVUtIa1RqcjhJ?=
 =?utf-8?B?Y24raENoeTVOc3h2RGJ2OVdmRDM3UTFnM1ljSWRoUkR3ajJwMm5URU5laFF1?=
 =?utf-8?B?ZklCdmZKUFM2K1gwaHdFblBHZVVyR2ViWlA4dDVrRzBlMzc4ZndpZTA2MVdM?=
 =?utf-8?B?TWtGRlRSRW5nemJ2R0krZW5haTBHM3pZci9vQ2Q1c1NlTTFQeFkrdy96QnhP?=
 =?utf-8?B?YnF3em50N240dmdYMTgxeE8wZzBsVHM3V2V4TjFMS1BYOVhLcXNreTZweng0?=
 =?utf-8?B?RE1YWitjRlFlMmpyenVXSTRLdUlkbTNTYlpTN0g1djgzODdMR0FRUVg1RXRz?=
 =?utf-8?B?WFJ3VWRlZytKelRDMDNFbWtHbWs1dkM0TUdpWFNPak4yMzRNdmdDQnEyK0Q2?=
 =?utf-8?B?RXJXb2VXOGMvQnJ6Y1NERG5Db3RvK1B5L3dMNFc5ZEZWTkthM2NHYjg3RFJy?=
 =?utf-8?B?TjN5SGlVaU8vcVo3MzZwQnVGd0NUdk1Kd0dvU0VIUGE1am1Wb2xjb2YzS1dn?=
 =?utf-8?B?bnV3d09DYjdNcWx1eHA4dHZINHhGOXJ4OFpGbVEwL1ZCa1doYU9tTVQ2R2VD?=
 =?utf-8?B?TjFydVYvWkErN0hyYWVIdVF5eW5RQnlFQXhDV3QrTUlyR2tuUUJFaXlxa0Vl?=
 =?utf-8?B?bmRUSEU2Z2FlcUw0c3hOTjVMeFk4VmhnSEF2MFAyOGttNnc2NjFuYjBhRkxF?=
 =?utf-8?B?SXExZlNaMHZKTWlnTkQ5UytwRlpQcVdaQUNKTzVxckkzOG95dGZIMlBISitV?=
 =?utf-8?B?V2lvdWdDeWpjK3MvU0ZLZ2pkcnFpYzNYb2IyKzU2R1F1WWkwUVFYWGM0N01E?=
 =?utf-8?B?THRQZURGVXk0VDQ4dVdOV25pRjFsallFMlNoaDBtNzVyS1ZJWloydmQ5aWxO?=
 =?utf-8?B?USs0L0ZHQzYwM3hXR1NiYVkwOTFYYnVNWnpwTEhYSmdFa29ZcUFHbk9JcVhR?=
 =?utf-8?B?RDU4Z1RJcDQxNzZxazBXeldiTjhPTEkvamNaWmMwb3JsdnhjL01mMUhqK0Qz?=
 =?utf-8?B?bDdqSjRvbFZXL2FoTm1ibThDdVNTRnNTeDcwb3d3Y3dmUVhXRXZXN2F5UDMy?=
 =?utf-8?B?b25XTVJValV5SE5zVm9HdTZqZEtjTHhLeWJ3ZlkvWGtwaVhaSm5OeUxPSTFp?=
 =?utf-8?B?TmtMY3pmUjcxYXVQdkZkc2FSeG5UTGlBd0JPM3lNblFSU285L3UzUklWMjRZ?=
 =?utf-8?B?VSt1RE1sWWQzejhnL2tOdXA1ZnFERC9UZTlIbk41YmdYYkdrTmxIeHhSRUZZ?=
 =?utf-8?B?RnBuclBha1pDaitlSVVtZ2ZIWCtFcWNiSTVIWjdVTDg1MllUUnZ4ekVqZXdv?=
 =?utf-8?B?OW9IMWJmS0NLYnRGYy9TQ0sySzZVejRuR2x5VVBCbW8yNENtckVqVjlERmNh?=
 =?utf-8?B?d2ZjUHg5eVJ0enVTeHkzK2tINHU5Ym45MlJTVlVsSmxtMk9VMmFrcFlKYmZX?=
 =?utf-8?B?bE1NSXJSS2tWWnpyNzY3TlQ0Z2tOWHNHemJaUGFhd1ZjeGZqcWIya3MrUElN?=
 =?utf-8?B?TkdaYVFnUkk2UUM4WDF3M3NST2VEZ3FXd1ZSY0RqbG05cHVuK3NEelBZNHZD?=
 =?utf-8?Q?flEK9XXI4JRXqryhigfwtLV9iqrCb1BIxM93w2I?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12757a94-0870-49fa-e73e-08d91fb0b844
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:10:11.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0kaSrdf2ZLQMre3gmWKUaykxiTD4Deb0GGNbvj9uchhWLnjyuS3cTvbjGCKcN2/xFRYD8Tmkq+ZKF+IiYoIc0226ssxfu1l5FOMOU9+5kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3024
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
X-Proofpoint-ORIG-GUID: q55Xpm4_IX5uMrf0BrUlcTld9CcTp0YM
X-Proofpoint-GUID: q55Xpm4_IX5uMrf0BrUlcTld9CcTp0YM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250117
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/24/21 9:25 PM, Damien Le Moal wrote:
> In device_area_is_invalid(), use bdev_is_zoned() instead of open
> coding the test on the zoned model returned by bdev_zoned_model().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/md/dm-table.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index ee47a332b462..21fd9cd4da32 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -249,7 +249,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>   	 * If the target is mapped to zoned block device(s), check
>   	 * that the zones are not partially mapped.
>   	 */
> -	if (bdev_zoned_model(bdev) != BLK_ZONED_NONE) {
> +	if (bdev_is_zoned(bdev)) {
>   		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>   
>   		if (start & (zone_sectors - 1)) {
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
