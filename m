Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45AC49EA5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 15:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DDC613DA
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 15:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFXPlv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXPlt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 11:41:49 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7FCC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 08:39:28 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s23so7762993oiw.9
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dJCNiAlUPB1PoEdox/Uy/m2O+kkoSzI+wpISSQH9uNU=;
        b=HddnJQaCVd8jdtfn4xqh3tY66xVQ3nwwEEa3jPXpw52bLb1tpSQkvvjD+QTG7Xpq/a
         ReAzdQoe0JgL31DI6U7W2I/yTz/2YXQ++1Z1VwrDxj8dHthdszAyFS5XwZ7xerCwSExx
         omNajb500HI5Afp86lILVvDBApabxATVHwqQzgsLaiA+Y8VkgAlSqDmapjGSbXNPbwBZ
         gEbhNzGE1AOzgc0fQvfldHS5HxYVpNwt+gw97WS5A14JB2BiwE2D8HIZDIk4/f5GU5EB
         CrSIKmICvIj68Zdt7v6CGBytoif0VFcr7gsGtb87X6C5H0qbZk+2PQx5GttjcT5KdtcK
         QXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJCNiAlUPB1PoEdox/Uy/m2O+kkoSzI+wpISSQH9uNU=;
        b=WHIH75lw2rEEFjc63sqSw/6eeXzypWFg9JlPnGtwg+j5/vFkbqWF/vIExDvY2FXt/0
         qKzRd02AsLYTCrkaRXFP06e6cyvW7B0NihPAh+Nsoy4qAS8yiUwPStBeMUWAtfNBVS9s
         FTsP2YN5eirFcIZzAInZfQkkB1NRYe/RKCv0pfXX9SpFXe5Y0NX2U7MVItMQPyAXN9jI
         T4metc5SW/M38itL+tSEwnl1+jdEVcbTiKtiOzTGWAVgZql/R7OqyDIeR811OgZadT+M
         /uNNCtwt62k2VQJe7HaBtXg2bw/RuDvf5Z0z2bhU0sWqEOsO+Me0Ml4FigupdaS2AjO7
         7GIg==
X-Gm-Message-State: AOAM532l3J+DqWhyl7J6dH3NTuEJa3acjZkinqq10bpZtMD8TM8ktWVe
        QokST5jQGbPZiMXyeP6zRNiWmA==
X-Google-Smtp-Source: ABdhPJzPceqZfj/iH7K8oJ+N4+xnHxBd+O4f5aojmHDn/lJq6HFDL9UKOrLUzED1053PpfNzVRNz9A==
X-Received: by 2002:a05:6808:2019:: with SMTP id q25mr7770646oiw.84.1624549167832;
        Thu, 24 Jun 2021 08:39:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id w69sm732304oia.22.2021.06.24.08.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 08:39:27 -0700 (PDT)
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YNGLn2MsJDwwbZbv@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6c5fddd-6829-a3ee-a270-c7e3a81a0c9a@kernel.dk>
Date:   Thu, 24 Jun 2021 09:39:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNGLn2MsJDwwbZbv@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/21 1:05 AM, Christoph Hellwig wrote:
> The following changes since commit e0d245e2230998e66dfda10fb8c413f29196eb1c:
> 
>   Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.14/drivers (2021-06-15 15:42:56 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-06-22

Pulled, thanks.

-- 
Jens Axboe

