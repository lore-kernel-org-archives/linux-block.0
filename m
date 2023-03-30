Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76614C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 22:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjC3Wji (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjC3Wjh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 18:39:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C57CA28
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:39:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x15so18671033pjk.2
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680215976; x=1682807976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8dYMW3XWv0alb9FRUxiLkOt8cztHbN++4YPbl+UQLk=;
        b=woe0VTMiVuN+D8JQTUNxpCp06PCu7tydCq/A2/BAealAPGvqXoUebB1wrIiVMG8Q8t
         roQWdn8HpWOT9aALGRE63bbh4U2imFhF32zYoWniXgX/2jOHmX3y7KFL6+sdyWOBO/I/
         3PE/AdIkveFcimQXkEEUKNVaOybMYLX6aoDHqIBTqdTzwQWJHFYGM/IfC8NWsJj22pDJ
         Q7d/h9S5hg311NwV+2REe66gVtUHDtgvVrITzyZ1mz5tFyI4Pvo7tX43eihyc595V0rK
         dcS7sRKtH/1KXBjigHfri3wXKlRbQ5kxPwaone4tAdwMuZb8N8C3PG5ES5bjifCPQ2Jv
         onjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215976; x=1682807976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8dYMW3XWv0alb9FRUxiLkOt8cztHbN++4YPbl+UQLk=;
        b=Y4VboxQLVtyjYd23yOaeqgNX1VRrkIIqAKPFGblfN4AJ7oWrB3O6TpRp1Ac2dTmBDZ
         AGCtFB0ejY3V3kxwG+DWWHmGVVjoKuukemNtAghyNx7g80pLfa9u4HKmUTitV6CvAmd7
         o6reABLMuuPqLg1VBz8z1vQmpGP1Z4Q9IbvY0KLga/AXntHQX9D05B6sf9FslCOrvWTW
         a/nlmVsZH+mDX3XcVwSfzLcuN7AoL8EQOVAcz2iSQxIFM06qPSJ2sm4dfO9SwgRcuY8m
         qhOBosZnRoxrnDC8hYQFjfFmOeVXEhsKt6jUuqPVU3OGkMF45Ye5mRdi/f7X8K427EkH
         HFmw==
X-Gm-Message-State: AAQBX9ekrypjMVbR3gp2hC0d+ewCVDpIggP9sp0AIAmgnvvjTcIjFbNJ
        zk+/wXaI9SblrSldhuL+dbVRKA==
X-Google-Smtp-Source: AKy350ZNS27Vy05v8IUzf4GKM10aPcsU/6w163pYstgpBDr3hqeZowRVl09Mi8cbV/q1tgBpMk016g==
X-Received: by 2002:a17:90a:ba04:b0:240:cf04:c997 with SMTP id s4-20020a17090aba0400b00240cf04c997mr2537630pjr.2.1680215975566;
        Thu, 30 Mar 2023 15:39:35 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ez16-20020a17090ae15000b002310ed024adsm3712198pjb.12.2023.03.30.15.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 15:39:35 -0700 (PDT)
Message-ID: <47d34a9c-bad7-cb6f-bcbb-48391734721c@kernel.dk>
Date:   Thu, 30 Mar 2023 16:39:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZCYPEl0cfKtOlkU8@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZCYPEl0cfKtOlkU8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 4:37 PM, Christoph Hellwig wrote:
> The following changes since commit bb430b69422640891b0b8db762885730579a4145:
> 
>   loop: LOOP_CONFIGURE: send uevents for partitions (2023-03-27 13:27:06 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-31
> 
> for you to fetch changes up to 88eaba80328b31ef81813a1207b4056efd7006a6:
> 
>   nvme-tcp: fix a possible UAF when failing to allocate an io queue (2023-03-30 11:24:33 +0900)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - mark Lexar NM760 as IGNORE_DEV_SUBNQN (Juraj Pecigos)
>  - fix a possible UAF when failing to allocate an TCP io queue
>    (Sagi Grimberg)

Pulled, thanks.

-- 
Jens Axboe


