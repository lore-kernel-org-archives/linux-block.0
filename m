Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32836 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdB0SLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 13:11:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so14654093wmv.0
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 10:09:21 -0800 (PST)
Subject: Re: [PATCH 1/3] blk-mq: make blk_mq_alloc_request_hctx() allocate a
 scheduler request
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <dcfe49f597dc1eec3b326024c86a6ad3afb82fa8.1488217516.git.osandov@fb.com>
 <20170227175351.GF10715@vader>
Cc: kernel-team@fb.com
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ce8f071d-5575-75cf-65f6-3f221cfd05a5@grimberg.me>
Date: Mon, 27 Feb 2017 20:02:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170227175351.GF10715@vader>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> blk_mq_alloc_request_hctx() allocates a driver request directly, unlike
>> its blk_mq_alloc_request() counterpart. It also crashes because it
>> doesn't update the tags->rqs map.
>>
>> Fix it by making it allocate a scheduler request.
>>
>> Reported-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>> ---
>> I think this should do it. Verified that normal operation still works
>> for me, but I'm not sure how to test the actual _hctx() alloc path.
>> Sagi, could you please test this series out?
>
> Hm, Sagi, your mail server seems to have rejected patches 2 and 3
> because git-send-email duplicated the in-reply-to header for some
> reason. I've attached the patches instead.

Strange, I got the them.
