Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA91ECAAD8
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 07:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiITHaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiITHaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:30:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574B34A12B
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xP6wHOSqYkKgdix4oCYoyflMlNZZ5QOHevLlURoQl2s=; b=ZmDrpAzKvizZF932Gn75TSxhbd
        mJ5YugZMLE4IkNXXEo8ctleIxx11qGvDv0r6qRD53mQeHOnDUGb0taaFA4+VMUGz9FZapmzSinQCW
        lRzyrN1Rs1QygVjhSaBf27P1NXNbmbosaKN50O7Biz22rWcjfnFrBVZbZsdbB8Y6bImYS03jOf3SM
        9vnAIKbTe77xe8BdEPMZotuQqazLSv/GNCTmR0dMOJg6ebiO2a07ND/k8TBPI+O5aNBNo35fE33e3
        s2U90/mRi/UoMrGyXOomsb96xsU/gHGrdttzz91g2aXZekwhsUb1TIgcBtlPb4V8RSnHDmt3oT7jZ
        o4SJNnBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXhe-001MrK-OL; Tue, 20 Sep 2022 07:29:58 +0000
Date:   Tue, 20 Sep 2022 00:29:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 4/4] brd: implement secure erase and write zeroes
Message-ID: <Yylr9g6B7Px6xBXb@infradead.org>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209160500190.543@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209160500190.543@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 16, 2022 at 05:00:46AM -0400, Mikulas Patocka wrote:
> This patch implements REQ_OP_SECURE_ERASE and REQ_OP_WRITE_ZEROES on brd.
> Write zeroes will free the pages just like discard, but the difference is
> that it writes zeroes to the preceding and following page if the range is
> not aligned on page boundary. Secure erase is just like write zeroes,
> except that it clears the page content before freeing the page.

What is the use case of this?  And just a single overwrite is not what
storage standards would consider a secure erase, but then again we
don't really have any documentation or standards for the Linux OP,
which strongly suggests not actually implementing it for now.
