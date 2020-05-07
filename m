Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF65C38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC5D20838
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 06:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GPdgl2HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgEGGLA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 02:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGGLA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 02:11:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93369C061A0F
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=GPdgl2HHXZy32q1bPH+6SbcQpl
        mqFTKHHGuZNNFQsrfk4v1c8FHTEp4LSu/wTmyf6WBiPJPDMjh9ONWKPyPM8COmSXnaHaq/3QnknOo
        +lDxt4IKcMgs3Sq75p/MoIgJ1eUYQ1lfYxD3I5Re17hjjaiNxLaMzzYFAKe8lq/w0osMNOuJ92PZl
        k3EumgS8br/0+X2CcP+OZ4ksdAAXbKaOwmnqjz81YBXhYmq/9I+YRd+kz3DkWOjS89+954idSWqGU
        kNOms/P3dYexPGSs3Ga61axmzTCevgXhAoUQO3FxyqpsWS2HraO9QqDoP2JsdAZ/ihYx65zotwwnO
        06VbhCfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWZkI-0001xV-Js; Thu, 07 May 2020 06:10:58 +0000
Date:   Wed, 6 May 2020 23:10:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 1/5] block: free both rq_map and request
Message-ID: <20200507061058.GA23530@infradead.org>
References: <cover.1588660550.git.zhangweiping@didiglobal.com>
 <b679d39aff2fc337e68f1e5f8c519b36a880b138.1588660550.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b679d39aff2fc337e68f1e5f8c519b36a880b138.1588660550.git.zhangweiping@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
