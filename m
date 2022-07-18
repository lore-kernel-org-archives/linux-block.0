Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E5C43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 06:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiGRGi2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiGRGi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 02:38:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D57165A0
        for <linux-block@vger.kernel.org>; Sun, 17 Jul 2022 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Golxju1qU1y8zH7AXtRwb2/jwuNXfYEsRIt2+fTSzx4=; b=BaXwaq6FdqXsx7bBgBUPhieF/w
        /wrV1a/ANLyxJALLr5k0FL9oO9bP+NuYX1VDtc6Md4aik5pGrA8oiceABtIrShgWTt2/mtQFXeSkI
        CFilrUEuliSZkFPZEehT9ZJTp5veu9wApTCSPc2+fsPLtlis5L8UUrpiv8q6wv1eONJucrA6N41eR
        xtUefMENrl27wxomUR9wBR9RkmOuibGkNSf8a3AKqwNLUbZzFy1d5APyNpKhrpKd+EGobBl8mI+67
        lK12NP++fZPwja6fnqKkEdncS48zwbohfP/6/0wtU4HfnItLSEf1ZlC0GZQ9/X+7yecxPzWUfwsgl
        yeJlEtIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDKOf-00BFke-1d; Mon, 18 Jul 2022 06:38:25 +0000
Date:   Sun, 17 Jul 2022 23:38:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: use of the system work queue in ublk
Message-ID: <YtT/4Y387f/6pxZH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

it seems like ublk uses schedule_work to stop the device, which
includes a del_gendisk.  I'm a little fearful this will gets us into
lockdep chains of death once syzbot or Tetsu notice it.

That being said, I don't reall understand the design of
ublk_daemon_monitor_work, which is only used to kick off other
work to start with.
