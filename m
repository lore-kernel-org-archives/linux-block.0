Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEFFC6FD20
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 17:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjCXR7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCXR7V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:59:21 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2B231D8
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:57:53 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id l7so2151283qvh.5
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pgbVxku/SERnvHwqjL/zSj3oN14cdGjOWYCaoljOO4=;
        b=ch+WI0rwZht0Gakl5OHUbcU3pkB5EegDPfbHiXj2KXQ10RwFliuJ4ijqo7kjuJdU6C
         C1mBLsSFg34Da+dVOA116dPVKn6XhTfmqrixO1i4NzD3aCdrevr4i7w0iWliVKJVdbGW
         HR3pAI8hV9wLnBgO2V+CMkj5S+ziOhV+0o0Y3Ovy24hJuZIwJyQVGb+lu9rHwr6aIdRG
         MFXBe4nVa35jznnG9Z3vRaMBJJFnlX8lTvLuTAc4ErqopqjcKwpKnf+V87YPu0lnFLxh
         yOHLTBaihwrS4172Po9f/zf6jz5WvzO0ULSphde8ZiKWpmq2bMjhePHUwu8HTQyyo6eK
         zajQ==
X-Gm-Message-State: AAQBX9er0+5v4U9xtvIly/I2aqAMS+p4Q5SUzDxce3mGtkhlUukHYIFr
        cLAyLZYOo7RSnUCGWNTLhkCzElIuM8IAvyMakBTJ
X-Google-Smtp-Source: AKy350YIMdLtee9pqwLUGDnz2HJDv9utRDKSI0McKyJpOJ5/JI3+moTTSTAHfS8GD6Ef0QjCYYY8Ug==
X-Received: by 2002:a05:6214:d05:b0:56e:9c11:651e with SMTP id 5-20020a0562140d0500b0056e9c11651emr6039810qvh.27.1679680620491;
        Fri, 24 Mar 2023 10:57:00 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cea52000000b005dd8b9345c5sm857446qvp.93.2023.03.24.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:00 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 0/9] dm bufio, thin: improve concurrent IO performance
Date:   Fri, 24 Mar 2023 13:56:47 -0400
Message-Id: <20230324175656.85082-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset has been staged in linux-next for the 6.4 merge
window. The relevant linux-dm.git branch is here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.4

The initial patchset I posted earlier in the week for this line of
work didn't properly split DM thin's discards. To be clear: both Joe
and I missed this, and the issue impacted the patchset I posted _and_
code Joe had developed and tested to that point.

device-mapper-test-suite's "discard_with_fstrim_passdown_true_ext4"
test reliably reproduced the incorrect splitting.  The issue was the
DM thin target wasn't respecting the new restrictions imposed by
dm bio-prison-v1 (which the DM thin target uses). Joe fixed this and
the code reflects that in patch 9.

All said, and as detailed in the "Testing" section of the header for
patch 3: these changes have _now_ been extensively tested in terms of
dm-thin (and dm-cache as much as device-mapper-test-suite
provides). The cryptsetup testsuite also passes (DM integrity uses
dm-bufio).

PLEASE HELP with further testing of other more exotic DM bufio
consumers and elaborate usecases (be it via Android, Chrome OS, etc).

Please use whatever tests you have to put pressure on bufio.
In particular: focused testing of bufio's shrinker, verify
DM_BUFIO_CLIENT_NO_SLEEP (via dm-verity's tasklets), etc.

There is still time to add fixes for 6.4 should any issues turn
up.

All review is welcome (I'll rebase to include Reviewed-by or Acked-by
tags). Also, positive reports in the form of Tested-by replies are
welcome!

Thanks,
Mike

Joe Thornber (4):
  dm bufio: remove unused dm_bufio_release_move interface
  dm bufio: improve concurrent IO performance
  dm thin: speed up cell_defer_no_holder()
  dm bio prison v1: improve concurrent IO performance

Mike Snitzer (3):
  dm bufio: move dm_buffer struct
  dm bufio: move dm_bufio_client members to avoid spanning cachelines
  dm: split discards further if target sets max_discard_granularity

Mikulas Patocka (2):
  dm bufio: use waitqueue_active in __free_buffer_wake
  dm bufio: use multi-page bio vector

 drivers/md/dm-bio-prison-v1.c |   87 +-
 drivers/md/dm-bio-prison-v1.h |   10 +
 drivers/md/dm-bufio.c         | 1970 ++++++++++++++++++++++-----------
 drivers/md/dm-thin.c          |  110 +-
 drivers/md/dm.c               |   25 +-
 include/linux/device-mapper.h |    6 +
 include/linux/dm-bufio.h      |    6 -
 include/uapi/linux/dm-ioctl.h |    4 +-
 8 files changed, 1509 insertions(+), 709 deletions(-)

-- 
2.40.0

