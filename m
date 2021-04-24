Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E904C433B4
	for <linux-block@archiver.kernel.org>; Sat, 24 Apr 2021 19:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0CA613C1
	for <linux-block@archiver.kernel.org>; Sat, 24 Apr 2021 19:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhDXTeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Apr 2021 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhDXTeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Apr 2021 15:34:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FB4C061574
        for <linux-block@vger.kernel.org>; Sat, 24 Apr 2021 12:33:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14so19935074pjl.5
        for <linux-block@vger.kernel.org>; Sat, 24 Apr 2021 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rO/BU/4BwTXgn/LS1reLpKHsO8KV0oaUU7jrX6j9d+Y=;
        b=xu9m91DVUffZdKC2kADmzjrVOUxIpf9enSpUL3Vcda9GVCGFWoFchoGvsHB3m2cLpZ
         srFbNMIDW03Z056iX00n+4WtXrb1vBkyXQ+3q1qAx0lxDBMfe1TyDAznfG2IZWbXr1kp
         Bd4Na5VcUfQGVGU6eso7Uuf4CxOhWSPjZSabnlZWm8o3OpU/FA2uAewDfaoADOdiIahU
         s8jt5fcF2YHP5ea1Qo6hhEK4ciPxywqTF2jWqn699Tk7lNwiyYFwr1FOZ+bj0ettbgsB
         KQXMyCnlHybvAoCdOjT6PdtpMsR8bRnBOd4owT3/8+kw12p1y8JiXrr956umPNH5j5qM
         vCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rO/BU/4BwTXgn/LS1reLpKHsO8KV0oaUU7jrX6j9d+Y=;
        b=alfJNjD+kpvtodjLmu+zP8ApdVB3gx1NCY4rwIL3WrIlNgZpicVKPMXyQBgMT1PM45
         aa9Xd0B9kqgyWFcJQ87ro1IaFHWbPNCBTbUdzcg8ANVgT7nTzG0QACvA1AOyZQGi4fns
         o/gg83q66xIaBW5sCq4A7O6tLzBfeMs55vmM01gB7bDSSTs6EH+CpWJd5gsvKxbVx9gR
         v4WYf4COgMzsAiLd/gNBESIrZ6lquiHW3LHbu+RbY0AHe9Htp+2Y3E+9md4lzEb4TKmU
         FyAozohCytz2oE4i48Ckc5UfCdrRzbjRAyyLSvUvIGSCPSnCltUkOPoSLzRt1xgQzLu2
         RcZg==
X-Gm-Message-State: AOAM530IWgDxYokhbb2g2AoOC6OwqPiKfyUL5k9XDfjyYqzhKV6Sb3N3
        0Tc/+ZZ/PWXYrk4AsM16gOjhZg==
X-Google-Smtp-Source: ABdhPJz7X3Xz1yT2zeyxxOJWIAIwHXbeDV+S2TCOv5iLmiJS65zkkODzeNlMUN+Qgw3UNiAIm9RGBg==
X-Received: by 2002:a17:902:b494:b029:e7:36be:9ce7 with SMTP id y20-20020a170902b494b02900e736be9ce7mr10299248plr.43.1619292803026;
        Sat, 24 Apr 2021 12:33:23 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f5sm7507630pfd.62.2021.04.24.12.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 12:33:22 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix two racy hctx->tags->rqs[] assignments
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
References: <20210423200109.18430-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <661306fd-0adc-dff7-c79b-f4be8feba73d@kernel.dk>
Date:   Sat, 24 Apr 2021 13:33:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423200109.18430-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/21 2:01 PM, Bart Van Assche wrote:
> hctx->tags->rqs[] must be cleared before releasing a request tag because
> otherwise clearing that pointer races with the following assignment in
> blk_mq_get_driver_tag():
> 
> 	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);

Looks good to me. Applied, and added:

Fixes: 5ba3f5a6ca7e ("blk-mq: Fix races between iterating over requests and freeing requests")

which was missing.

-- 
Jens Axboe

