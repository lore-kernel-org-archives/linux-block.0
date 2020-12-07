Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77241C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 23:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE4E239D0
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 23:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgLGXxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgLGXxk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 18:53:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65527C061749
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 15:53:00 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so12026835pfg.8
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 15:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uqN9V2jxlygnfanQe3waojlzBF5+E+JksEMAcbaS3g8=;
        b=U8Oun/PQxLKLt+cp3gMgoW77xiJCxiZbIJMs0Lp3Q6L7N/9Mi6HxH3lROZ0RPM5LOm
         SFcGBChIoCyJEtY1+w7AyxmhG0mpZUKDmKLnBZfBtsRzBJlalnVLfx1mIO9mI0Ag1tLA
         4BjifoV2UJjHSiaMNo+LJy1xxg8ss26f0Q4tUsknUiA0JVVwIh4WGiKHwqtgRRG1Xj+R
         5gsHc6iBjZbr8I8FKrkDht9np2FEPRxxuMiUxOMRM5a2mv4w4GKj4Lpz2n91qZpZ/LUK
         cdWzhevmM/77FioQtJZs5F8VakbWIHTkdsTnlKKhVEOKWDeACymG+3lJDWQCVncWvoZS
         J79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uqN9V2jxlygnfanQe3waojlzBF5+E+JksEMAcbaS3g8=;
        b=XZD80Bf6x0dCLpxq9YcRQY5ACNPj2UHot+QhQi4cNepazvBYO3c7wk6Gt0pdlxqZxJ
         7SoKFHEDt3NoTrulMR4Eb/wyySOGau/hG3wzfo+a/uK3xak1ag7fDiiRzL2HTObp0VWP
         ldernAyuOnIItie1+Y4ydxabI/F6iwwozGbbSrx4KTTnYWtcz7SsE0XFRGZeBRYDlUib
         Bj6Bay2yLptr0lYyXC9J659cVwahN8Pi8wNQ967enZCYnII+AO3cazZmd+pmq3BY6yiE
         BRkJl0Yg4hTrmMxkvJMw4t4fjB/gRAjyameNA0NeUjJSW4ZYWKlC+oEFTdSnXJxgqD7j
         wkBg==
X-Gm-Message-State: AOAM532cMqnykUk1VGnLTs1pFg1OwGzb9oY968x9WS1yyi0H573VQxC5
        ZhpaxEfwmdJmopobQcDsRcP68Qv/Oz9XBw==
X-Google-Smtp-Source: ABdhPJwYEaxjb3cJ6+MQllDElDdIYJeQGeJiQlMwCCRWuxC518BJv7jMaI+Rug9UZkeDBcQPRtlDcA==
X-Received: by 2002:a17:902:8309:b029:da:1140:df85 with SMTP id bd9-20020a1709028309b02900da1140df85mr18509643plb.46.1607385179978;
        Mon, 07 Dec 2020 15:52:59 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g26sm5439668pfo.35.2020.12.07.15.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 15:52:59 -0800 (PST)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
Date:   Mon, 7 Dec 2020 16:52:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204191356.2516405-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/20 12:13 PM, Sebastian Andrzej Siewior wrote:
> Controllers with multiple queues have their IRQ-handelers pinned to a
> CPU. The core shouldn't need to complete the request on a remote CPU.
> 
> Remove this case and always raise the softirq to complete the request.

I don't like this one at all, it'll add a softirq jump for the fast path
for eg nvme devices. Did you run any performance testing with this? I
can give it a spin, will do so anyway, but was curious if anything but
"this still works" testing was done.

-- 
Jens Axboe

