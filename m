Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33125C00528
	for <linux-block@archiver.kernel.org>; Sat,  5 Aug 2023 22:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHEWNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Aug 2023 18:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHEWNj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Aug 2023 18:13:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC0E78
        for <linux-block@vger.kernel.org>; Sat,  5 Aug 2023 15:13:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc4dc65aa7so3191115ad.0
        for <linux-block@vger.kernel.org>; Sat, 05 Aug 2023 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691273616; x=1691878416;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfoCc+RvjV+g+GLE3LFiITYI1ax4E6KyrUn9GtTQWKU=;
        b=Y2h94PojIusanzrjPBql/8LV2CORjY1s6biXpvYlWwZA1L/KDwvg8dvBt37DG0mzpN
         B7dt7VojBlYTaPOWjlaP5esyiMkVGFyQucBOPNHcvfI5nN80tbVha52gvGMx6PAuPB0v
         I3ysUBajJcS2F0UybgEkEiBJjjMbxn/id96mFIOfl5hJoI7YRXvhcLxucQMIm0/wWZ4U
         62tdfCNAIwzXEP8CaXC1q6uZg7CyC9VldzoAzQ5L2RoFlI9z8xHcM33mXz2xZvpT/pLI
         bMh/CR95r3UXAc39JwJxAjYlje52Q/t6RStTV8BsBBOms0Pux+zE5OS5TEZW6fN55YhK
         +zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691273616; x=1691878416;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfoCc+RvjV+g+GLE3LFiITYI1ax4E6KyrUn9GtTQWKU=;
        b=MHJp9d096LI/laoceKEmCr9Wi8A8bcEUXDFYrUISDbRd4SQ4J8CwWTcO+gWavmIidb
         7PDtVyP9Ou0CKFAFGOvbJrUoHlDESiYR5gcxuiGh2Iri0s5wN4APnbME57X17mt+ixe4
         OUtn3jj21B5RGRt4Fxxru2RQetGB6gL7tT60FlHAKldMNQ/yAbLYjGIILRC63dBqXo4r
         8JdtVNFhtYNuBoqODPx3HGEBDSz6qIorjo2NDn/ALzkIjc429T7FfE/HYubD4sxA3y4C
         GFm0a3fDirK97DhGdm5SjRtiR0bdSU/lCgGtNB7X/yKRs6ehM+eOn+LT7M1nLpyP2ZD/
         /2dw==
X-Gm-Message-State: ABy/qLYn2EPZ3z1oV+PySz44UFh5K2KclWvTzQj7DlDwJwgNQceX4Aoj
        OLKRb5JGyFr8ln74i98vL6e8lurtNLyfHniaiBY=
X-Google-Smtp-Source: APBJJlEv8pHOH7HWV+MOVitX5Kxcf06soD19PKjn8qyNH4ESUwUgXVaV/O/MtzWWKBI09ZRESJ80Tg==
X-Received: by 2002:a17:902:d2d1:b0:1b8:ac61:ffcd with SMTP id n17-20020a170902d2d100b001b8ac61ffcdmr28867244plc.3.1691273616618;
        Sat, 05 Aug 2023 15:13:36 -0700 (PDT)
Received: from [127.0.0.1] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001bba1188c8esm3929244plj.271.2023.08.05.15.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 15:13:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     minchan@kernel.org, senozhatsky@chromium.org,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <20230805055537.147835-1-hch@lst.de>
References: <20230805055537.147835-1-hch@lst.de>
Subject: Re: [PATCH] zram: take device and not only bvec offset into
 account
Message-Id: <169127361527.13732.4190461845439151626.b4-ty@kernel.dk>
Date:   Sat, 05 Aug 2023 16:13:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 05 Aug 2023 07:55:37 +0200, Christoph Hellwig wrote:
> Commit af8b04c63708 ("zram: simplify bvec iteration in
> __zram_make_request") changed the bio iteration in zram to rely on the
> implicit capping to page boundaries in bio_for_each_segment.  But it
> failed to care for the fact zram not only care about the page alignment
> of the bio payload, but also the page alignment into the device.  For
> buffered I/O and swap those are the same, but for direct I/O or kernel
> internal I/O like XFS log buffer writes they can differ.
> 
> [...]

Applied, thanks!

[1/1] zram: take device and not only bvec offset into account
      commit: 95848dcb9d676738411a8ff70a9704039f1b3982

Best regards,
-- 
Jens Axboe



