Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD3CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 02:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiAJCtW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 21:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiAJCtW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 21:49:22 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DDC06173F
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 18:49:22 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id f4so1674993ilr.9
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 18:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SYjbc9YYGpZpwn6PMZ939GUGrTWE9ByU0UkYcwqJU+I=;
        b=Sfn5gIBRJ1Z3/kVl/Q80oHgJmZ3Z0mQcir2zd1hyOGFgtZdpkFLt1ZQxpUyanNWdHY
         RWhqhgVfS7wGXWjekXZDgoVAOG24NVZZ43FTFicoxxIVF94N5LgAoRSqy3RD4Nu0DgcO
         mo/7KMlBtQs9jQCy5VpLsa8H/QsrIJiM/iPgnpHLfi9MI2ueZ4EgEFFNJnSO4/57ay5P
         sb8hwFnwHNxVvzAzY01lm0ocwkSQOWT3g5z2CW8B8pc/otKMjVEihnzcryfPkKseHzQj
         weeIYc8kqIlsMD8pXk6rONGgvfLZeyUrMTVyDZmAt0MbcamSQPzWdo84YqYYZJdOm4G0
         SdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYjbc9YYGpZpwn6PMZ939GUGrTWE9ByU0UkYcwqJU+I=;
        b=SWRU+hDG2cFv3+vvQHHiKUjV2F7YAE0TmlrjcXOjJYiJEcunAEm5DKJhCYMrKlG1i7
         ag7T0revrZoHhNXses+WsPalXmmafzM2E10zXmAFps/0Wzd0R0n/JvlYHkgRTz0vR4ZQ
         YWxh+O+5e/jeTr1FWzYnTpbvG8HDAESN+Dvo1h601TaEzFaii8sgcxuZrabyfJggtKr/
         UxNKIeFDOTlzKaThLtGeU5rzB4xRnsFdLkA12s2jzj1G1KXg+RAGlVoyDdY8Zdp4Mia2
         QSuumBiO4NvaZQbZK3n2NIox3uLdtSEqDnZ8prIMjxRtMAdwu93M6k/srNyyQAjjF+h5
         4gqQ==
X-Gm-Message-State: AOAM531mrk2EQih4ProX7c42Uu7TJT6Rlh1KPihsIlYkefm7MvNCkHD9
        LL2VkCarTPElaWChqZprCGlWXS1eglQFxA==
X-Google-Smtp-Source: ABdhPJyXlFS2bvZ/LEnW1LdEd1lxj2O9wAT+/7bOnj6vP/9q9z4Pyjy9yMDdPVQ0F7S8AbYX3zgVww==
X-Received: by 2002:a92:6802:: with SMTP id d2mr4902617ilc.75.1641782961408;
        Sun, 09 Jan 2022 18:49:21 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g5sm3649318iok.52.2022.01.09.18.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 18:49:21 -0800 (PST)
Subject: Re: [PATCH] lib/sbitmap: kill 'depth' from sbitmap_word
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
References: <20220110015007.326561-1-ming.lei@redhat.com>
 <020ba538-bb41-c827-1290-c2939bf8940c@kernel.dk> <YducMfW4vhk15CMq@T590>
 <8e24bd70-a817-ff8d-c59a-3e998e5cb869@kernel.dk> <YdueWjYzHVP1bkU0@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <58ca024e-523b-cde8-f809-fbf4eefcc4dc@kernel.dk>
Date:   Sun, 9 Jan 2022 19:49:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YdueWjYzHVP1bkU0@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/22 7:47 PM, Ming Lei wrote:
> On Sun, Jan 09, 2022 at 07:43:26PM -0700, Jens Axboe wrote:
>> On 1/9/22 7:38 PM, Ming Lei wrote:
>>> On Sun, Jan 09, 2022 at 06:54:21PM -0700, Jens Axboe wrote:
>>>> On 1/9/22 6:50 PM, Ming Lei wrote:
>>>>> Only the last sbitmap_word can have different depth, and all the others
>>>>> must have same depth of 1U << sb->shift, so not necessary to store it in
>>>>> sbitmap_word, and it can be retrieved easily and efficiently by adding
>>>>> one internal helper of __map_depth(sb, index).
>>>>>
>>>>> Not see performance effect when running iops test on null_blk.
>>>>>
>>>>> This way saves us one cacheline(usually 64 words) per each sbitmap_word.
>>>>
>>>> We probably want to kill the ____cacheline_aligned_in_smp from 'word' as
>>>> well.
>>>
>>> But sbitmap_deferred_clear_bit() is called in put fast path, then the
>>> cacheline becomes shared with get path, and I guess this way isn't
>>> expected.
>>
>> Just from 'word', not from 'cleared'. They will still be in separate
>> cache lines, but usually doesn't make sense to have the leading member
>> marked as cacheline aligned, that's a whole struct property at that
>> point.
> 
> OK, got it, it is just sort of code style thing, and not any functional
> change.

Right, it's more of a cleanup. It would be a bit misleading to have
it on the first member and thinking you could rely on it, when
external factors come into play there.

> Will include it in V2.

Thanks!

-- 
Jens Axboe

