Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95637C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3EF208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SiDeWISm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3EF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKPSq7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:46:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeKPSq7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OUeR5Pftb5hvb+FndG9cp3nNEB/qTQUJFzQelIYGc0Y=; b=SiDeWISmK9QmYyVBbfM29vz5S
        LXXm143n6xkSKltCwRrRg8FxGjlLKusP0UErEzWKLnZmq+veuGc3KS5b6txgQVzJPZ97jHDdVgx9a
        EPGu3sMsd1/CcxN5oYg+e8a+vKiTkX3NpkAnSB4a4c5IDpOPdXJvmigWCvAgNuQxVdYE02wFYuyUT
        z4O+6oCn2gDs5NTko48c1hlRxHkuyRnS6dbsoE5VrvIDrWylkSCWqq+xRIQA5gn2E4ibrwv30VSky
        9qeNZh3TvNpci/ys84Mz3P/LNKSM/khtYVemWlEU6I7e35g6GrPk2TBMvAUAxuuDFGPobt2eD59ho
        oSsH2zRoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZbH-0003up-Az; Fri, 16 Nov 2018 08:35:39 +0000
Date:   Fri, 16 Nov 2018 00:35:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 01/11] nvme: provide optimized poll function for separate
 poll queues
Message-ID: <20181116083539.GC9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115195135.22812-2-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:51:25PM -0700, Jens Axboe wrote:
> If we have separate poll queues, we know that they aren't using
> interrupts. Hence we don't need to disable interrupts around
> finding completions.
> 
> Provide a separate set of blk_mq_ops for such devices.

This looks ok, but I'd prefer if we could offer to just support
polling with the separate queue.  That way we get ourselves out of
all kinds of potential races of the interrupt path vs poll path.
