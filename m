Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D947CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 14:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA6120684
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 14:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FteJT4cq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfJYOSJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:18:09 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42469 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfJYOSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 10:18:09 -0400
Received: by mail-il1-f194.google.com with SMTP id o16so1968730ilq.9
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HwWQrehnQ6PqS1LXNfK7buSft8cUBtQIORQS/x4zW6I=;
        b=FteJT4cqk55kEwPSubwWqeYHDwFrHlql9PFbTO/R+ySJ1BaB/ZaSVT9Y9QgOVAPdRa
         Jw3mFBrHx39leSkOw+XFl1f0bEHBUme9REQto/rr/Z+lH5xlVDnaT1QCmun622RzlVnF
         +hrnkoYsY6XBRtcPuXumrGA4JDJMA794FGnoBe8AxbRNXz2PudiGu0lc4ltK1n+P7IdW
         xt/cyfmLcWh3CfKp9Lo90lqvU5JmVKuPHTC4SMsl6UWpFFQUIDezWYPPTxgikpJhllCf
         jO2zo1TfaaYQrrff9M04olq19ajq01llgL0W94InmoAveUZr/uiupqrx02oYUqzFIpZD
         iBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HwWQrehnQ6PqS1LXNfK7buSft8cUBtQIORQS/x4zW6I=;
        b=tcqhYIhbYC6hjanbMyLMHfMYz/fecn81EftXFe/ctW+2Mhcx/zPz/qqLHyPhRBJxHr
         RpUe5ZPVh103VpEpkt0KNZrMQAe0JEnfBDn+g960drVDnqsmojvlxPUQ8+kH5/TllV80
         zYFEtgQrL3x3+tMVVNLXw1fmMV7DVyxOyeZZIFJl0PO0jC6Nrwc2wrbaGqFzjIyVZbJX
         N5zM7p2E83z0KtLCYoOpOwbKaMtsYYgH/3IQVu6Wl538IKblo7Zdhqg20DVuPbSsQ1EE
         Y+aZ4irKnOvjDxOUiLsmZhyMljLimmwcfUS6N0DsMgWZKBi1+24kBElb0Ys0TWVBCRrg
         75hw==
X-Gm-Message-State: APjAAAUbZRqoO+O6m+yEPEFbZKpKnlmYnNXMz464Jb1zMNO/lWQEx7PC
        mHOSkYFjPQ8ZfwV7h0PEpwSBa5+jH3oHhw==
X-Google-Smtp-Source: APXvYqy6vL/Lf7GXQ7zcQqKQsFqwqXtUiYLW9EM6eiRT8kLIqDpzdr4xsKe6XOSnqm2+gxqF8pj+0A==
X-Received: by 2002:a92:8746:: with SMTP id d6mr4440653ilm.265.1572013084035;
        Fri, 25 Oct 2019 07:18:04 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c8sm275104iol.57.2019.10.25.07.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 07:18:02 -0700 (PDT)
Subject: Re: [RFC 0/2] io_uring: examine request result only after completion
From:   Jens Axboe <axboe@kernel.dk>
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
 <22fc1057-237b-a9b8-5a57-b7c53166a609@kernel.dk>
 <201931df-ae22-c2fc-a9c7-496ceb87dff7@oracle.com>
 <90c23805-4b73-4ade-1b54-dc68010b54dd@kernel.dk>
 <fa82e9fc-caf7-a94a-ebff-536413e9ecce@oracle.com>
 <b7abb363-d665-b46a-9fb5-d01e7a6ce4d6@kernel.dk>
Message-ID: <533409a8-6907-44d8-1b90-a10ec3483c2c@kernel.dk>
Date:   Fri, 25 Oct 2019 08:18:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b7abb363-d665-b46a-9fb5-d01e7a6ce4d6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 8:07 AM, Jens Axboe wrote:
> On 10/25/19 7:46 AM, Bijan Mottahedeh wrote:
>>
>> On 10/24/19 3:31 PM, Jens Axboe wrote:
>>> On 10/24/19 1:18 PM, Bijan Mottahedeh wrote:
>>>> On 10/24/19 10:09 AM, Jens Axboe wrote:
>>>>> On 10/24/19 3:18 AM, Bijan Mottahedeh wrote:
>>>>>> Running an fio test consistenly crashes the kernel with the trace included
>>>>>> below.  The root cause seems to be the code in __io_submit_sqe() that
>>>>>> checks the result of a request for -EAGAIN in polled mode, without
>>>>>> ensuring first that the request has completed:
>>>>>>
>>>>>> 	if (ctx->flags & IORING_SETUP_IOPOLL) {
>>>>>> 		if (req->result == -EAGAIN)
>>>>>> 			return -EAGAIN;
>>>>> I'm a little confused, because we should be holding the submission
>>>>> reference to the request still at this point. So how is it going away?
>>>>> I must be missing something...
>>>> I don't think the submission reference is going away...
>>>>
>>>> I *think* the problem has to do with the fact that
>>>> io_complete_rw_iopoll() which sets REQ_F_IOPOLL_COMPLETED is being
>>>> called from interrupt context in my configuration and so there is a
>>>> potential race between updating the request there and checking it in
>>>> __io_submit_sqe().
>>>>
>>>> My first workaround was to simply poll for REQ_F_IOPOLL_COMPLETED in the
>>>> code snippet above:
>>>>
>>>>         if (req->result == --EAGAIN) {
>>>>
>>>>             poll for REQ_F_IOPOLL_COMPLETED
>>>>
>>>>             return -EAGAIN;
>>>>
>>>> }
>>>>
>>>> and that got rid of the problem.
>>> But that will not work at all for a proper poll setup, where you don't
>>> trigger any IRQs... It only happens to work for this case because you're
>>> still triggering interrupts. But even in that case, it's not a real
>>> solution, but I don't think that's the argument here ;-)
>>
>> Sure.
>>
>> I'm just curious though as how it would break the poll case because
>> io_complete_rw_iopoll() would still be called though through polling,
>> REQ_F_IOPOLL_COMPLETED would be set, and so io_iopoll_complete()
>> should be able to reliably check req->result.
> 
> It'd break the poll case because the task doing the submission is
> generally also the one that finds and reaps completion. Hence if you
> block that task just polling on that completion bit, you are preventing
> that very task from going and reaping completions. The condition would
> never become true, and you are now looping forever.
> 
>> The same poll test seemed to run ok with nvme interrupts not being
>> triggered. Anyway, no argument that it's not needed!
> 
> A few reasons why it would make progress:
> 
> - You eventually trigger a timeout on the nvme side, as blk-mq finds the
>    request hasn't been completed by an IRQ. But that's a 30 second ordeal
>    before that event occurs.
> 
> - There was still interrupts enabled.
> 
> - You have two threads, one doing submission and one doing completions.
>    Maybe using SQPOLL? If that's the case, then yes, it'd still work as
>    you have separate threads for submission and completion.
> 
> For the "generic" case of just using one thread and IRQs disabled, it'd
> deadlock.
> 
>>> I see what the race is now, it's specific to IRQ driven polling. We
>>> really should just disallow that, to be honest, it doesn't make any
>>> sense. But let me think about if we can do a reasonable solution to this
>>> that doesn't involve adding overhead for a proper setup.
>>
>> It's a nonsensical config in a way and so disallowing it would make
>> the most sense.
> 
> Definitely. The nvme driver should not set .poll() if it doesn't have
> non-irq poll queues. Something like this:

Actually, we already disable polling if we don't have specific poll
queues:

        if (set->nr_maps > HCTX_TYPE_POLL &&
            set->map[HCTX_TYPE_POLL].nr_queues)
                blk_queue_flag_set(QUEUE_FLAG_POLL, q);

Did you see any timeouts in your tests? I wonder if the use-after-free
triggered when the timeout found the request while you had the busy-spin
logic we discussed previously.

-- 
Jens Axboe

