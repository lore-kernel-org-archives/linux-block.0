Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE831C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbiDLKMM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357624AbiDLJtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 05:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4AA5FDB
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649753797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j7aa2KPswai7rBoDebyO9Bw5wc8qwjLb/iLNbPIABxU=;
        b=BxAmGP8a2mORzGTVKsKWJJqbn+U3z/L/DGUTvlYyTGD5ELoBT36CEbNUVoHAsv50Ju/rEL
        ibRVA1la2Tqp8XQgkLb20DLN2aZJvhmpvJ1ENtgd4x5H+wChWPsyQJX/wctxZr4VCmBvTr
        xEhnxzn4gA1ogRk0+6gzHq5KPJaBHpc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-n4YCSgP2NK671DwK8MCxCw-1; Tue, 12 Apr 2022 04:56:34 -0400
X-MC-Unique: n4YCSgP2NK671DwK8MCxCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E564101AA42;
        Tue, 12 Apr 2022 08:56:34 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68A58145BA42;
        Tue, 12 Apr 2022 08:56:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/8] dm: io accounting & polling improvement 
Date:   Tue, 12 Apr 2022 16:56:08 +0800
Message-Id: <20220412085616.1409626-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

The 1st patch adds bdev based io accounting interface.

The 2nd ~ 5th patches improves dm's io accounting & split, meantime
fixes kernel panic on dm-zone.

The other patches improves io polling & dm io reference handling.


Ming Lei (8):
  block: replace disk based account with bdev's
  dm: don't pass bio to __dm_start_io_acct and dm_end_io_acct
  dm: pass 'dm_io' instance to dm_io_acct directly
  dm: switch to bdev based io accounting interface
  dm: always setup ->orig_bio in alloc_io
  dm: don't grab target io reference in dm_zone_map_bio
  dm: improve target io referencing
  dm: put all polled io into one single list

 block/blk-core.c              |  15 +--
 drivers/block/zram/zram_drv.c |   5 +-
 drivers/md/dm-core.h          |  17 ++-
 drivers/md/dm-zone.c          |  10 --
 drivers/md/dm.c               | 190 +++++++++++++++++++---------------
 include/linux/blkdev.h        |   7 +-
 6 files changed, 131 insertions(+), 113 deletions(-)

-- 
2.31.1

