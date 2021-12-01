Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B13EC433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Dec 2021 07:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbhLAHbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Dec 2021 02:31:05 -0500
Received: from verein.lst.de ([213.95.11.211]:33848 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347523AbhLAHa0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Dec 2021 02:30:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5D5B68B05; Wed,  1 Dec 2021 08:27:02 +0100 (CET)
Date:   Wed, 1 Dec 2021 08:27:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6/7] block: cleanup ioc_clear_queue
Message-ID: <20211201072702.GB31765@lst.de>
References: <20211130124636.2505904-1-hch@lst.de> <20211130124636.2505904-7-hch@lst.de> <20211130172613.GL7174@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130172613.GL7174@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 30, 2021 at 06:26:13PM +0100, Jan Kara wrote:
> I'm not quite sure about dropping the rcu protection here. This function
> generally runs without any protection so what guards us against icq being
> freed just after we've got its pointer from the list?

How does the RCU protection scheme work for the icq lookups?
ioc_lookup_icq takes it and then drops it before getting any kind
of refcount, so this all looks weird.  But I guess you are right that
I should probably keep this cargo culted scheme unless I have an
actual plan on how this could work.

While we're at it:  I don't see how put put_io_context could
be called under q->queue_lock and thus actually need the whole
workqueue scheme.  Then again we really need to do an audit on
queue_lock and split it into actually documented locks now that the
old request code is gone.
