Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B440C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693FC20835
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 16:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AR1t0EJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfD3QQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:16:03 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:38834 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3QQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:16:02 -0400
Received: by mail-it1-f176.google.com with SMTP id q19so5657990itk.3
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OD9cUVtGMZ8nWjuT5InBrU2Wv9vKngRSovSQaY9v9ag=;
        b=AR1t0EJigdlWLAm1bpe1jBedpB3UAIshTS6z3x7oKe+a4UkX0sw8lvHtH7+J9INbtq
         9nOOS/UNdWY84ePUPVQpAbcdOIEbQ+2Gl9V75TKaS/amKt1/M9gZTWDLA887JAfaGUDf
         k5Ux5uktNtO8tLWu1RuUqsVmEcIk3RHCLQ4BilV+BTieMjEHVM9RNuhYUtexjiXSZr1J
         21i2rhgUKbKG7ltDOmAGOGU7HPeEd+RoDJsPExaiymWDpSgs+BB9RHA1y1csxKmgF9XS
         iy3D4A+8tIR9kYvAp8+ksXQsMbM4P3zKqV5FZ7HxD+Zme/mCZ2F7p2E+z4crVlALIum/
         DCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OD9cUVtGMZ8nWjuT5InBrU2Wv9vKngRSovSQaY9v9ag=;
        b=pzBdOBMfjblz84Uv1dNbUAYet32DkoOFMH0/WpePq0JpPoQBlIJdQTnS6iS5gHHAZL
         Qvah026zmerhp27UHRVVGd9JYo3wS9tEyK30E7rvY32wp3ScK15uJybc3oE26tlngoRa
         3Wucm166EKGAk4aDovsrlAUS5dJ4LZWkDB9ywQyXq+wJwPAxFPBARPpfz3TfSD+hZ8te
         V8vVmVtVJftdKp7nHFPw1QlqfMeWDiyhkjBtMipFWvfmfTL1XBqYmG5Kr5UmUfcZSLFK
         lyvQBiGF84vYsGYyVMNY6HTV1TFK4B5WhMSyXo18LUT+xeElJypNWS37x1gbPXZ0k0zR
         av/g==
X-Gm-Message-State: APjAAAUk7WiWkvZICIe3RH15U+GWDNZTWwFGGH5ahwApKiZatOV5ouMp
        GweJ/jhP5odvEXu/ArExADF+bw==
X-Google-Smtp-Source: APXvYqwkIpfQeZGKskqHrEpU0VnfF17rCLM0fAMMJO2Dh+a53wrey/ZhXzWdo0xFDEbRozJHmaHGLQ==
X-Received: by 2002:a24:274e:: with SMTP id g75mr4005402ita.34.1556640961643;
        Tue, 30 Apr 2019 09:16:01 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 125sm1715130itx.21.2019.04.30.09.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:16:00 -0700 (PDT)
Subject: Re: io_uring: submission error handling
From:   Jens Axboe <axboe@kernel.dk>
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
 <66fb4ed7-a267-1b0b-d609-af34d9e1aa54@stbuehler.de>
 <8ce7be42-4183-b441-9a26-6b3441ed5fef@kernel.dk>
Message-ID: <4fe4bfb0-81a8-82da-66a2-ffe6fd972a7b@kernel.dk>
Date:   Tue, 30 Apr 2019 10:15:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8ce7be42-4183-b441-9a26-6b3441ed5fef@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/19 10:02 AM, Jens Axboe wrote:
> On 4/27/19 9:50 AM, Stefan Bühler wrote:
>> Hi,
>>
>> On 24.04.19 00:07, Jens Axboe wrote:
>>> On 4/23/19 2:31 PM, Jens Axboe wrote:
>>>>> 1. An error for a submission should be returned as completion for that
>>>>> submission.  Please don't break my main event loop with strange error
>>>>> codes just because a single operation is broken/not supported/...
>>>>
>>>> So that's the case I was referring to above. We can just make that change,
>>>> there's absolutely no reason to have errors passed back through a different
>>>> channel.
>>>
>>> Thinking about this a bit more, and I think the current approach is the
>>> best one. The issue is that only submission side events tied to an sqe
>>> can return an cqe, the rest have to be returned through the system call
>>> value. So I think it's cleaner to keep it as-is, honestly.
>>
>> Not sure we're talking about the same.
>>
>> I'm talking about the errors returned by io_submit_sqe: io_submit_sqes
>> (called by the SQ thread) calls io_cqring_add_event if there was an
>> error, but io_ring_submit (called by io_uring_enter) doesn't: instead,
>> if there were successfully submitted entries before, it will just return
>> those (and "undo" the current SQE), otherwise it will return the error,
>> which will then be returned by io_uring_enter.
>>
>> But if I get an error from io_uring_enter I have no idea whether it was
>> some generic error (say EINVAL for broken flags or EBADF for a
>> non-io-uring filedescriptor) or an error related to a single submission.
>>
>> I think io_ring_submit should call io_cqring_add_event on errors too
>> (like io_submit_sqes), and not stop handling submissions (and never
>> return an error).
>>
>> Maybe io_cqring_add_event could then even be moved to io_submit_sqe and
>> just return whether the job is already done or not (io_submit_sqes
>> returns the new "inflight" jobs, and io_ring_submit the total number of
>> submitted jobs).
> 
> I think we are talking about the same thing, actually. See below patch.
> This changes it so that any error that occurs on behalf of a specific
> sqe WILL trigger a completion event, instead of returning it through
> io_uring_enter(). io_uring_enter() can still return -ERROR for errors
> that aren't specific to an sqe.
> 
> I think this is what you had in mind?
> 
> Totally untested, will do so now.

Seems to work for me, just needed to adjust the -EAGAIN test case in
liburing.

I forgot to mention, but this will still stall the submission sequence.
Before, if you wanted to queue 8 sqes and we had an error on the 5th, we'd
return ret == 4 and the application would have to look at the sqring to
figure out what is wrong with the head entry. Now we'd return 5, and
have a cqe posted for the 5th entry that had an error. The app can then
decide if it needs to do anything about this. If it doesn't, it just
needs to call io_uring_enter() again to submit the remaining 3 entries.

I do like this change. Any error on an sqe will result in a cqe being
posted, instead of having the submission be slightly different and have
the cqe be dependent on where the error occurred.

-- 
Jens Axboe

