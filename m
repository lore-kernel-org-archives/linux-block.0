Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F810C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2D221907
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 20:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I/qIQQnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBGU5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:57:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38843 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfBGU5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 15:57:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so529584plb.5
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 12:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xawq7z+PV/ZeUtaPhAzsAhOVrlvuexv6AC5ScinQK0A=;
        b=I/qIQQnjRV9FFCrMc7YME6bXm0jctteW4Ua54tUdFY1I/kwK9q6Z13N77e32dDxQl4
         WoH4nzd9kv7WYPomUK04WbKYBmF21X9i1LtpjVRhYoVdMS8kPySxv+QZ2We1MsdMAeeK
         kfYyoLb/PvSO3Z4NPGNYHv82L1hAdG6GCRbWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xawq7z+PV/ZeUtaPhAzsAhOVrlvuexv6AC5ScinQK0A=;
        b=V4OTzpNy62qL8l0kytB3HDAAGLZ7IbPHcQs9qC+MWAKvdVkllSSJ3j/vFeS1ZRXS+I
         VlO6gFDqJDnrhWKKkVL3uIaJvpRKjic12sDKvgKPixsg9SbsoFL1Hh2AsQ8UooU6sl/r
         c1Ix8sZ0ueZjUjPwsYCnwq24WKOGi9OMnaznB70WGSGW4AEj8NqMGVKS5wXvAvUXDq6k
         agRkhwA9iF2E7ZYF/5odq4PZxevvmUX2P+Pqxm6i373o5c/MHk6fDJsIQtRIUpER8vyk
         YhyW6LxCrhZ3jKSzWkJHWFS8J/cDaXKy7pMvjpyoGpsFVL0joGk5xqAfciGFGeblnxV5
         095Q==
X-Gm-Message-State: AHQUAuYUjKu6zPH/8p5HUs0l4gKuH5Z40Wb80QGuiqXOYChrG7mHLIsF
        2sZk2VPN/vDq0vA2hDwkT2E9qRMmsNg=
X-Google-Smtp-Source: AHgI3IYrkOimqveRulGTCpIkCCpDlDv9UFrr3WKuXnb8tZfu1DRmCUxwjG2qzBFsIs4Nhao3tPADbQ==
X-Received: by 2002:a17:902:bd86:: with SMTP id q6mr18189270pls.16.1549573065734;
        Thu, 07 Feb 2019 12:57:45 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id y9sm27199pfi.74.2019.02.07.12.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 12:57:44 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] loop: Better discard for block devices
Date:   Thu,  7 Feb 2019 12:57:27 -0800
Message-Id: <20190207205730.199332-1-evgreen@chromium.org>
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
on a loop device backed by a block device that does not support discard.
Firstly, the error itself is incorrectly reported as I/O error, but is
actually EOPNOTSUPP. The first patch plumbs out EOPNOTSUPP to properly
report the error.

The second patch prevents these errors from occurring by mirroring the
discard capabilities of the underlying block device into the loop device.
Before this change, discard was always reported as being supported, and
the loop device simply turns around and does a discard operation on the
backing device. After this change, backing block devices that do support
discard will continue to work as before, and continue to get all the
benefits of doing that. Backing devices that do not support discard will
fail earlier, avoiding hitting the loop device at all and ultimately
avoiding this error in the logs.

I can also confirm that this fixes test block/003 in the blktests, when
running blktests on a loop device backed by a block device.


Changes in v2:
- Unnested error if statement (Bart)

Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 70 ++++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 22 deletions(-)

-- 
2.20.1

