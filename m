Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B6CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 17:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EBD61361
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 17:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhJSRMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhJSRMl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 13:12:41 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD68C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 10:10:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d125so21230631iof.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u1QTaBnY7Bx3/oW7D9ZuY0gJfdSJNFQsm2jE8G8IhYI=;
        b=MMzMCnme8a1D+2tTqfQ5LQ7zAtLDyEAGKS/4tOQ62SGUwTuSqZRXnFdN/xXQ9hSd3u
         du+Rgw5rHPDEuMtZm/jFI8clSFA3uv6CzLpdppeEFfTytwbYYsFFwxMoFMq70KP/CCfh
         GOFjfI3DjFS3y6Q/Iw+ujyLTUKJvDwcUyF78lIR7mvRl1530CcX9VY9eQ+E0dUn7yRw8
         zkQGS3LMLc+KM8wDCdbTQ7JjjNb4XbB9rxgtGZi6LhbniL2f2FmIdqHdep+WMiX8BSfQ
         6eRxELMKBMtrhOGa3tqfD6o6K94rpm28+J+C7rcso0swHatJ2/nVvG/FqosOFAuC2M2Z
         nPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1QTaBnY7Bx3/oW7D9ZuY0gJfdSJNFQsm2jE8G8IhYI=;
        b=EdCzFRqT+N1F1ZLSWrox7/jjn7dkubxUDhcwDF4JEeBEsch2dyizpMaq2PC7hJKU+Y
         1VmrXFTeKJfkMv6acBAVzNdzxMs60ym6Is25JtVggamA8sJrRwJnF/yhUwolYDyoq2fH
         0erx8Lb0sPwqKVR7svocy4nCQQhoOTNkI8nuzgRF3zqf2Tk0MSuw7qK+x/vWa6/3Bhw3
         GECh+G2RkkH6oP+r6rynDancrg1OWJO4Gkjnm/lmHFQgc9cjqz9EG3A/ElGa3kscCxvB
         rOtkkO2tjqykpyniLuDP/FlMBIzmJJ09mNbQY2iw7YQM6IzIbHGiAJICkkTY35tE7zy1
         xTyQ==
X-Gm-Message-State: AOAM532HF5AdKYBcpiFJ3leJx87P9ax822N9cmtXjcdriqsoadqIc1Am
        L1pgGj35cU+usWQB5cK23WJb97kV/H5oAg==
X-Google-Smtp-Source: ABdhPJy9MXCyAJnDoPt02cJR3dYtfbAJbqM/4g5qGntjYNQnW4bd4DVsa1zc5tBviOfioLvO1zZ2CQ==
X-Received: by 2002:a6b:208:: with SMTP id 8mr20121808ioc.46.1634663426104;
        Tue, 19 Oct 2021 10:10:26 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e14sm8679622ioe.37.2021.10.19.10.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 10:10:25 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: don't handle non-flush requests in
 blk_insert_flush
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211019122553.2467817-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3fffc188-106e-8c12-be32-ebbe717444cd@kernel.dk>
Date:   Tue, 19 Oct 2021 11:10:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019122553.2467817-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 6:25 AM, Christoph Hellwig wrote:
> Return to the normal blk_mq_submit_bio flow if the bio did not end up
> actually being a flush because the device didn't support it.  Note that
> this is basically impossible to hit without special instrumentation given
> that submit_bio_checks already clears these flags usually, so we'd need a
> tight race to actually hit this code path.
> 
> With this the call to blk_mq_run_hw_queue for the flush requests can be
> removed given that the actual flush requests are always issued via the
> requeue workqueue which runs the queue unconditionally.

This looks great, thanks.

-- 
Jens Axboe

