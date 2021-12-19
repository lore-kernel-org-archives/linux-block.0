Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74058C433F5
	for <linux-block@archiver.kernel.org>; Sun, 19 Dec 2021 21:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhLSVfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Dec 2021 16:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhLSVfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Dec 2021 16:35:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D5C061574
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 13:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WjpH3NsAsJoONU1iNvMGL7maY+qxBqQHT9U+dBzedxA=; b=gkMUVCsRUFuNKkluJZA4usrQBL
        CRUqG83/pMzTlFPmdxEtB7PTf1MaeDgwfmrj2dg499HkizLBYwC+/ujp5Qmv8KbyBGAqRxao+qXWo
        EXOrSv8ePU8vNjam04tCzzM7C15uo5np3u/0V+vqHf0ttC2PJQqRoRjiX/NqFWbLiUxWokHr50lBu
        r/7Dysnxf34K5kFSe5YZcjEZJLDgW9U0Rm2JIAsHkjf9efVqbH3Bm1QXOhazcS2BN8vFLNr5+PFLW
        03Mz86EpzfJzjGpwnrHg25L2KDsZiPtFu/Vzv0paLVpUbUa/MKHGotCyM2Q18osVxcL9DwA782XcL
        XaCsCXNA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz3qF-00H61h-2h; Sun, 19 Dec 2021 21:35:39 +0000
Date:   Sun, 19 Dec 2021 13:35:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH (resend)] brd: remove brd_devices_mutex mutex
Message-ID: <Yb+lq232ndMCt7z1@bombadil.infradead.org>
References: <01fb7a16-fb97-b0e4-1c1f-aa42e7f68766@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fb7a16-fb97-b0e4-1c1f-aa42e7f68766@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 17, 2021 at 08:03:48PM +0900, Tetsuo Handa wrote:
> If brd_alloc() from brd_probe() is called before brd_alloc() from
> brd_init() is called, module loading will fail with -EEXIST error.
> To close this race, call __register_blkdev() just before leaving
> brd_init().
> 
> Then, we can remove brd_devices_mutex mutex, for brd_device list
> will no longer be accessed concurrently.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
