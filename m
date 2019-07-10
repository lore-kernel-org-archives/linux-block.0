Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40516C74A21
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127332087F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U81telEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfGJN5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:57:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47085 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJN5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 09:57:40 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so4813045iol.13
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5GbjAQ2BkHHz7jIGN1nXh7A5POhfC3B+GwTz5D7kHeg=;
        b=U81telEoGjTphWwolw10dnGCq9TEdxQUtE3bYGzcr8Fm1jrlDrBPJFWH4ePAez0Okf
         IfBdxV2eJmcr1TvSFStxjj9qwh6UFrGAtZZ6ByaoxpmFY39hixg1fuBK0xF4Q+GnMzkR
         Wax7Jvyvw6JEUuQJefySOlP6bbMjD1kazfJ02naBA6oP7XQC0qxNR5tOgr+PyR9wPBzQ
         f4Euj9caDahH+XHNTz1gHIm2ffh52frwbyj0lfyUJXgTb+a44XKtsabSHE/4bjnUM5DF
         ZhCnMsxHIZ7SAuCi08p4bAYQXMzeYB9V4LcRa4uGmQlkkAB8PSi3w6mYOvVR/Xifm/kl
         l5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5GbjAQ2BkHHz7jIGN1nXh7A5POhfC3B+GwTz5D7kHeg=;
        b=PC4pb9QHF5A+Yw5Z2e6w5ogsSSbrC7nYzKOhxqA9jxCezRDpJ4fmMxZGAKZ6BW5XAm
         QXoFbBvd9jSC6q1u9ETQQEgB3E7NkZE9TbSt3vIWwBdaSZsAZZfwBsiGbi8h9suPajte
         ae9oG11lveZe8IEa+DPgC0yvQEmeK2UOiDDwLAN6udQw3Ft84Xfm1QCuAtaSgIDSwV0G
         hWNLenGjbH/wrEg1VBYm069I63dvT7hvgGb0bR3m6eviTXXn+4DhzEtKNJyG9LFRUbq3
         NMwzZdMhIhdbbfzp6o3ow3g+TNPxEiRPtJJwSy6IaU0WiH+hrwjPCweVThRodBDzlOLU
         8Aqw==
X-Gm-Message-State: APjAAAVzqxqsx5XTkBH5AWbl+gaw0Go1dR9XTv/niwZZbpPTcK/yG+p2
        m1aNSmYmDbYE0QsUQUafB3hRdLhXd0dz1Q==
X-Google-Smtp-Source: APXvYqzTacWpL5RT00+fI1TO17cpw8pqMaE5AGvHLm8mRXi/OWYn4rcNEiP3HSPp+S1lY9rBd82DSw==
X-Received: by 2002:a5e:881a:: with SMTP id l26mr14536823ioj.185.1562767059198;
        Wed, 10 Jul 2019 06:57:39 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c81sm2510343iof.28.2019.07.10.06.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 06:57:38 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix stuck problem caused by potential memory
 alloc failure
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190710083558.5940-1-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25691b9f-8c0f-0d19-d1db-4c4ce6dfb5a9@kernel.dk>
Date:   Wed, 10 Jul 2019 07:57:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710083558.5940-1-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 2:35 AM, Jackie Liu wrote:
> when io_req_defer alloc memory failed, it will be return -EAGAIN.
> But io_submit_sqe cannot be returned immediately because the reference
> count for req is still hold. we should be clean it.

Looks like this actually got fixed in my for-5.3/io_uring branch which
I haven't pushed out yet. Once that's in, I'd suggest we send yours to
stable separately. Probably change the wording to:

When io_req_defer alloc memory fails, it will be -EAGAIN. But
io_submit_sqe cannot return immediately because the reference count for
req is still held. Ensure that we free it.

-- 
Jens Axboe

