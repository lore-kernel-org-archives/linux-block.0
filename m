Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8E0C4321E
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 15:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiLBPBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLBPBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 10:01:44 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AE083E84
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 07:01:41 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id b2so3196271iof.12
        for <linux-block@vger.kernel.org>; Fri, 02 Dec 2022 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvjTMOyNuaCPSVSDCNmIubGuYYHsGY9CEszqPeygnwc=;
        b=wla0kadSjr3B4tsPMvuCvhSc/5oDIAU5YBoZVemownGeRODRAo5cg0ix2AKfN5qiV1
         KyX9aFGrLk2ZkHq5w6QbfPfmFj0RLEMePGkE9jEV7eJvUiUgrVXc9OsoF7wTE9RKb4rL
         Oi+CoaK5VPSs4HO1a99uNV3Oq/1rqZExa4KOO7Tmui2N7dP20ENMr0GIaT46pHRex4Cs
         JikOIqUT6Tg4CY1yNWRTqj5J5UwRp8t0Mryg6R0eq7jB274gwW2eBi/AXs1NEdh+COS7
         /2Z/p3jhYGOHmKzqZi4ghrlB1uU8+6UhgkutK03AvfALnGD84lPVMxX98wR0OD/Qv/JC
         CfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvjTMOyNuaCPSVSDCNmIubGuYYHsGY9CEszqPeygnwc=;
        b=guZkiz2TqMrV2fCurLwP+G4OLxLDzcOUgq5PZ4mJrSDz8Fqy6Ps8TzRUTmxco/Ei9g
         vd/hYg+9AKVkrRLwSMsrbi92aWHZjwwBJ+u9mw92SxndUHmnYsqy9xmz712MGvyGPIqT
         7kqphPp6WteYbIJOwFQqaKru3EtQVvVzlylypsQ52JyxNhcW7p8nZUlGlDKXZLrRH/Oo
         s1woJQYjjxf/G6EmcMLBnEvMHsbWyLNJRmaa16OHDljAb9SB2gcv5UHawlnKXitWf/fs
         1JvAN/YuNvsMspoCyFfZEd8DA/0LpKxiY/4qqMvH1YkI6SPf7a5zDYh1nX9yizgbbojf
         ZWrw==
X-Gm-Message-State: ANoB5pk/jL/vY5QCOptfiOPs+ltFvBwYvGPSn4WiNN46APDvaqBvLwYd
        qJnY1ayuCW8Ilu7w3UoKzjobAw==
X-Google-Smtp-Source: AA0mqf5a671VSyIDmTgcKym5stNFDUHr4aBdr3vqO2Wk/Y18m++AgU9SmckzfzOrXeNuoYdtbkALEA==
X-Received: by 2002:a02:cc2a:0:b0:372:bf99:b645 with SMTP id o10-20020a02cc2a000000b00372bf99b645mr25646876jap.278.1669993299098;
        Fri, 02 Dec 2022 07:01:39 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k84-20020a6bba57000000b006dfe5556e41sm1159490iof.40.2022.12.02.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:01:38 -0800 (PST)
Message-ID: <4e7153d5-3493-5663-a183-873445d7a8e6@kernel.dk>
Date:   Fri, 2 Dec 2022 08:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y4nG6f7QDhcmbldD@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4nG6f7QDhcmbldD@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/22 2:35 AM, Christoph Hellwig wrote:
> The following changes since commit 7d4a93176e0142ce16d23c849a47d5b00b856296:
> 
>   ublk_drv: don't forward io commands in reserve order (2022-11-23 20:36:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-01-02
> 
> for you to fetch changes up to 899d2a05dc14733cfba6224083c6b0dd5a738590:
> 
>   nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.1
> 
>  - fix SRCU protection of nvme_ns_head list (Caleb Sander)
>  - clear the prp2 field when not used (Lei Rao)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe


