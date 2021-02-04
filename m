Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C47C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F8664DF5
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhBDPaL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:30:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56088 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237315AbhBDP3A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 10:29:00 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114FA0iM000302;
        Thu, 4 Feb 2021 07:27:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=B0jPhiooojX+jQv2pQhdIvxdkllG0CT+N9CtaAkul7c=;
 b=iYiNBYb94LX/jdP6hWiGmw/8KG04SVfLBps2oB7EpC4OJk+bebTLi6wSEjt2ELr/A7EW
 wtaFeFXqUrBILYPDiQ50YpE0VsgRk0Vl7oDiYdWFoVFJTQWZl5Q7WX3ho2ERL9IVqx7z
 BNWk8HGc4F3ww0jMiN6Sd247ibIZElsfY90= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fwynem4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Feb 2021 07:27:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 07:27:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB9hSQw0UviZJoQZv6QeRV7m/NIZ8/7+Q+RcvPlIHXF6SmyHW8xiCUpHdGJlmLHCgsYqGCngAyzgKQcG9a42lyawS0qWxlM3DqWmQ5mCEYGS2W/1cGjR9fL8bu/Lk6wAcq1yrUPDvZ1m6tlNSwmrl5mtZXxmLMdN6rDSn4rbcPvqO9tlHiCvqb6/QIQeZzGUwEeWt4hWNGvyhw1o/umQWdKTRJBKNRIzGxd6/Ke7/l2ltL6yMQ2uZyzBhCFZGAIakb5UMCy9C89P446ZrPsES90QvzoyEDUY5dNBUkIIXp5GNgNj/AKVjRxCmhpGSIH9Snfg2LzIFeiJiRTBUkeJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0jPhiooojX+jQv2pQhdIvxdkllG0CT+N9CtaAkul7c=;
 b=Kl8Mo6EjgAEm9ygOvEx1S269WofndmWSIG+RVFUcQvyPWWhXkx6r7tMLAk7hUNrKuZXH/650D2oka6Qt7YbXZGOLkr9DW/NPF4xo1kHLq5sGFhuZm8/u6YiRKWAtANb5HI0kmxs39hKQQd15V0FgcSmVIdGXyFJZvEoQXY86IIwz2W2UkY+MxV55iDopryQ8eMo9dttgTjGkZFAli/uKn5rETFCgm+uHHUFKIeVXFG8zQTys2o1pyKQWGZSuOl51tIpFyHC/H8WiLUjulb7BQicIy6h8UPKkWJo5ipfYJo1K47nNnVJgjikJLKgdzbLmdDYFiOmMbRRZggYuI+6ZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0jPhiooojX+jQv2pQhdIvxdkllG0CT+N9CtaAkul7c=;
 b=TWE7tvKSZ3G3RJS5VLuT7zWsI4a0UFoVXm7sKklMo/AoFvnjOtr+WOPSJYnZ3YS/f/lWwK22TKj8t1ZKCm4nlM+yoMZQhkOf/+yuP5NpiksQR2c7kXrzSsc2X5UnFxZ05wm23dZaMNsS9FeEQ4D9H0kAemjHugJqilDhoaYMCYg=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by SJ0PR15MB4233.namprd15.prod.outlook.com (2603:10b6:a03:2ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 4 Feb
 2021 15:27:50 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb%6]) with mapi id 15.20.3784.023; Thu, 4 Feb 2021
 15:27:50 +0000
Subject: Re: [PATCH v5 1/3] blk-mq: introduce blk_mq_set_request_complete
To:     Chao Leng <lengchao@huawei.com>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210201034940.18891-2-lengchao@huawei.com>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <3b75b43c-638b-b5ac-eb5e-e37314d25ce1@fb.com>
Date:   Thu, 4 Feb 2021 08:27:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210201034940.18891-2-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.144.74.34]
X-ClientProxiedBy: CH0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:610:ce::22) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.30] (65.144.74.34) by CH0PR03CA0167.namprd03.prod.outlook.com (2603:10b6:610:ce::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Thu, 4 Feb 2021 15:27:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ab1249-d574-4282-b87d-08d8c9216ec1
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4233:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4233E0AFA31E8622E036A146C0B39@SJ0PR15MB4233.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhyZwvoJZLQzg2n1vAr98ObKiB7QuYegIeC0lypPoQ20e68GaS1EsHMKGF+DBY9otokMjni6MdzRsGN6VpzuIehXBuJpZ/HYwpUlpyO5ORWVKSV7NJV0UbmJK6jsWfNAIXOIC7XwFoq0x2gBE74pqk14vI6AcpzzbpnCh0d51zgvtbOgQV7lksO1FWEIznnRdFfx5gnttqOOeP1Ea97mnyV/3LQ+FvBG1j6TfAHIizE8FxjvyqHUeov4LRB4/2ciofP2X2Z4orZV5SWprzX6my64UmedYBIldsbNIKYF5/EDTpBmAHRPRlz7+xo4mK/8eMpk1BBjFvK1YjiL2ClU+4C2fGsAvS4wPkgOyeDHfyvegZLD97Mbtu5AvU2g7YEMG5aYEPgk0inbEKAfWE5l31OC7CGUlwEd2K7JpH+cbl2h5DsYl11R385bp2oCXHmrEVlbWuSUphYMjVdXZ0jmeUElKJ3Zw664/HvOH0znOCDOiHvfrWUZ6lJUponYgG24Oui06Z7g2AT73BS2dU5xcP/dBzjScCYY3W9f1m7vSOAiw8S/fSAcv9G/t9vhSCn3BKb7dcDoY+6/m2ZPXGnrdEDscti633KR7YlDPBAVvrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2566.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(52116002)(66556008)(316002)(66476007)(66946007)(16576012)(4744005)(5660300002)(4326008)(8676002)(6486002)(2906002)(86362001)(186003)(16526019)(2616005)(956004)(6666004)(36756003)(8936002)(53546011)(26005)(478600001)(83380400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MER3V3MreHY3T0tDQmhWYlhSb0UwNHNiUC9XcGlZMWI1SXhKdXYvcmNOS2s3?=
 =?utf-8?B?eDhLeGpWelloYzhYMHdOdnNHemxVb2ZFNk5rRms2bFM1ZUZyYkx4TE5xV0Zr?=
 =?utf-8?B?OEJ6NUIwa292SFpsVFRZbzQzNGxnY0NvT2RBK3crZHhSbUNUMHhpZUluRTU3?=
 =?utf-8?B?RXV5eWI5TWdxWGpyQWNLWkl0MjZOMjdqcnFib0R2VzJ4dkU4RmUvRVltdUIv?=
 =?utf-8?B?QkZlZnR0eVhCZzYyelB1TWI2VVJMOWVZK00wclBDQlNpc1VESlNSNG5aMVJH?=
 =?utf-8?B?a0VRbURJZ3E1cUM5Y0VpYUFDWHg5NXltUnNuYy9lNFl3TUNxOFo4cHkvdGJ5?=
 =?utf-8?B?S3ZoeXlmTG8va0wzb0poVXcyZS9IWFAzejlUZjEyM3R1Tld3emZPenl1STFR?=
 =?utf-8?B?NTM2YzVNa3k4MFI2ZlowYUhQVmZSMDlxQjFvNWV4SnY2UExCUnZMcTU2emp3?=
 =?utf-8?B?a216azFoWGs5cGsyelMyUW1idjYxTEdsbGdUQzRDWElFOFdGOFhiQUFkTmp5?=
 =?utf-8?B?YmM1VXZSandSR1JEeEVRSG56c0tqcHhJYlpmRmNEbDVnMm8zZEpsanI4VFNz?=
 =?utf-8?B?UVV1TnJiaVdhbExDOHVaaUx2eDZSQkVzYngySnRqNU51ZXdzQk9uNnhvNVcw?=
 =?utf-8?B?OGNJSDgwZU9JY01Qa3dJZUp0ZkNxWm5PVktrM1J3d212MVBHSHBuTTFtamYw?=
 =?utf-8?B?bnliRzBiRG9YMGdMeWFhTnVWTys0NzJSMFlTOE5MKzFXU1NsdTl3Z2xNbGNx?=
 =?utf-8?B?YWg5dmJXS05jTXlFRU0zREdGQUtRWWVKSHgrSkVLbEk1aFMrWU5BVUFxUW1x?=
 =?utf-8?B?ZVZwQVovMUl6dGVaeFFtSjNRa2FUYUIwTXNuQVBIY0o2UHhhT3REVHNlZ1dr?=
 =?utf-8?B?YTRUaEI3K3NablNWK3RiVnFYcU54aUx5OTIzY0VPTkcvZzVWNERaL1dMMnZa?=
 =?utf-8?B?c0g5U3ZHOVR0ODh2SUtHOUd6eG5qcVU2cTZGRlNRdVQ2aWcyZDZ5bVNrSzVY?=
 =?utf-8?B?R0JWQU4walhJUjVadEtVV1pLeEt5WjdiRmhuS3pOZU1RMUVJS3M3TDFKdGl2?=
 =?utf-8?B?K0V6L0tESVpUVjlqdkJPdlJDOWtVU0huNDdST2p5c0VTVEhKa2o3TmtHSmRk?=
 =?utf-8?B?aEg3Ykhkb2lXeHNjeVNkaFlRN2h6YzllOXZicGh0OTBTSVNyRit5aW1nMW1o?=
 =?utf-8?B?WXlaemZxY3BFNU1CcER6RWdoeDlEWGxXMWtJM0JIV2xyVnFIbmRjN3EvRHZq?=
 =?utf-8?B?VUE5MVhrZWdKMDBQY1AxWU5jTUZVWFB6WDBoKzZWRmMzWWpvY2pvMWZiTmJx?=
 =?utf-8?B?VzZqSkVaK1JKeFRyYnNJQlREN0tsZGJ4Z3NpRFUyandMSzZMUkJieXNKNWx5?=
 =?utf-8?B?UzVzTm9XMW5hZTQ3dlp6SzRkMTZZT3VQOXBVajRvUTBGRTNtd1phbm5zR1Jm?=
 =?utf-8?Q?UMX91cqZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ab1249-d574-4282-b87d-08d8c9216ec1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 15:27:50.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCoaCzXugwLFVtqF+NpU0cGuonIo+R03RtZ+gHFw9kA8UXiYWa5U9c1AiZVUPlrK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4233
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_08:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1011
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/21 8:49 PM, Chao Leng wrote:
> nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
> directly complete request in queue_rq.
> So add blk_mq_set_request_complete.

This is a bit iffy, but looks ok for the intended use case. We just have
to be careful NOT to add frivolous users of it...

-- 
Jens Axboe

