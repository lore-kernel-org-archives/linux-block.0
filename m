Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE35C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76B561153
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFUQJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhFUQJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 12:09:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3660C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:07:40 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d9so7570552ioo.2
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kH3jgnKLy9HB6R4byF/RNSNoVFANGWvscmGaNzjiulo=;
        b=YClAigfJME8Y5c9KIAcYPm5IJVDRurBUofGlgannlnAop2q5wWtY5XH3pbg8BHQxei
         +Yt7tWW94fBcZLmLiqSQDdjD/IgYc5yRqmQATWZIRHTjcF7nVFSBJ2e8fO6nSLiMjgWW
         YK1Zqu+7MUwlJrzygJkw8eKUjxgfrlEOe+TvRRXrRm1K0HNTdUoBQ0WZqdisI8Onv9Vs
         tLlyuwZenVSUzSDQcktNdKZOJpFxkqsctwAtFU5qMbyLWDa5dQywArAvpWGN/+MsHjkM
         uZRNEKwCvu2+9/j8zm4Dk1BK6+IYNSBWompuCf23UgirW885z7acqOcfVYOTu55mej0e
         Qnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kH3jgnKLy9HB6R4byF/RNSNoVFANGWvscmGaNzjiulo=;
        b=nIpYYSQj/z2658QNY5ylGsRmv8ZLcqgYDP9DNtn3m0JSjlbbKsz06/QrPfRKuZVjhE
         of14nZAPTjhlX0Zn/V5PTkUi+FvdsIxcrMhdqe7CeZE70PBlyldV/nP65CoKIh1D428J
         W1a/xip01w48oXNpGdNTAL7Gn3WHKd0WbZE2vqDfP52fUaw6MorMtv4KLeOOwFVIKhWk
         tgZQZno4JoIn4mAqKreHN7UHljc2qaq/nCu2j1GAPUHX8sRmCS3WpNi8oZvH4srnGuDt
         JnGbtS9MFBHaxBA92npbIoT+SJuOgOGdCSF/c8aax4Ot6XqOgFfYQW6iSlMGU1bbscAN
         BeRA==
X-Gm-Message-State: AOAM532UH1NUwVTFLab1KbEsT0TaYCkvkC2KnV/lHI/LmOiZ1XZA+nlW
        2CQb0Wa5jqkQmi9oi9ck4Flzyw==
X-Google-Smtp-Source: ABdhPJwublf3rDYj0gMMCe8o91jpwhGelZAqLUXjlJ0EAci1COUmXghM88WITNrKc+1G0rXCjAXIUA==
X-Received: by 2002:a6b:310b:: with SMTP id j11mr20119630ioa.151.1624291660153;
        Mon, 21 Jun 2021 09:07:40 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i1sm9882917iol.16.2021.06.21.09.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:07:39 -0700 (PDT)
Subject: Re: [PATCH 0/2] blk-wbt: fix two wbt enable problems
To:     Zhang Yi <yi.zhang@huawei.com>, linux-block@vger.kernel.org
Cc:     jbacik@fb.com, yukuai3@huawei.com
References: <20210619093700.920393-1-yi.zhang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9e6167d-ca23-56f6-7852-f5d5e0c59cfc@kernel.dk>
Date:   Mon, 21 Jun 2021 10:07:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210619093700.920393-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/21 3:36 AM, Zhang Yi wrote:
> Commit a79050434b45 ("blk-rq-qos: refactor out common elements of
> blk-wbt") introduce two wbt enable problems. The first one will cause
> false positive check by rwb_enabled() and lead to IO hung, the second
> one is wbt_enable_default() could not re-enable wbt after switch
> elevator back from bfq to other one.

Applied, thanks.

-- 
Jens Axboe

