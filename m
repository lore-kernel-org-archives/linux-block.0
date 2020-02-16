Return-Path: <SRS0=IDql=4E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE74C2BA83
	for <linux-block@archiver.kernel.org>; Sun, 16 Feb 2020 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1272086A
	for <linux-block@archiver.kernel.org>; Sun, 16 Feb 2020 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d+sCg2C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgBPRFe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Feb 2020 12:05:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39532 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBPRFe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Feb 2020 12:05:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so5762351plp.6
        for <linux-block@vger.kernel.org>; Sun, 16 Feb 2020 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1wblhQ0F68iiM2c0m/hr6TtOKn6RpxPFT13cYvSOlTY=;
        b=d+sCg2C9v8jg3GNQcr/hcptBv4GvXxzNEv4lBCWHGzr4Sy2raZYJpgME9+g5pV4bOm
         BAC7l7TTo/SqyzDvOcDhCOz3TPVoh7e/kRM2WHpYPaop41jGUbeCkvCfcHUIJX2gWAqI
         vVVXN7qnpyCd9IZMFWDevc3HkmlEsk/0K4k/3ehv8+PB8iTv6Vp4wgX+Av4ntbvr//+R
         P+60oHigC7Q8nznPizwTh6gHRNJrqdJ88OgPBJOQ4FEJ4+FbiG3smKozINUuFSMowv6V
         fouC+oXUUIWICOTmW7NjuBGdBEXElNdpbqNKxLxXlmXIp8620J0rjl+1WCtAgUhs02oM
         rODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1wblhQ0F68iiM2c0m/hr6TtOKn6RpxPFT13cYvSOlTY=;
        b=EGjETPVIzyM6tk/ikQnY+Dp6P5NWR//62/H5wviA4IaKdLOUeHESs7lXHj1MpBu1Gq
         1oBJztzaoAkX8PTP+yTFzqo1vY2g1fgAunf/8CB0EjAa6zH4L2bNumxY6D7Nl3sQHiEq
         FmVFQzHgBhv4yR615zGyLeh6ZWa4hjuSnVZM9MTuWFfezbcBmA/UMgSXGjLplIqQKF2e
         mAJp61U/SFM8hNSXqAJfZdHiLeT9mupO4q5wRHOKSheAgjj/SPH5oy4kxB65VIiB4SVR
         SKInWM8IXAnyS7nk1YtRrsrHG99ls9LY0FAcQEPLetIkKtid3iApsknHwWlgrNgkeRiM
         pqdg==
X-Gm-Message-State: APjAAAXaggcO0Y5529RRAIiEJFxGk2pkHTp0OEaPoxMcwH4O5ta4ie/4
        346l/FfMTJyek8XeDe4elDrwAO4gHxo=
X-Google-Smtp-Source: APXvYqwT5I6lMSNNt7fg3XPwOq+/bid3MfBPcDhuL/afvzMqHWHzh7Rq3htDMYJB6xuBK19u2SfAOg==
X-Received: by 2002:a17:902:8a8d:: with SMTP id p13mr12227950plo.159.1581872731818;
        Sun, 16 Feb 2020 09:05:31 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:b1fd:20cc:c368:304b? ([2605:e000:100e:8c61:b1fd:20cc:c368:304b])
        by smtp.gmail.com with ESMTPSA id b42sm13687205pjc.27.2020.02.16.09.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 09:05:31 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.6-rc2
Message-ID: <7f2de313-552e-e3d0-9b33-faf09bc65b57@kernel.dk>
Date:   Sun, 16 Feb 2020 09:05:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Not a lot here, which is great, basically just three small bcache fixes
from Coly, and four NVMe fixes via Keith.

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.6-2020-02-16


----------------------------------------------------------------
Anton Eidelman (1):
      nvme/tcp: fix bug on double requeue when send fails

Coly Li (3):
      bcache: ignore pending signals when creating gc and allocator thread
      bcache: Revert "bcache: shrink btree node cache after bch_btree_check()"
      bcache: remove macro nr_to_fifo_front()

Keith Busch (1):
      nvme/pci: move cqe check after device shutdown

Nigel Kirkland (1):
      nvme: prevent warning triggered by nvme_stop_keep_alive

Yi Zhang (1):
      nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info

 drivers/md/bcache/alloc.c   | 18 ++++++++++++++++--
 drivers/md/bcache/btree.c   | 13 +++++++++++++
 drivers/md/bcache/journal.c |  7 ++-----
 drivers/md/bcache/super.c   | 17 -----------------
 drivers/nvme/host/core.c    | 12 ++++++------
 drivers/nvme/host/pci.c     | 23 ++++++++++++++++++-----
 drivers/nvme/host/rdma.c    |  2 +-
 drivers/nvme/host/tcp.c     |  9 +++++++--
 8 files changed, 63 insertions(+), 38 deletions(-)

-- 
Jens Axboe

