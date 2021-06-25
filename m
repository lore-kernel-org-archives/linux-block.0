Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C881C49EA6
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 00:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D85610C7
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 00:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhFYAqo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 20:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYAqo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 20:46:44 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262CC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 17:44:24 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s19so10595552ioc.3
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 17:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V3lA3j/Lq5+Kq9/i6UR975zcuw2/K62SF3/EF52LXms=;
        b=yhpdtpUpfc5vnfWTTejEpfq51lkfi4kxdhbzTYHbERJqkRT1h8BcrMHwK4Ym6uwDBq
         lGgH0/2eZYtHGuZZT43XDJk5eI5a/2n0RkzCh5PphpDfriZYjBb2SpZm+w26+/p1JZ3s
         NtWBCOO6AYrLq+89RIKqYNJti34DlatXYtKfZsCx9s2pXXsuoqQYm208FqhMSqlpCBu2
         86PRQ3XH5MLq/lZ0iBc2mBMRxzIXifijGzrAOO6pVOeFCUT+44EJsaei+YSDF5vSi+TR
         61B7/cOnc1Ag9tey8aPgrVkeyThjoWVDb4J/4mtFV0bYE7P7GSoDzKKlfNkWrupL6p3y
         snVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3lA3j/Lq5+Kq9/i6UR975zcuw2/K62SF3/EF52LXms=;
        b=uFtzdFpvk5JA19T18/zT9Ibz/QrX7GL1kMm69cWjHR+uUgMvs5zZtquOyc7dijBk1W
         T39ADAmUsvzGb/1wSW46DaTvQ+hUhaJMsO/LEsg3W7GO7z84Hf+yNlxMFXopLa0sQkh0
         gFXy5suusUX5mNnQWqW5DFJhIgPErVs36bPQrTG1906zqw/8aP/ucP1T+0kvGX9eX+B5
         jB1hx/puOe6otak0OyuubSzlQmenHkZ2QM7/nZZnrGlvRmENZRbKjwlZEu4pCPArGe8V
         lzzXjzVM+Rug7jY89boyN5dOl2NJdsVDKh6wszUSCk3iGjWZFffOaLjI8mYszmqecX4O
         PEYg==
X-Gm-Message-State: AOAM5307N5FN4KFn0rBK5hd2YR7tMt6wZCWdBBTHiaZprolXjzZkVcjz
        yC9a+pLnvRXy5+B3rGKrcX/gZQ==
X-Google-Smtp-Source: ABdhPJwA5g6rHV/YeLAr/Y2qn6RWmuhgI8WP6Fgy76L7/GXFc61rgzX3DE5Fz19HP3DlWwRTxch0Cw==
X-Received: by 2002:a02:956a:: with SMTP id y97mr7034437jah.58.1624581863783;
        Thu, 24 Jun 2021 17:44:23 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id w11sm2418690ilv.14.2021.06.24.17.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 17:44:23 -0700 (PDT)
Subject: Re: [PATCH 0/2 v4] block: Fix deadlock when merging requests with BFQ
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20210623093634.27879-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b15405cd-2640-58eb-2a0e-aa1b5d377899@kernel.dk>
Date:   Thu, 24 Jun 2021 18:44:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210623093634.27879-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/21 3:36 AM, Jan Kara wrote:
> Hello,
> 
> This patch series fixes a lockdep complaint and a possible deadlock that
> can happen when blk_mq_sched_try_insert_merge() merges and frees a request.
> Jens, can you please merge the series? It seems to have slipped through last
> time when I posted it. Thanks!

Applied, thanks.

-- 
Jens Axboe

