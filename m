Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8263CEE8012
	for <linux-block@archiver.kernel.org>; Fri,  8 Sep 2023 15:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjIHPI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Sep 2023 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIHPI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2023 11:08:59 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBD1BFA
        for <linux-block@vger.kernel.org>; Fri,  8 Sep 2023 08:08:55 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bc57401cb9so266301a34.0
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2023 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694185735; x=1694790535; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPBD1phaXUOgmfmtBF3vDEZdPaFHOju+Jc1jYF2AHO4=;
        b=bMT89By2cLUEauHROWmVHdhn1/n/LEJjfBNbfLmxY7/pkYSEZLYrSvznh+TbRUQOUD
         DKgyoAg2U6OSRw83UgtfWaGAvEX0CBF3u0IMejfsvUSHqjL09KgioqksrxCj4RIsjLqi
         Lhe32rT7ysNb4Jnw6zObgAjRUCnX1cDzOfwySTAF3jPBUHy+KS55eoiKEgZIu/+nV/Uq
         j4aO6rh7EJPAKlR3iegnWp01YrH+snS2BF38+YHFlFinKVL/8wpaJctVZoyRcnp2Wo4u
         yq8xFUOBDeegM1wM6E7NRrXrWaRfPEo2JOHITBiVgvHi2K0/3UxNOUFQnhwnzuIC7hlL
         clFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185735; x=1694790535;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RPBD1phaXUOgmfmtBF3vDEZdPaFHOju+Jc1jYF2AHO4=;
        b=RRCWI2jJewou598QiZDKDqAkZnrQkiKnAi5A5RAD+b8P9vWB0TZgLxqa/zHhKeC69n
         Bf3XxEjN5cN8zqOB0sXgjXqPVPQCstvTb2kMCglJJt3Ta5k7Ly6zrBJDEjbjKBg6j4xd
         dySZN0p/hdez6VNUyK+WR1KM/Ko6vMXxUbAnYnKiDhTPlGLty9SSDccxNHsmAE12zOwy
         E009Vdtck3cZ+aK9KVEjYFRNJpATdn3UVliiFHlmxhTCvk9JS2Gj+c3rh9xOkFEthWkS
         LJaIHZt27ZXyFmENW9ljA8Yu1PmPvGmpG4sYdcDFrzYwnAHSrbspMZ+a9+jE+A2KkYsu
         stqg==
X-Gm-Message-State: AOJu0YxtY8Y0s080Q4r6dRytyQayDdD0+IRLiz/knK6wOprPKp9TnKDn
        dfJXKRqdFqt5pTPCKiomRuEv2Uj3OdyGFBkrYVIUZw==
X-Google-Smtp-Source: AGHT+IFpG6nQAieaM+F+ye9HDlPP1oA4qn9/WfapesDOcCLCSUJ9kky6Sxzi2dWhg4HajASClTtxZA==
X-Received: by 2002:a05:6870:a447:b0:1d0:f5bd:6c8 with SMTP id n7-20020a056870a44700b001d0f5bd06c8mr2902165oal.5.1694185734838;
        Fri, 08 Sep 2023 08:08:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k25-20020a02c779000000b00428737ce527sm514168jao.63.2023.09.08.08.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:08:53 -0700 (PDT)
Message-ID: <4cb29a92-f386-4ab1-b7c7-56aef11e35f2@kernel.dk>
Date:   Fri, 8 Sep 2023 09:08:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.6-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Some fixes for block that should go into the 6.6-rc1 merge window:

- Fix null_blk polled IO timeout handling (Chengming)

- Regression fix for swapped arguments in drbd bvec_set_page()
  (Christoph)

- String length handling fix for s390 dasd (Heiko)

- Fixes for blk-throttle accounting (Yu)

- Fix page pinning issue for same page segments (Christoph)

- Remove redundant file_remove_privs() call (Christoph)

- Fix a regression in partition handling for devices not supporting
  partitions (Li)

Please pull!


The following changes since commit 6c1b980a7e79e55e951b4b2c47eefebc75071209:

  Merge tag 'dma-mapping-6.6-2023-08-29' of git://git.infradead.org/users/hch/dma-mapping (2023-08-29 20:32:10 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.6-2023-09-08

for you to fetch changes up to 4b9c2edaf7282d60e069551b4b28abc2932cd3e3:

  drbd: swap bvec_set_page len and offset (2023-09-06 07:33:03 -0600)

----------------------------------------------------------------
block-6.6-2023-09-08

----------------------------------------------------------------
Chengming Zhou (1):
      null_blk: fix poll request timeout handling

Christoph Böhmwalder (1):
      drbd: swap bvec_set_page len and offset

Christoph Hellwig (2):
      block: remove the call to file_remove_privs in blkdev_write_iter
      block: fix pin count management when merging same-page segments

Heiko Carstens (1):
      s390/dasd: fix string length handling

Li Lingfeng (1):
      block: don't add or resize partition on the disk with GENHD_FL_NO_PART

Yu Kuai (4):
      blk-throttle: print signed value 'carryover_bytes/ios' for user
      blk-throttle: fix wrong comparation while 'carryover_ios/bytes' is negative
      blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
      blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()

 block/blk-map.c                  |   7 ++-
 block/blk-throttle.c             | 112 +++++++++++++++++++--------------------
 block/blk-throttle.h             |   4 +-
 block/fops.c                     |   4 --
 block/ioctl.c                    |   2 +
 drivers/block/drbd/drbd_main.c   |   2 +-
 drivers/block/null_blk/main.c    |  12 ++++-
 drivers/s390/block/dasd_devmap.c |   6 +--
 drivers/s390/block/dasd_eckd.c   |  10 ++--
 drivers/s390/block/dasd_int.h    |   4 ++
 10 files changed, 84 insertions(+), 79 deletions(-)

-- 
Jens Axboe

