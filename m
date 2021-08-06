Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F79C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 22:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72E761184
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 22:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbhHFWkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 18:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhHFWky (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 18:40:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD40CC0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Aug 2021 15:40:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so20103413pjb.2
        for <linux-block@vger.kernel.org>; Fri, 06 Aug 2021 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s+sQ4/NvUdoStCMijOHcxkxMFWFwwxM5neHhTqzEGfU=;
        b=dlRajXvOMukeGX57J1cmiBjubcnvunM/PzUyO0exarysAoTRKy2bPquL1iTG9hMCnT
         2m3WAD+nEJYBDcsnatIyzh+4KvjgMEKzhm+TpBBZ5K4M2W5RxDxoOo9lXwBby9L7zgD1
         4lSn3ffrL2pOY+Ewq7Kwq7bsSP0/VYT6zR/pw9BmOKDsVDN6lNieLQc8Lo+MQalziy/A
         65J5+JMIEk1x9yZRYagQsjfll0TjZqnT4S/BKAAaULNjbeRfHIt+plyHyEqi7Wkc0/Ve
         94QzWONPrciQY8aIPqJGZfijxLpArt18/6RrvXwsTFF6E92LBywPAUMbc3BJShdqgvir
         H8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+sQ4/NvUdoStCMijOHcxkxMFWFwwxM5neHhTqzEGfU=;
        b=oOSRhgYHJNaHkfleRZjo+L5B0kkgK0sZZkycqbO4U5g667YEuJ2jN1HAaKFDo4jvbs
         cGUd2QgF4ZSH6z8oRKcDkfJlGhedGMjlVxKywFq75IZ1jIAtkW9lJgqefyVTB1fUaZMB
         1KCsZCIjs3EK9B+ddYvlxV9VndYb6NgZUi6h6oBGqNoyownhPV870ymsug5i8gBrYiOr
         +xkWRFlLcfRJUhGrPn98cXiHbcyE2AdmM10KE9T6Xj9vNdKSbcy/N1uhhUgkTQlqDwdq
         Y+kUFv4Viw/4N2bS/gzT5E4Y9xznUMP1lBgC2BYGFY2g42bjVdsECaLrwqBwbCwoTqbd
         xFuA==
X-Gm-Message-State: AOAM533/q60pHk5sF0CPN3Y4HW3D5UHowJtJ3HHjYg+JSTR1ZwwNu/Ro
        kR2slOI7LlH96wMuQPopldME4Gv6DyanvsU+
X-Google-Smtp-Source: ABdhPJyXKmQgT9nnIo/hAYJidjITJP5fMi/AQ7X3XMaBOv7MgkI6J0Rlu95Irh4yhWSCTmLDEjsEag==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr23405021pjo.194.1628289637049;
        Fri, 06 Aug 2021 15:40:37 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p8sm11398551pfw.35.2021.08.06.15.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 15:40:36 -0700 (PDT)
Subject: Re: [PATCH] kyber: make trace_block_rq call consistent with
 documentation
To:     Vincent Fu <vincent.fu@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <CGME20210804194924uscas1p2922dc9e7bb44fbfa10abe8157fdd43e1@uscas1p2.samsung.com>
 <20210804194913.10497-1-vincent.fu@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9229ef3-6751-407f-a013-c4a1671996f9@kernel.dk>
Date:   Fri, 6 Aug 2021 16:40:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804194913.10497-1-vincent.fu@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 1:49 PM, Vincent Fu wrote:
> The kyber ioscheduler calls trace_block_rq_insert() *after* the request
> is added to the queue but the documentation for trace_block_rq_insert()
> says that the call should be made *before* the request is added to the
> queue.  Move the tracepoint for the kyber ioscheduler so that it is
> consistent with the documentation.

Applied, thanks.

-- 
Jens Axboe

