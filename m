Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1A1C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 02:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1BE64E83
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 02:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhBXC1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhBXC1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 21:27:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87443C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 18:26:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id f8so260172plg.5
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 18:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=azP9tJ1/jt84W11J9Hq5E1LG2mIlI91dFLypWHOp9ZzYCjS48vxbFQj2kU2DSlOMZX
         PJgvnRxQVPdARo9yj3BL+HhzDw5hHAz9IiKZjx3f7/Vs/soT1i6BvzEl6ZesFrQjTfcP
         LDlk1a6Jx+j+Rzj0JEN5hb9jNrQgyDYe6RABfAIyT4deDIRD9s3pfOvNvjO/10bbCeFU
         A8zuKpuBojONjUnkcC/uBgXpPztpglUmq7HAbWIquTXNMoFLShdVFsTev7gNGSje2ycJ
         zck7vdB++PLVXnM8Q+/ToVPkZmIZoU408re3OeaghBupSRuksAYWBhxN2cteWH8bjbjw
         U6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=qKOemNQ46PlNIg0HGA/kJ3yM7IHvumia15tlZpyKWd1TB+h6Cr/yjh/+7uETamimMA
         ezQM/zaZQD9D3x2St0NHWq+z/6aeSL2RI4wEdjb9yqZqhsxSy7YTNNWzjp1FZzgZPgyY
         J5uzLXghMyC2sEa6wLYCfp6r6+8ZgGxX/jcHgMlNF8WueBvWcNkIvE05EO7yjhHu9Uir
         8WxBs7trr+qDcKPNC62kg5z0Fet2KcAEmFABWfigGwAR1hPC5TQM5wsCfyQy3JFseJ/K
         IVV1We+o2zQBnjo13S6as71TvZFKmRLBhrgGhYp4qY5zJo6Jb87gksDRibJkDNAAqsqT
         +sZw==
X-Gm-Message-State: AOAM533+EH3NL0rAQIaU7wjNPb1SNOkHMhO/4UN2nOJBjkK/M2dR5EJM
        YKGKh/TV4fnDIXG1Ut9E0y8oDQ==
X-Google-Smtp-Source: ABdhPJyR3nz4/2Xe5wJThbH4JmwtF3FCVmv1vow0MEov3q6812/SA95OV/EDU86jIg7awO+mA89rHA==
X-Received: by 2002:a17:902:ec83:b029:e3:ec1f:9dfe with SMTP id x3-20020a170902ec83b02900e3ec1f9dfemr15422462plg.59.1614133595027;
        Tue, 23 Feb 2021 18:26:35 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z11sm309175pgc.6.2021.02.23.18.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 18:26:34 -0800 (PST)
Subject: Re: [PATCH v2] blk-settings: make sure that max_sectors is aligned on
 "logical_block_size" boundary
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Mike Snitzer <msnitzer@redhat.com>,
        Marian Csontos <mcsontos@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <alpine.LRH.2.02.2102221312070.5407@file01.intranet.prod.int.rdu2.redhat.com>
 <YDSwyrLeiP/fKgZH@T590>
 <alpine.LRH.2.02.2102231125170.27597@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20807c3a-5d44-4f90-4d73-c1cfab251b18@kernel.dk>
Date:   Tue, 23 Feb 2021 19:26:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2102231125170.27597@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

