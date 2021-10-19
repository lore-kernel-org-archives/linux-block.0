Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50632C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B91D6136F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhJSSbi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhJSSbi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 14:31:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1BE161260;
        Tue, 19 Oct 2021 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634668165;
        bh=RJcjF4vbYkWMfd19YVnbQrHB1lVc8DOfglA1A1idFsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAWjllgqex0oeLJ5DtSux3SVBAYksfdl4YOaE4svsg1qTegW2TuM61Kv/V+nN6Qkj
         bTSQrfhXDq/0O/vT/V88c0glqP9W/DS0JmNPvYU1svvq1siOv10X8cLyWE7YdI4ufV
         QzMwsIQt7i2iQMvmPT7eOSNE00T4JflYXDl9RRdxn+0gG0gcOFdFfwuI5Ot2YR0KN1
         KIN2EWmhCJV1KfXleSw1H2cPTt8GMXIca3IgTZk6x+SIfKo7RrBrqBYBXO+1Q0/3Nb
         RBHLZM3dR8sg2VOJ9PS8NIkWoVsmS8U0vEdqnQuTaUCQ4wKr/F8FPi1QltenheqggQ
         6XhZXenv4o+CQ==
Date:   Tue, 19 Oct 2021 11:29:22 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: don't memset() the normal read/write command
Message-ID: <20211019182922.GC2083665@dhcp-10-100-145-180.wdc.com>
References: <20211018124934.235658-1-axboe@kernel.dk>
 <20211018124934.235658-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018124934.235658-3-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 06:49:34AM -0600, Jens Axboe wrote:
> This memset in the fast path costs a lot of cycles on my setup. Here's a
> top-of-profile of doing ~6.7M IOPS:
> 
> +    5.90%  io_uring  [nvme]            [k] nvme_queue_rq
> +    5.32%  io_uring  [nvme_core]       [k] nvme_setup_cmd
> +    5.17%  io_uring  [kernel.vmlinux]  [k] io_submit_sqes
> +    4.97%  io_uring  [kernel.vmlinux]  [k] blkdev_direct_IO
> 
> and a perf diff with this patch:
> 
>      0.92%     +4.40%  [nvme_core]       [k] nvme_setup_cmd
> 
> reducing it from 5.3% to only 0.9%. This takes it from the 2nd most
> cycle consumer to something that's mostly irrelevant.
> 
> Acked-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
