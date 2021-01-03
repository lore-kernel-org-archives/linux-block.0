Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E45C433E0
	for <linux-block@archiver.kernel.org>; Sun,  3 Jan 2021 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CE92078D
	for <linux-block@archiver.kernel.org>; Sun,  3 Jan 2021 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbhACVz6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:55:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62334 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbhACVz5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 3 Jan 2021 16:55:57 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 103LpM28016101;
        Sun, 3 Jan 2021 13:55:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9cS/bPS8mzJpHeHHyS2WoTh3L1uOJd3Z+IgNuHzfufM=;
 b=THyGULTLWLEMGMSTlj2V+S4OVMFG2q+cKoBqcQn40Xxld1WNG1IJVO0vakThi/MtH+aF
 r57LeNCDrhfGAl2K31gN+TRN8Zee5M8DrBiCOO4omd4P2ZiN0yD8WnE1eab/HYZpDuWV
 pJPK8VnLEbbpyS0ZqhuH/XWKsfP6JNTsqpo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35u9ruhfac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 03 Jan 2021 13:55:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 3 Jan 2021 13:55:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEWjN9xVDk37spaCtdFr9OO5jcPl4gSf0J4apSMzSE++9xor8M2plEmpacf4yMwm2+j4SG/yYri4tCHP29Wq3uI9V4ckcXKhO84v5B6We/ZL71vEbrKRk553zD5VQuKfyJGCagkOvAAgiINvpSu/1YoEuKnEnOMcy7AR+rlh5spRwrnDAIisGaA+/Y3QBER4T8oaNoCzhyxG+N6CyVd3smPItUmLuQ8VdNJ+E1sqGzmODBFth31hGkqbQbK3/v1HlcKU1/bM5Vl01jqB6JTCSYyoy/gzSIZ3RlUXmjGkD6A/KjDqWSDlOb1+462lbAxjgv9SwSuPyzW4sNX2dyLZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cS/bPS8mzJpHeHHyS2WoTh3L1uOJd3Z+IgNuHzfufM=;
 b=GClKkHJkgDcDCGoCI/Cr1qubcd9G6/kFhqSReZvrNBPUI3jdH1FnKpfcLVch6jYCojIaG2kDHxBsLyc2dRPWg38lLpSrdbfR5OslYi/6YpibFKBgzzmCeoKhdFlh4vnogj9j8voNXafThcGAUD86fBJL6ja9RIPv9rmoHmud2s8Ol411KV3C8Ot8J1OhQmDZvtZJWEUZO5Z3JZoysqvrgh0EyTfBChv6t2i1vkWiXiva4SQssyL47nrhklC02lnxAQ3z8h56kP7bwG/86K5L2BaycdzIKOuK7IOek0L44TiG21Bq51U/84NCsmlFJE4sYGOpyE0ZyVLt8siWkW+orQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cS/bPS8mzJpHeHHyS2WoTh3L1uOJd3Z+IgNuHzfufM=;
 b=ensssRFCVi66l5k05VKCqXzoCwXSseHSU9zNE8B+yH9aLXL7T0OfdWu/E8M7KVKvgVnjCUorgVK1Qp1OREFZM70yetlBaV1M5WI967Dx/N6N82hkEl7jCJ9GShNYoXvDmKhos5J2RL1Sy6ObK9efMZ7BxgyteK1AU/I8z2hiylE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Sun, 3 Jan
 2021 21:55:08 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb%6]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 21:55:08 +0000
Subject: Re: [PATCH] lightnvm: select CONFIG_CRC32
To:     Arnd Bergmann <arnd@kernel.org>, Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210103214316.1997006-1-arnd@kernel.org>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <89046687-b650-afbb-af14-0a3b0dc1a8d0@fb.com>
Date:   Sun, 3 Jan 2021 14:55:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210103214316.1997006-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [66.219.217.173]
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.134] (66.219.217.173) by SJ0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:a03:331::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Sun, 3 Jan 2021 21:55:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba4f54c-7ca9-4d00-906b-08d8b0323cc6
X-MS-TrafficTypeDiagnostic: BYAPR15MB4119:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4119EB78FE34F983A7A30B5AC0D30@BYAPR15MB4119.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ8gfKluKpBOGljctwMHNzB6roe2LEp+JEyrDssAPrxW5D1q/GbJ+4R/bd95aJMkvgk/cyehya9KNlABpVIDMaEOTvgQaJBCzNKxZslKCMXFIzAAhf7oG9LyWQPDAWQ3F/eIBJ4aNDlYOPGVhpLyVwL0MfRaTroXMaMDkX7G/PvhRQzgaCVDQUAYvsTBKdmTeIu5hEd8cHCVfIpsWwwskuMKycv+S8zTRYggSrdubggbnc4rwuHyYw5wqqdpo5nLPlXWtRsmfbwONcmoc6PySohX1VOgWINwM/wp/hZA6FOjjZPWpRqUtUpUByefnkqTNhImVrqProAtFwxkuh5tBE2qwHCnF/cEJ5EYg4gQi0QEYXChTM+OLkOg6vjYyjez2ShSZbF4NFxlGPANrIC+fySJsbRHeqIIzBqd+rsSexX74iAr9bTTX6/sV8i0ZGo9XkUddW7qnm5rhnAQ7FDYfIpqTMyfhxtBca1OYm0j3rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(136003)(366004)(2616005)(52116002)(478600001)(4326008)(16526019)(31686004)(186003)(31696002)(5660300002)(66556008)(66476007)(4744005)(66946007)(8676002)(956004)(36756003)(2906002)(8936002)(110136005)(53546011)(16576012)(316002)(6486002)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUwyVUFVWFRmZE9JQkNVU0p5aTFuWW9LR1ZZSGtuQzdSSTFDR0dxdWVRZUVV?=
 =?utf-8?B?d1psNURoUytsRHRQWno5ZC9DbjdnRGd4RTJEU3pQMGw5cDAxVGFzcjhObGJv?=
 =?utf-8?B?T2FvYUp0cDNBWDB1UzNUWVd6OEQxaW5rZVo0dnhLYUk5Uld0N3Z0dU9EdS9n?=
 =?utf-8?B?clFLc3FsWVhTanJwSjdyejlpMkpSYzBDS29TVjluVkpoUnRxVkd0TmNCTlM4?=
 =?utf-8?B?ZUJ2OGMraWtjc2trTnJmS1YyNTBQMmFoN0pPd3h5anJyRlRHZ0dCSGZZdU4x?=
 =?utf-8?B?SG0wWnE5cTQ4UVh4N0lxc3Q1ZWc1WU81ZmdiclpUSEltNVVKUHhYVEVxZXFG?=
 =?utf-8?B?UnRDSTIyQlpuV2hpd3ZUNjN4YnE4QVFHdXlKRHhXU2FFbXpLcGUzbXpaYmZX?=
 =?utf-8?B?N3VEYW9FcUNlWjJiNEYvRVUzSnlSSzFPYkt4aFdTRm4wL3krNGxZWkdUSkta?=
 =?utf-8?B?MThRbGN5ZDBXbitYTjlJWC9zWjM3dlk4Y0RPRWVwcDlHM1pmZThOQmo4Q2tV?=
 =?utf-8?B?RlZDZzNmTTZ2T3pWKzZMM0diMlR1QnBaUUtGOVV1M3BjUjZaQVhUaW15MUhU?=
 =?utf-8?B?eDhyT2xHbjdIU1NhZWdoVjUzc3JuVG1zSlBQZUVxK2x3TUJhS3dLdjFaRG9w?=
 =?utf-8?B?YnFDck5aQ3QrZzYrY1gxZ0R5c3RwWlN5L040S1BPZzV6U0QzYXVwNkF6VGZj?=
 =?utf-8?B?ZkxpRE51SHhSZmlQTDNTam5zOGdMRHE5dXRuK1ZOd2hUeHRmSmJyMmVRRGM3?=
 =?utf-8?B?K2lZeTdqNlJVL2Mydi95K3dZNVNGcTVPdVZsRElqNlJwU3diTXZ2TDlyUjVk?=
 =?utf-8?B?NFRnMFl4Z3R0dzRSUlVUbjZzSE5aeENBVzJPeFBMTGNzQ09JWlIzRnJOeW5q?=
 =?utf-8?B?c3pZREJjVnN6alp5MkhSTFRra1hYcXNSeWtadDZYaDRrSTlEeEQ4Nkhnc2ZN?=
 =?utf-8?B?YjZ5WVdYKzdycWxVenVxMjVaSnFHNndpSzh1Qlo0VFlqdHVYWGwwYlNlYktZ?=
 =?utf-8?B?WlZVeHIzZU5FV0VockRSa0ZkNjVyZFp2R3V3TkxDRlZOM1p5c0pJd05aZWE3?=
 =?utf-8?B?VW9HNEVGU0lnVmdCa3pEaGVmK0dwd2xjNXhCM3VUTjBOZEk1OVU1RmVINmdR?=
 =?utf-8?B?UzZ6MlIrbG1ySDdHc2dMQUhkRnhhS2pjWGJqMGNMTElOTWcvdUJkQzR4c0dm?=
 =?utf-8?B?QkFMRU9JTXA0dWtRVUp0YVpzRnc0aUVkSStWbCsrZlZkODFWZFppZEJZR3Ez?=
 =?utf-8?B?WkdSQUxwNWd3T3l0cG5tZ2plSmhYQm5mTzQ3b2FORXoyN1orVk9mT01VUHpt?=
 =?utf-8?Q?yzClIWR46FYk4rKTO5lyVFKV2on+XLF249?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 21:55:08.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba4f54c-7ca9-4d00-906b-08d8b0323cc6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGD+bmeLCo6+erZF6BzGQNopGzG6GaH0k87QS0NTpHWbfHiZuSOgBZ8Yz794F2zf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-03_15:2020-12-31,2021-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101030140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/3/21 2:43 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CRC32 support, this fails to link:
> 
> arm-linux-gnueabi-ld: drivers/lightnvm/pblk-init.o: in function `pblk_init':
> pblk-init.c:(.text+0x2654): undefined reference to `crc32_le'
> arm-linux-gnueabi-ld: drivers/lightnvm/pblk-init.o: in function `pblk_exit':
> pblk-init.c:(.text+0x2a7c): undefined reference to `crc32_le'

Applied, thanks.

-- 
Jens Axboe

