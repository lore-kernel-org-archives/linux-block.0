Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C36C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D30060FC3
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJRJVl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:21:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93EC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=achr/bZlF9OYVBWOlH3XkqS3xa
        j3Dxvu3Gdj4cPMRragYdfFWXMlPiW8dpGtmTualQiGjZfxPbq0+Gh03lIU84TgCnDyJ81tAq13OPW
        xFm4LUzSBaN+0y5oT2MIGW3quyEH0zwhh+3YnB1sPTlCpvn8Vwa0+yWX64KD3Dsucn4V8qTFm49OH
        RWagG9ufjjCV9IZG1JjZ84mAE37ffKu8NuJWIkINYX9gBfd2aHgsAn8874AEJYF9AKhu8Xgovi+QL
        I1gjOZdtIZBGoJWwPbFSc7Pl7y1xuYs/iqJFCcI4jGg4Ou8r3BnZLGxFU22Tbl4hpFm1jY2lzcqUe
        kSS+HrNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOnq-00EmfT-Aq; Mon, 18 Oct 2021 09:19:30 +0000
Date:   Mon, 18 Oct 2021 02:19:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] block: improve layout of struct request
Message-ID: <YW08ImNNZrZHGKxe@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-9-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-9-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
