Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B4C4167B
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiK2TCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiK2TCV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 14:02:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3816444
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 11:02:15 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 6so13882435pgm.6
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huz+qkx5qKOiiKYcMwB8QQkDRCInoNi0jIxN/BCcI5Q=;
        b=J56W3Yl6sNYR+dAdJ9ExVrMKpBZ1PAiKnQJtwxEVOwNriBsbxL4aEp6qiSdWJ02UqV
         CVU72nw5YhrGRGknP6WLiJAfNr+Dz9yv+hbHVgia8H5/MR/7ZdYKxay8wbWbgfxYAhW1
         4UlTIUTh6Vyt15BY2ZW05vX5SkMGZqH8B9eirEFrRe3WHox5cgZr1b5OE8cpjJXI0L9+
         pUXuG9/V2PCspYfRxkQe4KVGyqi/9NTISHT0Ik/xzwVO0fR7EHlw+kaVXqPb/oQ/6k4J
         x9qF+U/j+DWlDS7hLxzMqZluwv7pu7FL4H8MaB+YTkdbGrvI/yryKWUIsAonLVS3mikN
         IJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huz+qkx5qKOiiKYcMwB8QQkDRCInoNi0jIxN/BCcI5Q=;
        b=sULPQ4IyP8Xe82fhTOBtO8jxevBSPBPEJA7n2eCH94P+L09jh/4qSxKesV2txR158L
         ZUR8iGPRgaQ5DFLAg9bPMxNW8VMjVBlqFGZTQsv+y0vETgX+Rps/KMWBuLNJTIiTRhl0
         I/5rrLe1vTsMh5qLw4WAye5hR2l6+YdprOI/gKHdXRg0eq41L7P8Xqq11ZAFVBkhhQj5
         tCuZUz9koh/piQaN/aImkNuvtfbQhbUc7FLrj/p7eRwJjNJg5RzogNAYCDSb3VDvuOvu
         G61/xQUHz6jXn6pDPVp6WKglSDJAHvX0J/5Q3tuuiPn8CYpvLzGeZBBPwhHEPw7tlcfS
         Sbmg==
X-Gm-Message-State: ANoB5pku9BqY/zvynC6OxSFfPQBP2ol2W07gTS2hUvux2UjDBDlXY6iI
        TkP/PyShzYtSPxmq5VFXS1AfKQAxqx+enIx0
X-Google-Smtp-Source: AA0mqf6gXtqtA0pimCAWoIDTyPYVHp3wAilc7b35jjbtpsyl4dYZSrSNtRoDY7dQUT8Gs1R7NEqy9A==
X-Received: by 2002:a63:234e:0:b0:470:4222:c3ee with SMTP id u14-20020a63234e000000b004704222c3eemr52083768pgm.571.1669748534966;
        Tue, 29 Nov 2022 11:02:14 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001897d30143asm6356621plg.289.2022.11.29.11.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:02:14 -0800 (PST)
Message-ID: <e3e62491-d670-df16-94f8-51feb5d159ec@kernel.dk>
Date:   Tue, 29 Nov 2022 12:02:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: blktests: block/027 failing consistently
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f9490310-11e2-fdc9-db3f-2b4a51170c85@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f9490310-11e2-fdc9-db3f-2b4a51170c85@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 11:49 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> blktest:block/027 failing consistently on latest linux-block/for-next

https://lore.kernel.org/linux-block/20221128033057.1279383-1-longman@redhat.com/

been a few discussions on it. Waiman, how's the fix looking? We need to
get this sorted asap, or I'll just revert the offending patch.

-- 
Jens Axboe


