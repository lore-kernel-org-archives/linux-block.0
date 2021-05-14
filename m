Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAC9C433B4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BFF613C4
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 15:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhENPgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhENPgJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 11:36:09 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25759C061574
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:34:57 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l21so28481669iob.1
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0XoqNq3wdckeVYbYHT4TK5BDu5jac/VM8YZ6C3ci8As=;
        b=g1jCswHHVoMUYjtcLhLySiTmdBTMSxpPya2Xu7BwZNrF9ud02e3ZFBxCUTGc9l+e0e
         MuRxk3B4WQijaf1IX7OppiHYNI0DxgZdDF3xr+7GFlMgmMVW0cQm3PcnbA4r7ytmqPaQ
         hlTsFWi/CiG9waK8JX2PdWUmLQxCA9JNhYpW+wbVvORN2b4FaviP9RK0BsuNcGiBvzMA
         CuEE1kpbC/Zd9FCrICr6REbfBb4Q8BuooUmcgQ7R+nMnDwIuspf6Cq2ihrZoJcMO57au
         89KIoeA7GDp/LUN9jgpUNL/S7Clr6tH9Rzj9F7OM9Dua2uDW8sj0GcudhN7pu9uVId1Y
         G5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0XoqNq3wdckeVYbYHT4TK5BDu5jac/VM8YZ6C3ci8As=;
        b=UsmymLINHhpmsk8TGMK1Quc0PkFqRFqb4ISOdgNsCA0g2EEHlLv6m1t603zufe5+9I
         zNOp+8oDoM+AyP9mvqt+c7NQed3UgipoTkM3eWtgYiC63BPa9VZnFpo706mTuJnFMIFW
         y+VENEOKmT557IvsIS+W9bchglViuaZs9rO2WMOo6cEnYQBkQdzfaiP0v/hZVyNy1hAf
         cocEzS9Y3PYusf+4OFyQO+SDKq3wBbYXCeRetCTwbNQxkYgheiw5wEZeqH+4uFNS3R5K
         ur7KvrVLOBLYycyXwlmzZJc6AvnyE4se7/HpYI3V10Zv3K0pCqhP2552+gjlzMaAHmKw
         FyYQ==
X-Gm-Message-State: AOAM530Auo7WphDX6UdWTSrlw5Lp9yMPyrKOzakPylaPdwzUPUv5le0t
        5FDylzafV6rVsB+kGlM1ZYgd8Q==
X-Google-Smtp-Source: ABdhPJx7LJD3ini8jWiDoey8ypkr8QoPBmMX8Qq82yB+IaV/glxX3nvjMDMkC6tgVfH09ll/jSAe5Q==
X-Received: by 2002:a05:6602:70d:: with SMTP id f13mr36770182iox.16.1621006496577;
        Fri, 14 May 2021 08:34:56 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm3207059ilt.60.2021.05.14.08.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:34:56 -0700 (PDT)
Subject: Re: [PATCH V7 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210511152236.763464-1-ming.lei@redhat.com>
 <YJ3Htj8rlJ6uunqn@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <053a3b7f-20cb-5494-7823-33a2da996feb@kernel.dk>
Date:   Fri, 14 May 2021 09:34:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJ3Htj8rlJ6uunqn@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/21 6:43 PM, Ming Lei wrote:
> On Tue, May 11, 2021 at 11:22:32PM +0800, Ming Lei wrote:
>> Hi Jens,
>>
>> This patchset fixes the request UAF issue by one simple approach,
>> without clearing ->rqs[] in fast path, please consider it for 5.13.
>>
>> 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
>> and release it after calling ->fn, so ->fn won't be called for one
>> request if its queue is frozen, done in 2st patch
>>
>> 2) clearing any stale request referred in ->rqs[] before freeing the
>> request pool, one per-tags spinlock is added for protecting
>> grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
>> in bt_tags_iter() is avoided, done in 3rd patch.
>>
>> V7:
>> 	- fix one null-ptr-deref during updating nr_hw_queues, because
>> 	blk_mq_clear_flush_rq_mapping() may touch non-mapped hw queue's
>> 	tags, only patch 4/4 is modified, reported and verified by
>> 	Shinichiro Kawasaki
>> 	- run blktests and not see regression
> 
> Hi Jens,
> 
> We have been working on this issue for a bit long, so any chance to get
> the fixes merged? Either 5.13 or 5.14 is fine.

Let's get it queued up for 5.14 - we can backport to stable as needed.
I'll do that now.

-- 
Jens Axboe

