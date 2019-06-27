Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EF3C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B002082F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0I2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:28:31 -0400
Received: from verein.lst.de ([213.95.11.211]:50592 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0I2b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:28:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6922A68B20; Thu, 27 Jun 2019 10:27:59 +0200 (CEST)
Date:   Thu, 27 Jun 2019 10:27:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/9] block: optionally mark pages dirty in
 bio_release_pages
Message-ID: <20190627082759.GC11043@lst.de>
References: <20190626134928.7988-1-hch@lst.de> <20190626134928.7988-3-hch@lst.de> <20190626205247.GH4934@minwooim-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626205247.GH4934@minwooim-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 05:52:47AM +0900, Minwoo Im wrote:
> Could you please explain a bit why we should not make it dirty in case
> of compound page?

PageCompount is only true for the tail pages, and marking them dirty
doesn't work.  On the other hand marking the head page dirty covers
the whole compount, so we are fine.
