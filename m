Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9650FC433E3
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C462074F
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 18:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgG0Si2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:38:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43115 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgG0Si1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 14:38:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id f185so4629314pfg.10
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 11:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nh+OsIVvLKpFN+3Qhgvq25K37TE7YLi6IxL8rajsPT4=;
        b=qsC2JfVYQRsvd14sCQdPM0/dVLsPwvRsb6b8wG3gEJEAAl8njb0VMBPhaBPYBv6u8g
         AR4gEoYLwMLW0IgDlOQCzSF9ka6wgYdpsZrs05iUoJxywZyrOJ7T/kWZ9YMzWjgG5oba
         +GqSRT9iQLgQaeD+QfSSMH9oy/mpXOW6bkk0V/FJzEBdz9pUqM2XpzU26xStLBMPkKrl
         cONqxJOohZL4bo7lalvf0N0EjMmVmBRnnw8nJMGBWTGN1KZtq1jBl7EL5ZJonBH7Jylm
         s9fACNYWxX7lEp/jbR3ITdfcK9hSs0FTEk3M/O8Rj4xkf2qB79d7ff8nHoYOKgybgBuJ
         AKGw==
X-Gm-Message-State: AOAM5323Ka6aoQ9nBg3UL8Tuwo5JiFnCVuDhVzJKUcs7TFA4FPu9jRnq
        9heqdN5LDQXUOQwsc0H0xp0=
X-Google-Smtp-Source: ABdhPJzD7/cr7OUej7K+jSeHTwN1VyUg5j4U2E3rOwz2+LC65MvE2g+TBJSi1qJhETkxRsUrMr34xA==
X-Received: by 2002:a63:338c:: with SMTP id z134mr20574979pgz.245.1595875107026;
        Mon, 27 Jul 2020 11:38:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id a2sm15638799pgf.53.2020.07.27.11.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:38:26 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
 <20200727035033.GD1129253@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c27dab04-81e3-d2bb-351d-d934282147b4@grimberg.me>
Date:   Mon, 27 Jul 2020 11:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727035033.GD1129253@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> On 2020/7/27 10:08, Ming Lei wrote:
>>>> It is at the end and contains exactly what is needed to synchronize. Not
>>> The sync is simply single global synchronize_rcu(), and why bother to add
>>> extra >=40bytes for each hctx.
>>>
>>>> sure what you mean by reuse hctx->srcu?
>>> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
>>> to each hctx for just simulating one single synchronize_rcu().
>>
>> To sync srcu together, the extra bytes must be needed, seperate blocking
>> and non blocking queue to two hctx may be a not good choice.
>>
>> There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
>> Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
>> not need if which do not need batch sync srcu, I still think it's better
>> for the SRCU to provide the batch synchronization interface.
> 
> The 'struct rcu_synchronize' can be allocated from heap or even stack(
> if no too many NSs), which is just one shot sync and the API is supposed
> to be called in slow path. No need to allocate it as long lifetime variable.
> Especially 'struct srcu_struct' has already been too fat.

stack is not possible, and there is zero justification for this to go to 
every srcu user out there...
