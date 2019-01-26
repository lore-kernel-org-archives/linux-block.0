Return-Path: <SRS0=xZ4d=QC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B19EC282C7
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D12921903
	for <linux-block@archiver.kernel.org>; Sat, 26 Jan 2019 15:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfAZPhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:37:15 -0500
Received: from gfuc.org ([88.99.83.187]:47906 "EHLO gfuc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfAZPhP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Jan 2019 10:37:15 -0500
Received: from [192.168.43.152] (x2f7f632.dyn.telefonica.de [2.247.246.50])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by gfuc.org (Postfix) with ESMTPSA id E59DC1E00F5;
        Sat, 26 Jan 2019 15:37:09 +0000 (UTC)
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
 <d9fd42a9-6105-2404-6e74-cc540da1cf16@florianstecker.de>
 <3d921990-06c4-4662-2853-7667b4e9a462@oracle.com>
 <4fe48ebc-43db-7ada-087b-5ccbdb64cc66@oracle.com>
From:   Florian Stecker <m19@florianstecker.de>
Message-ID: <00501045-a87b-27d0-6373-72dcf243b32b@florianstecker.de>
Date:   Sat, 26 Jan 2019 16:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4fe48ebc-43db-7ada-087b-5ccbdb64cc66@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/26/19 2:25 AM, jianchao.wang wrote:
> 
> 
> On 1/26/19 9:18 AM, jianchao.wang wrote:
>>
>>
>> On 1/26/19 6:10 AM, Florian Stecker wrote:
>>>
>>>
>>> On 1/25/19 10:05 AM, jianchao.wang wrote:
>>>>
>>>>
>>>> On 1/25/19 4:56 PM, Florian Stecker wrote:
>>>>> On 1/25/19 4:49 AM, jianchao.wang wrote:
>>>>>>
>>>>>> It sounds like not so easy to trigger.
>>>>>>
>>>>>> blk_mq_dispatch_rq_list
>>>>>>      scsi_queue_rq
>>>>>>         if (atomic_read(&sdev->device_busy) ||
>>>>>>           scsi_device_blocked(sdev))
>>>>>>           ret = BLK_STS_DEV_RESOURCE;             scsi_end_request
>>>>>>                                                     __blk_mq_end_request
>>>>>>                                                       blk_mq_sched_restart // clear RESTART
>>>>>>                                                         blk_mq_run_hw_queue
>>>>>>                                                     blk_mq_run_hw_queues
>>>>>>        list_splice_init(list, &hctx->dispatch)
>>>>>>      needs_restart = blk_mq_sched_needs_restart(hctx)
>>>>>>
>>>>>> The 'needs_restart' will be false, so the queue would be rerun.
>>>>>>
>>>>>> Thanks
>>>>>> Jianchao
>>>>>
>>>>> Good point. So the RESTART flag is supposed to protect against this? Now I see, this is also sort of what the lengthy comment in blk_mq_dispatch_rq_list is saying.
>>>>>
>>>>> May I complain that this is very unintuitive (the queue gets rerun when the RESTART flag is _not_ set) and also unreliable, as not every caller of blk_mq_dispatch_rq_list seems to set the flag, and also it does not always get cleared in __blk_mq_end_request?
>>>>>
>>>>> __blk_mq_end_request does the following:
>>>>>
>>>>>       if (rq->end_io) {
>>>>>           rq_qos_done(rq->q, rq);
>>>>>           rq->end_io(rq, error);
>>>>>       } else {
>>>>>           if (unlikely(blk_bidi_rq(rq)))
>>>>>               blk_mq_free_request(rq->next_rq);
>>>>>           blk_mq_free_request(rq);
>>>>>       }
>>>>>
>>>>> and blk_mq_free_request then calls blk_mq_sched_restart, which clears the flag. But in my case, rq->end_io != 0, so blk_mq_free_request is never called.
>>>>
>>>> So what is your rq->end_io ?
>>>> flush_end_io ? or mq_flush_data_end_io ? or other ?
>>>> In normal case, the blk_mq_end_request should be finally invoked.
>>>>
>>>> Did you ever try the bfq io scheduler instead of mq-deadline ?
>>>>
>>>> Can you share your dmesg and config file here ?
>>>
>>> Sure.
>>>
>>> dmesg: https://urldefense.proofpoint.com/v2/url?u=https-3A__florianstecker.de_dmesg-2D2019-2D01-2D25.txt&d=DwIDaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=t_udGGsH8ivtjXHin4oQ4LxELuPoXbl_ARP7oSxiQ6k&s=DC2fhRw2g4haGhhHxOYyX4zD6FWQQ5YoERdfptVRHM4&e=
>>> Note that no I/O scheduler is in use here, I deactivated them in a udev rule because I still want to be able to use my laptop. When I test this stuff I just reactivate mq-deadline manually.
>>>
>>> Config is the default in Arch Linux: https://urldefense.proofpoint.com/v2/url?u=https-3A__git.archlinux.org_svntogit_packages.git_tree_trunk_config-3Fh-3Dpackages_linux&d=DwIDaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=t_udGGsH8ivtjXHin4oQ4LxELuPoXbl_ARP7oSxiQ6k&s=GjV_fyXaKZ8za8zdB_gqmKW7yBlbla2OHRaAT0iGZkc&e=
>>>
>>> The problem also appears with BFQ.
>>>
>>> And rq->end_io is set to mq_flush_data_end_io when this happens. The only point I see where this function could invoke blk_mq_end_request is via blk_flush_complete_seq, but it does so only if seq == REQ_FSEQ_DONE. However, seq is REQ_FSEQ_POSTFLUSH for me (i.e. it just transitioned from REQ_FSEQ_DATA to REQ_FSEQ_POSTFLUSH).
>>
>>
>> Could it be this scenario ?
>>
>> data + post flush
>>
>> blk_flush_complete_seq          a flush
>>    case REQ_FSEQ_DATA
>>    blk_flush_queue_rq
>>    
>>    finally issued to driver      blk_mq_dispatch_rq_list
>>                                  try to issue a flush req
>>                                  failed due to NON-NCQ command
>>                                  due to RESTART is set, do nothing
>>    req complete
>>    req->end_io（） // doesn't check RESTART
>>    mq_flush_data_end_io
>> 　  blk_flush_complete_seq
>>       case REQ_FSEQ_POSTFLUSH
>>       blk_kick_flush
>>         do nothing because previous flush
>>         has not been completed, so
>>         flush_pending_idx != flush_running_idx
>>
> 
> If it is right, maybe we could try following
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ba37b9..3411b6a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -549,6 +549,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>          if (rq->end_io) {
>                  rq_qos_done(rq->q, rq);
>                  rq->end_io(rq, error);
> +               blk_mq_sched_restart(hctx);
>          } else {
>                  if (unlikely(blk_bidi_rq(rq)))
>                          blk_mq_free_request(rq->next_rq);
> 
> 
> 

I'm not sure if I understand every detail, but your scenario sounds 
roughly the same as what I imagine. The patch solves the problem for me 
(except for the fact that hctx is not defined in that function).

Actually, it doesn't seem to me as if any of the other users of 
blk_mq_free_request require or even expect that it calls 
blk_mq_sched_restart (I could be wrong though). If that is true, how 
about we just call it from __blk_mq_end_request, like this (also tested 
successfully on my laptop)?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6a7566244de3..9f3d3456c4af 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -481,7 +481,6 @@ static void __blk_mq_free_request(struct request *rq)
                 blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
         if (sched_tag != -1)
                 blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
-       blk_mq_sched_restart(hctx);
         blk_queue_exit(q);
  }

@@ -522,6 +521,7 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
  inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
  {
         u64 now = ktime_get_ns();
+       struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, 
rq->mq_ctx->cpu);

         if (rq->rq_flags & RQF_STATS) {
                 blk_mq_poll_stats_start(rq->q);
@@ -541,6 +541,8 @@ inline void __blk_mq_end_request(struct request *rq, 
blk_status_t error)
                         blk_mq_free_request(rq->next_rq);
                 blk_mq_free_request(rq);
         }
+
+       blk_mq_sched_restart(hctx);
  }
  EXPORT_SYMBOL(__blk_mq_end_request);

Thanks,
Florian
