Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiDLX3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiDLX2Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 19:28:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1D85979
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 15:32:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h5so17573873pgc.7
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=UTSp/G8zwV18QcS++FuQzWULt0VtGmmOqsMfzG5ErkA=;
        b=2u8RZR5Z/ycl0/rlZlTpBfbAQMR7bXJ9y/kQiA4x/saJN2+hoVZnRddqJRcYY7lb2v
         Bjodb+LUw3QTYFHpteR0dVcP6+jjnQlsCS2yVTUPgAvAxhQH75k3PFMoYpY6TcXVJXKy
         JudGJnkgu6CrhOQLuBs8YxpJVIjKnGliYLhm3kWUrWEIfz+27mq+rL0MLrS8sbQXWZrI
         TM3hM45jKo3JLLTbPZWOzw4mttlmyYdOIXO71hIow4aJYgK5BDO+uhK9qlDEA1o4UzPc
         MC44eMEGnQEArcYYjgJJcZcNJr56zFC6KsUykNSU1QOvOTGRE6FBdf8bZjZO/OGZ7EQ4
         tqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=UTSp/G8zwV18QcS++FuQzWULt0VtGmmOqsMfzG5ErkA=;
        b=Du+nlOw5FWTnSHje5pq87K3oJ3p2TPP5u/K3+zUlmaoBCQ0hwcgWa5r588MGk8UbUH
         32ccUVZiLtix17V91Cv8t7TPtwJP2RhHo93EPz0VAhP7u3Sb3oSEAVzwPlghVMRw22YU
         fmQAmeKTH251bkTc3J6GYp/A+Qq5uq2FpCOCewNhjR1BnZpbiONBZ50pASFYV2Bwkj6q
         0+30akOpeLPI9dLv/MiOfdvWKwjOLVL6eDiTkT/oYr2n5Ew8WY0qocIXp55NcaeaBGTc
         MCO75bZUSwvdgHEqP79ro+r4V3UJJvEtnMjKqDq/PgE/OfuQkiYBQhf6q6xEoc78ZXAR
         GXgg==
X-Gm-Message-State: AOAM531UfAKvWn0yxRDMXaTjRBsMiPmCp2xUbcBPyOFKriZnTnHht+le
        cIEC9DUAZBAZfOg26DZyuLH2ZA==
X-Google-Smtp-Source: ABdhPJxfJJwMFnMw12ISX69ykkGJykL+olL9K1M/959vnjtHTUaLHqNf2JTnUA5fym5wfUqCsaxWhQ==
X-Received: by 2002:a65:6a07:0:b0:39d:8c35:426b with SMTP id m7-20020a656a07000000b0039d8c35426bmr5415538pgu.171.1649802720473;
        Tue, 12 Apr 2022 15:32:00 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001ca2f87d271sm535902pjp.15.2022.04.12.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:31:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     alobakin@pm.me, linux-crypto@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org, kch@nvidia.com,
        kbusch@kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, martin.petersen@oracle.com,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20220412215220.75677-1-alobakin@pm.me>
References: <20220412215220.75677-1-alobakin@pm.me>
Subject: Re: [PATCH RESEND] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
Message-Id: <164980271890.301666.4533609890818235558.b4-ty@kernel.dk>
Date:   Tue, 12 Apr 2022 16:31:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Apr 2022 21:59:16 +0000, Alexander Lobakin wrote:
> While testing the new macros for working with 48 bit containers,
> I faced a weird problem:
> 
> 32 + 16: 0x2ef6e8da 0x79e60000
> 48: 0xffffe8da + 0x79e60000
> 
> All the bits starting from the 32nd were getting 1d in 9/10 cases.
> The debug showed:
> 
> [...]

Applied, thanks!

[1/1] asm-generic: fix __get_unaligned_be48() on 32 bit platforms
      commit: b97687527be85a55e12804c98745c5619eadcc32

Best regards,
-- 
Jens Axboe


