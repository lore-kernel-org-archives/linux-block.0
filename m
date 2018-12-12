Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DBC65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8882084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 18:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8882084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeLLSXP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:23:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36077 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 13:23:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so8703734pgm.3;
        Wed, 12 Dec 2018 10:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ARtLP0pFpzDfKojTpOqDFpWrfdhtL1szGWqvNpTejA=;
        b=f4JGm7ypLn9fD9WMErIqCRMy1E4h6DPGzm+ieDdb8bucs09wepCdrOhEgsziy/3MDj
         s8OhxupB1D7rWgoBPckqI6al7xV9CL7E+3TkkqYXZ1EUaOQBS4Xj8tgTO7o+lfwnFMEd
         TOJ1jSqIqxbO5Wb4lXDjU+lt1/aVbWxAK8JMAoZ9G+z5u95s8LU6uLZL6dtJtbG3TfcL
         iPAWJ0syFE0u7hxjqdC32xGLsjjMCgdeIwQu4rl86/hJmJe43t77jYZwVJPIRZoZXgM1
         zvZOzHOyMw7CxcOsidnHSPcaMTFW3f6GUWs5ee7A2360jfqcXShYbzh8OHnuJKfKvKcN
         rWng==
X-Gm-Message-State: AA+aEWa13BmSL0bG9NQTcJOGT2P69zU5mbeYS1xXcs0NZ0GHvKeq4Qps
        7lX3oYzi0sJ2f5PM2bXFGUM=
X-Google-Smtp-Source: AFSGD/WdOvO6j0b1xXMjIkhXVESF+aOhk87sqUCC/MqMfSvUXiHLHK+LWC2Uk3XfFnCSh92D34aacg==
X-Received: by 2002:a63:f201:: with SMTP id v1mr17833043pgh.232.1544638994620;
        Wed, 12 Dec 2018 10:23:14 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id f62sm22832139pgc.67.2018.12.12.10.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:23:13 -0800 (PST)
Subject: Re: [PATCH RFC 0/4] restore polling to nvme-rdma
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181212070756.GC28461@lst.de>
 <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
 <20181212080945.GA29679@lst.de>
 <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>
 <20181212140518.GA4527@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1abe2fa0-e05a-e8a7-47e6-6e37b4d8011e@grimberg.me>
Date:   Wed, 12 Dec 2018 10:23:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212140518.GA4527@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Well, it should just be a little blk_poll loop, right?
>>
>> Not so much about the poll loop, but the fact that we will need
>> to check if we need to poll for this special case every time in
>> .queue_rq and its somewhat annoying...
> 
> I don't think we need to add any special check in queue_rq.  Any
> polled command should be marked as HIPRI from the submitting code,
> and that includes the queue creation.

Hmm, good idea, perhaps adding something like to following:
--
/**
  * blk_execute_rq_polled - execute a request and poll for its completion
  * @q:          queue to insert the request in
  * @bd_disk:    matching gendisk
  * @rq:         request to insert
  * @at_head:    insert request at head or tail of queue
  *
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler
  *    queue for execution and poll for completion.
  */
void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
                    struct request *rq, int at_head)
{
         DECLARE_COMPLETION_ONSTACK(wait);
         unsigned long hang_check;

	rq->cmd_flags |= REQ_HIPRI;
         rq->end_io_data = &wait;
         blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);

         while (!completion_done(&wait))
		blk_poll(q, 0, true);
}
EXPORT_SYMBOL(blk_execute_rq_polled);
--

and __nvme_submit_sync_cmd() can receive a poll argument as well to call
blk_execute_req_polled()?
