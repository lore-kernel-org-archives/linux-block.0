Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C83ACA9EC8
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 01:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DCA21D80
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 01:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P+QKHS6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441921AbfJRBDb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 21:03:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32893 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438932AbfJRBDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 21:03:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so2760813pfl.0
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2019 18:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8hiQDiKBu8bq/v420z7KaeNxeXrGY0CPC2xZnXBHvc=;
        b=P+QKHS6cQ4aXmKHzwDxoUlOsI/lCHCbDNChXO6JLd9fKINqHViM4KZ0U1Cr9iN6OOd
         Qd+0IlIxuvUq+5smzFgA2/ppSSDzTuhqH5u5JMvHq4hwN6p71J/d+Y8u99oFsOJJfSNh
         eLMBsXMM8qesUbYOICQ3IDrPGOq1lshSt80ANtMjwMcsf4Rsygqu34BzqRJSzmSfBcyE
         Stie+Lue98d1227TVii2fUAu6o4mFghYckv646kadZRr4X6w3UJNbzTM3mZK0VKN2Opu
         T+wiRZTScypu4hLyBn4RBpPjLUjL93ZlFYnBI9ixfYX54tprUXLceZ+KTO32+Rr2dSwY
         o7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8hiQDiKBu8bq/v420z7KaeNxeXrGY0CPC2xZnXBHvc=;
        b=ueTbu/vKcsvj7nTg3ocnpIHjvHl6vLiC+onPY87J6lBVToGId+3lOdp7obtWm3zH/P
         zKYFs/Yukv4An9+MumcDx8QxUhNvWx0kAo1Zzh00P1olCraa6AArdbvzU8m/7wremYNp
         FJFFVPENg5ZkgzpE5PPgnnJ1ZeEA1U7/dBJZjA/L6T3cCpLgsvlqkV8X6BNusPujmPYy
         jTcmURFCyhP8Awt1kgihq1H7f/yz+uypp6gBvcyQNTw5y7rwXMQoqKbFyqX8AdNbPU7g
         qRKcjQWn77E1JrkEo6LzzG41ZjKaOpY+CYV/ewA3flql5pJxOOJoVBCjMd5d+UM7ZgVv
         PB0g==
X-Gm-Message-State: APjAAAV7jfi7MJtuGcDVV/eciaoSD7hemcRaV1mgAmMxgRhlh0P1NkYG
        TVfoPoC46xritjhdd+zOG0dx7Q==
X-Google-Smtp-Source: APXvYqy/Feym6XB1piCeyuLvDnzi7X7N5AzcitGLDDQicKaDNghdVWAoxxBHcs5lhhpIoBdcixG9oA==
X-Received: by 2002:aa7:92c9:: with SMTP id k9mr3472570pfa.215.1571360609431;
        Thu, 17 Oct 2019 18:03:29 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id p24sm6695080pgc.72.2019.10.17.18.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 18:03:28 -0700 (PDT)
Subject: Re: [PATCH RESEND] null_blk: return fixed zoned reads > write pointer
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Ajay Joshi <ajay.joshi@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
References: <20191017211943.4608-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3debc90-a3c0-c119-8d06-9a2273f92f2e@kernel.dk>
Date:   Thu, 17 Oct 2019 19:03:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017211943.4608-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/19 3:19 PM, Chaitanya Kulkarni wrote:
> From: Ajay Joshi <ajay.joshi@wdc.com>
> 
> A zoned block device maintains a write pointer within a zone, and reads
> beyond the write pointer are undefined. Fill data buffer returned above
> the write pointer with 0xFF.

Applied, thanks.

-- 
Jens Axboe

