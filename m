Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074C2C3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD502133F
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHPPOQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:14:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46165 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfHPPOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 11:14:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so2560622plz.13
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 08:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/M6OD/TkzrcNfnlQwoie71e6SDMjsJFVh4m+icqYtc=;
        b=amZ4Ki9we8NPMc3Sgy7R6iFmuvg4kIZWe5wX0kc5wgDYapYSlX9WrvCCWzOUNeNMD7
         BLWi7MwvXPm4CBPQSYfUazhRI4PZQ2S3WtWHbo7wrN7IiV2qXMYCX8k3G/HHpezmeIZG
         bjz5FW+pbyGgiOypegWoHH+FjisMV8IsFYcZ3V52qcCIFOl6WUzeJLuxUawkk5mTmLeJ
         iUl20mELBx/A+MURDf/gjkJA5YPPp42SiUmHnWIRKV4w/AhQi7fUFuV5iUyzi9lzIW0t
         cxPrP/Pna0GPihaJTgNv6aQbwpf/t50dev0f6tlAq+Spxbpqq5PUC6gdF+6dd17r0ZRo
         foAw==
X-Gm-Message-State: APjAAAUKPkAAxrI5WcNYlLdkWz3PLkpi/ikjBl65yZqiPM149YOQGpPa
        SvsFjnQ1IOmONNOhMqXob8U=
X-Google-Smtp-Source: APXvYqzT0Gk+UMDC2NewkBwBSLHZ/XFFbB8ZsiQFDpADvtV9l5aPqe/zvvLRPPtj0D5TemUwHzmRww==
X-Received: by 2002:a17:902:ac88:: with SMTP id h8mr9058953plr.77.1565968455397;
        Fri, 16 Aug 2019 08:14:15 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm7849733pff.148.2019.08.16.08.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:14:14 -0700 (PDT)
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190816135506.29253-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <429c8ae2-894a-1eb2-83d3-95703d1573cf@acm.org>
Date:   Fri, 16 Aug 2019 08:14:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816135506.29253-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 6:55 AM, Ming Lei wrote:
> The kernfs built-in lock of 'kn->count' is held in sysfs .show/.store
> path. Meantime, inside block's .show/.store callback, q->sysfs_lock is
> required.
> 
> However, when mq & iosched kobjects are removed via
> blk_mq_unregister_dev() & elv_unregister_queue(), q->sysfs_lock is held
> too. This way causes AB-BA lock because the kernfs built-in lock of
> 'kn-count' is required inside kobject_del() too, see the lockdep warning[1].
> 
> On the other hand, it isn't necessary to acquire q->sysfs_lock for
> both blk_mq_unregister_dev() & elv_unregister_queue() because
> clearing REGISTERED flag prevents storing to 'queue/scheduler'
> from being happened. Also sysfs write(store) is exclusive, so no
> necessary to hold the lock for elv_unregister_queue() when it is
> called in switching elevator path.
> 
> Fixes the issue by not holding the q->sysfs_lock for blk_mq_unregister_dev() &
> elv_unregister_queue().

Have you considered to split sysfs_lock into multiple mutexes? Today it 
is very hard to verify the correctness of block layer code that uses 
sysfs_lock because it has not been documented anywhere what that mutex 
protects. I think that mutex should be split into at least two mutexes: 
one that protects switching I/O schedulers and another one that protects 
hctx->tags and hctx->sched_tags.

Thanks,

Bart.
