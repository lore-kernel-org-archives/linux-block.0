Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C95C43141
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580D020729
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 21:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zXOoFyHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKOVQq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:16:46 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42645 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfKOVQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 16:16:46 -0500
Received: by mail-io1-f67.google.com with SMTP id k13so11937701ioa.9
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mJmTC1QtNMiaCcr8D76CJ+X9L2KeTkZm+OBCF6hm9ZM=;
        b=zXOoFyHgi6U7TPx8HDoeqzaEYSYazoOtsSrRCwEId+0Vyt1VxoIHay1RLm14x7Kuec
         qKo1S9jYdiL/tfZxgT4hNtXagy+/sg7gbsTDGmJj45jLilIvRQZlFNiJvHkh9+VUSYGX
         XywLMzi5X+CgctttfSUxhnxA4nuL+tCC6BXdSVbJ4Y6Txe4mx4cWGOKkc7JLjGVtvYC5
         Iv6l6ALx+zQw1IzWU4Q8WL+xBCtRxfEX5Bnb1S+I2At4wAT+iXiLeh3RRWuayAIlxHWB
         35hA14dDAKpp+8SSbp5AXvwOhUxnwBAk2LWGlGCtr3AsEi8uHrzEOQ8MVsYTlZdGF458
         2Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mJmTC1QtNMiaCcr8D76CJ+X9L2KeTkZm+OBCF6hm9ZM=;
        b=GxrOk5BgTzac3x9OrENhcC9TfpPTI+p6YMNXt9NEp4zNorXk2XdFGEd97rJtkFCrYR
         INKBhq1NKGfj0CFdEVKnTaRb4zhPR2wBT/Hhjlju1KBTQzibxoiBvSVbs/oXx77dBoOy
         Mx+oQxBSH9RXua7kosttQ14nc8czI11yc88Cl0Y6/swJnHwHhP73DHugFOzYr02Fwly/
         8uXQdOeXKkkfsDcKW7V0Uw1QThG/Z9QdR1mN2IO329UrRtvnZ4q7kfEQiPMclrmulrC/
         WoynYxRnzcHYHMm529K1YKUT54P+Z6aO9gUeP+4AO70fdIkfB+zzhNmx0X3KsQdaDayR
         46yA==
X-Gm-Message-State: APjAAAUCw5432QY2BLg3iskZ9+d2nkiuA9PU/9Lw/mdO6d63IzwpDdtI
        IZXNE5npRPIVwhOQ9trvE+k9rg==
X-Google-Smtp-Source: APXvYqysQd6n/HqrBk5Sae6V/L2DWeByT8WfjX3YbOmKoOWkbFWyXNV0gUsyNrFrLwd0uvQQFmlwVw==
X-Received: by 2002:a5d:9153:: with SMTP id y19mr422748ioq.26.1573852604986;
        Fri, 15 Nov 2019 13:16:44 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d11sm1842228ill.17.2019.11.15.13.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:16:43 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
Message-ID: <cdba1334-b037-d223-29a6-051bd49fef70@kernel.dk>
Date:   Fri, 15 Nov 2019 14:16:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/19 12:34 PM, Jens Axboe wrote:
> How about something like this? Should work (and be valid) to have any
> sequence of timeout links, as long as there's something in front of it.
> Commit message has more details.

Updated below (missed the sqe free), easiest to check out the repo
here:

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.5/io_uring-post

as that will show the couple of prep patches, too. Let me know what
you think.

-- 
Jens Axboe

