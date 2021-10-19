Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74746C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5193C60F46
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJSV0s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSV0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691EC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so5627554wmd.5
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fwt3VnD7b2iQRXhQl+ZZ2phaNDSJmd3pBlclkLV7DY0=;
        b=RafsNk5A39Rz2tBAaw1Flhj95ofaZTC3a0dCllEywRep6ka/ApSDQYrC+vnHhi2lfW
         2v97LszBWt3J/bMBjcMZCUHeY5H+aKYlE3EwPp+db/OlFBUKwxotCPl3hWf/4bsD47lz
         TYF4t5LxADFeRnj0J7ctp7J5xZGDh7+Bxu+vdeYo5+d87UiLoG/vO1nXCHiSR3wpJ0Ry
         00AnpUK/Lu8oTuG3riZf5bzFmwHPDZj+383yCU8ankIpEPYMNIUjNAPEhK3ajK3ekM+H
         IkDZQY39zC2Qw+vBTeQXnFL+ypLbH3vVO3jVZ6ZOslO1Twe5ECCgarABQxwKsEATYe0m
         QUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fwt3VnD7b2iQRXhQl+ZZ2phaNDSJmd3pBlclkLV7DY0=;
        b=qCDKTtMPAPvEyg5apQR7GsHJ10OmQGPPxVULuFx/OubpkkocWJ2qbIcPZvd7DAh/sT
         tIREvCX3sSbkWTaHj4nGhxHuWtqj+1rqBAQYO42Z65CHlGsWfFHRu/BES+GQtAXeViUM
         bNjEGtsgtaihsGyx5CCFbJ0wQOsgtnJAuK0eq3A6ExOGy+abQH6ZO079RAA7Xfl5B8u2
         7JLubwjj41XS7iktIxHHmGE0SloCd/vDkHX7vaz0piy1K5ZfiZFqKTgRV3yb08nvCIzU
         0kJ5ZHKhTUwZgUxxFqMQc8VFpeTBP4GIz5bDpppnSVP2e3HUSH7TwPtwiBTQLscLMh9y
         ZkGA==
X-Gm-Message-State: AOAM531I0Rw2jRzi2awoWjEMBPkima9fAGvTCYjUuq5pYmhp5DFjxxH+
        IVTfdkkoHeVrcesPOF6UFFDhf13X9Hoi7Q==
X-Google-Smtp-Source: ABdhPJxKNtHoF08jOpC+c//l/h5vOWIbvUtfoEZI0/nSRtfE3HrE16xRczJSzOk71CuxZljc6MpY6Q==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr8688197wmp.73.1634678672824;
        Tue, 19 Oct 2021 14:24:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:32 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 00/16] block optimisation round
Date:   Tue, 19 Oct 2021 22:24:09 +0100
Message-Id: <cover.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens tried out a similar series with some not yet sent additions:
8.2-8.3 MIOPS -> ~9 MIOPS, or 8-10%.

12/16 is bulky, but it nicely drives the numbers. Moreover, with
it we can rid of some not used anymore optimisations in
__blkdev_direct_IO() because it awlays serve multiple bios.
E.g. no need in conditional referencing with DIO_MULTI_BIO,
and _probably_ can be converted to chained bio.

Pavel Begunkov (16):
  block: turn macro helpers into inline functions
  block: convert leftovers to bdev_get_queue
  block: optimise req_bio_endio()
  block: don't bloat enter_queue with percpu_ref
  block: inline a part of bio_release_pages()
  block: clean up blk_mq_submit_bio() merging
  blocK: move plug flush functions to blk-mq.c
  block: optimise blk_flush_plug_list
  block: optimise boundary blkdev_read_iter's checks
  block: optimise blkdev_bio_end_io()
  block: add optimised version bio_set_dev()
  block: add single bio async direct IO helper
  block: add async version of bio_set_polled
  block: skip advance when async and not needed
  block: optimise blk_may_split for normal rw
  block: optimise submit_bio_checks for normal rw

 block/bio.c            |  20 +++----
 block/blk-core.c       | 105 ++++++++++++++--------------------
 block/blk-merge.c      |   2 +-
 block/blk-mq-sched.c   |   2 +-
 block/blk-mq-sched.h   |  12 +---
 block/blk-mq.c         |  64 ++++++++++++++-------
 block/blk-mq.h         |   1 -
 block/blk.h            |  20 ++++---
 block/fops.c           | 125 ++++++++++++++++++++++++++++++++++-------
 include/linux/bio.h    |  60 ++++++++++++++------
 include/linux/blk-mq.h |   2 -
 11 files changed, 259 insertions(+), 154 deletions(-)

-- 
2.33.1

