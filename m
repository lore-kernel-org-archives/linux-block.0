Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72EFC433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 22:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiERW3l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiERW3k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 18:29:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C5721A94F
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:29:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so3097462plr.9
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GHsUE9N7qwGKPhSfb7FLSZbI7huX80ouMGDrIjhw1Uk=;
        b=tok1tK7PAPs2jl/A5+MZDuzJGG74i7qajPVXyIwM3P53jmWgJKGEW7xAVxKnCBpMuW
         BnKA1MeavVlAHM+qmVYN405lR1GJKzR3fFBXM+n9IgkNThCrONTNOshTDllOgV0aSm2S
         bpSoI4pRydA/Nn0a0wlg8oLEhiZYRUn3g4325mDVoqBkb0dNlvbTWfaHzn7ZNlNUotWk
         lNm6knKRwz6jFbdE+onYhm26Cb5FxhurSbjVKHHpKViUX4kmpXEpRm4R4Hv64WsaZg+D
         s5CpNv4rgXS9RqIgdp3zMSXg1UwgClwDlEWUmWfSEUD++9eq0DBNYmbksnJwUu9qNd6E
         qINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GHsUE9N7qwGKPhSfb7FLSZbI7huX80ouMGDrIjhw1Uk=;
        b=bgqZPbyQ9mGDLJ4txlVQJDRfnUzqmSAjX21WMXxY7Nxs+XYwBDXCgHbM2xHZtGC8i8
         6CDlGRgnG7OKkupQvsm9MBBnDpoyDhVal6MlLG7HRGHTZ6/N10lf3M6JlnH4/9RodcVs
         obNHz6Gq40ckFt/a3rJxDXYRW8xu8t3yOg12HieIglcFWlPeRMOGT+p8e8EtfOKpfHrt
         MsglZ/vmfd6KYfM/bG21A5dN/Vz3TC8OOGYUJ+XFx8scILiq354K5d1Ngyzrq/de58fC
         A3LjdWJGrFgtyxfdih6WnPKpIQtgh2e9samrD/s9zE7RCRpx4+/fyQ9cq38U95P31uxK
         GiRg==
X-Gm-Message-State: AOAM532ch8WxoN94YezhlPGEM99H5l/4DmfgDmiK+Vwysa2ITVdJLaOD
        D8F3BGMgsgpTUK0UCsQdgT0P7jRkBF1GSw==
X-Google-Smtp-Source: ABdhPJxPQ+3/S+p5wkyoI6EnBIr0Se7SP74lvulMafErZTqa/eRb6oco6NUfBqYfRV0hsIvy7arjyA==
X-Received: by 2002:a17:90a:3e81:b0:1df:4c26:1786 with SMTP id k1-20020a17090a3e8100b001df4c261786mr1707941pjc.126.1652912977258;
        Wed, 18 May 2022 15:29:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001616723b8ddsm2231887plb.45.2022.05.18.15.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:29:36 -0700 (PDT)
Message-ID: <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
Date:   Wed, 18 May 2022 16:29:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, bh1scw@gmail.com,
        tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220516173930.159535-1-bh1scw@gmail.com>
 <CGME20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46@eucas1p1.samsung.com>
 <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 1:28 PM, Marek Szyprowski wrote:
> On 16.05.2022 19:39, bh1scw@gmail.com wrote:
>> From: Fanjun Kong <bh1scw@gmail.com>
>>
>> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
>> Which can serve as RCU read-side critical region, so remove
>> rcu_read_lock/unlock().
>>
>> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
> 
> This patch landed in today's linux next-20220518 as commit 77c570a1ea85 
> ("blk-cgroup: Remove unnecessary rcu_read_lock/unlock()").
> 
> Unfortunately it triggers the following warning on ARM64 based Raspberry 
> Pi 4B board:>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at block/blk-cgroup.c:301 blkg_create+0x398/0x4e0

Should this use rcu_read_lock_any_held() rather than rcu_read_lock_held()?

-- 
Jens Axboe

