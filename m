Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2FCC04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F3E2087F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 18:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VratITt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfEFSaT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 14:30:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45103 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEFSaS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 14:30:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so6859777pgi.12
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWiIIVTvafssa7j5YFzK8jBCCcMF1hHZ27yFT6HUiho=;
        b=VratITt3OckNpkTxBZmxmeeBz10CUAb/72hiWmNGZIyDt6Rx8s7JILbsP3ytTf4MLZ
         xQ3bzgaughDO59vyRGYHyS+tdAN5djfgX5XflzdqlujfPYO/6DmX5rQVJ/iqp/Kl6ay9
         mLJ6koEBR7aMD9PbYgYeulv2p0N+35KVTbLys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FWiIIVTvafssa7j5YFzK8jBCCcMF1hHZ27yFT6HUiho=;
        b=UpKMMAgtbdmYtjC0W6id74qEtmJ20CzzBJbeH40/NEu5Y3FjhNWWTvz75yyfdSDo29
         3mve5UGrxZ8L/K4V8yqxx7DtxGtRiGzgMvG3SSLfm0GNwe678Ob+FVyisjGeSYrSYjUl
         QFQ1ZygeOyxWdJiDGuHoZuBQM3NF/XDAT0JcehXEwOZL1PM2aLFLOy+xp8PDc5G5+cF2
         pNZ56pHgUG4Hm2ZhpIMtJnY6gZ/ixFBzPxE8tQZ2FzRdILho9EH6HFkCF7S4P5/VCywZ
         +jf7XogRWmOENOBjuAlocb3e6Zt5zRtwelMKSovthC2QTCe99QiW8AyoMlJYvShO5CjV
         tsyQ==
X-Gm-Message-State: APjAAAXFNpFOTyj/903zcqiMdAN0Oekk3LDytW/ON2Fx6CFHsO6cQ5nL
        rdtNNALXpL+Viv7t382cgpVu5Q==
X-Google-Smtp-Source: APXvYqwGOuhHbwCeB8eBEMqaNKfBx6lNy2CUJCcAW0YkFG5ZwcpzzaxxWjTmY7QfNb9/MYQEEEjByQ==
X-Received: by 2002:a62:41cd:: with SMTP id g74mr35756752pfd.216.1557167418165;
        Mon, 06 May 2019 11:30:18 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id o81sm18858033pfa.156.2019.05.06.11.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 11:30:17 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] loop: Better discard for block devices
Date:   Mon,  6 May 2019 11:27:34 -0700
Message-Id: <20190506182736.21064-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.

The errors look like this:
[   90.880875] print_req_error: I/O error, dev loop5, sector 0

The errors occur when trying to do a discard or write zeroes operation
on a loop device backed by a block device that does not support write zeroes.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
zeroing capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does an fallocate operation on the
backing device. After this change, backing block devices that do support
zeroing will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support zeroing will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.


Changes in v5:
- Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)

Changes in v4:
- Mirror blkdev's write_zeroes into loopdev's discard_sectors.

Changes in v3:
- Updated tags
- Updated commit description

Changes in v2:
- Unnested error if statement (Bart)

Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 66 +++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 22 deletions(-)

-- 
2.20.1

