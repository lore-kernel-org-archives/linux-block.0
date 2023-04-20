Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9EC77B76
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 12:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjDTMcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDTMcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 08:32:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F37A8F;
        Thu, 20 Apr 2023 05:31:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7BF2B68AFE; Thu, 20 Apr 2023 14:31:39 +0200 (CEST)
Date:   Thu, 20 Apr 2023 14:31:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, asml.silence@gmail.com,
        axboe@kernel.dk, leit@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, kbusch@kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <20230420123139.GA32030@lst.de>
References: <20230419102930.2979231-1-leitao@debian.org> <20230419102930.2979231-2-leitao@debian.org> <20230420045712.GA4239@lst.de> <ZEEwHk32Y8IcT20n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEEwHk32Y8IcT20n@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 20, 2023 at 05:29:18AM -0700, Breno Leitao wrote:
> > > -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> > > +	if (req->ctx->flags & IORING_SETUP_SQE128)
> > > +		size <<= 1;
> > 
> > 
> > Why does this stop using uring_cmd_pdu_size()?
> 
> Before, only the cmd payload (sqe->cmd) was being copied to the async
> structure. We are copying over the whole sqe now, since we can use SQE
> fields inside the ioctl callbacks (instead of only cmd fields). So, the
> copy now is 64 bytes for single SQE or 128 for double SQEs.

That's the point of this series and I get it.  But why do we remove
the nice and self-documenting helper that returns once or twice
the sizeof of the SQE structure and instead add a magic open coded
left shift?
