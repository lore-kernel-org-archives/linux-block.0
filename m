Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81676137B
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhJTUFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTUFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 16:05:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03863C06161C;
        Wed, 20 Oct 2021 13:03:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i12so71040wrb.7;
        Wed, 20 Oct 2021 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJs761PIZHA/yQrkxYR0H2JI0nZrSlRKQ+QXU0IoUbA=;
        b=E5lEyRk0SI0GaN1hNyuOKFhy90A37dGMRYW9dJGiPzvYhS3VJFVFKUSv4mS0bU14tW
         1qQpAEhOh2noHu8C0vDRCApJJCPsvI4xF86GD/8FYsK8DgL0YxXp7QCuJoswxcTaFZjA
         OcQGruxyCuSZZxtwcIX4ezT1hf1XRqqShRQPxP+9PvMQtctoLAe/YA1KIYfw18xC3eqI
         W1IOCTf5K8NmHAS+Csl7bG0EQYADDVbv+eef8IpmvLByw3kQruusrIvABcjhqe+Ri9gO
         NPknaHxOPG4zKvyuoLeXMUy2/L4KmYDpXsnI54yG76DTx3kj3zO9mCVkm+vw2BmPP3NY
         u4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJs761PIZHA/yQrkxYR0H2JI0nZrSlRKQ+QXU0IoUbA=;
        b=Z+EtHjaKfmjPsHPDH8zdjHxz82vrQ9RJ29FroBzPSQQdcgUikryp6SQzJMV4DQnRzk
         7xtRCfWNN0zPfwceUzrnleS8G/PF2AGZkMtUkGPirnUobHpR5FhBlhPLN46E4fu56oOU
         PI9hY3qanZo9xa7dnI4BrFYcHn5rjsFHkbsI0MK/TPmzFeVmy81kUnfXW4hWg4slwX8X
         dDnmX8nlAthtePTBUcYKqmiSCMdMGwt6DTp+y+EKdwESKouhpRqkjoQtgbJaGDRUR4NG
         6LstJicI+j8wRjc0QBaoA5BQ4cm/Zwg6gCHTt6gTPfwBZ0SrQmh0ATrnR2Kcixp2q2Bv
         eVfg==
X-Gm-Message-State: AOAM533CWS7VydBe0l7OZEg7KSuOc33+1GRacH1PA+Hja5CAi5pT8kVC
        EQ/zWkdPAyiLVXAm+JMUFph/DLAlou93iQ==
X-Google-Smtp-Source: ABdhPJy3VWjV7RWxxX3ABRwN4a8zHIkMBYKY2/89GnqyLE2t7QJc80rh8nEK3tGl/iFFYlwSiIV7Fg==
X-Received: by 2002:a5d:4b8c:: with SMTP id b12mr1641206wrt.31.1634760204248;
        Wed, 20 Oct 2021 13:03:24 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id m14sm3600119wms.25.2021.10.20.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:03:23 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/2] optimise blk_try_enter_queue()
Date:   Wed, 20 Oct 2021 21:03:17 +0100
Message-Id: <cover.1634759754.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kill extra rcu_read_lock/unlock() pair in blk_try_enter_queue().
Testing with io_uring (high batching) with nullblk:

Before:
3.20%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
3.05%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock

After:
2.52%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
2.28%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock

Doesn't necessarily translates into 1.4% perfofrmance improvement
but nice to have.

Pavel Begunkov (2):
  percpu_ref: percpu_ref_tryget_live() version holding RCU
  block: kill extra rcu lock/unlock in queue enter

 block/blk-core.c                |  2 +-
 include/linux/percpu-refcount.h | 31 +++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.33.1

