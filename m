Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1BC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEA02084D
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXcyW7Qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeLPQaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:30:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeLPQaL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D2H1GSMozFs+gaYJ6wgcMq+9G6b+APx9+0U4Fyqo1qE=; b=rXcyW7QwiccD2IXs9cx5MMrqo
        7xTPVWHm8NTSnNtzw+EK8hCUJJ/HO2nACajTOSbcoA9/OYISPig2ODVHdTsJmYwjiL7Su9421pMDw
        tCZgy+QXtwR4+AiZe1RiPUAXW+znE2B13d0h4cg6GJNrZSSES3FZyjiNqRm4eqWm6Wr9zwzNxEDZU
        zsWN3P3ON+3lQFqRa0UbUrjkyAOVkeuytHKmmdZbyPN1+MUBodBW2PU3Y131gZ/NUqSy4RuugOUjB
        p/iPwtfS8ybQd00uNWniI7xRSpE5sux6aD1OVbSKIJfqOSL5Rr4lpqjykIg28qnAW8P0KqRPjRaZY
        tKPDin4EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gYZIw-0007F2-Dm; Sun, 16 Dec 2018 16:30:10 +0000
Date:   Sun, 16 Dec 2018 08:30:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     yupeng <yupeng0921@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2 1/2] share nvme trace event helper functions with
 multiple nvme modules
Message-ID: <20181216163010.GA21285@infradead.org>
References: <20181216014849.8584-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216014849.8584-1-yupeng0921@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 15, 2018 at 05:48:48PM -0800, yupeng wrote:
> The trace.c could only be used by core.c, move it to a header file and
> then other nvme modules could also use it. This commit creates a new
> header file trace_common.h, which has all the functions of trace.c. It
> changes all functions to static functions, so any other modules could
> include it without conflict. This commit also moves some common
> functions from trace.h to trace_common.h. Because the trace events in
> trace.h are used by nvme-core only, this commit renames the trace.h to
> trace_core.h.

We could always export bits out of trace.o using EXPORT_SYMBOL_GPL,
no need to move duplicate the code.  Also as far as I can tell you
only use __assign_disk_name of the helpers, so we can move that into
a new helper.  It might make sense to just move that into
include/linux/genhd.h to make it easily available everywhere.

