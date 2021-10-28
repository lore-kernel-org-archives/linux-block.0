Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F8AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1323F61130
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJ1PPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhJ1PPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:15:41 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A648C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:13:09 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 3so7230269ilq.7
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rOp3UXZkmEWHOryY+o6eTPwFDrXJxnlBJxfivTekAlQ=;
        b=BDeOD864OBrYLDDWcx7VOxOklllPkRsNwNGDQFWabQFs/wcXymb3kk7Bxn0atLPWNd
         dSCEF81ZQ+WMJHUAzpbSJMOC1nWWo+F4SoFLW/VBla2d37mRLJ/8K08vkE8MZ5S7DX8F
         7YPM0KzhIenZzZ+mX+VLFsl68OyZTuTrZhvOTWVh7VCAb7k5Ql8sgh+VndlN3+Ztk2+P
         KP7QWM/ojpVzgv3i2BaVp9BLt+j1HgX8UElLT/cFRW8+7VpAcbIn5sqspsnCI6TbLgrz
         wGgNih8vr4idrpRx6rlOlY67w2zTw9Gf6bkXRCuF8UUtzfkUkja4tqw6fQNapQ3ZtIHg
         3Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rOp3UXZkmEWHOryY+o6eTPwFDrXJxnlBJxfivTekAlQ=;
        b=wNwgY3modIyInGLYQy7SAUlsx5cNhsGj6c4dVbIX92nGtkGY8nlRIju2kBtOaPpi8i
         odHjtTJWlUbWI0fXVnVSRyxoKvRLN968AHPx3qQXPNGLEEg74QHZ39PuiaJHDAS2DE5x
         SxLjFoi36GfZGnsoVWJFI78GSaGUAoPz3DPA6Wldqi7sdKlJGXqez8rs+S8A0X8STq8w
         YgFwWDoNyIsVwicQk9CHOm1ATtd3dIqhDNjJcGxCpvUKuKPF+dFVSRyVBmdai4xz1TSW
         la//7vFFKsJ0U8C0RHGZutgbGfrubeHwkjDNnPr7sgPGgui3EXTRrVJi7Ll6F1UKNaRH
         lXCA==
X-Gm-Message-State: AOAM532pXvB/BaqtDg7Gqq0o99aqnds24FWLW405R0ajET6W4W9OhtSM
        hbhVEJW9yuwXxTKxG76jxdBUOA==
X-Google-Smtp-Source: ABdhPJzV8Ul+jWBJZmNN/p3h3iw8JjvQEBxdIC63iZGVzqKIFFuWNrY4xkPKjMipeJNpulFf4jkzWw==
X-Received: by 2002:a05:6e02:214e:: with SMTP id d14mr3680640ilv.241.1635433988980;
        Thu, 28 Oct 2021 08:13:08 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i8sm1855642ilm.10.2021.10.28.08.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 08:13:08 -0700 (PDT)
Subject: Re: [PATCH 0/3] implement direct IO with integrity
To:     "Alexander V. Buev" <a.buev@yadro.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
References: <20211028112406.101314-1-a.buev@yadro.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
Date:   Thu, 28 Oct 2021 09:13:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211028112406.101314-1-a.buev@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/21 5:24 AM, Alexander V. Buev wrote:
> This series of patches makes possible to do direct block IO
> with integrity payload using io uring kernel interface.
> Userspace app can utilize READV/WRITEV operation with a new 
> (unused before) flag in sqe struct to mark IO request as 
> "request with integrity payload". 
> When this flag is set, the last of provided iovecs
> must contain pointer and length of this integrity payload.
> 
> Alexander V. Buev (3):
>   block: bio-integrity: add PI iovec to bio
>   block: io_uring: add IO_WITH_PI flag to SQE
>   block: fops: handle IOCB_USE_PI in direct IO
> 
>  block/bio-integrity.c         | 124 +++++++++++++++++++++++++++++++++-
>  block/fops.c                  |  71 +++++++++++++++++++
>  fs/io_uring.c                 |  32 ++++++++-
>  include/linux/bio.h           |   8 +++
>  include/linux/fs.h            |   1 +
>  include/uapi/linux/io_uring.h |   3 +
>  6 files changed, 235 insertions(+), 4 deletions(-)

A couple of suggestions on this:

1) Don't think we need an IOSQE flag, those are mostly reserved for
   modifiers that apply to (mostly) all kinds of requests
2) I think this would be cleaner as a separate command, rather than
   need odd adjustments and iov assumptions. That also gets it out
   of the fast path.

I'd add IORING_OP_READV_PI and IORING_OP_WRITEV_PI for this, I think
you'd end up with a much cleaner implementation that way.

-- 
Jens Axboe

