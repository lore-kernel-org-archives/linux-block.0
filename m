Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE083C10F14
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC221208E3
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 10:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZuYot+Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfDHKrF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:47:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDHKrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 06:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o59jJoQ88snmyCDs6HbbCUuwQWN8lrDcvrVpBvcusVM=; b=ZuYot+Muwj8Y6yBunI3+vrb58
        smBzxctPouz0lLsFwosx7qOQ4qqK2lA6qO1Qndp6fePIVPVrIjPrm4Z8rlERC0QsLLU5LB1WkakdR
        hcaW5dzridG1F0HrGF38lrRlGnV7dtenNZnu5DoxhEP0ltb8IWay3wskzCNcJFitOX602vrT5P4Xs
        owxU5iQXGSvjvugIHUn03rp/5DSQm4WFd6MVMrmZGnkWrxgXEfZU6YrrgVJUJwlRULblIfDFFGZPC
        pczCvc1Ks1vMujOCqDi0JcKKKnkJ9+D0M5eN8sDj4cchbCwww1xaRb87aPmI/KZVJ2V7+hz9t3HED
        5Cv3g7A9w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDRnq-0000E8-Ln; Mon, 08 Apr 2019 10:47:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: avoid calling nth_page in the block I/O path
Date:   Mon,  8 Apr 2019 12:46:36 +0200
Message-Id: <20190408104641.4905-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

you complained about the overhead of calling nth_page in the multipage
bio_vec enabled I/O path a while ago.  While I can't really reproduce
the numbers on my (slower) hardware we could avoid the nth_page calls
pretty easily with a few tweaks.  Can you take a look at this series?
