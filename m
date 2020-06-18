Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3374CC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A8420773
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFROhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:37:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:39506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbgFROhV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:37:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA57BACF9;
        Thu, 18 Jun 2020 14:37:19 +0000 (UTC)
Date:   Thu, 18 Jun 2020 16:37:19 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 02/12] blk-mq: factor out a helper to reise the block
 softirq
Message-ID: <20200618143719.aakeh5ciazsg23gv@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-3-hch@lst.de>
 <20200618143404.ro2kviia72qy6niv@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618143404.ro2kviia72qy6niv@beryllium.lan>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 18, 2020 at 04:34:04PM +0200, Daniel Wagner wrote:
> Couldn't this be folded into the previous condition, e.g
> 
> 	if (ccpu == cpu || shared || raised_blk_irq(ccpu, req))

to answer my own question, patch #3 does addresses this :)
