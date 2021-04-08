Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E3C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 19:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BE9610A8
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 19:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhDHToh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhDHTog (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 15:44:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568AC061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 12:44:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t20so1572194plr.13
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bfastjAcTH6GvPwsRgj4kE1AV0IU20Avq5QkV1jf3r4=;
        b=EJAHG+Uic46Jnmh+49aazvcUkUVTtFlYpkrr7bKQDNzWmlAzr7wuVZCTqKnJo576Uj
         I6caQ9M3WepGXq8KfauX3Kz0E4DW5cZMtRc4OR/R9wPAWKD2BOLF/z2KXK3AGQy+J3aG
         3H7UueJOv+dgTrAgF/+TiTbJUHBGezmWFYx5BXdLZrGBu7xfJ57v+rJbewkEf5hVQ5i7
         dn9oyKikDARyd1AFWtyKSu1bZkW3Cb+0qtsEUNT8dRp8ai7CcNcDKip3rcUZZlhsFjbW
         pZNBXKU1Uo9E8jDdZm/cc5iIgOj3DgQbJNiVB3JVCDe93ggFZXOBWgDBgSly8WXXwkpJ
         XbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bfastjAcTH6GvPwsRgj4kE1AV0IU20Avq5QkV1jf3r4=;
        b=a6QtYhFEcenXlW9A64bLSqksqxdqF9wxsBSb1eK6TLNsnIxx/9zPJUt8KUz5Z761WY
         XBR79+E7TUIUAYYXlXk7jw9TE3rhItK8Yv8Mr9Pu3EL8nvIrx/b6eXFfxuwdcCZEBEm1
         4qMqHhC5YGAuo4ldMYIabuO/n2xeRNALtBbGY/ykXbXheZTI7GmRo085o8r8bpIKtOsu
         xK/UF3RujpbmyM1aORJ1QRkiFVHmZ9uv7Y671cuGmp16nAsMadLs6Uka9Nbfebb9lZ48
         zB47OWmJJFntw89fVTbS5Pv9JVaSjP0x7Ufoda/j6DZoQ7c6+/iFx6dfRE70+Um80RRC
         sYJQ==
X-Gm-Message-State: AOAM530aeM3SZbUKJiSp+qhLUKmyDu4qWU660KsuuB9GP325a/UR5+i+
        c7XAmjdhwwrnMIAZ/eqcgoLmeNAcwCWeMQ==
X-Google-Smtp-Source: ABdhPJwLOPv5mYkBNpJyACmTwL9RSZ7tTYjT58P3V4Ml4mAfiOEPPlBWb3tBEh7V6+dxN64G/duR4A==
X-Received: by 2002:a17:90a:300f:: with SMTP id g15mr4386373pjb.88.1617911064537;
        Thu, 08 Apr 2021 12:44:24 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q10sm168327pgs.44.2021.04.08.12.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 12:44:24 -0700 (PDT)
Subject: Re: [PATCH] block: Fix sys_ioprio_set(.which=IOPRIO_WHO_PGRP) task
 iteration
To:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YG7Q5C4Rb5dx5GFx@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e8579a4e-2456-a89b-b750-892d265ba053@kernel.dk>
Date:   Thu, 8 Apr 2021 13:44:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG7Q5C4Rb5dx5GFx@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/21 3:46 AM, Peter Zijlstra wrote:
> 
> do_each_pid_thread() { } while_each_pid_thread() is a double loop and
> thus break doesn't work as expected. Also, it should be used under
> tasklist_lock because otherwise we can race against change_pid() for
> PGID/SID.

Applied, thanks.

-- 
Jens Axboe

