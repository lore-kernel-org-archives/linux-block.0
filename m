Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217FC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EF520672
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EF520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeK0DzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:55:10 -0500
Received: from verein.lst.de ([213.95.11.211]:53209 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0DzJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:55:09 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 21C0268BF4; Mon, 26 Nov 2018 18:00:27 +0100 (CET)
Date:   Mon, 26 Nov 2018 18:00:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv4 1/3] blk-mq: Return true if request was completed
Message-ID: <20181126170027.GA11848@lst.de>
References: <20181126165430.4519-1-keith.busch@intel.com> <20181126165430.4519-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126165430.4519-2-keith.busch@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:54:28AM -0700, Keith Busch wrote:
> A driver may have internal state to cleanup if we're pretending a request
> didn't complete. Return 'false' if the command wasn't actually completed
> due to the timeout error injection, and true otherwise.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
