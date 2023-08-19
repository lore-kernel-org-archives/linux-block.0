Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAE8EE49A5
	for <linux-block@archiver.kernel.org>; Sat, 19 Aug 2023 13:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjHSNu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Aug 2023 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHSNu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Aug 2023 09:50:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1F7A5C1
        for <linux-block@vger.kernel.org>; Sat, 19 Aug 2023 06:49:40 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc9353be9bso187769a34.1
        for <linux-block@vger.kernel.org>; Sat, 19 Aug 2023 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692452980; x=1693057780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/B6UoozTgOvnZDnxvKImlq9ysTnzY+A8aabIbXLECc=;
        b=ysEPnZ2wprO0ADtzkzFOQbi7bEuESJ1oyXnNd6Eu23By6wTNHjH4fDZx3zPpgJQczq
         0I3TXeDp5C6tVxw3uM7aTSPAYA03ihPLYtcR0VDidIoSySeemZrSGLverCzXaTzYx79F
         KQ7RENQd9GfXw1N7024GodNHyJ3NJVzX6dDjH1pRTMgLdamvF1zGo9q0MJAlpxLAGMci
         G/kQPyFD++2gJETmXPg+BSN0rD2lnYJNX3bB57w+aV3/O/iuZeYuMyOEdEM5JJLOhWKv
         81FarjqGZ4mX79INTv2PeipQR8BjfVELg0LWyEf26VN3Z1A0rC4PLwwaRVVstv7wMRQE
         EAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692452980; x=1693057780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/B6UoozTgOvnZDnxvKImlq9ysTnzY+A8aabIbXLECc=;
        b=U7gtknYoOIKrq6xZG6n+FLm0z8fhozS9wQyyROel8aX7nLo8p2DItWZ94UJjcyZlQY
         fMfSx6jMcj2evAfiSOhPffTJ8tk238xW9m4WLI57lk1tfgkUKn7I4XQNZ+mIn0KQYMcH
         g6lqEw/jhAGyW3LJPunJYhe5TJFsO/Rj1lc5SBdJsNrj+QmZhJ1qoqhUr3SWE6CwxAop
         yjbwxTUd+yQ/iZYCQWm4neOz3HJ73wkubjBgBX6CzXEWr1K13LPEMoT5AdVd7VrD6HyS
         snT3dxsYY4CXfnjrICQubTYOoF9V2Qrqzryl+OryKyNrVBy3hEoYo1TPqnqflIjMMR3F
         sTWg==
X-Gm-Message-State: AOJu0YysVPbnl7yYSzJQIGsyh3f8ZRgRIAh4NqzcM3n5vCTq9P7O4IUM
        TzNhpl/yOBxLp8Smtfyl2q0qpQ==
X-Google-Smtp-Source: AGHT+IEvvRLkc8kEmD2lgUo1aiyAPBpFrWPhmPLSWQOJ/warFZK5d4mY9EP3phvx8nF6CuIPv7vQew==
X-Received: by 2002:a05:6870:330a:b0:1bf:9fa2:bfa3 with SMTP id x10-20020a056870330a00b001bf9fa2bfa3mr2603134oae.1.1692452978347;
        Sat, 19 Aug 2023 06:49:38 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b002693505391csm4895881pjt.37.2023.08.19.06.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 06:49:36 -0700 (PDT)
Message-ID: <05ce0ba0-9c34-4da4-b8d0-e1b5a1c6c125@kernel.dk>
Date:   Sat, 19 Aug 2023 07:49:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: fix mismatch between IO scheduler insert and
 finish
Content-Language: en-US
To:     chengming.zhou@linux.dev, hch@lst.de, bvanassche@acm.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, chuck.lever@oracle.com, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>
References: <20230819031206.2744005-1-chengming.zhou@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230819031206.2744005-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/23 9:12 PM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> IO scheduler has requirement that one request which has been inserted
> must call finish_request() only once.
> 
> Now we have three special cases to consider:
> 1. rq has not insert, has complete: e.g. empty preflush
> 2. rq has insert, has not complete: e.g. merged requests will be freed
> 3. rq has insert, has twice complete: e.g. postflushes
> 
> Note case 1 which existed before, has been no problem since all the
> schedulers will check in their finish_request() if the rq has been
> inserted or not, like checking "rq->elv.priv[0]".
> 
> Then case 2 and case 3 are the introduced regression, we moved the
> scheduler finish_request() from free phase to complete phase to solve
> a deadlock problem. But it caused no finish_request() for request in
> case 2, and double finish_request() for request in case 3.
> 
> So we still need finish_request() in blk_mq_free_request() to cover
> case 2. And clear RQF_USE_SCHED flag to avoid double finish_request().
> It should be fine since we're freeing the request now anyway.
> 
> Of course, we can also make all schedulers' finish_request() to clear
> "rq->elv.priv[0]" to avoid double finish. Or clear it in blk-mq, make
> the rq like not inserted as case 1.
> 
> FYI it's easy to reproduce warning in mq-deadline using this:
> ```
> DEV=sdb
> echo mq-deadline > /sys/block/$DEV/queue/scheduler
> mkfs.ext4 /dev/$DEV
> mount /dev/$DEV /mnt
> cd /mnt
> stress-ng --symlink 4 --timeout 60
> echo none > /sys/block/$DEV/queue/scheduler
> ```
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308172100.8ce4b853-oliver.sang@intel.com
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

I folded in this one and added a link to it as well, final result is here:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=e5c0ca13659e9d18f53368d651ed7e6e433ec1cf

I'll get this sent off today.

-- 
Jens Axboe

