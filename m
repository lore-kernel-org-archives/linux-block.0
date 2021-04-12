Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11934C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1E561246
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhDLMpx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbhDLMpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 08:45:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5CC06174A
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:45:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7028441pjb.3
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8aDVNfXoIF5XPU+6/Ppxn9gxD4WX9+pA2AtuzcQRxUI=;
        b=TLUfENejvCj7xl7DF1FRmMlQOhpRzSSMNznkPnW99D181qC9CyTVzIt4cQpDLIHpbJ
         pX2t5BdtYlbF7Y3W/eRPYcMtIhK9IgvzGSqzpU+TmLcu5DQ4OeQlmpL4vtEhIy5b11+2
         o6bLFB6B1wtvfnPcegv0R1s2bU4ivOoOAZyozSKMp1GaJBnMhoJwJBmINJLvMHRI+smt
         qWVMw6PxNbw9Q/bw4/HsMukxrtMnse9ux2Toi76TrELC8UAAe7ziuAtPlKys3uFhFY7a
         nK3BTrWwNUK1vYBKI0RiWlM8/IFR0gBcL+Qy/Kpss7BY4pCUkO8cEwXzBP6gofZWNnCg
         LGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8aDVNfXoIF5XPU+6/Ppxn9gxD4WX9+pA2AtuzcQRxUI=;
        b=bRP0ybJTQ/IYxeJnrFQ4ThyGVJEwgQf/XtGc4XPX/XTRWnLyUyRTZExvw15UZdTINH
         +CWO6LdrSVfiYmW1u2/U6/VyYKMHKTqsmlN09svvkiULIEK4ucNUdEyjTKXr/TLNMqQd
         ZpGAQmJ0EdhCIorHLHPW8epGnIC1h5lCQjkPkVJVf1BtJNL9TRhgvfciT+HLmsDyPHG1
         H+BFzy2vv1kd1bJn5u8UCti5kDmuWo/zaQp/pf6oYFLP9m/J2ZmGE67qC7Kl1zPKes9g
         Rpkfi9HW5mLdPxoH3IVKLYcwkGsEKnF2wHBwpAyyhUoozi2qJZACjBjMj8f2rsHkA7Bv
         cW3Q==
X-Gm-Message-State: AOAM533iEUu/Tc/cIXWKyG1CZKSoBIbyz5nuKK0HaVNvGWM822ruNKIQ
        mVqItt/ctTeM80WB2L8idTdDpueGmblLXA==
X-Google-Smtp-Source: ABdhPJx4eWH3dv1t5oFBjHS+MBD7mUH4E6Ywg8kSUY0Jz6aA35Yu3H4XogfTjAjNRzY3Me2gprr4Ig==
X-Received: by 2002:a17:902:ed14:b029:eb:8e3:bfc9 with SMTP id b20-20020a170902ed14b02900eb08e3bfc9mr2547591pld.54.1618231534394;
        Mon, 12 Apr 2021 05:45:34 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t23sm7474894pju.15.2021.04.12.05.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:45:33 -0700 (PDT)
Subject: Re: [PATCH] block: remove an incorrect check from blk_rq_append_bio
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <20210409150447.1977410-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ddbd92c-bfb4-017e-e00a-1bde201a3571@kernel.dk>
Date:   Mon, 12 Apr 2021 06:45:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409150447.1977410-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/21 9:04 AM, Christoph Hellwig wrote:
> blk_rq_append_bio is also used for the copy case, not just the map case,
> so tis debug check is not correct.

Applied, thanks.

-- 
Jens Axboe

