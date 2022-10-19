Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A27C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 07:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJSHam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJSHaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 03:30:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128075F204
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:30:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 72A9F68C4E; Wed, 19 Oct 2022 09:30:35 +0200 (CEST)
Date:   Wed, 19 Oct 2022 09:30:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: blk_mq_quiesce_queue in del_gendisk
Message-ID: <20221019073035.GB11606@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Based on the per-tagset srcu for quiesce discusion I've been wondering
why we need the queue quiesce around elevator_exit and rq_qos_exit in
del_gendisk.  At the point where we call it, we've stopped new fs
I/O submissions, and the queue is frozen.  What does the quiesce still
protect against, and if anything can we come up with a cheaper way to
do that?
