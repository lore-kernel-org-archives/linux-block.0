Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18611C433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 01:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B47208CA
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 01:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Uu0lVg9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBBtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIBBsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 21:48:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80764C061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 18:48:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so1717701pgl.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/4wFGOq+jdmgy1C521XX4TvVkHBzuungWmQOOE8oXAU=;
        b=Uu0lVg9vFfx3JT+T6IDM8UHNmL25OLD/ZKO4RC4DSbuETuyl+GzyBituX3nR45XVUV
         lfxEWap/HgXd++RLWHxHJ6JYfGtq+sfddAlusDOA3k2+IHIP5+t8j+n7y7mmrr8tiCYy
         XDApwAPsgXE9/jVaskoJz0lj/SWR8le+m4Fm5GxbHCSJQlMV3R8vJNmwZ5fD/5epi4ZH
         q0TOryMPEmORi2PVBRTHeuUxDOeJ0RldNhg7uSWe0WnvTykFUI0N9J4jC8euLJjicRDI
         lutuu2r25FHQ71Vg10CCetZtVpmGyvBlMm3edQbsVTerjDmeWtMDKhbWX01rx2o2/5dx
         X2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4wFGOq+jdmgy1C521XX4TvVkHBzuungWmQOOE8oXAU=;
        b=r27CHid5h5gWqiF0hdQfQwnAGT5aw2B8B8N1CCFt42Lk1+xDlygJTiT4I89KDTfABJ
         m71gPTzaz+cOC0Q9DXPushKquO5V+waNDcEhcZQmu9JVq/TxUG2KayVtpitdOWivOA0J
         rbqUgj1GghWI2qRiWizwUt9NkFwX1xNdBBl4FGADE3415d8E5DUpjAgTuKgG+phees2a
         LKvSquLV/8njtAQKLtszKpYoAIl7AmtTe1xBbSOYHZ3aMIzKx3C6m1w6SoLJJGVIdQGk
         pGTZBxj3rcm1xueFg64D0Msb/jx6t8dOl7x3IYL7q9oPAWsweXJURn5MZDbiVnpwrF+w
         1MWA==
X-Gm-Message-State: AOAM533QuycivtVWIbZImCe/u8nxYv6ZEiShzmNzUN6ofYmwChGHXoOA
        5NheKxHhKu57+UVy10GrHsrKzQq0nh44zNso
X-Google-Smtp-Source: ABdhPJzstt3Y+NIGaVASxgMQnKIge9jkmIm0jVEsu/fdwg0w5mqQN0NhN70byC7Cx6+aJfmINScDfA==
X-Received: by 2002:a63:d003:: with SMTP id z3mr45293pgf.424.1599011317885;
        Tue, 01 Sep 2020 18:48:37 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e7sm3468231pfm.43.2020.09.01.18.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 18:48:36 -0700 (PDT)
Subject: Re: [PATCH] block: Remove a duplicative condition
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang7@gmail.com,
        dan.carpenter@oracle.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <24364e6dfe7905d4f823ab932f927e2d30858c5c.1599010968.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64043cf0-09c1-cbb4-ce2c-30dfd5ff02ee@kernel.dk>
Date:   Tue, 1 Sep 2020 19:48:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <24364e6dfe7905d4f823ab932f927e2d30858c5c.1599010968.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 7:45 PM, Baolin Wang wrote:
> Remove a duplicative condition to remove below cppcheck warnings:

Thanks, applied.

-- 
Jens Axboe

