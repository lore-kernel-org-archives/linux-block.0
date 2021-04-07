Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F84C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 17:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35D261353
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 17:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347984AbhDGRAU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:00:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2803 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347954AbhDGRAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 13:00:20 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFr9L3412z686vX;
        Thu,  8 Apr 2021 00:55:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 7 Apr 2021 19:00:08 +0200
Received: from [10.210.168.126] (10.210.168.126) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 18:00:07 +0100
Subject: Re: [PATCH v6 2/5] blk-mq: Introduce atomic variants of
 blk_mq_(all_tag|tagset_busy)_iter
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210406214905.21622-3-bvanassche@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <31402243-57ca-8fa5-473a-d5ce20774c50@huawei.com>
Date:   Wed, 7 Apr 2021 17:57:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210406214905.21622-3-bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.126]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/04/2021 22:49, Bart Van Assche wrote:
> Since in the next patch knowledge is required of whether or not it is
> allowed to sleep inside the tag iteration functions, pass this context
> information to the tag iteration functions. I have reviewed all callers of
> tag iteration functions to verify these annotations by starting from the
> output of the following grep command:
> 
>      git grep -nHE 'blk_mq_(all_tag|tagset_busy)_iter'
> 
> My conclusions from that analysis are as follows:
> - Sleeping is allowed in the blk-mq-debugfs code that iterates over tags.
> - Since the blk_mq_tagset_busy_iter() calls in the mtip32xx driver are
>    preceded by a function that sleeps (blk_mq_quiesce_queue()), sleeping is
>    safe in the context of the blk_mq_tagset_busy_iter() calls.
> - The same reasoning also applies to the nbd driver.
> - All blk_mq_tagset_busy_iter() calls in the NVMe drivers are followed by a
>    call to a function that sleeps so sleeping inside blk_mq_tagset_busy_iter()
>    when called from the NVMe driver is fine.

Hi Bart,

> - scsi_host_busy(), scsi_host_complete_all_commands() and
>    scsi_host_busy_iter() are used by multiple SCSI LLDs so analyzing whether
>    or not these functions may sleep is hard. Instead of performing that
>    analysis, make it safe to call these functions from atomic context.

Please help me understand this solution. The background is that we are 
unsure if the SCSI iters callback functions may sleep. So we use the 
blk_mq_all_tag_iter_atomic() iter, which tells us that we must not 
sleep. And internally, it uses rcu read lock protection mechanism, which 
relies on not sleeping. So it seems that we're making the SCSI iter 
functions being safe in atomic context, and, as such, rely on the iter 
callbacks not to sleep.

But if we call the SCSI iter function from non-atomic context and the 
iter callback may sleep, then that is a problem, right? We're still 
using rcu.

Thanks,
John
