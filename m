Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A47CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033E861373
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJSTH6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhJSTH5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 15:07:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685DC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:05:44 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so2926816otk.3
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mTZvuPk5p33U4e2lqjhFCtwvus4Zb7UkGXhjMU7TyUM=;
        b=kyfrl7xYKgU8HPMUGrjUVl+4iKdIzBCQWta5q0wya3XsN75OowxkgmEs2exhYmhCKh
         AyDkFBSnTEVv486ZP6SRvbbu/tUBMGMMLCECV3nL+S3HvYpWHPlah+/bYZkhMiLkhHhZ
         bk6vGFJgbRKpc3Y9gnq+tuGk52xesTahMo5gljRhTiwR0vfWcrq7l59/OuaTlEMy18wK
         LGqpOP+sFJh4CcAQ0CmPw1frOZ0lDpjrSuPH7d7qi3vkwow6bKNcEDi6MViscszI3ubL
         fLtxWdOdumRwtN6XfvrDjPeIPzJJVEAJL/S3zl5UKOotmCK/zhk2qatm9grSigB4MtJc
         HMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTZvuPk5p33U4e2lqjhFCtwvus4Zb7UkGXhjMU7TyUM=;
        b=nNyoeOvbbLqhRFf0a8FwUZ/l4PZXT1YVT4ckMf7CxY10n41GT9L19VvwSewIVHRDJH
         HRgttSIN9e3OW/UayTQ1LwF+wkQvZ6oduFZVVM5O/bRbHPXNpeLG907yCgJdPh21Ic/f
         UUBc59Lmh4iHN2qkcN0u1YZ3Mvr9DrPJIFuwpTaECayKlIM9SwF0H4nbXvYRoZLFFOfz
         gemjnYhyw1E2htib9F77EqzwXMBtepulHj8hCu856SHKELVhCao9LiE0qvS5no7gtfVU
         C6zLVtAgCDHCaq/UY4ZEDYc/EWhL1P8roH83U3WF2SlVzuIivOdTb77KX4RJOou5X3ZE
         6rng==
X-Gm-Message-State: AOAM531tE6YJbAqqWmN9uaVVXZqa2oOXG6VF/DNhyj0sTr4bvYqgUj+i
        uLjvYV4t5tD4ngRlnmP6rMxYvyzjNRQjRg==
X-Google-Smtp-Source: ABdhPJyxOei9oBlB+ftYZOm3M+Oi1zFwwIO5or11roiiZSnXSs2j8ctHaWhrc+CqnH1LLw3EJ+Hd9Q==
X-Received: by 2002:a9d:396:: with SMTP id f22mr6814362otf.327.1634670343365;
        Tue, 19 Oct 2021 12:05:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l7sm3151213oog.22.2021.10.19.12.05.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 12:05:43 -0700 (PDT)
Subject: Re: [PATCH] block: improve error checking in
 blkdev_bio_end_io_async()
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <69df4731-3232-eb2a-664d-47d0db381843@kernel.dk>
Message-ID: <eb5f3cf7-4bf3-d7f3-ed7f-cf067410f31b@kernel.dk>
Date:   Tue, 19 Oct 2021 13:05:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <69df4731-3232-eb2a-664d-47d0db381843@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 12:59 PM, Jens Axboe wrote:
> Track the current error status of the dio with DIO_ERROR in the flags,
> which can then avoid diving into dio->bio for the fast path of not
> having any errors. This reduces the overhead of the function nicely,
> which was previously dominated by this seemingly cheap check:
> 
>      4.55%     -1.13%  [kernel.vmlinux]  [k] blkdev_bio_end_io_async

Disregard, ended up being an older test version. I'll send the right
one.

-- 
Jens Axboe

