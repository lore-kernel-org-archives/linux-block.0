Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99BC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 03:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1722B60F5E
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 03:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIFDNd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 23:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbhIFDNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Sep 2021 23:13:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50FC061575
        for <linux-block@vger.kernel.org>; Sun,  5 Sep 2021 20:12:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f129so5353806pgc.1
        for <linux-block@vger.kernel.org>; Sun, 05 Sep 2021 20:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0aYegbSdO1FiBlBWI80aWTW7O5daH/lQmVZ3sA4ZzqQ=;
        b=dXDsfstAi1nwSKNQPFc4yUdvxR7lswwqgUZ6mH9AXmO7D84gxGtW5ZpWQr8wX0BBRp
         guQqJXC27/rEL83giZKOX7RsV6eY/4QLNp8JKtKPpAe3b74YYtmCssXbuSxzk98PQupH
         WbNRAg/UrX4tREkeTFaS8+o1K9sRyfdgbMEGa8joVhiP77ruaYEfcVf5PjvhPDKKiseB
         KhmD5chslTCfDlqAlnbB97Lzg7HTX6vpm0xTLWTTKQ/Tvk9zyhenXpswSnlP5f+hLE+/
         heTwmNJC3ltSvXlXckhmTf4K/Hcw2w9zuPtQ9UBW0doXSJKzpYmP+pG4ElhDf1pyV6t7
         AXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0aYegbSdO1FiBlBWI80aWTW7O5daH/lQmVZ3sA4ZzqQ=;
        b=ECK0MyzLNFOm3c75oR+L8YEKI+M08FPoxoP0YOLEK9leeODqx7dMwRQH14A6Udqa6a
         UgsWBcJI6KJSlcA/zyc0Dt9Jp/28dQTKFg+P2zENbHIfkxAHf/Zvj8tr3WnpfN60Vt+U
         Q0OHQS/BdUwRgkAPdAsmMewGSKl9GREL1sFpB0n47GCs0AMTGorL/wM1XVhY0QLRZZWt
         7Ijsfq0NL78+iBGOZnn+wVBXGeMOebX4aBSmJxNWh7t3dzk2Zsr8kid4eLwrEwV/Mxcb
         3gVTeGjuktMRzUffIkYtAL3HWTKcUKQS8u924eKHmiwzdvNrvyS7HK+CjmIxMrS5IhUZ
         yEOw==
X-Gm-Message-State: AOAM530ZLv5JeGlg9Fo2RVnCz/JLIusvcxTUJRp8aaZrphTgbPdgYVTp
        6G7k4fwGLflIYrLz5sn4iIBZ9w==
X-Google-Smtp-Source: ABdhPJzucBpcVDmS1+5Zg1wfMR3rlA068aDQSarztWzxXv2zpAXEVkANgx4TW6cPMc7AMCubTuHv1w==
X-Received: by 2002:a62:a513:0:b0:3f1:e19c:a23 with SMTP id v19-20020a62a513000000b003f1e19c0a23mr9904179pfm.43.1630897948086;
        Sun, 05 Sep 2021 20:12:28 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id h24sm5847316pfn.180.2021.09.05.20.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 20:12:27 -0700 (PDT)
Subject: Re: [PATCH] mq-deadline: Fix build error for !BLK_DEBUG_FS
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210906030918.3901521-1-chenhuacai@loongson.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2985f817-9195-528b-b814-1929058fe085@kernel.dk>
Date:   Sun, 5 Sep 2021 21:12:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210906030918.3901521-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/21 9:09 PM, Huacai Chen wrote:
> Function dd_queued() is only used in dd_queued_show(), but dd_queued_
> show() is only defined for BLK_DEBUG_FS enabled. However, in the commit
> 3fe617ccafd6f5bb3 ("Enable '-Werror' by default for all kernel builds")
> Werror is enabled by default, which cause a build error if DEBUG_FS is
> not enabled.
> 
> So we move dd_queued() in the CONFIG_BLK_DEBUG_FS block to fix it.

This has already been queued up for a while:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.15&id=55a51ea14094a1e7dd0d7f33237d246033dd39ab

-- 
Jens Axboe

