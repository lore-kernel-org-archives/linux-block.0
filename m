Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4321360C40
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhJLSdS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhJLSdN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:33:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A83960C40;
        Tue, 12 Oct 2021 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634063469;
        bh=EDq4Rbqxilv+AMad6PFM+cG85mVNoUldSVSt0M4YzYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhRvxwq+bX4ADMH+j2lFXIA0jwCS2VVLMo3ogKNgdco9urRw+fDBCcvGhreGqbpsN
         l3FFltt+Re2j/XGSzhBmXDieRclY1yhtGLhH54pPEkbaT87JndV+E8jSbfbSJbb+FB
         0jjLWoCD8FZnfsBx+xlraq8z6jELObHE3gs5c9BYnYUui8Bfcsu9HzZLCavwpXO2us
         0io4ZTP+ptn051GdeEphbSgQhmahj+mI9UawLIgcO18XkKWyJaRoompBWwoBpZkdyg
         JkI9cAZzgADqtLv3uG3zxDjoev0H1nz25TYf2ri32b0LK5gzIpuQMBnNWK9UV9+HIz
         m2E/fstcSocMQ==
Date:   Tue, 12 Oct 2021 11:31:07 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
Message-ID: <20211012183107.GA636540@dhcp-10-100-145-180.wdc.com>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 12:13:52PM -0600, Jens Axboe wrote:
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
> Retain the full clear for the other commands to avoid doing any audits
> there, and just clear the fields in the rw command manually that we
> don't already fill.

Oo, we knew about this optimization *years* ago, yet didn't do anything
about it! Better late than never.

  http://lists.infradead.org/pipermail/linux-nvme/2014-May/000837.html

Acked-by: Keith Busch <kbusch@kernel.org>
