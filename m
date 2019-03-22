Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B5C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB19218A5
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 14:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCVOBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:01:45 -0400
Received: from verein.lst.de ([213.95.11.211]:43237 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbfCVOBp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 10:01:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F079968C4E; Fri, 22 Mar 2019 15:01:35 +0100 (CET)
Date:   Fri, 22 Mar 2019 15:01:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/3] block: bio: kill BIO_SEG_VALID flag
Message-ID: <20190322140135.GA17767@lst.de>
References: <20190322131346.20169-1-jthumshirn@suse.de> <20190322131346.20169-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322131346.20169-2-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (bio->bi_phys_segments == -1)
> +		bio->bi_phys_segments = 1;
> +	else
> +		bio->bi_phys_segments++;

Minor nitpickm but I'd kust write this as:

	if (bio->bi_phys_segments == -1)
		bio->bi_phys_segments = 0;
	bio->bi_phys_segments++;

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
