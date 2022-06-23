Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C63C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 13:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiFWNzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiFWNzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:55:44 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C236B4F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:55:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m13so4506457ioj.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vyl3MVsTJITPEqW0N8buYuq986ADki9XTkUMF1TuePg=;
        b=K8LkDWESjxCVRqHy4/VcSS/W3Z+WD7/Rl5LQ4+OG+U3uPFMNkUGR07RKMq8VfLa0uE
         tjF6hq25EGBvFVQwesl/WoxZRQXk8PAGrMLcHCoqxFqrtJHlAJT1K0dyw/a5KkguqZ51
         f827IbMQVA8IrB8mvMxNZVUiRKb6ionrbSUjPx5xjx28jr5Rtp47GtE+BYnGDGOUYiGs
         KxIxPyPInFtkxF3cRl/93rrkhz5AKQCgPDQh8nBZQclQw5Gw4rm8b01jGmKkdEo8aXGF
         T+FFZF6/c2ckGR6/bifespv9J8QJ94c0+ChmFE/Jq4MLFNm5DfIDep2761IoRBKTgOtu
         tryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vyl3MVsTJITPEqW0N8buYuq986ADki9XTkUMF1TuePg=;
        b=fr9Oco3XEUHcjvqnUUshZxwCEvJeDckmK15YNvlYGMmsmoqzHlBjIfH8XIHkVgw9K6
         wGw2QV86tv/D6soQ8VHmwRodtjZGB7a2NTpz7AKs5kKcXS5cz/6u/B9v92Kk7nzrcR9E
         RAn05ushQWcScDsN/w4qtHrvqw1lwko0tjwwCAXqvNvTPudfkvi47AOwyRFFHR62NJmx
         5F2d0/J9Qs9S/44Y5H23zvM5YDerBpEfaEQKdRC7vQM87TvHOumHtYhW0zYgGDkseY4o
         4LpbyVH6Wycyr3t05AWBty81m5T5ba7BctppGp1waWosOrSDNuqRIuvxGQ1zDszqhIyk
         aLGg==
X-Gm-Message-State: AJIora/v6SxyjSc1O42WYwgBqlUPB8MQnqydiaKi5lj8+/GxYXoKN1Q+
        v/tcUfuClQ4U0fi7xlMwOdqaIEDzhAzWcA==
X-Google-Smtp-Source: AGRyM1u59WCPRQ+922XZMwCmGKVmkmNCphLi65/kEOJDsYAMjuXKceUjlnia9MSeMuywd4RIO5XatA==
X-Received: by 2002:a05:6638:ec9:b0:339:c3a2:b14c with SMTP id q9-20020a0566380ec900b00339c3a2b14cmr5346253jas.128.1655992543649;
        Thu, 23 Jun 2022 06:55:43 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t18-20020a92dc12000000b002d909e3d89esm5782494iln.60.2022.06.23.06.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:55:43 -0700 (PDT)
Message-ID: <ea17cebe-ea71-db73-2f91-199ddfd051f2@kernel.dk>
Date:   Thu, 23 Jun 2022 07:55:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YrRwn7dWdJcI9DSL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YrRwn7dWdJcI9DSL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 7:54 AM, Christoph Hellwig wrote:
> The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:
> 
>   block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-23

Pulled, thanks.

-- 
Jens Axboe

