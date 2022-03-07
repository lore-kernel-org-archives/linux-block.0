Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29836C433F5
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 18:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiCGSyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiCGSyC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 13:54:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22DEB6A07A
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 10:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646679186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=PIrPGInHSFz6WNm2eA20N9PIF/z1AQDXcwiipcOk5RY=;
        b=ByOCUYHJx4IaXrjcsikPAI6k+NZDesKwmqFhXzuK2Mpz9lsu8ajiVFNTN+m2242DDi4+2e
        SaxeJFJpqhvigomSRUoNvDQOKrJ+63lgkPaG/R5GgFFEBApav6BW7wm4OTMg73s7Fkk0Gf
        50vLj/cn9IGIlKr2s0N209ywfBK+v50=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-WiPVRe0GOeeOCqbWfoC9UA-1; Mon, 07 Mar 2022 13:53:05 -0500
X-MC-Unique: WiPVRe0GOeeOCqbWfoC9UA-1
Received: by mail-qv1-f71.google.com with SMTP id j6-20020a056214032600b004358f15c51bso3026299qvu.1
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 10:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PIrPGInHSFz6WNm2eA20N9PIF/z1AQDXcwiipcOk5RY=;
        b=h1jAVze/u9SaD26ihaS+t5ZTtuPoaC4sFsdsY6V5dKH7qesg/jHpspFMbQl5lc6GL5
         TBrvjjX50xMAbhMgRJ9v1a7zMLCAQAjnbjdE2TQmc1BzI1OtpVlTWyPNK7Z4u0x+UKUw
         H10zktSFRaox17f4GBRX10RyAsf3CsqQh9npsHPc2/6fb05t9M2QcN2TuxnmaJ1nCxsd
         hvkIHJumW4cng2aU+F1sg9M0B53Oxil+PpISQoxcidEBYtfnfl/yIQpzZhh/hfSbAPvl
         QyK31jQZpN91yw2X7QQBibvDoVL3H2lKAqpOBn44bc1lZ71KAcennbMMkLqRI9YOrfW5
         1lWA==
X-Gm-Message-State: AOAM531Ya5AJx5nCsSgqqBUdnHV02bViUcRI0J7GDJFejyg7XSjdtyDy
        f3ygmAajI5Ynvgcjj+1jMIxutH1AenXb3/9tVWvy5ayDH8mRPzB4pUy3+ehpd5Kh0LkvWUvVH5P
        EKHXhlXxqML8n/X57rrMb8g==
X-Received: by 2002:a05:6214:4013:b0:435:8b0f:a127 with SMTP id kd19-20020a056214401300b004358b0fa127mr5268771qvb.31.1646679184566;
        Mon, 07 Mar 2022 10:53:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9csigrfNznVmFZq2Q9zzriqWpGxcyNHJVTL9cD9sj+DHv7P9mtBvYYX+RHoMj/pfPQRrZJw==
X-Received: by 2002:a05:6214:4013:b0:435:8b0f:a127 with SMTP id kd19-20020a056214401300b004358b0fa127mr5268757qvb.31.1646679184337;
        Mon, 07 Mar 2022 10:53:04 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s8-20020a05622a1a8800b002de08a30becsm9075790qtc.80.2022.03.07.10.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:53:04 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v6 0/2] block/dm: support bio polling
Date:   Mon,  7 Mar 2022 13:53:01 -0500
Message-Id: <20220307185303.71201-1-snitzer@redhat.com>
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
Optane NVMe device (561K hipri=1 vs 530K hipri=0).

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

Thanks,
Mike

[1] https://github.com/ming1/linux/commits/my_v5.18-dm-bio-poll
[2] https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18
[3] https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.18-biopoll
[4] https://github.com/ming1/linux/commit/c107c30e15041ac1ce672f56809961406e2a3e52

v6: Ming switched from reusing .bi_end_io to .bi_private and added a
    comment to comment-block above dm_get_bio_hlist_head as suggested
    by Jens.

v5: remove WARN_ONs in ->poll_bio interface patch. Fixed comment typo
    along the way (found while seeing how other
    block_device_operations are referenced in block's code comments).

Ming Lei (2):
  block: add ->poll_bio to block_device_operations
  dm: support bio polling

 block/blk-core.c       |  14 +++--
 block/genhd.c          |   4 ++
 drivers/md/dm-core.h   |   2 +
 drivers/md/dm-table.c  |  27 ++++++++++
 drivers/md/dm.c        | 143 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/blkdev.h |   2 +
 6 files changed, 184 insertions(+), 8 deletions(-)

-- 
2.15.0

