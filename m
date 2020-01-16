Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F7C33CAF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 20:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55C62064C
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 20:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ieSfAt4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAPUCi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:02:38 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35514 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgAPUCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 15:02:37 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so2163712pjc.0
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2020 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9m+rC+oUDolU1XALd3i8OyKuH4mxh+m2TciQNEVn8O0=;
        b=ieSfAt4ECnxqa8cYWLvKBJN7d7uKIygQjPqx/MZS2YAX0XTkQAr1lJ8IWiXtUl8nD+
         u9HRJDekI1Dp+FRWxoquVQOWKhQELaw8zvPWy9gJN+hG86BWvUNRlF3XB8N5ncbxJZTT
         gHdZurBQ/OwpmzRfUPVxHtvFPksBq/OgZ0pMypB1A6sn3DADO7gA325jB/kV3sai1NOs
         tUGg1MyBzFVELB39jNnTksHPdHXsh7fcoBFAA53DirIlby0cbxVZFTtnubihNWC0wzpU
         HQbRyYhG4AhorZRHB7f0XjELPLiXoNeXMVIV9rSwmtzK5C9VWddHYc8ueOt0h1Q0sW8W
         c0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9m+rC+oUDolU1XALd3i8OyKuH4mxh+m2TciQNEVn8O0=;
        b=Zb2C6e1Isco41gFYo7nLCTOT34em3QoPs+/yiwmKFbTpmGM8XW6WcM8/yJmiUMgjLN
         1OCFURSoYML6HwWM1xXceAwJ78RYsg+bM9q/vPSDWuKao8YqO5tyw8J6d8dBKwuyxFcM
         5ErlElzwREQwCdxT4ZIBBvLk3jvEaqYf/O7cu4oH5pKMacbUgDZ7Jr0bSfJoJZqioDWu
         P7q7UYB0kbohxnX2x7LIyYVQ076YVU3qAI8zmxNG8Zo9OlXW1S4EOSWpxgforVONiZoZ
         ZpPiP1uzaBh41bh8hkCRRndBNT0wQY3fnav0A7tLH9uWOKi+U9yG1dPNLtc3W+dPd8D+
         IRcQ==
X-Gm-Message-State: APjAAAVdUxqxIFJ69UjRvSRSdy7X1ms0elzAyTFSYwm4L3wac8HO9hML
        nWUEn0Q65EjLdeqhl+6ez0UvMw==
X-Google-Smtp-Source: APXvYqwspA/ISVxq7O+kTNMHPp/+Ds3gQg1UEVb7NDrnymuJaIe3jmDH6uqM0kJudwXVbwaNhIeTgg==
X-Received: by 2002:a17:90a:cc04:: with SMTP id b4mr1059251pju.136.1579204957167;
        Thu, 16 Jan 2020 12:02:37 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1132::1012? ([2620:10d:c090:180::ab9])
        by smtp.gmail.com with ESMTPSA id d22sm26131500pfo.187.2020.01.16.12.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 12:02:36 -0800 (PST)
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@gmail.com>
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
 <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
 <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
 <b43835cd-3bd6-705e-df51-923bbec78c67@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <18346d15-d89d-9d28-1ef8-77574d44dce7@kernel.dk>
Date:   Thu, 16 Jan 2020 13:02:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b43835cd-3bd6-705e-df51-923bbec78c67@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/20 12:08 PM, Bijan Mottahedeh wrote:
> On 1/16/2020 8:22 AM, Jens Axboe wrote:
>> On 1/15/20 9:42 PM, Jens Axboe wrote:
>>> On 1/15/20 9:34 PM, Jens Axboe wrote:
>>>> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>>>>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>>>>> so acquire ctx->uring_lock beforehand similar to other instances of
>>>>> calling io_issue_sqe().
>>>> Is the below not enough?
>>> This should be better, we have two that set ->in_async, and only one
>>> doesn't hold the mutex.
>>>
>>> If this works for you, can you resend patch 2 with that? Also add a:
>>>
>>> Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")
>>>
>>> to it as well. Thanks!
>> I tested and queued this up:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.5&id=11ba820bf163e224bf5dd44e545a66a44a5b1d7a
>>
>> Please let me know if this works, it sits on top of the ->result patch you
>> sent in.
>>
> That works, thanks.
> 
> I'm however still seeing a use-after-free error in the request 
> completion path in nvme_unmap_data().  It happens only when testing with 
> large block sizes in fio, typically > 128k, e.g. bs=256k will always hit it.
> 
> This is the error:
> 
> DMA-API: nvme 0000:00:04.0: device driver tries to free DMA memory it 
> has not allocated [device address=0x6b6b6b6b6b6b6b6b] [size=1802201963 
> bytes]
> 
> and this warning occasionally:
> 
> WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
> 
> It seems like a request might be issued multiple times but I can't see 
> anything in io_uring code that would account for it.

Both of them indicate reuse, and I agree I don't think it's io_uring. It
really feels like an issue with nvme when a poll queue is shared, but I
haven't been able to pin point what it is yet.

The 128K is interesting, that would seem to indicate that it's related to
splitting of the IO (which would create > 1 IO per submitted IO).

-- 
Jens Axboe

