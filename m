Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 01:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiAJB4F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 20:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiAJB4E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 20:56:04 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA9C06173F
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 17:56:04 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h23so15505972iol.11
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 17:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N1Hze/0gAFtit4RBnMa7uJymkVW5vf+CPpKgxUVRGJk=;
        b=jZNFme+wt0hbFseEZD64JWez8fzfQnsqHXjVRI7EEAAFXwqC4QTgPKxmw8wI4vmE6Y
         WbuQLh61tHtZ2Tx4y5bvM4vWRU4UJ4loM2+reHKUzWsM13eeym3BUDMNbwVgfqMMD5jl
         gsfX6qGnXZKPWJTrDoMzFv9MMHm7NpxYswskx2pdHvIxyAMIwrnXzW5IE5pEQfzrZu9V
         D0A0kTQfdARZmaAtxB8vkJKewjJgud/BBqdLNEE2bL3tmyGsNVUvcVzBad0dmyNH+uM8
         OzqHqSPeTeXsL295p78T5m1dVbPVk7s7sGYv47pJuu/++LywsTgXzPuCPBxNWDw8ekl2
         0JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N1Hze/0gAFtit4RBnMa7uJymkVW5vf+CPpKgxUVRGJk=;
        b=WaL5j2N6Ct2fpxKTS7b0HXdRjIeZ8COFHrFRI+YKHOZ2uAL6gOTKOG6TYwgxjH3aeY
         ucWlcIFa78i5k4BsfzJJAoFxOC0UXXQBWumwnOn7EYTjShlgcEetJ7QQnEBm4zbWRP2f
         L9DyYeMHZ+dc8CzBVahzJkh0N+XQkP4ubzOv3BfsDxDDa70nJ0uWRbj4HYGOdVjkLnfF
         T31dGtU8WYqXgURouvafvUl3nM7KB5NCMWa6Jm7IOZ1QCSGuNBtBKdcAmQn6R+uzEsPS
         lY3xZHigKKs8rtJ+mupQKg4PiXUH8/XI1+qXTbHJkC6p6+ClAXd1ZiqoX9DgQcsefM09
         xslw==
X-Gm-Message-State: AOAM533hYd/X835CQHCnqpync2wglIX6hhRVVDFqR0V+UPcxU8azEXXs
        +sLooix2+3cfV9MMjg6wUkYHlw==
X-Google-Smtp-Source: ABdhPJzUtGgWydV0ly6pfPulpoaYXwhl5cWLj6dGJAk51WlZXXQryAT/dUQLyxGGMbYYF4RBHG3yqw==
X-Received: by 2002:a5e:da05:: with SMTP id x5mr34643009ioj.25.1641779763817;
        Sun, 09 Jan 2022 17:56:03 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o5sm2697188iow.8.2022.01.09.17.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 17:56:03 -0800 (PST)
Subject: Re: [PATCH] block: don't protect submit_bio_checks by q_usage_counter
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220104134223.590803-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9dd44dc4-ae0f-f2a6-0d83-72ddedc9deac@kernel.dk>
Date:   Sun, 9 Jan 2022 18:56:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220104134223.590803-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/4/22 6:42 AM, Ming Lei wrote:
> Commit cc9c884dd7f4 ("block: call submit_bio_checks under q_usage_counter")
> uses q_usage_counter to protect submit_bio_checks for avoiding IO after
> disk is deleted by del_gendisk().
> 
> Turns out the protection isn't necessary, because once
> blk_mq_freeze_queue_wait() in del_gendisk() returns:
> 
> 1) all in-flight IO has been done
> 
> 2) all new IO will be failed in __bio_queue_enter() because
>    q_usage_counter is dead, and GD_DEAD is set
> 
> 3) both disk and request queue instance are safe since caller of
> submit_bio() guarantees that the disk can't be closed.
> 
> Once submit_bio_checks() needn't the protection of q_usage_counter, we can
> move submit_bio_checks before calling blk_mq_submit_bio() and
> ->submit_bio(). With this change, we needn't to throttle queue with
> holding one allocated request, then precise driver tag or request won't be
> wasted in throttling. Meantime we can unify the bio check for both bio
> based and request based driver.

If you're now convinced it's fine, then I have no problems with it. This
basically reverts to the earlier version of what I had anyway.

-- 
Jens Axboe

