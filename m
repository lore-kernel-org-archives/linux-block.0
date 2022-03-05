Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE81C433EF
	for <linux-block@archiver.kernel.org>; Sat,  5 Mar 2022 02:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiCECI6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 21:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCECI6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 21:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C05F340CB
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 18:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646446087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=7Vaf+WRoHUeVQYxK6EsnFI2WrQxqipTtcjN+TM8yHuc=;
        b=a7YRVBtHvOZpcTPMEadSks/t3fXpWM7Dxj9+pKJ1mjmJTziVwuuN7mSW+rPjp/fmdAEmZ0
        54/IsxJkC0dt2AHWJI2/uCUNgghiZrq8p9A/VmpdF/v8T/T8DwjwLDDrxcOyhL6Wnk5pwz
        BSkUH3a7HffBt1Jr5fOPGTRnBhL3owI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-qF5TGsgCMHKrdfm8y1EWbw-1; Fri, 04 Mar 2022 21:08:06 -0500
X-MC-Unique: qF5TGsgCMHKrdfm8y1EWbw-1
Received: by mail-qk1-f198.google.com with SMTP id 2-20020a370a02000000b0060df1ac78baso6998380qkk.20
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 18:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Vaf+WRoHUeVQYxK6EsnFI2WrQxqipTtcjN+TM8yHuc=;
        b=tBGDcU7wamTg+s1M/zn0F4mvuJ3hU6+bbop/7oKc9ggj1kybjgyMOO/+NgCEdtHq40
         sjk90ajPa3Vg7C6joQ+d5O51eL4JP2tmDiGfHrqBQoGJi7JK487qbhmiFBHLrYlof4GM
         EqYJlPkuDjx8IvF6sdgzsSglPFPJLATDtAvF3HftASRJl5hNGnsLCtLVjLy3n+PaiW3u
         QWQirdUTrtapftc34RpVZl/2MB49xKEZ6LWOzNktUAHczZebIego8NL258xgvoq0x0WQ
         7BqUbqggt7RgJfo3ULQ2xTNFc0C0assRlN6zeaLI0JPWSYjcHNRchYXgZ9F7qOJ+7TFF
         +VyA==
X-Gm-Message-State: AOAM5328ZxQ2zy/Tf18XlbISlAFae1e+EFTMvgBCe1Uu5d26XwfLUub1
        QRGX/UCasZ2Vwc5f9dxzsJTcnSfGz/TFU0QtXqqRUv0Bj9tmsig3VbSM9zGxPXa01pCovTnamlZ
        pZnfXYWL7z8vLgeyZMXBsvw==
X-Received: by 2002:a37:80b:0:b0:507:58e:5dd4 with SMTP id 11-20020a37080b000000b00507058e5dd4mr1023441qki.130.1646446086188;
        Fri, 04 Mar 2022 18:08:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuVdv+qlbXOmiw3bwdmjzHCnJrDeVZSnG1NopvMLz5BfsVPwJmSlt7WCIb+H7b05F7asBDhw==
X-Received: by 2002:a37:80b:0:b0:507:58e:5dd4 with SMTP id 11-20020a37080b000000b00507058e5dd4mr1023431qki.130.1646446085950;
        Fri, 04 Mar 2022 18:08:05 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a181600b002dd4f62308dsm4387054qtc.57.2022.03.04.18.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:08:05 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v5 0/2] block/dm: support bio polling
Date:   Fri,  4 Mar 2022 21:08:02 -0500
Message-Id: <20220305020804.54010-1-snitzer@redhat.com>
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
go to Linus via the DM tree ;)

Thanks,
Mike

[1] https://github.com/ming1/linux/commits/my_v5.18-dm-bio-poll
[2] https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18
[3] https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18-biopoll
[4] https://github.com/ming1/linux/commit/c107c30e15041ac1ce672f56809961406e2a3e52

v5: remove WARN_ONs in ->poll_bio interface patch. Fixed comment typo
    along the way (found while seeing how other
    block_device_operations are referenced in block's code comments).

Ming Lei (2):
  block: add ->poll_bio to block_device_operations
  dm: support bio polling

 block/blk-core.c       |  14 +++--
 block/genhd.c          |   4 ++
 drivers/md/dm-core.h   |   2 +
 drivers/md/dm-table.c  |  27 +++++++++
 drivers/md/dm.c        | 150 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h |   2 +
 6 files changed, 191 insertions(+), 8 deletions(-)

-- 
2.15.0

