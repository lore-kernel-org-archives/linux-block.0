Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A735C613D1
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 11:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245410AbhI2LzL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:55:11 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38677 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244947AbhI2LzK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 07:55:10 -0400
Received: by mail-wr1-f47.google.com with SMTP id u18so3790917wrg.5
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 04:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Y1HuBf9lN+kQWKCO1g1Kb4iuwMOmOhY2Wh4y+H0eoM=;
        b=MYqJvzmMMpwqwLEVzncWl1OLfkdfj1SpccVtlpFBQv/yAU3yZofBGsX+MOvrXkpCG+
         x/tZ/jvJH4GK0xwkTTRg3SHNsAaYgprcnY8g/XTjTzybUuVGogDAiHJrhBARlF1dZ25s
         L2uGAeq1/q5e5/2VeshmZC6AGupwsFcJYpvYM5dIs/qBy+8m6GrYnADjSR4Zu8lsgj+K
         LWycWHG4iA1NMIv2zCfigZMpv86N5ZcLUOHdVZlQ1JSHq/ADmBZLoA+W20WyEan55PQH
         7+q6lVd0RMhSTh69zQTcV9/MG+pzVQ5vg4+iLRTIT8IHhGLPTD6ug5QfEWEPnQWTqb59
         VNtA==
X-Gm-Message-State: AOAM532rPUYibQRZNpA8Nn1qkq9DIuO/9r9yeQFsA+PM0IO4RXSjZ78O
        E9VX1RSmuvH2CnRRCMrJwUY=
X-Google-Smtp-Source: ABdhPJzGhWGVbT3MlvchMuoy7R3Q5OKSNBay3CCJMwDPSmx6sCdOeLTR/AnuOZ2XrUegMeOgKkvtvQ==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr6264457wri.323.1632916408500;
        Wed, 29 Sep 2021 04:53:28 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 189sm1644821wmz.27.2021.09.29.04.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 04:53:28 -0700 (PDT)
Subject: Re: [PATCH 5/5] blk-mq: support nested blk_mq_quiesce_queue()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-6-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <54b636d5-ede6-a700-4d02-4712db679234@grimberg.me>
Date:   Wed, 29 Sep 2021 14:53:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929041559.701102-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/29/21 7:15 AM, Ming Lei wrote:
> Turns out that blk_mq_freeze_queue() isn't stronger[1] than
> blk_mq_quiesce_queue() because dispatch may still be in-progress after
> queue is frozen, and in several cases, such as switching io scheduler,
> updating nr_requests & wbt latency, we still need to quiesce queue as a
> supplement of freezing queue.
> 
> As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
> for us to need support nested quiesce, especailly we can't let
> unquiesce happen when there is quiesce originated from other contexts.

The serialization need is clear, but why is the nesting required?
In other words what is the harm is running the hw queue every time
we unquiesce?
