Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA7AC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 05:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C06A2173E
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 05:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEUFLj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 01:11:39 -0400
Received: from verein.lst.de ([213.95.11.211]:57303 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfEUFLj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 01:11:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2704668B05; Tue, 21 May 2019 07:11:18 +0200 (CEST)
Date:   Tue, 21 May 2019 07:11:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fix nr_phys_segments vs iterators accounting v2
Message-ID: <20190521051117.GB29120@lst.de>
References: <20190516084058.20678-1-hch@lst.de> <20190520111714.GA5369@lst.de> <8ccb3744-53e3-71b0-cdec-6f703b2bd5c8@fb.com> <20190521011700.GC14268@ming.t460p> <a5a08ee7-5bbf-3285-5f02-4f6544770340@kernel.dk> <20190521012935.GE14268@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521012935.GE14268@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 09:29:36AM +0800, Ming Lei wrote:
> I am fine with this route, and just try to make the commit log not
> misleading.

I'll resend with the updated tags.  And I'll also look into the whole
recalc segments vs discard issue later, as we might have more dragons
hidden there.
