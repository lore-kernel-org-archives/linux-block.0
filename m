Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C78C433F5
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6037361AA2
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 18:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhKRSZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 13:25:41 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38868 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhKRSZl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 13:25:41 -0500
Received: by mail-pg1-f170.google.com with SMTP id q12so6150168pgh.5
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 10:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ncz5M4jCZ3xyETl19X/+9dhCMHGv2pfcOW3GR8Kyz4=;
        b=PSVr4XJY3aHtyDFepX0c0k0j6dC1hcgcmLw61opN2opA/P8CpFgQEoWMWqr0EWcxa8
         i6lzIW8kicVOUVeJdl0RjOqU2GBx70pukEvFFkJZz2F32oIOwYLaZougBplh4VcSXqgk
         g0DDtXJlS0AHZPqo6BeDkHGBMcAXQLkLDLbIkOvZjGGGH1jEhJN28k2lk3c6/bhiyXKm
         lxs4XicdlNSDdFa2LwoMozufSodv7TgQ1RlFT8QEnb+hxi+qZPbZlVLzvNCfIHuY/9zh
         LjF8hmJP98T9UL/h4QT2mEE51oDIMcOEepJelItmhvOnbIFhjox6dz7azZhUeZfk2KUu
         W6qA==
X-Gm-Message-State: AOAM533hBa5KrO119lE1tUjfhA9WpqGnhNu3RIdM2ZJZ0JfkFC+KMgo+
        ixUuoibfoTmP3uBzAVXav6g=
X-Google-Smtp-Source: ABdhPJwEqakM3wFiOrTF/kgXqrRCDmpGykbJ14PU+ufHQs4wmAn3bIJ8hwrRRLMOOLlOK46dUjGSNg==
X-Received: by 2002:a05:6a00:21c2:b0:44c:fa0b:f72 with SMTP id t2-20020a056a0021c200b0044cfa0b0f72mr16597667pfj.13.1637259760900;
        Thu, 18 Nov 2021 10:22:40 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e37f:ba6d:df8f:72a4])
        by smtp.gmail.com with ESMTPSA id s2sm320697pfg.124.2021.11.18.10.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 10:22:40 -0800 (PST)
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into scheduler
 queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ba3afcf6-7349-ada5-d157-17a84cd85777@acm.org>
Date:   Thu, 18 Nov 2021 10:22:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118153041.2163228-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/21 7:30 AM, Ming Lei wrote:
> We never insert flush request into scheduler queue before.
> 
> Recently commit d92ca9d8348f ("blk-mq: don't handle non-flush requests in
> blk_insert_flush") tries to handle FUA data request as normal request.
> This way has caused warning[1] in mq-deadline dd_exit_sched() or io hang in
> case of kyber since RQF_ELVPRIV isn't set for flush request, then
> ->finish_request won't be called.
> 
> Fix the issue by inserting FUA data request with blk_mq_request_bypass_insert()
> when the device supports FUA, just like what we did before.
> 
> [1] https://lore.kernel.org/linux-block/CAHj4cs-_vkTW=dAzbZYGxpEWSpzpcmaNeY1R=vH311+9vMUSdg@mail.gmail.com/

I had not yet noticed that report. Anyway, thank you for having fixed 
this issue.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
