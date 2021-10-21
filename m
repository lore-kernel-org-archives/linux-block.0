Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD72C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A636121E
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhJUO3z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhJUO3t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:29:49 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D649C061224
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:27:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so622772ote.8
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=kOUVd58X8A7GFduPiV0YPszKBECOqfLgu3/qFd2sRSM=;
        b=kjkTYzVCWkqaCuBc5hr6bRwLAm85Rl22YQudLR/Zm/Q83kfTRSeCzm9Ns9n4/W2l07
         9VCKbUss4RlgR55P19R6vQZdIV6h4IO3NOTzMQ/A05TBH7YZg2AVJz1EoiAN8r2TL1NR
         5iBEHXGRp5qnA8BZXJWYv3zXiBikH9cQleoDbhjOTW/m2RuVPfMEUIbXgChTY/XvHNEO
         qo6U5OAIy/gfTsrP1m9JAkJ8hSuJpAMdB3w9+C/LJViXhGztSpNDSFY1zNkBOsR9fB0w
         1OdJJR/52EEPonYvPrYSy9HZ2H/QtfNeD/77KZCkgdWTYIfsEhElczz5yeSla60GxOLa
         F/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=kOUVd58X8A7GFduPiV0YPszKBECOqfLgu3/qFd2sRSM=;
        b=24ZIto6++JEAkpxh+q+bKQGw+Zl39jiPHYUiAhiTkhcKImZXf6Jnghql+SEKXEduzj
         kOAInfmty3nyURDF39N8JyhBaJJ9MxIz1Fh+wUo5Gs8GJOxsF2keL6hsACMYZktQm0UG
         m/jKdMTuXwNS6RKSUlLsKXOfbZpjivaPo1BsckE8TSDcw8hUIJDw3ONQlXuD1W1zA+n8
         +zht5upYf3ph9inw5WV18Gm0GFW1sw3nukutJ5RDW3FuGjUOLSAsme3b0nT5TN8uLuM8
         wRmpKhgWloW+sQtOGHbMYfr9fptvDp9OBFkfx7jHRclQL8FTXGXoQImcicK4DRmw+hxs
         QMuA==
X-Gm-Message-State: AOAM532O8cTqLuy7DWht+1xuo2VDSqNMrKg7SkFQeaW9cFRq/Zr7bixA
        lnJXGr/Ql2C/Wk7p5DStes/qvFD+kU8xLKC1
X-Google-Smtp-Source: ABdhPJzBPe/CzqH/r75UgvxCT9fENe62jlmb46ApaAGH7M9zf8wPgp8+AK5v8ZnusRoANRQdjpLrXA==
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr5134416otl.200.1634826451478;
        Thu, 21 Oct 2021 07:27:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id bf3sm1235026oib.34.2021.10.21.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:27:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1634755800.git.asml.silence@gmail.com>
References: <cover.1634755800.git.asml.silence@gmail.com>
Subject: Re: [PATCH 0/3] random simple block cleanups
Message-Id: <163482644970.39741.3982696274471379202.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:27:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Oct 2021 20:00:47 +0100, Pavel Begunkov wrote:
> Several simple cleanups/optimisations splitted out from
> the optimisation series.
> 
> Pavel Begunkov (3):
>   block: optimise boundary blkdev_read_iter's checks
>   block: clean up blk_mq_submit_bio() merging
>   block: convert fops.c magic constants to SHIFT_SECTOR
> 
> [...]

Applied, thanks!

[1/3] block: optimise boundary blkdev_read_iter's checks
      commit: 6450fe1f668f410fe2ab69c79a52a0929a4a8296
[2/3] block: clean up blk_mq_submit_bio() merging
      commit: 179ae84f7ef5225e03cd29cb9a75f6e90d2d7388
[3/3] block: convert fops.c magic constants to SHIFT_SECTOR
      commit: 6549a874fb65e7ad4885d066ec314191cc137b52

Best regards,
-- 
Jens Axboe


