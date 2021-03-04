Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C61C4332B
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0092164F42
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbhCDAu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451822AbhCDAiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Mar 2021 19:38:11 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A0C0613E5
        for <linux-block@vger.kernel.org>; Wed,  3 Mar 2021 16:37:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j12so17528382pfj.12
        for <linux-block@vger.kernel.org>; Wed, 03 Mar 2021 16:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3lw4xYsAYM4nNGD3pp839+oyNk5fzKw4o00Jp0gKL3g=;
        b=fpTUmdMLr9O0F3dsWilaKpMfgoq51uCqsvKsJZL/QxMWTCXyFfF34vl4kbMMfNAPay
         CAK/rd0DY8O6YBcqgoimMZcx9A06F/X5y+B7OydM2XSJ0FW1qwxtnQKZwY9GA0atFQkQ
         X21r9I/Oap8fzbiQyC8VMhExGriRMRSUQNQ/G3LznS2id04Kjn5XqKoReIrFIUgDhgb+
         haiM4reKn8wRRAVGiIzIUOsjsPM1nytLzQETrsW6xZPQZG81TaLXeRqAlTsyolJJ8x0m
         ceZQKnrpf+9bgpqqGgg1IoqjJm+W/BH73Mggqtr69H2LwlHh6YL8Un4PCqiH9SxYaa31
         jD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3lw4xYsAYM4nNGD3pp839+oyNk5fzKw4o00Jp0gKL3g=;
        b=gpkb49m5TUIiz9UILIkBBXy6Lp6N+XKZO6xHmLBerK9yiN8+GbtC8LE+kpIlXYJ5zG
         P2DEC44X3U1YQUaBClvTQQ0LA6F9R1wzPbRGPhPikb7uUIjep4bQS6Z1976Bg/iyBFuP
         PpWvwPmNpVXOg8a65os5+Gvx7/AsI2xRTdKSP3Ym5rRXs7w4JkV/jf8Lit4Lh68R2B1k
         v0d+xEi8zf31WnINmImz6KHHWt9HBZZv6L8nmL7NRw+yjr5rLSOV9Sb9M6YT16SytulF
         uQ0tHm9wzagXpEbDhDIRkyUA87mgQ5Hm7gkh1KRElaqWd7y+gTOD9MykcoR3/BwkMtB9
         sHeQ==
X-Gm-Message-State: AOAM530jgqc8aVMIZc19UCSGdk6Ca9AyUVd4eDYPFfsdLmt+73WyKeqd
        1MemL7UMvkrnbRaNgW3kNRa5Sg==
X-Google-Smtp-Source: ABdhPJwMGv3OcuecvAWs+zF2L0Hj4jwyck66kQjBzy0EQ4mvd/le2HXi8XyCGl94ffMOcSh1fbFt7Q==
X-Received: by 2002:a63:4442:: with SMTP id t2mr1309496pgk.23.1614818248751;
        Wed, 03 Mar 2021 16:37:28 -0800 (PST)
Received: from ?IPv6:2600:380:7540:52b5:3f01:150c:3b2:bf47? ([2600:380:7540:52b5:3f01:150c:3b2:bf47])
        by smtp.gmail.com with ESMTPSA id e10sm8019732pgd.63.2021.03.03.16.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 16:37:28 -0800 (PST)
Subject: Re: [PATCH 1/4] block: introduce a function
 submit_bio_noacct_mq_direct
To:     Mikulas Patocka <mpatocka@redhat.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        caspar@linux.alibaba.com, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        dm-devel@redhat.com, hch@lst.de
References: <20210302190551.473015400@debian-a64.vm>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8424036e-fba9-227e-4173-8f6d05562ee3@kernel.dk>
Date:   Wed, 3 Mar 2021 17:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302190551.473015400@debian-a64.vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/21 12:05 PM, Mikulas Patocka wrote:

There seems to be something wrong with how this series is being sent
out. I have 1/4 and 3/4, but both are just attachments.

-- 
Jens Axboe

