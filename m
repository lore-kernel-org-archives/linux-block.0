Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A01C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 04:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKAEhh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 00:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKAEhg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 00:37:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537361054D
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 21:37:35 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l2so3994753qtq.11
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BURuUnZws+d426Nk/rZ14JQYHoSs9yu2RF2/NW8d2Mg=;
        b=ELzD9yr3HEn0sUpe2bo1MuNwBwXTxMIamLVo/UttI+zBocvtbmtG/k7ZyghqYu2X5I
         z77CPq2D8pprvsuii+eSCXtMf4U5NvQ5ZAF4A0fQ2eCxp88xc/7VU8lAUaW4GGQHsHCr
         RGJL1PuANq0VXvtYN1nkIn0UQ4YVusqGlT7jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BURuUnZws+d426Nk/rZ14JQYHoSs9yu2RF2/NW8d2Mg=;
        b=LeuE+9bAlemMt5ou+6MO32iT8wybE3TfmDEgi8bnDWPv89mX+sKkyzSIlFF+x/fUGS
         YUsOYG+FdsJNGncl/WlVWXAfuHtK+TVqiW68YP6J6Wd/tdvb6Z1hgMf7VcOindlvRYXR
         lmjRJOBN2DbFO/Myh4rGScJKp3tRJyiq5goj0pfGiR4paRGuHF6/fyDzQwE7+Q+sgIw9
         v9Nin9WP6RePHTS+8oEX4eDJ9E3d41rbD0Tjri1R904Fewo1T/+GKfsHDCRuQVhZDiPC
         ykfZ+Z7qBM4++BjaVh5CjV36Uwi68ozPWlkdKUMPvnK+UffZYsc/XVGPUT9gxVnPJuOO
         niBg==
X-Gm-Message-State: ACrzQf15sADKgXLF3s6D4DB17cGEgIm+DAM8jaCvsOZCi1XjGV04Opha
        WAvkJGzVYANShbIWFyikJvjYTWUz6dE9Ig==
X-Google-Smtp-Source: AMsMyM5/biWhxqzKIJyackreiBpGidNoze0fCQSTfnfzf16oOA3ycGW41WiYv9J3sHKfbCDFstNU3w==
X-Received: by 2002:ac8:5fc8:0:b0:398:db76:62ef with SMTP id k8-20020ac85fc8000000b00398db7662efmr53159qta.116.1667277454277;
        Mon, 31 Oct 2022 21:37:34 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id bn5-20020a05620a2ac500b006bb78d095c5sm4977092qkb.79.2022.10.31.21.37.33
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 21:37:33 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id k4so6014978qkj.8
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 21:37:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:6ee:d68b:5b26 with SMTP id
 v9-20020a05620a440900b006eed68b5b26mr11902150qkp.47.1667277452789; Mon, 31
 Oct 2022 21:37:32 -0700 (PDT)
MIME-Version: 1.0
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 31 Oct 2022 21:37:20 -0700
X-Gmail-Original-Message-ID: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
Message-ID: <CACGdZYJ0_8t1JV2CqW-5B92n2YFNkf6jzi7oVkpsBfNmBGd_VA@mail.gmail.com>
Subject: Why don't we always grab bfqd->lock for bio_bfqq?
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm investigating a NULL deref crash in bfq_add_bfqq_busy(), wherein
bfqq->woken_list_node is hashed, but bfqq->waker_bfqq is NULL - which
seems inconsistent per my reading of the code.

Wherein I see bfq_allow_bio_merge() both accesses and modifies
accesses bfqd->bio_bfqq without bfqd->lock, which strikes me as odd.
The call there though to bfq_setup_cooperator and bfq_merge_bfqqs()
seem wrong to me. In particular, the call to bfq_merge_bfqqs() I am
suspecting can cause the inconsistency seen above, since it's the only
place I've found that modifies bfqq->waker_bfqq without bfqd->lock.

But I'm curious in general - what's special about bio_bfqq? Should we
grab bfqd->lock when touching it? e.g. bfq_request_merge() also
accesses bio_bfqq without grabbing the lock, where-in we traverse
bfqq->sort_list - that strikes me as odd as well, but I'm not fully
familiar with the locking conventions here. But it feels like,
especially since we can merge bfqqs, so bio_bfqq is shared - this
lockless access seems wrong.
