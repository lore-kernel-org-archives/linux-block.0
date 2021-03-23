Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB49C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 17:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613B6619C0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 17:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCWR2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhCWR1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 13:27:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC34C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n198so18534415iod.0
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HeqUxpw67GUtG8xohzxQIj1PzhT3kGyB+k7vjdvIyxQ=;
        b=tO0RdXD3HzTKx65xOHct/Oaac5lN+TwBFu1cZU6ZbMJEjDAA0QpZ6BLpePaXMoHBeG
         AoPjKkVtXPYmqjQcZzL95IrcJG7je6M5XalF3b3uFh2CpQbMjJ4U2Oe4iZtq8Ea+fgIp
         NTtvSCyk+26XObFWg8v3Y48d7/4kL6mOe0mVR4kKZTR2tkUygAPD185BiTmdKPmE+gyJ
         PF94Tnn283npgzss6yD97+zsav7PG2KsvgdOw9UwB1h+p9kCbECu3Qxh9hHL3WMLv9/c
         Y0nqzJ01nVMtNoHnduk9RzPcfBxYpSWs9jf5VR8+kArqvEjI9BBF73qGHmL4X8HmoZJg
         fFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HeqUxpw67GUtG8xohzxQIj1PzhT3kGyB+k7vjdvIyxQ=;
        b=VNr4rUzZkE1BAbYC1Ifd7jQWVxmc09hvJCAUsFAcLEKUSPCnvKZFxsnUDwqp5tubc9
         KUHPAR2dSjyNoq9y9IPWpTKP8282yXETouE4xKdnZbNKiumB44r+lTxeDDT1zk5+P+Np
         Q8TuvJWQdAt3dsGR0nWCD6R6XMY862ND3/0zbukNoQ/gInIGvf36ixlJ8E3TyHvhCcFl
         dl9XeK1SOKvG93POl99vSblmx0nhLYXEQJUvI+ODmrGqhbhZJHMaVt/610rkmZzLZJiw
         R38CrCrAFi1WpGZlrIkhia/0t6JQLVhTj4/u6IRQnDoXcfcGiObchzsLiO/WeTIKhJAq
         rZHg==
X-Gm-Message-State: AOAM533RdX3Quss/LnSR/hlVf8Yyzit29F/Kuud7cKcsnnmqKeX/gFt8
        1J+Juvc4dVrBU52Wg5xxejjYKyfj5QwYAw==
X-Google-Smtp-Source: ABdhPJwLwiXGn9Vq7IXdEmorOoB/+QyO1pIg+nEB4rjswWkjpATzbY3SbS0r99PDOoF6QMcuPo7x8g==
X-Received: by 2002:a5d:8b09:: with SMTP id k9mr5098007ion.185.1616520470339;
        Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e12sm9566148ilm.85.2021.03.23.10.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 10:27:50 -0700 (PDT)
Subject: Re: [PATCH] block/umem: convert tasklet to threaded irq
To:     Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20210323004856.10206-1-dave@stgolabs.net>
 <20210323172437.GA2463754@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d26434e-36e2-58f2-16b4-ef0fa4292c6e@kernel.dk>
Date:   Tue, 23 Mar 2021 11:27:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323172437.GA2463754@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 11:24 AM, Christoph Hellwig wrote:
> On Mon, Mar 22, 2021 at 05:48:56PM -0700, Davidlohr Bueso wrote:
>> Tasklets have long been deprecated as being too heavy on the system
>> by running in irq context - and this is not a performance critical
>> path. If a higher priority process wants to run, it must wait for
>> the tasklet to finish before doing so. A more suitable equivalent
>> is to converted to threaded irq instead and deal with the async
>> processing in task context.
> 
> I'm really curious if this driver is still in use at all, or if we
> can drop it.

Me too, I'd be surprised if anyone has used it in... forever. We can
probably drop it - I really dislike making core changes to something
that can't even be tested. Davidlohr, assuming you had no way of
testing this change?

-- 
Jens Axboe

