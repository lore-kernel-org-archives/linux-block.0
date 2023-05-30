Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902ABC77B73
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 16:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjE3QvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjE3Qu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 12:50:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF9BE
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 09:50:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c304efb8fso23336439f.1
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685465457; x=1688057457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thlNA+UuWKKyy8pZTqyvsqUpo/JiTFe7Xh7JxERMZ40=;
        b=G+rs7+ExcnneR8BbE3EySvbKDR5K+ZX2Ri4FIBqu2kPlvVkPeUPNPloKVvWPEnscrh
         PWtT52bVoSL3WJrcwT8YyXKwin0mNNKDA3PgNKMTsUKpCIiM6Ul4PcP7y2OksfggjiWj
         gOZV9ONj35tEjBXx7i39azg3oZ6ZjTBLwv8kQ7GUB2aPMcBpCjBRAQoPXGUqEeb5KkX4
         rM3xI80KIE0TmgVV5TqPIvZWrmHPBOBv6zqk3MsfP5g0zL+Ki9LRT0AdC8h2SkBBRhWr
         7agI3E08H9L0zT4DRPRv9v/Liv//reEsCJyCzCHBvPG5lV+roxZWjl7IjCs1wVY3sW3z
         /x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465457; x=1688057457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thlNA+UuWKKyy8pZTqyvsqUpo/JiTFe7Xh7JxERMZ40=;
        b=bzkBdYSjP59HLHGsVDiRRJnu+Syhm/TcusmJBDL9uvNY26L7P0BYp4kUTQfV1Srd5Y
         V/Who5EBVrWrcSSbgzHJzAwm8sxP8E4o9gdDl8IG2raEOaBc9qceNF6GFrThbL5zefGg
         3WaxgEjGju96m2u4r/gOvWI5Guwl4YZvt+wJGpA7Qs+hYbUZWWi/AmkWkrKNYN/yj5vB
         ijlL8oatGYG6yg9tg2kx1lKiMk9xR6sr+rduOQMgMrCH/XZyZuB4ZmNz3XLLReUVRQDg
         6rOLT4D49tEyjwoWpq60n7Oh0OHc9ZGz7CnE5rrreOdnjvdW8Y2IIlJBIlNUTCwqNGX0
         IC5A==
X-Gm-Message-State: AC+VfDzbKh3po2vHaLBTP55QLjcvjCVp6E0dF8Ts4aAy91tK/8X5pBM7
        I1NvBwGh9XcD3dcIRqWuH/R1JA==
X-Google-Smtp-Source: ACHHUZ6jo5ahe5aPT0LiWcCj/I9bwL9QTDlnCR5dwxCtNXBP/2xuIbuw+WquGRcAFohxXHsdBHE2+w==
X-Received: by 2002:a05:6e02:1061:b0:32b:51df:26a0 with SMTP id q1-20020a056e02106100b0032b51df26a0mr19937ilj.2.1685465456841;
        Tue, 30 May 2023 09:50:56 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l3-20020a92d943000000b0033ba0b7e926sm746877ilq.31.2023.05.30.09.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 09:50:56 -0700 (PDT)
Message-ID: <2a56b6d4-5f24-9738-ec83-cefb20998c8c@kernel.dk>
Date:   Tue, 30 May 2023 10:50:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
 <ZHEaKQH22Uxk9jPK@moria.home.lan>
 <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
 <ZHYfGvPJFONm58dA@moria.home.lan>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZHYfGvPJFONm58dA@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/30/23 10:06?AM, Kent Overstreet wrote:
> On Tue, May 30, 2023 at 08:22:50AM -0600, Jens Axboe wrote:
>> On 5/26/23 2:44?PM, Kent Overstreet wrote:
>>> On Fri, May 26, 2023 at 08:35:23AM -0600, Jens Axboe wrote:
>>>> On 5/25/23 3:48?PM, Kent Overstreet wrote:
>>>>> Jens, here's the full series of block layer patches needed for bcachefs:
>>>>>
>>>>> Some of these (added exports, zero_fill_bio_iter?) can probably go with
>>>>> the bcachefs pull and I'm just including here for completeness. The main
>>>>> ones are the bio_iter patches, and the __invalidate_super() patch.
>>>>>
>>>>> The bio_iter series has a new documentation patch.
>>>>>
>>>>> I would still like the __invalidate_super() patch to get some review
>>>>> (from VFS people? unclear who owns this).
>>>>
>>>> I wanted to check the code generation for patches 4 and 5, but the
>>>> series doesn't seem to apply to current -git nor my for-6.5/block.
>>>> There's no base commit in this cover letter either, so what is this
>>>> against?
>>>>
>>>> Please send one that applies to for-6.5/block so it's a bit easier
>>>> to take a closer look at this.
>>>
>>> Here you go:
>>> git pull https://evilpiepirate.org/git/bcachefs.git block-for-bcachefs
>>
>> Thanks
>>
>> The re-exporting of helpers is somewhat odd - why is bcachefs special
>> here and needs these, while others do not?
> 
> It's not iomap based.
> 
>> But the main issue for me are the iterator changes, which mostly just
>> seems like unnecessary churn. What's the justification for these? The
>> commit messages don;t really have any. Doesn't seem like much of a
>> simplification, and in fact it's more code than before and obviously
>> more stack usage as well.
> 
> I need bio_for_each_folio().
> 
> The approach taken by the bcachefs IO paths is to first build up bios,
> then walk the extents btree to determine where to send them, splitting
> as needed.
> 
> For reading into the page cache we additionally need to initialize our
> private state based on what we're reading from that says what's on
> disk (unallocated, reservation, or normal allocation) and how many
> replicas. This is used for both i_blocks accounting and for deciding
> when we need to get a disk reservation. Since we're doing this post
> split, it needs bio_for_each_folio, not the _all variant.
> 
> Yes, the iterator changes are a bit more code - but it's split up into
> better helpers now, the pointer arithmetic before was a bit dense; I
> found the result to be more readable. I'm surprised at more stack
> usage; I would have expected _less_ for bio_for_each_page_all() since
> it gets rid of a pointer into the bvec_iter_all. How did you measure
> that?

Sorry typo, I meant text. Just checked stack and it looks identical, but
things like blk-map grows ~6% more text, and bio ~3%. Didn't check all
of them, but at least those two are consistent across x86-64 and
aarch64. Ditto on the data front. Need to take a closer look at where
exactly that is coming from, and what that looks like.

-- 
Jens Axboe

