Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31FC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAE120672
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAE120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeK0Dzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:55:54 -0500
Received: from verein.lst.de ([213.95.11.211]:53224 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbeK0Dzy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:55:54 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A301F68BF4; Mon, 26 Nov 2018 18:01:11 +0100 (CET)
Date:   Mon, 26 Nov 2018 18:01:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv4 3/3] blk-mq: Simplify request completion state
Message-ID: <20181126170111.GC11848@lst.de>
References: <20181126165430.4519-1-keith.busch@intel.com> <20181126165430.4519-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126165430.4519-4-keith.busch@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:54:30AM -0700, Keith Busch wrote:
> There are no more users relying on blk-mq request states to prevent
> double completions, so replace the relatively expensive cmpxchg operation
> with WRITE_ONCE.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
