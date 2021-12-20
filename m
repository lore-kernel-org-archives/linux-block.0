Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 20:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhLTUY4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLTUYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 15:24:54 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CE6C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 12:24:54 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e128so14971805iof.1
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m7aZ/r7KUOStH1ivBEoA3MsrYxmQznvOXwwCnQ4/VzY=;
        b=o1+/fs4ufV7cupeSZnM22YLRt0ngrla8EjIuThN/nzfSrf4A5aPqWKI791G4aZlBNK
         prFq7gRhxoajiEEKFLmMObjzVT7rnKwmvEDMdggp9+38bDB9JN9DKGZyzoEvnO+Ov0T8
         1k+JVJDrnkRanxLbE97gFxh40DIvS0WwY9VlXyTy4Y1DCf+82i/liNE8DBuaMQBunW5K
         2GvWtqFCtQjgkaNJvvqB8WVis9p41g1gaoFdIHFEMQtecSkuOUcSy+v/tzvrTRuWnacL
         w8pCwooAlciGn/ScS8oc3hckVUqw1ARXwz8YAPr3rbgxZaM8jNkvL4Ceaexwn1nkbBoA
         hvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m7aZ/r7KUOStH1ivBEoA3MsrYxmQznvOXwwCnQ4/VzY=;
        b=ffaH8H4g+Lc4ply+w/iul7ekPau9NnNZxdUEFJLrOClJszZ4LlmFMsIWQpo7sNDCHF
         RXWKCrFiWax5LIZzN9yhZFk/OrH+UwHsGfQb1DHsejW8UxEOBOOEer/ckXskAAt/FWab
         zXNy5nuWf/103Tq6l1i9j84PUiPz2p11WXeYQkv2AAUCtgKcu2URuXIlpW7a3NA9lPRA
         5EAu3o61hKsIBSG08GHyT4QlFyOQHSSSFYBrNBxvcXWxz4GEkskoHBa2OuDj0IpIjXEy
         w+mdg+wuJWYavmB2dMeWTLegNAB6plE6SpW7EMsZQHtiewo2UEOjokoZIKjVGAxfjXk/
         7/EA==
X-Gm-Message-State: AOAM532GJuGWVbtjxNWDOfR4IwCQ/4bHhW5pEEMkk/x+VKCOLEJlGv3B
        7h7EwBwLpfujkAmb3OoSB8LLhQ==
X-Google-Smtp-Source: ABdhPJzE4GpfqSszafQNZh5VE1wEYS+ilM68EHjaWP4KvcahVlb1ZrGdzMqh5cSSxxQSGHg/iSZLTA==
X-Received: by 2002:a02:c90e:: with SMTP id t14mr2567117jao.288.1640031893554;
        Mon, 20 Dec 2021 12:24:53 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h15sm1884133ili.55.2021.12.20.12.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 12:24:53 -0800 (PST)
Subject: Re: [PATCH v5 1/1] blktrace: switch trace spinlock to a raw spinlock
To:     Wander Costa <wcosta@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20211220192827.38297-1-wander@redhat.com>
 <8340efc7-f922-fb8c-772c-de72cefe3470@kernel.dk>
 <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b07b97b4-dff2-5915-ce56-a039a14a74dd@kernel.dk>
Date:   Mon, 20 Dec 2021 13:24:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAq0SUn_Nru1NTyzgjB9ETsaM46bgDRf3DTa+Z9sG-c8yjuQdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/21 12:49 PM, Wander Costa wrote:
> On Mon, Dec 20, 2021 at 4:38 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/20/21 12:28 PM, Wander Lairson Costa wrote:
>>> The running_trace_lock protects running_trace_list and is acquired
>>> within the tracepoint which implies disabled preemption. The spinlock_t
>>> typed lock can not be acquired with disabled preemption on PREEMPT_RT
>>> because it becomes a sleeping lock.
>>> The runtime of the tracepoint depends on the number of entries in
>>> running_trace_list and has no limit. The blk-tracer is considered debug
>>> code and higher latencies here are okay.
>>
>> You didn't put a changelog in here. Was this one actually compiled? Was
>> it runtime tested?
> 
> It feels like the changelog reached the inboxes after patch (at least
> mine was so). Would you like that I send a v6 in the hope things
> arrive in order?

Not sure how you are sending them, but they don't appear to thread
properly. But the changelog in the cover letter isn't really a
changelog, it doesn't say what changed.

-- 
Jens Axboe

