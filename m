Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33922C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 19:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiAKT3n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:29:43 -0500
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:36032
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236203AbiAKT3l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 14:29:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdP4mbLykn9vTzhX4hWzzpgS4EnKKHx+2b14tH6isoyVLcysXsoNEXzqqviAu2+9UDQjhgSfyWk5MqM4djijpJbdS8q3GdTJcBiKkW1DSxPE0113hVhZP9lAGEKjusIef9W5oD8KI/BKKFw6uRXsrM5tgfKwJ+IxlRjpBatsgq/AmNHNvnI+rVeg6jar6Zi5MN5ji/sAi4nNqtAvl9JopfJWRNKVrzzAXICpJPOPRxo7XV40p5wFvp1j6TrIIFOAN97Mm4iHz9JsXzVTxe484WT5Y3qc0DZNhH7l7oBaP4vK+vgTmxOfmt7Sj/h74Fp6od4vFC3s8ZQycsSdz/itwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii1tSxblTp0OSVcius26NukUZOvjjTkj8ov7Spv8R+s=;
 b=RuQpQnppH30qLkEJdxGOjmMCgLiK9pC2pyJLSxpo0a3D6uJ1HLF2DmMovTKBIMRF0Xl20QZa76CJ4ik352bqRN63+vMIWCvIM6ya724R9EWmEJmkcVfyOgJzNIsp0PnjAJMVDGz056Th0YmUsB52E1ft7/KlE0GjcJiD6+itVfapxYKXegm3os5ySPiNjziMO+CmWeQW5vCa5kLTuaWGpbXtDZh3w50cpkjSlnlWv0D22iVDxCV5pCFXsXyeYfyOktjUfMYaFbfrrCTUK18xc4SYeF1cgugBzR2czt2i+wBhya7HUZOb0bSYyQlgO3yTzNd2NYsi/YXR1RQaSjHsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii1tSxblTp0OSVcius26NukUZOvjjTkj8ov7Spv8R+s=;
 b=MApTAV61ifVxqMRlVYMxlnyHG+6jF4c5/OBkKvI332o4PUwLSXPKkxQYXKisFecOGIX7sHBrOqPOlI/4DQFGSTQ4T0ePC4hHbis88PC00MrFAdY5iw6xHoavbJvZXP8Ib0Lf+74sq5XtkKyY1CS8A+6lSKsGrDPUbarCRWyVCK+7zkQrJIejzg3g23/y0tOUoM1o11FUM3otZh0e5lw46HCyBoLP5zLeeB2uSn2dETZokaTbTCDWpdq6pMrCU2oBDTdQecxFJXS3pzIlJkkwLw+YcwfAaCbkVTIedGtSKnv2tVJHnKVbWbWfET4xrUzXNoyUdEedqCrNDWu+CPpbEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM6PR12MB3995.namprd12.prod.outlook.com (2603:10b6:5:1c6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 19:29:38 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::ede5:7f12:c1:b25%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 19:29:38 +0000
Message-ID: <e75c8f37-782f-f4d4-b197-8fda18090b42@nvidia.com>
Date:   Tue, 11 Jan 2022 11:29:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220105233440.63361-1-mfo@canonical.com>
 <Yd0oLWtVAyAexyQc@google.com> <Yd3SUXVy7MbyBzFw@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yd3SUXVy7MbyBzFw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c91828-8c02-4e60-c874-08d9d538b552
X-MS-TrafficTypeDiagnostic: DM6PR12MB3995:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3995E8DC3D82EA5C1C01F410A8519@DM6PR12MB3995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPCCaUH3/WKzYIQUEPQwosAdvvhrFxD74ICIGw6Y6+As2wRCo22WsVx9P76ihnzmSoONagVFZ3IcviBZhgW2LItHtzQWdw7zTuObGY8EadVrYgxeJgPihxPFrR7SbnHUPbLFRkuzYglXZP/6mgA4wLLKazl0OV6+qrKLBurrTuK5muREP9WI599z7nS3rmhPTbX+2//i20m92BYa1djh4mDvioyInxBbdXPsEjToWr2XlHa9e63v+AVfSp3bYgydSrbxb8NMWMUi1AxXNbI3Yj07UYW6vElUk92aJXOg/JNpKRVlsv7CrE2Vp3/ELWpC+bopg/woeKUOdJLb+haMQOe4V9Xn/RQhFAmN1ZU79sUSm4MiQw7KGbc5fh2H2D8sYw0cd/4vLQ5tLdZfEsHfoSE2L6jJZhEaLuuEsp/ZQLX5qNqXX+ciMJkweWbfeu+aK/qaqsAikoHh0SORNW1YHxyjWiYtELMXoSS/aXJ0ODFM4XNlHwYdms6j3McSbyclR2zcl9lE1VOfZCw4OM0MLhX5N/iyyr8Y6tMQ1xXEO6PI4RPSlvxQr0VaLTQi39C3tVlDQkZxbw2gHXuotRE+mAz8JtCN0E8CY9U5dVTXdNSqXfHXeFxab592/pAAYrJw4reFqvWHVRYF4mrJpAtEm55KHBI6oMYcTAuYhzMaZC9NFpGL+NmQs5Iycq/MR60IzJqofAFnDT8O0VpxTK70FVE6NeHAXsUGm55MkqDI67ogepmvgboXycsda4E4no6g7akPRF5G6VAvL2B30hNBf86MYPoMSP5NVuNa1aX5ocaZqnaBLpXBK20Dk9j75zsQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(36756003)(186003)(66946007)(5660300002)(110136005)(66556008)(6486002)(31696002)(66476007)(6512007)(2616005)(54906003)(508600001)(966005)(2906002)(316002)(53546011)(6506007)(8676002)(86362001)(83380400001)(26005)(31686004)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZaRlMwd1ZPbEMweE01RVJaSFphZzU5NWVTK01iZHMwcW8vKzc3MjdCVG5t?=
 =?utf-8?B?cTE4RzJuTTZVdy9JS2JRa3lHRStUNHI4akttMzZ2K3RLdkhZdHZBTmZBQUFv?=
 =?utf-8?B?YS9yc1hCQmFNWjZzM2JXWlZkZEtaUnRrcE05bnRTWVVLdkJEWFFzNVExTkNC?=
 =?utf-8?B?bUUxYXBKdVdEZGRDcWJXRHNLbXd6ZTlobTBRZ3haR2ZYeTYxcTlTQnVSZmVY?=
 =?utf-8?B?K1ZoaUFDNStTdlE0RDFYSWdkN3MzbEJDMVdydEhwd0trZ2xRaldRTFlwKzhE?=
 =?utf-8?B?R1VkekN0bi9QL2RpYjBuc2lPWUZMdzBOa0d6L2FzblBrZEw3cGpNVXNvMlZS?=
 =?utf-8?B?T0FaM2ttMS9IcmsvTmk3dWJuNkJnb1ZkZHBTZVhTY1VmQ2JCTjVCZi9Kd2Vr?=
 =?utf-8?B?SmRlbG0xWE1EQmZDcHowb0c0bWVUcktpdHlYM2Q4Z3JLSjV2VDVNQWx2bC9L?=
 =?utf-8?B?dWtRMUhtM0hKOFlFL2NRYUpSeE1UWmZyRDVTVEZRMzJyd282S25ROGllQW1s?=
 =?utf-8?B?cERqMTFUSU05bUhTZ3ZTUmo2azBuTmpTdk9tZy9ob0RhZi90ZHhwc1Zweldv?=
 =?utf-8?B?UHgvQTZ4Y2FKZFJEOHhNKzFaSDBtQWR5Q3dxMVNGRUpoQXBkd2w1V1hKeWlH?=
 =?utf-8?B?VkNPVERQY3lZZTllT3dmTE1leGJLM2tBbmdFMUhqZGh6dTJWYnlTaFR6M3Va?=
 =?utf-8?B?VlFUM0VRVlp4OXZ4ZDEvczdQVjA0VXJTYzJZREVqUkZMQmRsMkphMXhmc1Ez?=
 =?utf-8?B?VXNkblNoWVE5eU91RDUwODRmbGdrUWl6MUZmVU5Oejh1QnhQVDgxYWs3WE5L?=
 =?utf-8?B?eVlsbEFkRGtkeFgwdWFVak0rUUxBN21JMUZwbGtvVFhDUFRvVHdoeHl6Y2Vv?=
 =?utf-8?B?UEtBcWFnRjc5SjhYRWRnRnVuYmhoQkNENHBka3JLazNlRXptUGlhbCs0dEVH?=
 =?utf-8?B?MmhwejE5YWJUM29naXNVRkxlQTBQbmFOQTZqVHhSVXdKb3ZRTDJLaHJTdngy?=
 =?utf-8?B?c3Y4dXZYaVVpSzI0WDJoT05oZndrOGRrTlhtQ1VnSTJHVzRMeHZSZWgrTUZX?=
 =?utf-8?B?TExPdy90Nm16T3dpVnVpZ01VM2Qzc3hqOTN2eEU0ZjlHQVZUMm5FcEh5c3RI?=
 =?utf-8?B?dVk1VHdablV0c3Jta2wraDY0VHhtcjFsV1VNOUFqcE8vdmpPUE92VEpJdENs?=
 =?utf-8?B?WTV4TTRXYjZYcGFYbm5WWjEyZ0tNajkwblUzSnBrS3laMWxJTldYSVBxbkJr?=
 =?utf-8?B?WlJJMnlZdzUrVm1TRU9FM0VyUDlJUzZJVVJjeFhKY2IySGJZOWMralExSU1V?=
 =?utf-8?B?OW11Um1HVDU0NjRMVm9VOFVESTYyVzFzVVd5dmJ3R1Qwc0dTWGo3ZE9vajgw?=
 =?utf-8?B?TTJQZmVoakVTeWZ4VEFTemtLTGxWVUIvUEtBYXNjS0JkTTlpVEY1YlNySUcz?=
 =?utf-8?B?QktxcmlTVlBOVGhKNHIxRVk1ZGY4bC9DZktmS2xDTFpsV2xhVW91U3lHMk1h?=
 =?utf-8?B?Uy81THJoejV5MHA2Z21QWi82VkVxa1kxY0w4WXp3N0Noa3c3eGc4VFRtQXJu?=
 =?utf-8?B?RXJOaDdUUG1xa3dxL2h5VzhPWGtqOWkxK1lmWjRTRG1MUURwcitpelhMZDk3?=
 =?utf-8?B?UHc5OUhUNE14SlJYV2FPam1NWWN6bUF2MlVISDU2U3FZZC9KQVBzOXdGb0lY?=
 =?utf-8?B?eHFwZUo1MWhpMHNRbEFOSEE0Qy84UVp1L1IwWjBiTWh4VGVTUUVvVFhXRzM1?=
 =?utf-8?B?LysyREVBaVpIVTFLRGlONHN1cFlmMTF2WnZyc01VRzRSeGY5VUszT3liOHZx?=
 =?utf-8?B?THpyT0FZZXZNanA2NHN1TzBzWkthNEFFdHFZVXNDQVQvREJYaXpnN3RhazRG?=
 =?utf-8?B?Vjk5Z1ljY3pIZ3JRQmZPOXRCc3RQbTNvZnYweFpvSFRHTDJaVXpXYlJrRHE5?=
 =?utf-8?B?N2pkMVcrQktVeFp5eUpoQlU3THBTOFAzYlcxMkFMMERkL3hQL3NPaHRFV1Vj?=
 =?utf-8?B?aGMyV2N4dVdLbGV0ZHRmRGdnY2xJSGpFY2ZGNFhSUlRidHhmeTRJdHJLOWZG?=
 =?utf-8?B?aGZ6SlFHRjYreVlsNlhNUzd4bkgzWmFBVFJmcVdzVVVSdDdaS0lsdEc1YXhY?=
 =?utf-8?B?RmVxZVVTbTJibWxXYlg2TkpjelJLbjVWYmRVRnkzQXp3QTJheEF1aG12UHNC?=
 =?utf-8?Q?OG7jG3Omg00OtKfTWJKt0fo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c91828-8c02-4e60-c874-08d9d538b552
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:29:38.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2Q0mzMz+dEzywcnuCqF4/5YQEYZPZdsg2Z0PBPDlqpAYPwJdGuLpqc2IzT5pOgXr2kUrgfK/xPc+EyIAFQurQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3995
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/22 10:54, Minchan Kim wrote:
...
> Hi Yu,
> 
> I think you're correct. I think we don't like memory barrier
> there in page_dup_rmap. Then, how about make gup_fast is aware
> of FOLL_TOUCH?
> 
> FOLL_TOUCH means it's going to write something so the page

Actually, my understanding of FOLL_TOUCH is that it does *not* mean that
data will be written to the page. That is what FOLL_WRITE is for.
FOLL_TOUCH means: update the "accessed" metadata, without actually
writing to the memory that the page represents.


> should be dirty. Currently, get_user_pages works like that.
> Howver, problem is get_user_pages_fast since it looks like
> that lockless_pages_from_mm doesn't support FOLL_TOUCH.
> 
> So the idea is if param in internal_get_user_pages_fast
> includes FOLL_TOUCH, gup_{pmd,pte}_range try to make the
> page dirty under trylock_page(If the lock fails, it goes

Marking a page dirty solely because FOLL_TOUCH is specified would
be an API-level mistake. That's why it isn't "supported". Or at least,
that's how I'm reading things.

Hope that helps!

> slow path with __gup_longterm_unlocked and set_dirty_pages
> for them).
> 
> This approach would solve other cases where map userspace
> pages into kernel space and then write. Since the write
> didn't go through with the process's page table, we will
> lose the dirty bit in the page table of the process and
> it turns out same problem. That's why I'd like to approach
> this.
> 
> If it doesn't work, the other option to fix this specific
> case is can't we make pages dirty in advance in DIO read-case?
> 
> When I look at DIO code, it's already doing in async case.
> Could't we do the same thing for the other cases?
> I guess the worst case we will see would be more page
> writeback since the page becomes dirty unnecessary.

Marking pages dirty after pinning them is a pre-existing area of
problems. See the long-running LWN articles about get_user_pages() [1].


[1] https://lwn.net/Kernel/Index/#Memory_management-get_user_pages

thanks,
-- 
John Hubbard
NVIDIA
