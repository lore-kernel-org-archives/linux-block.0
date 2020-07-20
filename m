Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D0C433EA
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25022080D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVPaXARC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgGTGM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgGTGMz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 02:12:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B32C0619D2
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2020 23:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Mn84wykHGeHHhG0DrHeU5rYBpLOYWAT9az5ULq20f6c=; b=iVPaXARCyREJ6JL1YBp8YJAK8a
        ssMmqJQXauTtoRms9j81NKVfvOQmFS9EdQeXwrNoHHUlkTVeo5qBc6AapgMP0rojBdlDkZ19kGkTH
        Mo2QmGfOGtJ4ywNxPPnN52BTlgn5IGXgjUlNqVF+LsyMh763VSJwJBywpsGqAcG+JN+uKX0Cm4CRg
        UsABP3pj99lWv7LBEJKbJVk4Bu9EGQzXoYiLuvKWy9bqbfuBrp6yqaEDiFvztsW94RJMnb5UcAUME
        yE7xHYg2i486sdAeW8bMJDLvaytiK+Rczu3tWwdUHCILLO8SLPdck5YGJwcTwlZYC9YiFxfTbYEc8
        dt5Hvuxw==;
Received: from [2001:4bb8:105:4a81:b96b:120c:c0c5:74fd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxP2h-0006fq-T9; Mon, 20 Jul 2020 06:12:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: a fix and two cleanups around blk_stack_limits
Date:   Mon, 20 Jul 2020 08:12:48 +0200
Message-Id: <20200720061251.652457-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series ensures that the zoned device limitations are properly
inherited in blk_stack_limits, and then cleanups up two rather
pointless wrappers around it.
