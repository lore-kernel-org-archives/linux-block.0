Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20154C43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiGUPPE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGUPPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 11:15:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50D7B359
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 08:15:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C152668AFE; Thu, 21 Jul 2022 17:14:58 +0200 (CEST)
Date:   Thu, 21 Jul 2022 17:14:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: ublk vs write cache and FUA
Message-ID: <20220721151458.GA4399@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

ublk implements REQ_OP_FLUSH and REQ_FUA, but will never see those as
it never calls blk_queue_write_cache.  Can we drop the code?  Or should
there be a flag to enable write cache and fua support when setting up
a device?
