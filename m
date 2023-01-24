Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F1C38142
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 16:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjAXQNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjAXQNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 11:13:21 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57450303CE
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 08:13:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s67so11599270pgs.3
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 08:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtfqHhTP+lTehwv5PrWy5AzKiLBjhVfDlkpxl8gaKEs=;
        b=ZTe9semIpafife+UErjBtEU/c1JD+MhXjSWOSuVWpTXO0HkIb5h7jwc9XNnQHAxOmA
         htJk5fq/oZaoHe3ng8RTcP99i16nnyjxtGaVbsdtindXVDYUM+aqZznjgjZ74f5JyjWA
         2gyaESpr4NqtaVcWzjAeEyR+IinP3tdtLfIKCXU2nufc7/4JEEiZ7/v+rJpnG8aJil0+
         OZ6+17s108g/9ENmxEkd3tYFn/ypqjuiIJp5T4M8nUWdcvpfc58kCCSCfvEH5cS1m5QV
         uY4loHk9JGLAcoRuLCS+EVbWeVDjHItwkhnZjtXptenVvHTkd7/n5DtdI1aQbaI4LlYv
         kw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtfqHhTP+lTehwv5PrWy5AzKiLBjhVfDlkpxl8gaKEs=;
        b=6pfE0yD2FgNzGECWGTT9mafezA+oq2toaixtmfNzm7MIdFHkGrrGiwX7NzOAwhTzb5
         Ro6xgCgxFyIcfx/4o/gPRtba8s24ttmR3KVz47plwRWaOy47t7A52Mc7x98ft+QYAPk+
         cqwYvrNdMI6ffqsxTckA+ERtFtPhUw0jAQaC4RcN3NtC+VyTe9QNVzdnsTsru+Ky29De
         iS5jDKaEWI/1lNBE0hsKfI3HH6t2QBFhuC13QFySJbqKdkWEp+hGcCEE7CeQqYIqBHLb
         IJyxRgJtSawydpZyR0+iv7J1pHm4YwqTiYnPxKkiNPA8iV2lsxVF3zWlxyqVz8FFL+Q1
         f+1w==
X-Gm-Message-State: AFqh2krObEkWTYEpyA79z7EYiiknVjxZsRapJs2t4qYWWvqV54nDe5h1
        Ji5I/hXi0tD7Vi/7qn/GniQA1jbtB+gLEeTv
X-Google-Smtp-Source: AMrXdXvFOtL0Nd3NTZp1NasIjaeFezdo15OtUa662CuASNz1hywHXvKIOYLXrAVRBNO58SvgZarpJA==
X-Received: by 2002:a05:6a00:288c:b0:58d:94b9:6ded with SMTP id ch12-20020a056a00288c00b0058d94b96dedmr7269976pfb.2.1674576799731;
        Tue, 24 Jan 2023 08:13:19 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a13-20020a056a000c8d00b0058db5d4b391sm1869815pfv.19.2023.01.24.08.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:13:19 -0800 (PST)
Message-ID: <2443254b-6a9c-0e46-b157-d698c79ed915@kernel.dk>
Date:   Tue, 24 Jan 2023 09:13:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <BYAPR21MB168890325173FD3A35CB89DDD7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <167f918d-8417-8f3c-e208-5a4cc3004004@kernel.dk>
 <BYAPR21MB168820EEC294D8A951AA20EAD7C99@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <BYAPR21MB168820EEC294D8A951AA20EAD7C99@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/23 9:03 AM, Michael Kelley (LINUX) wrote:
> From: Jens Axboe <axboe@kernel.dk> Sent: Saturday, January 21, 2023 1:11 PM
>>
>> On 1/20/23 9:56?PM, Michael Kelley (LINUX) wrote:
>>> From: Jens Axboe <axboe@kernel.dk> Sent: Monday, January 16, 2023 1:06 PM
> 
> [snip]
> 
>>>
>>> I've wrapped up my testing on this patch.  All testing was via
>>> io_uring -- I did not test other paths.  Testing was against a
>>> combination of this patch and the previous patch set for a similar
>>> problem. [1]
>>>
>>> I tested with a simple test program to issue single I/Os, and verified
>>> the expected paths were taken through the block layer and io_uring
>>> code for various size I/Os, including over 1 Mbyte.  No EAGAIN errors
>>> were seen. This testing was with a 6.1 kernel.
>>>
>>> Also tested the original app that surfaced the problem.  It's a larger
>>> scale workload using io_uring, and is where the problem was originally
>>> encountered.  That workload runs on a purpose-built 5.15 kernel, so I
>>> backported both patches to 5.15 for this testing.  All looks good. No
>>> EAGAIN errors were seen.
>>
>> Thanks a lot for your thorough testing! Can you share the 5.15
>> backports, so we can put them into 5.15-stable as well potentially?
>>
> 
> Certainly.  What's the best way to do that?  Should I send them to you,
> or to the linux-block list?  Or post directly to stable@vger.kernel.org?
> If the latter, maybe I need to wait until it has an upstream commit ID
> that can be referenced.  Also, you or someone should do a quick review
> of the backport to make sure I didn't break something in a path I
> didn't test.

Just send them to the block list, then we have them for when the commit
hits upstream and gives us a chance to review them upfront.

Thanks!

-- 
Jens Axboe


