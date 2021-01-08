Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D82C433DB
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 15:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13412239EB
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 15:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbhAHPVV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 10:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbhAHPVT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 10:21:19 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5CC061380
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 07:20:39 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x15so10644834ilq.1
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8zCsmPDJQdJDnkQKZejQHJWw0dwAHVEo5bCx7sWw+Us=;
        b=f3/KYLt/J0hCYtwNhNQq+jNhIOIWqktI64HygeRj75qq1fPnhgIkN6NSbXBwf3AFJV
         dpswdSOXhnqXsIrqnRhxjdPs/6B9KDV9xd/HUsY7RwiPnV9CYPDuannIRoPOfnDzmipr
         xeOl3gqtigloxFfCU2BiU5hWGcYKkMWMudttgRY1ZHmUSaZMy+ChjbBMY1DDQNlRbSOl
         N0VymzHgJ7JTmAoklloysMoGESJ+v24My6ef/zOHq7MtfKWgC6AVFaaIVpuoeFes3Lnj
         DLyhgGlXd/7LXcRJhZGRkVD9s3J6a5ix56LXsx6k4roNiMHZOp6WA911hlGnYtpbAv6f
         dgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8zCsmPDJQdJDnkQKZejQHJWw0dwAHVEo5bCx7sWw+Us=;
        b=aSoVwSd2E9eninfxerWAmzXcZz9MtA7laOptu89r1ds2AGKOI6RnI/VTWXxRXgtVyi
         JHFxRWoTRz3zcWquNMENrfADrJtbujB59ruSsaIF0daSJWwoyFCyMb3hgfPKfogjsJOJ
         vIGLEW5rWdW+bdMmGRZyO7WUyk+0hsDUaFfQVfOgUXymWRIRnLcNqT6WLnGgY3Gkni/H
         Is1WaWOubvsMSRNy/viSUpY3qrnu8Ago3bqxsElsnVDTXuc49HDwAH7R0Ch52LzzSViJ
         WdcTbUE5JUte/cGa3pUTC/AT0kf/FnmoSPcI7ogu8PJ+8okFJmwzfs97yNcz+0cZ0Zyn
         6OuQ==
X-Gm-Message-State: AOAM5317RenCBnEXvRGd+N1OuVWDEtotnQJADQJl9TJ5OFs/T7nUwO8E
        f/UtVcCAACslijDP+In95DZIoQ==
X-Google-Smtp-Source: ABdhPJwLHghE+FJPmb5oqFCSqhecGE7My9bkts6MyHEwGH3AtUS5gKdtSmwdByWeukzwHGaxC9YDhA==
X-Received: by 2002:a92:d84a:: with SMTP id h10mr4088593ilq.77.1610119238421;
        Fri, 08 Jan 2021 07:20:38 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm5364829ioh.3.2021.01.08.07.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:20:37 -0800 (PST)
Subject: Re: [PATCH] blk-mq-debugfs: Add decode for BLK_MQ_F_TAG_HCTX_SHARED
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1610096137-187414-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0fa03b0-55b3-c4aa-6a8f-ac8b9afd6d13@kernel.dk>
Date:   Fri, 8 Jan 2021 08:20:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610096137-187414-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/21 1:55 AM, John Garry wrote:
> Showing the hctx flags for when BLK_MQ_F_TAG_HCTX_SHARED is set gives
> something like:
> 
> root@debian:/home/john# more /sys/kernel/debug/block/sda/hctx0/flags
> alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|3

Applied, thanks.

-- 
Jens Axboe

