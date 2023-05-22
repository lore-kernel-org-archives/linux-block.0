Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABAEC7EE26
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 09:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjEVJrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjEVJrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 05:47:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72027B4
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 02:47:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8ETMu023116;
        Mon, 22 May 2023 09:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HkQ74p9amVzhmN1feeOT45QB4dSKpiLwRkOcwN3dYco=;
 b=JY8Xx0zfBayM6AB8Nfr65r/SrJY9M4HHKq6rjtMDsczzp+fV87gdVissmiy4Wwo/OexK
 etwJeGrByvOJ0vtaCp8DtT0ibZ8j3b2CfQJtfCTsJH1rDSg5K+M/WdIMh2USsmcnpBEy
 AVBrcjAjHwctVGMPC9VOTsGDEQA8V2hvunFkzYRFzGp5SKW+WsRlVeRUovfhBfoS/QvE
 5d1c5OGlK2eBWa/Yk9AHJKHFEg7Hf9Mv2dbb6L8nywP5Qf+sXu24ZDkVU4uXKKHn5RQg
 IiHVPKVNwTV50oRdsnLwxmpuWc68JG5HVl1EESEunpU95kWyJeJR2lVxvxcSWJxPYZci yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3mja7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 09:46:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8VVm2029093;
        Mon, 22 May 2023 09:46:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk297hnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 09:46:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcPEADhcjAW1eZCpwdRWDY+ZeX8URDxrFU5Hnfz8omW7nmmWjyKhsHJ+xyi1vZeXCAbdq3iBhtYxas/BME9puvC17XyEjmKiPQGmjENpvO7uJS1anybUFFHEwdqo/hpgNsZr8yC+snRLQA3l3i3uVs5QdZ7S/hMqoA+hbP5MPKOKwnH8D0295Lm9dYflqAapOnxKjee1k3/vh6c2W7wsxiF8yuYSN8Ji2R5gbMIZD0C/vdjqeAT+HqILHDMf0K33CCbyhmOpnooKPUIAnDr1x9pHHIHlKRO8r8qsDsIOooTgvmomu4l92x3vVl0gXpR/HvakFHfcFpelbBNVyeeQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkQ74p9amVzhmN1feeOT45QB4dSKpiLwRkOcwN3dYco=;
 b=B2bNsbVOF5vs3TIu0hlrEUnkFFm8R12LBV4YKTb3rOIAn0uhGL1ppiIIZ3gSatZmmZvJcsSo9VH7jNJB14aRZCkCT0d0NjFvwBV43pRuwdx/VeY0i1HPtdHNcVbBYp1oT8zX+IbswnNlBAWRD3irv03Xrp07JYUT1lIQRmKJtExASms2IKDG9r1Qi2QucZaIWdG3CHXrKJrlG8eygcGGWQAft8F6SbE6ej18dH93Fzmj7X0JTAcNFRQgHe0dj1KxA8gVPyqXOvHXEBAwRFBzqAJ+D6URrP1JuhoZCsbVnXY1ayjPc0c0liC6m8knzkjOMg859nch8wfzQOWZf/5fNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkQ74p9amVzhmN1feeOT45QB4dSKpiLwRkOcwN3dYco=;
 b=xcDbi0CRcz5Bv56JcmOwBSlIuW6+jReOf8FB3xm9QXKGehM7ezc2IeBGQr3MTYdC/MjR7yQoHkimSwc70rrIZv0K9YMbrGWn6pSxznxrn3GFx5UB7/Xg+7Un38NGi5r/0u6c7dJ5oxbPgnKPzX7u3pb5LM14UfhSLLgpIVqeWhM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5950.namprd10.prod.outlook.com (2603:10b6:8:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:46:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:46:51 +0000
Message-ID: <a11faa27-965e-3109-15e2-33f015262426@oracle.com>
Date:   Mon, 22 May 2023 10:46:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
To:     Tian Lan <tilan7663@gmail.com>, ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, tian.lan@twosigma.com
References: <CAFj5m9LfZ=CATGUz-KFE3YFd04XV2Zmu7kPMdbbyXLg-KnsPeg@mail.gmail.com>
 <20230522021214.783024-1-tilan7663@gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230522021214.783024-1-tilan7663@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: df774b75-87d6-45c2-c3e1-08db5aa97840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B55xBkvnzuiIVsSlQhVe1uNNJU1XLUd0tGtLFjk/WPNlrQc8Mep7GoOoqP1RjxV0pKQt1PVW135c90pRTnAKvrAaUkyXSWn29ekPemTEpV6jeAYBtaA7wHCUuLMmxqP1pP5EUitjOsUBu2KR3ybiaYMnoarOupOcWl8+8+Nrn0pf8N6qZsB+3/5MlqSnhurbhrI4SKD6hHw9DMX1sgZtKWavlbBUHjVNo2dCJP0EVydvC0JPYLmSb0FqZiMC7O7f+Dla+F9/Z27bjSELtqSU2PX6SXSmpO7UvXv9JyK+/4HPtl2BCxLkOJOCxyOsFTzSQXWopIDazrHeWwy5sj97grYFsWsTHwUfOTYh7KfbInGheItw3iXMiKQfPXM1TRtvzyd1QmQGXIg5+j8VsGAgv8RB50mg1WHD/PhTQcXDEuGob0fTzgB7EbgTAc7XCOim2leLPbGEk3BsgyT1ZfVKBRD7WFhUC9jHm5Jz5T28dnALHiHIelA148MFCbZNI9dcP0kLyHDo6kl7meSqaBsoFgP5nQXem+dZFclel4Dt/sKrTy6C6T/YNfrVBqfIzAnvXNKj+EYIZPleKe/mhwlNz6M+QJb+ganz3aQvLYpIOCUCtaUootAluPTo9blwVP14Mw3jAn2UZi0lwrzdY4MwZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(6666004)(31686004)(86362001)(966005)(316002)(478600001)(36916002)(41300700001)(6486002)(66946007)(4326008)(66556008)(66476007)(38100700002)(8676002)(8936002)(5660300002)(83380400001)(2616005)(36756003)(31696002)(53546011)(26005)(2906002)(186003)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2NaQXJGeDNVd1ZOblJEdkxwUjRkazVCaEJSazBqZEszU0hEdVNVaUsyMU05?=
 =?utf-8?B?ZHg3V1JTT2c1Y2Z3bEZhWmVzVno2MzNzVlVpWXNaTWZpd2lzcGhuU0RPZC9i?=
 =?utf-8?B?emtiSVlpdUNxVTBJV0toUnZleVJNVUpFYzdHN2F4U1lqT2VXbHNmZUx6TkMz?=
 =?utf-8?B?cjVJbjd3bXlnQ1hGTVZBcEFOKzJERXFnSFpUZDIzcHZHcTJ3NDk2ZXIyZXRT?=
 =?utf-8?B?djI0YzZFaTlieU53eWF1MlhYRFRLcEhjV2RCZWQ5cDkzeSsyc213RktFZVFh?=
 =?utf-8?B?UGlobEJrTGxBMW1janh0bFVQbGpLUkdNVzN6MzB6SkhwUmhteCtuMDVwODJB?=
 =?utf-8?B?RnEyeFEyUk1pNWszUDVNUytEYjV6MDE3NGZtdzNhNkNUVmx2d0hYRUtabStK?=
 =?utf-8?B?eTBKRmNOVHRocWs4akFvalBQM2svbittWkVvSzJlZkZNR3R6YkJ1NEZJN1Zn?=
 =?utf-8?B?WTZhNktlZUtMYVY2VE1DN21HTkxjMmQweElFZ3NyWkR5L2xmT1p2NVhubzNT?=
 =?utf-8?B?czQrdjlZMVBuaUMxMHc5b0RNRURDbTdKZGZTaUNCUHp5NFRwaUduYVd0YnBt?=
 =?utf-8?B?Nk5mdlFNSTNVVjloRzdadWM4ZzMvRzdtWE1MU1RlWWw2ZktrUloyYnBINUdL?=
 =?utf-8?B?RmFaYWw0eWVMY2oxUGI3VEFqKy9tYVJrWU9tYUxIWlNkWUU0M1FDVWN2K0pV?=
 =?utf-8?B?ciswOXU3YjBIL2wwLzdsT2V6cnM0S01BQjhmTzJPa1RxVVcxNkZGbG4zUkJo?=
 =?utf-8?B?RUpZODVUa2loYjhvbFVRWlRWSCswSDZ6VXphNFpINkhqNndZbFgwMjZpVi9N?=
 =?utf-8?B?SVg0WlFBZ0JhNDJqaGwyajNGZ3F1bkFrWmFpR1pldVEzeHZVTXlkWEtVSHF5?=
 =?utf-8?B?NnZIQ09mTEowMlJPT3FVSjhiaHVnMXdwTm5YTTF3UVNXcDBkUDNmaUJoY0ts?=
 =?utf-8?B?S0VmWGJVMlV4eVR6dGs4YnVTVXpoR2k0d2cwMTc5KzBLempqVjI2NjJDM2x2?=
 =?utf-8?B?b1QwTGgwTXEvRGJQRFZqdFJ2azZOdVNjRW1zb0dQcHZoRFZhcEYyVFdoUW8y?=
 =?utf-8?B?N3hYWGZYSmhRZlhhVHJQVDZ0ZlVGTVdaSU9mZ0VyRXkzYkNhQzN1WHFiaVZ6?=
 =?utf-8?B?d1B3VE95ellGYjVtZldCR2FFOXM5RTNnZ0pmQUhQRlNOemJTSktvL0JvNGt2?=
 =?utf-8?B?SXZEUzUvUmZWK2RCK2ltQWY2ZXBBbmpBbW13UitpVHgvem1vMkZiWEJCWEo5?=
 =?utf-8?B?YjREaEg3N0g3bWVkb3BydjNWay9uWVJPTWNGNVNMbWxzS29JTEoxaytyaXdC?=
 =?utf-8?B?VEpNaHZsQTIxbFo2Lzg4Qmx5RWg5Q2Vvb1VhU2p4a21DQjFQeVJwdFdSL3RO?=
 =?utf-8?B?a0ZiaWY4TW02c3o2S0t6WTFOYXJ5WjhIaEQzeDErN2Z4UFQ2WEgxTk9ReUJ6?=
 =?utf-8?B?K1czcTBhUUUvYjlKaUE0TkM3ck5DSWhGNXJMOHRyVTlJQk5qcW9qN3hPQnFV?=
 =?utf-8?B?MG1yRlE4U21HQkVjWkcyalhHck5tWkc4ZFNDbkNtWkJLdEIxWGhPM2JEOTFE?=
 =?utf-8?B?SzMxTVk2N3dOVmdNaXJEcW1zKzhPakg3bzJDU29ZeVE3eURnWWVsUEFnNGJY?=
 =?utf-8?B?RHlVMUsxL3lhNmlPK05Vd0R6a21oRHpLTjh6cXQ2cXlnVDJZUGNJa2pCRnZN?=
 =?utf-8?B?Tkc1UHQ3cFkwYUx0dXJFVHFXN2txREN2WW5ISzU2dHlNRGVZK1cvemgvSDBO?=
 =?utf-8?B?UWluanZnbm9xVklMbWoxZzV0eXN1WUJnSEZpWXZSNHZNOWpJMHMzdHlaN0lt?=
 =?utf-8?B?azlldnkzTkRacm0rV3ZRaVdoUlZSUDREVk5WY2ErQmUxUG5oT0ZBU05WY1h0?=
 =?utf-8?B?ZmJlRFcwV3Jvd3pvOUpNK2hUNlkwUUxveU5zTjRZc3ZzbUM0UVpLZzBXeTRw?=
 =?utf-8?B?aTF2dndvZllGVXdDZ254ZUtUNmRla05NSC9Qb3pvbHR4Z2ZBaW5BRTF6UWRT?=
 =?utf-8?B?Zkg0UUlwaWg0UWRycm9FU0ZMNmpQQkNaeEswdWlOUGFxRFA0WEtQSjJmSXVl?=
 =?utf-8?B?VVFYalBEaWhWcXZBWjhkRmN4K1kyUTcrVkkzRXdGdHJSYlJkRVhFamJyOXZx?=
 =?utf-8?Q?XRO3oKdCO2ifUNkE7XtpGNTnk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GWvkHSA36XdVQkqiCtKmwO5BXI6ThK5qLbWpP6pgAQMcBjEeOyVQGlUMftYW0cRNn/EHtpD7gBI54Tuv8oFZjzbp1MxqZUjN70B9WCuQWBoMC9gteNLtPqF1cJKDQxLGdvHTUbSLZnXE/panNvlNhJfx2jyTFiTf2wqsvprLozbZ5WiK7fx+Plnj41BuO+iUEaNcSLOAXSN0Nfeg2q1wBePLmRtOqnlmFImsqh6TYj8DUwunVRGWp9n9ySCYOwoadP97QZ5gJqCnZFCJrKJLrifOJA0UlIwaUM+q0IGUxS1DNw8Bm5dqrenM4oI2Efx3R64sReXQawPyeKgnDxhdCG8+Q/KW1T7LH/LuywDdQMJ0kh15RjQLGJSXwIcwDVgqC6hVO35mzjVBg45qi46sAQoVwRipRdBH7OC8jkfzXfJPowJn8Xrrw+DzLWnQ+vtIgL4VWHZsHqn5ynhNhFlWqK5ty7MOWI5wKCXARXrKVPqk18EGLrXfC+KJE4EeOa+utHob3+dhMeguXnrj8vJ6+g6crh/33E1VULD+Svdr4RHnK913o3weIDjaC2kudwjbNJaaHH6JgH+hYk7A1syn4CB5gVdMH8D7r0U4tqvB2rGhIqrCoYRQjHWK1rOTEEwDAKvRNbbYcv7wUEfgPwCO6Vaz/6J7p7Hr3pRqEgZGEc7zbAloEanNU1dzyC6YHfXhMFGzyluzkNy0e//i19bk6l/IJoWQJtIwRjQf/Bu4gY1r28iWZby7TzsT9VpyllKwXWioSsOmMrn4U4rKoAPapk0w/LhzKiqMMjfQ7N6R/2+U9xJTo3i4ypZSXoIa6f05yoilaTHgGzP2nukchMnxcQZGzdkCI72C+iV0SUZW51hhu1z1LAfIFHxHVx7T3dITdFqbnkIHkrg7KNM081E4GfY50Q1fqCDn1F4e0sS6iJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df774b75-87d6-45c2-c3e1-08db5aa97840
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:46:51.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkI44Zi3KBjwwEvx7s+u7Vb0KcB1oDaR+Ou/eqlbs4yJGsb0VoqaHVwCLn3If1UeCIuahV8SsMyOnJ8A2sRJsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220082
X-Proofpoint-ORIG-GUID: eoH3rGDDFT4P8eE2rMbXTb0YfRO7ZoLb
X-Proofpoint-GUID: eoH3rGDDFT4P8eE2rMbXTb0YfRO7ZoLb
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/05/2023 03:12, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> If multiple CPUs are sharing the same hardware queue, it can
> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
> is executed simultaneously.
> 
> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d6af9d431dc6..0db6c31d3f4a 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -42,13 +42,13 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>   	if (blk_mq_is_shared_tags(hctx->flags)) {
>   		struct request_queue *q = hctx->queue;
>   
> -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))


How about add a small comment why we have the test_bit()? It seems to be 
asked every so often, like: 
https://lore.kernel.org/linux-block/6e2db454-b2f7-16a1-acc6-999ee09fdf10@suse.de/#t

>   			return;
> -		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
>   	} else {
> -		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
> +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>   			return;
> -		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
>   	}
>   
>   	users = atomic_inc_return(&hctx->tags->active_queues);

