Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42013C38A02
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 21:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJ1Vin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ1Vin (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 17:38:43 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF531D2F6B
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 14:38:42 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id 192so5845768pfx.5
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 14:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eky2t3lMAw0VhuARbfpVlAH47cho43zllPU1dSPRjcI=;
        b=Gd9orzIJM22TzhpFXnT8UQSS2mt8MmoQoRXt/AoZRTMdcsxjhhlRCa2OTmlioxW9dA
         zjCMDnXxHMzXVBC2IC2dPv2Hlu7XcybtO0SKucyu60YH0WlMo81MO2o1JGNXfh/7KAFr
         KoLt+GN8yCYGbEFyimERz9c8pDdwiNj0s+fk58fWgGbdXuEOM6H2PAVo8LSDTS8NJFWF
         kxCyt9jgIVB34Uo4tTj2o6Q399INRTO6n0TJfr4kdglyzjjAGB6JWzI/ZfySEH1vt5uf
         8AFPZWa9MlYDbfj3MUcnz4EPBkId5xWtbMO+BeNhdvOptdIDOOtHE/0AuKgq4+OeJZxQ
         g2gA==
X-Gm-Message-State: ACrzQf2gQc3Sc5viJ6l2DoBwyOWSHtisE96zRQfPymEo1zHuRdqqBfek
        dGGpvbbCnCaPTffV26FAxi4=
X-Google-Smtp-Source: AMsMyM7G4OpRRlAeBhKXsyVEfsbt9daJUy6FUDU8+CfUsTGkGCX7KnGpg9wo0ciEvYDmjTTxImVGdw==
X-Received: by 2002:a05:6a00:1810:b0:56b:f29d:cc8e with SMTP id y16-20020a056a00181000b0056bf29dcc8emr1419218pfa.33.1666993121599;
        Fri, 28 Oct 2022 14:38:41 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902e48400b001784a45511asm3452026ple.79.2022.10.28.14.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:38:40 -0700 (PDT)
Message-ID: <b7bab0a9-999e-3c88-1add-7f52642873f4@acm.org>
Date:   Fri, 28 Oct 2022 14:38:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V3 1/1] blk-mq: avoid double ->queue_rq() because of early
 timeout
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org
References: <20221026051957.358818-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221026051957.358818-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/22 22:19, Ming Lei wrote:
> David Jeffery found one double ->queue_rq() issue, so far it can
> be triggered in VM use case because of long vmexit latency or preempt
> latency of vCPU pthread or long page fault in vCPU pthread, then block
> IO req could be timed out before queuing the request to hardware but after
> calling blk_mq_start_request() during ->queue_rq(), then timeout handler
> may handle it by requeue, then double ->queue_rq() is caused, and kernel
> panic.
> 
> So far, it is driver's responsibility to cover the race between timeout
> and completion, so it seems supposed to be solved in driver in theory,
> given driver has enough knowledge.
> 
> But it is really one common problem, lots of driver could have similar
> issue, and could be hard to fix all affected drivers, even it isn't easy
> for driver to handle the race. So David suggests this patch by draining
> in-progress ->queue_rq() for solving this issue.

Nice work.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
