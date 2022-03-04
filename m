Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB68C433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Mar 2022 21:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiCDV1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiCDV1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 16:27:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C40585F27C
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646429186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=VJCDl2e633LFK05nuE8gVcSj47NPxoXSEpLgb5WvFBw=;
        b=G4bf5YBaQfaOpb8QuyeroM+II5QyTBrl+oK8M9Xe1Mv8Np+sXlliDGyxlsuAR8E0eKgx8V
        M4N7gB2ENuAyIwlaN6NlBaSkmQ0kNRyiuKHkwZn6Yh1+2qI03/hlLV0RKtOK6Vn4egcHVi
        JW+6uTt+G0TSOkRUeqWykn788DGxXOE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-paOuJ_bbNrmXtl59wg97Zw-1; Fri, 04 Mar 2022 16:26:25 -0500
X-MC-Unique: paOuJ_bbNrmXtl59wg97Zw-1
Received: by mail-qt1-f197.google.com with SMTP id r13-20020ac85c8d000000b002e0234f9bb5so7185854qta.0
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 13:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VJCDl2e633LFK05nuE8gVcSj47NPxoXSEpLgb5WvFBw=;
        b=Qost1JrrE9+dnqlp6K5Tkk0nekrZWzxUuV/tDyJux4DkMLXrlRcL3jIv1/dM59XLYl
         rCZbzvI9f1LSvxENVEHUWuLP04Z6lbhKYzfUVvmYqG7UWLqfltcq53rF6EqOQ2DZ7YC/
         yL5NxwRrEtIUlEVGJUCdBzsvRnKC1Gb9LdkGod3OFiw8GSVLaNxUcrwjhYXkwz2V/mW7
         G884Fn/svUFPyqBlO77zKEmRMEG1aZKDsAcdFqUpXf9RUi0I1aGTB6PdZTmpafY6KosW
         H8yQeYGrbQQTQAmRiaZSGBICecO0fZP31d5c6DfM/XP820RUfe2Mqmr8/PVaN3JWt4Om
         HGDw==
X-Gm-Message-State: AOAM532+WoQVm4T2j9RdUyEK2tPh2C5lGdfbFm4ZNeCgTKMRoXEbPiHT
        xC7ReOO6QXcQZKRL61AmWJh1RQWDscUO4lxuv0gwk6s6FlJPSB4BwbLvdxB6v1lxZRKDblNnr6n
        mF2Vp04lBG02OgowU3aYVww==
X-Received: by 2002:ad4:5968:0:b0:435:17c2:8c8e with SMTP id eq8-20020ad45968000000b0043517c28c8emr433776qvb.120.1646429185287;
        Fri, 04 Mar 2022 13:26:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHy6PROWMA8dQh7PKu/neB1y+0Iv/55SqrUWum+Nh77YYVw/FibH07+U/Lv/jzmhwTL3s+dA==
X-Received: by 2002:ad4:5968:0:b0:435:17c2:8c8e with SMTP id eq8-20020ad45968000000b0043517c28c8emr433764qvb.120.1646429185084;
        Fri, 04 Mar 2022 13:26:25 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v129-20020a379387000000b0064936bab2fcsm2982228qkd.48.2022.03.04.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:26:24 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v4 0/2] block/dm: support bio polling
Date:   Fri,  4 Mar 2022 16:26:21 -0500
Message-Id: <20220304212623.34016-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I've rebased Ming's latest [1] ontop of dm-5.18 [2] (which is based on
for-5.18/block). End result available in dm-5.18-biopoll branch [3]

These changes add bio polling support to DM.  Tested with linear and
striped DM targets.

IOPS improvement was ~5% on my baremetal system with a single Intel
Optane NVMe device (555K hipri=1 vs 525K hipri=0).

Ming has seen better improvement while testing within a VM:
 dm-linear: hipri=1 vs hipri=0 15~20% iops improvement
 dm-stripe: hipri=1 vs hipri=0 ~30% iops improvement

I'd like to merge these changes via the DM tree when the 5.18 merge
window opens.  The first block patch that adds ->poll_bio to
block_device_operations will need review so that I can take it
through the DM tree.  Reason for going through the DM tree is there
have been some fairly extensive changes queued in dm-5.18 that build
on for-5.18/block.  So I think it easiest to just add the block
depenency via DM tree since DM is first consumer of ->poll_bio

FYI, Ming does have another DM patch [4] that looks to avoid using
hlist but I only just saw it.  bio_split() _is_ involved (see
dm_split_and_process_bio) so I'm not exactly sure where he is going
with that change.  But that is DM-implementation detail that we'll
sort out. Big thing is we need approval for the first block patch to
go to Linus with the DM tree ;)

Thanks,
Mike

[1] https://github.com/ming1/linux/commits/my_v5.18-dm-bio-poll
[2] https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18
[3] https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18-biopoll
[4] https://github.com/ming1/linux/commit/c107c30e15041ac1ce672f56809961406e2a3e52

Ming Lei (2):
  block: add ->poll_bio to block_device_operations
  dm: support bio polling

 block/blk-core.c       |  12 +++-
 block/genhd.c          |   2 +
 drivers/md/dm-core.h   |   2 +
 drivers/md/dm-table.c  |  27 +++++++++
 drivers/md/dm.c        | 150 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h |   2 +
 6 files changed, 189 insertions(+), 6 deletions(-)

-- 
2.15.0

