Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE9C04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0204520815
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 14:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sCVqj0G/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEPOug (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 10:50:36 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:34374 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPOug (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 10:50:36 -0400
Received: by mail-it1-f172.google.com with SMTP id p18so8451687itm.1
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C+7jyZMzovW1eIY5U2RWEV1+yobNz3nf5wObRbXYfBQ=;
        b=sCVqj0G/zXImu+s8+hFIVoHCJ8+bRK+eLki/SsBmLHovNpGYVEn+eC75GrW8EC9dfb
         qgsBhbhBcu9NNDLpSlskKzaq/YTuZmZV0zPmPgJbaj09kJBPGjotlzPE/UIv8UqHfd5+
         3/KbA4s6X9ncZaf+hbzwrHi3uKT1dDsYLLBlFWc0xRGD0pDwsa2b5I/iUuWPXTZZ5Je2
         L14QFkjRsf8eYhfwrAQaWvy3SD36HN721C6egy2fP9V2IRfdwKv9FMc8micw7YxyXDbG
         eq3ZS18tltf4DWILMH+0hlFbQXZ4go0HkLxi+Pxr/X8ZqnoNOj3asiT4MEgZpr3Nnge4
         +Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+7jyZMzovW1eIY5U2RWEV1+yobNz3nf5wObRbXYfBQ=;
        b=M6qB1JkpAsWMqLzTbUTpaAT6lrA017rpz6gjs/xt4SUv9c+fjqMS152Ri9S5GVJNVR
         Q4IEi7TYzoglO6/qUgZnMzV8VyLt+6pO3y7uKhiqZUBSXNp2zEt6CSGCr468UWxHOUVs
         M0xdGQsf0LzcjRtkGxw7hWBBQVr/tU2i2BSw5tZW+XLiN0gLCErM0OtDPRYvNEX8tZCk
         RDZwfhFZ4AFqMRVNPaZni3SohkuC2UXGlChUJr0XUoHBzuC47ULQgMv2+TghdO/jMAE4
         y2plKdjNlPowGg9w6SOw1dSDKlksplhOUNjVpSmNRoz10BymTcDXr8HJD0oxpXBx8zNZ
         Bt6w==
X-Gm-Message-State: APjAAAVTfj0dpCgzTdTV82+bkwYKpaSDSjzL+R5rHPI7yv/jI4ec1m87
        p7XM8F1i0m/9iB0PBY4keSvxqEQ/HJ/M9g==
X-Google-Smtp-Source: APXvYqyPqCls7nEwpdQo4IAQY12DAptGaGdS9pcjatzas5XLse7bPWZ2jJalyga1Fy6MsSprKU41VA==
X-Received: by 2002:a24:5302:: with SMTP id n2mr12831691itb.27.1558018234859;
        Thu, 16 May 2019 07:50:34 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p129sm1536450itg.14.2019.05.16.07.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 07:50:34 -0700 (PDT)
Subject: Re: replace sq_mask with ring_mask
To:     JackieLiu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <820102D0-D768-4E39-A9FE-FB75A53FEE8F@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eea42825-8186-ab15-3bcc-4b05cbe33409@kernel.dk>
Date:   Thu, 16 May 2019 08:50:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <820102D0-D768-4E39-A9FE-FB75A53FEE8F@kylinos.cn>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/19 12:47 AM, JackieLiu wrote:
> Hello Jens Axboe
> 
> Could we replace ctx->sq_mask/ctx->cq_mask with cq_ring->ring_mask
> /sq_ring->ring_mask ? because it¡¯s a constant and never change in 
> io_uring.c
> 
> I found that ctx->sq_mask just used on 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/io_uring.c?h=v5.1#n1831
> 
> and we can replace like follow:
> 
> - head = READ_ONCE(ring->array[head & ctx->sq_mask]);
> + head = READ_ONCE(ring->array[head & ring->ring_mask]);
> 
> If I understand incorrectly, please point out.

We could, but we cache it in the kernel since the ring value could
potentially be modified by the application.

-- 
Jens Axboe

