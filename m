Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED5C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 20:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431B361056
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 20:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhJOUxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233367AbhJOUxF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 16:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634331057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Y+K55f8Q7QWzfWU0hxK25q9E+I8hW/Nq+N/9r8pMH98=;
        b=IWx29pYlFGS/PhyqIZqSD7R9V3tsCMEY3vQM1QJfGJhtxUKzq/mBu7kNxLTjFLu53WTRSr
        j5wFtxmBaTRpN52jt0vL/LTXVS+/cQdPH2jvdTNhegxn2lWoxjNId4ONyXkP/fPPpP4CYP
        xyznb4Hcl0v7FSI3q2zwZXTgqmQhyTg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-GgtdG11aNauqhq8o-mjSmA-1; Fri, 15 Oct 2021 16:50:56 -0400
X-MC-Unique: GgtdG11aNauqhq8o-mjSmA-1
Received: by mail-qt1-f200.google.com with SMTP id e10-20020ac8670a000000b002a78257482eso7483047qtp.10
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 13:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y+K55f8Q7QWzfWU0hxK25q9E+I8hW/Nq+N/9r8pMH98=;
        b=nISLpOg2LpCJpoFalTzT/XpMsozorbxvegXBvyPhEW9Z2IfokzkqDTDSaQm9Chg5kf
         S4Jl47qsIonZq4qiRP3GamkaIP6qyzf2AxeRUt1X/hzaIM3L0BY45aiVlQkpQnjH7NpZ
         6VF33OVMFXi0lhPxaXVhHyQYx+5LfgjhL+KP5enCcsVuZWkWUd77htEXDoa1btcXV6KD
         2PtPJEIJwbdeXGa1i97/pT8c2R0EEcWWBSkppX8x/6CwousGB+N33j1bIwV+aFgBcLQQ
         MvFNHI/2VWet3UsgP69EWlXlmruYiVGWuhigRsYh6JkSH/tFXGXNO3aSBC7JT6ogGpXa
         sHrA==
X-Gm-Message-State: AOAM533E/fUBwZ8bT1e7QhEESMwii1fqwt3fUdYiEOn8a9W6JOSFk3sK
        Zv1QgZImrNTZ4tZl/B/qEJAHXzPmsSJgXqQX/eYD47kfRT1P17ea/xMjvwojUr+F05WTENnOMGZ
        grYSG/tTRd0KFe+eA11etAA==
X-Received: by 2002:a37:bec4:: with SMTP id o187mr11966132qkf.383.1634331055938;
        Fri, 15 Oct 2021 13:50:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJdkD9RTr5OEPVNgYJkkIUrpO2zmJv8r1bXuHIYIFeuCPnq4PDQ0OKIgZ7UZewuuu8PQjGcA==
X-Received: by 2002:a37:bec4:: with SMTP id o187mr11966116qkf.383.1634331055746;
        Fri, 15 Oct 2021 13:50:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m14sm3111893qtq.74.2021.10.15.13.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:50:55 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:50:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Akilesh Kailash <akailash@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jiazi Li <jqqlijiazi@gmail.com>, Ming Lei <ming.lei@redhat.com>
Subject: [git pull] device mapper fixes for 5.15-rc6
Message-ID: <YWnprivVeSQHkRxN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-fixes

for you to fetch changes up to d208b89401e073de986dc891037c5a668f5d5d95:

  dm: fix mempool NULL pointer race when completing IO (2021-10-12 13:54:10 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM verity target to skip redundant processing on I/O errors.

- Fix request-based DM so that it doesn't queue request to blk-mq
  when DM device is suspended.

- Fix DM core mempool NULL pointer race when completing IO.

- Make DM clone target's 'descs' array static.

----------------------------------------------------------------
Akilesh Kailash (1):
      dm verity: skip redundant verity_handle_err() on I/O errors

Colin Ian King (1):
      dm clone: make array 'descs' static

Jiazi Li (1):
      dm: fix mempool NULL pointer race when completing IO

Ming Lei (1):
      dm rq: don't queue request to blk-mq during DM suspend

 drivers/md/dm-clone-target.c  |  2 +-
 drivers/md/dm-rq.c            |  8 ++++++++
 drivers/md/dm-verity-target.c | 15 ++++++++++++---
 drivers/md/dm.c               | 17 ++++++++++-------
 4 files changed, 31 insertions(+), 11 deletions(-)

