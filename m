Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C283C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E49861152
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbhJMR76 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbhJMR75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:59:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B0C061766
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y17so604649ilb.9
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lmUYvCfFjKpeQWiUkixenfQjUoqsESpuzMTo6x0QWjA=;
        b=IHSf48VHxH8VE1HavZrOcyFjeoUdom1i+o+TUkrjRQ1ghJCSQfize8jAMTiqlZIMIT
         Aw5xK868p7rUzL2t2Fxr50Id6MMkhindbfoGKwhCPO6I4Se9uNwLy8xhNecpvAOPRJGx
         5T2qNCDRSCo1Gc/hIDTlPNkudjWkB7UsRBzPoO7eLbxWL9DesuvwJmRhL7cjttRh9DmD
         w29/jzgzoUlO3+d110i9PGLRsf31Vh4pTxzM4h2TripT8RzLUHKN5e50ysZqodTgitFh
         U1MaahNOmwQYpZpIPD8pWNPuVvzQvLGte5unMMEsGNzSXwl/2fglLUafFa+v9P64Z8fZ
         qoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmUYvCfFjKpeQWiUkixenfQjUoqsESpuzMTo6x0QWjA=;
        b=QWW08y+Rwkz2At/IZMwBkCddB1jKfG0U1X0l0QACcT68KZJjLGfgYIcME0juZ2xGXQ
         WpTUOJLNaZeDkaUcwOTlTW9BzEYUp7KW+u03FrbDUadW44s/VfoFGKjXd7/hJiC7yOL8
         w7WToHn2vYmSto0atORUITs16vYppQF4SSGnaUzAxTgGWbAlDzTiu5s+XnDFxsRAadE1
         NyLJe5W9cjI3FUAzPkKr7zuNS4V6JGQ9B+Za5rbre7n/5Lca3dNW70G2++kI7lKf8hsL
         5T3kizCFggWxXAiDgkA4moVYdaPoX/RfAn91wvzk6BCbiZgRMYrc+2AKLRuYVW8hvAEH
         UdNg==
X-Gm-Message-State: AOAM5304+EgfTBg9vZQN6Qm9frGmwxo4iUXyT+mQ5r9UikQ5Zwan3Vg7
        HivYe2D4PkCAC491pHFQ/6hIfUJJwmZbmw==
X-Google-Smtp-Source: ABdhPJxfYOiO65muIq5SIWO37kcdwr+H/NfZZPxopN3z9SUKzTLSgcw/P0WYoksy5fSpy5nRhA4u6w==
X-Received: by 2002:a92:d2c5:: with SMTP id w5mr435234ilg.38.1634147872330;
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g13sm92825ilc.54.2021.10.13.10.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
Subject: Re: [PATCH 4/4] block: move update request helpers into blk-mq.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-5-axboe@kernel.dk> <YWcYFywO7J0R4oMb@infradead.org>
 <f55d823f-79ca-67f0-1868-c013d7711fe5@kernel.dk>
 <YWcdXjZPpYvuaJ5O@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2418e448-6df4-ce6e-da2d-99fb7ac41fcb@kernel.dk>
Date:   Wed, 13 Oct 2021 11:57:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWcdXjZPpYvuaJ5O@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:54 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 11:46:40AM -0600, Jens Axboe wrote:
>> On 10/13/21 11:32 AM, Christoph Hellwig wrote:
>>> On Wed, Oct 13, 2021 at 10:49:37AM -0600, Jens Axboe wrote:
>>>> For some reason we still have them in blk-core, with the rest of the
>>>> request completion being in blk-mq. That causes and out-of-line call
>>>> for each completion.
>>>>
>>>> Move them into blk-mq.c instead.
>>>
>>> The status/errno helpers really are core code.  And if we change
>>> the block_rq_complete tracepoint to just take the status and do the
>>> conversion inside the trace event to avoid the fast path out of line
>>> call.
>>
>> It's all core code at this point imho, there's on request based without
>> mq.
> 
> But the errno mapping is just as relevant for bio based drivers.

It's not like they are conditionally enabled, if you get one you get
the other. But I can shuffle it around if it means a lot to you...

-- 
Jens Axboe

