Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7216C432BE
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9829260EFF
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhHIVm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbhHIVmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 17:42:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D337C061796
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 14:42:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f3so7480024plg.3
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UbXAYdRHxKxxmC4KDWgyIc/4KEvYd5We70piQjbukJY=;
        b=WDUwHi84SGgUmjlZRgTAExBiEjnslPFUC2C2Dxwpq+qOoCOsVmUIxZX1z4hveShRZo
         DMRunpgURSW+VhFTInR12GfcpmPzwdCoOiP5ife3C6BhSHmCeP1EXeU6UVMZkbDhKCpj
         9otQQepxMn/+Ym4k/IANk6pd2WFjBgV+VL9Bto++lNPGAecSNO+WMUEKDU6sNEQOAX9l
         robaz3duHYqZ87F7j60GHqhFkpwveXll4TkaeJIiFp9iMDk5M2tTJTxoRdQtdS/MocKM
         DmGKWVZ9yxCvkW/75nvbPG1desNJyXre0ksMciWif2PnpJaIXwD5Cm0Q8xtrBDaYdOOw
         8+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UbXAYdRHxKxxmC4KDWgyIc/4KEvYd5We70piQjbukJY=;
        b=fzfX5WH3R5eYNW4GGk9wzSZgyJSdjqxIhRj5lUCzH/2WXHsGwV8IOgI4CtsGmJvvnR
         ZGL0CfNy+LY8V/oZdy08y1P/3naG0CZiEnwF7t74eRniyG9wz0RwJ1qN10PhvY2ZKnwD
         AmlxNJIsGCfWecILQmevniF0OC+gTY0UkzKoU+38MPtD2xgN+2d+kupp4gjWj0kbn75U
         vuPUa94ZIII7mLqNNiAMO/NmzcGn1tNWTvtFLOehcVjRr9iV8BsJP27e0RI7p95oSmId
         mbBcSH1kTanRKXcLNz4kf3E2TNgwgVK6hj+ABC70mJhqklbZQ/nGGTV/ukWaqbur9q2Q
         4zuA==
X-Gm-Message-State: AOAM530dX55TVdmg9XOoAyhXMCKtkDYFhqwyYphuMqa3Rm7qv9L9ai+c
        t9lSp3YV8g3dCQHh4cFVNThmOQ==
X-Google-Smtp-Source: ABdhPJx61ZrdrDebFM8AftzJkYmD+yuA3yIEk/5UglOl4tVRaCelmO3ZaPhQZ80e+8yRyMHvMyHlDA==
X-Received: by 2002:aa7:8d54:0:b029:3cd:6ce7:bec6 with SMTP id s20-20020aa78d540000b02903cd6ce7bec6mr3575308pfe.69.1628545354534;
        Mon, 09 Aug 2021 14:42:34 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id t8sm24803877pgh.18.2021.08.09.14.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:42:34 -0700 (PDT)
Subject: Re: move the bdi from the request_queue to the gendisk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210809141744.1203023-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1daf9ad7-1c6b-0e57-9645-7902feda712d@kernel.dk>
Date:   Mon, 9 Aug 2021 15:42:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210809141744.1203023-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/21 8:17 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the pointer to the bdi from the request_queue
> to the bdi, better matching the life time rules of the different
> objects.

Applied for 5.15, thanks.

-- 
Jens Axboe

