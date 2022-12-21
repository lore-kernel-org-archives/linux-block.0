Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01CAC4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 14:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLUOz3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiLUOzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 09:55:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D45222A2
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:55:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n4so15781030plp.1
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=se4c3LQvSx7KSnptIZl2MwU32n2d0yvOFzD9VsguCis=;
        b=WQILcTT2t7SAy7v2zA4Evc0z7hmgKBS9s/+tkmvSEGFazylzISKhfn7zMLwqNhsfoH
         E28arsOhRH3CXnUFBlItWmhmdLtmQNtNkuI3enmiUkhQQ2tYUL7LmQONJeaTAtjC/osR
         N4RhusTJM/4wwlgapI/rih25EoOzjhVLc2rCvpuNhdgYs6LNFNBzuD4nTOX9xdCfmRSQ
         +fNmCI6G/cKJHJSrzlN2BVc+Fzu3+2MDpu8jj3YPHZhOc6kCp1w2LAGG/tZrIf8ZkZQE
         k0HGb8hZ6ZEgbaey4qQvH+kjkreSDawhPPYPpds7ynrFzXhNb2Q5TdZnIy+njevRmI0x
         hFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=se4c3LQvSx7KSnptIZl2MwU32n2d0yvOFzD9VsguCis=;
        b=EtEkYF4H0MSxh3vSIi3g4A5A30tUr5Mxym6rmtE5iUrxrkDmwlSjLNg76+i61Jo1tG
         3sIjlcpx0xwmeo9dNQMhhSHi24vEXgksEIyepFW3/BY6P6sVk/EewPy8r04mMXNmgZNd
         hTkTMcxJJax4WNclutbJA6zLr4U/RP0Qc+lh19qrtaYuEu+Fa9eiezE+JdKdrdRgMr08
         FkYM3fq9++DcT0+eyOBdJSsFXKHjfcaxhx+Zs5qiQ4/suJZJ52je7sjRhIHDci61zZo8
         YmdF1ZQW5Gow3kdiuZWx7obH/4XQWLeuO85rVB83K7ydZlpwQEy/w7mvPYlHgJIP3Z10
         +elg==
X-Gm-Message-State: AFqh2krHbtKyzOqcd2uFF8mPMEPuFV6wDwOwX6McnLXnISFnBSx8zF9z
        hU59yBKZSARvgKcWW24nnrTZ+OqsOtY=
X-Google-Smtp-Source: AMrXdXtu5gbplphmND73rFm1KE+mj+MAvzgNZgktgPJn1AV72kJepNyBqM62Xtjn/CYvQix+e9EqxA==
X-Received: by 2002:a17:903:10c:b0:191:457b:fb9 with SMTP id y12-20020a170903010c00b00191457b0fb9mr1920751plc.69.1671634521796;
        Wed, 21 Dec 2022 06:55:21 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id d9-20020a170903230900b00176dc67df44sm11573994plh.132.2022.12.21.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:55:21 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v3 0/2] virtio-blk: set req->state to MQ_RQ_COMPLETE and support completion batching for the IRQ path
Date:   Wed, 21 Dec 2022 23:54:54 +0900
Message-Id: <20221221145456.281218-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

V3 changes
 - patch#2
  - Adjust tab indents for line continuation (Christoph's comment)

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

