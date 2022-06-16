Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA25C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 06:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358633AbiFPGPH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 02:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiFPGPG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 02:15:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32A736170
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 23:15:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0DD3D68AA6; Thu, 16 Jun 2022 08:15:01 +0200 (CEST)
Date:   Thu, 16 Jun 2022 08:15:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V3 2/3] blk-mq: avoid to touch q->elevator without any
 protection
Message-ID: <20220616061500.GA5144@lst.de>
References: <20220616014401.817001-1-ming.lei@redhat.com> <20220616014401.817001-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616014401.817001-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 16, 2022 at 09:44:00AM +0800, Ming Lei wrote:
> q->elevator is referred in blk_mq_has_sqsched() without any protection,
> no .q_usage_counter is held, no queue srcu and rcu read lock is held,
> so potential use-after-free may be triggered.
> 
> Fix the issue by adding one queue flag for checking if the elevator
> uses single queue style dispatch. Meantime the elevator feature flag
> of ELEVATOR_F_MQ_AWARE isn't needed any more.

I think clearing in common code would be safer, but this does work
as-is, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
