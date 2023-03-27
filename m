Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A3C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjC0UN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC0UN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:13:58 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C642119
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:07 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id bz27so9823416qtb.1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qJNUeSlBs/QEWgQxKgn+fN4efQ2Lsv6ieQkqZqD36k=;
        b=XOy2Ce+da8PYNY2XC9CcLJycJbtlt9ul78+U624n954Z2C3z7HPNDjmmmkY/LyiRkq
         E1Gbbil5KnBRcaq/hy4MtIE1f6McJ9oyATGbxNcwSrD7Q3iOWLe5XXGcGF52w/NSsJVM
         kvwsQUQ5eXP1ZJZE2ZsKgPpzZlunf8B9krpJLxFedw3qrz4bIUdCoiiZUHH6QbpXGn+B
         I3PgNwFdzthW2clI+45Uk8Sgq+I19xSiUcWJwFfg8eWeEQCZIw6/QmkkmZ4KWaIcCV2A
         82FRKsfvKEonZ9SlG38A+KjTKjnFyn6zaH6UMmCFVmh1GrZ/pGrMYYaeW9nHI4tdBnPP
         +I1w==
X-Gm-Message-State: AAQBX9eUHoAyDQ5x45NBz89hk3N2d+dcy23bqb3eXhEd0oJuQwf8q0nW
        JV39u/fttLvsVC+EWO2pgtPn
X-Google-Smtp-Source: AK7set/ppDiFJOM41j6nJOJdse4DtNuQjF0Ham2H9Bi3wiljlVirf95cZyVIlW0IDk8G6l/Z0J0d8A==
X-Received: by 2002:a05:622a:1a20:b0:3e3:9041:3f6e with SMTP id f32-20020a05622a1a2000b003e390413f6emr23188584qtb.7.1679947986828;
        Mon, 27 Mar 2023 13:13:06 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id he8-20020a05622a600800b003b835e7e283sm380873qtb.44.2023.03.27.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:06 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 00/20] dm bufio, thin: improve concurrent IO performance
Date:   Mon, 27 Mar 2023 16:11:23 -0400
Message-Id: <20230327201143.51026-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Please review and/or test. Thanks.

Available via git here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.4-dev3

Diffstat from v2 to v3:

git diff dm/dm-6.4-dev2 dm/dm-6.4-dev3 | diffstat
 dm-bio-prison-v1.c |   80 ++++++++++--------
 dm-bio-prison-v1.h |    5 +
 dm-bufio.c         |  226 ++++++++++++++++++++++++++++-------------------------
 dm-thin.c          |   29 ++++--
 dm.h               |   10 ++
 5 files changed, 197 insertions(+), 153 deletions(-)

Changes from v2 to v3:
- fixed inconsistent braces in conditionals and other whitespace nits
  in response to the quick review Jens offered on v2
- also fixed struct layout Jens noted, so locks and data they protect
  are on the same cacheline
- split v2's really large dm-bufio-improve-concurrent-IO-performance
  patch to be 4 patches (patches 5-8)
- removed the (ab)use of BUG_ON in most of dm-bufio.c (in preliminary
  patches 2-4 and also within patches 5-7)
- removed the bio-prison-v1.c's BUG_ON (introduced in patch 14) in
  favor of higher level dm-thin.c code checking when it builds the
  prison key (allowing for graceful error handling), in patch 15.
- introduced dm_num_sharded_locks and use it to remove the "NR_LOCKS"
  magic value (64) used to split locks in both dm-bio-prison-v1 and
  dm-bufio (patches 16-20).

Changes from v1 to v2:
- fixed dm-thin to properly split discards to respect
  dm-bio-prison-v1's BIO_PRISON_MAX_RANGE limit

Joe Thornber (7):
  dm bufio: remove unused dm_bufio_release_move interface
  dm bufio: add LRU abstraction
  dm bufio: add dm_buffer_cache abstraction
  dm bufio: improve concurrent IO performance
  dm bufio: add lock_history optimization for cache iterators
  dm thin: speed up cell_defer_no_holder()
  dm bio prison v1: improve concurrent IO performance

Mike Snitzer (11):
  dm bufio: use WARN_ON in dm_bufio_client_destroy and dm_bufio_exit
  dm bufio: never crash if dm_bufio_in_request()
  dm bufio: don't bug for clear developer oversight
  dm bufio: move dm_bufio_client members to avoid spanning cachelines
  dm: split discards further if target sets max_discard_granularity
  dm bio prison v1: add dm_cell_key_has_valid_range
  dm: add dm_num_sharded_locks()
  dm bufio: prepare to intelligently size dm_buffer_cache's buffer_trees
  dm bufio: intelligently size dm_buffer_cache's buffer_trees
  dm bio prison v1: prepare to intelligently size dm_bio_prison's
    prison_regions
  dm bio prison v1: intelligently size dm_bio_prison's prison_regions

Mikulas Patocka (2):
  dm bufio: use waitqueue_active in __free_buffer_wake
  dm bufio: use multi-page bio vector

 drivers/md/dm-bio-prison-v1.c |   93 +-
 drivers/md/dm-bio-prison-v1.h |   15 +
 drivers/md/dm-bufio.c         | 1988 +++++++++++++++++++++++----------
 drivers/md/dm-thin.c          |  125 ++-
 drivers/md/dm.c               |   25 +-
 drivers/md/dm.h               |   10 +
 include/linux/device-mapper.h |    6 +
 include/linux/dm-bufio.h      |    6 -
 include/uapi/linux/dm-ioctl.h |    4 +-
 9 files changed, 1558 insertions(+), 714 deletions(-)

-- 
2.40.0

