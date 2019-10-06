Return-Path: <SRS0=GTOX=X7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A2C4360C
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A43B20862
	for <linux-block@archiver.kernel.org>; Sun,  6 Oct 2019 15:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oiPn/7Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfJFPZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:25:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46351 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJFPZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Oct 2019 11:25:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so6979804pfg.13
        for <linux-block@vger.kernel.org>; Sun, 06 Oct 2019 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=maJ2FXUCg8vNkIizMO50NGsfFdPFdqKAiECAgvNp/ME=;
        b=oiPn/7YcBsRQyH1m/o+ETLvChQAdxdByZa6uPg9dghglLTKuk8iK7E7dz/0cBdYP/h
         o6u/FKXk4IRukpUP8piLKMTp7Y3+PNIGBTAV/KkdOoI5u3G/tHnd7QbzpqAhiI3+stwv
         j0ZPgkax6D6arn/xL57cMLwrXMYcVLw3w/2lj/PV3YOoHp2AwIl3KGmVjDsFgVdYuetS
         kDIvfW55rsfcpG0a+W9ZVpAdNU0RtmSWlldZrKsl5kB7PVej5y86fzOp24YQ7wkSrWet
         10Ei4/QMnJp5GM33T02Sr2W9eZIurqgR40JSukllX0Xz2GLZlk0MPZEVyWDwGIiruF7P
         x8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=maJ2FXUCg8vNkIizMO50NGsfFdPFdqKAiECAgvNp/ME=;
        b=RwYfEJzPXo8Q1ejzCOaj8ucpY2EBBvTNWiwJF0mOZALoEe8tEOz5ICnKoPZXrZkvuu
         sPFf07oW5glaWDjQK8s6c60Y23vmpDtH97q5fRMJcT92sH019PM2DtrsFq+f6iJg3tLG
         y60gM+i92/qo1lxNFMQ01NNKONWmLRsORllVYEI3zx6jlk2NKrQ/9sPCL6WPaumR/dh/
         GcKEu2BcR9C9u1V5fKqk3lE1RU7lJ0gVrRMDK6nmW+5V1FF0QOVV9NfiNaEWSgyXB6Jc
         S6ROU7ZNpbVvBtmym+PM2OSey6iW60bJIeQQWhpQ+zlBHv16gBD8zzzb1ztZqFGNnvK8
         FIJA==
X-Gm-Message-State: APjAAAV9hLPUshodpfbx7ZQ8tnP2E9ZV1tnzW97ls0Ld1Aua4C7KZSqa
        mrJuizoTqIM7JUDjttdZX1ykQg==
X-Google-Smtp-Source: APXvYqzHazVz0k/u0XRHI2W+hvULlIv9e2Zz2FJVED4yPo2Hl4hn6DDIvvhQvzVC67GiZzIv9OiTNA==
X-Received: by 2002:a17:90a:ae0d:: with SMTP id t13mr28703621pjq.60.1570375513877;
        Sun, 06 Oct 2019 08:25:13 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id d6sm14536552pgj.22.2019.10.06.08.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 08:25:13 -0700 (PDT)
Subject: Re: [PATCH v2] blk-wbt: fix performance regression in wbt
 scale_up/scale_down
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, vaibhavrustagi@google.com,
        Josef Bacik <jbacik@fb.com>
References: <20191005185927.91209-1-harshadshirwadkar@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <946f4a47-c4ad-0b2e-4a5b-d0873cbcb510@kernel.dk>
Date:   Sun, 6 Oct 2019 09:25:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191005185927.91209-1-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/19 12:59 PM, Harshad Shirwadkar wrote:
> scale_up wakes up waiters after scaling up. But after scaling max, it
> should not wake up more waiters as waiters will not have anything to
> do. This patch fixes this by making scale_up (and also scale_down)
> return when threshold is reached.
> 
> This bug causes increased fdatasync latency when fdatasync and dd
> conv=sync are performed in parallel on 4.19 compared to 4.14. This
> bug was introduced during refactoring of blk-wbt code.

Nice catch, thanks, applied.

-- 
Jens Axboe

