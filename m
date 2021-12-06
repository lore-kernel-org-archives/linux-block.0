Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D661DC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245724AbhLFQfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbhLFQfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 11:35:37 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED2C0613F8
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 08:32:08 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p65so13656559iof.3
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Y4lyaJ5nbN10xflcSf3Q96TrBlRvjDKp8bmE0H7ZD8=;
        b=cstV5U6FB9VcgqZDfsWLYPI+g6MFYsF57ljtuHPM2UZdRTQshW6MRBmf+I13iGstl2
         GerEDP0MTYcYufhvkY12nglK3G/TOnmnxmDPAMpMxvRgdBKtJhf2pdr+TPV1so2di9CR
         2lsqr3Mk27LtA2WRk9XQ2alifjAhRq6c+IAGbVQAJWl03CsXLJ469F5raFLOaDUbtmuu
         niS546AhwL8WKXwOM74+bC1q5Fzm9yoWJNttvu0LDGy9jniByhez3K3RumT+PllLQw+H
         HJ1i+T7VLARNs22VYi0WPwhT6BmNGGnk77yjnVgglHhw+APcCsOECmOrMmRFFGAYW5ON
         GyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Y4lyaJ5nbN10xflcSf3Q96TrBlRvjDKp8bmE0H7ZD8=;
        b=cGwyQ5b/skQrKcXMRufzyKknLoXNxP7GVclEz/v+fMWu0rON93uSuM1/vRrjWOzhMz
         KfXY85h/rQx8q1N4E49vfMrAyL5+jOx41wkWwg0Zw1YL71l4O2QK2kd3JA3aikH+5J0V
         taAMRYkwXx+lzx6Li4CS7rOzwyXlPAU7otWQNGgetHSxtefSv5zATRNqkiFT8A0J04bs
         pMJ81VfTzzV+cP/n4dPZSNzM4zNizR+rDVMkEz00eDQrlUKFu7Nz3jsBKATu/EQMup4t
         95VRHVN+ddVfXVnQmEZvDGaWQghRIlpLUe0idZP2JtsvmaejN0NvsJTawoc+Ql50UHQT
         1YeA==
X-Gm-Message-State: AOAM5315Uyq5rNibC8n4ydUZooUgFWuVDXJTuDCe9JnRYK6IpXFBOXSh
        VrvhW65hgSh8ETJXAXm7iLq99w==
X-Google-Smtp-Source: ABdhPJzSYpew8PAie7r3HH0URoXPsBCTNuQlGQo6oEgGxQG2Fp92tH0Mp3QVQRmQpQ+Ws2s4IqxQlg==
X-Received: by 2002:a05:6602:2b89:: with SMTP id r9mr34618746iov.32.1638808327752;
        Mon, 06 Dec 2021 08:32:07 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x18sm7678292iow.53.2021.12.06.08.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:32:07 -0800 (PST)
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dbe2b14c-5f0a-80dd-b661-d0a7c74ba230@kernel.dk>
Date:   Mon, 6 Dec 2021 09:32:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/21 1:31 AM, Peter Zijlstra wrote:
> On Sun, Dec 05, 2021 at 10:53:49PM -0800, Christoph Hellwig wrote:
>> On Fri, Dec 03, 2021 at 08:35:40AM -0700, Jens Axboe wrote:
>>> refcount_t is not as expensive as it used to be, but it's still more
>>> expensive than the io_uring method of using atomic_t and just checking
>>> for potential over/underflow.
>>>
>>> This borrows that same implementation, which in turn is based on the
>>> mm implementation from Linus.
>>
>> If refcount_t isn't good enough for a normal kernel fast path we have
>> a problem.  Can we discuss that with the maintainers instead of coming
>> up with our home grown schemes again?
> 
> Quite; and for something that pretends to be about performance, it also
> lacks any actual numbers to back that claim.

I can certainly generate that, it was already done for the two previous
similar conversions though.

> The proposed implementation also doesn't do nearly as much as the
> refcount_t one does.
> 
> Anyway refcount_t is just a single "lock xadd" and a few branches, where
> does it go wrong? Do you have perf output to compare between them?

I'll generate that.

-- 
Jens Axboe

