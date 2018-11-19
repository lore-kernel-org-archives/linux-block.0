Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6129C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3FA20871
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gyx+YdPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3FA20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKSSyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:54:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeKSSyY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fLu1AogadY3/ACVAJukUFJ+G0t9bKg9MdURz1jyZl84=; b=gyx+YdPxzoXojHwlCrKo4WdY7
        jZ6yAoYjWsqb6kLIk8sj/0yTt3DwWj4odWXEYA/sA727hOXoEaVsIk9EjsbWl0zxfHd/w5P5Gh7fL
        vFNEU03Foive1E2n19fgzIbcBubvhJNMMjA81smYau40U8LynODSrKHp1y/QZ1N0GcBs6B7tABzhh
        1DB5PRdqE1C/W/pycNMzkhQO5HdGH4nXod/YxbcXDWxWTvkp1nIhAaYnNbgvYYwItcseH3qFz3Ly+
        g/hL5FWeFx7MvQgmhlRU05UhaLn8lTzaqYlidSkLE0cRIqGSty8TeSQA4DzcDzM2FDy6JlqPBHQEv
        SVGIFkb7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOext-00082w-BG; Mon, 19 Nov 2018 08:31:29 +0000
Date:   Mon, 19 Nov 2018 00:31:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 1/3] blk-mq: Return true if request was completed
Message-ID: <20181119083129.GA29626@infradead.org>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115175820.13391-2-keith.busch@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 10:58:18AM -0700, Keith Busch wrote:
> A driver may have internal state to cleanup if we're pretending a request
> didn't complete. Return 'false' if the command wasn't actually completed
> due to the timeout error injection, and true otherwise.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
