Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E53C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 06:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbiFOGBu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiFOGBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:01:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4B4A936
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:01:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77E3C68C4E; Wed, 15 Jun 2022 08:01:42 +0200 (CEST)
Date:   Wed, 15 Jun 2022 08:01:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-mq: protect q->elevator by ->sysfs_lock
Message-ID: <20220615060140.GC22115@lst.de>
References: <20220615023712.750122-1-ming.lei@redhat.com> <20220615023712.750122-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615023712.750122-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 10:37:10AM +0800, Ming Lei wrote:
> elevator can be tore down by sysfs switch interface or disk release, so
> hold ->sysfs_lock before referring to q->elevator, then potential
> use-after-free can be avoided.

The subject probably should really talk about blk_mq_elv_switch_none
as we generally already protect ->elevator with ->sysfs_lock.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
