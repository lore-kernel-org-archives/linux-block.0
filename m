Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7681C433DF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBE22084D
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 18:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgG3SYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:24:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44571 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgG3SYF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 14:24:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id b6so25772552wrs.11
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 11:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9XH9OWkRt03mcWxWchgKk72hR3XSd5GOhc/vd+KP40=;
        b=D8/RcXhd5LXtHEshoqNtm5jBxmCAyStaLGIIod5fKVAlzgPI4POJ9BZpfVNnbyKelm
         jqXJVHOhVtXBWcSKxlEwwjxvQwzCWM3lHT7YZfPCcN8wKgZjd2kuvV8iFSMjWiMlS9NJ
         P94rAPViuIArABmTqqi6S/Lqog/ps0KgyS9G16BCAABEkVqslnrkV49z53P9gqoZydHM
         AjEySN4doJPTkiHfogO7iV0m7d0GNt5q6UrwRYimJLIaJxLpiWMkxNac1w9XeKWixrfg
         l8nsXmaDsiP3oegwKx3akpxN1eKUM0f761qgJY5O7o4d+5O3CmyI9etBmQfEKgCW/fkn
         Oa9Q==
X-Gm-Message-State: AOAM531rH2NPnV2RMmLnHVpqpeP8TleO+b7ddp/E6p9LmEgbdIk7rqJy
        4zmzzXLFwBXPDWLFi+4OrnM=
X-Google-Smtp-Source: ABdhPJwBjZAhohloAXKZ4tNaxbQOwUEO9QA+Q0h/0rLU+Fcz/bVYTX/hXklwwfErFbrR2w+RvYL5yQ==
X-Received: by 2002:a5d:4947:: with SMTP id r7mr39505wrs.165.1596133443833;
        Thu, 30 Jul 2020 11:24:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:11db:a722:81b1:7143? ([2601:647:4802:9070:11db:a722:81b1:7143])
        by smtp.gmail.com with ESMTPSA id d21sm1104903wmd.41.2020.07.30.11.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 11:24:03 -0700 (PDT)
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
 <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
 <20200729154957.GD1698748@T590>
 <f3ead535-070d-40ec-08b8-56e2c1cd7ba4@grimberg.me>
 <20200730145325.GA1710335@T590>
 <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
 <20200730181857.GA147247@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <761aa0f7-2e3f-d083-a32f-7c26ef2cd858@grimberg.me>
Date:   Thu, 30 Jul 2020 11:23:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730181857.GA147247@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> I think it will be a significant improvement to have a single code path.
>>>> The code will be more robust and we won't need to face issues that are
>>>> specific for blocking.
>>>>
>>>> If the cost is negligible, I think the upside is worth it.
>>>>
>>>
>>> rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
>>> and I don't think percpu_refcount is better than it, so I'd suggest to
>>> not switch non-blocking into this way.
>>
>> It's not a matter of which is better, its a matter of making the code
>> more robust because it has a single code-path. If moving to percpu_ref
>> is negligible, I would suggest to move both, I don't want to have two
>> completely different mechanism for blocking vs. non-blocking.
> 
> FWIW, I proposed an hctx percpu_ref over a year ago (but for a
> completely different reason), and it was measured as too costly.
> 
>    https://lore.kernel.org/linux-block/d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk/

If this is the case, we shouldn't consider this as an alternative at 
all, and move forward with either the original proposal or what
ming proposed to move a counter to the tagset.
