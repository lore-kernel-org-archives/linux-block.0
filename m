Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65298C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D76214D9
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 08:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BoVWD9Ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393178AbfIXI2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:28:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38278 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbfIXI2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 04:28:04 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so2377302iom.5
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rN+CCFgjkVKfpkBu9it69/0SwXM97JRpAOcW4kIpzI4=;
        b=BoVWD9Ei+4upFvzInWl+wWNqH3L3WMLBfNPHPRYnQWHtbHJmNphgq8YocFrVqAHtRf
         R6iasukQHA7sVYsd14LhpbF1bLPMqNSx4PjGlM6+BdHreaTsrQbO4POGb59vvQSqHyp7
         PkYbG0WOwey19zr/4wbS3P12SXf795gVfhBRBt8ybvn2/A55bMAsl2TUE3ek1dfEL1tK
         oLDqmJQ85s6iD0XldWvWOITuom9MWG2wKWk0WcS5PmB3pbHyQIbFi6hFk4XhWU/bpCct
         89HbWNrY+euZgQlCzL+Y0/yua1XW/pXosymxcCEKH7psIboyrN7rfZtHw9xpT7vggfQw
         yGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rN+CCFgjkVKfpkBu9it69/0SwXM97JRpAOcW4kIpzI4=;
        b=kEH+yjIAJE7eUzMLD/hTDkOgBhShRJiWYluQkhOdmp981hBSSNt0YWhs4lVOuUWSpU
         cAwXAN4QU6zySHto5tu4MfukHsd+gf+s7KBUWkuujIi2EbZxFO8Ercq8UlcP0S4xDTmP
         LKbyxs0t44YShfAlmjJU6xTHbGdLqNWouYDUWCf2FJJsC43SCTrlJ3rHJfPiky1xEEAJ
         6oxVy5rLHx8/ys2wA7BfW9OAK+/fuBjvLxoIA5CGHGGqZXDuDqxYRvFSmSQRBn/yWuYT
         hOt+t04gT2CJvu8z2+ESTnlZ+aA/OIhLhRA5cW8b1wqwsSwiSBojDG+CPsPaoxCwHLx9
         xvZw==
X-Gm-Message-State: APjAAAXzLiiSiccJJ2PCIwQdC606HLK5lOFyrjuMHrdO+Oq9OmVxJtMY
        NQJgN+/msLHln2p1CPC5Dkzt8g==
X-Google-Smtp-Source: APXvYqxi662Z4Bn70WGfxOYR9BgahyryS+CkPCnD//1DLNnyE5xB+ZdcX0sUI4SNFIDJbJgCaRINWA==
X-Received: by 2002:a02:b60f:: with SMTP id h15mr2481697jam.73.1569313683084;
        Tue, 24 Sep 2019 01:28:03 -0700 (PDT)
Received: from [172.19.131.113] ([8.46.75.9])
        by smtp.gmail.com with ESMTPSA id g8sm914450ioc.0.2019.09.24.01.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 01:28:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
Message-ID: <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
Date:   Tue, 24 Sep 2019 10:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 2:02 AM, Jens Axboe wrote:
> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>> structure with a count in it, on the stack. Got some flight time
>>>> coming up later today, let me try and cook up a patch.
>>>
>>> Totally untested, and sent out 5 min before departure... But something
>>> like this.
>> Hmm, reminds me my first version. Basically that's the same thing but
>> with macroses inlined. I wanted to make it reusable and self-contained,
>> though.
>>
>> If you don't think it could be useful in other places, sure, we could do
>> something like that. Is that so?
> 
> I totally agree it could be useful in other places. Maybe formalized and
> used with wake_up_nr() instead of adding a new primitive? Haven't looked
> into that, I may be talking nonsense.
> 
> In any case, I did get a chance to test it and it works for me. Here's
> the "finished" version, slightly cleaned up and with a comment added
> for good measure.

Notes:

This version gets the ordering right, you need exclusive waits to get
fifo ordering on the waitqueue.

Both versions (yours and mine) suffer from the problem of potentially
waking too many. I don't think this is a real issue, as generally we
don't do threaded access to the io_urings. But if you had the following
tasks wait on the cqring:

[min_events = 32], [min_events = 8], [min_events = 8]

and we reach the io_cqring_events() == threshold, we'll wake all three.
I don't see a good solution to this, so I suspect we just live with
until proven an issue. Both versions are much better than what we have
now.

-- 
Jens Axboe

