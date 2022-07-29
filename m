Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C764C00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 13:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiG2NWa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiG2NW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 09:22:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DED61B30
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 06:22:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6984068AA6; Fri, 29 Jul 2022 15:22:25 +0200 (CEST)
Date:   Fri, 29 Jul 2022 15:22:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        hch@lst.de, ming.lei@redhat.com
Subject: Re: [PATCH blktests] block/002: remove debugfs check while
 blktests is running
Message-ID: <20220729132225.GA28468@lst.de>
References: <20220729060411.162529-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729060411.162529-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 29, 2022 at 02:04:11PM +0800, Yi Zhang wrote:
> Seem commit: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_unregister_queue")

s/Seem/see/ ?

But yes, this should go in.  I thought I already submitted that, but
it seems like I didn't.
