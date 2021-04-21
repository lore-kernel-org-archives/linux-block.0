Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E8C433ED
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C9061455
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 14:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhDUOlG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbhDUOlE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 10:41:04 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC2CC06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 07:40:31 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so13185564otp.11
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AH32/rABzPy+b1uDLEY52lyuDgGlyiN/6gH6y6fqpmQ=;
        b=XaaP+ox8Cddm57QfCp1v1QRzHEId0e9r8CpBNFCbvZSB+ydFwzWVEYMvBr1tOy0KI0
         rmZ2IVBCfjfWqZRyi8XK9eQ5HEWsv9zYy30QaBpuUMrKDFiavFCQWZa6/W0Uybx1X5fY
         hJgfLx80SKvWzodTV9jgIk2GuRL0bpc+bp01/vtgYiX80l40PmbFDZ2yo+ajCFEyCclz
         Vic7WUOvqxy+hm3ldWnDRyjPu5lwlpzDJEOgpMIr6TYNdqfyq01dL7VWicE1frst0CoX
         LIlO871AxMaRs7ueGtOj+LDV+RlqfE6SeCRF1OkAk5WA9LILGoAIL4RFZ8OOanW00mBF
         iEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AH32/rABzPy+b1uDLEY52lyuDgGlyiN/6gH6y6fqpmQ=;
        b=SuflkvkDtQyt238X+kHJjq4o8M+QCYErBw9A0CtEQ9+kEWXS1lTaPYQy+UdX7YhNtm
         MDgSLsKIDoMQ9kMI65h6l+jSTPks5Q9wkqULFIEQrrl5KOZY6sKOIEJ+yLCslnlmBtB/
         rHINB7jj+O4PhhTVZisGnaYrAXH97DadCXgjxfbMw9oCeNVAmECuDzNvQOaaf0AGf36F
         qlHiiRck0uzkqp5FqfBu729VUPZz1jPQ1RH7mR3RgdeD215KB3dXJrfNvSciPc6xW/h6
         Oa1kawgDsBrOeGbjUt+uIR+fsxyW9D2ZZmGrN7KoH54cp8O7fIlaP7EhOiMukzOgAPI0
         eezQ==
X-Gm-Message-State: AOAM533fCkcyVZRDJWsHOtxyG05VxLm4pfN05R4wm3YO0qQAnUUbMiyN
        98ju76OYXL/zVqEUguIZgOBEAQ==
X-Google-Smtp-Source: ABdhPJyeffYylBu59ZZ6naP7YKnD89PrsWG2LfWzlkfF4F1y+qb1d5mSpthNdwZ5seIrA3I5fJLdDA==
X-Received: by 2002:a9d:7b59:: with SMTP id f25mr3104110oto.53.1619016030975;
        Wed, 21 Apr 2021 07:40:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id s3sm476929ool.36.2021.04.21.07.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 07:40:30 -0700 (PDT)
Subject: Re: [PATCH v7 0/5] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>
References: <20210421000235.2028-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15145d5e-10fc-50b5-5cde-10ead860f534@kernel.dk>
Date:   Wed, 21 Apr 2021 08:40:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421000235.2028-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/21 6:02 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> This patch series fixes the race between iterating over requests and
> freeing requests that has been reported by multiple different users over
> the past two years. Please consider this patch series for kernel v5.13.
> 

Applied, thanks Bart.

-- 
Jens Axboe

