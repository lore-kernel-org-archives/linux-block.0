Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD167C433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8636518A
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 18:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCHSac (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhCHSaS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Mar 2021 13:30:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 508406516B;
        Mon,  8 Mar 2021 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615228217;
        bh=QYiEvbFt5dw8REaN3BLt64OmJG/lfRjLtOk1Z/NPefU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFzcDFt2QI4ri/lx0t3BPgxuukpiuzg6Dekcu+D5w3DDldUivtKpTCCk/nKdbhwJV
         gAtlU9H0PfcTwS0mHDjwrIucWkvtBw9ZQdnk1eXxf9zM2iWejZ0JwoiJvOVb8RC0Qr
         YOvu7HEqK+gm+5tuwIjtMe6k3qFOtLhna6kZIfOWxsIP4w3CJjObM43MwVxzm97r66
         Z0RJMSBckkP22T2LUisyr5/5M5m3vh0nO6+Dg6XDwigWE/9RddD+1yFWkYjT8zgy+x
         eeyEh8w1tjgLZa3fKSRvWBodMniw5plkfHnM68x7vUd6VTOBhoRmLRPNmgNO0a9OvT
         YBroAHEd8c6IA==
Date:   Tue, 9 Mar 2021 03:30:11 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: Discard page cache of zone reset target range
Message-ID: <20210308183011.GA18341@redsun51.ssa.fujisawa.hgst.com>
References: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308033232.448200-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 08, 2021 at 12:32:32PM +0900, Shin'ichiro Kawasaki wrote:
> When zone reset ioctl and data read race for a same zone on zoned block
> devices, the data read leaves stale page cache even though the zone
> reset ioctl zero clears all the zone data on the device. To avoid
> non-zero data read from the stale page cache after zone reset, discard
> page cache of reset target zones. In same manner as fallocate, call the
> function truncate_bdev_range() in blkdev_zone_mgmt_ioctl() before and
> after zone reset to ensure the page cache discarded.
> 
> This patch can be applied back to the stable kernel version v5.10.y.
> Rework is needed for older stable kernels.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 3ed05a987e0f ("blk-zoned: implement ioctls")
> Cc: <stable@vger.kernel.org> # 5.10+

This looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
