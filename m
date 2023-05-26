Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59443C7EE23
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 15:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEZPsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjEZPso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 11:48:44 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DB0F3
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 08:48:42 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1967cd396a1so768939fac.0
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1685116121; x=1687708121;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VQ6d2o1496Vh/qHKObDUZZhsgC+lOnpZw6K/bd3XsK4=;
        b=A6eeClgAqrr74SOmNyjYd9YDisvmL+Ly+VIWgvQ/RK9fBmwIAJbMXh3dNMLuQOwi3B
         OH4fQ9MHRYZI3uBblqAQJyIqVdQi5zF9XybzqD+nGojcuyy1XiUUjxn11cbNj78AlGbq
         qKhDz+iRdWxcJhks9HmOumBZOS5re+BLeGhCmrMjVls3UJtAR5wC9CRpklacPLOIf37J
         tte5HJuXBj92AvplnuzkhoNL0Mklx6AdI2/DRukqfrCZj82NYazpB0E2v1lqu03nngH0
         feXOMHgGoX3ayqOTgFeVYWx5CPDZYm4i91eReGGVsGiCTcX8vpdJn+Qv+MIFRe7b0CfK
         MfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116121; x=1687708121;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQ6d2o1496Vh/qHKObDUZZhsgC+lOnpZw6K/bd3XsK4=;
        b=hNkXFNafHCqahlZII1D53y0XoAsleks5GmIM5clLXOD8diFCTxVA8dtcHoRQtdS0AU
         gQQjhTzYO25Q3fBWpxokILvkWUrXER6cfWYoTARU/TxEjRr39jDrfOVK4/mkIU+fK4/e
         FBuDTesc75mAlnAkpOApHIP3rxtf6QzKdEmulB97bY9+uhiZxxQYPQ0pkWimMpQbwqc+
         kWOftdV0oPj8oaXIAftn0mVmNwTA5Ni0dx3ea9CecUPL8nNAtGqzfY6RbuBeDhmnISag
         zJIV0uhvYxzhCzqLVio9fovaprOg+V8g9Z/cjjyYFcl+y9xEoW0/i0H1eVVTwaZEYdxD
         PzUA==
X-Gm-Message-State: AC+VfDxnS/9jK5rGndiXAbmVz41BU+KU2gP4cR8jjgCDTmw2Rmc4a8PY
        lzBZYaznnKCaCC8gmcIXvGyqSgv12IUgaRH4QQHDTJ98v0kmczGuqb0=
X-Google-Smtp-Source: ACHHUZ6yz+fx7vqZ8AIvrjWjL3vvOsMtXzMF/R2pxIbgyif2OI9xytsFLBjHlaJCxlYiCpOwLFAhtPZSjqVDFpz5vxk=
X-Received: by 2002:a05:6870:135a:b0:177:a5e2:442e with SMTP id
 26-20020a056870135a00b00177a5e2442emr1067449oac.43.1685116120729; Fri, 26 May
 2023 08:48:40 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Bunker <brian@purestorage.com>
Date:   Fri, 26 May 2023 08:48:29 -0700
Message-ID: <CAHZQxyKsym0E-GaV0cLQKH8GgO8X_4QR8WjiGghdjswhObLG0g@mail.gmail.com>
Subject: block: significant performance regression in iSCSI rescan
To:     linux-block@vger.kernel.org
Cc:     damien.lemoal@wdc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

One of our customers reported a significant regression in the
performance of their iSCSI rescan when they upgraded their initiator
Linux kernel:

https://forum.proxmox.com/threads/kernel-5-15-usr-bin-iscsiadm-mode-session-sid-x-rescan-really-slow.110113/

This was determined not to be an array side issue, but I chased the
problem for him. The issue comes down to a patch:

commit 508aebb805277c541e94ee14daba4191ff02347e
Author: Damien Le Moal <damien.lemoal@wdc.com>
Date:   Wed Jan 27 20:47:32 2021

    block: introduce blk_queue_clear_zone_settings()

When I connect 255 volumes with 2 paths to each and run an iSCSI
rescan there is a significant difference in the time it takes. The
rescan of iscsiadm rescan is a parallel sequential scan of the 255
volumes on both paths. It comes down to this for each device:

[root@init107-18 boot]# cd /sys/bus/scsi/devices/11\:0\:0\:1
[root@init107-18 11:0:0:1]# echo 1 > rescan
[root@init107-18 boot]# cd /sys/bus/scsi/devices/10\:0\:0\:1
[root@init107-18 10:0:0:1]# echo 1 > rescan
...

(As 5.11.0-rc5+)
Without this patch:
Command being timed: "iscsiadm --mode session --rescan"
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.04

Just adding this patch on the previous:
Command being timed: "iscsiadm --mode session --rescan"
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:13.45

In the most recent Linux kernel, 6.4.0-rc3+, the regression is not as
pronounced but is still significant.

With:
Command being timed: "iscsiadm --mode session --rescan"
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:04.84

Without:
Command being timed: "iscsiadm --mode session --rescan"
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.53

With the second being only the result of:
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -953,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum
blk_zoned_model model)
                blk_queue_zone_write_granularity(q,
                                                queue_logical_block_size(q));
        } else {
-               disk_clear_zone_settings(disk);
+               /* disk_clear_zone_settings(disk); */
        }
 }
 EXPORT_SYMBOL_GPL(disk_set_zoned);

From what I can tell this patch is trying to account for a change in
zoned behavior moving to none. It looks like it is saying that there
is no good way to tell between this moving to none and never reporting
block zoned capabilities at all. The penalty on targets which don't
support zoned capabilities at all seems pretty steep. Is there a
better way to get what is needed here without affecting disks which
are not zoned capable?

Let me know if you need any more details on this.

Thanks,
Brian Bunker
PURE Storage, Inc.
