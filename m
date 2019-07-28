Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BCC7618B
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2416E2077C
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQJwqMJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfG1GS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:18:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45925 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG1GS7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 02:18:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so26634768pgp.12
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 23:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTn3IzVfajSRm2e1CgAXIprxHZguLONTTITdDOVWM/Y=;
        b=VQJwqMJVWA7Xf3d0nii6ke8ZwKxRzDEnUNfiUenrAyDGRPHkaDJ76twpWkvVeT+yHH
         4QTFsD2kJriK3YrpVpssn451r6FCDXNIb7ThSx2MZPpaOjxER2IDhe4DvmfhC57fNywl
         SBc9G1DydvqbdNj3Q2DKmge/Zj+GUwVAPq6CWQymTaSxmqn5MVf10w0A6+2hsNGaxb2Y
         puueDc5rZtntn/ModXEEZ1H/zVEyLselrNvfuNgRZjCUAFsMfclkBk3CxKdvw9YlkkgD
         rMvB4yaztjkwW3AMEZWoz/qryTq6brdFOeKF4Y8C3e9ZV1tVcSO9X0v68jiN+Eg2Szom
         Aw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTn3IzVfajSRm2e1CgAXIprxHZguLONTTITdDOVWM/Y=;
        b=P6cRxxoMwkCp25xkkx01Crae9H1X3Dt5DjBjWMSf82/GhEQF2/TEECs3oUMg77Hygs
         3OeWAPzOW2ImiXOftnr0eMqfJLrvtXzAEN60F45aYrg3p/pLf3FmWtd0Dw840hzTdTSR
         Sza0zK+mLQvAGzblUYApWmM3IXsj3R6ovW5KGMuyJ+HvHNXJuqySTN2Zd8ApZLBb+iAG
         mEQkW1DDUVmw8x+c/BGeXyCOeiiqqoZpghCjfI1Ujn798TcuXH62VotsBtNFBpeJBhfI
         vrYrwCkGxXtztnmavpvtfMVFvyspBcFVN4QXX3MWBG5ZUC1M89Bivn912Pu499i/qrm5
         D7TA==
X-Gm-Message-State: APjAAAXsCY3yXJQ2jSTtN+3ykuYf58VFs17kY5p1V9jhkGBx0MZHWqN/
        B4r5Pc18+jfeN/Ki+0SMF18=
X-Google-Smtp-Source: APXvYqxcXY1G/Us9ZGbGBDDiXs8lYTENAAP3IUAq4MepPRPcQV9o2eJyLhK0JFda+aXPQWrrLP1bkw==
X-Received: by 2002:aa7:9254:: with SMTP id 20mr31393242pfp.212.1564294738712;
        Sat, 27 Jul 2019 23:18:58 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id c98sm56113170pje.1.2019.07.27.23.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 23:18:57 -0700 (PDT)
Date:   Sun, 28 Jul 2019 15:18:55 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 6/8] null_blk: allow memory-backed write-zeroes-bio
Message-ID: <20190728061855.GI24390@minwoo-desktop>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
 <20190711175328.16430-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711175328.16430-7-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-11 10:53:26, Chaitanya Kulkarni wrote:
> This patch adds support for memory backed REQ_OP_WRITE_ZEROES
> operations for the null_blk bio mode.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Hi Chaitanya,

This patch looks like good to me merged with 4th patch which is about
the null_handle_rq().  I think it would be great if a commit covers the
actual callers for those introduced.  But code looks good to me :)

Thanks!
