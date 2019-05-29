Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93435C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7110423D12
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 16:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2QK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 12:10:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfE2QK6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 12:10:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67780B8DF9748E704AEA;
        Thu, 30 May 2019 00:10:53 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 00:10:48 +0800
Subject: Re: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on CPU
 unplug
To:     Ming Lei <tom.leiming@gmail.com>, Ming Lei <ming.lei@redhat.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-6-ming.lei@redhat.com>
 <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com>
 <20190529022852.GA21398@ming.t460p> <20190529024200.GC21398@ming.t460p>
 <5bc07fd5-9d2b-bf9c-eb77-b8cebadb9150@huawei.com>
 <20190529101028.GA15496@ming.t460p>
 <CACVXFVODeFDPHxWkdnY5CZoOJ0did4mi_ap-aXk0oo+Cp05aUQ@mail.gmail.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        "Kashyap Desai" <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <94964048-b867-8610-71ea-0275651f8b77@huawei.com>
Date:   Wed, 29 May 2019 17:10:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVODeFDPHxWkdnY5CZoOJ0did4mi_ap-aXk0oo+Cp05aUQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>
>> And we should be careful to handle the multiple reply queue case, given the queue
>> shouldn't be stopped or quieseced because other reply queues are still active.
>>
>> The new CPUHP state for blk-mq should be invoked after the to-be-offline
>> CPU is quiesced and before it becomes offline.
>
> Hi John,
>

Hi Ming,

> Thinking of this issue further, so far, one doable solution is to
> expose reply queues
> as blk-mq hw queues, as done by the following patchset:
>
> https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/

I thought that this patchset had fundamental issues, in terms of working 
for all types of hosts. FYI, I did the backport of latest hisi_sas_v3 to 
v4.15 with this patchset (as you may have noticed in my git send 
mistake), but we have not got to test it yet.

On a related topic, we did test exposing reply queues as blk-mq hw 
queues and generating the host-wide tag internally in the LLDD with 
sbitmap, and unfortunately we were experiencing a significant 
performance hit, like 2300K -> 1800K IOPs for 4K read.

We need to test this further. I don't understand why we get such a big hit.

>
> In which global host-wide tags are shared for all blk-mq hw queues.
>
> Also we can remove all the reply_map stuff in drivers, then solve the problem of
> draining in-flight requests during unplugging CPU in a generic approach.

So you're saying that removing this reply queue stuff can make the 
solution to the problem more generic, but do you have an idea of the 
overall solution?

>
> Last time, it was reported that the patchset causes performance regression,
> which is actually caused by duplicated io accounting in
> blk_mq_queue_tag_busy_iter(),
> which should be fixed easily.
>
> What do you think of this approach?

It would still be good to have a forward port of this patchset for 
testing, if we're serious about it. Or at least this bug you mention fixed.

thanks again,
John

>
> Thanks,
> Ming Lei
>
> .
>


