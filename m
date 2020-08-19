Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE63C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF009204FD
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 14:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WUs7cZqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHSOKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHSOKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 10:10:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589CAC061383
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 07:10:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r11so11730149pfl.11
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqQSu+naoER2cTg6YN3Ri6AXCYtp5Cq2JF2/Sa6VXWs=;
        b=WUs7cZqcaS7XW9PpeihbyzUuuMYFyao+SOskgMzUBsUc/ydkUelp7uW76u126hDyqv
         fcvs8NhILbxyXRbpVwxSBJSdfxyt4emjxx4Eo2wEEdDRwWazrCBGt2Nntxubz0JVblOf
         3naKv0eitP+uZ4Z6luXkkdtuR/r8c5REWKjED5e1vdTuGFu00+Zz/jl74tTBqo9LTmvi
         nKIacXsWkLWNO0yLPLyJblHP66I+u0tenxnWiDrahWKYniF+EbkuN8KCxWnitWh1p6/x
         j1d4f3dQy06eOQTQq7d+9BvAcWIC5Ew/U0NODgD1XvGxqf7b3K5WCOizLzYO6/vocfev
         YY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqQSu+naoER2cTg6YN3Ri6AXCYtp5Cq2JF2/Sa6VXWs=;
        b=doykvoMo1T0iVmcBT0GuZtyLn/KZJ3K9Upi3jk3FfRNNNc+x3JqLBFiOw9GMcwOPw+
         Hlc6giJ58xQ2BIr6Nn/42aVPrYZwPr+clW/dbCvG0FJ+M9rzHu+LcxaAtj9nrP7dqkku
         HPWWvD6OrDYb3z8Yc526Rl0n8HFU3XIJ8TER9bO8u3zT1HNuplqLAibeIHt7ON3vfMbi
         wWyo+02OZZyqMqFqdoyYquA2cMJLSfzsWhJfhLRQ+uZhpNNkvorCm7T3QtqCgojpYpWZ
         Z0v9unbhg/cHiZg2KBkHNvUbyznLGcA8Q72TP4NQHVMHBeYzZY8m+VyPVEgSiuFHRVW1
         w8dg==
X-Gm-Message-State: AOAM533C2IMl21FVqT2s+eVNY/VeSj18DL1XHFiWinf2AbqsS7UMg6Ee
        /7cge2LUG0BHqMIpSvEjW6r9YPFpGf2yW/go
X-Google-Smtp-Source: ABdhPJwf7jTtgPpteLObzewS/SMagnR5kBHF/y9jZOZOVJ0cl9iGTgKfgR2TZ3TdakPBgtjQn4M96g==
X-Received: by 2002:a62:7acb:: with SMTP id v194mr19099980pfc.302.1597846210729;
        Wed, 19 Aug 2020 07:10:10 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h15sm3378093pjf.54.2020.08.19.07.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 07:10:10 -0700 (PDT)
Subject: Re: [PATCH v2] blkcg: fix memleak for iolatency
To:     Yufen Yu <yuyufen@huawei.com>, jbacik@fb.com, tj@kernel.org
Cc:     linux-block@vger.kernel.org
References: <20200811022116.1824539-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c6a113d4-c3f3-2921-0e92-53b1513d842d@kernel.dk>
Date:   Wed, 19 Aug 2020 08:10:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811022116.1824539-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/20 7:21 PM, Yufen Yu wrote:
> Normally, blkcg_iolatency_exit() will free related memory in iolatency
> when cleanup queue. But if blk_throtl_init() return error and queue init
> fail, blkcg_iolatency_exit() will not do that for us. Then it cause
> memory leak.

Applied, thanks.

-- 
Jens Axboe

