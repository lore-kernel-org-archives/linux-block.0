Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34997C433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 16:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1982F20829
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 16:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgG3QKz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:10:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34685 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgG3QKz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 12:10:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so25468839wrw.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 09:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9s3tkWHkOAEpkDIzv/j8SSeEIjQRVfELEcdZ9Sis/ys=;
        b=H+uXUG5gienwRcRKDkNAUx8z9m8PL7jMDr2sStaX42oAV5U3xrWFdWozMBF/vtx1Mq
         tFwOgMFz679q6HlN7Rw/wzrdfyJguAiYrosGhRZnl1poPwVfU7cSkdpqWiNATpGuWW6e
         +HBbuL3yLz7qlQ8vr/4X8LvW1t0+tVRMrdn/s4THqWCYSXSQ/y5bMmSEwBjWdfvzM1eE
         hwjU/T6NWxUNgHr8M+IfL/uHb0XSD/fYn+cJay/0NesVdDeU7jbV6CrurK48oOASahSO
         w92+RPkBMnlsaTBxVT7flZkEb72n57u1lMHrqcjhYd85x8Gv4495r5zMrj6Gm9y6Js9k
         1KPA==
X-Gm-Message-State: AOAM5325ROXywdY+1K3FuH+q5pNak16FQvNJrYEu9SQOVx2uH5ltUeQs
        B8CMWh+bYiNnUy/fi0YauAI=
X-Google-Smtp-Source: ABdhPJzXk6jYC93kFknNUf1tJXhdUMk5yo5MFtKkg6DynuYU+CPDELgf7eE+k/YsuwIguhDgbcQ6jw==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr3717928wra.118.1596125452811;
        Thu, 30 Jul 2020 09:10:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:11db:a722:81b1:7143? ([2601:647:4802:9070:11db:a722:81b1:7143])
        by smtp.gmail.com with ESMTPSA id u6sm2694377wrn.95.2020.07.30.09.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 09:10:52 -0700 (PDT)
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
Date:   Thu, 30 Jul 2020 09:10:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730145325.GA1710335@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>> In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
>>>>>> section during dispatching request, then request queue quiesce is based on
>>>>>> SRCU. What we want to get is low cost added in fast path.
>>>>>>
>>>>>> However, from srcu_read_lock/srcu_read_unlock implementation, not see
>>>>>> it is quicker than percpu refcount, so use percpu_ref to implement
>>>>>> queue quiesce. This usage is cleaner and simpler & enough for implementing
>>>>>> queue quiesce. The main requirement is to make sure all read sections to observe
>>>>>> QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
>>>>>>
>>>>>> Also it becomes much easier to add interface of async queue quiesce.
>>>>>
>>>>> BTW, no obvious IOPS difference is observed with this patch applied when running
>>>>> io on null_blk(blocking, submit_queues=32) in one dual-socket, 32cores system.
>>>>
>>>> Thanks Ming, can you test for non-blocking on the same setup?
>>>
>>> OK, I can do that, but this patch supposes to not affect non-blocking,
>>> care to share your motivation for testing non-blocking?
>>
>> I think it will be a significant improvement to have a single code path.
>> The code will be more robust and we won't need to face issues that are
>> specific for blocking.
>>
>> If the cost is negligible, I think the upside is worth it.
>>
> 
> rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
> and I don't think percpu_refcount is better than it, so I'd suggest to
> not switch non-blocking into this way.

It's not a matter of which is better, its a matter of making the code
more robust because it has a single code-path. If moving to percpu_ref
is negligible, I would suggest to move both, I don't want to have two
completely different mechanism for blocking vs. non-blocking.

> BTW, in case of blocking, one hctx may dispatch at most one request because there
> is only single .run_work, even though when .queue_rq() is slept, that said
> blk_mq_submit_bio() queues bio in sync style. This way won't be very efficient.
> So percpu_refcount should be good enough for blocking code path, but may not be
> well enough for non-blocking case.

Not sure what you mean, the percpu_ref is taken exactly where rcu is
taken, not sure what is the difference.
