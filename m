Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A1EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 17:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGURaG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjGUR36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 13:29:58 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4D30FF
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:29:48 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so29023239f.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689960588; x=1690565388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fa35+IuDPnWHknqU4Xwm+U5o9OlhfD5dgRx/XluS+U=;
        b=Bb9afUAtiESD/R2DIlvTETL95pi4Qxfn2EUvccRt5r2MNrG01ihv5pnyBJzGqkUnxU
         yIG1DfMeoZ72tIak9k3HZ6fS4r4s+1QqteuoqqSRqPZnaRGqEfTWSsZENfZYhfJ8xt2E
         opBSwHlGLoUKJqM2+LRT3I4goSrZ7kkKFUFYM38dVN/2GJMxGZhl64hGCApNDy0wqs99
         7hSAHnWDo1MbieC3uNwAVsOtX8G3m95bOZL2I0wSb7iQ9whIEQnEE6r+fw4EuRErBedk
         wJYi+luRiKeJJlwQsOSUDjq4FjqTkrbQGQqJ48cwalaBXT3k9Qd5no3wk+7rTQNP4nMC
         T0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960588; x=1690565388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fa35+IuDPnWHknqU4Xwm+U5o9OlhfD5dgRx/XluS+U=;
        b=gbaRX5AIphakKfBW4GYM713fuqSP9JAgvOOpTiGQLj0yhaOViEOx/iL8NjxxAQYROx
         zFTJimwFSYkM+rII/z/UaXEP3QU8Xe8Acfd4f+2N7lBpCQRRzPJnR8UAL3+tcotVwGK7
         +A9NbhQ8awhVU/W07dsRX42zhiqJf9WOPqkct66OE9BtRle/QdoUsaDcYp6Egbay4Ku7
         g9a2zwndT4fVqCPhNncIx245KtkPsQ8+55i2M2IlywrCWbdLg8uE4H2yQEvxLEVoSJ61
         WnwC9GozNQShRd81srg1LRgamJLqKe+ycyWJEAOJ5d1ve+iNJ+tK13L9TqbWwMJoXfLx
         YdIQ==
X-Gm-Message-State: ABy/qLb2pHFwlWLm7VzAbyAI2sHBEiOdf4Np+4FbwyQCP3wp4FH+r1xl
        j4D3n0/LjCf/Er1uvyf4cxOfpg==
X-Google-Smtp-Source: APBJJlExD0fwhnCdUZHxftddx+4NLpXXD55UqzTN4lEVs4zToi1LPd8oE16KcO7qp4rvL+B6KqgjEg==
X-Received: by 2002:a05:6602:381a:b0:783:6e76:6bc7 with SMTP id bb26-20020a056602381a00b007836e766bc7mr2547822iob.2.1689960587884;
        Fri, 21 Jul 2023 10:29:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d858c000000b00786450bb4edsm1194041ioj.35.2023.07.21.10.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 10:29:47 -0700 (PDT)
Message-ID: <22e2fcc4-5b42-2fd2-ab07-d77c31de8304@kernel.dk>
Date:   Fri, 21 Jul 2023 11:29:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>
References: <20230721095715.232728-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230721095715.232728-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/23 3:57?AM, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> Current code supposes that it is enough to provide forward progress by just
> waking up one wait queue after one completion batch is done.
> 
> Unfortunately this way isn't enough, cause waiter can be added to
> wait queue just after it is woken up.
> 
> Follows one example(64 depth, wake_batch is 8)
> 
> 1) all 64 tags are active
> 
> 2) in each wait queue, there is only one single waiter
> 
> 3) each time one completion batch(8 completions) wakes up just one waiter in each wait
> queue, then immediately one new sleeper is added to this wait queue
> 
> 4) after 64 completions, 8 waiters are wakeup, and there are still 8 waiters in each
> wait queue
> 
> 5) after another 8 active tags are completed, only one waiter can be wakeup, and the other 7
> can't be waken up anymore.
> 
> Turns out it isn't easy to fix this problem, so simply wakeup enough waiters for
> single batch.

Change looks good, but commit message needs:

1) Signed-off-by from author
2) To be wrapped at ~72 chars, it's got lines that are way too long.

I can edit the commit message, but David does need to reply with his SOB
before it can get applied.

-- 
Jens Axboe

