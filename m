Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DCC64EC4
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 00:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCAAdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCAAdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2023 19:33:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB1E1B546
        for <linux-block@vger.kernel.org>; Tue, 28 Feb 2023 16:33:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6980BB80E95
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 00:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74411C433D2;
        Wed,  1 Mar 2023 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677630815;
        bh=KWUAqyIrOElZsVBm+ETmF1cPnvpIy+hSd243sU7e2sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XW8thIcD3xIJyqGzTFDzDPISto/GJjiYFUOPfztBFYu3/ctwW2Z7jPXBIXLkSnYLP
         ol/EAl3APiSl6lfblsybLLq2cYJDvEw0UJj6JQ+zEKOzs8QzfrMvKN53J0oHozl3We
         stmf5saxK/EpE5sXTfgYotLilR0bqUGUyiUP6ANu/2aqUBLCeJcwGxttOmxvsNYQm3
         4rDXUdPOJX7LnnMIsEhYv/jcvsKZYv/n02uL2pmQPyn6K5x4DFtPD3sUsywcgXNQLM
         x9JIIigEMSOAk7yUuPnb1+cmRmqrEHWIKhLKIc0h7ORMUT92dPMsXDpVMTyqGiSFwo
         xzDNMQsfpvMOw==
Date:   Tue, 28 Feb 2023 17:33:31 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <Y/6dW8rVx9LktlW6@kbusch-mbp.dhcp.thefacebook.com>
References: <20230301000655.48112-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301000655.48112-1-ushankar@purestorage.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 28, 2023 at 05:06:55PM -0700, Uday Shankar wrote:
> The block layer might merge together discard requests up until the
> max_discard_segments limit is hit, but blk_insert_cloned_request checks
> the segment count against max_segments regardless of the req op. This
> can result in errors like the following when discards are issued through
> a DM device and max_discard_segments exceeds max_segments for the queue
> of the chosen underlying device.
> 
> blk_insert_cloned_request: over max segments limit. (256 > 129)
> 
> Fix this by looking at the req_op and enforcing the appropriate segment
> limit - max_discard_segments for REQ_OP_DISCARDs and max_segments for
> everything else.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
