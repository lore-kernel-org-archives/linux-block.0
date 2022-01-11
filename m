Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06759C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 23:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiAKXif (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 18:38:35 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:27927
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234150AbiAKXi2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 18:38:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exZ9ed0FQxeaS0uXhqeV9leEWOrLBBxhXfDoCJLEO1S/C/vvMNNfm2FPWC2DfEbUmqtT6oTDfXARneezn2REw+pUJZC3sRVURadqSGhiNsHZmOj5sCCEQK/TWRxpl1jum8e/rhg5MFkLbX3Xv+r4KrrQ40KOr3gSF3AU2NP5seUiLIRhojG+tU2rD2cvn3dK9lY1rlA1VSumIlFQwylsHwKdXHmveH0Wloeif7H8SU8ooMh8YrF0s92JuZjHhYfhNADDriG9rI5d8jHy8WX7G2rnDIgthNOKI/nWliBReaXvQ5e900NTAQr063/tO2+Izr4IwxvmzxrDHT/7s+iJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xmG6HqabqOUGva5moO8riyy9BTJyHqbR2d/vxT7zs0=;
 b=jgI6Vd+r7yCQln1L/ebaIH04RRJNi06uha8/53yJRZ55OzKMjxL2Jz9RFmOrOPb2ZeibcNjvReloxSR1undp7wthFc1CkuaLgdo4wVDAxGLifYC4Ft1X9+Zk2IAbWyC5jHoYj5vAQ2UOqb1HJ2YZ2hUOs+VgyGLyxlfkVsGnugmlCPyqDKU1aT/L3zKgpkMEbjVTxlE8M8Bfg1YaKMOhRNwqVZvqTCNnyY/ReKMgPvqA6FxaXqd+8qkTTG1sdqsuhDwLyvB5QjaJus6JKNIAhr4iL+0jvfyoMIK9UHZLB3lODiqLMH7FKJ2sL0TlBrZx6qbXvcj1R3dDMtzFp7hUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xmG6HqabqOUGva5moO8riyy9BTJyHqbR2d/vxT7zs0=;
 b=XCtaYBAkgjYiP01hgc3nPEVjKaMGeVUCclZ1qn1oHaKyvddqNVMBvkMnltWHISqFYNoeUPDUWimFgZAbJE+whUPRgY63sSt/8MSah+cx0PE4X1u4s5ISLFbGa1Rr4pSjdwM9/Iyht3MoxbmaCP5qXQlEuw6QmZK6XAwvugYS9fSXHvxwsuteHcTeLcEEfFyeP9TvP49VcUJ9bg7CLgwhvJ0DPScmFOViRB1spimNBqYgPBACTNrG/XDa01GUK6pzjlsPjlfXdflaQHSkS77Mii2Yk7wAz15fNfatPKlXMCrOm0E29Rvu84+GDlRzTEt2eewcHPTCNJxq7JtrQzBc4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR1201MB0181.namprd12.prod.outlook.com (2603:10b6:910:1f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 23:38:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%5]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 23:38:26 +0000
Message-ID: <7094dbd6-de0c-9909-e657-e358e14dc6c3@nvidia.com>
Date:   Tue, 11 Jan 2022 15:38:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com> <Yd3SUXVy7MbyBzFw@google.com>
 <e75c8f37-782f-f4d4-b197-8fda18090b42@nvidia.com>
 <Yd3mfROPwP72QPt3@google.com> <Yd3m55+d2edO2I4p@google.com>
 <Yd39019io71DHbVq@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yd39019io71DHbVq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::26) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47efdf0a-30a2-426e-ba17-08d9d55b7713
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0181267A5DEC8D64F294DD5FA8519@CY4PR1201MB0181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJplBmRcQDfVWx6v78MaK3IIiMT3ZqEG5wtb+wmBgMjfJoJiQBR6pDcs2wSdhiogj+lqwxDGx2CBTS5trTenb/bDZKfCR0saYym/Q+dq3RSsynt4y8viTsyH6yzJySF3IUb3E0ahqO3L1xHYavhFFlbLU6N9/2x9U+ZhSWop4Ilw+KrPl9Vb2YnqPCtyE+LkXpEshPGWvSMV+vN1Bu9m76HcB/EkdexmuzuJkCkjt5DvOshXDLDmtug/7WNmCI20Sa38N7+Z0ficeSXnusl6bhMLCzkniMsiC5+6cV5QdiU5o52UAnT1iKFMKiIFNWmu33KrKMQgd+CWBB6E2jJHOmYyEleiFHDQjuFFXU70VK575wfOSQxc6FUKO3IX0VMWoF5rFAVmwLUpxX9E/rvYadBh69b1vCrv4Yii6DARPqx15SSBbwdNOQRDXYKx5LU7fHiZ8Hb6XWWDpQ8dvE+0R/xwsUI67yblclsyOJCe2tliE7xrapjqx7SDxmYvuZi4cDFWnmgLheSTP6zcch3fyOgDVpC3nuPsJfU4iJcKZVZrzvBMpw8aGLNEJnQgz2wawsYPxbEf9BnX/SDBbc9DbAnFBVC2/EwpsI9IpUHPwrYua0yJ1rUr8+pQ2iMFc0mLmfvpuPtsFZuCsEZqGbEqvo1FLeiXrJpkSFTMBpt3xEJ4q7UDYtu2PZFwdM7hrJMI+M4NM4eY22lSQR5C6C3AG1CyE5Gq4wYPof071uY5dwsi3gyOSNeVhz/ghk2RRltM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(2616005)(6916009)(186003)(2906002)(53546011)(8936002)(6486002)(5660300002)(66946007)(38100700002)(8676002)(66476007)(26005)(31696002)(54906003)(36756003)(66556008)(316002)(86362001)(508600001)(31686004)(4326008)(83380400001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE9ZYzRJYkdlcEd2U0VnUXVYWTBuSEIyRTk1OHBtQjRhQzl4OWUwUnd1MURQ?=
 =?utf-8?B?MEpIOE9QYW1TT1prNmtsZjQ0eTNYWENuWjhhOGU3YnhkYUs1bWkrRUd3RUV6?=
 =?utf-8?B?ZTJWcVB3dktUL2hRNlBkL04yb0kyK2YrWGl5Tm5aTFZUWWgwcWtFdFRrSDM1?=
 =?utf-8?B?c2RCQzBMVTdkU3pTTjIxbTdxSTN0K1ZnazAwd1NzUXhqQjRsRU9HVmM4bUdo?=
 =?utf-8?B?dkEycVQyNmlWRHorbmF0ajc4bjVJZnZteGlnWlArR1dxakUvS1B0WHA3SHE2?=
 =?utf-8?B?OWUzRG1Xb0RXZStkdEZRc1YrTXYvaGdBZEhXZVNkaFgyVThMRmtrK05tR3Br?=
 =?utf-8?B?YWxPL0FoQ2MwZkNRY3Y2b2xWT0pUdjFnVGVXdVRsMFltUVlyVHY4ZXNqVUto?=
 =?utf-8?B?ZUdqYnQ2TUJycmRyd2ZUUStMY3haejMvME8yVE0zZXQrcmo0Um0vcURDRC9s?=
 =?utf-8?B?SVJLK08wYTBHQk52NktBR05HUU9SdnJVS1VLcGpSN0xsSllpQlpoaFN0bXdm?=
 =?utf-8?B?cm1hY3RDUVNxOTZ6VDV3dXIyQSswWWdQRm1Pby9IS3dzWlc5YnVaZXZNVHFO?=
 =?utf-8?B?eGYxWTlrcjRoK1QvMlpjbTBZa0FQZm5ZM1N5UjBvV3RjVW5XSGxBRmtZaldE?=
 =?utf-8?B?Y0laUG1RbC8rSVhUZTRPWldaa0FjTVlVYllzSG15amxzNW1HUHJEYzQ4NEk0?=
 =?utf-8?B?bFRZYmdhVEYyVGpEMXBPTktScEJXODVVOFJ4bE9EK1hPUUJvNm40K0Y4VGNJ?=
 =?utf-8?B?M1lkNUZPZ3d4dlkxRjVGdFMraE5BUUFOaSt0Q3Z0aE1NNUJWVXBaT3FnbXdy?=
 =?utf-8?B?RklUbUhNWU50V0l5WkFGQ21YSlZSelh2VW1mMElraXRJNEVHL2hYN1dhaDlz?=
 =?utf-8?B?Nmo5S0dPajZLSmxqT2JuZVROZEJHckhnT1JyZmtjRDBUODZMbjExTmVWUHpG?=
 =?utf-8?B?OVlmdWVUUG1Fa1p2bm9mUy8vQ1dsNmh2MEdrNU95aGdFYXJ6Ry9YZG4yU2RL?=
 =?utf-8?B?bGhvcjhRbDJPV3Nta2pVSHVwSmY1WHVreS9TalJ1ZVZIRnZxdUpaYnFpVUd2?=
 =?utf-8?B?WVZaZk5tMU0wT2dabGo5NGtTZnZpOGJCbi82RkthZnlwSzNrdmp1YjJDcUhG?=
 =?utf-8?B?dEo0eGhQcmpHSUVqQjFuRkVSazZlandTRFBscFNTbUU5UDR3cUs1QzFkazR5?=
 =?utf-8?B?Zm1nVzJRYnB0SHo1TWJxb1Y0T2lBQ0ZLUVB3Z1AySFZlclFtNjBtNkt6Wk93?=
 =?utf-8?B?V1FxemFGNmRmbG5yQ0lzd3g2VW9CU3pjWEdyR01SMGErZmlkc3F4QncyME1W?=
 =?utf-8?B?amJhRHE3MFFYL3RHN216Y1ZRYitnSmpXd3hHSm45QnpOYzk4b3lLYWdzUDJ5?=
 =?utf-8?B?SG1SSk53bGFkVkEzcEJydWxNM3pmMFBjcXNDL1R3QW53U1VQT0E1RTh6S3I2?=
 =?utf-8?B?UVNJbXNYQ2VzWkRGVEdId1lWMHdaODBwMThvTWZNZjlCeHRFa1dSRzQzUnZ1?=
 =?utf-8?B?K1pvWnY2UGsvY3UwdmZ2aVJDdDdsalUyejU3bzRLalFPUkJRVVlySFhhamVC?=
 =?utf-8?B?Rkhqdjg1VHNZMXU2VTE3d0QrNUt4N25DYVpnb3o0UkVXUyttT2NpMlA2Rld3?=
 =?utf-8?B?VjBYazJWM3VZRHljVkZUcUFsNkZnYlBlcllKcm1qZmV3MHJ3cGw5S0NrTmtX?=
 =?utf-8?B?RlhJWWlpWEEybUcxMVIrV2F4ejhsYUc5eG1kL2xWdjZmdUxRbWEzL3ZpaGxG?=
 =?utf-8?B?Z3EycWgvcEFRUXF1TVkvV1kvNW1TaVhhcmkzc3hDL1J3K1o3RVNsTFl5RnB2?=
 =?utf-8?B?V1RVaUNhUzBVeld0a01TNER0R3JzTTBrcWhvL1FCT0cwVVlQbTErUjV4THNj?=
 =?utf-8?B?dXQzTWE2a0Y3MzJLRXEyaEFOalFnMmVQR3lFZTB2VTVUcDVobXgySkVmcjdw?=
 =?utf-8?B?eld4bG9FNjZkUklFajRGb2dRejY1YjFDN0dWbjU3VWdJWDAvSWM5ODhTV2ZH?=
 =?utf-8?B?RHMzUzdubWNIZVJtcjF6UzRtczVPOVFIWmZOVGRhMXFBVFJWcHFRU0VhaGRq?=
 =?utf-8?B?cmpVdUs2WkExTU42MlVtNUFQcjZyeXNKMUVnaXZLdlN6ZXEzWW5OMFlSVXA0?=
 =?utf-8?B?MXhFYjNCRUxwTk43UDhlNzNneDRTdDlTUGpHaFI1WFdFY0U0cTI0Z1A1Q3VO?=
 =?utf-8?Q?vLsFbylRuBbKwydmcalY3D4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47efdf0a-30a2-426e-ba17-08d9d55b7713
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 23:38:26.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF4VrMBvcIrm0V4+UbmMXGhFUKQJHHvJ4chlNl3zojQPQwss+RKVMKj2DHT7PVU6NtI2bPa1MnE90Y7wyXDhoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0181
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/22 13:59, Minchan Kim wrote:
...
>>>> Marking pages dirty after pinning them is a pre-existing area of
>>>> problems. See the long-running LWN articles about get_user_pages() [1].
>>>
>>> Oh, Do you mean marking page dirty in DIO path is already problems?
>>
>>                    ^ marking page dirty too late in DIO path
>>
>> Typo fix.
> 
> I looked though the articles but couldn't find dots to connetct
> issues with this MADV_FREE issue. However, man page shows a clue

The area covered in those articles is about the fact that file system
and block are not safely interacting with pinned memory. Even today.
So I'm trying to make sure you're aware of that before you go too far
in that direction.

> why it's fine.
> 
> ```
>         O_DIRECT  I/Os should never be run concurrently with the fork(2) system call, if the memory buffer is a private map‐
>         ping (i.e., any mapping created with the mmap(2) MAP_PRIVATE flag; this includes memory allocated on  the  heap  and
>         statically  allocated  buffers).  Any such I/Os, whether submitted via an asynchronous I/O interface or from another
>         thread in the process, should be completed before fork(2) is called.  Failure to do so can result in data corruption
>         and  undefined  behavior  in parent and child processes.
> 
> ```
> 
> I think it would make the copy_present_pte's page_dup_rmap safe.

I'd have to see this in patch form, because I'm not quite able to visualize it yet.

thanks,
-- 
John Hubbard
NVIDIA
