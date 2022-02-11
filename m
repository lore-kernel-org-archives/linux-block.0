Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29402C433F5
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbiBKVlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353715AbiBKVlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 509D5C68
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8b2j/hRlmeRKgxQS01vdbuNTDBEr7G47snWX3xyMZr0=;
        b=ceItzhN2t7uaNBFU5DVassMY6mjeGSyWtwv0+JGq4UCoJo2vR8BVYFp7d4FLcatzNsBPxT
        YLuIvl7sce+ojbd+ahed+E1UyOHGhWx6ibWiG5f51JVETcf/4WcIIGTtnDZHieLRDd3ozY
        bQjN3xr2+6lIFLu1eJ5HX9tIlvCjji0=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-ZKhhbOYiM9WcTLS5QM-HfQ-1; Fri, 11 Feb 2022 16:41:04 -0500
X-MC-Unique: ZKhhbOYiM9WcTLS5QM-HfQ-1
Received: by mail-ot1-f70.google.com with SMTP id w16-20020a056830111000b005a3e1a958ccso6029634otq.11
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8b2j/hRlmeRKgxQS01vdbuNTDBEr7G47snWX3xyMZr0=;
        b=EaULrRhMvMjF1hZY+WXLQn+L0RkATXtzbpTv6SyH3LspRCTClkU32c/c4d4xtrqqRV
         2OK8tAXAt4mIw5+uT/HyVqYiiGoNkoaVdQ4kK+NwOJDrkOXMB+NOLNLRY7cSjli6cXxQ
         yBXs7WdDJlFT3sY9752AfuExGCFSQf71eILNwsgQCAtzPIjp2D/X7fe/kCp1NOmKdzeH
         B4WmIot81tSZzRnpXQrb32jycHRljkcRfUfoQKuWrEsSYD9BKpoCAZS9IJ4vSBna6ugd
         pCBfCaKAyAgER2KmSr7crWKPOXHMyLFjoCguHW1CzV4AtUIbOzJJbMM8onvkS00Ofovn
         OTVg==
X-Gm-Message-State: AOAM530rvGgvDD7Wj6nFqFV149pEdPY2XRW74SuGgjuAPcycGb2ql2Fr
        fY5OTnoxIuPSw1LMpbl+Trf+MHD5a6LYwit/fr0E0QBufEfYtFKiaGMDzplRVCxZ6fpoMif/LvP
        BMo9g2yeMWmWESXCc0BDFHA==
X-Received: by 2002:a05:6808:ece:: with SMTP id q14mr1091259oiv.174.1644615662992;
        Fri, 11 Feb 2022 13:41:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi7P+hhoDWQ7F6Az0Vws24qOdd5k5JsOKRbyjvj6pMufn+nzx1zyZXbHL8fuSV48Uc3NRqJQ==
X-Received: by 2002:a05:6808:ece:: with SMTP id q14mr1091244oiv.174.1644615662391;
        Fri, 11 Feb 2022 13:41:02 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 1sm9444505oab.16.2022.02.11.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:02 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 00/14] dm: improve bio-based IO accounting
Date:   Fri, 11 Feb 2022 16:40:43 -0500
Message-Id: <20220211214057.40612-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

All the changes from this patchset are available here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18

This work is based on Jens' for-5.18/block

Please see v1's 0th header for context on motivation behind this patchset:
https://listman.redhat.com/archives/dm-devel/2022-February/msg00193.html

Christoph, I addressed all your feedback from v1 and added the
Reviewed-by:s you provided. Thanks for your review.

Patch 10 now isolates the block changes like you asked.

All further review of this v2 patchset is welcomed.

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
  dm: move kicking of suspend queue to dm_io_dec_pending
  block: add bio_start_io_acct_remapped for the benefit of DM
  dm: add dm_submit_bio_remap interface
  dm crypt: use dm_submit_bio_remap
  dm delay: use dm_submit_bio_remap
  dm: move duplicate code in callers of alloc_tio into alloc_tio

 block/blk-core.c              |  24 ++---
 drivers/md/dm-core.h          |   2 +
 drivers/md/dm-crypt.c         |   9 +-
 drivers/md/dm-delay.c         |   5 +-
 drivers/md/dm.c               | 234 ++++++++++++++++++++++--------------------
 include/linux/blkdev.h        |  16 ++-
 include/linux/device-mapper.h |   7 ++
 include/uapi/linux/dm-ioctl.h |   4 +-
 8 files changed, 164 insertions(+), 137 deletions(-)

-- 
2.15.0

