Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F4EC10F14
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 11:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3549208C3
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 11:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfJJLHk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:07:40 -0400
Received: from verein.lst.de ([213.95.11.211]:57595 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbfJJLHj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 07:07:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF6F768C65; Thu, 10 Oct 2019 13:07:35 +0200 (CEST)
Date:   Thu, 10 Oct 2019 13:07:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 08/12] nvmet-tcp: don't check data_len in
 nvmet_tcp_map_data()
Message-ID: <20191010110735.GA28392@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com> <20191009192530.13079-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-10-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 09, 2019 at 01:25:26PM -0600, Logan Gunthorpe wrote:
> With passthru, the data_len is no longer guaranteed to be set
> for all requests. Therefore, we should not check for it to be
> non-zero. Instead check if the SGL length is zero and map
> when appropriate.
> 
> None of the other transports check data_len which is verified
> in core code.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

I think the issue here is deeper.  Yes, this patch is correct, but
nvmet-tcp has another use of req.data_len in
nvmet_tcp_handle_req_failure, which looks completely bogus.  Please
try to audit that as well and send out fixes to the list separately
from this series, as both look like potentially serious bugs.
