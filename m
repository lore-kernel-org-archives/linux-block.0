Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE7FC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBC22087C
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+8JngfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfBDOkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:40:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfBDOkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NfqWIsdgsC/PEqtnmUaPHPJkqEn46Ng2kyK530deiz4=; b=e+8JngfCwpTdEfvz8+GxdpD8I
        sQcQNiteZ4asg8h08kh91nXcbSMl1AUxqJ2IjpgwRzCZOVK4oMaVVOuyvFJ9AR4cvkzvwQjZsWf7u
        PEsZeO9UNTB8q/7hIxriOK6qRLPOIKLN+/KszdkX/aX2YyuJA+UQSoLzM3XbXkcje0ASk4lo57ZgL
        h7qaSlJlBlC2s7HULwk6vRl3ViXCbZOfhYsouWqJRtack9kSyRRwXeevf7vYzVo1JAl7kOSbGsygh
        hOtXmDmASXwvabH38iM6m6vv7dw/hTMYI7rqUEcZt8xmqU06nLu1D3UiVIzwh3853mak02Hr2kni1
        G160BpWFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfQO-00085O-Qj; Mon, 04 Feb 2019 14:40:40 +0000
Date:   Mon, 4 Feb 2019 06:40:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] bsg: allocate response buffer if requested
Message-ID: <20190204144040.GA23983@infradead.org>
References: <20190130094424.94255-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130094424.94255-1-hare@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 10:44:24AM +0100, Hannes Reinecke wrote:
> The 'response' buffer from bsg is mapped onto the SCSI sense buffer,
> however after commit 82ed4db499b8 we need to allocate them ourselves
> as the bsg queue is _not_ a SCSI queue, and hence the sense buffer
> won't be allocated from the scsi stack.

I don't think this is the full story.  Plain old bsg nodes are on SCSI
(or legacy IDE) request queues, so this should be initialized, and
your patch creates a memory leak by overwriting the sense pointer.

bsg-lib nodes aren't on scsi request queues, but they don't use the code
path your patch to start with.

What exactly is the reproducer for this problem? 
