Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41AC43613
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F3F2083B
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="xoGo+FQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFUNH5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:07:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38496 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfFUNHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 09:07:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so5899184ljg.5
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jWa7576rgWVWVSW1745Pn4vugUiYSLxuS7AWMaM+/FQ=;
        b=xoGo+FQp2vZ187gQdSdRprVD4vxPNYjUDtjPAO1IyXa/EuR7uCdQ7DeWaCegKic8As
         isyBoOKpuAuyPKr/2f0AwghYVFts14ArUpmou9WS/9QbyGw6Rf4PQLqF46ydseXryIWF
         JeLm1NkpF4CHvMAlmrNZTAkfkSDvVQe/a7SjPGxUB7eALo4cHbEpWB7G4VdV5qcqry5C
         kfFTS3P81Gy4tv5S+pui7Dz7b7kN0m8pzJlTYVJ5GslUWJyYL8ZRkBVsB6CSahpFg0Z8
         ONGD7t/P4r7+wITdLeBhui0WmxCDiOORu2kzfLfluN6+7PliYReUASKxUO/DrbSNj6Ln
         CHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jWa7576rgWVWVSW1745Pn4vugUiYSLxuS7AWMaM+/FQ=;
        b=R43v9Ld5tedc7ookj/9W7uL12V4TAZq8i2IejxS1tjMMUCCs6RFWkjoCc8UO9rJa1E
         3izzZPwhb0CMi6a+KGksjVgFIi/QCBLbrehykjyM0ef+BY3pSB2rWGZL/K4+Le3dr9es
         TzV6aGxrGdFyXHpV6t3zd3fXRynlr1weP9rBjSS39XeI2eG5y0pIJKixYDdwqtzRMlnc
         umOhBu6/ak5mOiqW9I3W1v/QnKuxaSiSwhBJMGQ6XyWi0dVZcZu0Av+/SGYKK226XEeN
         W/nh+0bXL7wrjITt5zcUoVAX9bjdqCRCHQ9FgLwMPjlqZMbeLCps0HZde4573VSq5yxQ
         ZqYA==
X-Gm-Message-State: APjAAAX3X9rrPpn4xQAYB5XnTGALtyg82hBZLZiZ1HGqvIHJ1yUDqnGd
        YNhIVmyUJrvYfoAgp4Pd2lAsRA==
X-Google-Smtp-Source: APXvYqzUnlkSIRvoWfskQmErTHxIyFPWo4CsYqd4wu3b2Zwd0KoJS6WozUgI1ufyf4P3BJmOuYo4mA==
X-Received: by 2002:a2e:96d0:: with SMTP id d16mr62786423ljj.14.1561122448747;
        Fri, 21 Jun 2019 06:07:28 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r2sm387100lfi.51.2019.06.21.06.07.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:07:27 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 0/4] open, close, finish zone support
Date:   Fri, 21 Jun 2019 15:07:07 +0200
Message-Id: <20190621130711.21986-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch serie adds support for explicit control of zone transitions.

To test it, one can use an updated blkzone version that is available
here:

  https://github.com/MatiasBjorling/util-linux.git zonemgmt

blkzone can be compiled with:

  ./autogen.sh
  ./configure
  make blkzone

After that, the binary is available in the compile directory.

Regards,
Matias

Ajay Joshi (4):
  block: add zone open, close and finish support
  null_blk: add zone open, close, and finish support
  scsi: sd_zbc: add zone open, close, and finish support
  dm: add zone open, close and finish support

 block/blk-core.c               |  3 ++
 block/blk-zoned.c              | 51 +++++++++++++++++++++---------
 block/ioctl.c                  |  5 ++-
 drivers/block/null_blk.h       |  4 +--
 drivers/block/null_blk_main.c  | 13 ++++++--
 drivers/block/null_blk_zoned.c | 33 ++++++++++++++++++--
 drivers/md/dm-flakey.c         |  7 ++---
 drivers/md/dm-linear.c         |  2 +-
 drivers/md/dm.c                |  5 +--
 drivers/scsi/sd.c              | 15 ++++++++-
 drivers/scsi/sd.h              |  6 ++--
 drivers/scsi/sd_zbc.c          | 18 ++++++++---
 include/linux/blk_types.h      | 35 +++++++++++++++++++--
 include/linux/blkdev.h         | 57 +++++++++++++++++++++++++++++-----
 include/uapi/linux/blkzoned.h  | 17 ++++++++--
 15 files changed, 221 insertions(+), 50 deletions(-)

-- 
2.19.1

