Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7586EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C15661212
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhJTTDR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhJTTDN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 15:03:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00CC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:00:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g39so16520768wmp.3
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkHR5tnSmFS8v9UaEJKNF1V4DmYKxDB/n+XexR2baqA=;
        b=e7FXgItEgqey1DKi5+SsUDbR7knx8oiBZo+UcjlEfgVXS8p9YheOQ3+L3+GQJo8jGr
         BQKNIU0xNUVv5989Wi0vccazmR7s8TbqL8sDZ70gOpX3IucH4/i2MBmpwdOuyHbqg10Z
         5/0yleCqeBdGmosU7gfhaNfkc0AfaV8YChGIunH2bBA19aIWQ3jaEPuo/cMD+d6JyoGX
         YtR/ojVr6TqbKgq2fq/CevRIQmR/5J4qCaYj2U3cB77nLmR2uOCkRTlc4Zf89Jz9M6Sh
         0TQ3WsyOOWF1T4ZvJfrROsK0hW5fvFAv77KUI3qzfmSnqQzrALRlfC56FZLJzdWE1B9U
         VRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkHR5tnSmFS8v9UaEJKNF1V4DmYKxDB/n+XexR2baqA=;
        b=b3vXQGEnNPQBQEIk+JkXyBqk8O8JHrcOhx7QE1zT7CVY5aTUxuyfRpC1POpdIRCQ8/
         b+Bd0tqQkvqUHToLthnx1hDax6nb3bardro9AA6zrp1RHT35HyPkcDmdY+YkYLliONzR
         q8/s5IcCwbqbAE+IACFf2d2kuz3oFQv5O7UrtygZ0qs5OpnNP8lzibDvX00fQbLWvIyW
         Rc0VqJt1KRgB17HxTCYW/+h/QJ0cBpCvieY2fhGaJL5ioYZE3yTVLPa6N29uSnJM9g/h
         PM9jod9k7hN4072JjcX+9HO13G2MJX426M6Sl5O+KNbl42OXGjZe3uCUh3mconzMVbbo
         y3HQ==
X-Gm-Message-State: AOAM531vnj5lDDAcVpXI860goEwhXCpm1TQEmYaVdTAaIR5CFHvMlXHp
        vi+sEuooYLeGhExF0F1BRpXI5490HeHWZg==
X-Google-Smtp-Source: ABdhPJylBGiH+hoz+fL3m4C7nSN9dw5JGZP0UmioE+q3oPkC2bBuptwHL88RRus8jYbyTTbe2UYXIQ==
X-Received: by 2002:a05:600c:a42:: with SMTP id c2mr15613463wmq.154.1634756457065;
        Wed, 20 Oct 2021 12:00:57 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id j11sm2743880wmi.24.2021.10.20.12.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 12:00:56 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/3] random simple block cleanups
Date:   Wed, 20 Oct 2021 20:00:47 +0100
Message-Id: <cover.1634755800.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Several simple cleanups/optimisations splitted out from
the optimisation series.

Pavel Begunkov (3):
  block: optimise boundary blkdev_read_iter's checks
  block: clean up blk_mq_submit_bio() merging
  block: convert fops.c magic constants to SHIFT_SECTOR

 block/blk-mq-sched.c |  2 +-
 block/blk-mq-sched.h | 12 +-----------
 block/blk-mq.c       | 15 +++++++--------
 block/fops.c         | 37 +++++++++++++++++++++----------------
 4 files changed, 30 insertions(+), 36 deletions(-)

-- 
2.33.1

