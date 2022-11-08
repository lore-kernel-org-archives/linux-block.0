Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39468C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 04:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKHEUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHEUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 23:20:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0A18E24
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 20:20:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d20so12037476plr.10
        for <linux-block@vger.kernel.org>; Mon, 07 Nov 2022 20:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83cd7INcuiTijOYYxaNVDXaneiUKh/ka3WlX8BaSzV4=;
        b=57rQLTKweq+vsGfc2d1yh23GAVXfhMtiSSF6UydvT7zAkGpDRt5jGCXksI4j5kxoeK
         6L14oN30Jgtp5H2Wobm+91dibkKP+9OsLI8ZjDmvGsUV6QjFdYReF7MdachKgZ5A9X8W
         ddWi73WPIXyBjHmtNV/6w2z4yN6QucqYItGfYWrxH8/1ekIyvpI09p+i0mO2PZXTRTqN
         1WBmTzi/jIUviZg0oRDhHsEMcPBBDYvTnfDVIMVcMFLmGjIM2+nS0ll5kd+ex/7LylIA
         7obxtWbMWk3mh37gW1YEBFHZd4w3aoTcV6Kx5stHFtntPFzIsivy7w+34jSC2MdZ/MEb
         SzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83cd7INcuiTijOYYxaNVDXaneiUKh/ka3WlX8BaSzV4=;
        b=tP7qs9xDKqIm6YZOzYMEcyx9RXop1/riE4CS5ts/5QVpJSTV2FdoPWu4Lv6db0VbJn
         fpynp7cbroeq4FCxBeUt/UPHulQahtdG8ud9pJRNahPIk8V3O7b7zJYzRRO4wgEyW8Fw
         mBRinIOE4tUwY5TkMSs059uC56oIsTFEiOPmTrGihreJqJVDpW2NupT9erHpnwsDabvU
         54A4b8blHb/oD4L8i3qbmvRug/Yibuh/gEu6KBKytAt6dMMRUHqtCuKIik9KUPJGv0Vj
         yGWkEvIb5K5CvQ1jC20qxdsrFI8L0JYCuCxF9pay4nSKHViqLCfhN1DoeFqIFDgJIACN
         3coA==
X-Gm-Message-State: ACrzQf36m6IK8ealWmZtv16wvdD/X/ZJwRJhZ7m0OWaSly7Dt7J0kM2y
        3ZBWlDHBP3CjX8ntWYb7wttcEg==
X-Google-Smtp-Source: AMsMyM6fH8pVSzjczSJr5w1oehVW/AZHC1P/OlbHJFpOuEC4vrXVdHkPEugmBYbvTgAcNBDM45S1Fw==
X-Received: by 2002:a17:90a:e60a:b0:213:e299:b8e8 with SMTP id j10-20020a17090ae60a00b00213e299b8e8mr44489887pjy.85.1667881239137;
        Mon, 07 Nov 2022 20:20:39 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b00186a6b63525sm5771049plb.120.2022.11.07.20.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 20:20:38 -0800 (PST)
Message-ID: <97c6c6b7-1de5-a341-e24c-f18e62aeaae7@kernel.dk>
Date:   Mon, 7 Nov 2022 21:20:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] blk-mq: remove blk_mq_alloc_tag_set_tags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20221107061706.1269999-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221107061706.1269999-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/22 11:17 PM, Christoph Hellwig wrote:
> This is a trivial wrapper with a single caller, so remove it.

Getting rid of the helper is nice, but the realloc one is badly
named imho. Can we rename that while at it? There are only 1
caller after this anyway.

-- 
Jens Axboe


