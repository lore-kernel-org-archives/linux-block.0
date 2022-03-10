Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC71C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 08:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiCJIeI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiCJIeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 03:34:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC995BE58;
        Thu, 10 Mar 2022 00:33:07 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE4AE68AFE; Thu, 10 Mar 2022 09:33:03 +0100 (CET)
Date:   Thu, 10 Mar 2022 09:33:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sbates@raithlin.com, logang@deltatee.com, pankydev8@gmail.com,
        javier@javigon.com, mcgrof@kernel.org, a.manzanares@samsung.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 09/17] io_uring: plug for async bypass
Message-ID: <20220310083303.GC26614@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com> <CGME20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13@epcas5p3.samsung.com> <20220308152105.309618-10-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-10-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 08:50:57PM +0530, Kanchan Joshi wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Enable .plug for uring-cmd.

This should go into the patch adding the
IORING_OP_URING_CMD/IORING_OP_URING_CMD_FIXED.
