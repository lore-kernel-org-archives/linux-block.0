Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00348C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 07:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D4120772
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 07:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHSHqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:46:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHSHqJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 03:46:09 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F2481C303EA19B84DB48;
        Wed, 19 Aug 2020 08:46:06 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.203) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 19 Aug
 2020 08:46:06 +0100
Subject: Re: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
To:     Ming Lei <ming.lei@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
 <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
 <20200819000009.GB2712797@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <585bb054-2009-4abc-f1e8-802e494ba49b@huawei.com>
Date:   Wed, 19 Aug 2020 08:43:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200819000009.GB2712797@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.203]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/08/2020 01:00, Ming Lei wrote:
> On Tue, Aug 18, 2020 at 07:19:57PM +0100, John Garry wrote:
>> On 18/08/2020 13:03, John Garry wrote:
>>> Hi guys,
>>>
>>> JFYI, While doing some testing on v5.9-rc1, I stumbled across this:
>>
>> I bisected to here (hopefully without mistake):
> 
> This one is a long-term problem, see the following discussion:
> 
> https://lore.kernel.org/linux-block/1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com/
> 
> 

ah, right. I vaguely remember this. Well, if we didn't have a reliable 
reproducer before, we do now.

Thanks,
John
