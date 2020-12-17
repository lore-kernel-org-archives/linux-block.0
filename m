Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3ECC2BB9A
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B882399A
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 18:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgLQSqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 13:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgLQSqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 13:46:44 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA9C061282
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 10:46:04 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n4so28547027iow.12
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Z5Fbb9QKjNVhGoQ8/IL5H72Brxfn+MGmw5CTLtTWw4=;
        b=m4dcKqkTzd5Yn96H8W9koOdcj4WpefpuyVjTFd430tfRwEXFOY4qOU6Syx7opMWoxt
         qjin3x63NTuDLOKbckXt7Br2+OjzOXsUfZIRt6y6x7rwnyAOPS3ZMyfrBgp5Ym5/LRhy
         iIZcv5nhF9pHYty6FF+/ExBPxDc7IXsLxgHYGRZVGkQ+71ErrjvLSsJ8pdVh6MK9oYso
         /J4Ko8XAlWbXhPY9dBRoKrAE0v03AAKn7sxL3Nak4mN4HOF0aAj9oKIeRGhXnE18zkns
         EjWCTy7EtL2gSGhfCcFB1+RLVq54xm8DFiU71Wi7cIYn5kZ/EpSHQev0BYcvfyOOUeRO
         gdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Z5Fbb9QKjNVhGoQ8/IL5H72Brxfn+MGmw5CTLtTWw4=;
        b=ZYMBFWitRc2imiYxufzfUIP1Oy3JSXZKXlxS0T3csOGYCwGC4RtosLy9C1YBMRITMV
         K4jOmnHYKVBd9fvx8lKzQ76KwAc5NbsUSNjkObSvbTkCHJZxbkPIgjkVJqfsR4YBuCbX
         XuT6aZmxj0XoKV21xjstIsH+TGOcesKy6fqWgfpAVCiQ41Z9QKp4qoo6q8pV3GbeuV3N
         klbyPTGG7OIJSbAgmkVRf+Zh8lhqdsTe1L9ojbQ/5N5vsMx4U1JdwonPK+YxHgv/GgyU
         hfV7vaUhpMh7exGnFaclBizGDRTIKxf9g0FuImIcOBJpcps6Da57IxeOzyd5OsJ0lbET
         Nt/Q==
X-Gm-Message-State: AOAM533op3XdoeRt3EyGUwpKd2r9jPK3tPwnrofcoh7x71El/CWe5vns
        W+JJLe3rpZYwB5iGJwNMXQK1GQ==
X-Google-Smtp-Source: ABdhPJw+UVCHjz/Xs9CGLlkLzh7l8zYPkSE1V2r76TvdsfZ/9D4EblquXXnEiL8hIc9CY76XTXxWpg==
X-Received: by 2002:a05:6602:1d4:: with SMTP id w20mr430834iot.25.1608230763638;
        Thu, 17 Dec 2020 10:46:03 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n77sm14883903iod.48.2020.12.17.10.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:46:03 -0800 (PST)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
 <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
 <20201217181639.byvly7dvpbdxmeu5@beryllium.lan>
 <1c11b5eb-4e3f-120e-2228-89f63c26bf29@kernel.dk>
 <20201217184154.hn5pjiaasti3m7e7@beryllium.lan>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <277c5421-d6ac-63a5-9dd2-c72e0a77fb8d@kernel.dk>
Date:   Thu, 17 Dec 2020 11:46:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217184154.hn5pjiaasti3m7e7@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 11:41 AM, Daniel Wagner wrote:
> On Thu, Dec 17, 2020 at 11:22:58AM -0700, Jens Axboe wrote:
>> Not only slightly hidden, b4 gets me v2 as well. Which isn't surprising,
>> since it's just a patch in a reply. I'll fix it up, but would've been
>> great if a v3 series had been posted, or at least a v3 of patch 3 in
>> that thread sent properly.
> 
> Yep.
> 
> BTW, if you like you can add my
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

To the series, or just that one patch?

-- 
Jens Axboe

