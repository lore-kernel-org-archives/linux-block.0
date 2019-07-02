Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAACC06510
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA22206E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 13:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGBN0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:26:14 -0400
Received: from verein.lst.de ([213.95.11.211]:42596 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBN0O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 09:26:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 101BA68C4E; Tue,  2 Jul 2019 15:26:13 +0200 (CEST)
Date:   Tue, 2 Jul 2019 15:26:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 2/2] blk-mq: Simplify blk_mq_make_request()
Message-ID: <20190702132612.GC15798@lst.de>
References: <20190701154730.203795-1-bvanassche@acm.org> <20190701154730.203795-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701154730.203795-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 01, 2019 at 08:47:30AM -0700, Bart Van Assche wrote:
> Move the blk_mq_bio_to_request() call in front of the if-statement.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
