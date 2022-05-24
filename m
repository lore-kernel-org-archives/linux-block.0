Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594CCC433FE
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 12:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiEXMUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiEXMT5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 08:19:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85A9347A
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 05:19:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y1so266968pfr.6
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=9IGHMIIKL88803hPgdSaXWlPilBJOtrDzZze0Yj8RM8=;
        b=xxwql3dVTB8lLlnXy/l+k1i87oKtRlHCr9pCN27Aj4Wm/49QP785GAMydx62OG5hAl
         yX63M6GgPNiRLySCTQn0n+seMB0KjAkJmzecq1y4PK5hQFnK2Lp9bromahMi61M2+nYQ
         6vRQ1HpsTTSPBhGi3zv3AWO7s1E3lB7GNd3ExDpoceCa6VvlBg3p9waMPxqoojBi/YV9
         OOXFnNplZoahr9mTt4MQZCvcomO6fQZMNQZLWHqBI4ZEwrPj7RF9U6CX0G199QXNpMbQ
         SCJmlMK4Ma7W2/yuiRSlCD2adkSguhpPB76p98YkVTjIROA1Na2opn3hv9XIio4nTmSa
         Pa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=9IGHMIIKL88803hPgdSaXWlPilBJOtrDzZze0Yj8RM8=;
        b=nPOhX1aAUpozYT4YejPZGk9Ai297iq0DWfIXH8jDJVdXVGwdhOc8E8kTT1c1t3FNW8
         49nQ+K+sJvLrbuYcahc0ZTT9+/oqmS2M9ut8QZ9xrsGLu0KjN3ufPlZ98LbVvOwOmoWs
         EzvdPTEr1KsRYigRPJxdBci5RjDJJ43SIwanNkQDArntx30/VrdUJxbxOZBZG32WZDf7
         caPNlbf22rP8AUvdE4rRHqSvo6lbjpISOqVdfgMR5a7yK9wFcJGHGTFZt1Ntf2u5y9+h
         TgMIMyIdMzV4KmkmSTDhWAa1X+6Uca8BE7SGuERSXkBPfkdw31mVwf0dzKeAzuLHdFfQ
         qD/g==
X-Gm-Message-State: AOAM531peflZGKqC6ylF9YAsg8D8bcsOr5zGtmLbrykTs5/hpbSN+elg
        g+0VBkdpFC89iUcaMfdpXKg30g==
X-Google-Smtp-Source: ABdhPJy0bamjH4IRdcw6z651AuNl4FrLJa4uYywdFKK+/6mPd/plJmVwQKZ2kvKH++ycuoJsSIKrnw==
X-Received: by 2002:a63:583:0:b0:3f2:3f20:ec1a with SMTP id 125-20020a630583000000b003f23f20ec1amr23927751pgf.460.1653394795180;
        Tue, 24 May 2022 05:19:55 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v17-20020a62c311000000b005087c23ad8dsm9369824pfg.0.2022.05.24.05.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 05:19:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     colyli@suse.de
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220524102336.10684-1-colyli@suse.de>
References: <20220524102336.10684-1-colyli@suse.de>
Subject: Re: [Resend PATCH v2 0/4] bcache fixes for Linux v5.19 (1st wave)
Message-Id: <165339479414.6179.11008749918880416100.b4-ty@kernel.dk>
Date:   Tue, 24 May 2022 06:19:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 24 May 2022 18:23:32 +0800, Coly Li wrote:
> Thank you for taking the late arrived series, they are all for bcache
> fixes when I work on the bcache journal no-space deadlock issue. It
> spent me quite long time to fix because other issues interfered my debug
> and analysis. When all the depending issues were fixed and my fix for
> the journal no-space deadlock is verified, this submission is late for
> Linux v5.19 submission. But it is still worthy to take them into v5.19
> because real issues are fixed by this series.
> 
> [...]

Applied, thanks!

[1/4] bcache: improve multithreaded bch_btree_check()
      commit: 622536443b6731ec82c563aae7807165adbe9178
[2/4] bcache: improve multithreaded bch_sectors_dirty_init()
      commit: 4dc34ae1b45fe26e772a44379f936c72623dd407
[3/4] bcache: remove incremental dirty sector counting for bch_sectors_dirty_init()
      commit: 80db4e4707e78cb22287da7d058d7274bd4cb370
[4/4] bcache: avoid journal no-space deadlock by reserving 1 journal bucket
      commit: 32feee36c30ea06e38ccb8ae6e5c44c6eec790a6

Best regards,
-- 
Jens Axboe


