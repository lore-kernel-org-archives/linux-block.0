Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00148CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C7721D81
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NBn6ptFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633133AbfJYQpW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:45:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32868 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633129AbfJYQoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:44:39 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so3184948ior.0
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zm0Wt9tmeF43jjcGuGvd+uwom6rh1GotNz5s3vFhBPs=;
        b=NBn6ptFxLHGd/sb4nsdiAXWE+YmSvdbCPGTI/PAKBsSKnTwSiymObmzbnyL3A7TJqV
         NFp3ZVVdimCpyFzTaeecq/rw/vKBduQD2qk98uhitEmCbIlbO3LjuoRDlOM8vTDJ5YvF
         72farqcKHi4/kAtg/BzgvUNAVqOSL0VwOusCuH7ESgM0/SV0TiT59l6HQI/DJ5t03nM7
         tWi3b7QffFY0dtp4A+CgwSamO5p2hJDLwTe7p4JIa70AZTp9PLNk3lJFGYhuLv11eJMh
         kE5rpedFqhV0yNnJ0KeHxxHkof7cTzcBPVDj9AWcxvM23T4g7aFEz2yBcQNPTuDWwz0d
         PsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zm0Wt9tmeF43jjcGuGvd+uwom6rh1GotNz5s3vFhBPs=;
        b=G4NRLkXozGQhI7yxj7EVIM4JqtnHO6HGY9xdZnIuPzpKPktqa+LAVThOEWEYEYxQBZ
         xL0K7eK1tZ8Euy99s7X6bu3odNkWxzcw8jZXECvw/Yt2H0K4nsZjnl7zjyDeKsam9wnU
         btOi7b6Q6cLz475YIr7+s1TW/e7IV0zS+/GVql+ZquN7Q+CdQns1Ghx4mJK2M7QheHad
         HHrGZpLflIT1S6eS1yq1DJRz9t02x5ZvLDW9pmkCrIWY663UYHbtMVwv1gpq9BQNG0AA
         jfmhsep0vULm29rUsu2DW31+0Uz/dwiZ/I7PT72m+cHGwjN+ZXw68kBX3gFaKgGlgwOf
         3xVw==
X-Gm-Message-State: APjAAAUdNAmTiQCtM/pXh4WBHFHsixCmgP29G9ZPLrKPrxPZYZXnTlgj
        5zWTmO1Us6FOXfY832a9xilJdA==
X-Google-Smtp-Source: APXvYqxGsz8uoLBkU7bCFMAWldnUz0ITxEBRpgcC0UpKerofzgajs3JJOXIqts26r7e8CCWwAjsMvg==
X-Received: by 2002:a5d:8b10:: with SMTP id k16mr2452894ion.69.1572021877607;
        Fri, 25 Oct 2019 09:44:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r13sm417313ilo.35.2019.10.25.09.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:44:36 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
 <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
 <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4e1f03c-e044-b09f-d943-cad3ab5b4969@kernel.dk>
Date:   Fri, 25 Oct 2019 10:44:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <31a7765b-bb6d-985a-454d-d998678100d1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 10:40 AM, Pavel Begunkov wrote:
> On 25/10/2019 19:32, Jens Axboe wrote:
>> On 10/25/19 10:27 AM, Jens Axboe wrote:
>>> On 10/25/19 10:21 AM, Pavel Begunkov wrote:
>>>> On 25/10/2019 19:03, Jens Axboe wrote:
>>>>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>>>>> I found 2 problems with __io_sequence_defer().
>>>>>>
>>>>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>>>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>>>>>> it can be maliciously changed.
>>>>>>
>>>>>> see sent liburing test (test/defer *_hung()), which left an unkillable
>>>>>> process for me
>>>>>
>>>>> OK, how about the below. I'll split this in two, as it's really two
>>>>> separate fixes.
>>>> cached_sq_dropped is good, but I was concerned about cached_cq_overflow.
>>>> io_cqring_fill_event() can be called in async, so shouldn't we do some
>>>> synchronisation then?
>>>
>>> We should probably make it an atomic just to be on the safe side, I'll
>>> update the series.
>>
>> Here we go, patch 1:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=f2a241f596ed9e12b7c8f960e79ccda8053ea294
>>
>> patch 2:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=b7d0297d2df5bfa0d1ecf9d6c66d23676751ef6a
>>
> 1. submit rqs (not yet completed)
> 2. poll_list is empty, inflight = 0
> 3. async completed and placed into poll_list
> 
> So, poll_list is not empty, but we won't get to polling again.
> At least until someone submitted something.

But if they are issued, the will sit in ->poll_list as well. That list
holds both "submitted, but pending" and completed entries.

-- 
Jens Axboe

