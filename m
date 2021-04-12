Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F9C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DD161261
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhDLMxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbhDLMxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 08:53:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B3C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:52:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14so1751695pjl.5
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OCA7mv5qC5017rl8fdArjmg8eI3IwufSfeA2oRPttk8=;
        b=pzfBAdpTyoa1uq+1q/lrhlCZ3v4zkbFz9OqQxAuBQb2zdVJM0sjYIadd2zKCUE1Sfh
         UeMmAeSSwnNJgYyeJsOImC9nlKhQsro+/vuBVRsFHQZYD5WzVP2FvQIMdXfHNkYMPGfm
         oElP9Wea45bqWAONfvk4kwKrsdPM2B7cNYwVj7dFR2wozBaOXRoOelCbB65PE4GlteSP
         RUnhkuWfL8/eajHFn6M2vYO03A6K1nTKgm3Dtt02bU2E33qddbkkD8e6EqqiJmYgXD/q
         443sgQsGDaanLXeQi+9i9z1XxMfV+6/SehwiWD6EXrhQxxOeOEWF3YNFJjGF+1Dsyz+F
         cliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCA7mv5qC5017rl8fdArjmg8eI3IwufSfeA2oRPttk8=;
        b=DGAHai8dQH2JRq6y1eeDqt7X5DarEU8Ty73cQD/7QCrJFd6WEFbprC4gWFqBXIys8e
         vMBBs7d4MPl+txja02S2LLmkxjjZed8e5QppMUzez+xA5jqgz3rWnOZkEr/Q4K1EW9so
         rwSBwwiRaa89znHS5Chc63bd2DUIdjNz4AVE5Uu+p4dk9NrKlwsRjmdeECY6eXxsHVzA
         FDgZAv9fRyPwFUZnM8LFCUQ5V0gG2/7Rk1eMarXlKeG1RGCwK1bpecGCmUoW4UytSJFh
         LE2VNleb80lr2ciuX+d0r4XJ9LRnJoTnh+wV72HshC8l67+u5ovO51tQdDA3zykQnk35
         kXeA==
X-Gm-Message-State: AOAM533taoAPscBr0clQljuMB8MxMh8ZVE9jbMc9U628fW2N1AgkMwpP
        wbqKnAaGMhBP0AOqZCiM5RRong==
X-Google-Smtp-Source: ABdhPJzLeLhBK66Nk4wwr1Qi+u5TGbrkSfojT0jims78QJOK4i1N/PgGldHlpVMOayemChkC/u0Vvw==
X-Received: by 2002:a17:90a:e54c:: with SMTP id ei12mr21732716pjb.164.1618231973836;
        Mon, 12 Apr 2021 05:52:53 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t12sm11687259pga.85.2021.04.12.05.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:52:53 -0700 (PDT)
Subject: Re: [PATCH V5 10/12] block: add queue_to_disk() to get gendisk from
 request_queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-11-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ba2f989-8294-cdf1-09a8-11cae5f4f03e@kernel.dk>
Date:   Mon, 12 Apr 2021 06:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401021927.343727-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/21 8:19 PM, Ming Lei wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Sometimes we need to get the corresponding gendisk from request_queue.
> 
> It is preferred that block drivers store private data in
> gendisk->private_data rather than request_queue->queuedata, e.g. see:
> commit c4a59c4e5db3 ("dm: stop using ->queuedata").
> 
> So if only request_queue is given, we need to get its corresponding
> gendisk to get the private data stored in that gendisk.

Applied this one as a separate cleanup/helper.

-- 
Jens Axboe

