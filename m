Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9694C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0061212
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJUNdO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhJUNdN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 09:33:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD29C0613B9;
        Thu, 21 Oct 2021 06:30:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e12so1146779wra.4;
        Thu, 21 Oct 2021 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+0W4a7ajc/42At+/XY3zEOp2xDA6GsLU+vihGYQJjI=;
        b=GM6vEvDiq18fZTt/3BWPB8rL8xabNUDF7bvLouAZs+L4s+RL1SMqSH2p6migRbiJGj
         VqqznedHEpvspyDHA+J4EPPv0ZW7dYj9AP057Q6R6N7OxOiHuSK1+ZiPmqlsLct9sZMx
         Rp3FlH53+Be9eLmc7MAzO2Ar4Vr79mf5Jw18lCAtdczImfnubYQrRbWRar4g8t7rt2ak
         xKHmh790AB0pGslHQeYVpCn80eW9KCLBWX47FXPkdQ79u8rj1hWSiOM0UFMQc3a6j2Bj
         sARADMc0d2eyJ8PcgFIFLF8Kdb6KwzIUA9yyuj+SgeAj7OQpNld7/VnK2s3aj4id41gg
         D4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+0W4a7ajc/42At+/XY3zEOp2xDA6GsLU+vihGYQJjI=;
        b=Oi0gUpvi7YlAEQn+sD/D6RG6o3O4FWAR7E6eO/mcN5jevnZeAJu2OJnt2LFxlHmoff
         X4zWZtI6Rq0SLafsHnLxYI0G0HrxVnO8dxX9dDF9CHoIxoWCsELJ35jtK2FQhfgx+3vH
         4BxFNeJ+AA/rdgsAS/ElqXiEC+83kPMsp8wXcC6QtxhLQhtYI0BFeBHvRSRvc+wzd/fW
         Z0WeExHCvvgdHm/0L+FhiRij0RpGAYlgmm9/Z4nfY/3Wt5q1xdxuDdBlS/Dp5Rwbx4LU
         34QBeE1ymS6CgBkWGvpid1DBxqFUeoCJG2BNe4jH1e8C4H9HwIAAGQo+cGWfzvKivY34
         KB0g==
X-Gm-Message-State: AOAM530Mv7Z2lllmQubLXkV5tVz2hrMk6/VbNg9Nq55PN365kX9flYTE
        dxQvqSAJKACMFyXrvdV4SDXHDeZvZ3MdCQ==
X-Google-Smtp-Source: ABdhPJzOTqbPi/I4x+EXVo8lE0cNw9TdqACGEBYPKCiYKpYoKaUh83al0Zl89H852GC6n6usWGyfYA==
X-Received: by 2002:adf:ee8b:: with SMTP id b11mr7172855wro.349.1634823055644;
        Thu, 21 Oct 2021 06:30:55 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id q188sm1753987wma.1.2021.10.21.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:30:55 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 0/2] optimise blk_try_enter_queue()
Date:   Thu, 21 Oct 2021 14:30:50 +0100
Message-Id: <cover.1634822969.git.asml.silence@gmail.com>
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

v2: rcu_read_lock_held() warning (Tejun)

Pavel Begunkov (2):
  percpu_ref: percpu_ref_tryget_live() version holding RCU
  block: kill extra rcu lock/unlock in queue enter

 block/blk-core.c                |  2 +-
 include/linux/percpu-refcount.h | 33 +++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.33.1

