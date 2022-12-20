Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A91C4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 15:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLTPgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTPgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 10:36:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725DBE0
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:36:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso4053468pjp.4
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxl0InSoARM/7UBwdi5nFBAGiRL61MdXiXPVohsOoG4=;
        b=pbrhT7tJJ4UaSRDtKvN1b8t7VD5vBD6dgQESI54cXIieh3RVnXY/P7TiRTi0LrYyCU
         c8kM4iTtURCYGK8osxsri85HNtCmcNIciUSzVf6P46kpiJxcepbKLlfslFZmCTfvKZVf
         1XGm01UW3fb7BWdbsJW9S6RtPHasPnGyWntcxdFu67e98XZunbVv3SNtG1qykc9P2nZl
         RHJa79GajkSGYq5fV98BvD1Wo2T82HfUuXivqCKfcQzu0D1L+jPhmdKB0ePu3fey9iDN
         eTGs+IF7g/1r3qQg1UbVeeH08+as23GfbMyuGn45P+kdwLqBkNJhLPgq2DZ0spgh4p61
         wPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxl0InSoARM/7UBwdi5nFBAGiRL61MdXiXPVohsOoG4=;
        b=L/wASNXLtvUh64QPs9MclBd4MeHEHoUjsRfK7ZK/VNnlSkSj+EntCGJbQM1QXT4FqP
         kr6Q/mFzpsNNn3qXDh9wAM6TOCruJ9sxkcjazN7fZ2fY7X891wiu2PozQGQkYHjcfcRK
         TtaRgbPeUFR+jbhR3/oX190I596To3XDNGkVEQmaQZ0Vfhura1HF/N/ZIrytZBJtLa/u
         HcQBAnFtAUuRt8Zh3D4to3worvtySVG43Ybn39TgiKyupssiVObK3OrSXMME3XRFNeCm
         d0G4Dz0vJlqUObmYEetcWFtFdL3WSV+r3RbrKuXH844jTBUqyrDRuXLPd+rm+kDLrWfy
         xAvA==
X-Gm-Message-State: AFqh2kopAMDDGfxpkILapBxKd2496S+zIGm7BIZlcPVioAM4PbKmgiH5
        NEB3Pph1r4H4+WJlHL4obD8=
X-Google-Smtp-Source: AMrXdXvQWmPLNrcOzBg+Cw6pLqZ19VTmyR+sHHnyhNp7AF/eqF1vXqoXhhpptsS07XjlQ1NnLUrOKg==
X-Received: by 2002:a17:902:f7ca:b0:191:23e0:366 with SMTP id h10-20020a170902f7ca00b0019123e00366mr7433900plw.13.1671550598788;
        Tue, 20 Dec 2022 07:36:38 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id jf3-20020a170903268300b001811a197797sm9558084plb.194.2022.12.20.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:36:38 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 0/2] virtio-blk: set req->state to MQ_RQ_COMPLETE and support completion batching for the IRQ path
Date:   Wed, 21 Dec 2022 00:36:11 +0900
Message-Id: <20221220153613.21675-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

V2 changes
 - patch#1
  - use blk_mq_complete_request_remote() instead of blk_mq_set_request_complete()

 - patch#2
  - Modify patch based on the patch#1 v2 changes.
  - Use iob.complete(&iob) instead of virtblk_complete_batch(&iob)
    at virtblk_done() (Stefan's comment)
  - It shows almost same performance improvement as v1 patch.

Suwan Kim (2):
  virtio-blk: set req->state to MQ_RQ_COMPLETE after polling I/O is
    finished
  virtio-blk: support completion batching for the IRQ path

 drivers/block/virtio_blk.c | 81 +++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 36 deletions(-)

-- 
2.26.3

