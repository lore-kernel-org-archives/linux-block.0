Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF037C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BC020672
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 07:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="hT2pRGbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgGHH72 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHH71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 03:59:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49933C08C5DC
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 00:59:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n2so31839508edr.5
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y/mRE6lKrupeh64EK6hYhYjXO+H5alQ6a0YuJYC6SS8=;
        b=hT2pRGbqRu+uXvp0LAZvsalcw4ilY3TODQnlM/IExD9s/MGgN74eJDWn83G628TcR3
         3XxNB/cd36zz12GO9hmtBqXtHQtPkSoMLiDA7oeyZDEGxNfYup2pFtCiuNXoVAw5+tuq
         qckoLOKD1XePiimv8T72fL2+XCrqw2Hj3VC1r5GHc5VFNUBP97kFogyQQrv59UYeuSwk
         nnt3aQDenBUgv8KjqSN8uRxnlv7OihfMrmYDbrW0LCQRvae+C/W2N540x+lI3MzpD0KJ
         NGlfx4uamfPRMstpfRBY2+W7nnTQ4TBNavNsIxzDt/G0V0HIdgHU68k1UZcqbz91v+Y3
         sijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y/mRE6lKrupeh64EK6hYhYjXO+H5alQ6a0YuJYC6SS8=;
        b=iLaIdcRhE1WBBnsB5k14kDQklRGEhVrFLIkBzPWsgq5qG1ej+fR8d4mlxmpCrNdyzD
         GPGPpKszPPAWwZ3/uGMDU108GCwBamBFZ722dK4FYPEpNzF+T2mqDZY6ZQyMI9fXlToe
         MZBZo1LX75tRzJp02UH6bN+aDxREVGJi046df4E3Fp1A/OnDq9/eahNGIFRw6DPSHzFA
         0z3uNXoXibuQ5OXZkY2axU60gs62D0sl2Ai1yYr7Ztl5/0hybdpx8DcP0lguSvd3Hpkk
         ahtbfYRkc7n0zcsRyVAHvcb92g14CIyA7MAxE6lQs9G2r1l+xNdT+zIRQOUXIWb4hAlU
         02fw==
X-Gm-Message-State: AOAM532Z2a+tPir3SRzT+gzVIuVb5L0nrRkclVYZlk/z+uCVCWXLcQV0
        FpfHC3R+d9EUUuGPp9JqMYcooA==
X-Google-Smtp-Source: ABdhPJxyNlEJ61sBlcbPLvd92QRNbV/ZVVF5QBlb8RWg7Mh1DSNr7Tp1y7X2SOCA2hAEGd+1e9Q5Zw==
X-Received: by 2002:a05:6402:1c11:: with SMTP id ck17mr62525346edb.38.1594195165885;
        Wed, 08 Jul 2020 00:59:25 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b161:f409:fd1d:3a1f])
        by smtp.gmail.com with ESMTPSA id mj22sm1570858ejb.118.2020.07.08.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:59:25 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [RFC PATCH 0/4] block: add two statistic tables
Date:   Wed,  8 Jul 2020 09:58:14 +0200
Message-Id: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The patchset mostly introduces some additional io stats for latency and sector,
with those tables, we can know better about the io patttern. And we want the
disk_start_io_acct returns ns instead of convert from jiffies, so some code
in drbd are changed accordingly.

For the table, the first row of below tables means the number which are "<= 1",
while the last row means the number which are ">= 1024". And the rest rows in
the table represent the number in a range.

With HZ=1000.
$ cat /sys/block/md127/io_latency
     1 ms: 3 0 0 0     - means 3 read IOs are finished less than or equal 1 ms
     2 ms: 1 0 0 0     - means 1 read IO is finished in the range [2ms, 4ms)
     4 ms: 0 0 0 0
     8 ms: 0 0 0 0
    16 ms: 1 0 0 0
    32 ms: 0 0 0 0
    64 ms: 0 0 0 0
   128 ms: 0 0 0 0
   256 ms: 0 0 0 0
   512 ms: 0 0 0 0
  1024 ms: 1 0 0 0
  2048 ms: 1 0 0 0     - means 1 read IO is finished more than or equal 2048 ms

While with HZ=100.
$ cat /sys/block/md127/io_latency
     10 ms: 3 0 0 0
     20 ms: 1 0 0 0
     40 ms: 0 0 0 0
     80 ms: 0 0 0 0
    160 ms: 1 0 0 0
    320 ms: 0 0 0 0
    640 ms: 0 0 0 0
   1280 ms: 0 0 0 0
   2560 ms: 0 0 0 0
   5120 ms: 0 0 0 0
  10240 ms: 1 0 0 0
  20480 ms: 1 0 0 0


$ cat /sys/block/md127/io_size
     1 KB: 0 0 0 0
     2 KB: 0 0 0 0
     4 KB: 0 0 0 0
     8 KB: 5 0 0 0
    16 KB: 0 0 0 0
    32 KB: 0 0 0 0
    64 KB: 0 0 0 0
   128 KB: 0 0 0 0
   256 KB: 0 0 0 0
   512 KB: 0 0 0 0
  1024 KB: 0 0 0 0
  2048 KB: 0 0 0 0

I will add a document if it is worth to add the two tables, review and comment
are welcome.

Thanks,
Guoqing

Guoqing Jiang (5):
  block: return ns precision from disk_start_io_acct
  drbd: remove unused argument from drbd_request_prepare and
    __drbd_make_request
  drbd: rename start_jif to start_ns
  block: add a statistic table for io latency
  block: add a statistic table for io sector

 block/Kconfig                     |  9 +++++
 block/blk-core.c                  | 61 +++++++++++++++++++++++++++++--
 block/genhd.c                     | 47 ++++++++++++++++++++++++
 drivers/block/drbd/drbd_debugfs.c |  8 ++--
 drivers/block/drbd/drbd_int.h     |  4 +-
 drivers/block/drbd/drbd_main.c    |  3 +-
 drivers/block/drbd/drbd_req.c     | 15 +++-----
 include/linux/part_stat.h         |  8 ++++
 8 files changed, 135 insertions(+), 20 deletions(-)
