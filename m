Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA323CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736E620663
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TeB4LX5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440455AbfJYOH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:07:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32875 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440454AbfJYOHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 10:07:25 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so2586124ior.0
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5GdXKqf6yTV+U8mRSZVSLLtANpPp/soR4POWFI0sV0Y=;
        b=TeB4LX5zj8ESVoMLzWwDofsig8gwlAv0TqMy5l9ZwwTwx7KxzjioRsS1KA9luDlAAm
         5S6WzX/89oCPRg5G4eZu4TWLSkifHadS+nKXxCI50ArCrdsiiOTiXuTjWY5q1oes7FeN
         a5spKzzL+yZw2CNKDlEMoUSJOxazpHs8RvQkUcmua8arPLbo4D6hzA0PgUJ9SPCCIeSB
         tFYDwBKiIfD0tIjnMKJQOn1/a1WU83gBkYO9C98IWZ80SKhECM5bEaeq3Ast5Ca0ICcG
         3xjm9UREbEK90BhzS0dMOjKfmlSZmByg7DCLZ4a69coFS/P+zKee5sN7SYWYjRWP+Dca
         +a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5GdXKqf6yTV+U8mRSZVSLLtANpPp/soR4POWFI0sV0Y=;
        b=q0Lh7f6QxmBLv4jTZr1tH0Q5dMYu0NYPmDWtZrqBiPOpid3IcS7UGLqdTMxDk/Slgb
         YLEv4YHqy+mhvAMcFImVln6QugWcXmxCLOkmvYfzhqUnSCWcV1SvUI7XcdYEYHP4AGm4
         3gPVoFWxj+xYPeM9sGalucs4SEOgpxA8x57ya4mzVlYz9t9TJY1Rkh2D3ucDpJFvqa49
         mCSy3B7HLwMQJXALNOeKnylJkSXxsUWN8s80wGCdtNxAyPtAKa/YR+ObpYisC1WLbuta
         lnkEo/luB17eHkUzpksiPIHfhod5PB6dmkewualYZb+SGoZaIoiJqzoO0zR2UyeoAC3w
         UpEA==
X-Gm-Message-State: APjAAAXltZzKosREwLvgdQqMLLoactzlaif2k02PdENIqTtWTwHDBGN6
        4oRP9hQTxGKculCe6TMLywjzc2tyZaziMw==
X-Google-Smtp-Source: APXvYqxnW988THyVZpeHO/39qP3RUIFJwUqXelkDMy8/nHloWg46dhy/u2Ejpb1haJke0tlIJBKMgg==
X-Received: by 2002:a02:7788:: with SMTP id g130mr4038357jac.56.1572012442662;
        Fri, 25 Oct 2019 07:07:22 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y7sm356068iln.20.2019.10.25.07.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 07:07:21 -0700 (PDT)
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
 <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
 <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
 <90c23805-4b73-4ade-1b54-dc68010b54dd@kernel.dk>
 <fa82e9fc-caf7-a94a-ebff-536413e9ecce@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7abb363-d665-b46a-9fb5-d01e7a6ce4d6@kernel.dk>
Date:   Fri, 25 Oct 2019 08:07:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fa82e9fc-caf7-a94a-ebff-536413e9ecce@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 7:46 AM, Bijan Mottahedeh wrote:
> 
> On 10/24/19 3:31 PM, Jens Axboe wrote:
>> On 10/24/19 1:18 PM, Bijan Mottahedeh wrote:
>>> On 10/24/19 10:09 AM, Jens Axboe wrote:
>>>> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>>>>> Running an fio test consistenly crashes the kernel with the trace included
>>>>> below.  The root cause seems to be the code in __io_submit_sqe() that
>>>>> checks the result of a request for -EAGAIN in polled mode, without
>>>>> ensuring first that the request has completed:
>>>>>
>>>>> 	if (ctx->flags & IORING_SETUP_IOPOLL) {
>>>>> 		if (req->result == -EAGAIN)
>>>>> 			return -EAGAIN;
>>>> I'm a little confused, because we should be holding the submission
>>>> reference to the request still at this point. So how is it going away?
>>>> I must be missing something...
>>> I don't think the submission reference is going away...
>>>
>>> I *think* the problem has to do with the fact that
>>> io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being
>>> called from interrupt context in my configuration and so there is a
>>> potential race between updating the request there and checking it in
>>> __io_submit_sqe().
>>>
>>> My first workaround was to simply poll for REQ_F_IOPOLL_COMPLETED in the
>>> code snippet above:
>>>
>>>        if (req->result == --EAGAIN) {
>>>
>>>            poll for REQ_F_IOPOLL_COMPLETED
>>>
>>>            return -EAGAIN;
>>>
>>> }
>>>
>>> and that got rid of the problem.
>> But that will not work at all for a proper poll setup, where you don't
>> trigger any IRQs... It only happens to work for this case because you're
>> still triggering interrupts. But even in that case, it's not a real
>> solution, but I don't think that's the argument here ;-)
> 
> Sure.
> 
> I'm just curious though as how it would break the poll case because
> io_complete_rw_iopoll() would still be called though through polling,
> REQ_F_IOPOLL_COMPLETED would be set, and so io_iopoll_complete()
> should be able to reliably check req->result.

It'd break the poll case because the task doing the submission is
generally also the one that finds and reaps completion. Hence if you
block that task just polling on that completion bit, you are preventing
that very task from going and reaping completions. The condition would
never become true, and you are now looping forever.

> The same poll test seemed to run ok with nvme interrupts not being
> triggered. Anyway, no argument that it's not needed!

A few reasons why it would make progress:

- You eventually trigger a timeout on the nvme side, as blk-mq finds the
  request hasn't been completed by an IRQ. But that's a 30 second ordeal
  before that event occurs.

- There was still interrupts enabled.

- You have two threads, one doing submission and one doing completions.
  Maybe using SQPOLL? If that's the case, then yes, it'd still work as
  you have separate threads for submission and completion.

For the "generic" case of just using one thread and IRQs disabled, it'd
deadlock.

>> I see what the race is now, it's specific to IRQ driven polling. We
>> really should just disallow that, to be honest, it doesn't make any
>> sense. But let me think about if we can do a reasonable solution to this
>> that doesn't involve adding overhead for a proper setup.
> 
> It's a nonsensical config in a way and so disallowing it would make
> the most sense.

Definitely. The nvme driver should not set .poll() if it doesn't have
non-irq poll queues. Something like this:


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 869f462e6b6e..ac1b0a9387a4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1594,6 +1594,16 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.poll		= nvme_poll,
 };
 
+static const struct blk_mq_ops nvme_mq_nopoll_ops = {
+	.queue_rq	= nvme_queue_rq,
+	.complete	= nvme_pci_complete_rq,
+	.commit_rqs	= nvme_commit_rqs,
+	.init_hctx	= nvme_init_hctx,
+	.init_request	= nvme_init_request,
+	.map_queues	= nvme_pci_map_queues,
+	.timeout	= nvme_timeout,
+};
+
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
 {
 	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q)) {
@@ -2269,11 +2279,14 @@ static void nvme_dev_add(struct nvme_dev *dev)
 	int ret;
 
 	if (!dev->ctrl.tagset) {
-		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
 		dev->tagset.nr_maps = 2; /* default + read */
-		if (dev->io_queues[HCTX_TYPE_POLL])
+		if (dev->io_queues[HCTX_TYPE_POLL]) {
+			dev->tagset.ops = &nvme_mq_ops;
 			dev->tagset.nr_maps++;
+		} else {
+			dev->tagset.ops = &nvme_mq_nopoll_ops;
+		}
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =

-- 
Jens Axboe

