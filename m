Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584BAC47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 20:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6161400
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 20:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCUFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:05:49 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:39683 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCUFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 16:05:49 -0400
Received: by mail-pj1-f45.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so6121744pjp.4
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 13:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/AH2z1DP8mm29b2M5LsHCoKZhQs5GChTEja57X7Zk7M=;
        b=ZxyqBQa7tbNLNSg9/pDkF7KN2DfJNjfiwaT80uah0/U+o0NGxMPvwVfiYpjc7umqEV
         as0YuQd8/Y6cTkW4fK9nfyMUMu7UQZXDBPLM/zXQAz/YTDzSly6C+ZmeLUOJEeb/I1NY
         qbjMDCJ0MF2S0+Q/GVHEVF/JYZjb9ZHsxWKiK4QcDAGuTLOpP0tZgKkWhRxPrWtA2Ece
         KV5LNgMc6nq3V7rjOqbIUH6ZI3AfdqeH2YP/9KK0V7pUmSxDEmQaA+lKCthPmXuq083/
         9QpefXa9UBdUC9rRLiKk3dtkVtu0C4RxjMOJV/FO090X/1YJCRGcp6hdx/LYQP8cbz0V
         5nTw==
X-Gm-Message-State: AOAM5306tu3R8whFLK1mMR66DlkBbbX77CjZig8Z2/TuQQFvTN2qv4G2
        SteHXMPLNd8hqG2450PcqL8=
X-Google-Smtp-Source: ABdhPJyeFpSkMxnrpa4Q0NWvAddNzbz9fHegkWDn7JkYTV2Ur4qDfxL/uEDOpAs4eD03RBgFnVp2WA==
X-Received: by 2002:a17:90a:a43:: with SMTP id o61mr926934pjo.233.1622750632305;
        Thu, 03 Jun 2021 13:03:52 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l5sm2934785pff.20.2021.06.03.13.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 13:03:51 -0700 (PDT)
Subject: Re: [PATCH] block: Update blk_update_request() documentation
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
References: <20210519175226.8853-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <98c3ce4b-dd73-1635-c02f-37e411d2b739@acm.org>
Date:   Thu, 3 Jun 2021 13:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210519175226.8853-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/21 10:52 AM, Bart Van Assche wrote:
> Although the original intent was to use blk_update_request() in stacking
> block drivers only, it is used much more widely today. Reflect this in the
> documentation block above this function. See also:
> * commit 32fab448e5e8 ("block: add request update interface").
> * commit 2e60e02297cf ("block: clean up request completion API").
> * commit ed6565e73424 ("block: handle partial completions for special
>   payload requests").

Can anyone help with reviewing this patch?

Thanks,

Bart.

