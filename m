Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB5C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2920727
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 12:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEPMmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 08:42:17 -0400
Received: from verein.lst.de ([213.95.11.211]:60438 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPMmR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 08:42:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFD2468B05; Sat, 16 May 2020 14:42:15 +0200 (CEST)
Date:   Sat, 16 May 2020 14:42:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 2/5] bio.h: Declare the arguments of bio iteration
 functions const
Message-ID: <20200516124215.GB13544@lst.de>
References: <20200516001914.17138-1-bvanassche@acm.org> <20200516001914.17138-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516001914.17138-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 05:19:11PM -0700, Bart Van Assche wrote:
> This change makes it possible to pass 'const struct bio *' arguments to
> these functions.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
