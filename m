Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8036EC43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 06:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiFOGul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiFOGuj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:50:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6979646663
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:50:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CFD0467373; Wed, 15 Jun 2022 08:50:34 +0200 (CEST)
Date:   Wed, 15 Jun 2022 08:50:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2 2/3] blk-mq: avoid to touch q->elevator without any
 protection
Message-ID: <20220615065034.GA23449@lst.de>
References: <20220615064826.773067-1-ming.lei@redhat.com> <20220615064826.773067-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615064826.773067-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 02:48:25PM +0800, Ming Lei wrote:
> q->elevator is referred in blk_mq_has_sqsched() without any protection,
> no .q_usage_counter is held, no queue srcu and rcu read lock is held,
> so potential use-after-free may be triggered.
> 
> Fix the issue by adding one queue flag for checking if the elevator
> uses single queue style dispatch. Meantime the elevator feature flag
> of ELEVATOR_F_MQ_AWARE isn't needed any more.

We still need to clear the flag when switching elevators.
