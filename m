Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:55954 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdJCQK2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 12:10:28 -0400
Received: by mail-qt0-f176.google.com with SMTP id x54so13847201qth.12
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 09:10:27 -0700 (PDT)
From: lee.tibbert@gmail.com
To: linux-block@vger.kernel.org
Cc: lucmiccio@gmail.com, paolo.valente@linaro.org,
        lee.tibbert@gmail.com
Subject: Re: [PATCH] block,bfq: Disable writeback throttling
Date: Tue,  3 Oct 2017 12:10:18 -0400
Message-Id: <20171003161018.18039-1-lee.tibbert@gmail.com>
In-Reply-To: <20170913100356.3649-1-lucmiccio@gmail.com>
References: <20170913100356.3649-1-lucmiccio@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Luca,

Please feel free to add:

  Tested-by: Lee Tibbert <lee.tibbert@gmail.com>

The short story is that, with one small commenting issue, the patch is
fine on my system.  The small issue is that block/blk-wbt.c line 657 says:

    Disable wbt, if enabled by default. Only called from CFQ.

As of this patch, that comment is no longer true.  Adding "& BFQ" is
the obvious edit, but simply deleting the "Only" sentence is probably
more robust. IMHO, that should not hold up acceptence of this patch.

Longer story:

      In addition to running this for almost three weeks now, I explicitly
      tested a number of paths CONFIG_BLK_WBT enabled &
      disabled, etc. Details upon request.

      In particular, I tested that when CONFIG_BLK_WBT is enabled
      sys/block/sda/queue/wbt_lat_usec is cleared when the elevator
      is set to BFQ(BFQ-MQ). Patch does what it purports.

      I also tested that wbt_lat_usec gets set back to its default when
      an elevator other than BFQ is selected after BFQ is active. (Yeah,
      the new elevator probably does this. There is no code in BFQ to do it).

      This patch makes it easier to get write back settings right when using
      cgroups.  With cgroup, on wants  CONFIG_BLK_DEV_THROTTLING on
      but CONFIG_BLK_WBT off. This patch painlessly assures the latter
      and reduces, at least my, confusion.

Thank you for this patch. I hope that it is accepted for linux-block in
as time allows.

Lee
