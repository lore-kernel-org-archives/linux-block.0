Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59827C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C9220B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 19:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGATsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:48:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33616 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGATr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 15:47:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so7878495plo.0;
        Mon, 01 Jul 2019 12:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zTwBmiZYlx6Byko5skKuUp6sRWScJXH828IxIIwVctM=;
        b=mYNoDGBpYxl8VW8bAN1YOmG4uQlrNA9bk8FcMpBDE39LEBdus7xHUfxecqTuwDCOPP
         GXMaTP+VL7G59ym/EwMIZ1dCUQLiq8ux7pSBqO/5zqAYN0lkmiaeLLrqNn2nn8n97sdT
         6Nk9C4iiddaraoCDc/JRfKyemN2u/vqj4cE3JGQ42eae5w1EiLFy9lW6LdjqHbrqzmV4
         MjA5I8JIOlNnhYAjp8Ji2BNDeuNhHjkXtI5DFeQtxDo/Ay+uxupO/8+4mZeDD94OVeHf
         +f1Mexd4WRvIlOwdq3yNL0e93DlsX1cu44k6zbHszQnLLGayDWnrjbiSjkYuwYanNr3z
         7qfQ==
X-Gm-Message-State: APjAAAWmVSxuw06IUZ6b6QFn3gN5ZbBUIjMTtOHZr4XJPNNxFNoDcKcd
        zJZI/GXP5pjfa5WKX1TA+pvXT0/R
X-Google-Smtp-Source: APXvYqycHFFoAZg//afyYx/iI7zy31VEKKiG6yuQy5yImToi9cJjBaH720oBd8VFuEi+lZ5WqzQTKA==
X-Received: by 2002:a17:902:2869:: with SMTP id e96mr29689729plb.203.1562010478643;
        Mon, 01 Jul 2019 12:47:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m16sm13335140pfd.127.2019.07.01.12.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:47:57 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Use seq_puts() in __blk_mq_debugfs_rq_show()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <81847ca5-fac5-710c-29d5-f70b58f6437d@web.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e2a06dfd-4a03-2f56-59e6-abce261653d6@acm.org>
Date:   Mon, 1 Jul 2019 12:47:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <81847ca5-fac5-710c-29d5-f70b58f6437d@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 12:27 PM, Markus Elfring wrote:
> A string which did not contain a data format specification should be put
> into a sequence. Thus use the corresponding function “seq_puts”.

"should"? Why should this be done? Or in other words, what is wrong with 
the current code other than that it is slightly verbose and slightly 
slower than seq_puts()? Do you think this matters for debugfs code?

Thanks,

Bart.
