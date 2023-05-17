Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF4C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEQHXp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEQHXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:23:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85794109;
        Wed, 17 May 2023 00:23:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6BDC468C4E; Wed, 17 May 2023 09:23:14 +0200 (CEST)
Date:   Wed, 17 May 2023 09:23:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, axboe@kernel.dk, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, joshi.k@samsung.com
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Message-ID: <20230517072314.GC27026@lst.de>
References: <cover.1684154817.git.asml.silence@gmail.com> <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 15, 2023 at 01:54:43PM +0100, Pavel Begunkov wrote:
> Use IOU_F_TWQ_LAZY_WAKE via iou_cmd_exec_in_task_lazy() for passthrough
> commands completion. It further delays the execution of task_work for
> DEFER_TASKRUN until there are enough of task_work items queued to meet
> the waiting criteria, which reduces the number of wake ups we issue.

Why wouldn't you just do that unconditionally for
io_uring_cmd_complete_in_task?

