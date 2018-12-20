Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF699C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 04:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764B221741
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 04:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Fg2upG+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbeLTEsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 23:48:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45495 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbeLTEsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 23:48:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so264532pgc.12
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 20:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LdmVvbqNJSKvD3L9fLqPWyd/9YdClk4pagLXGMswoI4=;
        b=Fg2upG+0mW5SqEuGgpD9AsOuGnVO3RWAgrJi+j1IK/KppdxnI897M36/NBvoHGQtTF
         8eH1MT3dwg8r6A1+i9Cp14Lr4Gh/KHayHMcapppZQittpjZEfeasfq+59ORG96jYFsaB
         0YNFxWwiGPCetxEY/7TEfiTNFPU7r12MMDLIB5jbmv4MYOXvd9lyxlGig+hEDNYKNbm3
         jkMJpOlzuY4wIsB0s4H7zLTWVmGUej4ABmtjOyKiDcI2Ba+ta36vl0cGtbW5mjl312dP
         Itb6qhL767uBeuG7JcRbqrLOT1+qrNQiLqeTj8fLCSlY8hvA4x/TyNC4zHY9sQCKikpz
         XLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LdmVvbqNJSKvD3L9fLqPWyd/9YdClk4pagLXGMswoI4=;
        b=ZiN0j6mgf47dxA0mSlGBuOP+YsKkrFIW1jUYX/J7Hux2A2dM6niajsgtdiPdUuKKgc
         DR6wgIVUIwbnJ1j2M+ADuY6oI5hwuRZyn8fU8d5YK0bc6EuqJmufphQgrc0ZZw4GT0CY
         fP37SN2vlHxjWncmDIbhdndwn3MtEveMP4zrOrWbtZAPDqmdjCE16oQsfWJSK977si9g
         41PPJn0FVcIqS/e+9/HDqRT60EhApZfzb4FLcFFJOWA70YLczP9iX0RV5SDr8od8j1Yg
         K3poxxtzsalOr6MQEnK1ieDiuv5REM0hypTVVKrCfIKYSciss7Rpfu/r6NWv0MkC24Ey
         iqyA==
X-Gm-Message-State: AA+aEWa9tZ1hNjSpgEEUxFtqecHLUDa8tz+2oCQkMBOJdCak9z1RduUb
        WnMeFb14juh4kgk+ADwoSPZBKXcPhT3+Kw==
X-Google-Smtp-Source: AFSGD/Wb237FAKCCKdEZS3obZG1YbdusIGloyz3pgJG5RnYbsjrsfStzZE8aqnb9klgGv/8Cs2lSrw==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr21162218pgc.216.1545281333826;
        Wed, 19 Dec 2018 20:48:53 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 15sm28567278pfr.55.2018.12.19.20.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 20:48:52 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
Date:   Wed, 19 Dec 2018 21:48:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/18 9:32 PM, jianchao.wang wrote:
> 
> 
> On 12/20/18 12:19 PM, Jens Axboe wrote:
>> On 12/19/18 8:24 PM, jianchao.wang wrote:
>>>
>>>
>>> On 12/20/18 11:17 AM, Jens Axboe wrote:
>>>> On 12/19/18 5:16 PM, Bart Van Assche wrote:
>>>>> On Wed, 2018-12-19 at 16:27 -0700, Jens Axboe wrote:
>>>>>> On 12/19/18 4:24 PM, Bart Van Assche wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> If I run the srp blktests in a loop then I see the below call stack appearing
>>>>>>> sporadically. I have not yet had the time to analyze this but I'm reporting
>>>>>>> this here in case someone else would already have had a look at this.
>>>>>>>
>>>>>>> Bart.
>>>>>>>
>>>>>>> ==================================================================
>>>>>>> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
>>>>>>> Read of size 8 at addr ffff88803b335240 by task fio/21412
>>>>>>>
>>>>>>> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
>>>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>>>>>>> Call Trace:
>>>>>>>  dump_stack+0x86/0xca
>>>>>>>  print_address_description+0x71/0x239
>>>>>>>  kasan_report.cold.5+0x242/0x301
>>>>>>>  __asan_load8+0x54/0x90
>>>>>>>  bt_iter+0x86/0xf0
>>>>>>>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>>>>>>>  blk_mq_in_flight+0x96/0xb0
>>>>>>>  part_in_flight+0x40/0x140
>>>>>>>  part_round_stats+0x18e/0x370
>>>>>>>  blk_account_io_start+0x3d7/0x670
>>>>>>>  blk_mq_bio_to_request+0x19c/0x3a0
>>>>>>>  blk_mq_make_request+0x7a9/0xcb0
>>>>>>>  generic_make_request+0x41d/0x960
>>>>>>>  submit_bio+0x9b/0x250
>>>>>>>  do_blockdev_direct_IO+0x435c/0x4c70
>>>>>>>  __blockdev_direct_IO+0x79/0x88
>>>>>>>  ext4_direct_IO+0x46c/0xc00
>>>>>>>  generic_file_direct_write+0x119/0x210
>>>>>>>  __generic_file_write_iter+0x11c/0x280
>>>>>>>  ext4_file_write_iter+0x1b8/0x6f0
>>>>>>>  aio_write+0x204/0x310
>>>>>>>  io_submit_one+0x9d3/0xe80
>>>>>>>  __x64_sys_io_submit+0x115/0x340
>>>>>>>  do_syscall_64+0x71/0x210
>>>>>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>>> RIP: 0033:0x7f02cf043219
>>>>>>
>>>>>> I've seen this one before as well, it's not a new thing. As far as I can
>>>>>> tell, it's a false positive. There should be no possibility for a
>>>>>> use-after-free iterating the static tags/requests.
>>>>>
>>>>> Are you sure this is a false positive?
>>>>
>>>> No I'm not, but the few times I have seen it, I haven't been able to
>>>> make much sense of it. It goes back quite a bit.
>>>>
>>>> I have not yet encountered any false
>>>>> positive KASAN complaints. According to the following gdb output this complaint
>>>>> refers to reading rq->q:
>>>>>
>>>>> (gdb) list *(bt_iter+0x86)
>>>>> 0xffffffff816b9346 is in bt_iter (block/blk-mq-tag.c:237).
>>>>> 232
>>>>> 233             /*
>>>>> 234              * We can hit rq == NULL here, because the tagging functions
>>>>> 235              * test and set the bit before assigning ->rqs[].
>>>>> 236              */
>>>>> 237             if (rq && rq->q == hctx->queue)
>>>>> 238                     iter_data->fn(hctx, rq, iter_data->data, reserved);
>>>>> 239             return true;
>>>>> 240     }
>>>>> 241
>>>>>
>>>>> From the disassembly output:
>>>>>
>>>>> 232
>>>>> 233             /*
>>>>> 234              * We can hit rq == NULL here, because the tagging functions
>>>>> 235              * test and set the bit before assigning ->rqs[].
>>>>> 236              */
>>>>> 237             if (rq && rq->q == hctx->queue)
>>>>>    0xffffffff816b9339 <+121>:   test   %r12,%r12
>>>>>    0xffffffff816b933c <+124>:   je     0xffffffff816b935f <bt_iter+159>
>>>>>    0xffffffff816b933e <+126>:   mov    %r12,%rdi
>>>>>    0xffffffff816b9341 <+129>:   callq  0xffffffff813bd3e0 <__asan_load8>
>>>>>    0xffffffff816b9346 <+134>:   lea    0x138(%r13),%rdi
>>>>>    0xffffffff816b934d <+141>:   mov    (%r12),%r14
>>>>>    0xffffffff816b9351 <+145>:   callq  0xffffffff813bd3e0 <__asan_load8>
>>>>>    0xffffffff816b9356 <+150>:   cmp    0x138(%r13),%r14
>>>>>    0xffffffff816b935d <+157>:   je     0xffffffff816b936f <bt_iter+175>
>>>>>
>>>>> BTW, rq may but does not have to refer to tags->static_rqs[...]. It may also
>>>>> refer to hctx->fq.flush_rq.
>>>>
>>>> But even those are persistent for the lifetime of the queue... But since
>>>> kasan complains it belongs to a specific page, I'm guessing it's one
>>>> of the regular requests since those are out of a chopped up page. Which
>>>> means it makes even less sense.
>>>>
>>>> Is this happening while devices are being actively torn down? And
>>>> are you using shared tags? That's the only way I could see this
>>>> triggering.
>>>>
>>>
>>> Or could it be caused by the stale request in hctx->tags->rqs[] slot ?
>>> We don't clear it after free the requests.
>>>
>>> And there could be a scenario like,
>>> There used to be a io scheduler attached.
>>> After some workload, the io scheduler is detached.
>>> So there could be rqs allocated by the io scheduler left in hctx->tags->rqs.
>>>
>>> blk_mq_get_request                            blk_mq_queue_tag_busy_iter
>>>   -> blk_mq_get_tag
>>>                                                 -> bt_for_each
>>>                                                   -> bt_iter
>>>                                                     -> rq = taags->rqs[]
>>>                                                     -> rq->q
>>>   -> blk_mq_rq_ctx_init
>>>     -> data->hctx->tags->rqs[rq->tag] = rq;
>>>
>>> If the scenario is possible, maybe we could fix it as following.
>>
>> Ah yes, good point, I bet that's what it is. But we just had this exact
>> discussion in another thread, and my point there was that we should
>> clear these when they go away, not inline. So how about clearing entries
>> when the sched tags go away?
>>
> I guess it should be OK. :)

Something like this. Totally untested... And I wonder if there's a more
efficient way to do this, not that it matters THAT much. But still.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2de972857496..341cb8b9cfb7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2025,16 +2025,21 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 {
 	struct page *page;
 
-	if (tags->rqs && set->ops->exit_request) {
-		int i;
+	if (tags->rqs) {
+		int i, j;
 
 		for (i = 0; i < tags->nr_tags; i++) {
 			struct request *rq = tags->static_rqs[i];
 
 			if (!rq)
 				continue;
-			set->ops->exit_request(set, rq, hctx_idx);
+			if (set->ops->exit_request)
+				set->ops->exit_request(set, rq, hctx_idx);
 			tags->static_rqs[i] = NULL;
+
+			for (j = 0; j < tags->nr_tags; j++)
+				if (tags->rqs[j] == rq)
+					tags->rqs[j] = NULL;
 		}
 	}
 

-- 
Jens Axboe

