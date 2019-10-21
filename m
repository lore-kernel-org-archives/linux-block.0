Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A09CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 11:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624A420659
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 11:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJULuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:50:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfJULuC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 07:50:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0C2C893130F6F3E865A0;
        Mon, 21 Oct 2019 19:50:00 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 19:49:58 +0800
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <20191021093448.GA22635@ming.t460p>
 <9e6e86a5-7247-4648-9df9-61f81d2df413@huawei.com>
 <20191021102401.GB22635@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c98c0cd5-950d-5404-eeaf-4e4ed6c86acc@huawei.com>
Date:   Mon, 21 Oct 2019 12:49:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191021102401.GB22635@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>>
>>
>> Yes, we share tags among all queues, but we generate the tag - known as IPTT
>> - in the LLDD now, as we can no longer use the request tag (as it is not
>> unique per all queues):
>>
>> https://github.com/hisilicon/kernel-dev/commit/087b95af374be6965583c1673032fb33bc8127e8#diff-f5d8fff19bc539a7387af5230d4e5771R188
>>
>> As I said, the branch is messy and I did have to fix 087b95af374.
>
> Firstly this way may waste lots of memory, especially the queue depth is
> big, such as, hisilicon V3's queue depth is 4096.
>
> Secondly, you have to deal with queue busy efficiently and correctly,
> for example, your real hw tags(IPTT) can be used up easily, and how
> will you handle these dispatched request?

I have not seen scenario of exhausted IPTT. And IPTT count is same as 
SCSI host.can_queue, so SCSI midlayer should ensure that this does not 
occur.

>
> Finally, you have to evaluate the performance effect, this is highly
> related with how to deal with out-of-IPTT.

Some figures from our previous testing:

Managed interrupt without exposing multiple queues: 3M IOPs
Managed interrupt with exposing multiple queues: 2.6M IOPs
No managed interrupts: 500K IOPs.

Now my problem is that I hear some people are relying on the 3M 
performance, even though it is experimental and unsafe. I need to follow 
up on this. I really don't want to keep that code.

>
> I'd suggest you to fix the stuff and post them out for review.

OK, I'll also check on adding that WARN you provided.

Thanks again,
John

>
> Thanks,
> Ming
>
>
> .
>


