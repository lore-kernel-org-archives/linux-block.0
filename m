Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85CBC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62E164E06
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhBCQVN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:21:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2491 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhBCQVM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 11:21:12 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DW6JW21f8z67kbS;
        Thu,  4 Feb 2021 00:16:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 17:20:29 +0100
Received: from [10.210.171.46] (10.210.171.46) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 16:20:28 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2 v3] blk-mq: Improve performance of non-mq IO
 schedulers with multiple HW queues
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
CC:     <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
References: <20210111164717.21937-1-jack@suse.cz>
 <7afa35b2-cf35-a149-d325-3ad2ae8d8935@kernel.dk>
Message-ID: <8b871c07-a516-36ae-75c2-7d0a153ea753@huawei.com>
Date:   Wed, 3 Feb 2021 16:18:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7afa35b2-cf35-a149-d325-3ad2ae8d8935@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.46]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/01/2021 01:20, Jens Axboe wrote:
> On 1/11/21 9:47 AM, Jan Kara wrote:
>> Hello!
>>
>> This patch series aims to fix a regression we've noticed on our test grid when
>> support for multiple HW queues in megaraid_sas driver was added during the 5.10
>> cycle (103fbf8e4020 scsi: megaraid_sas: Added support for shared host tagset
>> for cpuhotplug). The commit was reverted in the end for other reasons but I
>> believe the fundamental problem still exists for any other similar setup.

That commit made it into 5.11-rc, and other SCSI HBA expose HW queues in 
5.10 and earlier. But then this series is targeted at 5.12.

Question: can we consider backport this series just due to performance 
issue regression? I'd say no, but maybe someone strongly disagrees with 
me ...

Thanks,
John

> The
>> problem manifests when the storage card supports multiple hardware queues
>> however storage behind it is slow (single rotating disk in our case) and so
>> using IO scheduler such as BFQ is desirable. See the second patch for details.

