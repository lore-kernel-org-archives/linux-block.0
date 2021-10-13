Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C9FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2830660F23
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJMEyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhJMEyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:54:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74DFC061570;
        Tue, 12 Oct 2021 21:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=nufIwPFlg2x6aEpOlc/MhpMTlr
        GkpG6ylVDADUsgI0R/94VVW4cVSV4bcUpWO3iZ45nP/Jh9gZbUllY8xwbnhXD2aOM8K231w6/ghwY
        FRjDgqWxmdBnvd4+NVewCjy/OiPz2iZWs7ARxv07abKw113SDeNuI+ZayD4RDKo1z4IGaQmh97jFo
        P37dgd1Gfry8BIpQr1yedIIH9sjIMaQRclPI+vh7QEomP6p24Xk/vHcIR762Fw7M47hhU50Io43Wo
        Em3B5zzX/U7B2mn7QSTljTBwOxGaeOGANK3PdVlAS8HuNBxknd3KLgyG8ydFDdEeLmIgKWciDZ5YX
        TCVT22+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maWDR-0075Ki-Rl; Wed, 13 Oct 2021 04:50:34 +0000
Date:   Wed, 13 Oct 2021 05:50:09 +0100
From:   "hch@infradead.org" <hch@infradead.org>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH RESEND v2] block-map: added error handling for
 bio_copy_kern()
Message-ID: <YWZlgTF65S3Le50a@infradead.org>
References: <CGME20211013014256epcms2p5485187a369a9f8c74c2b3ab925df88fb@epcms2p4>
 <20211013021602epcms2p408b3eb79d4861bf8c340542ac92c23ec@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013021602epcms2p408b3eb79d4861bf8c340542ac92c23ec@epcms2p4>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
