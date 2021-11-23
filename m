Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA5C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 17:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhKWRJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbhKWRJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 12:09:58 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46720C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:06:50 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id v23so28830182iom.12
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=juR+fVMErLWsnbWFyhPdvzRaIBM+6Dn7nWG6zRv6ALA=;
        b=hJQGyfAT6lA7fPf/wJK4xPCv7aOKprXvpvMTURLyNrgnpJafoIflbEuGVaUSoRn/0o
         nXMFGW5N8h7w5b+10YFzF6RTcbs9YRUvTk69xzWgzCwVZkgeGGs7bWSjgi6DWfFkOUlj
         2EyZbRssbjV1/nYYGklibRK4lpACz7L9UYsRYGbdRtiHd6LI7Oh8t1HHS6xzvWvA39h1
         1cQIZAs8YsoMDQ2kmA+sI4573F+kLx5rI63OJb6c62ZYdRnaYtv15s4BoZ4kfOqnk12B
         gbla6o4SdvKx3khAiW15ivVGndv3AlQQqukluo0tfjUcZ5IkHZkTicY6q3dOPwPN6ZEE
         3V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=juR+fVMErLWsnbWFyhPdvzRaIBM+6Dn7nWG6zRv6ALA=;
        b=TzK4GnF25uz0LFVW1I0CzCA+jEBNrEmAjy0ExEm1t1SaEWK7og2PCC6Zj1h/vFC/0d
         vkwfNqxhtqo+YzC8KFANdSqwKAv/ZJtiY8xz4nIm8MYXr2+NC+5JEPTYR7gNCvFypqLB
         odydvvOc1+3rY/hY1HchqqaVlbmk0sm5YRtGJev0oWsrllfTm1XtN2OrE9qv/fc852XC
         HO3/gspm/U/8QBK/PxMewmbCGIB9BGz94g3HrX9TJerH2r36eG6wnZEsv3if8xecQWFd
         qIGWUKz/haBfbVI0xv56k6BnxhmZ5YKJ0ud9kW/xvFaokQ/hmQx7yebyuOxaoWXqrv+g
         hLaA==
X-Gm-Message-State: AOAM5300X9hfY72PvqgHj2cH/Lsm3kiCruxwQC57y5jUsP7DX/9iTWPf
        6OTZU6PetsItpGtxG+gM4q2/mRZZ+ObqMq9M
X-Google-Smtp-Source: ABdhPJxUFT5sM6zvnNkMIr2QHjTtK/4O+gLTzz8xV4aRHSTWDe1sf9ceSioQUc07LfiamvsYzdORbA==
X-Received: by 2002:a02:a11d:: with SMTP id f29mr7865226jag.78.1637687209424;
        Tue, 23 Nov 2021 09:06:49 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t6sm6870218ioi.51.2021.11.23.09.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 09:06:49 -0800 (PST)
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-4-axboe@kernel.dk> <YZ0ZvJMKlHOjMckv@infradead.org>
 <e1a46189-0b83-42ea-4488-4b6ccb3132e0@kernel.dk>
 <YZ0fYq+7XSRWp+XG@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f6defb84-38f6-9457-0c7b-66af03704fb1@kernel.dk>
Date:   Tue, 23 Nov 2021 10:06:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ0fYq+7XSRWp+XG@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/21 10:05 AM, Christoph Hellwig wrote:
> On Tue, Nov 23, 2021 at 09:44:18AM -0700, Jens Axboe wrote:
>> I think so:
> 
> I think my eternal enemy in blk-mq-debugfs.c will need an update for
> the flag removal, but otherwise this looks good.

Heh yes, it always evades grep.

-- 
Jens Axboe

