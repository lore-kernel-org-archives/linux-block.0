Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18192C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67C7613DB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 15:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbhGOPe6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhGOPe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 11:34:58 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1297C06175F
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:32:04 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id o3-20020a4a84c30000b0290251d599f19bso1622589oog.8
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ore/buOvmy6PiNPNB+ZztbTPRHromdTxvhlN0ku+HBo=;
        b=oHVwezaYtR6TAFgDpETK45laJD6NHI1GRFaJ+Iu7pQnNWgbfXAgm38Ead7lGAghoZF
         xQPeehO+zSPrEyVENDsIZ78TZ3VpvfxTV6a4wTRIrbyfv2zxgQC7pLi1fB2PXOGvpVXP
         u86ptOdg+wytdLo4svunqcl3CzdewOQ5j0/xIt6+HGgnlMXbTtcy+VnU+85/B8vLc7dc
         qg+0iND5emyy4aWHsPSDw26AgcwOE8TF1UHqzkcprdFUH6Wv0Enz+jY4pgPauP/fLbJ7
         yTScpC3VvVhURILseAMGW4HByDKPOGlH+JpmuaPBe+BPuQGSaiQfls0w101FLWK4IrkF
         CAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ore/buOvmy6PiNPNB+ZztbTPRHromdTxvhlN0ku+HBo=;
        b=PKrRtIzJ7s0KY0rKCu/pPr/I75iya0GXFRpoFC6uZtM937sxaJP2jMju66UUc8uvAn
         5Grf1lbU/mQ4Xf/JCg7WOag61MqwizGDH6WltAB/ATfL/Q5DD19lDDLzGn/z4doRQf7i
         bTZWbFJZJRS219b0iBKXKgycpUKBKSBHN6mz292z4fQRf+2MEfpQkP31JSjXoqLZr442
         lQEcSs0eL+xu9XsXi8l6WOVmvsaUsKaPPORVfylrVMgB2YQm8hV+15jzEwjoSUeMPW+i
         6wWfpYd7SwgGUF7lWLSBOVGtNe3zZULFFf/PIwKUgfqq2AhjdwbsXhCFelSfNTqYMWxG
         LiEQ==
X-Gm-Message-State: AOAM530icSFCUgm+rt9qd7LPSjsftwk5HOzSgvamPNVZZbn+33uuMhCt
        Y64MkE4bLfNI8CuTPpg8Jq5Y5w==
X-Google-Smtp-Source: ABdhPJzzUyp5Uje9lJudJSaYThAMnKm6MS69xFpl6mAyniP7sxy7BxdpRehY1HafXGlmOqw+xx3SKA==
X-Received: by 2002:a4a:db42:: with SMTP id 2mr3885401oot.47.1626363124320;
        Thu, 15 Jul 2021 08:32:04 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p4sm1114948ooa.35.2021.07.15.08.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:32:03 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YPBCY6IjDBwYTceO@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d4ca9178-9b6c-0612-b1ba-57c244f69adc@kernel.dk>
Date:   Thu, 15 Jul 2021 09:32:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPBCY6IjDBwYTceO@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/21 8:12 AM, Christoph Hellwig wrote:
> The following changes since commit a731763fc479a9c64456e0643d0ccf64203100c9:
> 
>   blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs (2021-07-07 09:36:36 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-15

Pulled, thanks.

-- 
Jens Axboe

