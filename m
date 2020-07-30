Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8339C433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBC020838
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 21:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgG3VDF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:03:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33229 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgG3VDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 17:03:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id i92so3860116pje.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 14:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YadpvRPknONejplDlvDoARzWV8G+hOuFcbzau+t61t0=;
        b=kEvMTMNPWtMbXIHD7+/K6oGP117233QTAtbArBXbve8VQDArPCh2ZoXxzfQ4vsDbOZ
         1phxtUuv5t4zi5+KE+rxZgFVjiQCCHq+ruhy4JAl2oC8TYSNPqFiFbnjqm9okgoBKshY
         FQDwrcMjPHg0iwa9Pqu0YeOCleZmFhH2HwBBNt3MOA1N4XD+vLmWpZLHDlAur5XHayNB
         hlU9j8E7OnZhVeJ7M9ErT0LcDPjTIuC0gnOP2n7ZdZ8TdFZ44eAf+hLyC/YTb9qKnwlQ
         F2mCJ6PyM80f26b8X3C5tqCl5e0p6KOp/MrFGuBLa1rGeiSNGy2OzsEoS6ic1s8MolpZ
         V7bg==
X-Gm-Message-State: AOAM533bR6OZl90yZbtUOF512XWfr7Mof4Y7T5FnW2FM9FAyppUnNAzE
        9etoaEPSOHejilZiTtF+ZYg=
X-Google-Smtp-Source: ABdhPJx3B9gIqfdDAREX988lNXh08n+9GYpvgb76Xz4skD5vRY3SPrFuKit2Cza1qTzSWK5qk9EsqA==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20mr916561plo.241.1596142984676;
        Thu, 30 Jul 2020 14:03:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9d7e:b2ea:15f4:b0b0? ([2601:647:4802:9070:9d7e:b2ea:15f4:b0b0])
        by smtp.gmail.com with ESMTPSA id t17sm7413951pgu.30.2020.07.30.14.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 14:03:03 -0700 (PDT)
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
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
 <761aa0f7-2e3f-d083-a32f-7c26ef2cd858@grimberg.me>
 <20200730192701.GC147247@dhcp-10-100-145-180.wdl.wdc.com>
 <05f75e89-b6f7-de49-eb9f-a08aa4e0ba4f@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d8b3c882-098c-eb7a-06b9-46d3f05f72fb@grimberg.me>
Date:   Thu, 30 Jul 2020 14:03:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <05f75e89-b6f7-de49-eb9f-a08aa4e0ba4f@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>>> I think it will be a significant improvement to have a single code path.
>>>>>>> The code will be more robust and we won't need to face issues that are
>>>>>>> specific for blocking.
>>>>>>>
>>>>>>> If the cost is negligible, I think the upside is worth it.
>>>>>>>
>>>>>>
>>>>>> rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
>>>>>> and I don't think percpu_refcount is better than it, so I'd suggest to
>>>>>> not switch non-blocking into this way.
>>>>>
>>>>> It's not a matter of which is better, its a matter of making the code
>>>>> more robust because it has a single code-path. If moving to percpu_ref
>>>>> is negligible, I would suggest to move both, I don't want to have two
>>>>> completely different mechanism for blocking vs. non-blocking.
>>>>
>>>> FWIW, I proposed an hctx percpu_ref over a year ago (but for a
>>>> completely different reason), and it was measured as too costly.
>>>>
>>>>     https://lore.kernel.org/linux-block/d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk/
>>>
>>> If this is the case, we shouldn't consider this as an alternative at all,
>>> and move forward with either the original proposal or what
>>> ming proposed to move a counter to the tagset.
>>
>> Well, the point I was trying to make is that we shouldn't bother making
>> blocking and non-blocking dispatchers use the same synchronization since
>> non-blocking has a very cheap solution that blocking can't use.
> 
> I fully agree with that point.

I also agree, just said we should use the same mechanisms, IFF its not
expensive. But I'm concerned that if we use completely different 
mechanisms we are likely to get wrong assumptions and break one at some
point.

Hence my suggestion to move back to srcu and place the rcu_head in the hctx.
