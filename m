Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DE2C63697
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2C12222A
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 16:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zeKR4T+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgKSQrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 11:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgKSQq7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 11:46:59 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98388C0613CF
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 08:46:59 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id y18so5890356ilp.13
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2020 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FaAZ3Ie6S4Ojl8IwJ7YfwRCdnjPQtizRhqlrShWzHSw=;
        b=zeKR4T+NvyvQCgl3HJ9IUz0nFCmDPyPffNjPihBKuBviHjsn0NLfJ+KImxOGTviP6F
         iyR45a75WIMB3CcAQZQSAdVIc6Nk8eUTv5NTQODrsvMEoNCPARLgOwJo9TQlBnmY0HpO
         8HSr5ymO22054vQ+v5b73KmecdCR2f0w5h0Ixdza9HZP9/bXhJ/NUvT2ky685QuSPYYB
         95DeZECFTXQPk4mY3iV5K+SRtSp4uRn9Vfw7yuhzGThC0jkfdQ54jZQOMMibMcfQyEcT
         19hlwWMMfDQyMMyeUOEncnr8MKVb2juJnZ+L6Bv8iBNgSavnf5ALf6jTrNlkhnWFXVIp
         6sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FaAZ3Ie6S4Ojl8IwJ7YfwRCdnjPQtizRhqlrShWzHSw=;
        b=nMmKuN5mv9vEcZ4K9QbhOhAShn8r6nbxn5kZCTvKvjEtZaZH+uotF3z6h4RyEz/p5i
         B17im+x5n74/K6fvb2QF7qx+qpfrnW1A2VISEFzOf148aUnwzjiiI8hrKS8Aw811F8io
         HAjSEKp9NOQ2vsSKG18/R3BwoGHt66zn12suwKdHYu9CKixp3LNiwEg01lIdt0CrtYHs
         dpnkPLIMIrhkj7PR7QTkO9VSykTMdiCGJArsP9v3Z6mU+qvQTZ7Uhqy7BzA6UMpbzR7L
         8NtVx0BwaQphL/F0rsy6dL2qadb6AS9TJyZOMt9U2lT75eqa5HspwKwo7ubA2OBTDeIy
         dbKQ==
X-Gm-Message-State: AOAM5335x2/vHGneeh5dGHp8BBomwjccTTtm0kJVbVbqgiYA5LUVduyZ
        +66q+VLzRWLMEFlQr7twH6ToIw==
X-Google-Smtp-Source: ABdhPJxX3WvEa5ao8bfs8kI6M75hJG4I+/QU4VLpOR9ir2ZfnBPp26ILs3ypZw77yzcqFQJX7x4KgQ==
X-Received: by 2002:a92:cb50:: with SMTP id f16mr944655ilq.225.1605804418878;
        Thu, 19 Nov 2020 08:46:58 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o124sm190932ila.62.2020.11.19.08.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:46:58 -0800 (PST)
Subject: Re: [PATCH 0/2] optimise iov_iter
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <cover.1605799583.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b50322d-821f-469e-6f57-072b54e25ef4@kernel.dk>
Date:   Thu, 19 Nov 2020 09:46:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1605799583.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/20 8:29 AM, Pavel Begunkov wrote:
> The first patch optimises iov_iter_npages() for the bvec case, and the
> second helps code generation to kill unreachable code.
> 
> Pavel Begunkov (2):
>   iov_iter: optimise iov_iter_npages for bvec
>   iov_iter: optimise iter type checking
> 
>  include/linux/uio.h | 10 +++++-----
>  lib/iov_iter.c      | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)

Nice! Tested this and confirmed both the better code generation,
and reduction in overhead in iov_iter_npages().

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

