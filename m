Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D86C33CAA
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 01:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074FC22522
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 01:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgAUBpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:45:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728512AbgAUBpA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 20:45:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD32333EE0431CDAE50B;
        Tue, 21 Jan 2020 09:44:57 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 Jan 2020
 09:44:47 +0800
Subject: Re: [PATCH V3] brd: check and limit max_part par
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
References: <c8236e55-f64f-ef40-b394-8b7e86ce50df@huawei.com>
 <20200115022725.GA14585@ming.t460p>
 <ce5823ea-2183-90df-05b0-c02d1f654be3@huawei.com>
 <20200120225858.GB19571@ming.t460p>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <1378f7d0-7166-a860-03cd-523cef8ea14b@huawei.com>
Date:   Tue, 21 Jan 2020 09:44:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120225858.GB19571@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/1/21 6:58, Ming Lei wrote:
> On Mon, Jan 20, 2020 at 09:14:50PM +0800, Zhiqiang Liu wrote:
>>>> +static inline void brd_check_and_reset_par(void)
>>>> +{
>>>> +       if (unlikely(!rd_nr))
>>>> +               rd_nr = 1;
>>>> +
>>>> +       if (unlikely(!max_part))
>>>> +               max_part = 1;
>>>
>>> Another limit is that 'max_part' needs to be divided exactly by (1U <<
>>> MINORBITS), something like:
>>>
>>> 	max_part = 1UL << fls(max_part)
>>
>> Do we have to limit that 'max_part' needs to be divided exactly by (1U <<
>>> MINORBITS)? As your suggestion, the i * max_part is larger than MINORMASK,
>> we can allocate from extended devt.
> 
> Exact dividing is for reserving same minors for all disks with
> RAMDISK_MAJOR, otherwise there is still chance to get same dev_t when
> adding partitions.
> 
> Extended devt is for covering more disks, not related with 'max_part'.
> 

Thank you very much.
I will change that as you said.


