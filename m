Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B2C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 18:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7B6613CC
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 18:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhE0SmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 14:42:03 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:34438 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhE0Sl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 14:41:58 -0400
Received: by mail-pl1-f177.google.com with SMTP id e15so413483plh.1
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 11:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kRWmXULB0L3U+Et48ICY2LJMecDWMsK5C6cbbPBUkdw=;
        b=JchEBrO01sbl1reiLmHIlytMQhRDyFYYk49/lgoRCKV64I4R41ytp7OL+0Jo172xzt
         wm0oclEhgf/SxGyocUuiFmDxVyAnLQvQ5stt71xF2RrBYTrZVw+FKfQq/FI/Dx5GKKOb
         PYH74b69qxNg04J8c9l0PawPM3jRiiv3v6oHVfs0pLpMuVXNXmnwiTGnKqaaeJjcsAgD
         dDgBJEJSw+3ALytNWhmpL12a5PFHwAG1ps70UZRsLEgqDxmQPloWtT5/gsJmR1FwT3s6
         tPqypf7l8Ze/MtnOXU8jnOtUYNTXI6+HHKVbxmUvhZJNUdybeY7X3MeCPqP8VRKP287P
         h6bQ==
X-Gm-Message-State: AOAM531FuA3ApF0A3FXBBIPKI3SVvWQtLlfZyI6OAnvS0xENy2DFG3Il
        dZvBlLXZAFOISsaklf3wFS0=
X-Google-Smtp-Source: ABdhPJxorX3n3vwMMt2LRIt6rJJbzMI+ycpVqOD68diL/Oh3WunCL4bnhuYZrbwWHsk/0X7r2xJzSA==
X-Received: by 2002:a17:90a:be12:: with SMTP id a18mr5087108pjs.187.1622140823385;
        Thu, 27 May 2021 11:40:23 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c20sm2515899pjr.35.2021.05.27.11.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 11:40:22 -0700 (PDT)
Subject: Re: [PATCH 0/9] Improve I/O priority support
To:     Wang Jianchao <jianchao.wan9@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <b58840a8-0122-26cd-e756-92562064075a@gmail.com>
 <ef81558a-cab2-ca2f-dba8-e032ecdb8154@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <22c245e9-469c-0a0f-ad31-455a33f1e073@acm.org>
Date:   Thu, 27 May 2021 11:40:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <ef81558a-cab2-ca2f-dba8-e032ecdb8154@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 1:05 AM, Wang Jianchao wrote:
> On 2021/5/27 2:25 PM, Wang Jianchao wrote:
>> On 2021/5/27 9:01 AM, Bart Van Assche wrote:
>>> A feature that is missing from the Linux kernel for storage devices that
>>> support I/O priorities is to set the I/O priority in requests involving page
>>> cache writeback. Since the identity of the process that triggers page cache
>>> writeback is not known in the writeback code, the priority set by ioprio_set()
>>> is ignored. However, an I/O cgroup is associated with writeback requests
>>> by certain filesystems. Hence this patch series that implements the following
>>> changes for the mq-deadline scheduler:
>>
>> How about implement this feature based on the rq-qos framework ?
>> Maybe it is better to make mq-deadline a pure io-scheduler.
> 
> In addition, it is more flexible to combine different io-scheduler and rq-qos policy
> if we take io priority as a new policy ;)

Hi Jianchao,

That's an interesting question. I'm in favor of flexibility. However,
I'm not sure whether it would be possible to combine an rq-qos policy
that submits high priority requests first with an I/O scheduler that
ignores I/O priorities. Since a typical I/O scheduler reorders requests,
such a combination would lead to requests being submitted in the wrong
order to storage devices. In other words, when using an I/O scheduler,
proper support for I/O priority in the I/O scheduler is essential. The
BFQ I/O scheduler is still maturing. The purpose of the Kyber I/O
scheduler is to control latency by reducing the queue depth without
differentiating between requests of the same type. The mq-deadline
scheduler is already being used in combination with storage devices that
support I/O priorities in their controller. Hence the choice for the
mq-deadline scheduler.

Thanks,

Bart.
