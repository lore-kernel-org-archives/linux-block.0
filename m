Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66FC433EF
	for <linux-block@archiver.kernel.org>; Tue, 10 May 2022 03:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiEJDVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiEJDVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 23:21:30 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0249915814;
        Mon,  9 May 2022 20:17:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 24A3HNto032097;
        Tue, 10 May 2022 05:17:23 +0200
Date:   Tue, 10 May 2022 05:17:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Minh Yuan <yuanmingbuaa@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH 1/3] floppy: use a statically allocated error counter
Message-ID: <20220510031723.GB31834@1wt.eu>
References: <20220508093709.24548-1-w@1wt.eu>
 <20220509061430.GA17155@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509061430.GA17155@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 09, 2022 at 08:14:30AM +0200, Christoph Hellwig wrote:
> The whole series looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you Christoph!
Willy
