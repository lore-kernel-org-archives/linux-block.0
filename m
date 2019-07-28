Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA2C7618B
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5009C2077C
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKWaGVcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfG1GMU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:12:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32838 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfG1GMU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 02:12:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so26412192pfq.0
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9rzasymMKdCTOZTciD4Xp1bEILoA3/1aaTSmsToYcw=;
        b=nKWaGVcpvti10rb4UtBz6/fZ5o3oq+cggGh2tkSQwf5WeSygGUNm6aaVChifpTdyAC
         6cVIOQRJ23usWCADSLmB3ri91FdTSi7kkkI2wpDwU65CL07VTMHQmIxNvZQSrX5i836+
         eqGbvPK9xoe15+IBTWqOUF7Od7LrlPx39AXQ3zAp068K8s5AbQuxIZwiiTvz4mnbA1In
         JvXS2te62Qy/oJzvsnrPejyg3wchkL4ABSbMlOKU+k0QdrqoYjg51zAjKWjLoL7VHPdm
         PV9o0tS0qsN3y3s93lgOvqQmbim4cgcDHlY8jLRKAXjk6kAYy/yzacS+ifssXYoAjI9N
         LDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9rzasymMKdCTOZTciD4Xp1bEILoA3/1aaTSmsToYcw=;
        b=E5KxQttJ344M3Tyq9yPbA2qgOro/7pMQhoPgOHQGVQfY2HfU4VKn5TgGFI0hPObTZV
         E1nTFYo4IOm9g+j8pIYVtei0Nxs2XNh1ngPjoZxxEA4+DGTB8Cdbno2xz2c7PmFxItE8
         lyoizwRT8HAbGoujAYTtGTJvVTm5zk6/QzHpTANsqJsdpcHXAVHM9hRnLsXwBNbDBFVr
         FXshOcoaNHBeWJdLmWg2BuVuXvMGo2tDcKl5VAg5EM2CTnuwjSqwdYbytNzq3O0+7CPn
         Huoq4zOyOiDtswXb/7r+X8keXiCJnXsmfBdFbHaSeP40QrrDVVpcNeK/Mn70sZR5Q7RT
         jTkw==
X-Gm-Message-State: APjAAAWywqBbEcDg6Dyo3m1RNXkEFvmbF0lTVhatO5KN1n6oVSAz7gic
        55VEbPYgDM8TOYZUgGcZ9vjQNBKjQek=
X-Google-Smtp-Source: APXvYqyckDt2jkEgeoc7mjOi7MEPWpIcNX3tFn3jo3BYQUHgiqlKc5ssuI54hATMIyXxOTrQCR2RrA==
X-Received: by 2002:aa7:8752:: with SMTP id g18mr29245264pfo.201.1564294339935;
        Sat, 27 Jul 2019 23:12:19 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id h129sm54249615pfb.110.2019.07.27.23.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 23:12:19 -0700 (PDT)
Date:   Sun, 28 Jul 2019 15:12:17 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 5/8] null_blk: code cleaup
Message-ID: <20190728061217.GG24390@minwoo-desktop>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
 <20190711175328.16430-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711175328.16430-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-11 10:53:25, Chaitanya Kulkarni wrote:
> In the null_blk for different page and sector calculation we have
> simple macros to make the code more redable.
                                      ^^^^^^^
Maybe someone can take care of this in any step :) s/redable/readable/
