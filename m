Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED41C433EF
	for <linux-block@archiver.kernel.org>; Mon, 11 Jul 2022 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGKLE1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiGKLEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 07:04:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7618BA3B7
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 03:11:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 02B7468AA6; Mon, 11 Jul 2022 12:10:57 +0200 (CEST)
Date:   Mon, 11 Jul 2022 12:10:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: don't create hctx debugfs dir until
 q->debugfs_dir is created
Message-ID: <20220711101056.GA4639@lst.de>
References: <20220711090808.259682-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711090808.259682-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
