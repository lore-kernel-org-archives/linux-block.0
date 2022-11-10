Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6FCC4332F
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKJSSd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKJSSc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:18:32 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A3BE79
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:18:30 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id o13so1411501ilc.7
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BNZGrC81NBokuvwdUqRX9ld2A3meBFvf97mv+wEVQU=;
        b=R73O9BPAJa8Qc4g4EyVu4EriaoEIXU5Y6iaDjIm5aVVYrRVunRkIDQKsTsCo5txPNl
         HwwN34aovgUu1XJbpivyX77gIYIstxK1aKcL+AXVB8oHVqeBY9HgRSbA7R/Ps/MExlsM
         Q15o+3VXk2KbGIALW+XK1/ZzS+em28y20HvYLUP2Fbr+luoHFmPC9xgy2jJXD1A+N/KF
         QOJXAyM/Kl9gyQlTx1wT3pVPs01VZ1RU9wUvo63duQFGTSW1amzx1YkMTluXm1fULGHy
         ha8AeKTitn7gK2460lPQwIV6gTL2F0JrYd0UNQI5iodajPwcHfDoXGDJNE4IloZ0nGK/
         WuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BNZGrC81NBokuvwdUqRX9ld2A3meBFvf97mv+wEVQU=;
        b=Q3YiL/vFZOUOj71IJ1iWNU5gOkMcZMBsRE/g2JzQU1sJ1VB8O57MiKk1G2Apa10631
         Os2kyUdYm3T+sc7LrudWQPb7osHKZ3bIajXlxaWvdHHKFGvRGamVLkuhhUdLv2DD5tYp
         SzShDvUKhkD93eDKkFoATqyTpwTVQuUZVhoJ1u5wmqNACTsr20F3gCNk/aHjvVV+225r
         htcBgInJHvPB6J5WFwVJW2MFxZ1gp+bz1XzTxJN7Lk6LAuWMPRbNu6rd+HJ0Z4gekJgp
         cgrTN77KUN7Ry3WAo5D4D12QsvYyw831fV0H95QSERtBpp4wbKRU9WYWHqhP387ZRZMR
         5oMg==
X-Gm-Message-State: ACrzQf00xEeZFNHjxEMsmI5jc6c6tvMUuqM3oHqQMxP2tXPlZWHdhzAb
        th+Ga9R/n6uPbvGJrgr0I1fM1HkgzgS2FQ==
X-Google-Smtp-Source: AMsMyM43krql/TwlEeUPRrW7yMARZ1/Sep0Z8OA6j1DmuJApCeTAaxR2nG0/Z5p9D1C1VeecvMAdpw==
X-Received: by 2002:a05:6e02:1a84:b0:2e8:6f4b:256e with SMTP id k4-20020a056e021a8400b002e86f4b256emr3146357ilv.284.1668104310089;
        Thu, 10 Nov 2022 10:18:30 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r12-20020a92ce8c000000b002fd00a8f8fcsm94363ilo.47.2022.11.10.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:18:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221109100811.2413423-1-hch@lst.de>
References: <20221109100811.2413423-1-hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: remove blk_mq_alloc_tag_set_tags
Message-Id: <166810430907.167817.8061756744774174707.b4-ty@kernel.dk>
Date:   Thu, 10 Nov 2022 11:18:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 9 Nov 2022 11:08:10 +0100, Christoph Hellwig wrote:
> There is no point in trying to share any code with the realloc case when
> all that is needed by the initial tagset allocation is a simple
> kcalloc_node.
> 
> 

Applied, thanks!

[1/2] blk-mq: remove blk_mq_alloc_tag_set_tags
      commit: 5ee20298ff25e883d0668507b3216992a2e9e6cd
[2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
      commit: ee9d55210c2fe40ab6600b8009de2243b2ad1a4a

Best regards,
-- 
Jens Axboe


