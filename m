Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44095C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 08:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiFTI4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiFTI4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 04:56:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B556477
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 01:56:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3563268AA6; Mon, 20 Jun 2022 10:56:47 +0200 (CEST)
Date:   Mon, 20 Jun 2022 10:56:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/6] block: remove blk_cleanup_disk
Message-ID: <20220620085647.GA13464@lst.de>
References: <20220619060552.1850436-1-hch@lst.de> <20220619060552.1850436-7-hch@lst.de> <25329ddf-73d1-70e9-cd2f-372309e509ba@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25329ddf-73d1-70e9-cd2f-372309e509ba@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 10:49:06AM +0200, Hannes Reinecke wrote:
> I wish we could have blktests for tearing down device-drivers; doing a 
> regression test here will be really hard.

The problem with a remove is that while we have a generic device remove
attribute, it:

 a) isn't always in the same place relatively to the disk
 b) once removed we have no generic way to add the device back for
    further testing

nvme/032 has basic remove testing for nvme, and I think I can also
wire up my scsi bind/unbind testing for blktests using scsi_debug without
too much effort.  But that still isn't exactly a generic test.
