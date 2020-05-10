Return-Path: <SRS0=ZTaq=6Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E3C54E49
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 07:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED82E208DB
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 07:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgEJHo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 03:44:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34319 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgEJHo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 03:44:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so2621560pfa.1;
        Sun, 10 May 2020 00:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8vEftalko3e/aSL2c6EH2GiC1/kTRGdDwSPX8vzJhg=;
        b=iixYWzUgYkxtavgLVmsfKuomXANpQLY63kW6qXK5OOIlxEBbZQ18i2yQfc0QTlzfz1
         53pjSV2cok3NCtpxi14+zhfKIFeFg6hETP9OIcabRNJKap+cl48dBQAQSzvjdfRNLH8p
         oMaemyakFux7hPMEt+DdYCCi8AdeKxfEdOmGALR/rMGwSTSFeUe5JiNsdCIFiTHzjPRb
         +CVbEXSnXXjJ9K/dbnc9CzK5LukZ5OIp/woZbezVu+UlUR1PFQZnoDFDJDeVdiUMX1HU
         Kyz7qt0gmriM0xPidLBVExCmTfTq11ysRX4ciO5+HhlwwiVV8+DzT+CKa4BKhsvOrcqK
         P04w==
X-Gm-Message-State: AGi0PubF7yyS5IL0hFHQfRRIShvuuxy/AhZE2cFVF/eqrbsaoXyo+cyk
        8kKsbRsV7p+BiK3KHnB943dHMK3O
X-Google-Smtp-Source: APiQypK5Et3TG3oVbt6bqscsJwAt2oZBp9J+aYp03GcjOcqNfEAG0O/5M6TovGK2yKQkUipEQRxbgA==
X-Received: by 2002:a63:d610:: with SMTP id q16mr9534050pgg.370.1589096696506;
        Sun, 10 May 2020 00:44:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:84d8:c040:9a38:e659? ([2601:647:4802:9070:84d8:c040:9a38:e659])
        by smtp.gmail.com with ESMTPSA id a33sm2052000pgl.92.2020.05.10.00.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 00:44:55 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
To:     Ming Lei <ming.lei@redhat.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
 <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
 <20200509094306.GA1414369@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6579459b-aa98-78f2-f805-a6cd46f37b6c@grimberg.me>
Date:   Sun, 10 May 2020 00:44:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509094306.GA1414369@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> You're mostly correct. This is exactly why an I/O scheduler may be
>>>> applicable here IMO. Mostly because I/O schedulers tend to optimize for
>>>> something specific and always present tradeoffs. Users need to
>>>> understand what they are optimizing for.
>>>>
>>>> Hence I'd say this functionality can definitely be available to an I/O
>>>> scheduler should one exist.
>>>>
>>>
>>> I guess it is just that there can be multiple requests available from
>>> scheduler queue. Actually it can be so for other non-nvme drivers in
>>> case of none, such as SCSI.
>>>
>>> Another way is to use one per-task list(such as plug list) to hold the
>>> requests for dispatch, then every drivers may see real .last flag, so they
>>> may get chance for optimizing batch queuing. I will think about the
>>> idea further and see if it is really doable.
>>
>> How about my RFC v1 patch set[1], which allows dispatching more than
>> one request from the scheduler to support batch requests?
>>
>> [1]
>> https://lore.kernel.org/patchwork/patch/1210034/
>> https://lore.kernel.org/patchwork/patch/1210035/
> 
> Basically, my idea is to dequeue request one by one, and for each
> dequeued request:
> 
> - we try to get a budget and driver tag, if both succeed, add the
> request to one per-task list which can be stored in stack variable,
> then continue to dequeue more request
> 
> - if either budget or driver tag can't be allocated for this request,
> marks the last request in the per-task list as .last, and send the
> batching requests stored in the list to LLD
> 
> - when queueing batching requests to LLD, if one request isn't queued
> to driver successfully, calling .commit_rqs() like before, meantime
> adding the remained requests in the per-task list back to scheduler
> queue or hctx->dispatch.

Sounds good to me.

> One issue is that this way might degrade sequential IO performance if
> the LLD just tells queue busy to blk-mq via return value of .queue_rq(),
> so I guess we still may need one flag, such as BLK_MQ_F_BATCHING_SUBMISSION.

Why is that degrading sequential I/O performance? because the specific
device will do better without batching submissions? If so, the driver
is not obligated to respect the bd->last/.commit_rqs, so if that is the
case, it should just ignore it.
