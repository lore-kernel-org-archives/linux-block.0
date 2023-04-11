Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E873C77B6F
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDKR5h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDKR5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:57:36 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC1061AC
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:57:29 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso8831180pjp.5
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235848; x=1683827848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukFGH3vMyNIaFtxo5MIRy2Mk21w1ACSjFoxmOO4Ssns=;
        b=ic42Ao7vXCLC+ZqmbT7mkfoFaTVEGIMw3mOElLp4nmn0i/hPJJySkBygZS6ncxQopF
         csE58CzeqRIp2uODk5oZ0OmqNFlHUhsVn6OWVdeFW5UurOGGaFI4mV620CZSQg3ltrMn
         VvlsqitLZuG6NsDKXjJxQZKQCWXnDvI7WgkxQsTzxPOlYoKx+wCEcPAf+RTnO/2bWqXu
         ka9T3TrlCBiXH6tsmlt4YrPhiUbBgvr3DHlwLX7NBo86kG0yhx/9zacq3TuPaDoV8kBU
         +KKzBwpSrnb9rfQYcaoydgEQkBS6YGuK+y18531zf9bWIMPJSz/r/uw50BbppojWocOm
         0auQ==
X-Gm-Message-State: AAQBX9fnQDfYeQvzyE7eyAh3hrbNiV/wREgzxysJQmzn67F+4cUviLCZ
        QSUUSEEV/msSIab5oY7a48s=
X-Google-Smtp-Source: AKy350aqENX9lo5yzDC6kBaSbccOM+pZmzq6/IrTpnt6Q7JYGrbJsS+WE0TNkDWRCjrLJbnGa60XCw==
X-Received: by 2002:a05:6a20:b907:b0:d9:8d85:eb42 with SMTP id fe7-20020a056a20b90700b000d98d85eb42mr14951544pzb.26.1681235848494;
        Tue, 11 Apr 2023 10:57:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78708000000b005d72e54a7e1sm4861407pfo.215.2023.04.11.10.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:57:28 -0700 (PDT)
Message-ID: <b6ba784d-2f25-8aff-5144-e45c076d56da@acm.org>
Date:   Tue, 11 Apr 2023 10:57:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 10/16] blk-mq: factor out a blk_mq_get_budget_and_tag
 helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-11-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Factor out a helper from __blk_mq_try_issue_directly in preparation
> of folding that function into its two callers.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
