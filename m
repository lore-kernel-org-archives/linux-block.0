Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70BC433E1
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CE5204EC
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m0swvNT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgF2Ss6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgF2Srn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA45C02F03F
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 08:09:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l6so5092514pjq.1
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqlmVG78iXs3ajjXsqe/luI6Bsp4Jqxp96Da7CCW4P0=;
        b=m0swvNT5I4fsJ5e0cVdRCGoS4Gep1sPkCbXehbvbkq+AANBChxcAllGhlBu0NrflKc
         i75XmYCkOQ7onW5AoCG6eCrz24Tr7rgsr7d0+eu0uJtAiS62ODVgPZ1+T+nd+gNZPk+K
         tz9fcA9G3gIiKOVi0fOebGPrsDXPjX1qqHNGuq3d/S36WOD2Awto4/RKwsVUrRXp5l60
         FbKtJnwhq8Nevr37M3deQWyv/IqzYPtC8a6O9fKz8k7GN7/N8WAuFzzUTmwtynKD2yuQ
         Uf/lFdAUyyLcs3eJhIzvwxHyTImxc1Ln5ZACcRGG3UEFWISgdBleMn4XbujIAFsjsCmP
         esIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqlmVG78iXs3ajjXsqe/luI6Bsp4Jqxp96Da7CCW4P0=;
        b=WXL37hFM1+NlAl8LKjOIjWb2rINWHeFEmxG4fVGCr9Rvk6nv7DU/IjzcWloes4hEqC
         xfmqWVvjDLC5skIl38ryB1mykHHN9CwM5znAResHvNoDCnWMaFZs3uCAsvyYWAe6jcVj
         3IBAtE7ZlDIwqcE2zxcEjHzwUxvamqsFlcbVWk3z8X1BO+hVKqxA6AJ4JEyUPvV9wjYA
         NXdsibatvWNAO9GIT2FG+piDjw8GA58rsM0ZLn5YeI9IEzq0gk2FtOtk4/2Yf+5MjMcP
         o3V15b3PLHpLKq6K89LzcF9s/nDorGKX15vrqRVyvKZGcqX+7OZCbGQKUlPJe+ragiJI
         SbTQ==
X-Gm-Message-State: AOAM531bmMMKBuQQ0eeKl40weOhg9+UXOn8Gr8OjhTOBgC79zCb62CSR
        zAuOijC/accxlXQJNJaGMbfzJg==
X-Google-Smtp-Source: ABdhPJxwZjsguM484F6sMiKLUZjrGQV40HFdBT3LN52GuV2BrrlgN4LhTVhem+onWXtopEtTIEUvTw==
X-Received: by 2002:a17:90a:222d:: with SMTP id c42mr11700791pje.126.1593443389436;
        Mon, 29 Jun 2020 08:09:49 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id p19sm83847pff.116.2020.06.29.08.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:09:48 -0700 (PDT)
Subject: Re: drive-by blk-cgroup cleanups
To:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20200627073159.2447325-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90c404ed-58b0-274e-516f-b7c63ce34fcc@kernel.dk>
Date:   Mon, 29 Jun 2020 09:09:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/20 1:31 AM, Christoph Hellwig wrote:
> Hi all,
> 
> while looking into another "project" I ended up wading through the
> blkcq code for research and found a bunch of lose ends.  So here is
> a bunch of drive-by cleanups for the code.

Applied, thanks.

-- 
Jens Axboe

