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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6EBC2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084756140F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhEYTMd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 15:12:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 15:12:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ5KxH110036;
        Tue, 25 May 2021 19:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bwpfj+C/NnrYja0rBOUQh1IBUcSK3uqwQmxAdPxU3LY=;
 b=F4XdIcsOYFGVwDuuP0TH699skeMo9Lklfa9W33UIcfeLL3f4PWogg1avbKJCYCnK9Up2
 kyhrH0LoNrrodqWX42oPG3LIdnvK07W+lyd6uMmqq7aC4yZY58T4Wgrmfmz7Qhb1S1s/
 PtXGwKRYBRyJCufRFF6Rga4C5CvgL/dydSwr42xDXPZZd755lebOmeFxYS5C9qk2GQKg
 dgGbLaPqciD6GdIvcblwl6X7AwVpgbLAGpvCw5ckOcU6bNRUf10m+Q+AwgNBArmrnSJs
 H/RZydb2iexnZO52YKSD3GNtXzbLSzTALnrfypt4kjZsmS67jvFkGHJvBZMODCP4WYTm MA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38rne42mab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:10:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ63cQ015962;
        Tue, 25 May 2021 19:10:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3030.oracle.com with ESMTP id 38pr0c27sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm8iasP3WVE7+NaumRTYOTfwG/IRqdIg+pXNplLf5g9GutOj4rMSJ9WmjfzZWthdaxBtkwgf/t3keiOtIAzhgWK0DXogrV6vnwFYdzTyXhoosmy0ugmWkKue2bF4OVsO5ZUjE/ZLME+HJcC0LCth7KsPQRwofOshBt6rPf2YwmhZlKEVlb5iAVTipF1qQ+clUX5aEF8ZQ9tTUTUcB0mwuX6//si8k1FN8kcRG6WtH6M3OVjhatzc8pY/f7BhmFKQczP03xXxm980FTwHfksjkC6FmHDB5LWXD70NaceAXKGKbsx/vJZBp7oFVG8TBFPgYVFUz63FmMNuQ6y/k2Jc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwpfj+C/NnrYja0rBOUQh1IBUcSK3uqwQmxAdPxU3LY=;
 b=htVhOPD91S/06wUexcc1hDdCANXtTC+kXaIBfrQMpkp5/SOla/tf4Vjqr3W9538n/LuV7vEWBFmqyVlaEHJ6iL/Osph6Cq8yQ9MHk8YaMNPxIPPgQcJylNOBU3UPnx0UdJ0oDpR71OcT63Hz36cU5GOqQrYKLGJg4dw81yUWRx7HXlSW5/WaDtVeJxNuoCaPK2yxwYx2xG1nkZsc4h+X6+0ga1lwe8iNdXjJPzZ7X5wpuegkgs4zAwcR1lYPvg9rDiLiycyiJs9Mf0uPyIKKui2r+Q9M2lFnl0xDXGR6hMF3c4a1ohSfrf1rE+rHLpUn6AZPDTMYEFhJ27VGuiNWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwpfj+C/NnrYja0rBOUQh1IBUcSK3uqwQmxAdPxU3LY=;
 b=tKVAD6ZDGXVJv7b260L5oWLK0B0/dMuldiHNZ9Oaa38bxw9NuA4NhyNIKxBZIc0IKd6Dp9v85vyFYUYtKvok2PsscjfNL4UUcPKI/3eY6ZMPL/rIuDXcEUVxE+Z4psEq3nevrRy36dPvT6C7BOvowaa8mPRDAhU4B37+WQxJ5qI=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 19:10:58 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:10:58 +0000
Subject: Re: [PATCH v4 06/11] dm: move zone related code to dm-zone.c
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-7-damien.lemoal@wdc.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <6ae6ba83-24e3-5e9a-7d9b-c9cab9a6874c@oracle.com>
Date:   Tue, 25 May 2021 14:10:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210525022539.119661-7-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SA9PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:806:28::15) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SA9PR13CA0160.namprd13.prod.outlook.com (2603:10b6:806:28::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 19:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ac8486-e293-46a8-93b4-08d91fb0d3e5
X-MS-TrafficTypeDiagnostic: SA2PR10MB4683:
X-Microsoft-Antispam-PRVS: <SA2PR10MB468357B34CD0AB73E119FE96E6259@SA2PR10MB4683.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pivUKlohP/9K7Ab2/rlNJeFnGmf52aBTPMQVNVYBPxDyubvOvxXNmEOGz/bxLiJvCpKkxIoA/5UX0+gFSN13B509ca4b0szxWmLYL+Y9mcl/6krvI/vEs0w6uCVWiORwGNXmjjwtWJ6xbyjXSqbjrNiGdzo1GEi9AfqjflZXVysPf4hz1M0IRzwwJ5Mq2OV/olqV8Za1GaZ22ShkvqciocL+79kBF1pHFimBl8vOkbkQmfE4P3fUhrh6kWfdUdJiWqqvLiZlvjiHg4/rSjYY3Mnd8EIa41d7RqJUozSW2G3ZyRdnWQ9dSP14aArxwvaad2Fvx9nQVNc48oj6GHY+dIs7H0tOh6maN3p/frIg2JiyMCSd+EWq+QzEi1SpiUsjHZtm8Hjvhl725VT0qpAQgIBBVAGXwlOh9lEJP20t/gbY+n0f3uceK9+srHqgirok8nLe3gmUVoKRNri++wP+fqxP23U2initEXvK4R7zbeph6KYoyr0YtEiEZmH5+FWb3p9iUzrXKiBza+t4clgW+g1JU/7TRpbR9S7FJB4UyL7f2vBuBme3fUNZaNe1erRWm9iF+Tkw3ueSZjVTL9D38mA37SiHDEqy0QeYogpT/vn+3PzbVDi92TCig55kdpbxSqtH9pxVldhnGq5R71rWro0JmEeCzYtUBUsAjpwfLrNluSkusXhv9ZyV7N0iXYVN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(66556008)(66476007)(66946007)(110136005)(26005)(8676002)(31696002)(83380400001)(5660300002)(38100700002)(86362001)(36916002)(53546011)(956004)(2906002)(2616005)(16576012)(31686004)(44832011)(16526019)(478600001)(36756003)(186003)(6486002)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QnVGK0lhdFZxUGl6ZFh0aXQxR1BzMXpLUWJVSVRGYml3MFlyWjlZOUdrb0NT?=
 =?utf-8?B?MnoyV2k1cFMvM1BFZXNaNWxJL00xclBvWlppRnZwVm12SzFCY3Y2ZkJKZFdk?=
 =?utf-8?B?Y056Y2hHbTVEbU90V3NhditRV0l5Wkg4UVFBK2NqYmkyUDltb3JyVitmZVh1?=
 =?utf-8?B?RGFWUjR0U1JiRHhtL2VBazk3NERtcndScDVxNmRhWXZ1U0xKWDRLSTBxRDhP?=
 =?utf-8?B?ZmFoRTVLOHIwY3BPcUpnclJWVTJESFVKTzRIaTU4Q0VaZThtbUxHTjdKYXQy?=
 =?utf-8?B?V3NPM0pnZHR5OE9YT0lWTlpUeWtJdHdvNDZINm5talBjalRpenllR2h4ejRI?=
 =?utf-8?B?ZElRSmNrL1I5L3I0b2doVjE0U2lUS2dmeDU4dlpVVkNTTXZEaXlLVW91azdZ?=
 =?utf-8?B?UzJRN1hXUTJvSUtBYlJEZFBZYWxlN2h3TW5PTlYvZzZqMVlhSHNXN0pSSUlG?=
 =?utf-8?B?Y0dtNTdtLzNvb3NHMmhaM0d2S2UraWZBL2N5N3ZWUWVuMDJBUElkQ0FYY0pL?=
 =?utf-8?B?UmFuUk1zdTF2RWR1cGc4b1Axd2l0TzdTNXd2b0wrTEg3VTdEQ0p3TEx0ZmZE?=
 =?utf-8?B?QVQ0b2N0aXlPbUxsenNZenlrdDNSWVdRQkN4K2ExdG5JS1FnNVdCbW16ekdM?=
 =?utf-8?B?Z3grVVFxbE1zV3BMQ0hGMDdBMjZVV01MakRmTVBQN0xwMlRWOWVScXJWcW1B?=
 =?utf-8?B?VmtwLzZwMFFnNzlVQzZhcVU1WXhUeEQ1Rm9ycW5QcCtzYnliWGhGZGZrNmVr?=
 =?utf-8?B?VStvTlJKYzVJTU40RjR1RUZZSExWVTl0aWN2U1RYWUlCNUcxeHZ6dktJdVRh?=
 =?utf-8?B?ZUtzUXVKVy9sdWxvYWhFRVJ3dklPVHllTUpud2krZmFqa0NKRU9xbFc1L3Aw?=
 =?utf-8?B?cXcvUWVENm94dGhMaGhiWGNvNTJINDdPNEUrYms5NFJpMHNMRGlhMUZ1YXBo?=
 =?utf-8?B?VG0yVS9iaTF1MFV3S0RLZDNVaVpLbkZVK3ladHQzQnUrS2VDQlo3d0YrY1Vw?=
 =?utf-8?B?R0pwVEtmR3BGdDVNZkw2SFNUclMwdXY1MSsweUFzNnZjU0szendVSy9DWWtk?=
 =?utf-8?B?eVpObE5ydmRQck9IeGlJdGsrMlhEZGxUejg3UDlTUVA4TGFWTS9kaGY4UjBy?=
 =?utf-8?B?dGFHWitQM0o5SHFiVWptdk8wWjdqbmV5bitLUzB2NjVzVk1GUkRGOG0rS1VD?=
 =?utf-8?B?TytyWWNDVjBzaXB3ZFhsSlpLd1VRYkxhbkFZSWJjcHorSWdWTTBIV0xHekF3?=
 =?utf-8?B?V1RhS0hMZXRtN0xiL09LTFFOMVFKdmg1U0VEaTh5QlBuWGdNdU1wZ2dGMjJa?=
 =?utf-8?B?Wm5Qb2pPME5jalIvSnNqWWtkRDBxRUlreVJNRGtVUFc0UFFDMWpQenJNeU03?=
 =?utf-8?B?YjUyLzVxbVQxWHhNSS9nNWZKOUZrd0dyZDJwbjlNcjZvOGJHQ1AvOVphRWhR?=
 =?utf-8?B?Rnl0RDZSb0RaTTFPNnMrSjR1RmFUN0o5WmtvQjZTNlNrZzllUjM2S1ZwZUhU?=
 =?utf-8?B?elB3RUliWEZqWWV5ZExlWTM4WGJDWXRTdElpUU1vV0ZqUVpFSlI2SXFJMm1L?=
 =?utf-8?B?K0ZFdE54RG5Bd1BIVVpZc0dTblZVOWZzTGZEdnhxNVZJVFdncXJ1aU5mTEtO?=
 =?utf-8?B?eFNXSGpORnlqMTJCVS82OUIyaWZkYmxUNmlYVEdrcjFpcE8rVnA1bmV5b0gz?=
 =?utf-8?B?QlBWT2dCY3hodGlPcTZCS0tLQXZlUXZGRlpRNFh0OTNjY0NDZlFlZExWdjhm?=
 =?utf-8?Q?DYhiVUqgDKG5sqlmYgtosPeWjY2yDprIr7M1F77?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ac8486-e293-46a8-93b4-08d91fb0d3e5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:10:58.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyz7+k5UsXPT3jY+NCnylg/wqUaVQNaxM9OKLejWOl+iJGKtikdxmnErjO/eVeEp9g4MYWDnffBqliT0Mbat3bV+CcrwxiJdhyB3ifcCIYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
X-Proofpoint-ORIG-GUID: _JZseefAbKYWOatkscwWDOOPuUZ7gVKg
X-Proofpoint-GUID: _JZseefAbKYWOatkscwWDOOPuUZ7gVKg
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
> Move core and table code used for zoned targets and conditionally
> defined with #ifdef CONFIG_BLK_DEV_ZONED to the new file dm-zone.c.
> This file is conditionally compiled depending on CONFIG_BLK_DEV_ZONED.
> The small helper dm_set_zones_restrictions() is introduced to
> initialize a mapped device request queue zone attributes in
> dm_table_set_restrictions().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/md/Makefile   |   4 ++
>   drivers/md/dm-table.c |  14 ++----
>   drivers/md/dm-zone.c  | 102 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/md/dm.c       |  78 --------------------------------
>   drivers/md/dm.h       |  11 +++++
>   5 files changed, 120 insertions(+), 89 deletions(-)
>   create mode 100644 drivers/md/dm-zone.c
> 
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index ef7ddc27685c..a74aaf8b1445 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -92,6 +92,10 @@ ifeq ($(CONFIG_DM_UEVENT),y)
>   dm-mod-objs			+= dm-uevent.o
>   endif
>   
> +ifeq ($(CONFIG_BLK_DEV_ZONED),y)
> +dm-mod-objs			+= dm-zone.o
> +endif
> +
>   ifeq ($(CONFIG_DM_VERITY_FEC),y)
>   dm-verity-objs			+= dm-verity-fec.o
>   endif
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 21fd9cd4da32..dd9f648ab598 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -2064,17 +2064,9 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>   	    dm_table_any_dev_attr(t, device_is_not_random, NULL))
>   		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
>   
> -	/*
> -	 * For a zoned target, the number of zones should be updated for the
> -	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
> -	 * target, this is all that is needed.
> -	 */
> -#ifdef CONFIG_BLK_DEV_ZONED
> -	if (blk_queue_is_zoned(q)) {
> -		WARN_ON_ONCE(queue_is_mq(q));
> -		q->nr_zones = blkdev_nr_zones(t->md->disk);
> -	}
> -#endif
> +	/* For a zoned target, setup the zones related queue attributes */
> +	if (blk_queue_is_zoned(q))
> +		dm_set_zones_restrictions(t, q);
>   
>   	dm_update_keyslot_manager(q, t);
>   	blk_queue_update_readahead(q);
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> new file mode 100644
> index 000000000000..3243c42b7951
> --- /dev/null
> +++ b/drivers/md/dm-zone.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/blkdev.h>
> +
> +#include "dm-core.h"
> +
> +/*
> + * User facing dm device block device report zone operation. This calls the
> + * report_zones operation for each target of a device table. This operation is
> + * generally implemented by targets using dm_report_zones().
> + */
> +int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
> +			unsigned int nr_zones, report_zones_cb cb, void *data)
> +{
> +	struct mapped_device *md = disk->private_data;
> +	struct dm_table *map;
> +	int srcu_idx, ret;
> +	struct dm_report_zones_args args = {
> +		.next_sector = sector,
> +		.orig_data = data,
> +		.orig_cb = cb,
> +	};
> +
> +	if (dm_suspended_md(md))
> +		return -EAGAIN;
> +
> +	map = dm_get_live_table(md, &srcu_idx);
> +	if (!map) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	do {
> +		struct dm_target *tgt;
> +
> +		tgt = dm_table_find_target(map, args.next_sector);
> +		if (WARN_ON_ONCE(!tgt->type->report_zones)) {
> +			ret = -EIO;
> +			goto out;
> +		}
> +
> +		args.tgt = tgt;
> +		ret = tgt->type->report_zones(tgt, &args,
> +					      nr_zones - args.zone_idx);
> +		if (ret < 0)
> +			goto out;
> +	} while (args.zone_idx < nr_zones &&
> +		 args.next_sector < get_capacity(disk));
> +
> +	ret = args.zone_idx;
> +out:
> +	dm_put_live_table(md, srcu_idx);
> +	return ret;
> +}
> +
> +int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
> +{
> +	struct dm_report_zones_args *args = data;
> +	sector_t sector_diff = args->tgt->begin - args->start;
> +
> +	/*
> +	 * Ignore zones beyond the target range.
> +	 */
> +	if (zone->start >= args->start + args->tgt->len)
> +		return 0;
> +
> +	/*
> +	 * Remap the start sector and write pointer position of the zone
> +	 * to match its position in the target range.
> +	 */
> +	zone->start += sector_diff;
> +	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL) {
> +		if (zone->cond == BLK_ZONE_COND_FULL)
> +			zone->wp = zone->start + zone->len;
> +		else if (zone->cond == BLK_ZONE_COND_EMPTY)
> +			zone->wp = zone->start;
> +		else
> +			zone->wp += sector_diff;
> +	}
> +
> +	args->next_sector = zone->start + zone->len;
> +	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
> +}
> +EXPORT_SYMBOL_GPL(dm_report_zones_cb);
> +
> +void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
> +{
> +	if (!blk_queue_is_zoned(q))
> +		return;
> +
> +	/*
> +	 * For a zoned target, the number of zones should be updated for the
> +	 * correct value to be exposed in sysfs queue/nr_zones. For a BIO based
> +	 * target, this is all that is needed.
> +	 */
> +	WARN_ON_ONCE(queue_is_mq(q));
> +	q->nr_zones = blkdev_nr_zones(t->md->disk);
> +}
> +
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index a9211575bfed..45d2dc2ee844 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -444,84 +444,6 @@ static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>   	return dm_get_geometry(md, geo);
>   }
>   
> -#ifdef CONFIG_BLK_DEV_ZONED
> -int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
> -{
> -	struct dm_report_zones_args *args = data;
> -	sector_t sector_diff = args->tgt->begin - args->start;
> -
> -	/*
> -	 * Ignore zones beyond the target range.
> -	 */
> -	if (zone->start >= args->start + args->tgt->len)
> -		return 0;
> -
> -	/*
> -	 * Remap the start sector and write pointer position of the zone
> -	 * to match its position in the target range.
> -	 */
> -	zone->start += sector_diff;
> -	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL) {
> -		if (zone->cond == BLK_ZONE_COND_FULL)
> -			zone->wp = zone->start + zone->len;
> -		else if (zone->cond == BLK_ZONE_COND_EMPTY)
> -			zone->wp = zone->start;
> -		else
> -			zone->wp += sector_diff;
> -	}
> -
> -	args->next_sector = zone->start + zone->len;
> -	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
> -}
> -EXPORT_SYMBOL_GPL(dm_report_zones_cb);
> -
> -static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
> -		unsigned int nr_zones, report_zones_cb cb, void *data)
> -{
> -	struct mapped_device *md = disk->private_data;
> -	struct dm_table *map;
> -	int srcu_idx, ret;
> -	struct dm_report_zones_args args = {
> -		.next_sector = sector,
> -		.orig_data = data,
> -		.orig_cb = cb,
> -	};
> -
> -	if (dm_suspended_md(md))
> -		return -EAGAIN;
> -
> -	map = dm_get_live_table(md, &srcu_idx);
> -	if (!map) {
> -		ret = -EIO;
> -		goto out;
> -	}
> -
> -	do {
> -		struct dm_target *tgt;
> -
> -		tgt = dm_table_find_target(map, args.next_sector);
> -		if (WARN_ON_ONCE(!tgt->type->report_zones)) {
> -			ret = -EIO;
> -			goto out;
> -		}
> -
> -		args.tgt = tgt;
> -		ret = tgt->type->report_zones(tgt, &args,
> -					      nr_zones - args.zone_idx);
> -		if (ret < 0)
> -			goto out;
> -	} while (args.zone_idx < nr_zones &&
> -		 args.next_sector < get_capacity(disk));
> -
> -	ret = args.zone_idx;
> -out:
> -	dm_put_live_table(md, srcu_idx);
> -	return ret;
> -}
> -#else
> -#define dm_blk_report_zones		NULL
> -#endif /* CONFIG_BLK_DEV_ZONED */
> -
>   static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
>   			    struct block_device **bdev)
>   {
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index b441ad772c18..fdf1536a4b62 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -100,6 +100,17 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t);
>    */
>   #define dm_target_hybrid(t) (dm_target_bio_based(t) && dm_target_request_based(t))
>   
> +/*
> + * Zoned targets related functions.
> + */
> +void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q);
> +#ifdef CONFIG_BLK_DEV_ZONED
> +int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
> +			unsigned int nr_zones, report_zones_cb cb, void *data);
> +#else
> +#define dm_blk_report_zones	NULL
> +#endif
> +
>   /*-----------------------------------------------------------------
>    * A registry of target types.
>    *---------------------------------------------------------------*/
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
