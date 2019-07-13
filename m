Return-Path: <SRS0=xoF3=VK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9400FC71142
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 21:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE4920838
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 21:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JzU9fg+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfGMVoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Jul 2019 17:44:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44223 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfGMVoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jul 2019 17:44:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so6414022plr.11
        for <linux-block@vger.kernel.org>; Sat, 13 Jul 2019 14:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rZqpvFGE762L9OobK/PGgV0CXPuhu7N/68uA7cqNRxM=;
        b=JzU9fg+n48cm83QOInzu/+7crBvXw+RPZI1phGTDp1FMXixPTjugHiUIZ/GODyEAVb
         6bqMcRi3otQEeAyypJ086SbpaNm22TQ7n7OmBM+wNDZKRcYsQEp+zZRmymXa7ZEAYc8R
         xm9MzMfY65GxY/UP94x3jREqwBlzdPyj2vwjusUtJPRl7k0kw1M2DYeKG91jcXksObhU
         2aIxqCSClfJRce/O0KOM7foLfNAiuHDCt7P9eLStyMSjAqlk27BSLhbZRL5LQa9GaEkw
         Vqdpvvj+4ucw8+RXw1+KoynHs/Fqckroo/6Kc6v+YsppHW2LF1YInQAqh1a+503TuasP
         PV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZqpvFGE762L9OobK/PGgV0CXPuhu7N/68uA7cqNRxM=;
        b=a++rGqc17XMgwDLAIohZoj4uC3XQemnqPh8yUunS6rbNhC7TkjzWyM5FT3DHrL8akn
         FPhNYdB5/G3cSimHBOkcBACAo+uKpZ+a6TPWAwkyjRg0SmTclLovzfeDoSrCkhn6HlBu
         haRRwmphq01qFjnde/v/Wi8NHVj+fZFRm1IoARTNjSP4edarmkhI9TdMw5IiTN/9DUmV
         Dk1TeWYvIaSA8WPFj5yl/7pjKxYPg4xsJT6vzd0O5BRSm6COKVWQGJAZM8hEe/Zi9zy1
         Ih41UhLFcTDTtkAbzFSFfIR5JRK0ffP+BXbq6K3ktN8r15N3LH2BkI8zGscyGc5h4+52
         LFeA==
X-Gm-Message-State: APjAAAXwS/frXNhS0uTNqdDdCZGGm/WFdWgPEIHwyEpOL+F8arHVVE1O
        D6Yd6dd4z5Zol7LedScUEQfnkw6NGTo=
X-Google-Smtp-Source: APXvYqxBPIH3/klkbaGlr+5elryBKT1pGgTOkqcV3g0sy33cQnxN8flWWaMNSS6EVlaJ3xJK8tw+1Q==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12mr19742560plt.87.1563054244139;
        Sat, 13 Jul 2019 14:44:04 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id m31sm13582079pjb.6.2019.07.13.14.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 14:44:03 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: use kmem_cache to alloc sqe
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190713045454.2929-1-liuzhengyuan@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f56dacc-6f69-35ff-dfb9-0b3e91696e36@kernel.dk>
Date:   Sat, 13 Jul 2019 15:44:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190713045454.2929-1-liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/19 10:54 PM, Zhengyuan Liu wrote:
> As we introduced three lists(async, defer, link), there could been
> many sqe allocation. A natural idea is using kmem_cache to satisfy
> the allocation just like io_kiocb does.

A change like this needs to come with some performance numbers
or utilization numbers showing the benefit. I have considered
doing this before, but just never got around to testing if it's
worth while or not.

Have you?

-- 
Jens Axboe

