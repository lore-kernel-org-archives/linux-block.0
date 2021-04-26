Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73DCC433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 15:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DACB61289
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 15:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhDZPFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 11:05:47 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA07C061756
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 08:05:06 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v13so7092520ilj.8
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMztohQgZ6nJz0Yf3sV1YO0hfcw9sjGPqCAVQaP0xKg=;
        b=AmduKi1LpOfaOKLNxHbTAsmqOsnJsgBSJkPL69Tlsz53G4PgbsczXBRLNUAlpqNlGF
         63EAgM1kxyF0m67NqbJkmMZZdeoHWhrJsRwLEk9RTy1eSy1v+cbv8AWF9aeGLvtsFX9Y
         YGNvmxfARZajok7XYvpDDuXtpvZgCrinICvlTnraUpTUGXiXouz6uiCh0h/5767rXmU/
         iUPjI8YqXYnSMtB9GXUsat/aljFWjehWu/WE8knJ8KFET7UlmcFxthLGQOEjNEbm+lvY
         CoOl0nqohL0CPPbS6/3/5GtIWfjaS9bwuXuJnk1ituSPP4zZpoG+mVpsyDAE+IbnmeLF
         sCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMztohQgZ6nJz0Yf3sV1YO0hfcw9sjGPqCAVQaP0xKg=;
        b=TiiIwTZWUeAP5SjGR0rN1Qez6mIQCaz4sROAw3wyulrwGkUMWXkrbz1aJnCXVIXxOE
         7M/ZiW9cCPbm8kDuMgTQxHR8cwjYNxYteWxQlicqz9Ds4hdQ4qCFPwYKUrhTftuMd/Ot
         5rXkBiPxEhs+/3m4J/+zUNzM+W8s6ebznCRc0sbzD6KQHPgs5EiY3wCcMbnYtxIwhC8c
         eItAQSkKtZbwsBBm8CL4vZ1ODiJ7DBZYj0nKwn55s8MZvdPVJ0Gee7B5vRNRmrDaWPro
         U2qcIYV2kJKaD9g2XGKC3ilCmkj3rKobGjkj3dLFzj/WrCpYsg1uSzbFvJpfD/o0mlxt
         VKdw==
X-Gm-Message-State: AOAM531k3CJ5P7bVtuSKiAcp+CNTaufv0YclB0X5doFL0CK3jQ39537t
        8sdBTH8l+EfSYcYugmuOdNS7rA==
X-Google-Smtp-Source: ABdhPJy4XK0nwvX6VqHA4XaVwMJoW4D29o0DXqLGumuBpYj+IT4ig6jXO7NU12w2dBSPJTaKhiuRAQ==
X-Received: by 2002:a05:6e02:20c1:: with SMTP id 1mr13557255ilq.71.1619449505796;
        Mon, 26 Apr 2021 08:05:05 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k14sm7336813iov.35.2021.04.26.08.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:05:05 -0700 (PDT)
Subject: Re: [PATCH] drivers/block/null_blk/main: Fix a double free in
 null_init.
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, damien.lemoal@wdc.com,
        johannes.thumshirn@edc.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210426143229.7374-1-lyl2019@mail.ustc.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <434036d5-4610-3b60-74ba-5641cc2b9d5b@kernel.dk>
Date:   Mon, 26 Apr 2021 09:05:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426143229.7374-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 8:32 AM, Lv Yunlong wrote:
> In null_init, null_add_dev(dev) is called.
> In null_add_dev, it calls null_free_zoned_dev(dev) to free dev->zones
> via kvfree(dev->zones) in out_cleanup_zone branch and returns err.
> Then null_init accept the err code and then calls null_free_dev(dev).
> 
> But in null_free_dev(dev), dev->zones is freed again by
> null_free_zoned_dev().
> 
> My patch set dev->zones to NULL in null_free_zoned_dev() after
> kvfree(dev->zones) is called, to avoid the double free.

Applied, thanks.

-- 
Jens Axboe

