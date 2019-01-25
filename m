Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91480C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 22:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639AF21855
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfAYWKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:10:38 -0500
Received: from gfuc.org ([88.99.83.187]:47894 "EHLO gfuc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfAYWKi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 17:10:38 -0500
Received: from [192.168.178.72] (dslb-092-075-196-175.092.075.pools.vodafone-ip.de [92.75.196.175])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by gfuc.org (Postfix) with ESMTPSA id 532031E00EF;
        Fri, 25 Jan 2019 22:10:35 +0000 (UTC)
From:   Florian Stecker <m19@florianstecker.de>
Subject: Re: fsync hangs after scsi rejected a request
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
 <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
 <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
 <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
 <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de>
 <c42631fa-3e61-e046-851e-8079906a14fb@oracle.com>
Message-ID: <d9fd42a9-6105-2404-6e74-cc540da1cf16@florianstecker.de>
Date:   Fri, 25 Jan 2019 23:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c42631fa-3e61-e046-851e-8079906a14fb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/25/19 10:05 AM, jianchao.wang wrote:
> 
> 
> On 1/25/19 4:56 PM, Florian Stecker wrote:
>> On 1/25/19 4:49 AM, jianchao.wang wrote:
>>>
>>> It sounds like not so easy to trigger.
>>>
>>> blk_mq_dispatch_rq_list
>>>     scsi_queue_rq
>>>        if (atomic_read(&sdev->device_busy) ||
>>>          scsi_device_blocked(sdev))
>>>          ret = BLK_STS_DEV_RESOURCE;             scsi_end_request
>>>                                                    __blk_mq_end_request
>>>                                                      blk_mq_sched_restart // clear RESTART
>>>                                                        blk_mq_run_hw_queue
>>>                                                    blk_mq_run_hw_queues
>>>       list_splice_init(list, &hctx->dispatch)
>>>     needs_restart = blk_mq_sched_needs_restart(hctx)
>>>
>>> The 'needs_restart' will be false, so the queue would be rerun.
>>>
>>> Thanks
>>> Jianchao
>>
>> Good point. So the RESTART flag is supposed to protect against this? Now I see, this is also sort of what the lengthy comment in blk_mq_dispatch_rq_list is saying.
>>
>> May I complain that this is very unintuitive (the queue gets rerun when the RESTART flag is _not_ set) and also unreliable, as not every caller of blk_mq_dispatch_rq_list seems to set the flag, and also it does not always get cleared in __blk_mq_end_request?
>>
>> __blk_mq_end_request does the following:
>>
>>      if (rq->end_io) {
>>          rq_qos_done(rq->q, rq);
>>          rq->end_io(rq, error);
>>      } else {
>>          if (unlikely(blk_bidi_rq(rq)))
>>              blk_mq_free_request(rq->next_rq);
>>          blk_mq_free_request(rq);
>>      }
>>
>> and blk_mq_free_request then calls blk_mq_sched_restart, which clears the flag. But in my case, rq->end_io != 0, so blk_mq_free_request is never called.
> 
> So what is your rq->end_io ?
> flush_end_io ? or mq_flush_data_end_io ? or other ?
> In normal case, the blk_mq_end_request should be finally invoked.
> 
> Did you ever try the bfq io scheduler instead of mq-deadline ?
> 
> Can you share your dmesg and config file here ?

Sure.

dmesg: https://florianstecker.de/dmesg-2019-01-25.txt
Note that no I/O scheduler is in use here, I deactivated them in a udev 
rule because I still want to be able to use my laptop. When I test this 
stuff I just reactivate mq-deadline manually.

Config is the default in Arch Linux: 
https://git.archlinux.org/svntogit/packages.git/tree/trunk/config?h=packages/linux

The problem also appears with BFQ.

And rq->end_io is set to mq_flush_data_end_io when this happens. The 
only point I see where this function could invoke blk_mq_end_request is 
via blk_flush_complete_seq, but it does so only if seq == REQ_FSEQ_DONE. 
However, seq is REQ_FSEQ_POSTFLUSH for me (i.e. it just transitioned 
from REQ_FSEQ_DATA to REQ_FSEQ_POSTFLUSH).

> 
> Thanks
> Jianchao
> 
