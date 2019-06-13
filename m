Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A70C31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE3420665
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dww8Mp6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfFMQOQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:14:16 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40509 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfFMIma (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 04:42:30 -0400
Received: by mail-yb1-f194.google.com with SMTP id g62so7503837ybg.7
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zjpXrdhZdWSVnzo1hcCmpdYCRukSqJAaG4+HlfSu5wc=;
        b=Dww8Mp6DzN1GHQieAdQBJBXrZ6Dx9lwUFAyjoSpdOPjDv5aHFyXKPRFuPFDadk3F4N
         PlAxkpCqcbhb6+yKQ3k3gDZlgZ8ltdDU3HqW0ffCqnxdaRQN/wD1YadQA77Sbb051t1M
         u3hZk++QD/VFEeZiQvaXESGohxYVWpUChsQd0zFYnswawNr2oKOBEv9Rc5HGkHPQ3Rs6
         wP+KYkzy8EYouMLVbEHXfV8pMIxqWa3daudYkLkiEWCCTSBX6kXfjntbprtvsFputU3m
         DNZBzUHcvlxbDEeq+ZdSCnZORxSBGGAQFGxDcZryNZn+8w1MabKJ9e5hOwV6uOAdegLT
         n3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjpXrdhZdWSVnzo1hcCmpdYCRukSqJAaG4+HlfSu5wc=;
        b=L25jhQ9r3MRLnn9hGSiAdQndHZjS6/CmQDPaw/SzNGcaXZr7L9cEaLvPBjBAgjDb52
         proKdkcHzOWFhsgDt0T+gI/zyMoeIlXUMcozwViK5DFk7iBdjSeDUNO9A3rR8PEKGy7o
         ted29Ce4VSXCiUGyiemgVEoZ/4QiutAKGYowjAd3RIFygiBT3gvQDR+UlDFbt75YyGnn
         xRNJvXB81eidMYi1QanoJxjtz7UEa4g1IRTJZBAwUQIZwFCEYsa3FZ0vVxSr8xWEFJF2
         Jim0iwP5yyojeos4o+dMnP8GqKeX7X7uPzqm8ACKJahr6LuWuwZXpV9chY5shHTsElCo
         QzPw==
X-Gm-Message-State: APjAAAWb7g/7V7B/LckJQ43Iiz2f0tdzKzTajt5dhOp90TUu1gNvGoPu
        4zAFA99NFIttQbhyu6ottCbG7Q==
X-Google-Smtp-Source: APXvYqw6HbzBIcjkNiK7Q0GLBBoGGfFaDqjTHwqIkqQaT8YYX/nxFXa9ac5Nsx5wzsq/aODUxFvBaA==
X-Received: by 2002:a25:320b:: with SMTP id y11mr14886649yby.92.1560415350170;
        Thu, 13 Jun 2019 01:42:30 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id 84sm769447ywp.45.2019.06.13.01.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:42:29 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix memory leak of UNIX domain socket inode
To:     Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+111cb28d9f583693aefa@syzkaller.appspotmail.com>
References: <0000000000005bc340058983fe8e@google.com>
 <20190612215843.91294-1-ebiggers@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8afa475-8ed9-e8ee-c66a-270bea7efad5@kernel.dk>
Date:   Thu, 13 Jun 2019 02:40:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612215843.91294-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/19 3:58 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Opening and closing an io_uring instance leaks a UNIX domain socket
> inode.  This is because the ->file of the io_uring instance's internal
> UNIX domain socket is set to point to the io_uring file, but then
> sock_release() sees the non-NULL ->file and assumes the inode reference
> is held by the file so doesn't call iput().  That's not the case here,
> since the reference is still meant to be held by the socket; the actual
> inode of the io_uring file is different.
> 
> Fix this leak by NULL-ing out ->file before releasing the socket.

Thanks, applied.

-- 
Jens Axboe

