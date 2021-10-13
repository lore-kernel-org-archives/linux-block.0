Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0EBC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 18:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEC560FDA
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 18:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhJMSJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhJMSJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 14:09:13 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02511C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 11:07:10 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a8so628324ilj.10
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Lp8nfZ2U5cfuBvpSOi+LGiRvbwAF9gjDxzlP9ljfsw=;
        b=Ojz7WmDrBisc65S/2u3hXflnAzRWZ1S7nJOzu3JGta6I7FJG1/LU92W7bg2xddqM5y
         YYQgAeESLV+QSvaC4x+iGMLfiP/qno1DmPvmZkHKDwAfMO2kaxmCEqvUBXiGunb9ZdO8
         YJgwlk7MQX/aSShh4rq7DsrQ+2UdxQj3R+sfeTjoIwUyvJY3MpB5x4QJA11cBOc9knM1
         6ChQFuTX5L0tM1JaPFW6zBvAkPP/dqQ89CcP037E/zJZJReTkpUkETdNlFer1TmCtjXR
         eUKHaZRIDePcWuHvPCJaQWJdLuk16stRdZ2dUcQ0SDfZ5HVf7MeQIjaKi49tvsL19N8f
         e5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Lp8nfZ2U5cfuBvpSOi+LGiRvbwAF9gjDxzlP9ljfsw=;
        b=d4yfax3tPMXWV1EeNe0a0pjsB6kJri+XKjJRxiOSDPXdHXhxWF9BCgQEW+KnfUbxPO
         TiLga24mQGAGax0qY2QkTZMAKhq++hMwgMyEyU7IH01XvfM708d79Xdv12BVbtMWeInB
         9W/A2oIEdgzaN0hBVpU8TtJONXQIA1Z/RXfwny9o+7YV2pYs2c3G2U1+fsOkxA1qj4Ox
         B7nUqREex0MSkwHdrDoj+y+ef7Y4kmeOsTUdAXt6WNb87pgMYdHkMeLo133+g3AjNA6C
         HKgh1CBVA0W7YwjPPHHRYLasuJaCE00ffjWFopvJBmwstuJnaj5C+Q0m7sVSIK0ZB3HQ
         LWLA==
X-Gm-Message-State: AOAM5304Z9rybCyvvLpCKmb/9gd+Rw7/SdtzSH8TLVVTnxLomUmX8Kg1
        uISA9EScgYbZQngfybba1Q4bAn5q4tu1ag==
X-Google-Smtp-Source: ABdhPJzwWbibzdoC4/Xyj2UZ0w9DqbqvKpLUmj9BurGkwwCwc27c8U5o+GQ/6EQFuX9J7xSaaGz+cA==
X-Received: by 2002:a05:6e02:190b:: with SMTP id w11mr474300ilu.292.1634148429106;
        Wed, 13 Oct 2021 11:07:09 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w4sm98688ilj.37.2021.10.13.11.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 11:07:08 -0700 (PDT)
Subject: Re: [PATCH 2/4] block: inline fast path of driver tag allocation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-3-axboe@kernel.dk> <YWcV52525ZR6ilwx@infradead.org>
 <ad0cc4dc-1742-87ac-73f7-2d16be37f44f@kernel.dk>
 <YWcd7NzLHv9Qt7Lx@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dfddae28-7ddb-0365-24e0-79aab9351983@kernel.dk>
Date:   Wed, 13 Oct 2021 12:07:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcd7NzLHv9Qt7Lx@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:57 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 11:46:04AM -0600, Jens Axboe wrote:
>> On 10/13/21 11:22 AM, Christoph Hellwig wrote:
>>> On Wed, Oct 13, 2021 at 10:49:35AM -0600, Jens Axboe wrote:
>>>> If we don't use an IO scheduler or have shared tags, then we don't need
>>>> to call into this external function at all. This saves ~2% for such
>>>> a setup.
>>>
>>> Hmm.  What happens if you just throw an inline tag onto
>>> blk_mq_get_driver_tag?
>>
>> I'd be surprised if that's any different than my patch in terms of
>> performance, the fast path would be about the same. I don't feel
>> strongly about it, can do that instead.
> 
> I find the double indirection in your patch a bit confusing.  Not a big
> deal if it is actually required, but if we can avoid that I'd prefer
> not to add the extra indirection.

Tested the variants, and it does seem to be the best one...

-- 
Jens Axboe

