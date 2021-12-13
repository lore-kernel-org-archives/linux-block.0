Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A931BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhLMQwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhLMQwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 11:52:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDBCC061574
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 08:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=basdbiDCjY8+sZwfZy0ALKTSZo
        xXQRj1UQszKheFlty2bU+G+bT8u1HSXNZynaAYuXdKshTLEn3A/JPYjungciU94cOJ9yhwm9lJwlw
        PCzcudLEvuFlIboLcjrXlopLYq02lTgLIpRcs2uIGGEbl7eQ1A7ibfRG1m2mqgpyEKBBUj4Yyf9oM
        pLgxjYreeUqiU0P47YeK9jFuX1eJOKNirSmorpdT+Fr5qL45ES28JNymp7pGxijfgdY3aJdJAI1Aj
        SzYiF+Gtv19eBDjY8t5bpxvnRHqkVfLGIWBlnD02gfmrqvv0BPkklRJBot3mbDpS9tcnyFfPA+nvV
        Mja0qZ1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwoYY-00Aic6-Ej; Mon, 13 Dec 2021 16:52:06 +0000
Date:   Mon, 13 Dec 2021 08:52:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH (resend)] loop: make autoclear operation asynchronous
Message-ID: <Ybd6NsqyLy0Bbz/z@infradead.org>
References: <1ed7df28-ebd6-71fb-70e5-1c2972e05ddb@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed7df28-ebd6-71fb-70e5-1c2972e05ddb@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
