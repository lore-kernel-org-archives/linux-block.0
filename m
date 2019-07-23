Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC49C7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 00:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DFF21951
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 00:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfGWAHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:07:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43791 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbfGWAHz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 20:07:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so30985337oif.10
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 17:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fjcB1FH4OIEzwCsv2saOPnLiM1UTiS07EKgrxMRYBfk=;
        b=mrua4zZplRsf8rEJCits9QYus/B7ZhFYjY4rLOQmATQvzNlEfal93EbmG6jcSrH2K2
         CQ16hxRu1EKZXu0WPHkiq6PWZaaj5oT52gCsfaPV+K7q1L3FPoL0ospSS0hcIsKwLyrX
         rP68g3Sdt0jOtYV1uJ0rRNoXI7F9pTOMi8QJil4IlS8VobTKQZqcbeH1c/8y0cIPFNfg
         5oggFWb3P82UBs0oCHPzrWofEynN1356yWwZKijEzBF6SXhoOQ/SjxYUbCEj7O5Eu/1S
         cjhPxVu1B1U4OFDtqc0jNzCvRC0dlz3BddEE27okZY32q4LwwwqPv+NFOEIqQXIakFFs
         zleg==
X-Gm-Message-State: APjAAAX9/YG7p27UBERcqSW2rEvnRLNaErjju2Ea5S7YTy9IdjWCmvDt
        7O0808UoprPpS0HdQA/iUmk=
X-Google-Smtp-Source: APXvYqwea4YnEJu6LuLrymkLkcWKnNCXqEHllMPIzZtYxWFX32bCNusnaNoOlVNGrKCOT6rkwxe3Jw==
X-Received: by 2002:aca:3a0a:: with SMTP id h10mr37399735oia.52.1563840474588;
        Mon, 22 Jul 2019 17:07:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id z69sm13985238oia.48.2019.07.22.17.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 17:07:53 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme: don't abort completed request in
 nvme_cancel_request
To:     Keith Busch <keith.busch@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-4-ming.lei@redhat.com>
 <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
 <CAOSXXT5TkrfH0AFZCV0c+YtbFCQ4MnShKM-gkZrj8Qex+Z7Png@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29a64c98-5da2-c954-1272-e8705a4941c4@grimberg.me>
Date:   Mon, 22 Jul 2019 17:07:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAOSXXT5TkrfH0AFZCV0c+YtbFCQ4MnShKM-gkZrj8Qex+Z7Png@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> On 7/21/19 10:39 PM, Ming Lei wrote:
>>> Before aborting in-flight requests, all IO queues have been shutdown.
>>> However, request's completion fn may not be done yet because it may
>>> be scheduled to run via IPI.
>>>
>>> So don't abort one request if it is marked as completed, otherwise
>>> we may abort one normal completed request.
>>>
>>> Cc: Max Gurtovoy <maxg@mellanox.com>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Cc: Keith Busch <keith.busch@intel.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/core.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index cc09b81fc7f4..cb8007cce4d1 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -285,6 +285,10 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>>
>>>    bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>>>    {
>>> +     /* don't abort one completed request */
>>> +     if (blk_mq_request_completed(req))
>>> +             return;
>>> +
>>>        dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>>>                                "Cancelling I/O %d", req->tag);
>>
>> Something I probably already asked before: what prevents that
>> nvme_cancel_request() is executed concurrently with the completion
>> handler of the same request?
> 
> At least for pci, we've shutdown the queues and their interrupts prior
> to tagset iteration, so we can't concurrently execute a natural
> completion for in-flight requests while cancelling them.

Same for tcp and rdma.
