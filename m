Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F2C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 17:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDLRuL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDLRuK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 13:50:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31BDE69
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 10:50:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CHE2F2023904;
        Wed, 12 Apr 2023 17:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lO7OZCfd8eLi/DVsjsFp4818jNLQYeFNicG2jnMO3Is=;
 b=WQ0QYSTQFlqMxbKQlIaOOpGjDaM/iO8eHz1iWobUaPJbrPWRJA5Ndi+F/t2j4x6Z/pLI
 7jaRjPx231s5ffDni2gA/6x4hiA0o9BwTNmnaxlODKoGgzRb3rI8cT1oaVDIYFow3q7B
 HS8G74VvAvLYgKADnyU80j127UrmrRilXjt5+/Hr7+LuNgAafLwWQgkFzE39Xk4/Bt4y
 1byKc8eo2id5cvPOOy5fpvgdu7GlAdl+vc28i3LxYBDgG+hkSPIhWj2I3U+pQ6S+GoVH
 Vez7KqIMZ/01e4Ms1aztw1ACwvRNcQEGc2tMWq1CqzIYQWZ0KkBMlQkvROH8aeypgxXb Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bw0ynf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 17:50:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CH8NOe025058;
        Wed, 12 Apr 2023 17:50:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdr6ejk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 17:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BApZJUbxLDM+4iAWkTdmGqT28Tl4LrrsFY4IbBkqkQpAYFWXhlH0xum7va/yuxV26UE622STAGpTI4k9mDOrxMkfBXyYI1P0d2cAgYgnw9oJCq0TJaUu+BWLS9sqvJyr9lipz7mjbHhm+IrRlaVabwjcUmqo5U/LlGXo6bOaosqvwMYiiI5Oygahw+mTaRdqshAoyGA8/F617qDb+K31KZ4dXNgEeRTwa2OeydQcBx/1KmuOGo2mtTT8gc30FCvaTtJqTLTCAy8l6ljJSo7R5CZ+wXahJaXNx0j5ViqSn97Ssw2rLj3zi/2YmP10rkprITowhlPB+t1mFbIeh9uqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO7OZCfd8eLi/DVsjsFp4818jNLQYeFNicG2jnMO3Is=;
 b=JUPEN1PIN2ka7n5Ca1x1mBxiOpqUQr5d1S3er1+1Gqs9jnXmhoMdRi/Z0QNaqzAhK2+8+vqNY+SeGdLaxJzsnZo2auQJam6zLKQk6JKjFv/En+HEfXCQdOceKMZanP+ETQPFxj2YlW4dz9i5srJFsJFxrr6LKXdiXKDVri2EnMSuE0kmm80b6aHmplxLDHQL4eGSjzcPyjdPD9HKJaiIvHfnArPN7owMmwEYqNF6+7e40KeegbFT4omEpATSmlA9cP0PceoVFbEx9mZP8HaTaBWXx0Te9frYPgmE6i8+bL61+YSAnj/XydUgNP4D9P3KAbrvR85deB0AseKJ+WcIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO7OZCfd8eLi/DVsjsFp4818jNLQYeFNicG2jnMO3Is=;
 b=NxTyLjOUOzB5r+b9gDcFXZK3mRiodvekkx1FINqsOCPUj+vA+8wLN9rOGXyHMvDspiVRPqNu7b8X8s39we1cRggAjAUapJADn63nqp58U8rRfvK4uF/wBO+aZMcz+SYVbu8bajY/0YxE4W0gskHSbHtsI0DahaSfPbEbVHTIDIg=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH0PR10MB5305.namprd10.prod.outlook.com (2603:10b6:610:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 17:49:58 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%6]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 17:49:58 +0000
Message-ID: <34019736-06eb-b5dd-b6a1-101907c38917@oracle.com>
Date:   Wed, 12 Apr 2023 10:49:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH blktests] nvme/039: avoid failure by error message rate
 limit
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230412085923.1616977-1-shinichiro@fastmail.com>
From:   alan.adamson@oracle.com
In-Reply-To: <20230412085923.1616977-1-shinichiro@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::15) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CH0PR10MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd29ced-9cd0-4c52-47a5-08db3b7e5509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnAWZBOQBqiGLokWViac6Qwlm+K5tO+PkYHUEa5PnZwMNM+Dc/HRq3av52MlvfE6qHrT1kG1hwf84Qu1Z6QGWIAEH46/HBdQhC3DoCyXe01mS2SXeN2yAUcG/eEd87OB3k7PM3omXytxz2NMSKnPhrYfK39kb11zahw/I1XRBzdH70a59wX9pWFsmfTvNwQVikyx1Nd/0+HkrpQWItytfUi3w09s/4u0XKP2VQQdKiAU26VtM5lp5uNTilzI82J17uicbN1w9BaoNZCalnT0R3Z8k8HrUGW8AndrPCfntWyXPUgYWARfWX/h9E6WVbPcqIj+mc22T7lJRRfCiLLOIfqkqdJmT4hAu3xOW7JV2MT9Q5TkL3dDYk/T3WEdOqAZyRBaSYC7CezrCGWlGe5R0YVC1BSB7ux+idmmiS/n4d2dh0GlMwyv6hoqOExZqKAUybJiqfqrM5qVStHCUuxGagPMwsYL1XXZadXvD/MpxI4Ce2ZpTnUkSe63lvt4AJJMcNeQHEoYkRpqT4QA1kj32uaSvC9GcC3o1dMddEq2GJ5mtAjMOjXPUx2h2lt80FTZClAnFR+3Mdc+C4Xsnqaf+54E3JdAP4UZS72cJiNdl/b3iNGXg0VznwMfQr3HtXy7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(31686004)(5660300002)(41300700001)(38100700002)(36756003)(15650500001)(2906002)(31696002)(86362001)(8676002)(316002)(4326008)(66556008)(8936002)(66946007)(66476007)(2616005)(83380400001)(478600001)(6506007)(6512007)(26005)(53546011)(9686003)(186003)(6486002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZEdDArZ0dGdWJNQnhPd0xETG5YNThFYTBVOGRPSnhKaHlGTFZlZC9MOWxo?=
 =?utf-8?B?bXlPalRGOGJUTm9RVlBnaHFCSTdSdE9PZjZFWkNvUG5zWHpkdUNxKy8vb04y?=
 =?utf-8?B?cXZkRkU2d2pjMmkzZTZwRS9YSVJTRkJKQWNGS0lLNkVpcXlCb1drWXFKWkF6?=
 =?utf-8?B?TDBJWG9QaE9ZT3RvSml1bzlNL3JTTVZWNDQ3SEVBMXZwTFZLUGttZGV0UTV3?=
 =?utf-8?B?em9KZEtnelBBRkdSQlFCdmJsRU12cXF4T3pCMDVsblJlKzRtVWJaM1BtdEFW?=
 =?utf-8?B?dmhOTTV0cVVRNTJLQ0FXNWhGaTZ1ZjVzWFVQUmZ6K240c0I2L3hTaS91THVR?=
 =?utf-8?B?K3EwdHFBZjRqencvS2pHdWxPSi9FbTNBQ3RRQnJoSXNaZkI5eHNGRzR3OFp0?=
 =?utf-8?B?Nm0vOEtUcjlQbXpVZnhKTnNKUGpXRnpYWE1SK1dyTzFYV0lCRWdXUGVqdzNK?=
 =?utf-8?B?M0lURjRDZWJ2V1hJRmRLek5yenA0eWhXTlZZeEJOZkw2ck1SYy9ldVhrbmVB?=
 =?utf-8?B?Q0YrWTZmT0JOZ0JBRmVJK2FMZWkwSVk4bGU5K0Q1U3ZmSDZNOG5jaGRmdUta?=
 =?utf-8?B?NTRKcS9CWU9vTmYvSmdlamt0VzJaVlVQZXRBSExLYVo3YStPczd6SkVPN3lL?=
 =?utf-8?B?NEd0VWt4d1UwSCs0V3p0dkpEYUdneEhiVVRuQUtsYU12NHRKTjlaSkNLLzNH?=
 =?utf-8?B?VkR3eGFwdHQ2RVJqTkVRYkpmSUY1Y3FMKzVnT1pwYk5CcFkzaVVBUkp0aS80?=
 =?utf-8?B?MVNLUUFsME82NXp2T0paTEgzak9OcGtPaGlySU5FYzBMbEhIZzJmaGc2bjhR?=
 =?utf-8?B?VEs3WUlrNmNuS2JZQU1hYTdJOC9GSDNFdWMwWUwxQzFmS2duU1czU1B6Znho?=
 =?utf-8?B?TWZoTEFkekNwTkduMm56dlNnZWJKZXpHR0Z2a0JrRlRlRnFWSmhTUENCQmlC?=
 =?utf-8?B?OW1GUWJ6MDlNRkwvcGZMeEwyZC9FTUU4Y2hmeVJBUkplK0MwMm1WblFjWTNE?=
 =?utf-8?B?ZnJZSWRxNFlZUGZ0RlJZNTJZNWdZdjBCVnFIMUZmSmJuZXBlaDJPdnZmb2dS?=
 =?utf-8?B?OHdlK3dwTWFZbkE0L0h0SnVwNS8renpzTzhNd2FlMlB4WGlLb1hhY3B5QWls?=
 =?utf-8?B?cUQ5b2lqenEvcVlrR1Ixb1hPUjRiMTdmTVFDUXp0aGJkaGtzR1p3MXZyamc4?=
 =?utf-8?B?bzRmNUhKaXBrWVNlckhWVzdkN2R6Z2lzRUo4Qnp2Q1I3dk9pVUVmZzU3enR0?=
 =?utf-8?B?dGFLRDY3YXM4Zng4b29XYXdZdTErVDdqNlg4NUdCQ29lSFU0NUh1cUttejZm?=
 =?utf-8?B?c1Q4QmZHVUhjM1NHVytlYm5jUFMxNnZLa1pJU2ROcXVOQUU0T2o1dDV1NWdK?=
 =?utf-8?B?RXVZSXB6Nk12eGxzRUsvUVF6QnFhNW9udGhPNENDWFdGNXNXc0E2b3Zqc0JM?=
 =?utf-8?B?QWE3MzRVVGlMYUJIc3BpMzdqU3N1VTQ4STlXb0JseEhOS0ZGeXU3ODdFQkVP?=
 =?utf-8?B?Z3dlQ2hZWmlrL2RrSjJVTmI0ajRGRElBVmNGd096SWZ3NVBMMmk2cUZtQWNk?=
 =?utf-8?B?eXRxbWZrU29zRU4vUFVOWmxNNEpyL3VvSUdzdlQ2em5GMEN1em1ueldWdzAv?=
 =?utf-8?B?QXA0UFhaVkF6U0NBaEh5ZnVlKzVtU1ZwQUtVZjV0dThYVEtEMXNwT3g0UXJZ?=
 =?utf-8?B?TFBHYmM5L2J3VVpIQ0hoRlNCTEZYakZhRmxkWjNSRHVsTDVUK0VIMGxhVjFU?=
 =?utf-8?B?MGFMbVh4Q0lEK1QxTHRIcFJZeHU4SXNOcXl0UG4wN3BZcytJNUZiSlF3UjFT?=
 =?utf-8?B?T0RwYTZKc29TWHZrMkd6eElsUkprdjFxZFgxaGczVHFCTStlMjR1RDJvdWZL?=
 =?utf-8?B?T3JxbnBhMkNkanUrV2VFMzJROWlXYS9ILzRvQVNESUhZcE8waTdtOXBHMkVp?=
 =?utf-8?B?NG12Q2N4VEsxWUlrR1pxVlNDV1ViR0RVUVVWQWdnOTZHOXZvWmRKQVUwNW95?=
 =?utf-8?B?RWdZZGp0MTRPTWlldUZHQ0Y0dUlqcit4QXVtV2RBeWNkUVZ6aW9zMWhWQ2ZP?=
 =?utf-8?B?NytBV1FsSzJmK2RmSUVkTGVuRzNXY0ltWUN6bVhKaC8wMGNNTmR2SkhnVSs2?=
 =?utf-8?Q?C1ZslAebG36sBMCb1MNj731X3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EtjzppDOBFcl28SoVpHQarjhmbWJrLacIcRbwnuKM+6MGOZFMeGeW//iCDBTpOwg++ZP+z3xS+pCzLDxi9VaE6TddtHmlmxxcg4INivkMUqbAowM2xBpzStB7seB125sBo8UVbT0GldRVzbPYlnsYJlxAGxms6Yh42qp2fwXue0Y2l8pH7cejFkBSeQ17QPdRH1+hZPF2YRErnDDmL2QLdSrXfSSU6z7d4SUv+30nFtzU1C9KspjoN31TgrrXw31NKGEeZuqUwI27TQ8uVK3lZmJKgjh2MKcvtYF6J89lasO+t3DonYY4RXlNP5Vnjcz2OvT9hd6pkw6huqVtgbKvfL3iCYE84czG252HkcUO27n5fzFl3PWUdiTkl8QmYQ0bcEPYYQz56m8hRVpfoAWackKEp5A0vF1qbkZUXls0aYmrJ0uuJ7wxovk/+tT3DU+YtaOWoDj98WfUi8yYco8j/sWr5TaNg1EcSL6e/LW4GVTmkKqWUb7fO971J9q0JwBJXs02VCy7+onF4Mk1suR3E2N7mWsvKbnqZXou8zffqWGjf29gEmqCGpkd+AhB/NfVjwUf1+GDo/fIqTkNQDZY+wfihEIfmwIcmyV/TKZnCebFQEgoA2PhxWRxuu/6a7oKRss7MCH9+s7ZAgzgZhPUw/Wankh+mJPjWnfTaRnJiBEPhSQSjmZgoCTbYLGYgzFmh8JrTB7JXMTzjoDu7hxX2wrgykLMgXRKzTHAijVmQOW2WLEMFZ+KIGT1NpRN7hJi+09n9Wz1C2VxvemYeUW3ki6D0n3MbroOnwPjn3vUvgwjwr6E+oCiYXmlO1tyM9Li/yJP3GqN8ZRAEXoJArcnfiYBRAMzdzWMbnOEJiZ51kNJ1PNQO5k6VI1cbh5aBNx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd29ced-9cd0-4c52-47a5-08db3b7e5509
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 17:49:58.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9yZu5n0l8tvXlbApz8cOlTjx9+tTA1A3zp4Ti6GnVPk7iEyKqsREGJKDB4Os0rZJnybg8bKIPocgE0BpmhoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=933 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120153
X-Proofpoint-GUID: -Ka0DifCcK0pxbzyoD8QKZO4lRdReIup
X-Proofpoint-ORIG-GUID: -Ka0DifCcK0pxbzyoD8QKZO4lRdReIup
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/12/23 1:59 AM, Shin'ichiro Kawasaki wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>
> The test case nvme/039 tests that expected error messages are printed
> for errors injected to the nvme driver. However, the test case fails by
> chance when previous test cases generate many error messages. In this
> case, the kernel function pr_err_ratelimited() may suppress the error
> messages that the test case expects. Also, it may print messages that
> the test case does not expect, such as "blk_print_req_error: xxxx
> callbacks suppressed".
>
> To avoid the failure, make two improvements for the test case. Firstly,
> wait DEFAULT_RATE_LIMIT seconds at the beginning of the test to ensure
> the expected error messages are not suppressed. Secondly, exclude the
> unexpected message for the error message check. Introduce a helper
> function last_dmesg() for the second improvement.

Why are we seeing the callback messages?  By the time the test starts 
generating errors (after a 5 sec delay) we should be able to log 10 
messages without any being suppressed.

Alan


