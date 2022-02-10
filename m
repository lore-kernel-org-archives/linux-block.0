Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C21BC433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 22:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiBJWii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:38:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiBJWii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 17:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B262664
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644532716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5zsO3Fp/ELwIYD28/txcroKMAxj9kdpSixyYpBN1Xrw=;
        b=X5dfXb+x7RCXoWE3bLGEpoaiP1sGUpUmgRTokWGXDHN26S3MxiJkocKtVatPrkfpw7SAal
        tGKElTBnk3uV3aS4LjtHZYndIHics6JagJqfNPcXK7VhuwgzabNlLep/g08oGhsWWlMspt
        +cvGSnL9UFM10ta+Q3EGnCsc2PlQaDY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-7NO-Zn2xNWyygJytZSbbvg-1; Thu, 10 Feb 2022 17:38:34 -0500
X-MC-Unique: 7NO-Zn2xNWyygJytZSbbvg-1
Received: by mail-qk1-f198.google.com with SMTP id z1-20020ae9f441000000b00507a22b2d00so4571958qkl.8
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 14:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5zsO3Fp/ELwIYD28/txcroKMAxj9kdpSixyYpBN1Xrw=;
        b=s4e2XF50iXVaxSkiXqR0KLOFrsq9J/Q/MCmeNnFN/vX+F5MkqPJpda9JZO5B2pjInh
         5T1W9ATLjEm8WbERIVZZQwjpsLKRg20BqXiAkO/vUxPEsQm5AlYoOrvtTpDiVaeORCnX
         ygJ7qxDMlG+9Y3cIO/j9Y3wnyr5Z7mBXr7EYkpxDTxk9N3Yi1Hbiu6XGgik0clf/HwoD
         xDOxDN5lx9Z0xjc96i1HRj+rw1/fIBtaiSamLJ/qbhA9saX/Wr+3af5uuiMDpmiFbjtp
         jBc477vzJTCBX/nmODQ4ybZbp4ErjPcFqmelHyR8xdvNbsJkJmplDsPWWO2aiwGVa3lR
         Oqjg==
X-Gm-Message-State: AOAM533TuCA7dfyAtI+JN9oS87O9AlQrgtz+ADuS8+CEil0bHpsvJ1Gq
        cVeODjr2aA4xolq5Z+rZZVqI+uVMrYmG8ZckadGqK0sVnnfxblpvDUcqIfwPniVefWfPN0RiJRv
        gBJUDFAHC5ag5W2RLod/m9Q==
X-Received: by 2002:ad4:5b83:: with SMTP id 3mr6625810qvp.103.1644532714152;
        Thu, 10 Feb 2022 14:38:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZUXcOQHDRnivoNe930Kbl9CSrwP87HKASyNcGBndoZSfIJ5t7gykPiUrhOnJ90EtUlhGs5A==
X-Received: by 2002:ad4:5b83:: with SMTP id 3mr6625803qvp.103.1644532713898;
        Thu, 10 Feb 2022 14:38:33 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id b10sm11641506qtb.34.2022.02.10.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:38:33 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 00/14] dm: improve bio-based IO accounting
Date:   Thu, 10 Feb 2022 17:38:18 -0500
Message-Id: <20220210223832.99412-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

All the changes from this patchset are available here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18

This work is based on Jens' for-5.18/block

For the linux-block crowd, I'm spamming you purely to seek review of
the last patch in this patchset (but welcome review of the entire set
if you're willing). Given all the DM changes that precede the last
block patch I'd appreciate review so it can be merged for 5.18 via
linux-dm.git.

DM is the only consumer of the recently added bio_start_io_acct_time
that the last patch enhances and renames to bio_start_io_acct_remapped

This patchset's primary purpose is to add the dm_submit_bio_remap()
interface to improve the bio-based IO accounting for DM targets that
take ownership of bios and use their own workqueues to process/remap
and later submit the bios.

Motivation is to fix the relatively useless nature of dm-crypt's
buffered IO stats.  DM core shouldn't immediately start IO accounting
for bios that dm-crypt goes on to queue in workqueues. The IO should
only have its IO started once submitted.  Otherwise the iostats for
dm-crypt just looks like an upfront flood of IO but then offer little
indication that anything is happening.  Given dm-crypt's cpu intensive
nature it takes time to complete IO but unless you look at the
underlying devices' iostats you wouldn't see it occurring.

Mike

Mike Snitzer (14):
  dm: rename split functions
  dm: fold __clone_and_map_data_bio into __split_and_process_bio
  dm: refactor dm_split_and_process_bio a bit
  dm: reduce code duplication in __map_bio
  dm: remove impossible BUG_ON in __send_empty_flush
  dm: remove unused mapped_device argument from free_tio
  dm: remove code only needed before submit_bio recursion
  dm: record old_sector in dm_target_io before calling map function
  dm: prep for following changes
  dm: add dm_submit_bio_remap interface
  dm crypt: use dm_submit_bio_remap
  dm delay: dm_submit_bio_remap
  dm: improve correctness and efficiency of bio-based IO accounting
  block: add bio_start_io_acct_remapped for the benefit of DM

 block/blk-core.c              |  24 ++---
 drivers/md/dm-core.h          |   4 +-
 drivers/md/dm-crypt.c         |   7 +-
 drivers/md/dm-delay.c         |   3 +-
 drivers/md/dm.c               | 224 ++++++++++++++++++++++--------------------
 include/linux/blkdev.h        |  16 ++-
 include/linux/device-mapper.h |   7 ++
 7 files changed, 156 insertions(+), 129 deletions(-)

-- 
2.15.0

