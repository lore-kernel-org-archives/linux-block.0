Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD8EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 16:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjFPQI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjFPQI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 12:08:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F3E2D5D
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 09:08:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77dcff76e35so4755239f.1
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686931705; x=1689523705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YfEH8qoqKE2ArVjSGCyI8u91V3DIju5xdxwJAakLmE=;
        b=YNP5kETLrm8T/RRnZdDcLyOkiDJYyJwp+cTeIfg89bpejVpm5crpLiTODsa/EZ0ezn
         6YXH317Iv6PZIxOKTERy616a808YLQdjGUUYZ1VlR2HTSBY9OkIgCM5MvasgUQIKA8oQ
         UgZq+eWLAnSJdy7Tl0KEAgf0KAd8AcjBcrvwU/Xz8SkNHsbyipJONhw5SEzQkyPzDW5n
         ihAQC53imOPIHBM1vZu5/7ZQPlEALgmTT0GtGbLzablAxMbtO1S+GvbHzbcQNRRpqy7X
         1wRlYfNqOx566BtD3Xg2LUXoftbybpIgMSO/RWyAG5MbyxJdFb5mbfZfYCfwduqTCMSU
         EZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931705; x=1689523705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YfEH8qoqKE2ArVjSGCyI8u91V3DIju5xdxwJAakLmE=;
        b=TVYpW+dGF4KaI9QexvTkAdydcPF2/8d0cSTo+9/q+Zy1kjvB6BPgt4V/AZD81HtLGl
         KxS1QjQmA6DNY8byjjkXnVTToTf1jhWWGFODMGfjMKD/QaqEsol52MhlKce03Xj99b1A
         nmWrW8GP9p4KuxMTwa4zDGIuV9Yoh2oaMBHNwxSI9OjQGRGS5+hlLHYmWjSPTYHaWKKQ
         QLomGb1dSFoHos0Av3413yImyWioxIbtp+XogBz45Yf/UkadccVgqwBlq2/HE4a999LT
         QiVuKFc2LbmYNZSVJsdgFo4Mn0pRGosw8A2eNQlnx449rv+lefwLEPHbDS2YXeXRWulJ
         NQLQ==
X-Gm-Message-State: AC+VfDyyoorDpF8ZerO1hRThIZkmRE291ApBeS32jgOQxdaCk3JqqMjL
        mKWLYNHjmINrxtsVA/R036TwDqoXOroV2fanwCk=
X-Google-Smtp-Source: ACHHUZ4cKsFlo8t58r1Lk9uE5JPxsZHPspWy3gYS2SrJmhQPp5WRVCbqt5753z2TzwDBlED4W3bJsw==
X-Received: by 2002:a05:6602:1a87:b0:774:9337:2d4c with SMTP id bn7-20020a0566021a8700b0077493372d4cmr2784811iob.1.1686931705526;
        Fri, 16 Jun 2023 09:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g6-20020a05663811c600b00420c29f7938sm3687115jas.100.2023.06.16.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 09:08:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20230614140341.521331-1-hch@lst.de>
References: <20230614140341.521331-1-hch@lst.de>
Subject: Re: dio / splice fixups
Message-Id: <168693170439.2452694.2683453223561840064.b4-ty@kernel.dk>
Date:   Fri, 16 Jun 2023 10:08:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 14 Jun 2023 16:03:37 +0200, Christoph Hellwig wrote:
> this series has a small fix and a bunch of cleanups on top of the
> splice and direct I/O rework in the block tree.
> 
> block/blk.h               |    2 --
>  fs/splice.c               |   15 +++++++--------
>  include/linux/bio.h       |    3 +--
>  include/linux/blk_types.h |    1 -
>  include/linux/uio.h       |    6 ------
>  lib/iov_iter.c            |   35 +++++++----------------------------
>  6 files changed, 15 insertions(+), 47 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] splice: don't call file_accessed in copy_splice_read
      commit: 0b24be4691c9e6ea13ca70050d42a9f9032fa788
[2/4] splice: simplify a conditional in copy_splice_read
      commit: 2e82f6c3bfd1acde2610dd9feb4f2b264c4ef742
[3/4] block: remove BIO_PAGE_REFFED
      commit: e4cc64657becbd073c3ecc9d5938a1fe0d59913f
[4/4] iov_iter: remove iov_iter_get_pages and iov_iter_get_pages_alloc
      commit: 84bd06c632c6d5279849f5f8ab47d9517d259422

Best regards,
-- 
Jens Axboe



