Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC3C433EF
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 07:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbiBDHDg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 02:03:36 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:10401
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236451AbiBDHDf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Feb 2022 02:03:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nczuMJAwHrdMMAST+HJ5+lFC9u1lAC4bcIFBJERl5XUHHKS1nt8MN3ZDd6/ImPNZgt0ZkVPnepozz5f40bDib4KwO7q99VnAC3kpwCTFcFYJj29QimkeSpCCjWxiMXAgt4/EwrhS+zEFaNXlNBuqQZQ43lHkPtjLH4FqcTxzitzgVYeX+rG1WHbo64gU3Yjibw+aiEudXciZWXYYAc+Y8Fhb6WFeHjpusdGbCs6lZs/BMYGOhvU3WEakvFefznvbub7y3bkNq/vws395MBGI8dl6rHIBdbRYe1ii+RflpkjxkxyTszgCGxs7Jn4A/FmUEFo3Lgb7mfAMmOubGAfYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY6uux2WwFvZ18uhhyJ3CkMc3TTzq1a0X6ReYixW+wg=;
 b=Tgwmm/xz0uzMScV+T01+HckkoN2/O4oqUqCLW198CHOFA0hm3Z2phWpzKKly/LaiQchehYANUHL2VegmCbZXlBUod7K24vuH/OnfbABsN9TdJfhnhzGyeiOJL5kNaIgUrW5/s7t53WOmWWsvs4KGayMt5mAQ4xbU6Dy6zRRCV/YcwwKgdEokwsTwEOUm5Ny3ZE0Edyb8EEmzKNw8Qt1Om90CDT/Y1A2BmRJqhgFqmRpqyKVjY8kMV7wlgP3pP02FG/69TxuX1+uwm8X+jikqVta5U9dBRXl986L8Ic4NijiUBgzTrCIb5wLzPTCzT8DwuVxoGS/smb/XP3RAdy6peA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY6uux2WwFvZ18uhhyJ3CkMc3TTzq1a0X6ReYixW+wg=;
 b=ebVYU7eV3hwKJICJLRw3rLCMR2EhnpiIhPF823/twdfHj3+eWIigCEcRHy/iH1/fkFYBu3Ln2BDXCmC1bMtHXTyBmxp4AUGgkXHcJfK2RlcGLYEaPAZw+XRnnJt3tnSfzRow6GSWR3Ee8znM8jRC9C+oTqNQUxE0TgEHQ9cjkUrhhZ/nFQ+3NBVAyOhH2Z65AGPMpA0pnwhF1jzumF5cTHUYML9k19GrMfGHdM1v89V607Eb0vKnZZIL73CcTRk5R3Pqmg6HDsPqGC6P2NywdtvWFWQexlUNSSv5bdhcl2SoyxPEngKXBRSNGqivYRDmOjTqAvYzrgHh7uGIQgB4rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN8PR12MB3137.namprd12.prod.outlook.com (2603:10b6:408:48::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 07:03:33 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 07:03:33 +0000
Message-ID: <aed15ae0-24f9-d733-a3a2-3f803a82b6c7@nvidia.com>
Date:   Thu, 3 Feb 2022 23:03:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux-MM <linux-mm@kvack.org>, linux-block@vger.kernel.org
References: <20220131230255.789059-1-mfo@canonical.com>
 <Yfrh9F67ligMDUB7@google.com>
 <CAO9xwp3DNioiVPJNH9w-eXLxfVmTx9jBpOgq9eatpTFJTTg50Q@mail.gmail.com>
 <Yfr9UkEtLSHL2qhZ@google.com>
 <CAO9xwp0U4u_XST3WARND0eQ5nyHFrKx+sLWVJLQpjYrkZJOBaw@mail.gmail.com>
 <CAOUHufbrQZQ=ZCmVFRGOFk6+Snuy4Z6YSDUb3qMsHwROXatz_w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAOUHufbrQZQ=ZCmVFRGOFk6+Snuy4Z6YSDUb3qMsHwROXatz_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8176ad3d-6b60-4c47-cdb8-08d9e7ac7511
X-MS-TrafficTypeDiagnostic: BN8PR12MB3137:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB313704023F79AA8A86229B42A8299@BN8PR12MB3137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeOhTOokhq7QXYEsyyePq3eZEEK2z+fbGlI26A7z4c8kj9FcVH4aa2LuYVBHtyJXMvnSOsaxy1jBppVRb1A7bx5BunCDf3ikq5xJdqIDH3Id3LMRFZBTRArE2+XtW822SmS1rory7bpMCqFGXWsG/9P9rNoj/PiurgI0eWCYG6OiXLJynhHPDMDPIXyaSUiwZ/zn21FZvElCVtxdAkXk4YkFHiEFU38T1dPiGgLRONJcguvlMY7+zwPloAkvsB7h1QPeaUoCtz+mh9Pa1QH+xAgOm8N9Hcz6MCxSWB9qoMAM10XTH6VRx1g5rg3cSfi2DZ7KP79r5THTSVzR2KMnKGTaiOtvjLh0XcIcFrQ6OOm3T3SsT4rEDA68l3pg5kGOkA6FyCvKrz1UQdibkj+CWVe5MrAY8sFJGGP0A9R5Fn/HUmx1w8GHfSiOvBoZNoAYlPfCP9dB7HmXRgGAYuKC2x71MpHmJ4YARUqpZUnoFa7BL5uDXHVfFdMo3qgFlf4y+9UujGiZ0H1wNPN9hkWnTyr8B5UPhfoQD9r3II58Zrmr0gXUnXesAdBHNpr+KkXOe4umLh3Qb32Y46i9rA91ahI4lhdjwMsyLPZZaZOgqjwUSbO7I45kRqRqONX72kQ5D0uF1jPG9j+WkGdkxMYo9esNXx7FA0L8Xi3Z00bslVkDftw/ewvwDPhoWX9R/5oQ7AnISd+AtbaIeBFgY7EXG1jdxcky6ntL2+Cx3Hzef5FZFPArF+IQWXH+Ev/ft0yX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(31696002)(6486002)(66946007)(6506007)(8936002)(4326008)(26005)(186003)(2616005)(2906002)(6512007)(8676002)(31686004)(53546011)(316002)(66556008)(110136005)(54906003)(508600001)(38100700002)(36756003)(5660300002)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVHbkYvbU5Mb045enlSOU5RMGNVZXM0bGM1N2t1Rm5IY3ZQRTU3QVloM2NQ?=
 =?utf-8?B?R0d3QTZ5YkMrdWdlc24rcHlpTTF2T1ZubllOZWdkcmRDZUM2TWVzMDlobmFj?=
 =?utf-8?B?K0NDRWFtTzZ0cWJkZHJoQUpUU3Vkb0tZMG81d0ZyVENLZUJ5VmprQzUxcHhh?=
 =?utf-8?B?TmZrbmpRcUxyL0VKdWVjZTd5TUNQZDNDM2xKMnQ1bXdSR2p3bTQyeHVTK1Nz?=
 =?utf-8?B?SVRFVFFQaENEY1lMNDl1dVJCbEM2bEZSNHA5Zmt1eFBvREgxbkZwNzdWOG5P?=
 =?utf-8?B?cTA4SXN3bmsxakZoTlo3MERZK2RFNXN2T0luendkVFhzTTk2UzFiV1ZwUXdT?=
 =?utf-8?B?ZUVtU0o0dXRjOU9yOENvL3k3aWtWZXozR2N5RzhnQjBZbVlERjVhZWhXU3dq?=
 =?utf-8?B?WTl1MzA3aTk0Q05sQ3drd1ZlVWh2NEFIUitLWDZYLy9qbTcxNlh5NGRpZXAr?=
 =?utf-8?B?OEpGaXo0TlR5UVZXbmdPbWFwZ0pJb3NFZ0NuZUZWNEYzNXYvbTNqNFBkbzdm?=
 =?utf-8?B?bTRLa2hnVUE3Wm1FNzVzOUs3SkI3eFk4THRjNThta1FFOEhQenZTVkdGTFVz?=
 =?utf-8?B?cXYwdEs4OFAxRlBHNGVuS21FTEVVcHBBT1E1eEQwQmhjNzlYQXVVZDRYUjBB?=
 =?utf-8?B?NEl3dGZHc2hqOG95QUJLdldlOGlVeWk5Y3h0ZnlLVkx6ZEN0R3lKYWI0VG5S?=
 =?utf-8?B?NXlBbkhhL3dMKzNBUkpTYzM4clEzYy9WMDNtczFMaWlJYmkyTlJ5aXRjNHhi?=
 =?utf-8?B?UFlRYm5BR3JpeHBDckJNamQ0V0V4b1RjcmFiZWR4REJNNmdla25XdzQvMk1y?=
 =?utf-8?B?SW1XWWltL3NUK2VLelk1clV5QXBJSkhQd0FvbHVXUFFFUnB2eDNkM2U5R01H?=
 =?utf-8?B?M1JXNVlKM3U4cFFPZXZ1elI3bmtRUnQwdlgzcExpeS8rK3hEc3lUZTQ2REQz?=
 =?utf-8?B?OUV5QnkxVUwvcGJFWHRUZldSZGkyNGU3Nkk2SXA5a1BDY3A1YTFhcWh5aHlI?=
 =?utf-8?B?bk1CdjQ1bTRoOVBYVDZxRkc5NitWdmVSRCtHZnZWRHozd2JZVklpWEo1Nm1q?=
 =?utf-8?B?Y2I1bUpMZXJzeElRTHc3bUdPL0NMUVpYQm11Um1uei9mZmF3ZHNoMElOSVd6?=
 =?utf-8?B?NGM0WG9ud3N3QnhBNUlVSURaTDRDaTJna2JINjdMSGpuZTU4UG96Q1Y2cjdK?=
 =?utf-8?B?SXByQk8rSnlIRW1WU3R5ZGNMVlQ4WVFVSHIzWXROdkVhNEppZjBVcmhkZnds?=
 =?utf-8?B?em1XK3NPcWkyOE5wenJVcWFoMzRCOGJoMVdhYVM1SHU1TmtYWFNubnY4REtN?=
 =?utf-8?B?bGR0dFlmQnBjdEQzOHE1REtVT1F2dHJONjFzUnlVR3V6VVJ5SENWQ0VtcFc2?=
 =?utf-8?B?M3RrdHNLUGovZGhCYld5UWJLaHM0R1pKQkdzeWdJYUpLYVNRTS9RdkJGb1F2?=
 =?utf-8?B?QnhnVE92QU9DbVB2S0FBblBPTU91Tm9oSW0xQ2JaNUJxaW1BSVhrcUdoeUU4?=
 =?utf-8?B?VjRLNGhPVVE3WWp3ajQ2M1grTDdjMnNkUmhuRENWMDRjeGx0dVFtOFpTSmxL?=
 =?utf-8?B?dWNsSmJ3eFJwMjF4M1p3Y3hSc1lhUnNSNlptSzQzVXMyTHdUVGJ0eGRjL2pN?=
 =?utf-8?B?b0F0T0oxeXUwQnNvTUhob2FMdGlVeXk3RlMvTVR6WVpzMEQweGQyczZoR3lT?=
 =?utf-8?B?OG5qTU5JdFFXZ2V6ejZENGdycjN0Q3crcmpzcndHb3VIY0FtN21MSlExWFJ6?=
 =?utf-8?B?eVlyaFNCenMzbGFZbnVxaGc0T3p0SXlIbFpYTFJJNklvRjlKMHJTMk1YSDNJ?=
 =?utf-8?B?TUVUMDBybEVUSGNhWUcrWE1PdHlFSGlGd2NndDBDQ1NBclBvTCtpSGFnYi9G?=
 =?utf-8?B?L252dXdRclY4dCsvOCt4TXFyZC84c0huM0svemhRRm9ITXNLZk5vdWRnNkpI?=
 =?utf-8?B?NGJtOGV3bmtaaWFhbTBwYjN6c3c4d0pyUFUzQnlIUk9OREZkVVlGbDkwOXNt?=
 =?utf-8?B?c3hiVGpzSVE4TjJoNzArQmtGSWVzMFZpc2ppZVpyT2NtUzYxVHBjWXRaZGgw?=
 =?utf-8?B?TlJEdTFsMUhzeDJ3YTd0MlF0OEM4YlJtTzM0RWVvVWMrcHV6d0hnTlBqQjQz?=
 =?utf-8?B?bThmQjJoQ0laU3VSQVpucTIwM2tmY3daMGdZWkxSckpKOXdpZ21KaFJOd01S?=
 =?utf-8?Q?I4+mIMKR9zXKDd5Lya5axsg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8176ad3d-6b60-4c47-cdb8-08d9e7ac7511
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 07:03:33.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6M81w7BCy7QK042kQXBP+o9PLBc8P/oYYUsT+3X+yS72kpNj144LP4u3dTsMOBeuvVBxZi/cqW/OOmcMRTLFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3137
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/22 21:56, Yu Zhao wrote:
...
>>> Got it. IIRC, get_user_pages() doesn't imply a write barrier. If so,
>>> there should be a smp_wmb() on the other side:
>>
>> If I understand it correctly, it actually implies a full memory
>> barrier, doesn't it?
>>
>> Because... gup_pte_range() (fast path) calls try_grab_compound_head(),
>> which eventually calls* atomic_add_unless(), an atomic conditional RMW
>> operation with return value, thus fully ordered on success (atomic_t.rst);
>> (on failure gup_pte_range() falls back to the slow path, below.)
>>
>> And follow_page_pte() (slow path) calls try_grab_page(), which also calls
>> into try_grab_compound_head(), as the above.

Well, doing so was a mistake, actually. I've recently reverted it, via:
commit c36c04c2e132 ("Revert "mm/gup: small refactoring: simplify
try_grab_page()""). Details are in the commit log.

Apologies for the confusion that this may have created.

thanks,
-- 
John Hubbard
NVIDIA

>>
>> (* on CONFIG_TINY_RCU, it calls just atomic_add(), which isn't ordered,
>> but that option is targeted for UP/!SMP, thus not a problem for this race.)
>>
>> Looking at the implementation of arch_atomic_fetch_add_unless() on
>> more relaxed/weakly ordered archs (arm, powerpc, if I got that right),
>> there are barriers like 'smp_mb()' and 'sync' instruction if 'old != unless',
>> so that seems to be OK.
>>
>> And the set_page_dirty() calls occur after get_user_pages() / that point.
>>
>> Does that make sense?
> 
> Yes, it does, thanks. I was thinking along the lines of whether there
> is an actual contract. The reason get_user_pages() currently works as
> a full barrier is not intentional but a side effect of this recent
> cleanup patch:
> commit 54d516b1d6 ("mm/gup: small refactoring: simplify try_grab_page()")
> But I agree your fix works as is.

