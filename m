Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A88C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53B4610FC
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 15:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDZPRk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZPRj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 11:17:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DD1461041;
        Mon, 26 Apr 2021 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619450218;
        bh=4Yn/mfaMho0PcS/JLVj/WsgPQuu9nCREYLZ2ygXW6O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbVZTrTNhL09YE/4lCwX4x2zMYhd9XUyckYInILKLTgZvP/J6EtehWLcvi5dZbaRM
         Pt04Ofq1bxFtAftxBbSIPhVrihewKtOQ05mgcoOfKJSJ0HvcGzNxK46J7IN8ztYNvt
         ct9DIRntDt6hqiu1w0Ec5FsrPmdafONeA6TcaXjEMyj/LzrG30IMnBOBmpm8RmNFFd
         cfTxMFEtGU9s/jkaLXgO2re2jrMXdPFQvFjpcH9nGojnl5/QMBct4jORXlc2ATn8DA
         uE3EGAPZLVqn7VLSs6CGKsSmfWsbvxN/EbxCIKIjHn50yenGqRssEAcITkri+vXgXB
         YOYTWgq1B9ZOg==
Date:   Tue, 27 Apr 2021 00:16:55 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     taochiu <taochiu@synology.com>
Cc:     hch@lst.de, chaitanya.kulkarni@wdc.com, axboe@fb.com,
        sagi@grimberg.me, james.smart@broadcom.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Cody Wong <codywong@synology.com>,
        Leon Chien <leonchien@synology.com>
Subject: Re: [PATCH v2 1/2] nvme-core: Move nvmf queue ready check routines
 to core
Message-ID: <20210426151655.GC12593@redsun51.ssa.fujisawa.hgst.com>
References: <20210426025310.3005573-1-taochiu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426025310.3005573-1-taochiu@synology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 10:53:10AM +0800, taochiu wrote:
> From: Tao Chiu <taochiu@synology.com>
> 
> queue_rq() in pci only checks if the dispatched queue (nvmeq) is ready,
> e.g. not being suspended. Since nvme_alloc_admin_tags() in reset flow
> restarts the admin queue, users are able to submit admin commands to a
> controller before reset_work() completes. Commands submitted under this
> condition may interfere with commands that performs identify, IO queue
> setup in reset_work(), and may result in a hang described in the
> following patch.
> 
> As seen in the fabrics, user commands are prevented from being executed
> under inproper controller states. We may reuse this logic to maintain a
> clear admin queue during reset_work().
> 
> Signed-off-by: Tao Chiu <taochiu@synology.com>
> Signed-off-by: Cody Wong <codywong@synology.com>
> Reviewed-by: Leon Chien <leonchien@synology.com>

The series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
