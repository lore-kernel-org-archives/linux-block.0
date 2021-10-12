Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA241C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 06:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35F860EDF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 06:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhJLG1x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJLG1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 02:27:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949FC061570;
        Mon, 11 Oct 2021 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B1aPVJuxZP/j2NM7qjbxfmvVLLNT6DBv5a9xDWQIXWk=; b=j6rCaX0Gu1sym2HCXotded7fAx
        2ysZOuz3e9z6KFbD18nX6XHMULIgkcrUi/+SyWJn+P9YvmDy22zbUl3EXXY48sN86YE71X+8F0zl/
        qUoBotRMGo6ovSg9kmbYNt2TL4KMrh09nrxOY6fMG5sagfppcpG2Zr0tf6Xnyj/fD8tcm/PeF0p8w
        QZDI9OJQsDaqla7RGF7c8A+PlovNIHPlv67TIEvYjQD/E8psGtPKSZg/9LC/G/jYnLindpimWxCiC
        9U2O3qOjQdahPCjKA/txA7K4x2mBVOq3IyQ5V4MPCzbxVPS9dle6wPXasIfy8nkSfEa9wSP+lY61O
        MS7CwnYQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maBDH-006GOS-JR; Tue, 12 Oct 2021 06:25:03 +0000
Date:   Tue, 12 Oct 2021 07:24:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block-map: added error handling for bio_copy_kern()
Message-ID: <YWUqI/SkoJxYAeco@infradead.org>
References: <CGME20210928063420epcms2p8f0cad25e1b820169755962ff4555d3ac@epcms2p1>
 <20210928063919epcms2p12ef0dfc94e6756f7bf85945522720e8f@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928063919epcms2p12ef0dfc94e6756f7bf85945522720e8f@epcms2p1>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +       int do_copy = 0;

Please make this a bool.  Otherwise the patch looks good.
