Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD6C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D5D60F46
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhHPQMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:12:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF2C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZsWA0r06G7OeDyZcsrcZCuD02cJEzD/J089geosJ9vs=; b=WoACpXrk/AedqTI8YC6SYIG3aA
        cHwS1cUBiwH9wrY/OCZpV5inqF4qyIg5n5mSOMMV2DI/wNgckyBkVVlrPfMgn2OeSobiNyvuig4/x
        X+JJU96TotqkTD5E49SGud7TAh8+H48cFFhbpgKs1G0SAfsS83IVV8uMmi4j6/AxzcQ8nAaFP2uV3
        EvUv+Q8lO2tA3gWB2gd/x5CW9E2GlPIaQZE0GIFK2k6nLYMq8BcXsk1gmOwWk4IIdO4tsw7nm3OoQ
        e86oqGHZCU4GQdP7QgqcdkmVI1U/8LpBAJpRzRoS8ezNUmjfPbZ7ifhWadYTkV6j3M9CsP6K2zs+e
        yfaE7Prw==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFfCi-001Z7k-9p; Mon, 16 Aug 2021 16:11:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org
Subject: paride initialization cleanup
Date:   Mon, 16 Aug 2021 18:11:06 +0200
Message-Id: <20210816161110.909076-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the paride drivers currently have a major Linux 1.x-style mess for
initializing the gendisks.  This series refactors them to be modular
and self-contained in preparation of error handling for add_disk.

Diffstat:
 pcd.c |  298 +++++++++++++++++++++++++++++-------------------------------------
 pd.c  |  142 +++++++++++++++----------------
 pf.c  |  223 +++++++++++++++++++++----------------------------
 3 files changed, 303 insertions(+), 360 deletions(-)
