Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE33C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 17:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiITRVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITRVt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 13:21:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2FD5F222
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 10:21:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7383568AFE; Tue, 20 Sep 2022 19:21:46 +0200 (CEST)
Date:   Tue, 20 Sep 2022 19:21:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: rnbd cleanups v2
Message-ID: <20220920172146.GA24795@lst.de>
References: <20220909131509.3263924-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909131509.3263924-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Can you pick these up?
