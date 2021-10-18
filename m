Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447D0610A6
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhJRBV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 21:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbhJRBV0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 21:21:26 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAD4C06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 18:19:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i189so14389026ioa.1
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Ss6rRSBafTIyy3JhG9gpWccPlEHBJC6ZWuBmCdlDp0=;
        b=Xrvkrt26FJkelTeTryGVQXkGgmwphAIS0XbuvXrHExwVfeZ1NSjegp/rkUYOKtCN4I
         IoO/SgnPZnSa9wN5y018mZFcoY1oTJsMYeWv4krUryHKxi6YItVdaWH4GnRlL808LhSc
         WEou4qvAXRdUHtoAh7ODDawwJzo67nqpGgaJIFFlNJgAx4sDmYJB7v2+JA3FYoKU3CPQ
         i2O7l5L9j+81NB6SKnHw6xuDk7g91oVx951lRYVxNBP04vQVce5qDpHjh8I2GZTovBe3
         mMqao8t3Abe0WrFqYWQAm087iJxbdobeecCjK7vkB3hICmRH+e+O93+Mm3ES3NYjLSUj
         t/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ss6rRSBafTIyy3JhG9gpWccPlEHBJC6ZWuBmCdlDp0=;
        b=CVy/Pgr6kVMcRzIBZwjoygxUsPKqYoJSxWJ+hn5igrYYUOZNBuNmil5Leh7CIc/Df4
         wSLdR9ssk1owj+Ap9Z8EsUt+DZ8KpHCc6svTDevz7Yg0ilAUGEe6W1KrRbGjR2SXmjtl
         d424Tci/tYPM0jp+FWK0ykPBAhpARbxz2b2kV3wGc1x8gXOh70YQSAk5yMPV9aHTZ35n
         HDvC95kson1iYX48woQIlus6roMkWDyU/FN2f3YfMIAjmRNSJ5x3Nh3IyIZGJj+xSxz2
         jv9weX4f1s0FNhlcPCmUIvCXwrr9whGzmoFl92qEIB1Y7zWx5nfw7Eb2LD2AFFU4xdCf
         wOdg==
X-Gm-Message-State: AOAM533BKTT+CdL5dO9gguoSmPqV2l/eJsmmoDzUoZGdjZURTPw4jLBJ
        J9yVptwEyrmNqfd9ZsJLqH73Ww==
X-Google-Smtp-Source: ABdhPJz46apwwR3fPj7comOfIeu5CLlqxArnD7r0hvgNjTJBUvusbXLbDOJ2jDqFbZ4E1gktMYuLIA==
X-Received: by 2002:a02:858c:: with SMTP id d12mr16836425jai.110.1634519954760;
        Sun, 17 Oct 2021 18:19:14 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i8sm1167604ilm.10.2021.10.17.18.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 18:19:14 -0700 (PDT)
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai3@huawei.com>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
 <20211014121145.GB15198@lst.de> <YWzIazr+VjY9MNCv@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd75e597-ab35-2a88-c2a7-e4e5365bf0ef@kernel.dk>
Date:   Sun, 17 Oct 2021 19:19:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWzIazr+VjY9MNCv@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 7:05 PM, Ming Lei wrote:
> On Thu, Oct 14, 2021 at 02:11:45PM +0200, Christoph Hellwig wrote:
>> Except for the nitpick just noted this looks fine to me:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> I plan to apply at least 1-5 to the nvme tree with that nitpick fixed
>> up locally.
>>
>> Jens: do you want me to take the last patch through the nvme tree as
>> well?
> 
> Hello Jens & Christoph,
> 
> Any chance to make it in v5.16?

Yep, I'll take a look at this in the morning. Rebasing the block tree
anyway, I'll let you know if we need any changes here.

-- 
Jens Axboe

