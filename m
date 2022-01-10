Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E768C433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 16:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiAJQtQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 11:49:16 -0500
Received: from verein.lst.de ([213.95.11.211]:39348 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237755AbiAJQtN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 11:49:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECC2D68BFE; Mon, 10 Jan 2022 17:49:09 +0100 (CET)
Date:   Mon, 10 Jan 2022 17:49:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: don't protect submit_bio_checks by
 q_usage_counter
Message-ID: <20220110164909.GA7372@lst.de>
References: <20220104134223.590803-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104134223.590803-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 04, 2022 at 09:42:23PM +0800, Ming Lei wrote:
> Commit cc9c884dd7f4 ("block: call submit_bio_checks under q_usage_counter")
> uses q_usage_counter to protect submit_bio_checks for avoiding IO after
> disk is deleted by del_gendisk().
> 
> Turns out the protection isn't necessary, because once
> blk_mq_freeze_queue_wait() in del_gendisk() returns:
> 
> 1) all in-flight IO has been done

Only for blk-mq drivers.

So I don't think this is actually safe.

Sorry for the late reply, last week was still holiday time here.

