Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D2DC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F16321670
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 13:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfFZNSF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:18:05 -0400
Received: from verein.lst.de ([213.95.11.211]:43120 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfFZNSF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:18:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C60EF68B05; Wed, 26 Jun 2019 15:17:33 +0200 (CEST)
Date:   Wed, 26 Jun 2019 15:17:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190626131733.GA5363@lst.de>
References: <20190626065438.19307-1-damien.lemoal@wdc.com> <20190626065438.19307-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626065438.19307-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is still missing the proper vmalloc flushing and invalidation.

We can't leave that to the callers as is very subtle and trivial
to get wrong, as shown by your couple of previous attempts.
