Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13784C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D612E61931
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 15:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCVPbY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhCVPbE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 11:31:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5526861984;
        Mon, 22 Mar 2021 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616427064;
        bh=zK5KKi4ATr3SmNmxLp2wyzhdt5icF3UWhPn8KlBQl/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqJJnLrGTbKUp5bBsjDtKRY8LZtCMl+gjyDUCDvSH92FowEtQTQeRqWkDl+xNNuKF
         35qmMs/1A0BYa9MZ5yiXeJCp+d/Dk0LvGcDlF9nLML9mUhEQfQilN6/6LB1o5dEPpV
         hQKuXFJHEWSXfNzT5JbNzL+Xw0x0zrhsKtuBVViOdm8jKXLYiWK4orhsjmHajlCBVy
         pXr4jzV9/iO5MGGgyLQCFFA010gqghiLgBGV5HKFWTOeeAL1behlRN+jmlvi+jX47U
         ADKWzeoLZc/CVJveUccAWtA3Z5q49PjuL4VRpdJeVhr5YeY5jheZXARV46fH2lYP5i
         3AYaJTzz+08TA==
Date:   Tue, 23 Mar 2021 00:31:01 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210322153101.GB17311@redsun51.ssa.fujisawa.hgst.com>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322073726.788347-3-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 22, 2021 at 08:37:26AM +0100, Christoph Hellwig wrote:
> When we reset/teardown a controller, we must freeze and quiesce the
> namespaces request queues to make sure that we safely stop inflight I/O
> submissions. Freeze is mandatory because if our hctx map changed between
> reconnects, blk_mq_update_nr_hw_queues will immediately attempt to freeze
> the queue, and if it still has pending submissions (that are still
> quiesced) it will hang.
> 
> However, by freezing the namespaces request queues, and only unfreezing
> them when we successfully reconnect, inflight submissions that are
> running concurrently can now block grabbing the nshead srcu until either
> we successfully reconnect or ctrl_loss_tmo expired (or the user
> explicitly disconnected).
> 
> This caused a deadlock when a different controller (different path on the
> same subsystem) became live (i.e. optimized/non-optimized). This is
> because nvme_mpath_set_live needs to synchronize the nshead srcu before
> requeueing I/O in order to make sure that current_path is visible to
> future (re-)submisions. However the srcu lock is taken by a blocked
> submission on a frozen request queue, and we have a deadlock.
> 
> In order to fix this use the blk_mq_submit_bio_direct API to submit the
> bio to the low-level driver, which does not block on the queue free
> but instead allows nvme-multipath to pick another path or queue up the
> bio.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
