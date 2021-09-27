Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1E1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 02:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFFA61100
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 02:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhI0Cjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Sep 2021 22:39:46 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33363 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhI0Cjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Sep 2021 22:39:46 -0400
Received: by mail-pf1-f178.google.com with SMTP id s16so14512265pfk.0
        for <linux-block@vger.kernel.org>; Sun, 26 Sep 2021 19:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bEhBj8CtzjHnu7t0TmIMWbMSgY7RZLWPqqEgOvyB36k=;
        b=s+KhJxpMcPzwv3gcn7YG7yOt/YDMfCy3+BvbDKBvwXx5zF7vCn4zJcB5yqwMgV8eBd
         5DU5J2lgkbXbXRWKHME4vvwIcH6/12ECGw8Brnxed8d8M5vuBOloZZ79pjDeLXF55s64
         hNKly6JB0XB5pLc+inrDUeEEdQ75BPFdcDeQDvKCcbCXPUPg4FP1fskbbRvPKuHkAHm8
         oPML+PY+hR25axFPfnkv3JgJziBN1EGlw7Cc2yzZFAstqFeDKcXxnRG2EpRIdYvJkT05
         DL6mARpRAVY67FQav0zr1gQTZvobwwX9C5UfUQF5xFxLkDgNhSFulxUZUtdMEQVLJWPY
         Ab/A==
X-Gm-Message-State: AOAM531Ev/5Y8pqHPQbW6n1wt26tCiG6Awx0EV7kCwpFr00hl/r/xoLF
        SDvRAQ5AiVbP5MaBHKEuFbA=
X-Google-Smtp-Source: ABdhPJySyz4av+DouGvvUupvtr7a0l1jIblfhKjImiVMOtM79dI2ESpC/WNmr5SRKiZ5fPGJW3TpJw==
X-Received: by 2002:a63:ef01:: with SMTP id u1mr14504974pgh.336.1632710288906;
        Sun, 26 Sep 2021 19:38:08 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:e864:8ed1:d30b:31ff? ([2601:647:4000:d7:e864:8ed1:d30b:31ff])
        by smtp.gmail.com with ESMTPSA id q11sm14467026pjf.14.2021.09.26.19.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 19:38:08 -0700 (PDT)
Message-ID: <9997e3dc-44f8-1884-04f9-fc43dc655d5d@acm.org>
Date:   Sun, 26 Sep 2021 19:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/4] block/mq-deadline: Stop using per-CPU counters
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
 <20210923232655.3907383-3-bvanassche@acm.org>
 <DM6PR04MB7081B7096944F8115A8BE2B6E7A49@DM6PR04MB7081.namprd04.prod.outlook.com>
 <81cd7cea-6060-4500-8af3-cd324aef61de@acm.org>
 <6d52ad94-36af-cce6-afaa-8d0a49939d2e@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6d52ad94-36af-cce6-afaa-8d0a49939d2e@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/21 17:19, Damien Le Moal wrote:
> Another thing: in patch 3, you are actually not handling the overflows. So
> dd_queued() may return some very weird number (temporarily) when the inserted
> count overflows before the completed count does. Since
> dd_dispatch_aged_requests() does not care about the actual value of dd_queued(),
> only if it is 0 or not, I am not 100% sure if it is useful to fix. Except maybe
> for sysfs attributes ?

Hmm ... I'm not following. I think it can be proven mathematically that
dd_queued() returns a number in the range [0, max_queued_requests). Here is
an example:
* inserted = 1 (wrapped around).
* completed = UINT32_MAX - 1 (about to wrap but has not yet wrapped around).
* dd_queued() returns 2.

Bart.
