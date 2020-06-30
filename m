Return-Path: <SRS0=9ToN=AL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC9C433E0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8DF206C0
	for <linux-block@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iG0R4dk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgF3NkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733186AbgF3NkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 09:40:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D452C061755
        for <linux-block@vger.kernel.org>; Tue, 30 Jun 2020 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=iG0R4dk6VkG9orUc0mWlwSgmL4
        AGuadD73ZrWGgA34BRL5mWTi2OAizKRy5Rx6oPeSXIFD/OoosJmpwNMisYMCYqTundtelzAA2xeq2
        1/GNBvbKk+Wr8CoRE8TU8a4yrc5d/dgzIZGI4IM20Py2/o+yFai2lUArll084X0g/9I9jzOztHn/k
        LtHLURGt52iBa9aPU6krisV1qyfrisVPs+gGA87RsSoRc5btk4iYKIfw4QMJTOE1Mpiw4Fd815Dpe
        Tmalu1N2YuY7zQMsh8posjhRxEapVHAqL56LMEFkkTGf6qhPCJDiIpj2f7+gDD/BnyI2BmO6CldY7
        rjRnyjRQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqGUm-00080Z-Gc; Tue, 30 Jun 2020 13:40:20 +0000
Date:   Tue, 30 Jun 2020 14:40:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V7 6/6] blk-mq: support batching dispatch in case of io
Message-ID: <20200630134020.GB30397@infradead.org>
References: <20200630102501.2238972-1-ming.lei@redhat.com>
 <20200630102501.2238972-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630102501.2238972-7-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
