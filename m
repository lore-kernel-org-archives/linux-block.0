Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47ADC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 00:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912752230B
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 00:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKSAGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:06:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSAGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 19:06:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so21711989wrw.1
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 16:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tZxLd2IRk4d1rcA/UAUVBNCOa5kUj7/JJgZoFiR+mm8=;
        b=JO81FcDqY5UAZwjwaoPezD9ypCoReQemPwggcYaB7VbdvmgDenTTGGNXpw0PQJDcBN
         kF0htWBYo2417M/wauxvEOnqjCNn+Cby380EhYFXHiCQ3p3aRWOst78Cc3U0Br1+f/Wb
         50/vG5oqt7VxlpFLkp6jOoEfZRKSDlM5nV+PSIqlUu5Mnfq1fOHTYmrxtf2DSTSxS0Ns
         fEtev3DVKd20zbljLoiTj7UUGbS+xrufEzpXWYpilNuH19O7YAe4eXCbcIenS1cMG+D9
         ZGiQqIR8rXbHfXjnyWS64Np2b/tiEbZBnI5cYR6NilUTYi7vf4bZEnjo46uP0apLPIdp
         jLHQ==
X-Gm-Message-State: APjAAAXr6DVqyqSQSYlIGxfmmsUh/rpRYDpFH9VNNMcu2geA3mK6amMa
        CCmh3lPnDUgrceeCvtbpw3U=
X-Google-Smtp-Source: APXvYqw5+UcNcSqFG7ka+GpudIJhIgIFPk49jGnrRMf2u78OLIlUPt9dhcoBrtmcH61evpwo1M2vMg==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr33969309wrm.120.1574121967199;
        Mon, 18 Nov 2019 16:06:07 -0800 (PST)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id f67sm1138078wme.16.2019.11.18.16.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 16:06:06 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
Date:   Mon, 18 Nov 2019 16:05:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116071754.GB18194@ming.t460p>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Sagi,
> 
> On Fri, Nov 15, 2019 at 02:38:44PM -0800, Sagi Grimberg wrote:
>>
>>> Hi,
>>
>> Hey Ming,
>>
>>> Use blk_mq_alloc_request() for allocating NVMe loop, fc, rdma and tcp's
>>> connect request, and selecting transport queue runtime for connect
>>> request.
>>>
>>> Then kill blk_mq_alloc_request_hctx().
>>
>> Is it really so wrong to have an API to allocate a tag that belongs to
>> a specific queue? Why must the tags allocation always correlate to the
>> running cpu? Its true that NVMe is the only consumer of this at the
>> moment, but does this mean that the interface should be removed because
>> it has one (or rather four) consumer(s)?
> 
> Now blk-mq takes a static queue mapping between CPU and hw queues, given
> CPU hotplug may happen any time, so the specified hw queue may become
> inactive any time.
> 
> Queue mapping from CPU to hw queue is one core model of blk-mq which
> relies a lot on the fact that hw queue active or not depends on
> request's submission CPU. And we always can retrieve one active hw
> queue if there is at least one online CPU.
> 
> IO request is always mapped to the proper hw queue via the submission
> CPU and queue type.
> 
> So blk_mq_alloc_request_hctx() is really weird from the above blk-mq's
> model.
> 
> Actually the 4 consumer is just one single type of usage for submitting
> connect command, seems no one explain this special usage before. And the
> driver can handle well enough without this interface just like this
> patch, can't it?

Does removing the cpumask_and with cpu_online_mask fix your test?

this check is wrong to begin with because it can not be true right after
the check.

This is a much simpler fix that does not create this churn local to
every driver. Also, I don't like the assumptions about tag reservations
that the drivers is taking locally (that the connect will have tag 0
for example). All this makes this look like a hack.

There is also the question of what happens when we want to make connects
parallel, which is not the case at the moment...

>> I would instead suggest to simply remove the constraint that
>> blk_mq_alloc_request_hctx() will fail if the first cpu in the mask
>> is not on the cpu_online_mask.. The caller of this would know and
>> be able to handle it.
> 
> Of course, this usage is very special, which is different with normal
> IO or passthrough request.
> 
> The caller of this still needs to rely on blk-mq for dispatching this
> request:
> 
> 1) blk-mq needs to run hw queue in round-robin style, and different
> CPU is selected from active CPU masks for running the hw queue.
> 
> 2) Most of blk-mq drivers have switched to managed IRQ, which may be
> shutdown even though there is still in-flight requests not completed
> on the hw queue. We need to fix this issue. One solution is to free
> the request and remap the bios into proper active hw queue according to
> the new submission CPU.
> 
> 3) warning will be caused when dispatching one request on inactive hw queue
> 
> If we are going to support this special usage, lots of blk-mq needs to
> be changed for covering the so special case.

I'm starting to think we maybe need to get the connect out of the block
layer execution if its such a big problem... Its a real shame if that is
the case...

>> To me it feels like this approach is fundamentally wrong. IMO, having
>> the driver select a different queue than the tag naturally belongs to
>> feels like a backwards design.
> 
> The root cause is that the connection command needs to be submitted via
> one specified queue, which is fundamentally not compatible with blk-mq's
> queue mapping model.
> 
> Given the connect command is so special for nvme, I'd suggest to let driver
> handle it completely, since blk-mq is supposed to serve generic IO function.

Its one thing to handling it locally, and to hack queue_rq to queue on a
different queue than what was determined by the block layer... If this
model is fundamentally broken with how the block layer dispatch
requests, then we need a different solution.
