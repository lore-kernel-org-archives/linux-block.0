Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3D3C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF932619BD
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 07:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCWHhG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 03:37:06 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:40808 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhCWHgm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 03:36:42 -0400
Received: by mail-pg1-f179.google.com with SMTP id v186so10824770pgv.7
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E5IJ2NTiStWRS0yTKBe3muHCvR7EJ4ZBfZfPHNWN9Qo=;
        b=IrTbJiuaJDKwSEi5psr57W06n7BAlZZXxK2N8iR4bO83oEDA5vyL7bGdmHB37/zlMO
         HQcXctI/Z0vwQlPrBMc8IVu5gc3Zr4ciXQXQ5PqKIVNltpZDVx/ew3RganYJno+9p5+a
         COybbkRNklGdQ36uzg6gpdN2No00vft1NFew8ecNLdse+Io5brihVtO2ZoEKz2We9RED
         NKUqGRSAfKc/AUZFZypQp20mWhdGXyPUlJBPsPffMvpzVyZW4daJtSQyuUhVwqG10zG3
         p3NaPm5GQfTsz6ElI2o4FSpL068SX3+qCXAm7K9bMPsllTBgLTu5Ps2qRORXYtrp+8mv
         NHhQ==
X-Gm-Message-State: AOAM5338jFpiUzriw/tC+tTEENAlVdDjOzZzl4g+CE9S8tNaNst/QMoT
        IXZzx3nlnU5JPwoMIfnmCqg=
X-Google-Smtp-Source: ABdhPJxVLzwYncrnsVjWUzV3i2OM0Wtug3Tma8WY3A+kKqFBL0Wxapp1CsBYjdfxtNRzARUw1CJzsA==
X-Received: by 2002:a62:7f45:0:b029:205:9617:a819 with SMTP id a66-20020a627f450000b02902059617a819mr3286098pfd.17.1616485002091;
        Tue, 23 Mar 2021 00:36:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0? ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
        by smtp.gmail.com with ESMTPSA id kk6sm1594441pjb.51.2021.03.23.00.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 00:36:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
Date:   Tue, 23 Mar 2021 00:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> I check it again. I still think the below patch can avoid the bug.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41 

I don't understand what you are saying...

> 
> The process:
> 1.nvme_ns_head_submit_bio call srcu_read_lock(&head->srcu).
> 2.nvme_ns_head_submit_bio will add the bio to current->bio_list instead 
> of waiting for the frozen queue.

Nothing guarantees that you have a bio_list active at any point in time,
in fact for a workload that submits one by one you will always drain
that list directly in the submission...

> 3.nvme_ns_head_submit_bio call srcu_read_unlock(&head->srcu, srcu_idx).
> So nvme_ns_head_submit_bio do not hold head->srcu long when the queue is 
> frozen, can avoid deadlock.
> 
> Sagi, suggest trying this patch.

The above reproduces with the patch applied on upstream nvme code.
