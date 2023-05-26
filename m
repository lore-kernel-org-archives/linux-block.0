Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7F6C77B73
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 23:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjEZXbf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEZXbe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 19:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD8B2
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 16:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D60D616FD
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 23:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A84BC433D2;
        Fri, 26 May 2023 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685143892;
        bh=xc3LhZkra+9FGSYDoc+GHxPWr5JhtsrjQc/12w3BuHg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=suJDZ0DQ07Ryn7Vi5kj6eDbV/smQt70p2512/H2BpyvubN6Z2xZg3qifGNzCebZUC
         YZPQfaP5gv1DC6ZKUhjOIvEjcgTjx4jLuW3kP3E/14fC5oijLEm+iFtNPp3U4DdZWU
         bVWtPP4Va4S7jl7UIKT8UmLjB1ZD6LgWj3SU94ldQDZ7FPV2pzcwkiqKNdjHRh1TVi
         stDLRHBOkRM+8RCbCQ7HWn+yWFTtu1xfw5Cp07tHFk3ui6qoMToIc/AMLPHImZIbr/
         sr1Q/l69y74xoHCKZjTPK4klOAdZSiQV3tp83+s8z78rJNhINyJWJSac4hPYzEUlpz
         S9/lXBhsBrkKw==
Message-ID: <b7c9d102-ff68-a8c6-c33d-9dd730a13c12@kernel.org>
Date:   Sat, 27 May 2023 08:31:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: block: significant performance regression in iSCSI rescan
To:     Brian Bunker <brian@purestorage.com>, linux-block@vger.kernel.org
References: <CAHZQxyKsym0E-GaV0cLQKH8GgO8X_4QR8WjiGghdjswhObLG0g@mail.gmail.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAHZQxyKsym0E-GaV0cLQKH8GgO8X_4QR8WjiGghdjswhObLG0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/23 00:48, Brian Bunker wrote:
> Hello,
> 
> One of our customers reported a significant regression in the
> performance of their iSCSI rescan when they upgraded their initiator
> Linux kernel:
> 
> https://forum.proxmox.com/threads/kernel-5-15-usr-bin-iscsiadm-mode-session-sid-x-rescan-really-slow.110113/
> 
> This was determined not to be an array side issue, but I chased the
> problem for him. The issue comes down to a patch:
> 
> commit 508aebb805277c541e94ee14daba4191ff02347e
> Author: Damien Le Moal <damien.lemoal@wdc.com>
> Date:   Wed Jan 27 20:47:32 2021
> 
>     block: introduce blk_queue_clear_zone_settings()
> 
> When I connect 255 volumes with 2 paths to each and run an iSCSI
> rescan there is a significant difference in the time it takes. The
> rescan of iscsiadm rescan is a parallel sequential scan of the 255
> volumes on both paths. It comes down to this for each device:
> 
> [root@init107-18 boot]# cd /sys/bus/scsi/devices/11\:0\:0\:1
> [root@init107-18 11:0:0:1]# echo 1 > rescan
> [root@init107-18 boot]# cd /sys/bus/scsi/devices/10\:0\:0\:1
> [root@init107-18 10:0:0:1]# echo 1 > rescan
> ...
> 
> (As 5.11.0-rc5+)
> Without this patch:
> Command being timed: "iscsiadm --mode session --rescan"
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.04
> 
> Just adding this patch on the previous:
> Command being timed: "iscsiadm --mode session --rescan"
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:13.45
> 
> In the most recent Linux kernel, 6.4.0-rc3+, the regression is not as
> pronounced but is still significant.
> 
> With:
> Command being timed: "iscsiadm --mode session --rescan"
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:04.84
> 
> Without:
> Command being timed: "iscsiadm --mode session --rescan"
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.53
> 
> With the second being only the result of:
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -953,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum
> blk_zoned_model model)
>                 blk_queue_zone_write_granularity(q,
>                                                 queue_logical_block_size(q));
>         } else {
> -               disk_clear_zone_settings(disk);
> +               /* disk_clear_zone_settings(disk); */
>         }
>  }
>  EXPORT_SYMBOL_GPL(disk_set_zoned);
> 
> From what I can tell this patch is trying to account for a change in
> zoned behavior moving to none. It looks like it is saying that there
> is no good way to tell between this moving to none and never reporting
> block zoned capabilities at all. The penalty on targets which don't
> support zoned capabilities at all seems pretty steep. Is there a
> better way to get what is needed here without affecting disks which
> are not zoned capable?
> 
> Let me know if you need any more details on this.

Can you try this and see if that restores rescan times for your system ?

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 896b4654ab00..4dd59059b788 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -915,6 +915,7 @@ static bool disk_has_partitions(struct gendisk *disk)
 void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
        struct request_queue *q = disk->queue;
+       unsigned int old_model = q->limits.zoned;

        switch (model) {
        case BLK_ZONED_HM:
@@ -952,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum
blk_zoned_model model)
                 */
                blk_queue_zone_write_granularity(q,
                                                queue_logical_block_size(q));
-       } else {
+       } else if (old_model != BLK_ZONED_NONE) {
                disk_clear_zone_settings(disk);
        }
 }


> 
> Thanks,
> Brian Bunker
> PURE Storage, Inc.

-- 
Damien Le Moal
Western Digital Research

