Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45345C433FE
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B9A61AFB
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhJBNao (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Oct 2021 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhJBNan (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Oct 2021 09:30:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DFFC0613EC
        for <linux-block@vger.kernel.org>; Sat,  2 Oct 2021 06:28:57 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k13so13478791ilo.7
        for <linux-block@vger.kernel.org>; Sat, 02 Oct 2021 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dCkNHFsEN6MvEG1ZDSeULMUhv2QttNHqJmByU8POC3Y=;
        b=eHA79hddrjkSNlIr8yuJUJBxg1RCE19yI4y/vnv50N11E5E0I/rV0IrqGtlf88bWuw
         KpfM+XAeEb1FQ3tfoqKFzDQQCAwh1gNPxzPzzlJMBZCG/1z8fgvtOwihZ17tFk7v9aUk
         Yzjuivk+LroxW9qiJ0jQFAhI1OsEf986CQp+0wZPpZko1dab5dxnS6zRsdenp0LGsZNf
         W/R4cPbPkCR0mTLzd+E2D7l0q+9SC67gSbVPqH5xVtGWH6DYFHiATQzN4rM6kib8zfzn
         QGmRJGiWO3lLlu2LnKZQGmmCi0lLA3o5PQgS0fUam0mYeDdss66VxIiWWoADTOkNv/F4
         8LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dCkNHFsEN6MvEG1ZDSeULMUhv2QttNHqJmByU8POC3Y=;
        b=r9k7myIquc59KSMVJBgOoQv+g9sldAK8VZvHSs0nzowFgmbhF2ObIDQVMi5OFgoaIi
         DID8KITctrWfykEa34uWVKpN6gtQf7zud3pc7euP2c6RpJ0fsj+O0dFQBtkpY076uUMb
         b8ShcMjZdlvTDzuz1wmVeFk+C3zUOG2PdIn9MgeqcTzBtAcSWmN7OGq3MQaymHATJ6W0
         BtiV0EsuvBV7bfOzoKU/vR2qC5ehqcIo58Lt0nbJ5BfuDOIUY/ARmE8khLft1QZp9Uaa
         EY2XjHALbOLluoD1iDjAZqCLBmZcpSaANM50aNLXPyr/PXZYp88dmej/MqPygbBPZrP/
         0dRA==
X-Gm-Message-State: AOAM5301uuZDmZr21MI82nUDjsnvNxgelQ3CzTWSiavY7qlq3L5Wx4t3
        CpI768TMTAiw6ga1lFYEvNtkcTE0+yYTQw==
X-Google-Smtp-Source: ABdhPJwYCxfkXmh3i+5Qs1nN9Ojyiqxj7J7J5t96prJ9jo2huDeT+H0tmSG0MXRqvZkei+gw2463GA==
X-Received: by 2002:a05:6e02:18ce:: with SMTP id s14mr2624329ilu.242.1633181337228;
        Sat, 02 Oct 2021 06:28:57 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l3sm5535528ilq.48.2021.10.02.06.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 06:28:56 -0700 (PDT)
Subject: Re: [PATCH v2 (RESEND)] brd: reduce the brd_devices_mutex scope
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <d79f288b-3968-71ca-c9b2-49c0ac6940b6@i-love.sakura.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a3365e67-8e85-13e4-f202-04d0eb47513c@kernel.dk>
Date:   Sat, 2 Oct 2021 07:28:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d79f288b-3968-71ca-c9b2-49c0ac6940b6@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/2/21 3:19 AM, Tetsuo Handa wrote:
> As with commit 8b52d8be86d72308 ("loop: reorder loop_exit"),
> unregister_blkdev() needs to be called first in order to avoid calling
> brd_alloc() from brd_probe() after brd_del_one() from brd_exit(). Then,
> we can avoid holding global mutex during add_disk()/del_gendisk() as with
> commit 1c500ad706383f1a ("loop: reduce the loop_ctl_mutex scope").

Applied for 5.16, thanks.

-- 
Jens Axboe

