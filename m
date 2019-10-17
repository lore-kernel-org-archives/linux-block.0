Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DD3ECE58E
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE65A21925
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 17:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KUMQX9Sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfJQR14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:27:56 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40339 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfJQR14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 13:27:56 -0400
Received: by mail-il1-f196.google.com with SMTP id o16so2835397ilq.7
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2019 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgpsXwLHGXlj0FRpdB93vsqWHq+vj6WFGtnbcpo2Xa8=;
        b=KUMQX9SzeTt5/WvwlnzhMepFQ/cyh/k5HG+bAOrkp1wNRuW6D/9DVAyFOjAcNiPFBl
         ktiC5EMGROFhk4JhtL/aTPKNUm+hOQXfFDB8qjon5l5IREtgXn0eZSH7Bu/kz12BKN/L
         jcImGURdDdeZpC6tnIcw0ggMAJ9TQAj2oGacMd1kNF/T+wek9NArlm/VG56pcBmcL/qk
         9y9tPYMiVBbLW66iPe7D+WFNKFWWnebHMiE1Bu17TxHjmbR0GlhLNvIM2sDrubD2l9u+
         AswIsw5uPv6amnuqTufcaL4sd2W5mxZZXGOWZBII1CUqKLQ8lXTdzGUcIPeQOkd23hAA
         K+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgpsXwLHGXlj0FRpdB93vsqWHq+vj6WFGtnbcpo2Xa8=;
        b=jFbYNv+ceoF9UieJYA2chM4rIQVpyjKPUpi7Ny7NNLjrLbOWcxoJGG5APD4902dFXu
         ZWJZDPLixdreLWeD5lFDl2aZe1glnV9j6mt7jc6SdA0bDsRYOmHxrlbUhLAKYKVpasuR
         LAO65o+cJedB1quAVeawwflpN0pz9kFIvQqY28mdAzrlPU+4pqyST3XLUPU/Uswc8SX7
         1eR+zixxLY8BjStAn2alUgK2pk3bk2XygFQoY26nf7xLCAKHsA+gmO0sxHnZdzUuH+yn
         RvKGa1vyvpCIAJWZ1cuxyuUdho9ZvfE5opNWtlPUh/QuUsxauprd0aH5f32s6RMWS4zf
         XPQg==
X-Gm-Message-State: APjAAAWPLkQVXVni6TcsKEY3mBvt6ZLluxVFnIXm7AFSnkvxEcLeN5ar
        2tdrh0Wk+1eZmHfHGoZnSnRIsw==
X-Google-Smtp-Source: APXvYqwiy5jFJl5pGiEu1/QihogCjhYLSBDY3z7B31qWUPvEwukiBzOwPW9RCUnWk3VX7UpDhnhEww==
X-Received: by 2002:a92:3c04:: with SMTP id j4mr4928525ila.120.1571333273743;
        Thu, 17 Oct 2019 10:27:53 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d27sm1195248ill.64.2019.10.17.10.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 10:27:52 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix logic error in io_timeout
To:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com, houtao1@huawei.com
References: <20191017041235.45594-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <739796ea-15f0-b03f-1d4e-bcf249fb57e8@kernel.dk>
Date:   Thu, 17 Oct 2019 11:27:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017041235.45594-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/19 10:12 PM, yangerkun wrote:
> If ctx->cached_sq_head < nxt_sq_head, we should add UINT_MAX to tmp, not
> tmp_nxt.

Applied, thanks.

-- 
Jens Axboe

